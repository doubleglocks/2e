local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()
local CurrentCamera = workspace.CurrentCamera
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
local AntiAimPre = "Custom Velocity"

local Speed = false
local SpeedKey = "C"
local SpeedAmount = 4

local NoClip = false
local NoClipKey = ""

local Flying = false
local FlyKey = ""
local Flyspeed = 4

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
local TrailMaterial = "Neon"
local TrailColor = Color3.fromRGB(162, 125, 200)

local CustomBody = false
local BodyMaterial = "ForceField"
local BodyColor = Color3.fromRGB(162, 125, 200)

local LookAt = false

local ShowDot = false
local ShowLine = false
local ShowName = false
local ShowCham = false
local ShowHitBox = false


local AutoArmor = false
local AutoShoot = false


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
local Line = Drawing.new("Line")
Line.Thickness = 2
Line.Transparency = 1
Line.Color = Color3.fromRGB(102, 160, 222)

local Stats = Instance.new('ScreenGui', game:GetService("CoreGui"))
local Frame = Instance.new("Frame", Stats)
local UIListLayout = Instance.new("UIListLayout", Frame)
local ClientStatsLabel = Instance.new("Frame", Stats)
local Index = Instance.new("TextLabel", ClientStatsLabel)
local Stats_Velocity = Instance.new("Frame", Stats)
local Index_2 = Instance.new("TextLabel", Stats_Velocity)
local Value = Instance.new("TextLabel", Stats_Velocity)
local Stats_RotVelocity = Instance.new("Frame", Stats)
local Index_3 = Instance.new("TextLabel", Stats_RotVelocity)
local Value_2 = Instance.new("TextLabel", Stats_RotVelocity)
local Stats_Rotation = Instance.new("Frame", Stats)
local Index_4 = Instance.new("TextLabel", Stats_Rotation)
local Value_3 = Instance.new("TextLabel", Stats_Rotation)
local Stats_Position = Instance.new("Frame", Stats)
local Index_5 = Instance.new("TextLabel", Stats_Position)
local Value_4 = Instance.new("TextLabel", Stats_Position)
Stats.Enabled = false
Stats.Name = "Stats"
Stats.ResetOnSpawn = false
Stats.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = Stats
Frame.AnchorPoint = Vector2.new(1, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.750
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(1, -15, 0.417541236, 0)
Frame.Size = UDim2.new(0, 200, 0, 110)

UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

ClientStatsLabel.Name = "ClientStatsLabel"
ClientStatsLabel.Parent = Frame
ClientStatsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ClientStatsLabel.BackgroundTransparency = 1.000
ClientStatsLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ClientStatsLabel.BorderSizePixel = 0
ClientStatsLabel.Size = UDim2.new(1, 0, 0, 22)

Index.Name = "Index"
Index.Parent = ClientStatsLabel
Index.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Index.BackgroundTransparency = 1.000
Index.BorderColor3 = Color3.fromRGB(0, 0, 0)
Index.BorderSizePixel = 0
Index.Position = UDim2.new(0, 5, 0, 0)
Index.Size = UDim2.new(1, -10, 1, 0)
Index.Font = Enum.Font.Arial
Index.Text = "Server Stats"
Index.TextColor3 = Color3.fromRGB(255, 255, 255)
Index.TextSize = 13.000
Index.TextStrokeTransparency = 0.000

Stats_Velocity.Name = "Stats_Velocity"
Stats_Velocity.Parent = Frame
Stats_Velocity.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Stats_Velocity.BackgroundTransparency = 1.000
Stats_Velocity.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stats_Velocity.BorderSizePixel = 0
Stats_Velocity.Size = UDim2.new(1, 0, 0, 22)

Index_2.Name = "Index"
Index_2.Parent = Stats_Velocity
Index_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Index_2.BackgroundTransparency = 1.000
Index_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Index_2.BorderSizePixel = 0
Index_2.Position = UDim2.new(0, 5, 0, 0)
Index_2.Size = UDim2.new(0.5, -5, 1, 0)
Index_2.Font = Enum.Font.Arial
Index_2.Text = "Velocity"
Index_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Index_2.TextSize = 13.000
Index_2.TextStrokeTransparency = 0.000
Index_2.TextXAlignment = Enum.TextXAlignment.Left

Value.Name = "Value"
Value.Parent = Stats_Velocity
Value.AnchorPoint = Vector2.new(1, 0)
Value.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Value.BackgroundTransparency = 1.000
Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
Value.BorderSizePixel = 0
Value.Position = UDim2.new(1, -5, 0, 0)
Value.Size = UDim2.new(0.5, -5, 1, 0)
Value.Font = Enum.Font.Arial
Value.Text = "0, 0, 0"
Value.TextColor3 = Color3.fromRGB(255, 255, 255)
Value.TextSize = 13.000
Value.TextStrokeTransparency = 0.000
Value.TextXAlignment = Enum.TextXAlignment.Right

Stats_RotVelocity.Name = "Stats_RotVelocity"
Stats_RotVelocity.Parent = Frame
Stats_RotVelocity.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Stats_RotVelocity.BackgroundTransparency = 0.750
Stats_RotVelocity.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stats_RotVelocity.BorderSizePixel = 0
Stats_RotVelocity.Size = UDim2.new(1, 0, 0, 22)

Index_3.Name = "Index"
Index_3.Parent = Stats_RotVelocity
Index_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Index_3.BackgroundTransparency = 1.000
Index_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Index_3.BorderSizePixel = 0
Index_3.Position = UDim2.new(0, 5, 0, 0)
Index_3.Size = UDim2.new(0.5, -5, 1, 0)
Index_3.Font = Enum.Font.Arial
Index_3.Text = "RotVelocity"
Index_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Index_3.TextSize = 13.000
Index_3.TextStrokeTransparency = 0.000
Index_3.TextXAlignment = Enum.TextXAlignment.Left

Value_2.Name = "Value"
Value_2.Parent = Stats_RotVelocity
Value_2.AnchorPoint = Vector2.new(1, 0)
Value_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Value_2.BackgroundTransparency = 1.000
Value_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Value_2.BorderSizePixel = 0
Value_2.Position = UDim2.new(1, -5, 0, 0)
Value_2.Size = UDim2.new(0.5, -5, 1, 0)
Value_2.Font = Enum.Font.Arial
Value_2.Text = "0, 0, 0"
Value_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Value_2.TextSize = 13.000
Value_2.TextStrokeTransparency = 0.000
Value_2.TextXAlignment = Enum.TextXAlignment.Right

Stats_Rotation.Name = "Stats_Rotation"
Stats_Rotation.Parent = Frame
Stats_Rotation.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Stats_Rotation.BackgroundTransparency = 1.000
Stats_Rotation.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stats_Rotation.BorderSizePixel = 0
Stats_Rotation.Size = UDim2.new(1, 0, 0, 22)

Index_4.Name = "Index"
Index_4.Parent = Stats_Rotation
Index_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Index_4.BackgroundTransparency = 1.000
Index_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Index_4.BorderSizePixel = 0
Index_4.Position = UDim2.new(0, 5, 0, 0)
Index_4.Size = UDim2.new(0.5, -5, 1, 0)
Index_4.Font = Enum.Font.Arial
Index_4.Text = "Rotation"
Index_4.TextColor3 = Color3.fromRGB(255, 255, 255)
Index_4.TextSize = 13.000
Index_4.TextStrokeTransparency = 0.000
Index_4.TextXAlignment = Enum.TextXAlignment.Left

Value_3.Name = "Value"
Value_3.Parent = Stats_Rotation
Value_3.AnchorPoint = Vector2.new(1, 0)
Value_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Value_3.BackgroundTransparency = 1.000
Value_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Value_3.BorderSizePixel = 0
Value_3.Position = UDim2.new(1, -5, 0, 0)
Value_3.Size = UDim2.new(0.5, -5, 1, 0)
Value_3.Font = Enum.Font.Arial
Value_3.Text = "0, 0, 0"
Value_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Value_3.TextSize = 13.000
Value_3.TextStrokeTransparency = 0.000
Value_3.TextXAlignment = Enum.TextXAlignment.Right

Stats_Position.Name = "Stats_Position"
Stats_Position.Parent = Frame
Stats_Position.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Stats_Position.BackgroundTransparency = 0.750
Stats_Position.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stats_Position.BorderSizePixel = 0
Stats_Position.Size = UDim2.new(1, 0, 0, 22)

Index_5.Name = "Index"
Index_5.Parent = Stats_Position
Index_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Index_5.BackgroundTransparency = 1.000
Index_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
Index_5.BorderSizePixel = 0
Index_5.Position = UDim2.new(0, 5, 0, 0)
Index_5.Size = UDim2.new(0.5, -5, 1, 0)
Index_5.Font = Enum.Font.Arial
Index_5.Text = "Position"
Index_5.TextColor3 = Color3.fromRGB(255, 255, 255)
Index_5.TextSize = 13.000
Index_5.TextStrokeTransparency = 0.000
Index_5.TextXAlignment = Enum.TextXAlignment.Left

Value_4.Name = "Value"
Value_4.Parent = Stats_Position
Value_4.AnchorPoint = Vector2.new(1, 0)
Value_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Value_4.BackgroundTransparency = 1.000
Value_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Value_4.BorderSizePixel = 0
Value_4.Position = UDim2.new(1, -5, 0, 0)
Value_4.Size = UDim2.new(0.5, -5, 1, 0)
Value_4.Font = Enum.Font.Arial
Value_4.Text = "0, 0, 0"
Value_4.TextColor3 = Color3.fromRGB(255, 255, 255)
Value_4.TextSize = 13.000
Value_4.TextStrokeTransparency = 0.000
Value_4.TextXAlignment = Enum.TextXAlignment.Right

--[[local FovCircle = Drawing.new("Circle")
FovCircle.Visible = true
FovCircle.Filled = false
FovCircle.Thickness = 1
FovCircle.Transparency = 1
FovCircle.Color = Color3.new(0, 1, 0)
FovCircle.Radius = 100
FovCircle.Position = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/doubleglocks/LinoriaLib/main/Library.lua"))()
local NotifyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))()

local function Notify(title, text, time)
    NotifyLibrary.Notify({
        Title = title;
        Description = text;
        Duration = time;
    })
end

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

local function FindPlayer(Name)
    local Inserted = {}
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do 
        if string.lower(string.sub(p.Name, 1, string.len(Name))) == string.lower(Name) or 
           (p.DisplayName and string.lower(string.sub(p.DisplayName, 1, string.len(Name))) == string.lower(Name)) then 
            table.insert(Inserted, p)
            return p
        end
    end
end

local function Teleport(TeleportTarget)
    if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and TeleportTarget then
            local TweenTeleport = game:GetService("TweenService") :Create(
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), 
                TweenInfo.new(
                    0 + 1, 
                    Enum.EasingStyle.Sine, 
                    Enum.EasingDirection.InOut
                ), 
                {CFrame = TeleportTarget}
            )
            TweenTeleport:Play()
        end
    end
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

