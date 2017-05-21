PARTY.parties = PARTY.parties or {}
PARTY.index = 1 // Increment this every time a new party is created

local meta = FindMetaTable("Player")

util.AddNetworkString("createParty")
util.AddNetworkString("disbandonParty")
util.AddNetworkString("updateParty")
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

net.Receive("inviteParty", function(len, ply)
    local member = net.ReadEntity()

    ply:inviteParty(member)
end)

function PARTY:updateAllMembers(index)
    for k,v in pairs(self.parties[party].members) do
        v:updateParty()
    end
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
    if IsValid(member) and self.party and member.party then
        if PARTY.parties[member.party].leader == self then
            if disconnected then
                meta:disbandonParty(disconnected)
                return
            end

            for k,v in pairs(PARTY.parties[member.party]) do
                if v == member then
                    PARTY.parties[member.party].members[k] = nil

                    self:notify("You have kicked " ..member:getName() .." from your party.", NOTIFY_GENERIC)
                    member:notify("You have been kicked from your party.", NOTIFY_GENERIC)

                    member.party = nil
                    member:updateParty()
                end
            end
        else
            self:notify("You are not allowed to kick other players.", NOTIFY_ERROR)
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
            // Invite player
            self.partyInviteTime = CurTime() + PARTY.inviteCooldown
            member.invitedParty = self.party

            self:notify("You have invited " ..member:getName() .." to join your party.", NOTIFY_GENERIC)
            member:notify("You have been invited to join " ..self:getName() .."'s party. Type /accept to join.", NOTIFY_GENERIC, 7)
        else
            self:notify("You must wait " ..(CurTime() - self.partyInviteTime) .." more seconds to invite again.", NOTIFY_ERROR)
        end
    end
end

function meta:isPartyLeader()
    return IsValid(self) and self.party and (PARTY.parties[self.party].leader == self)
end

hook.Add("PlayerSay", "joinParty", function(ply, text)
    if string.sub(text, 1, #PARTY.acceptText) then
        ply:joinParty()
    end
end)

hook.Add("PlayerDisconnected", "removeFromParty", function(ply)
    ply:kickParty(ply, true)
end)
