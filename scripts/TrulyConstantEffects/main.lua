local core = require("openmw.core")
local self = require("openmw.self")
local async = require("openmw.async")
local types = require("openmw.types")
local time = require("openmw_aux.time")

require("scripts.TrulyConstantEffects.utils")
require("scripts.TrulyConstantEffects.consts")


local countdownActive = false

local function checkConstSummon()
    local constEquipmentSpells = GetAllActiveConstSpellsFromEquipment(self.object)

    -- check if all spells are active
    -- dont forget about threshold
    for _, spell in ipairs(constEquipmentSpells) do
        
    end
end


-- heart of the thing
time.runRepeatedly(checkConstSummon, 1 * time.second)


return {
    engineHandlers = {
        onUpdate = function ()

        end,
    }
}