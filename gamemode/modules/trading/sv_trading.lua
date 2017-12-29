TRADING.index = TRADING.index or 1
TRADING.trades = TRADING.trades or {}

local meta = FindMetaTable("Player")

util.AddNetworkString("beginTrade")
util.AddNetworkString("closeTrade")
util.AddNetworkString("offerItem")
util.AddNetworkString("unofferItem")
util.AddNetworkString("offerCaps")
util.AddNetworkString("unofferCaps")
util.AddNetworkString("updateTrade")
util.AddNetworkString("updateStatusTrade")

net.Receive("closeTrade", function(len, ply)
    ply:closeTrade()
end)

net.Receive("offerItem", function(len, ply)
    local classid = net.ReadInt(16)
    local uniqueid = net.ReadInt(32)
    local quantity = net.ReadInt(16)

    ply:offerItem(classid, uniqueid, quantity)
end)

net.Receive("unofferItem", function(len, ply)
    local uniqueid = net.ReadInt(32)
    local quantity = net.ReadInt(16)

    ply:unofferItem(uniqueid, quantity)
end)

net.Receive("offerCaps", function(len, ply)
    local caps = net.ReadInt(32)

    ply:offerCaps(caps)
end)

net.Receive("unofferCaps", function(len, ply)
    local caps = net.ReadInt(32)

    ply:unofferCaps(caps)
end)

net.Receive("updateStatusTrade", function(len, ply)
    local status = net.ReadInt(8)

    ply:updateStatusTrade(status)
end)

function TRADING:beginTrade(playerA, playerB)
    local index = TRADING.index
    TRADING.index = TRADING.index + 1

    playerA.trade = index
    playerB.trade = index

    TRADING.trades[index] = {
        [playerA] = {
            lockedIn = false,
            accepted = false,
            offer = {
                caps = 0,
                items = {}
            }
        },
        [playerB] = {
            lockedIn = false,
            accepted = false,
            offer = {
                caps = 0,
                items = {}
            }
        }
    }

    net.Start("beginTrade")
        net.WriteTable(TRADING.trades[index])
    net.Send(playerA)
    net.Start("beginTrade")
        net.WriteTable(TRADING.trades[index])
    net.Send(playerB)
end

function TRADING:getTrade(id)
    return self.trades[id]
end

function TRADING:getOtherTrader(known)
    for k,v in pairs(self:getTrade(known.trade)) do
        if k != known then
            return k
        end
    end
end

function TRADING:getOfferItem(ply, uniqueid)
    for k,v in pairs(self:getTrade(ply.trade)[ply].offer.items) do
        if k == uniqueid then
            return v
        end
    end
end

function TRADING:resetStatus(trade)
    for k,v in pairs(self:getTrade(trade)) do
        v.accepted = false
        v.lockedIn = false
    end
end

function TRADING:updateTrade(id, updater)
    for k,v in pairs(self.trades[id]) do
        net.Start("updateTrade")
            net.WriteTable(TRADING:getTrade(id))
            if updater then
                net.WriteEntity(updater)
            end
        net.Send(k)
    end
end

// Close the trade with no message, usually done at the end of an accepted trade, or in event of trade failure
function TRADING:endTrade(id, message, messageType)
    for trader, v in pairs(self:getTrade(id)) do
        if IsValid(trader) then
            trader.trade = nil

            net.Start("closeTrade")
            net.Send(trader)

            if message then
                trader:notify(message, messageType)
            end
        end
    end

    TRADING.trades[id] = nil
end

function TRADING:failTrade(failer, message, otherMessage)
    local other = self:getOtherTrader(failer)

    TRADING:endTrade(failer.trade)

    if other then
        other:notify(otherMessage, NOTIFY_ERROR, 5)
    end
    failer:notify(message, NOTIFY_ERROR, 5)
end

