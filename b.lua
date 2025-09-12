getgenv().AutoFarm = true 
_G.FastAttack = true

local player = game.Players.LocalPlayer local ReplicatedStorage = game:GetService("ReplicatedStorage") local Enemies = workspace:WaitForChild("Enemies") local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_") local RegAttack = ReplicatedStorage.Modules.Net["RE/RegisterAttack"] local RegHit = ReplicatedStorage.Modules.Net["RE/RegisterHit"]

local function getCharacter() return player.Character or player.CharacterAdded:Wait() end

local function fastAttackLoop() task.spawn(function() while _G.FastAttack do local Char = getCharacter() local HR = Char:FindFirstChild("HumanoidRootPart") local Head = Char:FindFirstChild("Head") or HR if HR then pcall(function() RegAttack:FireServer(0) end) for _, enemy in pairs(Enemies:GetChildren()) do local enemyHum = enemy:FindFirstChild("Humanoid") local enemyHRP = enemy:FindFirstChild("HumanoidRootPart") if enemyHum and enemyHRP and enemyHum.Health > 0 then pcall(function() RegHit:FireServer(HR, {{enemy, enemyHRP}}) end) pcall(function() RegHit:FireServer(Head, {{enemy, enemyHRP}}) end) end end end task.wait() end end) end

local function autoFarmLoop() task.spawn(function() while getgenv().AutoFarm do local Char = getCharacter() local Hum = Char:WaitForChild("HumanoidRootPart") local Level = player.Data.Level.Value

local MON, MONPOS, QUESTPOS, QUESTNAME, QUESTNUMBER

        if MON then
            local questGui = player.PlayerGui.Main.Quest
            local questTitle = questGui.Container.QuestTitle.Title:FindFirstChild("ContantText")

            if questTitle and not string.find(questTitle.Text, MON) then
                pcall(function() CommF_:InvokeServer("AbandonQuest") end)
            end

            if QUESTPOS and (Hum.Position - QUESTPOS.Position).Magnitude < 5 then
                player:LoadCharacter()
                task.wait(1)
                Char = getCharacter()
                Hum = Char:WaitForChild("HumanoidRootPart")
            end

            if not questGui.Visible then
                Hum.CFrame = QUESTPOS
                task.wait(0.5)
                pcall(function() CommF_:InvokeServer("StartQuest", QUESTNAME, QUESTNUMBER) end)
                task.wait(0.5)
            end

            local closestTarget = nil
            local minDist = math.huge
            for _, target in pairs(Enemies:GetChildren()) do
                if target.Name == MON and target:FindFirstChild("Humanoid") and target.Humanoid.Health > 0 then
                    local targetHRP = target:FindFirstChild("HumanoidRootPart")
                    if targetHRP then
                        local dist = (Hum.Position - targetHRP.Position).Magnitude
                        if dist < minDist then
                            minDist = dist
                            closestTarget = targetHRP
                        end
                    end
                end
            end

            if closestTarget then
                Hum.CFrame = closestTarget.CFrame * CFrame.new(0, 15, 0)
                task.wait()
                pcall(function() RegHit:FireServer(closestTarget) end)
            else
                Hum.CFrame = MONPOS
            end
        end

        task.wait()
    end
end)

end

player.CharacterAdded:Connect(function(Char) Hum = Char:WaitForChild("HumanoidRootPart") end)

fastAttackLoop() 
autoFarmLoop()

