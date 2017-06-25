util.AddNetworkString("damagePopup")

local meta = FindMetaTable("Player")

function meta:headBob()
    if util.roll(1, 3) then
        self:ViewPunch(Angle(math.random(10, 70), math.random(-5, -5), math.random(-170, 170)))
    end
end

function meta:bleedAttack(ent, damage)
    if util.roll(1, 3) and !ent.bleedTime then
        ent.bleedTime = 5
        ent.bleedDamage = math.floor(damage / 5)
        ent.bleedAttacker = self

        timer.Simple(1, function()
            if IsValid(ent) then
                ent:bleed()
            end
        end)
    end
end

function meta:bleed()
    if IsValid(self) and self:Health() > 0 then
        self:TakeDamage(self.bleedDamage)
        self:EmitSound("player/pl_pain7.wav")

        self.bleedTime = self.bleedTime - 1

        if self.bleedTime > 0 then
            timer.Simple(1, function()
                self:bleed()
            end)
        else
            self.bleedTime = nil
        end
    end
end

function meta:sendDmg(ent, dmg, dmgType, dmgInfo, crit)
    local pos = nil
    if dmgInfo:IsBulletDamage() then
        pos = dmgInfo:GetDamagePosition()
    elseif (dmgType == DMG_CLUB or dmgType == DMG_SLASH) then
        pos = util.TraceHull({
            start  = self:GetShootPos(),
            endpos = self:GetShootPos() + (self:GetAimVector() * 100),
            filter = self,
            mins   = Vector(-10,-10,-10),
            maxs   = Vector( 10, 10, 10),
            mask   = MASK_SHOT_HULL,
        }).HitPos
    end

    if pos == nil then
        pos = ent:LocalToWorld(ent:OBBCenter())
    end

    local force = nil
    if dmgInfo:IsExplosionDamage() then
        force = dmgInfo:GetDamageForce() / 4000
    else
        force = -dmgInfo:GetDamageForce() / 1000
    end
    force.x = math.Clamp(force.x, -1, 1)
    force.y = math.Clamp(force.y, -1, 1)
    force.z = math.Clamp(force.z, -1, 1)


    net.Start("damagePopup")
        net.WriteEntity(ent)
        net.WriteInt(dmg, 16)
        net.WriteVector(pos)
        net.WriteVector(force)
        net.WriteBool(crit)
    net.Send(self)
end
