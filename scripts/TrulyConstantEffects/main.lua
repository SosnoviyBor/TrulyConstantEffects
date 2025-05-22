require("scripts.TrulyConstantEffects.player_state")

local playerState
local isSecondFrame = false
local showMessages = true

return {
    engineHandlers = {
        onUpdate = function()
            if not playerState:isUpToDate() and isSecondFrame then
                playerState:updateSpells(showMessages)
                isSecondFrame = false
            else
                -- i need one additional frame to refresh the state
                -- lmao
                isSecondFrame = true
            end
        end,
        onLoad = function()
            playerState = PlayerState:new()
        end
    }
}
