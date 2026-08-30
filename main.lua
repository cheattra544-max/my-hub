local CorrectKey = "CHEATTRA-VIP-2026"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🔥 Cheattra VIP Hub | Steal An Egg 🔥", "Midnight")

local KeyVerified = false
local FastSpeed = false
local SafeSpeedMode = true -- បើក Mode សុវត្ថិភាពជាដំបូង
local SpeedValue = 22 -- ល្បឿនធម្មជាតិ (Normal = 16)
local AutoEvadeDistance = false
local AutoSteal = false
local EvadeRange = 12

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local function getAliveCharacter()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
        if char.Humanoid.Health > 0 then
            return char
        end
    end
    return nil
end

local KeyTab = Window:NewTab("🔑 Key Verification")
local KeySec = KeyTab:NewSection("Enter Your Key Below")

KeySec:NewTextBox("Enter Key", "Paste key & press Enter", function(EnteredKey)
    if KeyVerified then return end

    if EnteredKey == CorrectKey then
        KeyVerified = true
        StarterGui:SetCore("SendNotification", {Title = "Success!", Text = "Key ត្រឹមត្រូវ! មុខងារ VIP បើករួច។", Duration = 3})

        local MainTab = Window:NewTab("Main Features")
        
        -- Safe Speed Section
        local SpeedSec = MainTab:NewSection("🛡️ Safe & Legit Speed (Anti-Admin)")
        
        SpeedSec:NewToggle("Enable Legit Speed", "បើករត់លឿនបែបធម្មជាតិ មិនឲ្យគេដឹង", function(state)
            FastSpeed = state
            if not state then
                local char = getAliveCharacter()
                if char then char.Humanoid.WalkSpeed = 16 end -- ត្រឡប់មកល្បឿនដើមវិញ
            end
        end)

        SpeedSec:NewSlider("Legit Speed Level", "កំណត់ល្បឿន (ណែនាំ: 20-25)", 40, 16, function(v)
            SpeedValue = v
        end)

        -- Auto Section
        local AutoSec = MainTab:NewSection("Auto Features")
        AutoSec:NewToggle("Auto Dodge Player/Monster", "តេឡេពតគេចខ្លួន", function(state) AutoEvadeDistance = state end)
        AutoSec:NewToggle("Auto Fire Proximity Prompts", "លួចពងស្វ័យប្រវត្តិ", function(state) AutoSteal = state end)

        local ExtraTab = Window:NewTab("Player Settings")
        local ExtraSec = ExtraTab:NewSection("Jump Settings")
        ExtraSec:NewSlider("Adjust Jump Power", "កម្ពស់លោត", 120, 50, function(s)
            local char = getAliveCharacter()
            if char then
                char.Humanoid.UseJumpPower = true
                char.Humanoid.JumpPower = s
            end
        end)

        -- 1. Anti-Admin Safe Speed Loop
        task.spawn(function()
            while true do
                task.wait(0.1)
                if FastSpeed then
                    local char = getAliveCharacter()
                    if char then
                        -- កំណត់ WalkSpeed ផ្ទាល់ តែរក្សាស្ថេរភាព Anti-Cheat Reset
                        char.Humanoid.WalkSpeed = SpeedValue
                    end
                end
            end
        end)

        -- 2. Proximity Evade Loop
        task.spawn(function()
            while true do
                task.wait(0.1)
                if AutoEvadeDistance then
                    local char = getAliveCharacter()
                    if char then
                        local myHrp = char.HumanoidRootPart
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                                if (myHrp.Position - p.Character.HumanoidRootPart.Position).Magnitude <= EvadeRange then
                                    myHrp.CFrame = myHrp.CFrame + Vector3.new(0, 30, 0)
                                    task.wait(0.5)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end)

        -- 3. Auto Steal Loop
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

    else
        StarterGui:SetCore("SendNotification", {Title = "Key Error!", Text = "Key មិនត្រឹមត្រូវទេ!", Duration = 3})
    end
end)
