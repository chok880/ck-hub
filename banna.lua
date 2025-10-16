-- โหลด Luna Interface
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua"))()

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Character Setup
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- ค่าปรับความเร็ว Auto Farm
local go = 0.3
local to = 0.5

-- ตัวแปรควบคุม
getgenv().AutoFarmCow = false
getgenv().AutoFarmMango = false

-- GUI Teleport Button (วาร์ปไปผู้เล่น/NPC ที่ตาย)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeleportUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0, 180, 0, 50)
TeleportButton.Position = UDim2.new(0.5, -90, 0.85, 0)
TeleportButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
TeleportButton.TextColor3 = Color3.new(1, 1, 1)
TeleportButton.Text = "วาร์ปไปผู้เล่น/NPC ที่ตาย"
TeleportButton.Font = Enum.Font.SourceSansBold
TeleportButton.TextSize = 18
TeleportButton.Parent = ScreenGui

-- ฟังก์ชันวาร์ปไปผู้เล่น/NPC ที่ตาย
local function teleportToDeadCharacter()
	for _, obj in ipairs(workspace:GetChildren()) do
		if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
			local humanoid = obj.Humanoid
			local targetRoot = obj.HumanoidRootPart
			if humanoid.Health <= 10 then
				root.CFrame = targetRoot.CFrame + Vector3.new(0,3,0)
				print("วาร์ปไปยัง:", obj.Name)
				return true
			end
		end
	end
	return false
end

TeleportButton.MouseButton1Click:Connect(function()
	local success = teleportToDeadCharacter()
	if success then
		TeleportButton.Text = "✅ วาร์ปสำเร็จ!"
		TeleportButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	else
		TeleportButton.Text = "❌ ไม่มีตัวที่ตาย"
		TeleportButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	end
	task.delay(2, function()
		TeleportButton.Text = "วาร์ปไปผู้เล่น/NPC ที่ตาย"
		TeleportButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
	end)
end)

-- ฟังก์ชันฟาร์มวัว
local function farmCows()
	for _, cow in pairs(workspace.Plants.Cow:GetChildren()) do
		if not getgenv().AutoFarmCow then break end
		if cow:FindFirstChild("Cube") and cow.Cube:FindFirstChild("ProximityPrompt") then
			local prompt = cow.Cube.ProximityPrompt
			root.CFrame = cow.Cube.CFrame * CFrame.new(0,0,3)
			task.wait(to)
			if not getgenv().AutoFarmCow then break end
			prompt:InputHoldBegin()
			task.wait(go)
			prompt:InputHoldEnd()
		end
	end
end

-- ฟังก์ชันฟาร์มมะม่วง
local function farmMangos()
	for _, mango in pairs(workspace.Plants.Mango:GetChildren()) do
		if not getgenv().AutoFarmMango then break end
		local model = mango:FindFirstChild("Model")
		if model and model:FindFirstChild("Trunk") then
			local trunk = model.Trunk
			local attach = trunk:FindFirstChild("Attachment")
			if attach and attach:FindFirstChild("ProximityPrompt") then
				local prompt = attach.ProximityPrompt
				root.CFrame = trunk.CFrame * CFrame.new(0,0,3)
				task.wait(to)
				if not getgenv().AutoFarmMango then break end
				prompt:InputHoldBegin()
				task.wait(go)
				prompt:InputHoldEnd()
			end
		end
	end
end

-- ลูปฟาร์มอัตโนมัติ
task.spawn(function()
	while true do
		if getgenv().AutoFarmCow then pcall(farmCows) end
		if getgenv().AutoFarmMango then pcall(farmMangos) end
		RunService.Heartbeat:Wait()
	end
end)

-- สร้าง Luna Window และแท็บ
local window = Luna:CreateWindow({
	Title = "Chok Hub",
	SubTitle = "Auto Farm + Medical + Event",
	Size = UDim2.new(0, 350, 0, 250)
})

-- แท็บฟาร์ม
local farmTab = window:CreateTab({ Title = "ฟาร์มอัตโนมัติ" })
farmTab:CreateToggle({
	Name = "Auto Cow",
	Default = false,
	Callback = function(state) getgenv().AutoFarmCow = state end
})
farmTab:CreateToggle({
	Name = "Auto Mango",
	Default = false,
	Callback = function(state) getgenv().AutoFarmMango = state end
})

-- แท็บหมอ
local medicalTab = window:CreateTab({ Title = "หมอ" })
medicalTab:CreateToggle({
	Name = "เปิด/ปิด Teleport UI",
	Default = true,
	Callback = function(state) ScreenGui.Enabled = state end
})
medicalTab:CreateButton({
	Name = "วาร์ปไปโรงบาล",
	Callback = function()
		root.CFrame = CFrame.new(-230.932831, 4.692873, 1498.82788, 1,0,0,0,1,0,0,0,1)
		print("วาร์ปไปโรงบาลเรียบร้อย")
	end
})

-- แท็บอีเวนต์
local eventTab = window:CreateTab({ Title = "อีเวนต์" })
eventTab:CreateButton({
	Name = "วาร์ปไป Halloween Gems ทั้งหมด",
	Callback = function()
		for _, gem in pairs(workspace["Halloween Gems"]:GetChildren()) do
			if gem:FindFirstChild("HumanoidRootPart") then
				root.CFrame = gem.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
				task.wait(0.5) -- เว้นระยะก่อนวาร์ปตัวถัดไป
			elseif gem:IsA("BasePart") then
				root.CFrame = gem.CFrame + Vector3.new(0,3,0)
				task.wait(0.5)
			end
		end
		print("วาร์ปไป Halloween Gems ทั้งหมดเรียบร้อย")
	end
})
