
function item_urn_of_shadows_datadriven_on_spell_start(keys)
	keys.target:EmitSound("DOTA_Item.UrnOfShadows.Activate")
	
	if keys.caster:GetTeam() == keys.target:GetTeam() then   --Apply the healing version of the Urn modifier.
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_urn_of_shadows_datadriven_heal", nil)
	else  --Apply the damaging version of the Urn modifier.
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_urn_of_shadows_datadriven_damage", nil)
	end
end