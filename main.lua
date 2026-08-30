local CorrectKey = "CHEATTRA-VIP-2026"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🔥 Cheattra VIP Hub | Steal An Egg 🔥", "Midnight")

local KeyVerified = false
local FastSpeed = false
local SpeedValue = 50
local AutoStealEgg = false
local MonsterGodmode = false
local ESPEnabled = false
local AutoTreadmill = false
local Treadmill5x = false
local SafeFarmStep = false
local UltraFast100B = false

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

        -- TAB 1: EGG & PROTECTION
        local ProtectTab = Window:NewTab("🥚 Steal & Protection")
        local ProtectSec = ProtectTab:NewSection("🛡️ True Monster Godmode")
        
        ProtectSec:NewToggle("Auto Steal Egg (លួចពងស្វ័យប្រវត្តិ)", "លួចពងសត្វតាម Remote & Prompt", function(state)
            AutoStealEgg = state
        end)

        ProtectSec:NewToggle("Monster Godmode (មេវាយមិនត្រូវ 100%)", "បង្កក Hitbox/បិទ Touch Interest របស់មេ", function(state)
            MonsterGodmode = state
        end)

        -- TAB 2: FARM FEATURES
        local FarmTab = Window:NewTab("🌾 Farm Features")
        local FarmSec = FarmTab:NewSection("🏋️ Speed / Step Farm Engine")
        
        FarmSec:NewToggle("⚡ ULTRA SPEED FARM (រុញទៅ 100B)", "កើន Speed/Step ក្នុងល្បឿនលឿនបំផុត", function(state)
            UltraFast100B = state
        end)

        FarmSec:NewToggle("Auto Treadmill (រត់លើម៉ាស៊ីន)", "ដើររត់លើម៉ាស៊ីនរត់ស្វ័យប្រវត្តិ", function(state)
            AutoTreadmill = state
        end)

        FarmSec:NewToggle("Treadmill 5x Boost (គុណ៥ លើម៉ាស៊ីនរត់)", "បង្កើនល្បឿន និង Step គុណនឹង ៥", function(state)
            Treadmill5x = state
        end)

        FarmSec:NewToggle("Safe Step Farm (កើន Step មិន Crash)", "កើន Step លឿន និងមានសុវត្ថិភាព", function(state)
            SafeFarmStep = state
        end)

        -- TAB 3: MAIN FEATURES
        local MainTab = Window:NewTab("Main Features")
        local SpeedSec = MainTab:NewSection("⚡ Super Speed (No-Crash & Bypass)")
        
        SpeedSec:NewToggle("Enable Fast Speed", "បើករត់លឿន", function(state) FastSpeed = state end)
        SpeedSec:NewTextBox("Set Speed Number", "វាយលេខល្បឿន (ឧ: 50, 100)", function(txt)
            local num = tonumber(txt)
            if num then SpeedValue = num end
        end)

        -- TAB 4: VISUALS
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

        -- TAB 5: SETTINGS
        local ExtraTab = Window:NewTab("Player Settings")
        ExtraTab:NewSection("Jump Settings"):NewTextBox("Set Jump Power", "វាយកម្ពស់លោត", function(txt)
            local num = tonumber(txt)
            local char, _, hum = getAliveCharacter()
            if num and char me then
                hum.UseJumpPower = true
                hum.JumpPower = num
            end
        end)

        -- 1. Movement Speed Engine
        RunService.Heartbeat:Connect(function()
            if FastSpeed then
                local char, hrp, hum = getAliveCharacter()
                if char and hrp and hum and hum.MoveDirection.Magnitude > 0 then
                    local moveDir = hum.MoveDirection
                    hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * SpeedValue, hrp.AssemblyLinearVelocity.Y, moveDir.Z * SpeedValue)
                end
            end
        end)

        -- 2. True Monster Godmode Engine
        RunService.Stepped:Connect(function()
            if MonsterGodmode then
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("TouchTransmitter") or v:IsA("TouchInterest") then
                        local parentName = v.Parent and v.Parent.Name:lower() or ""
                        local grandParentName = v.Parent and v.Parent.Parent and v.Parent.Parent.Name:lower() or ""
                        if parentName:find("monster") or parentName:find("boss") or parentName:find("hitbox") or grandParentName:find("monster") or grandParentName:find("boss") then
                            v:Destroy()
                        end
                    end
                end
                
                local char = getAliveCharacter()
                if char then
                    for _, part in ipairs(char:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanTouch = false
                        end
                    end
                end
            end
        end)

        -- 3. Advanced Auto Steal Egg Engine
        task.spawn(function()
            while true do
                task.wait(0.05)
                if AutoStealEgg then
                    for _, v in ipairs(game:GetDescendants()) do
                        if v:IsA("RemoteEvent") then
                            local rName = v.Name:lower()
                            if rName:find("steal") or rName:find("egg") or rName:find("take") or rName:find("grab") or rName:find("collect") then
                                pcall(function() v:FireServer() end)
                            end
                        end
                    end
                    
                    for _, prompt in ipairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            pcall(function()
                                prompt.HoldDuration = 0
                                prompt.RequiresLineOfSight = false
                                prompt.MaxActivationDistance = 9999
                                fireproximityprompt(prompt)
                            end)
                        end
                    end
                end
            end
        end)

        -- 4. NEW ALL-REMOTE SPEED FARM ENGINE (v17 Update)
        task.spawn(function()
            while true do
                task.wait(0.02)
                if UltraFast100B then
                    -- វិធីទី១៖ បាញ់ Remotes ទាំងអស់ដែលពាក់ព័ន្ធនឹង Speed / Add / Train / Walk
                    for _, v in ipairs(game:GetDescendants()) do
                        if v:IsA("RemoteEvent") then
                            local name = v.Name:lower()
                            if name:find("speed") or name:find("add") or name:find("train") or name:find("walk") or name:find("step") or name:find("click") or name:find("treadmill") or name:find("gain") then
                                pcall(function()
                                    v:FireServer()
                                    v:FireServer(100)
                                    v:FireServer(true)
                                end)
                            end
                        end
                    end

                    -- វិធីទី២៖ ធ្វើ Simulated Movement (ដើរអង្រួនខ្លួន) ដើម្បីឱ្យ Server គណនា Speed
                    local char, hrp, hum = getAliveCharacter()
                    if char and hrp and hum then
                        hum:Move(Vector3.new(math.random(-1, 1), 0, math.random(-1, 1)), true)
                    end
                end
            end
        end)

        -- 5. Treadmill Engine
        task.spawn(function()
            while true do
                task.wait(0.05)
                if AutoTreadmill then
                    local char, hrp, hum = getAliveCharacter()
                    if char and hrp and hum then
                        local speedMult = Treadmill5x and 150 or 30
                        hrp.AssemblyLinearVelocity = hrp.CFrame.LookVector * speedMult
                    end
                end
            end
        end)

        -- 6. Treadmill 5x Remote Multiplier Loop
        task.spawn(function()
            while true do
                task.wait(0.05)
                if Treadmill5x or SafeFarmStep then
                    local loops = Treadmill5x and 5 or 1
                    for i = 1, loops do
                        for _, v in ipairs(game:GetDescendants()) do
                            if v:IsA("RemoteEvent") and (v.Name:lower():find("step") or v.Name:lower():find("treadmill") or v.Name:lower():find("speed")) then
                                pcall(function() v:FireServer() end)
                            end
                        end
                    end
                end
            end
        end)

        -- 7. ESP Loop
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
