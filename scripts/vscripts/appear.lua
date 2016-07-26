function BlinkStrike( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1

	-- Ability variables
	local bonus_damage = ability:GetLevelSpecialValueFor("bonus_damage", ability_level)
	local victim_angle = target:GetAnglesAsVector()
	local victim_forward_vector = target:GetForwardVector()
	
	-- Angle and positioning variables
	local victim_angle_rad = victim_angle.y*math.pi/180
	local victim_position = target:GetAbsOrigin()
	local attacker_new = Vector(victim_position.x + 100 * math.cos(victim_angle_rad), victim_position.y + 100 * math.sin(victim_angle_rad), 0)
	
	
	-- Sets Riki behind the victim and facing it
	caster:SetAbsOrigin(attacker_new)
	FindClearSpaceForUnit(caster, attacker_new, true)
	caster:SetForwardVector(victim_forward_vector)
end
