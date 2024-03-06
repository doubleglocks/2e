--[[

    To do:
        - Character Visuals
        - Target Visuals
        - Game Visuals
        - Silent aim
        - Fake macro
        - Anti Stomp
        - Anti Bag
        - Target Strafe
        - Autoshoot/Triggerbot

        - Resolver
        - Keybinds

        - Client visuals
        - Bloom
        - Color Correction
        - Tint Color
        - Sky box
        - Fog color
        

    Bugs:
        - None as of 06/5/24 [ March 5th 2024 ]

]]








local Target = nil
local TargetKey = "Q"
local AimlockKey = ""
local CamlockKey = ""

local Spinbot = false

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

local Desync = false
local AntiAimKey = ""
local AntiAim = false
local AntiXValue = 0
local AntiYValue = 0 
local AntiZValue = 0
local AntiAimPre = "Custom Velocity" --[[ Sky, Ground, Custom, Mouse]]

local Speed = false
local SpeedKey = "LeftShift"
local SpeedAmount = 4

local NoClip = false
local NoClipKey = "X"

local Flying = false
local FlyKey = "F"
local Flyspeed = 4

-- local AntiStomp = true

local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()
local CurrentCamera = workspace.CurrentCamera

local SilentAim = false
local SAiming = false
local SilentAimKey = "P"

local AKnockedCheck = true
local AGrabbedCheck = true
local CKnockedCheck = true
local CGrabbedCheck = true
--local Triggerbot = false

local Strafe = false
local StrafeXAngle = 0
local StrafeSpeed = 5
local StrafeDistance = 8

local BodyTrail = false
local TrailColor = Color3.fromRGB(0, 255, 0)

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
--[[local FovCircle = Drawing.new("Circle")
FovCircle.Visible = true
FovCircle.Filled = false
FovCircle.Thickness = 1
FovCircle.Transparency = 1
FovCircle.Color = Color3.new(0, 1, 0)
FovCircle.Radius = 100
FovCircle.Position = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)]]


local NotifyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))()

local function TargetChecks(Player)
    if AKnockedCheck or CKnockedCheck then
        if Player.Character.BodyEffects["K.O"].Value then
            return false
        end
    end
    if AGrabbedCheck or CGrabbedCheck then
        if Player.Character.BodyEffects["Grabbed"].Value then
            return false
        end
    end
    return true
end

local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and TargetChecks(v) then
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

local function fly()
    local BodyPosition = Instance.new("BodyPosition", game.Players.LocalPlayer.Character:FindFirstChild("Head"))
    local BodyGyro = Instance.new("BodyGyro", game.Players.LocalPlayer.Character:FindFirstChild("Head"))
    BodyPosition.maxForce = Vector3.new(math.huge, math.huge, math.huge)
    BodyPosition.position = game.Players.LocalPlayer.Character:FindFirstChild("Head").Position
    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.CFrame = game.Players.LocalPlayer.Character:FindFirstChild("Head").CFrame
    repeat
        wait()
        game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
        local New = BodyGyro.CFrame - BodyGyro.CFrame.p + BodyPosition.position
        if game:GetService("UserInputService"):IsKeyDown("W") then
            New = New + CurrentCamera.CoordinateFrame.lookVector * Flyspeed
            BodyGyro.CFrame = CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad(Flyspeed * 0), 0, 0)
        end
        if game:GetService("UserInputService"):IsKeyDown("S") then
            New = New - CurrentCamera.CoordinateFrame.lookVector * Flyspeed
            BodyGyro.CFrame = CurrentCamera.CoordinateFrame * CFrame.Angles(math.rad(Flyspeed * 0), 0, 0)
        end
        if game:GetService("UserInputService"):IsKeyDown("D") then
            New = New * CFrame.new(Flyspeed, 0, 0)
            BodyGyro.CFrame = CurrentCamera.CoordinateFrame
        end
        if game:GetService("UserInputService"):IsKeyDown("A") then
            New = New * CFrame.new(-Flyspeed, 0, 0)
            BodyGyro.CFrame = CurrentCamera.CoordinateFrame
        end
        BodyPosition.Position = New.p
    until not Flying
    Flying = not Flying
    BodyGyro:Destroy()
    BodyPosition:Destroy()
    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
end

game.Players.PlayerRemoving:Connect(function(player)
    if player.Name == tostring(Target) then
        Target = nil
        Notify("Target Left", '['..player.Name..'] Has left the server', 3)
    end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/doubleglocks/LinoriaLib/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "streaming",
    Center = true, 
    AutoShow = true,
})
local Tabs = {
    Main = Window:AddTab('Combat'), 
}


