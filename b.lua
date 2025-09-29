local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local SafeZoneFolder = Workspace:WaitForChild("SafeZone") 

local function IsInSafeZone(position)
    for _, zone in pairs(SafeZoneFolder:GetChildren()) do
        if zone:IsA("BasePart") then
            local size = zone.Size / 2
            local pos = zone.Position
            if (position.X >= pos.X - size.X and position.X <= pos.X + size.X) and
               (position.Y >= pos.Y - size.Y and position.Y <= pos.Y + size.Y) and
               (position.Z >= pos.Z - size.Z and position.Z <= pos.Z + size.Z) then
                return true
            end
        end
    end
    return false
end

local function WarpBehindNearestEnemy()
    local nearestTarget
    local shortestDistance = math.huge

    for _, target in pairs(Players:GetPlayers()) do
        if target ~= LocalPlayer then
            if target.Character and target.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChild("Humanoid") then
                local hrp = target.Character.HumanoidRootPart
                local humanoid = target.Character.Humanoid

                if target.Team ~= LocalPlayer.Team and humanoid.Health > 0 and not IsInSafeZone(hrp.Position) then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestTarget = target
                    end
                end
            end
        end
    end

    if nearestTarget then
        local targetHRP = nearestTarget.Character.HumanoidRootPart
        local offset = targetHRP.CFrame.LookVector * -51
        LocalPlayer.Character.HumanoidRootPart.CFrame = targetHRP.CFrame + offset
    end
end

-- ลูปเรียลไทม์ทุก 0.5 วินาที
while true do
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        WarpBehindNearestEnemy()
    end
    wait(0.5) -- ปรับความถี่ตามต้องการ
end