function TRADING:completeTrade(id)
    local trade = self:getTrade(id)
    local transfer = {}
    local index = 1

    // Initial sweep checking if both players have the items and get total weight
    for trader, v in pairs(trade) do
        transfer[index] = {
            player = trader,
            caps = 0,
            weight = 0,
            items = {}
        }

        for uniqueid, item in pairs(v.offer.items) do
            local invItem = trader:getInventoryItem(uniqueid, item.classid)
            if invItem then
                if util.positive(item.quantity) then
                    if invItem.quantity < item.quantity then
                        TRADING:failTrade(trader, "You do not have enough of that item.", trader:Nick() .." is missing an item.")
                        return
                    end
                end
            else
                TRADING:failTrade(trader, "You do not have that item anymore.", trader:Nick() .." is missing an item.")
                return
            end

            if !trader:canAfford(v.offer.caps) then
                TRADING:failTrade(trader, "You cannot afford that many caps.", trader:Nick() .." cannot afford that many caps.")
                return
            end

            local quantity = item.quantity or 1
            transfer[index].weight = transfer[index].weight + (getItemWeight(item.classid) * quantity)
            table.insert(transfer[index].items, item)
        end

        transfer[index].caps = v.offer.caps

        // Store and Check PlayerB next iteration
        index = index + 1
    end

    // Final sweep for checking if players can hold final weight and transfering the items
    for k,v in pairs(transfer) do
        local ply = v.player
        local otherIndex
        if k == 1 then
            otherIndex = 2
        else
            otherIndex = 1
        end
        local otherPly = transfer[otherIndex].player

        // Verify that player has room
        local maxWeight = ply:getMaxInventory()
        local currentWeight = ply:getInventoryWeight()
        local outgoingWeight = v.weight
        local incomingWeight = transfer[otherIndex].weight

        currentWeight = currentWeight - outgoingWeight + incomingWeight
        if currentWeight > maxWeight then
            TRADING:failTrade(ply, "You do not have enough inventory space.", ply:Nick() .." does not have enough inventory space.")
            return
        end

        // Deduct YOUR items
        for k, item in pairs(v.items) do
            ply:depleteInventoryItem(classidToStringType(item.classid), item.uniqueid, item.quantity)
        end
        // Add THEIR items
        for k, item in pairs(transfer[otherIndex].items) do
            ply:pickUpItem(table.Copy(item), item.quantity)
        end

        // Deduct their caps, give to you
        local caps = transfer[otherIndex].caps
        if util.positive(caps) then
            otherPly:addCaps(-caps)
            ply:addCaps(caps)
        end
    end

    TRADING:endTrade(id, "Trade complete.", NOTIFY_GENERIC)
end

function meta:updateStatusTrade(status)
    if self.trade then
        local trade = TRADING:getTrade(self.trade)
        local other = TRADING:getOtherTrader(self)

        if status == 1 then
            trade[self].lockedIn = true
        elseif status == 2 then
            if trade[self].lockedIn then
                if trade[other].accepted then
                    // Complete the trade
                    TRADING:completeTrade(self.trade)

                    return
                else
                    trade[self].lockedIn = false
                    trade[self].accepted = true
                end
            else
                self:notify("You must lock in first.", NOTIFY_ERROR)
            end
        elseif status == 3 then
            self:notify("You must wait for the other player to lock in.", NOTIFY_ERROR)
        elseif status == 4 then
            trade[self].lockedIn = false
            trade[self].accepted = true
            trade[other].accepted = false
        else
            return
        end

        TRADING:updateTrade(self.trade)
    end
end

function meta:offerItem(classid, uniqueid, quantity)
    // Check that they are trading
    // Check that they have the item (take into account current offer)
    // Add item to the offer

    if self.trade then
        local itemType = classidToStringType(classid)
        local invItem = table.Copy(self.inventory[itemType][uniqueid])

        local offerItem = TRADING:getOfferItem(self, uniqueid)
        if offerItem then
            if !util.positive(offerItem.quantity) or (quantity > (invItem.quantity - offerItem.quantity)) then
                self:notify("You don't have enough of that item.", NOTIFY_ERROR)
                return
            end

            TRADING.trades[self.trade][self].offer.items[offerItem.uniqueid].quantity = offerItem.quantity + quantity
        else
            invItem.quantity = quantity
            TRADING.trades[self.trade][self].offer.items[uniqueid] = invItem

            TRADING:resetStatus(self.trade)
        end

        TRADING:updateTrade(self.trade, self)
    end
end

