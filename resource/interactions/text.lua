local Config = lib.require('config')

if Config.interaction.type ~= "3dtext" then
    return
end

function loadInteractions()

    local point = lib.points.new({
        coords = Config.examCoords,
        distance = 8
    })

    function point:nearby()
        local onScreen, _x, _y = World3dToScreen2d(Config.examCoords.x, Config.examCoords.y, Config.examCoords.z + 1)
        if onScreen then
            SetTextScale(0.4, 0.4)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 255)
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(true)
            AddTextComponentString("[~b~E~w~] " .. Config.interaction.markerlabel .. "")
            DrawText(_x, _y)
        end
        if self.currentDistance < 3 and IsControlJustReleased(0, 38) then
            beginExam()
        end
    end
end
