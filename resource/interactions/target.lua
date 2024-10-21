local Config = lib.require('config')

if Config.interaction.type ~= "target" then
    return
end

local targetId
function loadInteractions()
    local options = {
        {
            name = 'mri_Qwhitelist:targetExam',
            onSelect = beginExam,
            icon = Config.interaction.targeticon,
            label = Config.interaction.targetlabel
        },
        distance = Config.interaction.targetdistance,
    }
    targetId = exports.ox_target:addBoxZone({
        coords = Config.examCoords,
        size = Config.interaction.targetradius,
        rotation = 45,
        options = options
    })
end

AddEventHandler('onResourceStop', function(resource)
   if resource == GetCurrentResourceName() then
       exports.ox_target:removeZone(targetId)
   end
end)
