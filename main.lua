local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

local Window = Rayfield:CreateWindow({
   Name = "My Custom Hub",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by Cheattra",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main", 4483362458)

local player = game.Players.LocalPlayer

MainTab:CreateButton({
   Name = "Speed Boost (100)",
   Callback = function()
       if player and player.Character and player.Character:FindFirstChild("Humanoid") then
           player.Character.Humanoid.WalkSpeed = 100
       end
   end,
})

MainTab:CreateButton({
   Name = "High Jump (120)",
   Callback = function()
       if player and player.Character and player.Character:FindFirstChild("Humanoid") then
           player.Character.Humanoid.UseJumpPower = true
           player.Character.Humanoid.JumpPower = 120
       end
   end,
})
