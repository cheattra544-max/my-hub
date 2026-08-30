local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

local Window = OrionLib:MakeWindow({
    Name = "🔥 My Custom Hub (VIP) 🔥",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "CheattraHubConfigs",
    IntroText = "Welcome to Cheattra VIP"
})

local MainTab = Window:MakeTab({
    Name = "Main Features",
    Icon = "rbxassetid://448336248",
    PremiumOnly = false
})

local Player = game.Players.LocalPlayer

-- Slider សម្រាប់ Speed
MainTab:AddSlider({
    Name = "Adjust Speed (ល្បឿនរត់)",
    Min = 16,
    Max = 200,
    Default = 16,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = Value
        end
    end
})

-- Slider សម្រាប់ Jump
MainTab:AddSlider({
    Name = "Adjust Jump (កម្ពស់លោត)",
    Min = 50,
    Max = 300,
    Default = 50,
    Color = Color3.fromRGB(0, 100, 255),
    Increment = 1,
    ValueName = "Power",
    Callback = function(Value)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.UseJumpPower = true
            Player.Character.Humanoid.JumpPower = Value
        end
    end
})

OrionLib:Init() -- ចាំបាច់ត្រូវដាក់នៅចុងបញ្ចប់ដើម្បីឱ្យ UI ដំណើរកា
