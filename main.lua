local CorrectKey = "CHEATTRA-VIP-2026"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🔥 Cheattra VIP Hub (Fixed Edition) 🔥", "Midnight")

-- ==================== TAB 1: KEY SYSTEM ====================
local KeyTab = Window:NewTab("🔑 Key Verification")
local KeySec = KeyTab:NewSection("Enter Your Key Below")

KeySec:NewTextBox("Enter Key", "Paste key & press Enter", function(EnteredKey)
    if EnteredKey == CorrectKey then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Success!",
            Text = "Key ត្រឹមត្រូវ! មុខងារ VIP ត្រូវបានបើក។",
            Duration = 3
        })

        -- ==================== TAB 2: MAIN FEATURES ====================
        local MainTab = Window:NewTab("Bypass & Evade")
        local SpeedSec = MainTab:NewSection("Anti-Lagback Speed (២០០)")

        local FastSpeed = false
        local SpeedMultiplier = 1.2 -- បន្ថយមកត្រឹម ១.២ ដើម្បីកុំឱ្យហ្គេមទាញថយក្រោយ

        SpeedSec:NewToggle("Enable Smooth Speed", "រត់លឿនបែប Smooth មិនទាញថយក្រោយ", function(state)
            FastSpeed = state
        end)

        -- ប្រព័ន្ធរត់លឿនការពារ Lagback / Rubberband
        task.spawn(function()
            while true do
                task.wait(0.02) -- បន្ថែម Delay បន្តិចដើម្បីបន្លំ Anti-Cheat
                if FastSpeed then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                        if char.Humanoid.MoveDirection.Magnitude > 0 then
                            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (char.Humanoid.MoveDirection * SpeedMultiplier)
                        end
                    end
                end
            end
        end)

        -- ==================== PROXIMITY EVADE ====================
        local EvadeSec = MainTab:NewSection("Proximity Evade")
        local AutoEvadeDistance = false
        local EvadeRange = 12

        EvadeSec:NewToggle("Auto Dodge Player Nearby", "តេឡេពតគេចខ្លួនពេលគេចូលជិត", function(state)
            AutoEvadeDistance = state
        end)

        task.spawn(function()
            while task.wait(0.1) do
                if AutoEvadeDistance then
                    local myChar = game.Players.LocalPlayer.Character
                    if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                        local myPos = myChar.HumanoidRootPart.Position
                        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                            if otherPlayer ~= game.Players.LocalPlayer and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local otherPos = otherPlayer.Character.HumanoidRootPart.Position
                                if (myPos - otherPos).Magnitude <= EvadeRange then
                                    -- លោតឡើងលើ ៣៥ ម៉ែត្រ (កាត់បន្ថយពី ៧០ ដើម្បីកុំឱ្យទាញថយក្រោយ)
                                    myChar.HumanoidRootPart.CFrame = myChar.HumanoidRootPart.CFrame + Vector3.new(0, 35, 0)
                                    task.wait(0.6)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end)

        -- ==================== TAB 3: SETTINGS ====================
        local ExtraTab = Window:NewTab("Settings")
        local ExtraSec = ExtraTab:NewSection("Jump Settings")
        ExtraSec:NewSlider("Adjust Jump", "កម្ពស់លោត", 200, 50, function(s)
            game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
        end)

    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Key Error!",
            Text = "Key មិនត្រឹមត្រូវទេ!",
            Duration = 3
        })
    end
end)
