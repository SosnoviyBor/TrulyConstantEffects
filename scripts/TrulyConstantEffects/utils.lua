local core = require("openmw.core")
local types = require("openmw.types")


function GetAllActiveConstSpellsFromEquipment(actor)
    -- get active const effect spells
    local constEquipmentSpells = {}
    for _, spell in pairs(types.Actor.activeSpells(actor)) do
        local item = spell.item

        -- if spell source is not an item
        if item ~= nil then
            local itemRecord = item.type.records[item.recordId]
            local enchantmentRecord = core.magic.enchantments.records[itemRecord.enchant]

            -- if enchantment on the item is constant
            if enchantmentRecord.type == core.magic.ENCHANTMENT_TYPE.ConstantEffect then
                table.insert(constEquipmentSpells, spell)
            end
        end
    end

    return constEquipmentSpells
end


function PrintConstEquipmentSpellsInfo(constEquipmentSpells)
    for id, params in ipairs(constEquipmentSpells) do
        print('active spell '..tostring(id)..':')
        print('  name: '..tostring(params.name))
        print('  id: '..tostring(params.id))
        print('  item: '..tostring(params.item))
        print('  caster: '..tostring(params.caster))
        print('  effects: '..tostring(params.effects))
        for _, effect in pairs(params.effects) do
            print('  -> effects['..tostring(effect)..']:')
            print('       id: '..tostring(effect.id))
            print('       name: '..tostring(effect.name))
            print('       affectedSkill: '..tostring(effect.affectedSkill))
            print('       affectedAttribute: '..tostring(effect.affectedAttribute))
            print('       magnitudeThisFrame: '..tostring(effect.magnitudeThisFrame))
            print('       minMagnitude: '..tostring(effect.minMagnitude))
            print('       maxMagnitude: '..tostring(effect.maxMagnitude))
            print('       duration: '..tostring(effect.duration))
            print('       durationLeft: '..tostring(effect.durationLeft))
            print("\n")
        end
    end
    print("\n\n\n")
end


function IsTableEmpty(list)
    return next(list) ~= nil
end