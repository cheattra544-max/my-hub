local CorrectKey = "CHEATTRA-VIP-2026"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🔥 Cheattra VIP Hub | Steal An Egg 🔥", "Midnight")

local KeyVerified = false
local FastSpeed = false
local SpeedValue = 50
local AutoTreadmill = false
local AutoWalkPhysical = false

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
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
        StarterGui:SetCore("SendNotification", {Title = "Success!", Text = "Key ត្រឹមត្រូវ!", Duration = 3})

        local FarmTab = Window:NewTab("🌾 Physical Farm")
        local FarmSec = FarmTab:NewSection("🏃 Movement & Treadmill Engine")

        FarmSec:NewToggle("Auto Treadmill Mode", "រត់លើម៉ាស៊ីនស្វ័យប្រវត្តិ", function(state)
            AutoTreadmill = state
        end)

        FarmSec:NewToggle("Auto Walk Circle (ដើររវល់កើន Step)", "ឱ្យតួអង្គដើរវិលជុំវិញដើម្បីកើន Step", function(state)
            AutoWalkPhysical = state
        end)

        local MainTab = Window:NewTab("Main Features")
        local SpeedSec = MainTab:NewSection("⚡ WalkSpeed Boost")
        
        SpeedSec:NewToggle("Enable Fast Speed", "បើករត់លឿន", function(state) FastSpeed = state end)
        SpeedSec:NewTextBox("Set Speed Number", "វាយលេខល្បឿន", function(txt)
            local num = tonumber(txt)
            if num then SpeedValue = num end
        end)

        -- 1. Physical Auto Walk Engine (Simulating Inputs)
        task.spawn(function()
            while true do
                task.wait(0.1)
                if AutoWalkPhysical then
                    local char, hrp, hum = getAliveCharacter()
                    if char and hrp and hum then
                        hum:Move(Vector3.new(math.sin(tick() * 3), 0, math.cos(tick() * 3)), true)
                    end
                end
            end
        end)

        -- 2. Treadmill Physics Velocity
        RunService.Heartbeat:Connect(function()
            if AutoTreadmill then
                local char, hrp, hum = getAliveCharacter()
                if char and hrp and hum then
                    hrp.AssemblyLinearVelocity = hrp.CFrame.LookVector * 50
                end
            end
            if FastSpeed then
                local char, hrp, hum = getAliveCharacter()
                if char and hrp and hum and hum.MoveDirection.Magnitude > 0 then
                    local moveDir = hum.MoveDirection
                    hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * SpeedValue, hrp.AssemblyLinearVelocity.Y, moveDir.Z * SpeedValue)
                end
            end
        end)

    else
        StarterGui:SetCore("SendNotification", {Title = "Key Error!", Text = "Key មិនត្រឹមត្រូវទេ!", Duration = 3})
    end
end)
