local CorrectKey = "CHEATTRA-VIP-2026"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🔥 Cheattra VIP Hub | Steal An Egg 🔥", "Midnight")

-- Variables
local KeyVerified = false
local FastSpeed = false
local AutoEvadeDistance = false
local AutoSteal = false
local SpeedMultiplier = 1.3
local EvadeRange = 15

-- Services & LocalPlayer
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- ==================== TAB 1: KEY SYSTEM ====================
local KeyTab = Window:NewTab("🔑 Key Verification")
local KeySec = KeyTab:NewSection("Enter Your Key Below")

KeySec:NewTextBox("Enter Key", "Paste key & press Enter", function(EnteredKey)
    if KeyVerified then
        StarterGui:SetCore("SendNotification", {
            Title = "Notice",
            Text = "អ្នកបានផ្ទៀងផ្ទាត់ Key រួចរាល់ហើយ!",
            Duration = 3
        })
        return
    end

    if EnteredKey == CorrectKey then
        KeyVerified = true

        StarterGui:SetCore("SendNotification", {
            Title = "Success!",
            Text = "Key ត្រឹមត្រូវ! មុខងារ VIP ត្រូវបានបើក។",
            Duration = 3
        })

        -- ==================== TAB 2: MAIN FEATURES ====================
        local MainTab = Window:NewTab("Main Features")
        
        -- Speed Section
        local SpeedSec = MainTab:NewSection("Bypass Speed")
        SpeedSec:NewToggle("Enable Smooth Speed", "រត់លឿនបែប Smooth ការពារ Lagback", function(state)
            FastSpeed = state
        end)
        
        SpeedSec:NewSlider("Speed Power", "ល្បឿនរត់", 30, 10, function(v)
            SpeedMultiplier = v / 10
        end)

        -- Evade & Steal Section
        local AutoSec = MainTab:NewSection("Auto Features")
        AutoSec:NewToggle("Auto Dodge Player/Monster", "តេឡេពតគេចខ្លួនពេលមានគេមកជិត", function(state)
            AutoEvadeDistance = state
        end)

        AutoSec:NewToggle("Auto Fire Proximity Prompts", "លួចពង/ចុច Prompt ដោយស្វ័យប្រវត្តិ", function(state)
            AutoSteal = state
        end)

        -- ==================== TAB 3: SETTINGS ====================
        local ExtraTab = Window:NewTab("Player Settings")
        local ExtraSec = ExtraTab:NewSection("Jump Settings")
        
        ExtraSec:NewSlider("Adjust Jump Power", "កម្ពស់លោត", 200, 50, function(s)
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char.Humanoid.UseJumpPower = true
                char.Humanoid.JumpPower = s
            end
        end)

        -- ==================== BACKGROUND LOOPS ====================
        
        -- 1. Anti-Lagback Speed Loop
        task.spawn(function()
            while true do
                task.wait(0.02)
                if FastSpeed then
                    local char = LocalPlayer.Character
                    if char then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.MoveDirection.Magnitude > 0 then
                            hrp.CFrame = hrp.CFrame + (hum.MoveDirection * SpeedMultiplier)
                        end
                    end
                end
            end
        end)

        -- 2. Proximity Evade Loop (Dodge Player/Monster)
        task.spawn(function()
            while true do
                task.wait(0.1)
                if AutoEvadeDistance then
                    local myChar = LocalPlayer.Character
                    if myChar then
                        local myHrp = myChar:FindFirstChild("HumanoidRootPart")
                        if myHrp then
                            local myPos = myHrp.Position
                            for _, otherPlayer in ipairs(Players:GetPlayers()) do
                                if otherPlayer ~= LocalPlayer and otherPlayer.Character then
                                    local otherHrp = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                                    if otherHrp and (myPos - otherHrp.Position).Magnitude <= EvadeRange then
                                        -- លោតគេចឡើងលើ ៤០ ម៉ែត្រ
                                        myHrp.CFrame = myHrp.CFrame + Vector3.new(0, 40, 0)
                                        task.wait(0.5)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)

        -- 3. Auto Steal / Interaction Loop
        task.spawn(function()
            while true do
                task.wait(0.2)
                if AutoSteal then
                    for _, prompt in ipairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
        end)

    else
        StarterGui:SetCore("SendNotification", {
            Title = "Key Error!",
            Text = "Key មិនត្រឹមត្រូវទេ!",
            Duration = 3
        })
    end
end)
