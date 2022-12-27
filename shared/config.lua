Config = {}

Config.WelcomePlace = vector3(-490.16, -697.76, 33.24) -- Blip Coords
Config.PedCoords = vector4(-490.56, -693.48, 19.03, 48.64) -- Ped Spawn Coords

Config.Target = 'ox_target' -- qb-target todo
Config.Menu = 'keep-menu' -- qb-menu todo

Config.WelcomeZones = {
    [1] = {
        points = {
            vector2(-495.29165649414, -683.14117431641),
            vector2(-497.29385375977, -676.74005126953),
            vector2(-503.37655639648, -676.70086669922),
            vector2(-508.06423950195, -676.70281982422),
            vector2(-510.10824584961, -683.13684082031),
            vector2(-508.77206420898, -695.71142578125),
            vector2(-498.96215820312, -696.00164794922),
            vector2(-488.75524902344, -694.50854492188),
            vector2(-488.71618652344, -687.03118896484)
        },
        minZ = 1.43,
        maxZ = 22.7,
    }
}

Config.Questions = {
    {
        question = 'What is Fail RP?',
        answers = {
            a = 'Me Taking fat shit',
            b = 'False',
            c = 'Nope',
            d = 'Not This',
            correct = 'a',
        }
    },
    {
        question = 'What is RDM?',
        answers = {
            a = 'I drive into people and say was not me lol',
            b = 'I kill people for no reason and get banned',
            c = 'Nope',
            d = 'Shoot somone for no reason',
            correct = 'a',
        }
    },
    {
        question = 'What MoneSuper like the most?',
        answers = {
            a = 'Anna?',
            b = 'Loath?',
            c = 'Jay?',
            d = 'Monkey?',
            correct = 'b',
        }
    },
    {
        question = 'What happens when config devs ask questions?',
        answers = {
            a = 'How do Install Notepad++',
            b = 'I use notepad',
            c = 'How do I add SQL file into my server?',
            d = 'Your script dont work',
            correct = 'c',
        }
    },
 
    -- Add more questions here
    -- {
    --     question = 'What happens when config devs ask questions?',
    --     answers = {
    --         a = 'How do Install Notepad++',
    --         b = 'I use notepad',
    --         c = 'How do I add SQL file into my server?',
    --         d = 'Your script dont work',
    --         correct = 'c',
    --     }
    -- },
}

Config.Minimum = 3 -- Minimum amount of correct answers to pass the quiz

Config.DebugPoly = true -- Debug Polyzonezone lol
Config.AdminPerms = true -- Perm to bypass the quiz
