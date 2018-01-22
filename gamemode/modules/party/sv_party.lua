PARTY.parties = PARTY.parties or {}
PARTY.index = PARTY.index or 1 // Increment this every time a new party is created

local meta = FindMetaTable("Player")

util.AddNetworkString("createParty")
util.AddNetworkString("disbandonParty")
util.AddNetworkString("updateParty")
util.AddNetworkString("settingsParty")
util.AddNetworkString("kickParty")
util.AddNetworkString("inviteParty")

net.Receive("createParty", function(len, ply)
    ply:createParty()
end)

net.Receive("disbandonParty", function(len, ply)
  ply:disbandonParty()
end)

net.Receive("kickParty", function(len, ply)
    local member = net.ReadEntity()

    ply:kickParty(member)
end)

net.Receive("settingsParty", function(len, ply)
    local settings = net.ReadTable()

    ply:settingsParty(settings)
end)

net.Receive("inviteParty", function(len, ply)
    local member = net.ReadEntity()

    ply:inviteParty(member)
end)

function PARTY:updateAllMembers(index)
    for k,v in pairs(self.parties[index].members) do
        v:updateParty()
    end

    self.parties[index].leader:updateParty()
end

function meta:updateParty()
    local hasParty = tobool(self.party)

    if hasParty then
      net.Start("updateParty")
          net.WriteBool(hasParty)
          net.WriteTable(PARTY.parties[self.party])
      net.Send(self)
    else
      net.Start("updateParty")
          net.WriteBool(hasParty)
      net.Send(self)
    end
end

function meta:hasXpShareParty()
    return self.party and PARTY.parties[self.party].settings.xpShare
end

function meta:shareXpParty(exp)
    local members = {}

    for k,v in pairs(ents.FindInSphere(self:GetPos(), PARTY.shareRadius)) do
        if IsValid(v) and v:IsPlayer() then
            if v == PARTY.parties[self.party].leader or table.HasValue(PARTY.parties[self.party].members, v) then
                table.insert(members, v)
            end
        end
    end

    local exp = exp / #members

    for k,v in pairs(members) do
        v:addExp(exp)

        // Experience is still 'shared' if it's just 1 person, it's just shared in full
        if #members > 1 then
            v:notify("Some of your experience was shared with party members.", NOTIFY_GENERIC)
        end
    end
end

function meta:createParty()
    if self.party then
        self:notify("You must leave your current party before doing that.", NOTIFY_ERROR)
    else
        // Create party
        PARTY.parties[PARTY.index] = {
            leader = self,
            members = {},
            settings = {
                xpShare = true
            }
        }

        self.party = PARTY.index
        PARTY.index = PARTY.index + 1

        self:updateParty()
        self:notify("You have created a party.", NOTIFY_GENERIC)
    end
end

function meta:disbandonParty(disconnected)
    if self:isPartyLeader() then
        local index = self.party

        for k,v in pairs(PARTY.parties[self.party].members) do
            if disconnected then
                v:notify("Your party leader has disconnected.", NOTIFY_GENERIC)
            else
                v:notify("Your leader has disbandoned the party.", NOTIFY_GENERIC)
            end

            v.party = nil
            v:updateParty()
        end

        if !disconnected then
          self.party = nil
          self:updateParty()
          self:notify("You have disbandoned your party.", NOTIFY_GENERIC)
        end

        PARTY.parties[index] = nil
    end
end

function meta:kickParty(member, disconnected)
    if IsValid(member) and self:isPartyLeader() and member.party then
        if disconnected then
            self:disbandonParty(disconnected)
            return
        end

        for k,v in pairs(PARTY.parties[member.party].members) do
            if v == member then
                PARTY.parties[member.party].members[k] = nil

                self:notify("You have kicked " ..member:getName() .." from your party.", NOTIFY_GENERIC)
                member:notify("You have been kicked from your party.", NOTIFY_GENERIC)

                local index = member.party

                member.party = nil
                member:updateParty()

                PARTY:updateAllMembers(index)
            end
        end
    else
        self:notify("That member is no longer available.", NOTIFY_ERROR)
    end
end

function meta:joinParty()
    if self.party then
        self:notify("You must leave your current party before joining another one.", NOTIFY_ERROR)
    elseif self.invitedParty then
        if PARTY.parties[self.invitedParty] then
            self.party = self.invitedParty
            table.insert(PARTY.parties[self.invitedParty].members, self)
            PARTY:updateAllMembers(self.invitedParty)
        else
            self:notify("That party no longer exists.", NOTIFY_ERROR)
        end
    else
        self:notify("You have not been invited to any party.", NOTIFY_ERROR)
    end
end

function meta:inviteParty(member)
    if IsValid(member) and self:isPartyLeader() then
        if member.party then
            self:notify("That player is already in a party.", NOTIFY_GENERIC)
        elseif !(self.partyInviteTime and self.partyInviteTime > CurTime()) then
            if member:Team() == self:Team() then
                // Invite player
                self.partyInviteTime = CurTime() + PARTY.inviteCooldown
                member.invitedParty = self.party

                self:notify("You have invited " ..member:getName() .." to join your party.", NOTIFY_GENERIC)
                member:notify("You have been invited to join " ..self:getName() .."'s party. Type " ..PARTY.acceptText .." to join.", NOTIFY_GENERIC, 7)
            else
                self:notify("You cannot invite players in another faction.", NOTIFY_ERROR)
            end
        else
            self:notify("You must wait " ..math.floor(self.partyInviteTime - CurTime()) .." more seconds to invite again.", NOTIFY_ERROR)
        end
    end
end

function meta:settingsParty(settings)
    if self:isPartyLeader() then
        PARTY.parties[self.party].settings = settings
    end

    self:notify("You have updated the party's settings.", NOTIFY_GENERIC)

    PARTY:updateAllMembers(self.party)
end

function meta:isPartyLeader()
    return IsValid(self) and self.party and (PARTY.parties[self.party].leader == self)
end

hook.Add("PlayerSay", "joinParty", function(ply, text)
    if string.sub(text, 1, #PARTY.acceptText) == PARTY.acceptText then
        ply:joinParty()

        return ""
    end
end)

hook.Add("PlayerDisconnected", "removeFromParty", function(ply)
    ply:kickParty(ply, true)
end)
