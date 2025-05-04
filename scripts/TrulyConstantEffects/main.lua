local core = require("openmw.core")
local self = require("openmw.self")
local async = require("openmw.async")
local types = require("openmw.types")
local time = require("openmw_aux.time")

require("scripts.TrulyConstantEffects.utils")
require("scripts.TrulyConstantEffects.consts")
require("scripts.TrulyConstantEffects.general_utils.tables")


local reapplyInvisInstantly = true
local resummonInstantly = true
local threshold = 0.5


local function checkConstSummon()
    local constEquipmentSpells = {}

    -- get active const effect spells
    -- for whatever reason dead summons and broken invis still count as active spells
    for _, spell in pairs(types.Actor.activeSpells(self)) do
        local item = spell.item

        -- if spell source is an item
        if item ~= nil then
            local itemRecord = item.type.records[item.recordId]
            local enchantmentRecord = core.magic.enchantments.records[itemRecord.enchant]

            -- if enchantment on the item is constant
            if enchantmentRecord.type == core.magic.ENCHANTMENT_TYPE.ConstantEffect then
                -- check if its a relevant effect for us
                -- TODO test it
                for _, effect in ipairs(enchantmentRecord.effects) do
                    if RelevantEffectIds[effect.id] then
                        table.insert(constEquipmentSpells, spell)
                        break
                    end
                end
            end
        end
    end

    -- check each spell if its active *enough*
    -- TODO check if invisibility from 2 items work correctly
    for _, spell in ipairs(constEquipmentSpells) do
        local item = spell.item
        local itemRecord = item.type.records[item.recordId]
        local enchantmentRecord = core.magic.enchantments.records[itemRecord.enchant]
        
        -- count active and item spells
        local spellEffectCount = TableSize(spell.effects)
        local enchEffectCount =  TableSize(enchantmentRecord.effects)
        
        -- check if all spells are active
        if (
            spellEffectCount ~= enchEffectCount
            and spellEffectCount / enchEffectCount <= threshold
        ) then
            -- maybe theres a better way to write it
            -- check active effects of the spell
            local activeEffects = {}
            for _, effect in ipairs(spell.effects) do
                activeEffects[effect.id] = true
            end

            -- get all missing effects of the spell
            local missingEffectIds = {
                invisibility = {},
                summon = {}
            }
            for index, effect in ipairs(enchantmentRecord.effects) do
                if not activeEffects[effect.id] then
                    -- invis and summons need to be treated separately
                    if effect.id == core.magic.EFFECT_TYPE.Invisibility then
                        table.insert(missingEffectIds.invisibility, index-1)
                    else
                        table.insert(missingEffectIds.summon, index-1)
                    end
                end
            end

            -- TODO
            -- add timer for invisibility
            -- add timer for summons
            -- add instant

            -- Current problem: effects are aplied for 0s instead of constantly
            -- if i dont find a workaround, i'll have to resort to requipping the item...
            print("Applying the effect back...")
            types.Actor.activeSpells(self):add({
                id = spell.id,
                effects = missingEffectIds,
            })
        end
    end
end


-- heart of the thing
time.runRepeatedly(checkConstSummon, 1 * time.second)


-- return {
--     engineHandlers = {
--         onUpdate = function ()

--         end,
--     }
-- }