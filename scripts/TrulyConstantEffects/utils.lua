local core = require("openmw.core")
local types = require("openmw.types")


function CheckConstEnchantedEquipment(actor, effect)
    local constEnchantItems = {}
    for _, item in pairs(types.Actor.getEquipment(actor)) do
        local itemData = types.Item.itemData(item)
        -- check if item *potentially* has constant enchant
        if itemData.enchantmentCharge == 0 then
            -- get the item record
            local itemRecord = item.type.records[item.recordId]
            if itemRecord == nil then goto continue end
            -- get the enchantment record
            local enchantmentRecord = core.magic.enchantments.records[itemRecord.enchant]
            -- check for the enchantment type and effect
            if enchantmentRecord.type == core.magic.ENCHANTMENT_TYPE.ConstantEffect then
                -- iterate each effect to find the exact one
                for _, effectParams in pairs(enchantmentRecord.effects) do
                    if effect == effectParams.effect.id then
                        table.insert(constEnchantItems, item)
                    end
                end
            end
        end
        ::continue::
    end
    -- no such item
    return constEnchantItems
end


SummonEffectIds = {
    -- core.magic.EFFECT_TYPE.SummonAncestralGhost,
    -- core.magic.EFFECT_TYPE.SummonBear,
    -- core.magic.EFFECT_TYPE.SummonBonelord,
    -- core.magic.EFFECT_TYPE.SummonBonewalker,
    -- core.magic.EFFECT_TYPE.SummonBonewolf,
    -- core.magic.EFFECT_TYPE.SummonCenturionSphere,
    -- core.magic.EFFECT_TYPE.SummonClannfear,
    -- core.magic.EFFECT_TYPE.SummonDaedroth,
    -- core.magic.EFFECT_TYPE.SummonDremora,
    -- core.magic.EFFECT_TYPE.SummonFabricant,
    -- core.magic.EFFECT_TYPE.SummonFlameAtronach,
    -- core.magic.EFFECT_TYPE.SummonFrostAtronach,
    -- core.magic.EFFECT_TYPE.SummonGoldenSaint,
    -- core.magic.EFFECT_TYPE.SummonGreaterBonewalker,
    -- core.magic.EFFECT_TYPE.SummonHunger,
    -- core.magic.EFFECT_TYPE.SummonScamp,
    core.magic.EFFECT_TYPE.SummonSkeletalMinion,
    -- core.magic.EFFECT_TYPE.SummonStormAtronach,
    -- core.magic.EFFECT_TYPE.SummonWingedTwilight,
    -- core.magic.EFFECT_TYPE.SummonWolf,
    
    -- who?
    -- core.magic.EFFECT_TYPE.SummonCreature04,
    -- core.magic.EFFECT_TYPE.SummonCreature05,
}


function IsTableEmpty(list)
    return next(list) ~= nil
end