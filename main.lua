local CorrectKey = "CHEATTRA-VIP-2026"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🔥 Cheattra VIP Hub | Steal An Egg 🔥", "Midnight")

local KeyVerified = false
local FastSpeed = false
local AutoEvadeDistance = false
local AutoSteal = false
local SpeedMultiplier = 1.3
local EvadeRange = 15

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local KeyTab = Window:NewTab("🔑 Key Verification")
local KeySec = KeyTab:NewSection("Enter Your Key Below")

KeySec:NewTextBox("Enter Key", "Paste key & press Enter", function(EnteredKey)
    if KeyVerified then return end

    if EnteredKey == CorrectKey then
        KeyVerified = true
        StarterGui:SetCore("SendNotification", {Title = "Success!", Text = "Key ត្រឹមត្រូវ! មុខងារ VIP បើករួច។", Duration = 3})

        local MainTab = Window:NewTab("Main Features")
        local SpeedSec = MainTab:NewSection("Bypass Speed")
        SpeedSec:NewToggle("Enable Smooth Speed", "រត់លឿនបែប Smooth", function(state) FastSpeed = state end)

        local AutoSec = MainTab:NewSection("Auto Features")
        AutoSec:NewToggle("Auto Dodge Player/Monster", "តេឡេពតគេចខ្លួន", function(state) AutoEvadeDistance = state end)
        AutoSec:NewToggle("Auto Fire Proximity Prompts", "លួចពងស្វ័យប្រវត្តិ", function(state) AutoSteal = state end)

        local ExtraTab = Window:NewTab("Player Settings")
        local ExtraSec = ExtraTab:NewSection("Jump Settings")
        ExtraSec:NewSlider("Adjust Jump Power", "កម្ពស់លោត", 200, 50, function(s)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character.Humanoid.UseJumpPower = true
                LocalPlayer.Character.Humanoid.JumpPower = s
            end
        end)

        task.spawn(function()
            while true do
                task.wait(0.02)
                if FastSpeed and LocalPlayer.Character then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.MoveDirection.Magnitude > 0 then
                        hrp.CFrame = hrp.CFrame + (hum.MoveDirection * SpeedMultiplier)
                    end
                end
            end
        end)

        task.spawn(function()
            while true do
                task.wait(0.1)
                if AutoEvadeDistance and LocalPlayer.Character then
                    local myHrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if myHrp then
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                                if (myHrp.Position - p.Character.HumanoidRootPart.Position).Magnitude <= EvadeRange then
                                    myHrp.CFrame = myHrp.CFrame + Vector3.new(0, 40, 0)
                                    task.wait(0.5)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end)

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
