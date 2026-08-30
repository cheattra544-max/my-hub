local CorrectKey = "CHEATTRA-VIP-2026"

-- ផ្ទាំងទារ Key ងាយស្រួល និងដំណើរការ ១០០%
local KeyInput = game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🔑 CHEATTRA HUB",
    Text = "សូមវាយ Key ក្នុង Chat ឬប្រើប្រអប់ខាងក្រោម",
    Duration = 5
})

-- បង្កើត UI វាយ Key
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local Title = Instance.new("TextLabel")

ScreenGui.Parent = game:GetService("CoreGui")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Frame.Position = UDim2.new(0.35, 0, 0.35, 0)
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Active = true
Frame.Draggable = true

Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "🔑 Cheattra Hub - Key Verification"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 50)

TextBox.Parent = Frame
TextBox.Position = UDim2.new(0.1, 0, 0.35, 0)
TextBox.Size = UDim2.new(0.8, 0, 0.25, 0)
TextBox.PlaceholderText = "Paste Key Here..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 60)

SubmitBtn.Parent = Frame
SubmitBtn.Position = UDim2.new(0.2, 0, 0.7, 0)
SubmitBtn.Size = UDim2.new(0.6, 0, 0.2, 0)
SubmitBtn.Text = "SUBMIT KEY"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

SubmitBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == CorrectKey then
        ScreenGui:Destroy() -- បិទផ្ទាំង Key វិញ
        
        -- ==================== MAIN VIP HUB ====================
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
        SubmitBtn.Text = "KEY WRONG! TRY AGAIN"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        task.wait(1.5)
        SubmitBtn.Text = "SUBMIT KEY"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    end
end)
