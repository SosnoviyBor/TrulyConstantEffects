local core = require("openmw.core")
local self = require("openmw.self")
local async = require("openmw.async")
local types = require("openmw.types")
local time = require("openmw_aux.time")

require("scripts.TrulyConstantEffects.utils")
require("scripts.TrulyConstantEffects.consts")


local countdownActive = false

local function checkConstSummon()
    -- get active const effect spells
    local constEquipmentSpells = {}
    for _, spell in pairs(types.Actor.activeSpells(self.object)) do
        local item = spell.item
        
        if item ~= nil then
            local itemRecord = item.type.records[item.recordId]
            local enchantmentRecord = core.magic.enchantments.records[itemRecord.enchant]
            print(enchantmentRecord)

            if enchantmentRecord.type == core.magic.ENCHANTMENT_TYPE.ConstantEffect then
                table.insert(constEquipmentSpells, spell)
            end
        end
    end

    for _, spell in ipairs(constEquipmentSpells) do
        
    end

    
    -- for id, params in ipairs(constEquipmentSpells) do
    --     print('active spell '..tostring(id)..':')
    --     print('  name: '..tostring(params.name))
    --     print('  id: '..tostring(params.id))
    --     print('  item: '..tostring(params.item))
    --     print('  caster: '..tostring(params.caster))
    --     print('  effects: '..tostring(params.effects))
    --     for _, effect in pairs(params.effects) do
    --         print('  -> effects['..tostring(effect)..']:')
    --         print('       id: '..tostring(effect.id))
    --         print('       name: '..tostring(effect.name))
    --         print('       affectedSkill: '..tostring(effect.affectedSkill))
    --         print('       affectedAttribute: '..tostring(effect.affectedAttribute))
    --         print('       magnitudeThisFrame: '..tostring(effect.magnitudeThisFrame))
    --         print('       minMagnitude: '..tostring(effect.minMagnitude))
    --         print('       maxMagnitude: '..tostring(effect.maxMagnitude))
    --         print('       duration: '..tostring(effect.duration))
    --         print('       durationLeft: '..tostring(effect.durationLeft))
    --         print("\n")
    --     end
    -- end
    -- print("\n\n\n")
end


-- heart of the thing
time.runRepeatedly(checkConstSummon, 1 * time.second)


return {
    engineHandlers = {
        onUpdate = function ()

        end,
        -- TODO add saving and loading for reequippingQueue
    }
}