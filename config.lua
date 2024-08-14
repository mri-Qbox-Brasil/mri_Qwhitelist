return {
    loadNotify = 'Você deve completar o exame de cidadania para jogar!', -- Notification when player loads in without completing citizenship.
    escapeNotify = 'Você deve completar o exame de cidadania para jogar!', -- Notification when player tries to leave citizenship office.
    -- Labels for Exam:
    StartExamLabel = 'Iniciar o exame de cidadania',
    StartExamHeader = 'Exame de cidadania',
    StartExamContent = 'Todos os novos cidadãos devem passar no exame antes que possam jogar. Faça no seu tempo, responda com bom senso e não responda aleatoriamente.',
    SuccessHeader = 'Você passou no exame de cidadania!',
    SuccessContent = 'Bem -vindo ao nosso servidor!',
    FailedHeader = 'Você falhou no exame de cidadania!',
    FailedContent = 'Por favor, tente novamente.',
    PassingScore = 4, -- Amount of correct questions required to get citizenship.
    NotifyType = 'ox_lib', -- Support for 'ox_lib', 'qb', 'esx', 'okok' and 'custom' to use a different type.
    interaction = {
        type = 'target', -- Supports 'marker' and 'target' and '3dtext'

        markerlabel = 'Comece o exame de cidadania',
        markertype = 27, -- https://docs.fivem.net/docs/game-references/markers/
        markercolor = { r = 26, g = 115, b = 179}, -- RGB Color picker: https://g.co/kgs/npUqed1
        markersize = { x = 1.0, y = 1.0, z = 1.0},

        targeticon = 'fas fa-passport', -- https://fontawesome.com/icons
        targetlabel = 'Comece o exame de cidadania',
        targetradius = vector3(4, 4, 4),
        targerdistance = 2.0,
    },

    -- DO NOT MODIFY UNLESS YOU ARE GOING TO MODIFY citizenZone.
    spawnCoords = vec4(-1371.2579, -471.2089, 72.0422, 6.8564),
    examCoords = vec3(-1372.2820, -465.5251, 71.8305), -- vec3(-1372.2820, -465.5251, 71.8305)
    completionCoords = vec4(-1034.9070, -2733.7327, 20.1693, 331.5052),

    citizenZone = { -- Can be created through /zone box
        coords = vec3(-1372.0, -468.0, 72.0),
        size = vec3(6.5, 29.0, 6.5),
        rotation = 5.0
    },

    Questions = {
        {
            title = 'O que é Meta Gaming?',
            allowCancel = false,
            options = {
                {label = 'Metagaming é o uso de qualquer informação que seu personagem não aprendeu dentro do roleplay na cidade.', correct = true},
                {label = 'Metagaming é quando você tenta vender pés de galinha para as pessoas e você não tem nenhum pé de galinha.', correct = false},
                {label = 'Eu não sei.', correct = false},
                {label = 'Metagaming é quando você não teme pela sua vida.', correct = false}
            }
        },
        {
            title = 'O que é Power Gaming?',
            options = {
                {label = 'Powergaming é o uso do cartão de crédito da sua mãe para comprar Fundador Suporte ;)', correct = false},
                {label = 'Powergaming é o uso de formas de roleplay irreais ou a recusa total de fazer roleplay para se dar uma vantagem injusta.', correct = true},
                {label = 'Powergaming é quando você invade o clube de alguém usando exploits.', correct = false},
                {label = 'Eu não sei.', correct = false}
            }
        },
        {
            title = 'Você pode usar software de trapaça de terceiros?',
            options = {
                {label = 'Sim, claro, eu adoro eulen!', correct = false},
                {label = 'Isso não é permitido sob nenhuma circunstância.', correct = true},
                {label = 'Somente se você pedir permissão para sua mãe.', correct = false},
                {label = 'Eu não sei.', correct = false}
            }
        },
        {
            title = 'Qual dos exemplos abaixo é uma Zona Verde?',
            allowCancel = false,
            options = {
                {label = 'Hospitais.', correct = true},
                {label = 'Bancos de parque.', correct = false},
                {label = 'Em todos os lugares.', correct = false},
                {label = 'Todos os itens acima', correct = false}
            }
        },
        {
            title = 'O que significa quebrar o personagem?',
            allowCancel = false,
            options = {
                {label = 'Quando você fala fora do personagem dentro da cidade.', correct = true},
                {label = 'Quando você quebra o personagem de outro jogador.', correct = false},
                {label = 'Quando seu tio não vem te buscar na escola.', correct = false},
                {label = 'Eu não sei.', correct = false}
            }
        },
        {
            title = 'Qual destes exemplos é da Regra de Morte Aleatória?',
            allowCancel = false,
            options = {
                {label = 'Você não pode atacar outro jogador aleatoriamente sem primeiro se envolver em algum tipo de RP verbal.', correct = true},
                {label = 'Você pode matar outros jogadores sem motivo.', correct = false},
                {label = 'Você não pode comprar água a menos que seja um apoiador do servidor.', correct = false},
                {label = 'Eu não sei.', correct = false}
            }
        }
    },
}
