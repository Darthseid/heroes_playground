function chessmaster_force_staff( keys )
local caster = keys.caster
local target = keys.target
	local ability = keys.ability
	local victim_angle = target:GetAnglesAsVector()
	local victim_angle_rad = victim_angle.y*math.pi/180
	local victim_position = target:GetAbsOrigin()
	local victim_push_direction = Vector(victim_position.x - 100 * math.cos(victim_angle_rad), victim_position.y - 100 * math.sin(victim_angle_rad), 0)
	local forced = keys.distance * victim_push_direction
	local tree_radius = 100
	
	GridNav:DestroyTreesAroundPoint( victim_position, tree_radius, false )
	FindClearSpaceForUnit( target, victim_position, true )


	local knockbackModifierTable =
	{
		should_stun = 0,
		knockback_duration = keys.duration,
		knockback_distance = forced
		knockback_height = keys.height,
	}
	keys.target:AddNewModifier( keys.caster, nil, "modifier_knockback", knockbackModifierTable )
end