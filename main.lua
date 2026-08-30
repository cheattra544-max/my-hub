local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

local Window = OrionLib:MakeWindow({
    Name = "🔥 My Custom Hub (VIP) 🔥", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "CheattraHubConfigs",
    IntroText = "Welcome to Cheattra VIP"
})

local MainTab = Window:MakeTab({
    Name = "Main Features",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

local Player = game.Players.LocalPlayer

MainTab:AddSlider({
    Name = "Adjust Speed (ល្បឿនរត់)",
    Min = 16,
    Max = 200,
    Default = 16,
    Color = Color3.fromRGB(0, 255, 100),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = Value
        end
    end    
})

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

MainTab:AddToggle({
    Name = "Inf Jump / Fly (លោតមិនចេះធ្លាក់)",
    Default = false,
    Callback = function(Value)
        _G.InfJump = Value
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfJump and Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end
})

OrionLib:Init()
