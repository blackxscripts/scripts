--// BLACK X UNIVERSAL HUB V1
--// Todas funções em PT-BR | Sem GUI externa

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BLACK X UNIVERSAL HUB V1",
   LoadingTitle = "BLACK X",
   LoadingSubtitle = "Scripts que fazem a diferença",
   ConfigurationSaving = {Enabled = false}
})

--// Tabs
local Principal = Window:CreateTab("Principal")
local Player = Window:CreateTab("Player")
local Teleporte = Window:CreateTab("Teleporte")
local Visual = Window:CreateTab("Visual")

--// Variáveis
local noclip = false
local velocidade = 16
local pulo = 50
local infjump = false
local fly = false
local gravidade0 = false

local pos1 = nil
local pos2 = nil

--// NOCLIP
Principal:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Callback = function(Value)
      noclip = Value
      while noclip do
         task.wait()
         for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
               v.CanCollide = false
            end
         end
      end
   end
})

--// CLICK TP (Ferramenta)
Principal:CreateButton({
   Name = "Click TP (Ferramenta)",
   Callback = function()
      local tool = Instance.new("Tool")
      tool.Name = "Click TP"
      tool.RequiresHandle = false

      tool.Activated:Connect(function()
         local mouse = game.Players.LocalPlayer:GetMouse()
         if mouse.Hit then
            game.Players.LocalPlayer.Character:MoveTo(mouse.Hit.Position)
         end
      end)

      tool.Parent = game.Players.LocalPlayer.Backpack
   end
})

--// SPEED
Player:CreateSlider({
   Name = "Velocidade",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      velocidade = Value
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = velocidade
   end
})

--// PULO
Player:CreateSlider({
   Name = "Força do Pulo",
   Range = {50, 200},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(Value)
      pulo = Value
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = pulo
   end
})

--// INFINITE JUMP
Player:CreateToggle({
   Name = "Pulo Infinito",
   CurrentValue = false,
   Callback = function(Value)
      infjump = Value
   end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
   if infjump then
      game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

--// FLY
Player:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Callback = function(Value)
      fly = Value
      local plr = game.Players.LocalPlayer
      local char = plr.Character
      local hrp = char:WaitForChild("HumanoidRootPart")

      if fly then
         local bv = Instance.new("BodyVelocity")
         bv.Velocity = Vector3.new(0,0,0)
         bv.MaxForce = Vector3.new(9e9,9e9,9e9)
         bv.Parent = hrp

         local bg = Instance.new("BodyGyro")
         bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
         bg.CFrame = hrp.CFrame
         bg.Parent = hrp

         while fly do
            task.wait()
            bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
         end

         bv:Destroy()
         bg:Destroy()
      end
   end
})

--// GRAVIDADE ZERO
Player:CreateToggle({
   Name = "Gravidade Zero",
   CurrentValue = false,
   Callback = function(Value)
      gravidade0 = Value
      if gravidade0 then
         workspace.Gravity = 0
      else
         workspace.Gravity = 196
      end
   end
})

--// TELEPORT SALVAR
Teleporte:CreateButton({
   Name = "Salvar Posição 1",
   Callback = function()
      pos1 = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
   end
})

Teleporte:CreateButton({
   Name = "Teleportar Posição 1",
   Callback = function()
      if pos1 then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos1
      end
   end
})

Teleporte:CreateButton({
   Name = "Salvar Posição 2",
   Callback = function()
      pos2 = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
   end
})

Teleporte:CreateButton({
   Name = "Teleportar Posição 2",
   Callback = function()
      if pos2 then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos2
      end
   end
})

--// TELEPORTAR PARA PLAYER
Teleporte:CreateInput({
   Name = "Nome do Player",
   PlaceholderText = "Digite o nome",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G.playerTP = Text
   end
})

Teleporte:CreateButton({
   Name = "Ir para Player",
   Callback = function()
      for _,v in pairs(game.Players:GetPlayers()) do
         if string.lower(v.Name):find(string.lower(_G.playerTP)) then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
         end
      end
   end
})

--// ESP PLAYERS
Visual:CreateToggle({
   Name = "ESP Players",
   CurrentValue = false,
   Callback = function(Value)
      for _,v in pairs(game.Players:GetPlayers()) do
         if v ~= game.Players.LocalPlayer and v.Character then
            if Value then
               local hl = Instance.new("Highlight")
               hl.Parent = v.Character
               hl.FillColor = Color3.fromRGB(255,255,255)
               hl.OutlineColor = Color3.fromRGB(0,0,0)
            else
               if v.Character:FindFirstChild("Highlight") then
                  v.Character.Highlight:Destroy()
               end
            end
         end
      end
   end
})

--// HITBOX EXPANDER
Visual:CreateToggle({
   Name = "Hitbox Expander",
   CurrentValue = false,
   Callback = function(Value)
      for _,v in pairs(game.Players:GetPlayers()) do
         if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if Value then
               v.Character.HumanoidRootPart.Size = Vector3.new(10,10,10)
               v.Character.HumanoidRootPart.Transparency = 0.7
               v.Character.HumanoidRootPart.CanCollide = false
            else
               v.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
               v.Character.HumanoidRootPart.Transparency = 1
            end
         end
      end
   end
})

--// CAMERA FREEZE
Visual:CreateToggle({
   Name = "Camera Freeze",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
      else
         workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
      end
   end
})

--// FREE CAMERA
Visual:CreateButton({
   Name = "Free Camera",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Roblox/Core-Scripts/master/CoreScriptsRoot/Modules/Server/FreeCamera.lua"))()
   end
})