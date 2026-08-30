local CorrectKey = "CHEATTRA-VIP-2026"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🔥 Cheattra VIP Hub | Steal An Egg 🔥", "Midnight")

local KeyVerified = false
local FastSpeed = false
local SpeedValue = 50 -- ល្បឿនកំណត់ (Default)
local AutoEvadeDistance = false
local AutoSteal = false
local EvadeRange = 12
local ESPEnabled = false

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local function getAliveCharacter()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
        if char.Humanoid.Health > 0 then return char end
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
        local SpeedSec = MainTab:NewSection("⚡ Super Speed (Bypass Anti-Cheat)")
        
        SpeedSec:NewToggle("Enable Fast Speed", "បើករត់លឿន (Bypass Anti-Cheat)", function(state)
            FastSpeed = state
        end)
        
        SpeedSec:NewSlider("WalkSpeed Power", "សារ៉េល្បឿន (២០ ដល់ ១៥០)", 150, 20, function(v)
            SpeedValue = v
        end)

        local AutoSec = MainTab:NewSection("Auto Features")
        AutoSec:NewToggle("Auto Dodge Player/Monster", "តេឡេពតគេចខ្លួន", function(state) AutoEvadeDistance = state end)
        AutoSec:NewToggle("Auto Fire Proximity Prompts", "លួចពងស្វ័យប្រវត្តិ", function(state) AutoSteal = state end)

        local VisualTab = Window:NewTab("Visuals / ESP")
        local EspSec = VisualTab:NewSection("Player ESP (មើលធ្លុះ)")
        EspSec:NewToggle("Enable Player ESP", "មើលឃើញ Player តាមជញ្ជាំង", function(state)
            ESPEnabled = state
            if not state then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("Highlight") then
                        p.Character.Highlight:Destroy()
                    end
                end
            end
        end)

        local ExtraTab = Window:NewTab("Player Settings")
        local ExtraSec = ExtraTab:NewSection("Jump Settings")
        ExtraSec:NewSlider("Adjust Jump Power", "កម្ពស់លោត", 150, 50, function(s)
            local char = getAliveCharacter()
            if char then
                char.Humanoid.UseJumpPower = true
                char.Humanoid.JumpPower = s
            end
        end)

        -- 1. Velocity Bypass Speed Loop (រត់លឿនពិតប្រាកដ)
        task.spawn(function()
            while true do
                task.wait(0.01)
                if FastSpeed then
                    local char = getAliveCharacter()
                    if char then
                        local hrp = char.HumanoidRootPart
                        local hum = char.Humanoid
                        if hum.MoveDirection.Magnitude > 0 then
                            -- ប្រើ Velocity Push ដើម្បីបង្ខំឲ្យតួអង្គរត់ទៅមុខតាមល្បឿន Slider
                            hrp.Velocity = Vector3.new(hum.MoveDirection.X * SpeedValue, hrp.Velocity.Y, hum.MoveDirection.Z * SpeedValue)
                        end
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

        -- 4. ESP Loop
        task.spawn(function()
            while true do
                task.wait(0.5)
                if ESPEnabled then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character then
                            if not p.Character:FindFirstChild("Highlight") then
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
            end
        end)

    else
        StarterGui:SetCore("SendNotification", {Title = "Key Error!", Text = "Key មិនត្រឹមត្រូវទេ!", Duration = 3})
    end
end)
