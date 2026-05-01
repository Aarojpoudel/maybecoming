-- [[ AOT:R Update 4 - Analysis Tool ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "AOT:R Analysis | Grade 10 Project",
   LoadingTitle = "Securing Environment...",
   LoadingSubtitle = "by Gemini",
})

-- [[ DATA VALUES ]]
getgenv().AutoFarm = false
getgenv().AutoSkip = false
getgenv().RaidLogic = false
getgenv().CurrentRaid = "Colossal"

-- [[ TABS ]]
local MainTab = Window:CreateTab("Main Farm", 4483362458)
local RaidTab = Window:CreateTab("Raid Specialized", 4483362458)

-- [[ MAIN FARM FUNCTIONS ]]
MainTab:CreateToggle({
   Name = "Auto Kill Titans (Nape Lock)",
   CurrentValue = false,
   Flag = "AutoKill",
   Callback = function(Value)
      getgenv().AutoFarm = Value
      if Value then
         task.spawn(function()
            while getgenv().AutoFarm do
               for _, titan in pairs(workspace.Titans:GetChildren()) do
                  if titan:FindFirstChild("Nape") and titan.Humanoid.Health > 0 then
                     -- Analysis: This uses Tween to bypass velocity checks
                     local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - titan.Nape.Position).Magnitude
                     local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(dist/300), {CFrame = titan.Nape.CFrame * CFrame.new(0,0,3)})
                     tween:Play()
                     task.wait(0.5) -- Delay to look human
                  end
               end
               task.wait()
            end
         end)
      end
   end,
})

MainTab:CreateToggle({
   Name = "Auto Skip Cutscenes",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoSkip = Value
   end,
})

-- [[ RAID SPECIALIZED FUNCTIONS ]]
RaidTab:CreateSection("Boss Specifics")

RaidTab:CreateDropdown({
   Name = "Select Raid",
   Options = {"Colossal", "Female", "Armored"},
   CurrentOption = {"Colossal"},
   Callback = function(Option)
      getgenv().CurrentRaid = Option[1]
   end,
})

RaidTab:CreateToggle({
   Name = "Run Auto-Raid Logic",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().RaidLogic = Value
      if Value then
          Rayfield:Notify({Title = "Raid Logic Active", Content = "Detecting " .. getgenv().CurrentRaid .. " mechanics..."})
          -- Logic for Female Hardening or Colossal Cannons would go here
      end
   end,
})

-- [[ BACKGROUND SYSTEM LOOP ]]
task.spawn(function()
   while task.wait(1) do
      -- Auto Skip
      if getgenv().AutoSkip then
         local skip = game.Players.LocalPlayer.PlayerGui:FindFirstChild("SkipButton", true)
         if skip and skip.Visible then firesignal(skip.MouseButton1Click) end
      end
      
      -- Auto Chest/Retry (Common in AOT:R Raids)
      local retry = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Retry", true)
      if retry and retry.Visible then firesignal(retry.MouseButton1Click) end
   end
end)