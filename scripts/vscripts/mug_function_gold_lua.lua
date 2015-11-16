function mug_attack_loss( keys )

    local attacker = keys.attacker
    local target = keys.target
    local ability = keys.ability

    ability.gold_steal_percent = ability:GetLevelSpecialValueFor("gold_loss_percent", ability:GetLevel() - 1)
    local mug_modifier = keys.mug_modifier 
	
if keys.target:IsHero() and keys.target:IsOpposingTeam(keys.caster:GetTeam()) then
 target:ModifyGold = target:GetDamageDoneToHero() * (ability.gold_loss_percent / 100)

    -- this sets the number of stacks of damage
    ability:ApplyDataDrivenModifier(attacker, attacker, mug_modifier, {})
    attacker:SetModifierStackCount(mug_modifier, ability, damage)
end

function mug_attack_gain( keys )
  local attacker = keys.attacker
  local target = keys.target
  local ability = keys.ability

  ability.gold_gain_percent = ability:GetLevelSpecialValueFor("gold_gain_percent", ability:GetLevel() - 1)
  if keys.target:IsHero() and keys.target:IsOpposingTeam(keys.caster:GetTeam()) then
  
  attacker:ModifyGold = target:GetDamageDoneToHero() * (ability.gold_gain_percent / 100)

 
end