spawn(function()
    while true do
        -- BodyTrail logic
        if BodyTrail and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.Archivable = true
            local clone = game.Players.LocalPlayer.Character:Clone()
            for _, v in pairs(clone:GetDescendants()) do    
                if v.Name == "HumanoidRootPart" or v:IsA("Humanoid") or v:IsA("LocalScript") or v:IsA("Script") or v:IsA("Decal") then
                    v:Destroy()
                elseif v:IsA("BasePart") or v:IsA("Meshpart") or v:IsA("Part") then
                    if v.Transparency == 1 then
                        v:Destroy()
                    else
                        v.CanCollide = false
                        v.Anchored = true
                        v.Material = Enum.Material.Neon
                        v.Color = TrailColor
                    end
                end
            end
            clone.Parent = game.Workspace
            wait(0.8)
            clone:Destroy()
        end
        
        -- Spin bot logic
        if Spinbot and game.Players.LocalPlayer.Character then
            local character = game.Players.LocalPlayer.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(1000), 0)
            end
        end

        -- AutoAimPrediction logic
        if AutoAimPrediction then
            local ping = tonumber((game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString() or ""):split(" ")[1])
            if ping then
                if ping > 200 and ping < 300 then 
                    AimPred = 0.18742
                    Options.APrediction:SetValue(AimPred)
                elseif ping > 180 and ping < 195 then 
                    AimPred = 0.16779123
                    Options.APrediction:SetValue(AimPred)
                elseif ping > 140 and ping < 180 then 
                    AimPred = 0.16
                    Options.APrediction:SetValue(AimPred)
                elseif ping > 110 and ping < 140 then 
                    AimPred = 0.15934
                    Options.APrediction:SetValue(AimPred)
                elseif ping < 105 then
                    AimPred = 0.138
                    Options.APrediction:SetValue(AimPred)
                elseif ping < 90 then
                    AimPred = 0.136
                    Options.APrediction:SetValue(AimPred)
                elseif ping < 80 then
                    AimPred = 0.134
                    Options.APrediction:SetValue(AimPred)
                elseif ping < 70 then
                    AimPred = 0.131
                    Options.APrediction:SetValue(AimPred)
                elseif ping < 60 then
                    AimPred = 0.1229
                    Options.APrediction:SetValue(AimPred)
                elseif ping < 50 then
                    AimPred = 0.1225
                    Options.APrediction:SetValue(AimPred)
                elseif ping < 40 then
                    AimPred = 0.1256
                    Options.APrediction:SetValue(AimPred)
                end
            end
        end

        -- AutoCamPrediction logic
        if AutoCamPrediction then
            local ping = tonumber((game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString() or ""):split(" ")[1])
            if ping then
                if ping > 200 and ping < 300 then 
                    CamPred = 0.18742
                    Options.CPrediction:SetValue(CamPred)
                elseif ping > 180 and ping < 195 then 
                    CamPred = 0.16779123
                    Options.CPrediction:SetValue(CamPred)
                elseif ping > 140 and ping < 180 then 
                    CamPred = 0.16
                    Options.CPrediction:SetValue(CamPred)
                elseif ping > 110 and ping < 140 then 
                    CamPred = 0.15934
                    Options.CPrediction:SetValue(CamPred)
                elseif ping < 105 then
                    CamPred = 0.138
                    Options.CPrediction:SetValue(CamPred)
                elseif ping < 90 then
                    CamPred = 0.136
                    Options.CPrediction:SetValue(CamPred)
                elseif ping < 80 then
                    CamPred = 0.134
                    Options.CPrediction:SetValue(CamPred)
                elseif ping < 70 then
                    CamPred = 0.131
                    Options.CPrediction:SetValue(CamPred)
                elseif ping < 60 then
                    CamPred = 0.1229
                    Options.CPrediction:SetValue(CamPred)
                elseif ping < 50 then
                    CamPred = 0.1225
                    Options.CPrediction:SetValue(CamPred)
                elseif ping < 40 then
                    CamPred = 0.1256
                    Options.CPrediction:SetValue(CamPred)
                end
            end
        end

        -- NoClip logic
        if NoClip then
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do 
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end

        wait()
    end
end)

