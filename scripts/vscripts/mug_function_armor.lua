function modifier_mug_armor_on_attack_landed(keys)

		
		local previous_stack_count = 0
		if keys.target:HasModifier("modifier_mug_debuff_counter") then
			previous_stack_count = keys.target:GetModifierStackCount("modifier_mug_debuff_counter", keys.caster)
			
			
			keys.target:RemoveModifierByNameAndCaster("modifier_mug_debuff_counter", keys.caster)
		end
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_mug_debuff_counter", nil)
		keys.target:SetModifierStackCount("modifier_mug_debuff_counter", keys.caster, previous_stack_count + 1)		
		
	
		local i = 0
		local armor_loss_abs = math.abs(keys.armor_loss)
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_mug_armor_datadriven_debuff", nil)
			i = i + 1
		end



function modifier_mug_armor_datadriven_debuff_on_destroy(keys)
	if keys.target:HasModifier("modifier_mug_debuff_counter") then
		local previous_stack_count = keys.target:GetModifierStackCount("modifier_mug_debuff_counter", keys.caster)
		if previous_stack_count > 1 then
			keys.target:SetModifierStackCount("modifier_mug_debuff_counter", keys.caster, previous_stack_count - 1)
		else
			keys.target:RemoveModifierByNameAndCaster("modifier_mug_debuff_counter", keys.caster)
		end
	end
end


