function ReorderInventory( keys )
local caster = keys.caster
	local target = keys.target
    local slots = {}
    for itemSlot = 0, 5, 1 do

        -- Handle the case in which the caster is removed
        local item
        if IsValidEntity(caster) then
            item = caster:GetItemInSlot( itemSlot )		
        end
		
        if item ~= nil then
            table.insert(slots, itemSlot)
        end
    end

    for k,itemSlot in pairs(slots) do	
        caster:SwapItems(itemSlot,k+6) --makes the items permanently unavailable while still applying stats
    end
end

function ReorderStash( keys )
local caster = keys.caster
	local target = keys.target
    local slots = {}
    for itemSlot = 6, 11, 1 do

        -- Handle the case in which the caster is removed
        local item
        if IsValidEntity(caster) then
            item = caster:GetItemInSlot( itemSlot )
		
        end
        if item ~= nil then		
            table.insert(slots, itemSlot)
        end		
    end
	
    for k,itemSlot in pairs(slots) do
        caster:SwapItems(itemSlot,k-6)	--doesn't do much	
    end
end


 function Gold( keys )
	local caster = keys.caster
	local ability = keys.ability
local gold_gain = 2		
	caster:ModifyGold(gold_gain, true, 0)
					end
			
 