game.RunService.Heartbeat:Connect(function()
    -- Strafe logic
    if Strafe and Target and Target.Character and Target.Character.HumanoidRootPart then
        StrafeXAngle = StrafeXAngle + StrafeSpeed
        game.workspace.CurrentCamera.CameraSubject = Target.Character
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.Angles(0, StrafeXAngle, 0) * CFrame.new(0, 0, StrafeDistance)
    else
        game.workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
    end
    
    -- Targeting logic
    if Target ~= nil and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
        local TargetPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * AimPred))
        local TargetPosition2, onScreeen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position)
        if onScreen and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
            Dot.Visible = true
            if CamPrediction or AimPrediction or AutoAimPrediction or AutoCamPrediction then
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

    -- Camera logic
    if Target ~= nil and Camlock and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
        if CamPrediction then
            CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, Target.Character[CamPart].Position + (Target.Character[CamPart].Velocity * CamPred))
        else
            CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, Target.Character[CamPart].Position)
        end
    end

    -- Desync Logic
    if Desync and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local OldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, -1, 0) * (2^16)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, 0.0001, 0)
        game.RunService.RenderStepped:Wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = OldVelocity
    end 
    -- Anti-aim logic
    if AntiAim and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local OldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        if AntiAimPre == "Sky" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 9999, 0)
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
    if Key.KeyCode == Enum.KeyCode[TargetKey] then
        if Target ~= nil then 
            Target = nil
        else
            Target = GetClosestPlayer()
            Notify("New Target", 'Locked on to ['..tostring(Target)..']', 3)
        end
    end
    if Key.KeyCode == Enum.KeyCode[Options.SpeedKey.Value] then
        if Speed then
            repeat
                if game:GetService("UserInputService"):IsKeyDown("W") or game:GetService("UserInputService"):IsKeyDown("A") or game:GetService("UserInputService"):IsKeyDown("S") or game:GetService("UserInputService"):IsKeyDown("D")then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * SpeedAmount
                end
                game:GetService("RunService").Heartbeat:wait()
            until not game:GetService("UserInputService"):IsKeyDown(Options.SpeedKey.Value)
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

AimTab:AddToggle('ToggleAKnockedCheck', {
    Text = 'Knocked Check',
    Default = AKnockedCheck,
})
Toggles.ToggleAKnockedCheck:OnChanged(function()
    AKnockedCheck = Toggles.ToggleAKnockedCheck.Value
end)
AimTab:AddToggle('ToggleAGrabbedCheck', {
    Text = 'Knocked Check',
    Default = AGrabbedCheck,
})
Toggles.ToggleAGrabbedCheck:OnChanged(function()
    AGrabbedCheck = Toggles.ToggleAGrabbedCheck.Value
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

CamTab:AddToggle('ToggleCKnockedCheck', {
    Text = 'Knocked Check',
    Default = CKnockedCheck,
})
Toggles.ToggleCKnockedCheck:OnChanged(function()
    CKnockedCheck = Toggles.ToggleCKnockedCheck.Value
end)
CamTab:AddToggle('ToggleCGrabbedCheck', {
    Text = 'Knocked Check',
    Default = CGrabbedCheck,
})
Toggles.ToggleCGrabbedCheck:OnChanged(function()
    CGrabbedCheck = Toggles.ToggleCGrabbedCheck.Value
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

SilentAim:AddToggle('ToggleFovFill', {
    Text = 'FOV Filled',
    Default = false,
})

SilentAim:AddToggle('ToggleKnockedC', {
    Text = 'Knocked Check',
    Default = false,
})

SilentAim:AddToggle('ToggleGrabbedC', {
    Text = 'Grabbed Check',
    Default = false,
})

SilentAim:AddSlider('SilentAimFOV', {
    Text = 'FOV Size',

    Default = 100,
    Min = 10,
    Max = 1000,
    Rounding = 1,

    Compact = false
})


local CharTab = Tabs.Main:AddLeftTabbox("Character")
local Char = CharTab:AddTab('Character')
Char:AddToggle('ToggleFly', {
    Text = 'Fly',
    Default = Flying,
}):AddKeyPicker('FlyKey', {

    Default = FlyKey,
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'Fly',
    NoUI = false, 
})
Toggles.ToggleFly:OnChanged(function()
    Flying = Toggles.ToggleFly.Value
    if Flying then
        fly()
    end
end)
Char:AddSlider('Flyspeed', {
    Text = 'Fly Speed',

    Default = Flyspeed,
    Min = 1,
    Max = 15,
    Rounding = 1,

    Compact = false
})
Options.Flyspeed:OnChanged(function()
    Flyspeed = Options.Flyspeed.Value
end)
Char:AddToggle('ToggleSpinbot', {
    Text = 'Spin Bot',
    Default = Spinbot,
})
Toggles.ToggleSpinbot:OnChanged(function()
    Spinbot = Toggles.ToggleSpinbot.Value
end)
Char:AddToggle('ToggleStrafe', {
    Text = 'Strafe',
    Default = Strafe,
})
Toggles.ToggleStrafe:OnChanged(function()
    Strafe = Toggles.ToggleStrafe.Value
end)
Char:AddSlider('StrafeSpeed', {
    Text = 'Strafe Speed',

    Default = StrafeSpeed,
    Min = 1,
    Max = 25,
    Rounding = 1,

    Compact = false
})
Options.StrafeSpeed:OnChanged(function()
    StrafeSpeed = Options.StrafeSpeed.Value
end)
Char:AddSlider('StrafeDistance', {
    Text = 'Strafe Distance',

    Default = StrafeSpeed,
    Min = 1,
    Max = 25,
    Rounding = 1,

    Compact = false
})
Options.StrafeDistance:OnChanged(function()
    StrafeDistance = Options.StrafeDistance.Value
end)


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

    Text = 'Sprint Speed',
    NoUI = false, 
})
Toggles.ToggleSpeed:OnChanged(function()
    Speed = Toggles.ToggleSpeed.Value
end)

