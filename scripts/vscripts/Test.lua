function camouflage( keys )
	local caster = keys.caster
	local ability = keys.ability
	local casterLocation = caster:GetAbsOrigin()
	local radius = ability:GetLevelSpecialValueFor("radius", (ability:GetLevel() - 1))
	local grace_time = keys.ability:GetLevelSpecialValueFor( "grace_time", keys.ability:GetLevel() - 1 )
	local mana_cost_interval = ability:GetLevelSpecialValueFor("mana_cost_interval", ability:GetLevel() - 1)
	
	local mana_per_sec = ability:GetLevelSpecialValueFor("mana_cost_per_second", ability:GetLevel() - 1)
	 local units =  FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, radius,
			DOTA_UNIT_TARGET_TEAM_NONE,   DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_MECHANICAL + DOTA_UNIT_TARGET_BUILDING,
        DOTA_UNIT_TARGET_FLAG_NONE, 0, 0, false )

	 
   camouflage_take_mana({caster=caster,
                        ability=ability,
                        mana_per_sec=mana_per_sec,
                        mana_cost_interval=mana_cost_interval})
						

	if #Units>0 then
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_invisible", {})
	else
if caster:HasModifier("modifier_invisible") then
    Timers:CreateTimer( grace_time, function()
        caster:RemoveModifierByName("modifier_invisible")               
    end)
end
function camouflage_take_mana( params )
    if params.ability:GetToggleState() == false then
        return
    end
    params.caster:ReduceMana(params.mana_per_sec)
    if params.caster:GetMana() < params.mana_per_sec then
        params.ability:ToggleAbility()
    end
    
    Timers:CreateTimer(params.mana_cost_interval,
        function()
            camouflage_take_mana(params)
        end
    )
end

function camouflage_stop( keys )
    local caster = keys.caster
end

	end
end
