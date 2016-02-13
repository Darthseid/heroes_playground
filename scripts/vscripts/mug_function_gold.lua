function mug_attack_steal( keys )

    local attacker = keys.attacker
    local target = keys.target
    local ability = keys.ability

    ability.gold_loss_percent = ability:GetLevelSpecialValueFor("gold_loss_percent", ability:GetLevel() - 1)
ability.gold_gain_percent = ability:GetLevelSpecialValueFor("gold_gain_percent", ability:GetLevel() - 1)

local Damage = attacker:GetAttackDamage()

if keys.target:IsHero() and keys.target:IsOpposingTeam(keys.caster:GetTeam()) then
local take = Damage * (ability.gold_loss_percent / 100)
local get = Damage * (ability.gold_gain_percent / 100)

target:ModifyGold(take, false, 0)
attacker:ModifyGold(get, false, 0)
	end
end


