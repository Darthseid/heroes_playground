function Criminal( keys )
		print ("hi")
local caster = keys.caster
local target = keys.target
local ability = keys.ability
local bonus_gold = 250
		print(bonus_gold)
local targetLocation = caster:GetAbsOrigin()
local bonus_gold_radius = 815

		print(bonus_gold_radius)
local bonus_gold_targets = FindUnitsInRadius(caster:GetTeam() , targetLocation, nil, bonus_gold_radius, DOTA_UNIT_TARGET_TEAM_ENEMY , DOTA_UNIT_TARGET_HERO, 0, 0, false)
		print (bonus_gold_targets)

	for k,v in pairs(bonus_gold_targets) do v:ModifyGold(bonus_gold, true, 0)
	end
		print("Next Up")
end

function Scum( keys )
local caster = keys.caster
local ability = keys.ability
local gold_loss = -500
		print(gold_loss)
	caster:ModifyGold(gold_loss, true, 0)
		print("bye")
end
