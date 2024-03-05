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

local Camlock = false
local AutoCamPrediction = false
local CamPrediction = false
local CamPred = 0.148
local CamPart = "UpperTorso"

local Aimlock = false
local AutoAimPrediction = false
local AimPrediction = false
local AimPred = 0.148
local AimPart = "UpperTorso" 

local AntiAimKey = "V"
local AntiAim = false
local AntiXValue = 0
local AntiYValue = 0 
local AntiZValue = 0
local AntiAimPre = "Custom Velocity" --[[ Sky, Ground, Custom, Mouse]]

local Speed = false
local SpeedKey = "LeftShift"
local SpeedAmount = 4

local NoClip = false
local NoClipKey = "N"

local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()
local CurrentCamera = workspace.CurrentCamera

local SilentAim = false
local SilentAimKey = "P"

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


game.RunService.Heartbeat:Connect(function()
    if AutoAimPrediction and AimPrediction then
        pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        split = string.split(pingvalue, " ")
        ping = split[1]
        if tonumber(ping) > 200 and tonumber(ping) < 300 then 
            AimPred = 0.18742
            Options.APrediction:SetValue(AimPred)
        elseif tonumber(ping) > 180 and tonumber(ping) < 195 then 
            AimPred = 0.16779123
            Options.APrediction:SetValue(AimPred)
        elseif tonumber(ping) > 140 and tonumber(ping) < 180 then 
            AimPred = 0.16
            Options.APrediction:SetValue(AimPred)
        elseif tonumber(ping) > 110 and tonumber(ping) < 140 then 
            AimPred = 0.15934
            Options.APrediction:SetValue(AimPred)
        elseif tonumber(ping) < 105 then
            AimPred = 0.138
            Options.APrediction:SetValue(AimPred)
        elseif tonumber(ping) < 90 then
            AimPred = 0.136
            Options.APrediction:SetValue(AimPred)
        elseif tonumber(ping) < 80 then
            AimPred = 0.134
            Options.APrediction:SetValue(AimPred)
        elseif tonumber(ping) < 70 then
            AimPred = 0.131
            Options.APrediction:SetValue(AimPred)
        elseif tonumber(ping) < 60 then
            AimPred = 0.1229
            Options.APrediction:SetValue(AimPred)
        elseif tonumber(ping) < 50 then
            AimPred = 0.1225
            Options.APrediction:SetValue(AimPred)
        elseif tonumber(ping) < 40 then
            AimPred = 0.1256
            Options.APrediction:SetValue(AimPred)
        end
    end
    if AutoCamPrediction and CamPrediction then
        pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        split = string.split(pingvalue, " ")
        ping = split[1]
        if tonumber(ping) > 200 and tonumber(ping) < 300 then 
            CamPred = 0.18742
            Options.CPrediction:SetValue(CamPred)
        elseif tonumber(ping) > 180 and tonumber(ping) < 195 then 
            CamPred = 0.16779123
            Options.CPrediction:SetValue(CamPred)
        elseif tonumber(ping) > 140 and tonumber(ping) < 180 then 
            CamPred = 0.16
            Options.CPrediction:SetValue(CamPred)
        elseif tonumber(ping) > 110 and tonumber(ping) < 140 then 
            CamPred = 0.15934
            Options.CPrediction:SetValue(CamPred)
        elseif tonumber(ping) < 105 then
            CamPred = 0.138
            Options.CPrediction:SetValue(CamPred)
        elseif tonumber(ping) < 90 then
            CamPred = 0.136
            Options.CPrediction:SetValue(CamPred)
        elseif tonumber(ping) < 80 then
            CamPred = 0.134
            Options.CPrediction:SetValue(CamPred)
        elseif tonumber(ping) < 70 then
            CamPred = 0.131
            Options.CPrediction:SetValue(CamPred)
        elseif tonumber(ping) < 60 then
            CamPred = 0.1229
            Options.CPrediction:SetValue(CamPred)
        elseif tonumber(ping) < 50 then
            CamPred = 0.1225
            Options.CPrediction:SetValue(CamPred)
        elseif tonumber(ping) < 40 then
            CamPred = 0.1256
            Options.CPrediction:SetValue(CamPred)
        end
    end
    if Target ~= nil then
        local TargetPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * AimPred))
        local TargetPosition2, onScreeen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position)
        if onScreen then
            Dot.Visible = true
            if CamPrediction or AimPrediction then
                Dot.Position = Vector2.new(TargetPosition.X, TargetPosition.Y)
                HitBox.CFrame = CFrame.new(Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * AimPred))
            else
                Dot.Position = Vector2.new(TargetPosition2.X, TargetPosition2.Y)
                HitBox.CFrame = CFrame.new(Target.Character[AimPart].Position)
            end
        else
            Dot.Visible = false
            HitBox.CFrame = CFrame.new(0, -9999, 0)
        end
    else
        Dot.Visible = false
        HitBox.CFrame = CFrame.new(0, -9999, 0)
    end
    if Target ~= nil and Camlock then
        if CamPrediction then
            CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, Target.Character[CamPart].Position + (Target.Character[CamPart].Velocity * CamPred))
        else
            CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, Target.Character[CamPart].Position)
        end
    end
    if NoClip then
        game.RunService.RenderStepped:Wait()
        for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do 
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
    if AntiAim then
        OldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        if AntiAimPre == "Sky" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 9999, 0)
        --[[elseif AntiAimPre == "Mouse" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(game.Players.LocalPlayer:GetMouse().UnitRay.Origin.X, game.Players.LocalPlayer:GetMouse().UnitRay.Origin.Y, game.Players.LocalPlayer:GetMouse().UnitRay.Origin.Z)]]
        elseif AntiAimPre == "Underground" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, -9999, 0)
        elseif AntiAimPre == "Custom Velocity" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(AntiXValue, AntiYValue, AntiZValue)
        end
        game.RunService.RenderStepped:Wait()
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



