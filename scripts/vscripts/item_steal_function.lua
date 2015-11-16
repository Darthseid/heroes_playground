function Five Finger Discount( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	
	
target:GetNumItemsinInventory()

GetNumItemsinInventory = v
math.random(0,v) = i


for itemSlot = i, 1 do
local item = target:GetItemInSlot(itemSlot)
 if item ~= nil then
 local itemName = itemGetName()
 local newItem = CreateItem(itemName, caster, target)
 
caster:AddItem(itemName)
target:RemoveItem(itemName)

itemName:IsDroppable = false
itemName:IsSellable = false
itemName:IsDisassemblable = false
itemName:IsCombinable = false

end

function Red Handed
local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	
if caster:HasItemInInventory(itemName) then
local item = caster:GetItemInSlot(itemSlot)
 if item ~= nil then
 local itemName = itemGetName()
 local newItem = CreateItem(itemName, caster, target)

 
caster:RemoveItem(itemName)
target:AddItem(itemName)


end

