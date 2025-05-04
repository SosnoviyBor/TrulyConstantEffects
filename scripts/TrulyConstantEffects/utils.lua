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