local Config = lib.require('config')
local examCompleted = false

function shuffleQuestions(t)
    local shuffled = {}
    for i = #t, 1, -1 do
        local rand = math.random(i)
        t[i], t[rand] = t[rand], t[i]
        table.insert(shuffled, t[i])
    end
    return shuffled
end

function beginExam()
    local ped = PlayerPedId()
    if ped then
        local alert = lib.alertDialog({
            header = Config.StartExamHeader,
            content = Config.StartExamContent,
            centered = true,
            cancel = true,
            labels = {
                confirm = 'Iniciar',
                cancel = 'Cancelar'
            }
        })
        if alert == 'cancel' then
            return
        end

        local score = 0
        local questions = shuffleQuestions(Config.Questions)
        for _, question in ipairs(questions) do
            ::StartQuestion::
            local options = {}
                table.insert(options, {
                    type = 'select',
                    options = question.options
                })
            local input = lib.inputDialog(question.title, options)
            if not input then
                lib.notify({description = 'Você cancelou o exame', type = 'error'})
                return
            end
            local answers = 0
            for i, answer in ipairs(input) do
                if answer then
                    answers = answers + 1
                end
            end
            for i, answer in ipairs(input) do
                if answer and question.options[i].value then
                    score = score + 1
                end
            end
        end

        if score >= Config.PassingScore then
            local alert = lib.alertDialog({
                header = Config.SuccessHeader,
                content = Config.SuccessContent,
                centered = true,
                cancel = false,
                labels = {
                    confirm = 'Jogar',
                    cancel = 'Fechar'
                }
            })
            lib.callback.await('mri_Qwhitelist:addCitizenship', false)
            examCompleted = true
            DoScreenFadeOut(800)
            Wait(800)
            SetEntityCoords(ped, Config.completionCoords, 1, 0, 0, 1)
            SetEntityHeading(ped, Config.completionCoords.h)
            Wait(500)
            DoScreenFadeIn(1000)
        else
            lib.alertDialog({
                header = Config.FailedHeader,
                content = Config.FailedContent,
                centered = true,
                cancel = false,
                labels = {
                    confirm = 'Fechar',
                    cancel = 'Fechar'
                }
            })
        end
    end
end

function escapeCitizenship()

    if examCompleted then
        return
    end

    DoScreenFadeOut(500)
    FreezeEntityPosition(cache.ped, true)
    Wait(800)

    SetEntityCoords(cache.ped, Config.spawnCoords.x, Config.spawnCoords.y, Config.spawnCoords.z)
    SetEntityHeading(cache.ped, Config.spawnCoords.h)

    FreezeEntityPosition(cache.ped, false)
    DoScreenFadeIn(1000)
    lib.notify({ description = Config.escapeNotify, type = 'error' })
end

function loadCitizenship()

    DoScreenFadeOut(500)
    FreezeEntityPosition(cache.ped, true)
    Wait(800)

    SetEntityCoords(cache.ped, Config.spawnCoords.x, Config.spawnCoords.y, Config.spawnCoords.z)
    SetEntityHeading(cache.ped, Config.spawnCoords.h)

    loadInteractions()

    local citizenZone = lib.zones.box({
        name = "citizenZone",
        coords = Config.citizenZone.coords,
        size = Config.citizenZone.size,
        rotation = Config.citizenZone.rotation,
        debug = true
    })

    function citizenZone:onExit(self)
        if examCompleted then
            citizenZone:remove()
            return
        end

        escapeCitizenship()
    end

    FreezeEntityPosition(cache.ped, false)
    DoScreenFadeIn(1000)
    lib.notify({ description = Config.loadNotify, type = 'info' })
end

function OnPlayerLoaded()
    local isCitizen = lib.callback.await('mri_Qwhitelist:checkCitizenship', false)

    if not isCitizen then
        loadCitizenship()
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    OnPlayerLoaded()
end)