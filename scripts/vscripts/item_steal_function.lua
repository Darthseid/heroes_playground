function Swap( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	
  if target:GetNumItemsInInventory() < 6 then
  
    local demItems = {}
    for itemSlot = 0, 5 do 
      local item = target:GetItemInSlot(itemSlot)
      if item then
        table.insert(demItems, item)
      end
      print("INVENTORY IS COOL")
    end

		if #demItems > 0 then
    	local randomItem = demItems[RandomInt(1,#demItems)]
    	local theItem = target:Script_TakeItem(randomItem)		
		print ("Grey Fox")
		theItem:SetOwner(nil)
		theItem:SetPurchaser(nil)
    	caster:AddItem(theItem)
		end
	else
  	print("INVENTORY IS FOOL")
  end
end

function Drop( keys )
local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local itemName = tostring(keys.ability:GetAbilityName())
for itemSlot = 0, 5 do 
      local item = target:GetItemInSlot(itemSlot)
      if item then
local theItem = caster:Script_TakeItem(stolenItem)		
		print ("Grey Fox")
		theItem:SetOwner(nil)
		theItem:SetPurchaser(nil)
    	target:AddItem(theItem)
		end
	else
  	print("INVENTORY IS FOOL")
  end