function meta:unofferItem(uniqueid, quantity)
    // Check that quantity is positive
    // Check that player is trading
    // Remove the quantity, completely remove if quantity is 0

    if quantity < 0 then
        self:notify("You cannot remove negative quantity.", NOTIFY_ERROR)
        return
    end

    if self.trade then
        local item = TRADING:getOfferItem(self, uniqueid)
        item.quantity = item.quantity or 0
        item.quantity = item.quantity - quantity

        if !util.positive(item.quantity) then
            TRADING.trades[self.trade][self].offer.items[uniqueid] = nil
        end

        TRADING:resetStatus(self.trade)
        TRADING:updateTrade(self.trade, self)
    end
end

function meta:offerCaps(caps)
    if self.trade then
        if !util.positive(caps) then
            self:notify("You cannot offer negative caps.", NOTIFY_ERROR)
            return
        end

        if !self:canAfford(caps) then
            self:notify("You cannot afford that much.", NOTIFY_ERROR)
            return
        end

        TRADING.trades[self.trade][self].offer.caps = TRADING.trades[self.trade][self].offer.caps + caps
        TRADING:updateTrade(self.trade, self)
    end
end

function meta:unofferCaps(caps)
    if self.trade then
        if !util.positive(caps) then
            self:notify("You cannot remove negative caps.", NOTIFY_ERROR)
            return
        end

        if caps > TRADING.trades[self.trade][self].offer.caps then
            self:notify("You cannot remove more caps than you offered.", NOTIFY_ERROR)
            return
        end

        TRADING.trades[self.trade][self].offer.caps = TRADING.trades[self.trade][self].offer.caps - caps
        TRADING:updateTrade(self.trade, self)
    end
end

function meta:closeTrade()
    if !self.trade then return end

    local other = TRADING:getOtherTrader(self)

    TRADING.trades[self.trade] = nil
    self.trade = nil

    if other then
        other.trade = nil

        net.Start("closeTrade")
        net.Send(other)

        other:notify(self:getName() .." has ended the trade.", NOTIFY_ERROR)
    end

    self:notify("You have ended the trade.", NOTIFY_GENERIC)
end

function meta:acceptTrade()
    local requestor = self.requestedTrade

    if IsValid(requestor) then
        if self.trade then
            self:notify("You are busy right now.", NOTIFY_ERROR)
        elseif requestor.trade then
            self:notify("That player is busy right now.", NOTIFY_ERROR)
        else
            if (self:GetPos():Distance(requestor:GetPos()) < TRADING.tradeDistance) then
                self.requestedTrade = nil
                TRADING:beginTrade(self, requestor)
            else
                self:notify("That player is too far away.", NOTIFY_ERROR)
            end
        end
    else
        self:notify("That player is no longer available to trade.", NOTIFY_ERROR)
    end
end

function meta:requestTrade()
    local trace = self:GetEyeTrace()
    local ent = trace.Entity

    if IsValid(ent) and ent:IsPlayer() then
        if (self:GetPos():Distance(trace.HitPos) < TRADING.tradeDistance) then
            if !(self.requestTradeTime and (self.requestTradeTime > CurTime())) then
                self.requestTradeTime = CurTime() + TRADING.requestCooldown
                ent.requestedTrade = self

                ent:notify(self:getName() .." has requested to trade with you. Type /accept", NOTIFY_GENERIC, 10)
                self:notify("You have sent a trade request to " ..ent:getName() ..".", NOTIFY_GENERIC)
            else
                self:notify("You must wait " ..math.floor(self.requestTradeTime - CurTime()) .." more seconds to request a trade again.", NOTIFY_ERROR)
            end
        else
            self:notify("You need to be closer to do that.", NOTIFY_ERROR)
        end
    end
end

hook.Add("PlayerSay", "requestTrade", function(ply, text)
    if string.sub(text, 1, #TRADING.requestText) == TRADING.requestText then
        ply:requestTrade()

        return ""
    end
end)

hook.Add("PlayerSay", "acceptTrade", function(ply, text)
    if string.sub(text, 1, #TRADING.acceptText) == TRADING.acceptText then
        ply:acceptTrade()

        return ""
    end
end)
