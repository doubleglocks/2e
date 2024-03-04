--[[

    to do:
        silent aim
        fake macro
        speed

        desync
        resolver
        keybinds



]]








local Target = nil
local TargetKey = "Q"
local AimlockKey = "C"
local CamlockKey = "X"
local SpeedKey = "Z"

local Aimlock = false
local Camlock = false
local Pred = 0.148
local AimPart = "UpperTorso"

local AntiAimKey = "V"
local AntiAim = false
local AntiXValue = 0
local AntiYValue = -9999 
local AntiZValue = 0

local Speed = false
local SpeedKey = "LeftShift"
local SpeedAmount = 4

local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()
local CurrentCamera = workspace.CurrentCamera


local Dot = Drawing.new("Circle")
Dot.Radius = 5
Dot.Filled = true
Dot.Thickness = 2
Dot.Visible = false
Dot.Transparency = 1
Dot.Color = Color3.fromRGB(102, 160, 222)
local HitBox = Instance.new("Part", workspace)
HitBox.Shape = Enum.PartType.Block
HitBox.CanCollide = false
HitBox.Material = "Neon"
HitBox.Color = Color3.fromRGB(102, 160, 222)
HitBox.Size = Vector3.new(5.5, 5.5, 5.5)
HitBox.Transparency = 0.5
local NotifyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))()

local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y + 36)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

local function Notify(title, text, time)
    NotifyLibrary.Notify({
        Title = title;
        Description = text;
        Duration = time;
    })
end

game.RunService.Heartbeat:Connect(function()
    if Target ~= nil then
        local TargetPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * Pred))
        if onScreen then
            Dot.Visible = true
            Dot.Position = Vector2.new(TargetPosition.X, TargetPosition.Y)
            HitBox.CFrame = CFrame.new(Target.Character.HumanoidRootPart.Position)
        else
            Dot.Visible = false
            HitBox.CFrame = CFrame.new(0, -9999, 0)
        end
    else
        Dot.Visible = false
        HitBox.CFrame = CFrame.new(0, -9999, 0)
    end
    if Target ~= nil and Camlock ~= false then
        CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * Pred))
    end
    if AntiAim then
        OldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(AntiXValue, AntiYValue, AntiZValue)
        game.RunService.Heartbeat:Wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = OldVelocity
    end
end)
        


game:GetService("UserInputService").InputBegan:Connect(function(Key, Typing)
    if Typing then return end
    --[[if Key.KeyCode == Enum.KeyCode[AimlockKey] then
        Aimlock = not Aimlock
        Toggles.ToggleAimlock:SetValue(Aimlock)
    end
    if Key.KeyCode == Enum.KeyCode[CamlockKey] then
        Camlock = not Camlock
        Toggles.ToggleCamlock:SetValue(Camlock)
    end]]
    if Key.KeyCode == Enum.KeyCode[TargetKey] then
        if Target ~= nil then 
            Target = nil
        else
            Target = GetClosestPlayer()
        end
    end
    if Key.KeyCode == Enum.KeyCode[SpeedKey] then
        if Speed then
            repeat
                if game:GetService("UserInputService"):IsKeyDown("W") or game:GetService("UserInputService"):IsKeyDown("A") or game:GetService("UserInputService"):IsKeyDown("S") or game:GetService("UserInputService"):IsKeyDown("D")then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * SpeedAmount
                end
                game:GetService("RunService").Heartbeat:wait()
            until not game:GetService("UserInputService"):IsKeyDown("LeftShift")
        end
    end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/doubleglocks/LinoriaLib/main/Library.lua"))()
Library.KeybindFrame.Visible = true

local Window = Library:CreateWindow({
    Title = "streaming",
    Center = true, 
    AutoShow = true,
})
local Tabs = {
    Main = Window:AddTab('Combat'), 
}

local CombatTab = Tabs.Main:AddLeftTabbox("Combat")
local Combat = CombatTab:AddTab('Combat')

Combat:AddToggle('ToggleAimlock', {
    Text = 'Aimlock',
    Default = Aimlock,
}):AddKeyPicker('AimlockKey', {

    Default = AimlockKey,
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'Aimlock',
    NoUI = false, 
})
Toggles.ToggleAimlock:OnChanged(function()
    Aimlock = Toggles.ToggleAimlock.Value
end)

Combat:AddToggle('ToggleCamlock', {
    Text = 'Camlock',
    Default = Camlock,
}):AddKeyPicker('CamlockKey', {

    Default = CamlockKey,
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'Camlock',
    NoUI = false, 
})
Toggles.ToggleCamlock:OnChanged(function()
    Camlock = Toggles.ToggleCamlock.Value
end)



local CharTab = Tabs.Main:AddLeftTabbox("Character")
local Char = CombatTab:AddTab('Character')
Char:AddToggle('ToggleSpeed', {
    Text = 'Speed',
    Default = Speed,
}):AddKeyPicker('SpeedKey', {

    Default = SpeedKey,
    SyncToggleState = true, 

    Mode = 'Hold',

    Text = 'Speed',
    NoUI = false, 
})
Toggles.ToggleSpeed:OnChanged(function()
    Speed = Toggles.ToggleSpeed.Value
end)

Char:AddToggle('ToggleAntiAim', {
    Text = 'Anti Aim',
    Default = AntiAim,
}):AddKeyPicker('AntiAimKey', {

    Default = AntiAimKey,
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'Anti Aim',
    NoUI = false, 
})
Options.AntiAimKey:OnClick(function()
    AntiAim = Options.AntiAimKey.Value
end)

Toggles.ToggleAntiAim:OnChanged(function()
    AntiAim = Toggles.ToggleAntiAim.Value
end)

Char:AddSlider('AntiXValue', {
    Text = 'X Value',

    Default = AntiXValue,
    Min = -9999,
    Max = 9999,
    Rounding = 2,

    Compact = false
})
Options.AntiXValue:OnChanged(function()
    AntiXValue = Options.AntiXValue.Value
end)
Char:AddSlider('AntiYValue', {
    Text = 'Y Value',

    Default = AntiYValue,
    Min = -9999,
    Max = 9999,
    Rounding = 2,

    Compact = false
})
Options.AntiYValue:OnChanged(function()
    AntiYValue = Options.AntiYValue.Value
end)
Char:AddSlider('AntiZValue', {
    Text = 'Z Value',

    Default = AntiZValue,
    Min = -9999,
    Max = 9999,
    Rounding = 2,

    Compact = false
})
Options.AntiZValue:OnChanged(function()
    AntiZValue = Options.AntiZValue.Value
end)

Combat:AddSlider('Prediction', {
    Text = 'Prediction',

    Default = Pred,
    Min = 0,
    Max = 1,
    Rounding = 3,

    Compact = false
})
Options.Prediction:OnChanged(function()
    Pred = Options.Prediction.Value
end)


Combat:AddDropdown('PartSel', {
    Values = {'Head', 'UpperTorso', 'LowerTorso', 'HumanoidRootPart'},
    Default = AimPart,
    Multi = false, 

    Text = 'Aim Part',

})
Options.PartSel:OnChanged(function()
    AimPart = Options.PartSel.Value
end)


Combat:AddButton('Rejoin', function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)


local Old; Old = hookmetamethod(game, "__namecall", function(...)
    local args = { ... }
    local method = getnamecallmethod()
    
    if Target ~= nil and method == "FireServer" then
        if args[2] == "MousePos" or args[2] == "UpdateMousePos" or args[2] == "Mouse" then 
            args[3] = Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * Pred)
            return Old(unpack(args))
        end
    end
    
    return Old(...)
end)