Char:AddSlider('SpeedValue', {
    Text = 'Sprint Speed',

    Default = SpeedAmount,
    Min = 0,
    Max = 10,
    Rounding = 1,

    Compact = false
})
Options.SpeedValue:OnChanged(function()
    SpeedAmount = Options.SpeedValue.Value
end)

local AAT = CharTab:AddTab('Anti-Aim')
AAT:AddToggle('ToggleDesync', {
    Text = 'Desync',
    Default = Desync,
})
Toggles.ToggleDesync:OnChanged(function()
    Desync = Toggles.ToggleDesync.Value
end)
AAT:AddToggle('ToggleAntiAim', {
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

AAT:AddDropdown('AntiAimPreset', {
    Values = {'Sky', 'Shake', --[['Mouse',]] 'Underground', 'Custom Velocity'},
    Default = AntiAimPre,
    Multi = false, 

    Text = 'Anti Aim Preset',

})
Options.AntiAimPreset:OnChanged(function()
    AntiAimPre = Options.AntiAimPreset.Value
end)

AAT:AddSlider('AntiXValue', {
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
AAT:AddSlider('AntiYValue', {
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
AAT:AddSlider('AntiZValue', {
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

local ClientTab = Tabs.Main:AddLeftTabbox("Client")
local ClientT = ClientTab:AddTab('Client')
ClientT:AddToggle("ShowChat", {
    Text = "Show Chat", 
    Default = false
})
Toggles.ShowChat:OnChanged(function()
    game.Players.LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = Toggles.ShowChat.Value
end)
ClientT:AddToggle('ToggleBodyTrail', {
    Text = 'Body Trail',
    Default = false,
}):AddColorPicker('TrailColor', {
    Default = TrailColor,
    Title = 'Player Trail Color',
})
Toggles.ToggleBodyTrail:OnChanged(function()
    BodyTrail = Toggles.ToggleBodyTrail.Value
end)
ClientT:AddToggle("ToggleWatermark", {
    Text = "Show Watermark", 
    Default = false
})
ClientT:AddToggle("ToggleBindsMenu", {
    Text = "Show Keybinds Menu", 
    Default = false
})
Toggles.ToggleBindsMenu:OnChanged(function()
    Library.KeybindFrame.Visible = Toggles.ToggleBindsMenu.Value
end)
ClientT:AddSlider("FieldOfView", {
    Text = "Field Of View", 
    Default = 70, 
    Min = 70, 
    Max = 120, 
    Rounding = 0
})
Options.FieldOfView:OnChanged(function()
    game.workspace.CurrentCamera.FieldOfView = Options.FieldOfView.Value
end)




ClientT:AddButton('Rejoin', function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)


local Old; Old = hookmetamethod(game, "__namecall", function(self, ...)
    local args = { ... }
    local method = getnamecallmethod()
    
    if method == "FireServer" then
        if args[1] == "MousePos" or args[1] == "UpdateMousePos" or args[1] == "Mouse" then 
            if Target ~= nil and Aimlock then
                args[2] = Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * AimPred)
                return Old(self, unpack(args))
            end
        end
    end

    return Old(self, ...)
end)
