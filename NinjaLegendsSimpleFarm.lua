-- BLACK X NINJA AUTO FARM

repeat task.wait() until game:IsLoaded()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "BLACK X | Ninja Auto Farm",
    LoadingTitle = "BLACK X",
    LoadingSubtitle = "Advanced Farm System",
    ConfigurationSaving = {Enabled = false},
    KeySystem = false,
})

-- SERVICES
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local plr = Players.LocalPlayer

local function GetHRP()
    return plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
end

local function TP(cf)
    local hrp = GetHRP()
    if hrp then
        hrp.CFrame = cf
    end
end

-- ILHAS
local Ilhas = {
    {Nome = "Ilha 1", CFrame = CFrame.new(72.36, 765.96, -159.21)},
    {Nome = "Ilha 2", CFrame = CFrame.new(219.70, 2013.81, 258.15)},
    {Nome = "Ilha 3", CFrame = CFrame.new(154.03, 4047.16, 63.70)},
    {Nome = "Ilha 4", CFrame = CFrame.new(143.63, 5656.96, 81.75)},
    {Nome = "Ilha 5", CFrame = CFrame.new(140.13, 9284.96, 67.44)},
    {Nome = "Ilha 6", CFrame = CFrame.new(142.27, 13679.81, 70.38)},
    {Nome = "Ilha 7", CFrame = CFrame.new(141.44, 17686.11, 70.05)},
    {Nome = "Ilha 8", CFrame = CFrame.new(136.73, 24069.80, 62.74)},
    {Nome = "Ilha 9", CFrame = CFrame.new(139.75, 28256.07, 64.92)},
    {Nome = "Ilha 10", CFrame = CFrame.new(136.60, 33206.76, 65.27)},
    {Nome = "Ilha 11", CFrame = CFrame.new(139.05, 39317.35, 61.29)},
    {Nome = "Ilha 12", CFrame = CFrame.new(139.89, 46010.34, 61.77)},
    {Nome = "Ilha 13", CFrame = CFrame.new(138.13, 52607.55, 66.83)},
    {Nome = "Ilha 14", CFrame = CFrame.new(138.37, 59594.46, 66.20)},
    {Nome = "Ilha 15", CFrame = CFrame.new(142.11, 66668.95, 72.74)},
    {Nome = "Ilha 16", CFrame = CFrame.new(143.77, 70270.95, 72.04)},
    {Nome = "Ilha 17", CFrame = CFrame.new(141.71, 74442.64, 73.28)},
    {Nome = "Ilha 18", CFrame = CFrame.new(139.04, 79746.77, 64.65)},
    {Nome = "Ilha 19", CFrame = CFrame.new(137.52, 83198.77, 64.03)},
    {Nome = "Ilha 20", CFrame = CFrame.new(137.99, 87050.86, 63.74)},
    {Nome = "Ilha 21", CFrame = CFrame.new(139.62, 91245.86, 62.33)},
    {Nome = "Ilha 22", CFrame = CFrame.new(141.70, 91245.86, 66.16)}
}

-- FARM POSIÇÕES
local ChiCF = CFrame.new(234.57, 106.96, -287.83)
local MoneyCF = CFrame.new(93.84, 91245.55, 137.06)

-- DETECTAR ILHA
local function GetClosestIslandIndex()
    local hrp = GetHRP()
    if not hrp then return 1 end

    local closestIndex = 1
    local closestDistance = math.huge

    for i, ilha in ipairs(Ilhas) do
        local dist = (hrp.Position - ilha.CFrame.Position).Magnitude
        if dist < closestDistance then
            closestDistance = dist
            closestIndex = i
        end
    end

    if closestDistance > 5000 then
        return 1
    end

    return closestIndex
end

-- EMPURRAR PLAYERS (CHI)
local function PushPlayers()
    local hrp = GetHRP()
    if not hrp then return end

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local target = v.Character.HumanoidRootPart
            local dist = (hrp.Position - target.Position).Magnitude

            if dist < 25 then
                target.Velocity = (target.Position - hrp.Position).Unit * 100
            end
        end
    end
end

-- AUTO CLICK (MONEY)
local function AutoClick()
    VirtualUser:CaptureController()
    VirtualUser:Button1Down(Vector2.new(0,0))
end

-- TOGGLES
local AutoIlha = false
local FarmChi = false
local FarmMoney = false

local Tab = Window:CreateTab("Auto Farm")

-- AUTO ILHAS
Tab:CreateToggle({
    Name = "Auto Subir Ilhas",
    CurrentValue = false,
    Callback = function(v)
        AutoIlha = v

        while AutoIlha do
            local startIndex = GetClosestIslandIndex()

            TP(Ilhas[startIndex].CFrame)
            task.wait(1)

            for i = startIndex + 1, #Ilhas do
                if not AutoIlha then break end
                TP(Ilhas[i].CFrame)
                task.wait(1.2)
            end

            task.wait(2)
        end
    end
})

-- FARM CHI
Tab:CreateToggle({
    Name = "Auto Farm Chi",
    CurrentValue = false,
    Callback = function(v)
        FarmChi = v

        while FarmChi do
            TP(ChiCF)
            PushPlayers()
            task.wait(0.5)
        end
    end
})

-- FARM MONEY
Tab:CreateToggle({
    Name = "Auto Farm Money",
    CurrentValue = false,
    Callback = function(v)
        FarmMoney = v

        while FarmMoney do
            TP(MoneyCF)
            AutoClick()
            task.wait(0.2)
        end
    end
})

Rayfield:Notify({
    Title = "BLACK X",
    Content = "Auto Farm V4 carregado!",
    Duration = 5
})