local AimlockTab = Tabs.Main:AddRightTabbox("Aimlock")
local AimTab = AimlockTab:AddTab('Aimlock')
local CamTab = AimlockTab:AddTab('Camlock')
AimTab:AddToggle('ToggleAimlock', {
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

AimTab:AddToggle('ToggleAPrediction', {
    Text = 'Prediction',
    Default = AimPrediction,
})
Toggles.ToggleAPrediction:OnChanged(function()
    AimPrediction = Toggles.ToggleAPrediction.Value
end)

CamTab:AddToggle('ToggleCamlock', {
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

AimTab:AddToggle('ToggleAutoPred', {
    Text = 'Auto Prediction',
    Default = AutoPrediction,
})
Toggles.ToggleAutoPred:OnChanged(function()
    AutoAimPrediction = Toggles.ToggleAutoPred.Value
end)
AimTab:AddSlider('APrediction', {
    Text = 'Aimlock Prediction',

    Default = AimPred,
    Min = 0,
    Max = 1,
    Rounding = 3,

    Compact = false
})
Options.APrediction:OnChanged(function()
    AimPred = Options.APrediction.Value
end)

AimTab:AddDropdown('APartSel', {
    Values = {'Head', 'UpperTorso', 'LowerTorso', 'HumanoidRootPart'},
    Default = AimPart,
    Multi = false, 

    Text = 'Aim Part',

})
Options.APartSel:OnChanged(function()
    AimPart = Options.APartSel.Value
end)


CamTab:AddToggle('ToggleCPrediction', {
    Text = 'Prediction',
    Default = CamPrediction,
})
Toggles.ToggleCPrediction:OnChanged(function()
    CamPrediction = Toggles.ToggleCPrediction.Value
end)
CamTab:AddToggle('ToggleCAutoPred', {
    Text = 'Auto Prediction',
    Default = AutoCamPrediction,
})
Toggles.ToggleCAutoPred:OnChanged(function()
    AutoCamPrediction = Toggles.ToggleCAutoPred.Value
end)
CamTab:AddSlider('CPrediction', {
    Text = 'Camlock Prediction',

    Default = CamPred,
    Min = 0,
    Max = 1,
    Rounding = 3,

    Compact = false
})
Options.CPrediction:OnChanged(function()
    CamPred = Options.CPrediction.Value
end)

CamTab:AddDropdown('CPartSel', {
    Values = {'Head', 'UpperTorso', 'LowerTorso', 'HumanoidRootPart'},
    Default = CamPart,
    Multi = false, 

    Text = 'Cam Part',

})
Options.CPartSel:OnChanged(function()
    CamPart = Options.CPartSel.Value
end)

local SilentAimTab = Tabs.Main:AddRightTabbox("Silent Aim")
local SilentAim = SilentAimTab:AddTab('Silent Aim')
SilentAim:AddToggle('ToggleSilent', {
    Text = 'Silent Aim',
    Default = SilentAim,
}):AddKeyPicker('SilentAimKey', {

    Default = SilentAimKey,
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'Silent Aim',
    NoUI = false, 
})
Toggles.ToggleSilent:OnChanged(function()
    SilentAim = Toggles.ToggleSilent.Value
end)


local CharTab = Tabs.Main:AddLeftTabbox("Character")
local Char = CharTab:AddTab('Character')
Char:AddToggle('ToggleNoclip', {
    Text = 'NoClip',
    Default = NoClip,
}):AddKeyPicker('NoClipKey', {

    Default = NoClipKey,
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'NoClip',
    NoUI = false, 
})
Toggles.ToggleNoclip:OnChanged(function()
    NoClip = Toggles.ToggleNoclip.Value
end)

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

Char:AddSlider('SpeedValue', {
    Text = 'SprintSpeed',

    Default = SpeedAmount,
    Min = 0,
    Max = 10,
    Rounding = 1,

    Compact = false
})
Options.SpeedValue:OnChanged(function()
    SpeedAmount = Options.SpeedValue.Value
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
Toggles.ToggleAntiAim:OnChanged(function()
    AntiAim = Toggles.ToggleAntiAim.Value
end)

Char:AddDropdown('AntiAimPreset', {
    Values = {'Sky', 'Shake', --[['Mouse',]] 'Underground', 'Custom Velocity'},
    Default = AntiAimPre,
    Multi = false, 

    Text = 'Anti Aim Preset',

})
Options.AntiAimPreset:OnChanged(function()
    AntiAimPre = Options.AntiAimPreset.Value
end)

Char:AddSlider('AntiXValue', {
    Text = 'X Velocity',

    Default = AntiXValue,
    Min = -9999,
    Max = 9999,
    Rounding = 1,

    Compact = false
})
Options.AntiXValue:OnChanged(function()
    AntiXValue = Options.AntiXValue.Value
end)
Char:AddSlider('AntiYValue', {
    Text = 'Y Velocity',

    Default = AntiYValue,
    Min = -9999,
    Max = 9999,
    Rounding = 1,

    Compact = false
})
Options.AntiYValue:OnChanged(function()
    AntiYValue = Options.AntiYValue.Value
end)
Char:AddSlider('AntiZValue', {
    Text = 'Z Velocity',

    Default = AntiZValue,
    Min = -9999,
    Max = 9999,
    Rounding = 1,

    Compact = false
})
Options.AntiZValue:OnChanged(function()
    AntiZValue = Options.AntiZValue.Value
end)


AimTab:AddButton('Rejoin', function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)


local Old; Old = hookmetamethod(game, "__namecall", function(...)
    local args = { ... }
    local method = getnamecallmethod()
    
    if Target ~= nil and method == "FireServer" then
        if args[2] == "MousePos" or args[2] == "UpdateMousePos" or args[2] == "Mouse" then 
            args[3] = Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * AimPred)
            return Old(unpack(args))
        end
    end
    
    return Old(...)
end)
