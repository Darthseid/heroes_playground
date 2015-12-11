function Criminal( keys )
local caster = keys.caster
local target = keys.target
local targetLocation = target:GetAbsOrigin()
local bonus_gold = ability:GetLevelSpecialValueFor("bonus_gold", (ability:GetLevel() - 1))
local bonus_gold_radius = ability:GetLevelSpecialValueFor("bonus_gold_radius", (ability:GetLevel() - 1))
local bonus_gold_targets = FindUnitsInRadius(caster:GetTeam() , targetLocation, nil, bonus_gold_radius, DOTA_UNIT_TARGET_TEAM_ENEMY , DOTA_UNIT_TARGET_HERO, 0, 0, false)

bonus_gold_targets:ModifyGold(bonus_gold, true, 0)
end

function Scum( keys )
local caster = keys.caster
caster:ModifyGold(gold_loss, true, 0)
end
