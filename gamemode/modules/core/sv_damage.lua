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
