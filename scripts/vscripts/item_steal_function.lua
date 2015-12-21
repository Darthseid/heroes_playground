function Five( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	
	
target:GetNumItemsinInventory()

GetNumItemsinInventory = v

for itemSlot =  RandomInt( int 0, int v ) , = i, 1 do
local item = target:GetItemInSlot(itemSlot)
 if item ~= nil then
 local itemName = itemGetName()
 itemName:GetCurrentCharges = z
 local newItem = CreateItem(itemName, caster, target)
 
itemName:SetCurrentCharges(z)
caster:AddItem(itemName)
target:RemoveItem(itemName)

itemName:IsDroppable = false
itemName:IsSellable = false
itemName:IsDisassemblable = false
itemName:IsCombinable = false

end

function Red( keys )
local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	
if caster:HasItemInInventory(itemName) then
local item = caster:GetItemInSlot(itemSlot)
 if item ~= nil then
 local itemName = itemGetName()
  itemName:GetCurrentCharges = z
 local newItem = CreateItem(itemName, caster, target)
 
caster:RemoveItem(itemName)
itemName:SetCurrentCharges(z)
target:AddItem(itemName)
						end
				end
			end
