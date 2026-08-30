local CorrectKey = "CHEATTRA-VIP-2026"
local EnteredKey = ""

local KeyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local KeyWindow = KeyLibrary.CreateLib("🔑 Cheattra Hub - Key System", "Midnight")
local KeyTab = KeyWindow:NewTab("Key Verification")
local KeySec = KeyTab:NewSection("Enter Your Key Below")

-- ប្រអប់សម្រាប់វាយ Key
KeySec:NewTextBox("Enter Key", "Paste your Key here", function(txt)
    EnteredKey = txt
end)

-- ប៊ូតុងសម្រាប់ចុចផ្ទៀងផ្ទាត់ Key
KeySec:NewButton("Submit Key (ចុចដើម្បីផ្ទៀងផ្ទាត់)", "Check Key", function()
    if EnteredKey == CorrectKey then
        -- លុបផ្ទាំង Key System ចោល
        game:GetService("CoreGui"):FindFirstChild("KavoUI"):Destroy()
        
        -- ==================== ដំណើរការ MAIN HUB ====================
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
        local Window = Library.CreateLib("🔥 Cheattra VIP Hub (Egg Steal Edition) 🔥", "Midnight")

        local MainTab = Window:NewTab("Bypass & Evade")
        local SpeedSec = MainTab:NewSection("Fast Speed (២០០)")

        local FastSpeed = false
        local SpeedValue = 2

        SpeedSec:NewToggle("Enable Fast Speed (ល្បឿន ២០០)", "រត់លឿន ២០០ ការពារ Anti-Cheat Kick", function(state)
            FastSpeed = state
        end)

        game:GetService("RunService").Heartbeat:Connect(function()
            if FastSpeed and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local HRPT = game.Players.LocalPlayer.Character.HumanoidRootPart
                local MoveDirection = game.Players.LocalPlayer.Character.Humanoid.MoveDirection
                if MoveDirection.Magnitude > 0 then
                    HRPT.CFrame = HRPT.CFrame + (MoveDirection * SpeedValue)
                end
            end
        end)

        local EvadeSec = MainTab:NewSection("Proximity Evade (គេចពេលគេចូលជិត)")
        local AutoEvadeDistance = false
        local EvadeRange = 15

        EvadeSec:NewToggle("Auto Dodge Player Nearby", "តេឡេពតគេចខ្លួនភ្លាម ពេលមានគេដើរចូលជិត", function(state)
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
                                    myChar.HumanoidRootPart.CFrame = myChar.HumanoidRootPart.CFrame + Vector3.new(0, 70, 0)
                                    task.wait(0.5)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end)

        local ExtraSec = MainTab:NewSection("Jump Settings")
        ExtraSec:NewSlider("Adjust Jump", "កម្ពស់លោត", 200, 50, function(s)
            game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
        end)
    else
        -- បើវាយ Key ខុស វានឹងលោតសារប្រាប់
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Key Error!",
            Text = "Key មិនត្រឹមត្រូវទេ! សូមពិនិត្យមើលឡើងវិញ។",
            Duration = 3
        })
    end
end)
