-- โหลด GUI Ash-Libs
local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/BloodLetters/Ash-Libs/refs/heads/main/source.lua"))()

-- ตั้งค่าหน้าหลัก
GUI:CreateMain({
    Name = "Ashlabs",
    title = "Ashlabs GUI v2",
    ToggleUI = "K",
    WindowIcon = "home",
    Theme = {
        Background = Color3.fromRGB(25, 25, 35),
        Secondary = Color3.fromRGB(35, 35, 45),
        Accent = Color3.fromRGB(138, 43, 226),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 180, 180),
        Border = Color3.fromRGB(50, 50, 60),
        NavBackground = Color3.fromRGB(20, 20, 30)
    },
    Blur = { Enable = false, value = 0.2 }
})

-- แท็บหลัก
local main = GUI:CreateTab("หลัก", "home")
GUI:CreateSection({ parent = main, text = "ระบบเก็บผลไม้และสัตว์อัตโนมัติ (v2)" })

-- ตัวแปรหลัก
getgenv().AutoCow = false
getgenv().AutoChicken = false
getgenv().AutoMango = false
getgenv().AutoTree = false
getgenv().AutoDurian = false
getgenv().AutoPineapple = false

-- ปุ่มเปิด/ปิดแต่ละระบบ
GUI:CreateToggle({ parent = main, text = "🐄 เก็บวัวอัตโนมัติ", default = false, callback = function(v) getgenv().AutoCow = v end })
GUI:CreateToggle({ parent = main, text = "🐔 เก็บไก่อัตโนมัติ", default = false, callback = function(v) getgenv().AutoChicken = v end })
GUI:CreateToggle({ parent = main, text = "🥭 เก็บมะม่วงอัตโนมัติ", default = false, callback = function(v) getgenv().AutoMango = v end })
GUI:CreateToggle({ parent = main, text = "🌳 เก็บต้นไม้อัตโนมัติ", default = false, callback = function(v) getgenv().AutoTree = v end })
GUI:CreateToggle({ parent = main, text = "🥥 เก็บทุเรียนอัตโนมัติ", default = false, callback = function(v) getgenv().AutoDurian = v end })
GUI:CreateToggle({ parent = main, text = "🍍 เก็บสับปะรดอัตโนมัติ", default = false, callback = function(v) getgenv().AutoPineapple = v end })

-- 🧠 ตรวจจับตัวละครใหม่เสมอ
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(newChar)
	char = newChar
	root = newChar:WaitForChild("HumanoidRootPart")
end)

-- ⚡ AutoFarm Loop รวมทุกระบบ
task.spawn(function()
	while task.wait(0.1) do
		if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
			player.CharacterAdded:Wait()
			root = player.Character:WaitForChild("HumanoidRootPart")
			continue
		end

		-- 🐄 วัว
		if getgenv().AutoCow then
			for _, cow in pairs(workspace.Plants.Cow:GetChildren()) do
				local cube = cow:FindFirstChild("Cube")
				if cube and cube:FindFirstChild("ProximityPrompt") then
					root.CFrame = CFrame.new(cube.Position + Vector3.new(0,0,-2))
					cube.ProximityPrompt.HoldDuration = 0
					pcall(function() fireproximityprompt(cube.ProximityPrompt) end)
				end
			end
		end

		-- 🐔 ไก่
		if getgenv().AutoChicken then
			for _, chicken in pairs(workspace.Plants.Chicken:GetChildren()) do
				local obj = chicken:FindFirstChild("Object_1")
				if obj and obj:FindFirstChild("ProximityPrompt") then
					root.CFrame = CFrame.new(obj.Position + Vector3.new(0,0,-2))
					obj.ProximityPrompt.HoldDuration = 0
					pcall(function() fireproximityprompt(obj.ProximityPrompt) end)
				end
			end
		end

		-- 🥭 มะม่วง
		if getgenv().AutoMango then
			for _, mango in pairs(workspace.Plants.Mango:GetChildren()) do
				local model = mango:FindFirstChild("Model")
				if model and model:FindFirstChild("Trunk") then
					local attach = model.Trunk:FindFirstChild("Attachment")
					if attach and attach:FindFirstChild("ProximityPrompt") then
						root.CFrame = CFrame.new(model.Trunk.Position + Vector3.new(0,0,-2))
						attach.ProximityPrompt.HoldDuration = 0
						pcall(function() fireproximityprompt(attach.ProximityPrompt) end)
					end
				end
			end
		end

		-- 🌳 ต้นไม้
		if getgenv().AutoTree then
			for _, tree in pairs(workspace.Plants.Tree:GetChildren()) do
				local trunk = tree:FindFirstChild("Trunk")
				if trunk and trunk:FindFirstChild("AttachText") then
					local attach = trunk.AttachText:FindFirstChild("ProximityPrompt")
					if attach then
						root.CFrame = CFrame.new(trunk.Position + Vector3.new(0,0,-2))
						attach.HoldDuration = 0
						pcall(function() fireproximityprompt(attach) end)
					end
				end
			end
		end

		-- 🥥 ทุเรียน
		if getgenv().AutoDurian then
			for _, durian in pairs(workspace.Plants.Durian:GetChildren()) do
				local model = durian:FindFirstChild("Model")
				if model and model:FindFirstChild("Trunk") then
					local attach = model.Trunk:FindFirstChild("Attachment")
					if attach and attach:FindFirstChild("ProximityPrompt") then
						root.CFrame = CFrame.new(model.Trunk.Position + Vector3.new(0,0,-2))
						attach.ProximityPrompt.HoldDuration = 0
						pcall(function() fireproximityprompt(attach.ProximityPrompt) end)
					end
				end
			end
		end

		-- 🍍 สับปะรด
		if getgenv().AutoPineapple then
			for _, pineapple in pairs(workspace.Plants.Pineapple:GetChildren()) do
				local model = pineapple:FindFirstChild("Model")
				if model then
					for _, child in pairs(model:GetChildren()) do
						if child:FindFirstChild("ProximityPrompt") then
							root.CFrame = CFrame.new(child.Position + Vector3.new(0,0,-2))
							child.ProximityPrompt.HoldDuration = 0
							pcall(function() fireproximityprompt(child.ProximityPrompt) end)
						end
					end
				end
			end
		end
	end
end)

