Target = {
    TargetId = nil,
    LoadInteractions = function()
        if Config.Interaction.Type ~= "target" then
            return
        end
        local options = {
            {
                name = "mri_Qwhitelist:targetExam",
                onSelect = beginExam,
                icon = Config.Interaction.TargetIcon,
                label = Config.Interaction.TargetLabel,
                distance = Config.Interaction.TargetDistance,
            },
        }
        Target.TargetId =
        exports.ox_target:addBoxZone(
            {
                coords = Config.ExamCoords,
                size = Config.Interaction.TargetRadius,
                rotation = 45,
                options = options
            }
        )
    end
}

AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            exports.ox_target:removeZone(Target.TargetId)
        end
    end
)