local Window = Library:CreateWindow({
    Title = "STREAMING.C2EZ | ["..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."]",
    Center = true, 
    AutoShow = true,
})
local Tabs = {
    Main = Window:AddTab('Combat'), 
}
Library:SetWatermark("Streaming.C2EZ | ["..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."]")

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
                        v.Material = TrailMaterial
                        v.Color = TrailColor
                    end
                end
            end
            clone.Parent = game.Workspace
            wait(0.6)
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
                elseif ping > 180 and ping < 195 then 
                    AimPred = 0.16779123
                elseif ping > 140 and ping < 180 then 
                    AimPred = 0.16
                elseif ping > 110 and ping < 140 then 
                    AimPred = 0.15934
                elseif ping < 105 and ping > 90 then
                    AimPred = 0.138
                elseif ping < 90 and ping > 80 then
                    AimPred = 0.136
                elseif ping < 80 and ping > 70 then
                    AimPred = 0.134
                elseif ping < 70 and ping > 60 then
                    AimPred = 0.131
                elseif ping < 60 and ping > 50 then
                    AimPred = 0.1229
                elseif ping < 50 and ping > 40 then
                    AimPred = 0.1225
                elseif ping < 40 then
                    AimPred = 0.1256
                end
                Options.APrediction:SetValue(AimPred)
            end
        end
        
        -- AutoCamPrediction logic
        if AutoCamPrediction then
            local ping = tonumber((game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString() or ""):split(" ")[1])
            if ping then
                if ping > 200 and ping < 300 then 
                    CamPred = 0.18742
                elseif ping > 180 and ping < 195 then 
                    CamPred = 0.16779123
                elseif ping > 140 and ping < 180 then 
                    CamPred = 0.16
                elseif ping > 110 and ping < 140 then 
                    CamPred = 0.15934
                elseif ping < 105 and ping > 90 then
                    CamPred = 0.138
                elseif ping < 90 and ping > 80 then
                    CamPred = 0.136
                elseif ping < 80 and ping > 70 then
                    CamPred = 0.134
                elseif ping < 70 and ping > 60 then
                    CamPred = 0.131
                elseif ping < 60 and ping > 50 then
                    CamPred = 0.1229
                elseif ping < 50 and ping > 40 then
                    CamPred = 0.1225
                elseif ping < 40 then
                    CamPred = 0.1256
                end
                Options.CPrediction:SetValue(CamPred)
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

        -- CustomBody logic
        if CustomBody and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("MeshPart") then
                    v.Material = BodyMaterial
                    --v.Color = BodyColor
                end
            end
        else
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("MeshPart") then
                    v.Material = "Plastic"
                end
            end
        end

        -- Stats logic
        if Stats.Enabled and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            Value.Text = string.format("(%d, %d, %d)", game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity.X, game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity.Z)
            Value_2.Text = string.format("(%d, %d, %d)", game.Players.LocalPlayer.Character.HumanoidRootPart.RotVelocity.X, game.Players.LocalPlayer.Character.HumanoidRootPart.RotVelocity.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.RotVelocity.Z)
            --Value_3.Text = computeRotationalVelocity()
            Value_4.Text = string.format("(%d, %d, %d)", game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z)
        end

        wait()
    end
