modifier_sniper_r = class({})

function modifier_sniper_r:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL
    }
    return funcs
end

function modifier_sniper_r:CheckState()
    local state = {
    }

    if IsServer() then
        local hero = self:GetParent().hero
        local invisible = true

        for _, target in pairs(Spells:GetValidTargets()) do
            local distance = (target:GetPos() - hero:GetPos()):Length2D()

            if target ~= hero and distance <= 400 then						
               
                break
            end
        end

        state[MODIFIER_STATE_INVISIBLE] = invisible

        if invisible then
            self:SetStackCount(1)
        else
            self:SetStackCount(0)
        end
    end

    return state
end

function camouflage_take_mana( params )
    if params.ability:GetToggleState() == false then
        return
    end
    if params.caster:GetMana() = 0 then
        params.ability:ToggleAbility()
    end
end

function modifier_sniper_r:GetModifierInvisibilityLevel(params)
    return self:GetStackCount()
end

function modifier_sniper_r:GetEffectName()
    return "particles/sniper_r/sniper_r.vpcf"
end

function modifier_sniper_r:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function camouflage_break( keys )
local delay = keys.ability:GetLevelSpecialValueFor( "fade_time", keys.ability:GetLevel() - 1 )

Timers:CreateTimer(fade_time, function()
ability:ApplyDataDrivenModifier(caster, caster, "modifier_camouflage_datadriven", {})              
    end)
end
