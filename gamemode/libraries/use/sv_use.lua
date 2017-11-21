util.AddNetworkString("useUpdate")
util.AddNetworkString("useEnd")

function USE:begin(ent, ply, time)
    if ply.isUsing then return end

    ply.isUsing = true

    self:burnTime(ent, ply, 0, time)
end

function USE:cancel(ply)
    if IsValid(ply) then
        ply.isUsing = false

        net.Start("useEnd")
        net.Send(ply)
    end
end

function USE:burnTime(ent, ply, curTime, totalTime)
    if !IsValid(ent) and !IsValid(ply) then self:cancel(ply) return end

    local trace = ply:GetEyeTrace()
    if not IsValid(trace.Entity) or trace.Entity != ent or trace.HitPos:Distance(ply:GetShootPos()) > 100 then
        self:cancel(ply)
        return
    end

    local curTime = curTime + self.removeTime

    // Player has finished using
    if curTime >= totalTime then
        if ent.OnUseFinish then
            ent:OnUseFinish(ply)
        end

        self:cancel(ply)
        return
    end

    net.Start("useUpdate")
        net.WriteFloat(curTime)
        net.WriteFloat(totalTime)
    net.Send(ply)

    timer.Simple(self.removeTime, function()
        self:burnTime(ent, ply, curTime, totalTime)
    end)
end
