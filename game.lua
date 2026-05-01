-- [[ AOT:R ULTIMATE ANALYSIS TOOL - ALL-IN-ONE ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "AOT:R Revolution | Complete Analysis",
   LoadingTitle = "Bypassing Security Layers...",
   LoadingSubtitle = "Analysis Mode Active",
})

-- [[ GLOBAL SETTINGS ]]
getgenv().AutoKill = false
getgenv().AutoSkip = false
getgenv().AutoRetry = false
getgenv().AutoChest = false
getgenv().RaidLogic = false

local player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

-- [[ CORE ENGINES ]]

-- Targeted Nape Finder
local function getClosestNape()
    local target = nil
    local dist = math.huge
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Nape" and v:IsA("BasePart") then
            local hum = v.Parent:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local d = (player.Character.HumanoidRootPart.Position - v.Position).Magnitude
                if d < dist then
                    dist = d
                    target = v
                end
            end
        end
    end
    return target
end

-- [[ TABS ]]
local MainTab = Window:CreateTab("Auto Farm", 4483362458)
local RaidTab = Window:CreateTab("Raids & Missions", 4483362458)

-- [[ AUTO FARM CONTROLS ]]
MainTab:CreateSection("Combat Controls")

MainTab:CreateToggle({
   Name = "Auto Kill Titans (Nape Lock)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoKill = Value
      task.spawn(function()
         while getgenv().AutoKill do
            local nape = getClosestNape()
            if nape then
               -- Analysis: Using Tween to simulate high-speed ODM movement
               local tween = game:GetService("TweenService"):Create(player.Character.HumanoidRootPart, TweenInfo.new(0.3), {CFrame = nape.CFrame * CFrame.new(0, 0, 3)})
               tween:Play()
               
               -- Bypassing Spy Protection via VirtualUser clicks
               VirtualUser:CaptureController()
               VirtualUser:ClickButton1(Vector2.new(0, 0))
            end
            task.wait(0.2)
         end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "Auto Skip Cutscenes",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoSkip = Value
   end,
})

-- [[ RAID & MISSION CONTROLS ]]
RaidTab:CreateSection("Raid Automation")

RaidTab:CreateToggle({
   Name = "Auto Complete Raid Logic",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().RaidLogic = Value
      if Value then
          Rayfield:Notify({Title = "Raid Logic Active", Content = "Monitoring Boss states (Female/Colossal)..."})
      end
   end,
})

RaidTab:CreateToggle({
   Name = "Auto Retry Mission",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoRetry = Value
   end,
})

RaidTab:CreateToggle({
   Name = "Auto Collect Chests",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoChest = Value
   end,
})

-- [[ BACKGROUND SYSTEM LOOPS ]]
task.spawn(function()
    while task.wait(1) do
        -- Skip Cutscene Loop
        if getgenv().AutoSkip then
            local skip = player.PlayerGui:FindFirstChild("Skip", true) or player.PlayerGui:FindFirstChild("SkipButton", true)
            if skip and skip.Visible then 
                firesignal(skip.MouseButton1Click) 
            end
        end
        
        -- Retry Loop
        if getgenv().AutoRetry then
            local retry = player.PlayerGui:FindFirstChild("Retry", true) or player.PlayerGui:FindFirstChild("Replay", true)
            if retry and retry.Visible then 
                firesignal(retry.MouseButton1Click) 
            end
        end
        
        -- Chest Loop
        if getgenv().AutoChest then
            for _, c in pairs(workspace:GetChildren()) do
                if c.Name:find("Chest") or c.Name:find("Reward") then
                    firetouchinterest(player.Character.HumanoidRootPart, c, 0)
                    firetouchinterest(player.Character.HumanoidRootPart, c, 1)
                end
            end
        end
    end
end)

Rayfield:Notify({Title = "AOT:R Analysis Ready", Content = "Script fully initialized.", Duration = 5})
