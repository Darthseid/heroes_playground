It's important to note something about angles in Dota:
Pretend the upcoming O is a unit, and -----> is the angle they are facing.
O---->
This is a 0 degree rotation as far as Dota is concerned.
^
|
|
O
This is a 90 degree rotation.
<-----O
This is a 180 degree rotation.
O
|
|
V
This is a -90 degree rotation.
Therefore, when dealing with angles in Dota, I prefer to just add 180 to whatever degree value you're working with; that way, you go from dealing with positive and negative angles to just angles that increment clockwise from 3 o'clock.
]]

function bristleback_takedamage(params)
	-- Create the threshold counter on the unit if it doesn't exist.
	if params.unit.quill_threshold_counter == nil then
		params.unit.quill_threshold_counter = 0.0
	end

	local ability = params.ability
	local back_reduction_percentage = ability:GetLevelSpecialValueFor("back_damage_reduction", ability:GetLevel() - 1) / 100
	local side_reduction_percentage = ability:GetLevelSpecialValueFor("side_damage_reduction", ability:GetLevel() - 1) / 100

	-- The y value of the angles vector contains the angle we actually want: where units are directionally facing in the world.
	local victim_angle = params.unit:GetAnglesAsVector().y
	local origin_difference = params.unit:GetAbsOrigin() - params.attacker:GetAbsOrigin()
	-- Get the radian of the origin difference between the attacker and Bristleback. We use this to figure out at what angle the attacker is at relative to Bristleback.
	local origin_difference_radian = math.atan2(origin_difference.y, origin_difference.x)
	-- Convert the radian to degrees.
	origin_difference_radian = origin_difference_radian * 180
	local attacker_angle = origin_difference_radian / math.pi
	-- See the opening block comment for why I do this. Basically it's to turn negative angles into positive ones and make the math simpler.
	attacker_angle = attacker_angle + 180.0
	-- Finally, get the angle at which Bristleback is facing the attacker.
	local result_angle = attacker_angle + victim_angle
	result_angle = math.abs(result_angle)

	-- Check for the side angle first. If the attack doesn't pass this check, we don't have to do back angle calculations.
	if result_angle >= (180 - (ability:GetSpecialValueFor("side_angle") / 2)) and result_angle <= (180 + (ability:GetSpecialValueFor("side_angle") / 2)) then 
		-- Check for back angle. If this check doesn't pass, then do side angle "damage reduction".
		if result_angle >= (180 - (ability:GetSpecialValueFor("back_angle") / 2)) and result_angle <= (180 + (ability:GetSpecialValueFor("back_angle") / 2)) then 
			-- Check if the reduced damage is lethal
			if((params.unit:GetHealth() - (params.Damage * (1 - back_reduction_percentage))) >= 1) then
				-- This is the actual "damage reduction".
				params.unit:SetHealth((params.Damage * back_reduction_percentage) + params.unit:GetHealth())
				-- Play the sound on Bristleback.
				EmitSoundOn(params.sound, params.unit)
				-- Create the back particle effect.
				local back_damage_particle = ParticleManager:CreateParticle(params.back_particle, PATTACH_ABSORIGIN_FOLLOW, params.unit) 
				-- Set Control Point 1 for the back damage particle; this controls where it's positioned in the world. In this case, it should be positioned on Bristleback.
				ParticleManager:SetParticleControlEnt(back_damage_particle, 1, params.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", params.unit:GetAbsOrigin(), true) 
				-- Increase the Quill Spray damage counter based on how much damage was done.
				params.unit.quill_threshold_counter = params.unit.quill_threshold_counter + (params.Damage)
			end
		else
			-- Check if the reduced damage is lethal
			if((params.unit:GetHealth() - (params.Damage * (1 - side_reduction_percentage))) >= 1) then
				-- This is the actual "damage reduction".
				params.unit:SetHealth((params.Damage * side_reduction_percentage) + params.unit:GetHealth())
				-- Play the sound on Bristleback.
				EmitSoundOn(params.sound, params.unit)
				-- Create the side particle effect.
				local side_damage_particle = ParticleManager:CreateParticle(params.side_particle, PATTACH_ABSORIGIN_FOLLOW, params.unit) 
				-- Set Control Point 1 for the side damage particle; same stuff as the back damage particle.
				ParticleManager:SetParticleControlEnt(side_damage_particle, 1, params.unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", params.unit:GetAbsOrigin(), true) 
				ParticleManager:SetParticleControlEnt(side_damage_particle, 2, params.unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0, result_angle, 0), true)
				-- Increase the Quill Spray damage counter based on how much damage was done.
				params.unit.quill_threshold_counter = params.unit.quill_threshold_counter + (params.Damage)
			end
		end
	end
	
	function ChainFrost( event )

	-- The chain frost is cast from the latest hit target to the first nearby enemy that isn't the same target
	local caster = event.caster
	local unit = event.target
	local targets = event.target_entities
	local ability = event.ability

	local jumps = ability:GetLevelSpecialValueFor( "jumps", ability:GetLevel() - 1 )
	local jump_range = ability:GetLevelSpecialValueFor( "jump_range", ability:GetLevel() - 1 )
	local jump_interval = ability:GetLevelSpecialValueFor( "jump_interval", ability:GetLevel() - 1 )

	local projectile_speed = ability:GetLevelSpecialValueFor( "projectile_speed", ability:GetLevel() - 1 )
	local vision_radius = ability:GetLevelSpecialValueFor( "vision_radius", ability:GetLevel() - 1 )

	local particle_name = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf"

	-- Initialize the chain counter, on 1 because the first cast
	if not ability.jump_counter then
		ability.jump_counter = 1
	end

	-- If there's still bounces to expend, find a new target
	if ability.jump_counter <= jumps then

		-- Emit the sound, Creep or Hero depending on the type of the enemy hit
		if unit:IsRealHero() then
			unit:EmitSound("Hero_Lich.ChainFrostImpact.Hero")
		else
			unit:EmitSound("Hero_Lich.ChainFrostImpact.Creep")
		end

		-- Go through the target_enties table, checking for the first one that isn't the same as the target
		local target_to_jump = nil
		for _,target in pairs(targets) do
			if target ~= unit and not target_to_jump then
				target_to_jump = target
			end
		end

		if target_to_jump then

			print("Bounce number "..ability.jump_counter)
			-- Create the next projectile
			local info = {
				Target = target_to_jump,
				Source = unit,
				Ability = ability,
				EffectName = particle_name,
				bDodgeable = false,
				bProvidesVision = true,
				iMoveSpeed = projectile_speed,
		        iVisionRadius = vision_radius,
		        iVisionTeamNumber = caster:GetTeamNumber(), -- Vision still belongs to the one that casted the ability
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION
			}
			ProjectileManager:CreateTrackingProjectile( info )

			-- Add one to the jump counter for this bounce
			ability.jump_counter = ability.jump_counter + 1
		else
			print("Can't find a target, End Chain")
			ability.jump_counter = nil
		end	
	else
		print("No more bounces left, End Chain")
		ability.jump_counter = nil
	end
	local damage = params.unit.quill_threshold_counter

	local damage_table = {}
	damage_table.attacker = caster
	damage_table.victim = target
	damage_table.damage_type = ability:GetAbilityDamageType()
	damage_table.ability = ability
	damage_table.damage = damage

	ApplyDamage(damage_table)
	end
end