----------------------------------------------------
-- 🏥 ระบบหมอ / Medic
----------------------------------------------------
local main2 = GUI:CreateTab("หมอ", "briefcase-medical")
GUI:CreateSection({ parent = main2, text = "ระบบรักษาและวาร์ป (v2)" })

-- วาร์ปไปโรงพยาบาล
GUI:CreateButton({
	parent = main2,
	text = "🏥 วาร์ปไปโรงพยาบาล",
	callback = function()
		if root then
			root.CFrame = CFrame.new(-230.932831, 4.692873, 1498.82788)
		end
	end
})

-- วาร์ปไปหาคนเจ็บ
GUI:CreateButton({
	parent = main2,
	text = "🚑 วาร์ปไปหาคนเจ็บ",
	callback = function()
		for _, obj in ipairs(workspace:GetChildren()) do
			local humanoid = obj:FindFirstChildOfClass("Humanoid")
			local hrp = obj:FindFirstChild("HumanoidRootPart")
			if humanoid and hrp and humanoid.Health <= 10 then
				root.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
				break
			end
		end
	end
})

-- 💉 AutoMedic (รักษาอัตโนมัติ)
GUI:CreateToggle({
	parent = main2,
	text = "💉 AutoMedic (รักษาอัตโนมัติ)",
	default = false,
	callback = function(state)
		getgenv().AutoMedic = state
		task.spawn(function()
			while getgenv().AutoMedic do
				for _, obj in ipairs(workspace:GetChildren()) do
					local humanoid = obj:FindFirstChildOfClass("Humanoid")
					local hrp = obj:FindFirstChild("HumanoidRootPart")
					if humanoid and hrp and humanoid.Health <= 10 then
						local prompt = hrp:FindFirstChild("Medic_Prompt")
						if prompt and prompt:IsA("ProximityPrompt") then
							prompt.HoldDuration = 0
							pcall(function() fireproximityprompt(prompt) end)
						end
					end
				end
				task.wait(0.1)
			end
		end)
	end
})

-- 🚑 วาร์ปอัตโนมัติไปรักษา
GUI:CreateToggle({
	parent = main2,
	text = "🚑 วาร์ปอัตโนมัติไปรักษา",
	default = false,
	callback = function(state)
		getgenv().AutoWarpMedic = state
		task.spawn(function()
			while getgenv().AutoWarpMedic do
				for _, obj in ipairs(workspace:GetChildren()) do
					local humanoid = obj:FindFirstChildOfClass("Humanoid")
					local hrp = obj:FindFirstChild("HumanoidRootPart")
					if humanoid and hrp and humanoid.Health <= 10 then
						root.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
						break
					end
				end
				task.wait()
			end
		end)
	end
})
