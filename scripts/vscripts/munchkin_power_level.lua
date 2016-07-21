function item_hand_of_midas_datadriven_on_spell_start(keys)
local caster = keys.caster
	local target = keys.target
	local targetLocation = target:GetAbsOrigin() 
	local ability = keys.ability
	if not target:IsAlive() then

		-- Gives gold to the caster
keys.caster:AddExperience(keys.target:GetDeathXP() * keys.XPMultiplier_munchkin, false, false)  --Give the player some XP.
		-- Finds all valid friendly heroes within the bonus gold radius
		local bonus_xp_targets = FindUnitsInRadius(caster:GetTeam() , targetLocation, nil, aura_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY , DOTA_UNIT_TARGET_HERO, 0, 0, false)

		-- Grants them gold but we must exclude the caster
		for i,v in ipairs(bonus_xp_targets) do
			if not (v == caster) then
				v:AddExperience(keys.target:GetDeathXP() * keys.XPMultiplier_munchkin, false, false)  --Give the player some XP.
			end
		end
	end
	
	--Start the particle and sound.
	keys.target:EmitSound("DOTA_Item.Hand_Of_Midas")
	local midas_particle = ParticleManager:CreateParticle("particles/items2_fx/hand_of_midas.vpcf", PATTACH_ABSORIGIN_FOLLOW, keys.target)	
	ParticleManager:SetParticleControlEnt(midas_particle, 1, keys.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.caster:GetAbsOrigin(), false)

	--Remove default gold/XP on the creep before killing it so the caster does not receive anything more.
	keys.target:SetDeathXP(0)
end