end)

game.RunService.Heartbeat:Connect(function()
    --// Look At logic
    if LookAt and Target and Target.Character and Target.Character.HumanoidRootPart then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(Target.Character.HumanoidRootPart.Position.X, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position.Y, Target.Character.HumanoidRootPart.Position.Z))  
    end 
    -- Strafe logic
    if Strafe and Target and Target.Character and Target.Character.HumanoidRootPart then
        StrafeXAngle = StrafeXAngle + StrafeSpeed
        game.workspace.CurrentCamera.CameraSubject = Target.Character
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.Angles(0, StrafeXAngle, 0) * CFrame.new(0, 0, StrafeDistance)
    else
        game.workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    end

    -- Camera logic
    if Target ~= nil and Camlock and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
        if CamPrediction or AutoCamPrediction then
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

    -- Show line Logic
    if Showline then
        if Target ~= nil and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
            local TargetPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * AimPred))
            local TargetPosition2, onScreeen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position)
            if onScreeen then
                Line.Visible = true
                if AutoAimPrediction or AutoCamPrediction or CamPrediction or AimPrediction then
                    Line.To = Vector2.new(TargetPosition.X, TargetPosition.Y)
                    Line.From = Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y + 36)
                else
                    Line.To = Vector2.new(TargetPosition2.X, TargetPosition2.Y)
                end
            else
                Line.Visible = false
            end
        else
            Line.Visible = false
        end
    end

    -- Show Dot Logic
    if ShowDot then
        if Target ~= nil and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
            local TargetPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * AimPred))
            local TargetPosition2, onScreeen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position)
            if onScreeen then
                Dot.Visible = true
                if AutoAimPrediction or AutoCamPrediction or CamPrediction or AimPrediction then
                    Dot.Position = Vector2.new(TargetPosition.X, TargetPosition.Y)
                else
                    Dot.Position = Vector2.new(TargetPosition2.X, TargetPosition2.Y)
                end
            else
                Dot.Visible = false
            end
        else
            Dot.Visible = false
        end
    else
        Dot.Visible = false
    end

    -- Show HitBox logic
    if ShowHitBox then
        if Target ~= nil and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
            local TargetPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * AimPred))
            local TargetPosition2, onScreeen = workspace.CurrentCamera:WorldToViewportPoint(Target.Character[AimPart].Position)
            if onScreeen then
                if AutoAimPrediction or AutoCamPrediction or CamPrediction or AimPrediction then
                    HitBox.CFrame = CFrame.new(Target.Character[AimPart].Position + (Target.Character[AimPart].Velocity * AimPred))
                else
                    HitBox.CFrame = CFrame.new(Target.Character[AimPart].Position)
                end
            else
                HitBox.CFrame = CFrame.new(0, -9999, 0)
            end
        else
            HitBox.CFrame = CFrame.new(0, -9999, 0)
        end
    else
        HitBox.CFrame = CFrame.new(0, -9999, 0)
    end

    --// AntiStomp Logic
    --[[if AntiStomp and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if game.Players.LocalPlayer.Character.Humanoid.Health <= 5 and game.Players.LocalPlayer.Character.BodyEffects["K.O"] then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") or v:IsA("Part") then
                    v:Destroy()
                end
            end
        end
    end]]

    --// Auto Armor / Auto Heal [ Adding heals soon :DDDD ]
    if AutoArmor and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if game.Players.LocalPlayer.Character.BodyEffects.Armor.Value <= 50 and workspace.Ignored.Shop["[High Armor] - $3200"] and not game.Players.LocalPlayer.Character.BodyEffects["K.O"].Value then
            if not OldPos then
                OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[High Armor] - $3200"].Head.CFrame
            fireclickdetector(workspace.Ignored.Shop["[High Armor] - $3200"].ClickDetector)
        elseif OldPos then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OldPos
            OldPos = nil
        end
    end

    -- AutoShoot Logic
            

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



