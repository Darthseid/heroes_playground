function Splash( keys )
	-- Variables
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local radius_small = ability:GetLevelSpecialValueFor("splash_radius", 0)
	local target_exists = false
	local splash_damage_small = ability:GetLevelSpecialValueFor("splash_damage_percent", 0) / 100
	
	-- Finding the units for each radius
	local splash_radius_small = FindUnitsInRadius(caster:GetTeam(), target:GetAbsOrigin() , nil, radius_small , DOTA_UNIT_TARGET_TEAM_ENEMY	, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)  
	-- Initializing the damage table
	local damage_table = {}
	damage_table.attacker = caster
	damage_table.damage_type = DAMAGE_TYPE_PHYSICAL
	damage_table.damage = caster:GetAttackDamage() * splash_damage_small


	--loop for doing the splash damage while ignoring the original target
	for i,v in ipairs(splash_radius_small) do
		if v ~= target then 
			damage_table.victim = v
			ApplyDamage(damage_table)
		end
	end
