-- left it just for future reference







local core = require("openmw.core")
local self = require("openmw.self")
local async = require("openmw.async")
local types = require("openmw.types")
local time = require("openmw_aux.time")
require("scripts.TrulyConstantEffects.utils")


local countdownActive = false
local reequippingQueue = {}

local function applyConstInvis(args)
    local item = args[1]
    local constItemSlot
    local equipment = types.Actor.getEquipment(self.object)
    -- get the exact item slot if it's still equipped
    -- BUG helmet being unequipped together with amulet
    for slot, equippedItem in pairs(types.Actor.getEquipment(self.object)) do
        if equippedItem == item then
            constItemSlot = slot
            break
        end
    end
    -- item is no longer equipped
    if not constItemSlot then
        countdownActive = false
        return
    end

    -- populate the queue with functions
    -- since they have to be iterated in 2 separate frames
    local equipmentBefore = {table.unpack(equipment)}
    equipmentBefore[constItemSlot] = nil
    table.insert(reequippingQueue, function ()
        types.Actor.setEquipment(self, equipmentBefore)
        -- print("unequip")
    end)
    local equipmentAfter = {table.unpack(equipment)}
    equipmentAfter[constItemSlot] = item
    table.insert(reequippingQueue, function ()
        types.Actor.setEquipment(self, equipmentAfter)
        -- print("equip")
    end)

    countdownActive = false
end

local applyConstInvisTimerCallback = async:registerTimerCallback(
    "applyConstInvis", applyConstInvis
)

local function checkConstInvis()
    local constEnchantItem = CheckConstEnchantedEquipment(
        self.object, core.magic.EFFECT_TYPE.Invisibility)
    local hasConstInvisEffect = CheckActiveConstEffect(
        self.object, core.magic.EFFECT_TYPE.Invisibility)

    if (
        constEnchantItem ~= nil
        and not hasConstInvisEffect
        and not countdownActive
    ) then
        countdownActive = true
        async:newSimulationTimer(
        -- TODO add configurations
            1 * time.second,
            applyConstInvisTimerCallback,
            {constEnchantItem})
    end
end


-- -- heart of the thing
-- time.runRepeatedly(checkConstInvis, 1 * time.second)


-- return {
--     engineHandlers = {
--         onUpdate = function ()
--             -- unequip and eqip the const enchant item
--             -- to reapply the constant effect
--             if next(reequippingQueue) ~= nil then
--                 table.remove(reequippingQueue, 1)()
--             end
--         end,
--         -- TODO add saving and loading for reequippingQueue
--     }
-- }