local AimlockTab = Tabs.Main:AddRightTabbox()
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
    Text = 'Grabbed Check',
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
    Text = 'Grabbed Check',
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

local SilentAimTab = Tabs.Main:AddRightTabbox()
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
local TargetVTab = AimlockTab:AddTab('Visuals')
TargetVTab:AddToggle('ToggleDot', {
    Text = 'Show Dot',
    Default = ShowDot,
}):AddColorPicker('DotColor', {
    Default = Dot.Color,
    Title = 'Dot Color',
})
Toggles.ToggleDot:OnChanged(function()
    ShowDot = Toggles.ToggleDot.Value
end)
TargetVTab:AddToggle('ToggleLine', {
    Text = 'Show Line',
    Default = ShowLine,
})
Toggles.ToggleLine:OnChanged(function()
    ShowLine = Toggles.ToggleLine.Value
end)
TargetVTab:AddToggle('ToggleCham', {
    Text = 'Show Cham',
    Default = ShowCham,
}):AddColorPicker('ChamColor', {
    Default = HitBox.Color,
    Title = 'Cham Color',
})
Toggles.ToggleCham:OnChanged(function()
    ShowCham = Toggles.ToggleCham.Value
end)
TargetVTab:AddToggle('ToggleName', {
    Text = 'Show Name',
    Default = ShowName,
})
Toggles.ToggleName:OnChanged(function()
    ShowName = Toggles.ToggleName.Value
end)
TargetVTab:AddToggle('ToggleHitBox', {
    Text = 'Show HitBox',
    Default = ShowHitBox,
}):AddColorPicker('HitBoxColor', {
    Default = HitBox.Color,
    Title = 'Hitbox Color',
})
Options.HitBoxColor:OnChanged(function()
    HitBox.Color = Options.HitBoxColor.Value
end)
Toggles.ToggleHitBox:OnChanged(function()
    ShowHitBox = Toggles.ToggleHitBox.Value
end)


