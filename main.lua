local CorrectKey = "CHEATTRA-VIP-2026"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🔥 Cheattra VIP Hub | Steal An Egg 🔥", "Midnight")

local KeyVerified = false
local FastSpeed = false
local SpeedValue = 50
local AutoEvadeDistance = false
local AutoSteal = false
local EvadeRange = 12
local ESPEnabled = false
local AutoTreadmill = false
local FastFarm100K = false

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function getAliveCharacter()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
        local hum = char.Humanoid
        if hum.Health > 0 and hum:GetState() ~= Enum.HumanoidStateType.Dead then
            return char, char.HumanoidRootPart, hum
        end
    end
    return nil, nil, nil
end

local KeyTab = Window:NewTab("🔑 Key Verification")
KeyTab:NewSection("Enter Your Key Below"):NewTextBox("Enter Key", "Paste key & press Enter", function(EnteredKey)
    if KeyVerified then return end

    if EnteredKey == CorrectKey then
        KeyVerified = true
        StarterGui:SetCore("SendNotification", {Title = "Success!", Text = "Key ត្រឹមត្រូវ! មុខងារ VIP បើករួច។", Duration = 3})

        -- TAB 1: FARM FEATURES (NEW)
        local FarmTab = Window:NewTab("🌾 Farm Features")
        local FarmSec = FarmTab:NewSection("🏋️ Auto Treadmill & Multiplier")
        
        FarmSec:NewToggle("Auto Treadmill (រត់លើម៉ាស៊ីន)", "ដើររត់លើម៉ាស៊ីនរត់ស្វ័យប្រវត្តិ", function(state)
            AutoTreadmill = state
        end)

        FarmSec:NewToggle("Fast Step Multiplier 100K", "Spam កើន Step លឿនខ្លាំង", function(state)
            FastFarm100K = state
        end)

        -- TAB 2: MAIN FEATURES
        local MainTab = Window:NewTab("Main Features")
        local SpeedSec = MainTab:NewSection("⚡ Super Speed (No-Crash & Bypass)")
        
        SpeedSec:NewToggle("Enable Fast Speed", "បើករត់លឿន", function(state) FastSpeed = state end)
        SpeedSec:NewTextBox("Set Speed Number", "វាយលេខល្បឿន (ឧ: 50, 100)", function(txt)
            local num = tonumber(txt)
            if num then SpeedValue = num end
        end)
        SpeedSec:NewButton("Speed: 40 (Legit Fast)", "រត់លឿនល្មម", function() SpeedValue = 40 end)
        SpeedSec:NewButton("Speed: 70 (Super Fast)", "រត់លឿនខ្លាំង", function() SpeedValue = 70 end)

        local AutoSec = MainTab:NewSection("Auto Features")
        AutoSec:NewToggle("Auto Dodge Player/Monster", "តេឡេពតគេចខ្លួន", function(state) AutoEvadeDistance = state end)
        AutoSec:NewToggle("Auto Fire Proximity Prompts", "លួចពងស្វ័យប្រវត្តិ", function(state) AutoSteal = state end)

        -- TAB 3: VISUALS
        local VisualTab = Window:NewTab("Visuals / ESP")
        VisualTab:NewSection("Player ESP"):NewToggle("Enable Player ESP", "មើលឃើញ Player តាមជញ្ជាំង", function(state)
            ESPEnabled = state
            if not state then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("Highlight") then
                        p.Character.Highlight:Destroy()
                    end
                end
            end
        end)

        -- TAB 4: SETTINGS
        local ExtraTab = Window:NewTab("Player Settings")
        ExtraTab:NewSection("Jump Settings"):NewTextBox("Set Jump Power", "វាយកម្ពស់លោត", function(txt)
            local num = tonumber(txt)
            local char, _, hum = getAliveCharacter()
            if num and char then
                hum.UseJumpPower = true
                hum.JumpPower = num
            end
        end)

        -- 1. Movement Speed Loop
        RunService.Heartbeat:Connect(function()
            if FastSpeed then
                local char, hrp, hum = getAliveCharacter()
                if char and hrp and hum and hum.MoveDirection.Magnitude > 0 then
                    local moveDir = hum.MoveDirection
                    hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * SpeedValue, hrp.AssemblyLinearVelocity.Y, moveDir.Z * SpeedValue)
                end
            end
        end)

        -- 2. Auto Treadmill Loop (បង្ខំឱ្យតួអង្គដើរលើម៉ាស៊ីន)
        task.spawn(function()
            while true do
                task.wait(0.05)
                if AutoTreadmill then
                    local char, hrp, hum = getAliveCharacter()
                    if char and hrp and hum then
                        -- រុញតួអង្គឱ្យរត់ទៅមុខលើ Treadmill
                        hrp.AssemblyLinearVelocity = hrp.CFrame.LookVector * 25
                    end
                end
            end
        end)

        -- 3. Fast Step Multiplier 100K Remote Loop
        task.spawn(function()
            while true do
                task.wait(0.01)
                if FastFarm100K then
                    -- បាញ់ Remote Events ទាំងអស់ក្នុង ReplicatedStorage ដើម្បីកើន Step ស្វ័យប្រវត្តិ
                    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
                        if v:IsA("RemoteEvent") and (v.Name:lower():find("step") or v.Name:lower():find("treadmill") or v.Name:lower():find("add")) then
                            pcall(function() v:FireServer() end)
                        end
                    end
                end
            end
        end)

        -- 4. Auto Evade Loop
        task.spawn(function()
            while true do
                task.wait(0.2)
                if AutoEvadeDistance then
                    local char, myHrp = getAliveCharacter()
                    if char and myHrp then
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHum = p.Character:FindFirstChildOfClass("Humanoid")
                                if targetHum and targetHum.Health > 0 then
                                    if (myHrp.Position - p.Character.HumanoidRootPart.Position).Magnitude <= EvadeRange then
                                        myHrp.CFrame = myHrp.CFrame + Vector3.new(0, 15, 0)
                                        task.wait(1.5)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)

        -- 5. Auto Steal Loop
        task.spawn(function()
            while true do
                task.wait(0.2)
                if AutoSteal then
                    for _, prompt in ipairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then fireproximityprompt(prompt) end
                    end
                end
            end
        end)

        -- 6. ESP Loop
        task.spawn(function()
            while true do
                task.wait(0.5)
                if ESPEnabled then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("Highlight") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "Highlight"
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.FillTransparency = 0.5
                            hl.Parent = p.Character
                        end
                    end
                end
            end
        end)

    else
        StarterGui:SetCore("SendNotification", {Title = "Key Error!", Text = "Key មិនត្រឹមត្រូវទេ!", Duration = 3})
    end
end)