local CharTab = Tabs.Main:AddLeftTabbox("")
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
Char:AddToggle('ToggleLookAt', {
    Text = 'Look At',
    Default = LookAt,
})
Toggles.ToggleLookAt:OnChanged(function()
    LookAt = Toggles.ToggleLookAt.Value
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


local ClientT = CharTab:AddTab('Client')
ClientT:AddToggle('ToggleAutoArmor', {
    Text = 'Auto Armor',
    Default = false,
})
Toggles.ToggleAutoArmor:OnChanged(function()
    AutoArmor = Toggles.ToggleAutoArmor.Value
end)
ClientT:AddToggle('ToggleBodyTrail', {
    Text = 'Body Trail',
    Default = false,
}):AddColorPicker('TrailColor', {
    Default = TrailColor,
    Title = 'Player Trail Color',
})
Options.TrailColor:OnChanged(function()
    TrailColor = Options.TrailColor.Value
end)
Toggles.ToggleBodyTrail:OnChanged(function()
    BodyTrail = Toggles.ToggleBodyTrail.Value
end)
ClientT:AddDropdown('TrailMaterial', {
    Values = {'Neon', 'ForceField'},
    Default = TrailMaterial,
    Multi = false, 

    Text = 'Trail Material',

})
Options.TrailMaterial:OnChanged(function()
    TrailMaterial = Options.TrailMaterial.Value
end)

ClientT:AddToggle('ToggleCustomBody', {
    Text = 'Customized Body',
    Default = CustomBody,
})--[[:AddColorPicker('BodyColor', {
    Default = BodyColor,
    Title = 'Body Material Color',
})
Options.BodyColor:OnChanged(function()
    BodyColor = Options.BodyColor.Value
end)]]
Toggles.ToggleCustomBody:OnChanged(function()
    CustomBody = Toggles.ToggleCustomBody.Value
end)

--[[ClientT:AddDropdown('BodyMaterial', {
    Values = {'Neon', 'Plastic', 'ForceField'},
    Default = BodyMaterial,
    Multi = false, 

    Text = 'Body Material',

})
Options.BodyMaterial:OnChanged(function()
    BodyMaterial = Options.BodyMaterial.Value
end)]]







local MiscTab = Tabs.Main:AddLeftTabbox()
local MiscT = MiscTab:AddTab('Misc')
MiscT:AddButton('Rejoin', function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)
MiscT:AddToggle("ShowChat", {
    Text = "Chat", 
    Default = false
})
Toggles.ShowChat:OnChanged(function()
    game.Players.LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = Toggles.ShowChat.Value
end)
MiscT:AddToggle("ToggleWatermark", {
    Text = "Watermark", 
    Default = false
})
MiscT:AddToggle("ToggleBindsMenu", {
    Text = "Keybinds Menu", 
    Default = false
})
MiscT:AddToggle("ToggleClientStats", {
    Text = "Client Stats Menu", 
    Default = false
})
Toggles.ToggleWatermark:OnChanged(function()
    Library:SetWatermarkVisibility(Toggles.ToggleWatermark.Value)
end)
Toggles.ToggleClientStats:OnChanged(function()
    Stats.Enabled = Toggles.ToggleClientStats.Value
end)
Toggles.ToggleBindsMenu:OnChanged(function()
    Library.KeybindFrame.Visible = Toggles.ToggleBindsMenu.Value
end)
MiscT:AddSlider("FieldOfView", {
    Text = "Field Of View", 
    Default = 70, 
    Min = 70, 
    Max = 120, 
    Rounding = 0
})
Options.FieldOfView:OnChanged(function()
    game.workspace.CurrentCamera.FieldOfView = Options.FieldOfView.Value
end)


local TeleportsTab = Tabs.Main:AddRightTabbox()
local TPTab = TeleportsTab:AddTab('Teleport')
TPTab:AddInput('TPToPlayer', {
    Default = '',
    Numeric = false, 
    Finished = true, 

    Text = 'Teleport to Player',
    Tooltip = '',

    Placeholder = 'Enter Username/Display', 
})
Options.TPToPlayer:OnChanged(function()
    if Options.TPToPlayer.Value ~= "" then
        local TPTarget = FindPlayer(Options.TPToPlayer.Value)
        if TPTarget and TPTarget.Character then 
            Teleport(TPTarget.Character:FindFirstChild("HumanoidRootPart").CFrame)
        end
    end
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
