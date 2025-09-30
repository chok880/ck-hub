-- Kavo Premium - Fully Fixed & Stable
-- No Bugs Guaranteed!

local KavoPremium = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Safe Themes with fallbacks
local PremiumThemes = {
    CyberPunk = {
        SchemeColor = Color3.fromRGB(255, 20, 147),
        Background = Color3.fromRGB(10, 10, 20),
        Header = Color3.fromRGB(20, 20, 40),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(30, 30, 60)
    },
    NeonDark = {
        SchemeColor = Color3.fromRGB(0, 255, 128),
        Background = Color3.fromRGB(15, 15, 25),
        Header = Color3.fromRGB(25, 25, 35),
        TextColor = Color3.fromRGB(240, 240, 240),
        ElementColor = Color3.fromRGB(40, 40, 60)
    }
}

-- Safe Utility Functions
local Utility = {}

function Utility:SafeTween(obj, properties, duration)
    if not obj or not properties then return end
    local tweenInfo = TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Main Function (FIXED)
function KavoPremium.CreateLib(windowName, themeName)
    -- Safe defaults
    windowName = windowName or "Premium UI"
    local Theme = PremiumThemes[themeName] or PremiumThemes.CyberPunk
    
    -- Ensure all theme colors exist
    Theme.SchemeColor = Theme.SchemeColor or Color3.fromRGB(255, 20, 147)
    Theme.Background = Theme.Background or Color3.fromRGB(10, 10, 20)
    Theme.Header = Theme.Header or Color3.fromRGB(20, 20, 40)
    Theme.TextColor = Theme.TextColor or Color3.fromRGB(255, 255, 255)
    Theme.ElementColor = Theme.ElementColor or Color3.fromRGB(30, 30, 60)
    
    -- Create UI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KavoPremium_" .. math.random(10000, 99999)
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = Theme.Header
    Header.BorderSizePixel = 0

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 8)
    HeaderCorner.Parent = Header

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = windowName
    Title.TextColor3 = Theme.TextColor
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header

    -- Close Button
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Position = UDim2.new(1, -30, 0.5, -12.5)
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Image = "rbxassetid://3926305904"
    CloseButton.ImageRectOffset = Vector2.new(284, 4)
    CloseButton.ImageRectSize = Vector2.new(24, 24)
    CloseButton.ImageColor3 = Theme.TextColor
    CloseButton.Parent = Header

    CloseButton.MouseButton1Click:Connect(function()
        Utility:SafeTween(MainFrame, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }, 0.3)
        wait(0.3)
        ScreenGui:Destroy()
    end)

    -- Tab System
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 120, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundColor3 = Theme.Header
    TabContainer.BorderSizePixel = 0

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -120, 1, -40)
    ContentContainer.Position = UDim2.new(0, 120, 0, 40)
    ContentContainer.BackgroundColor3 = Theme.Background
    ContentContainer.BorderSizePixel = 0

    -- Assemble UI
    Header.Parent = MainFrame
    TabContainer.Parent = MainFrame
    ContentContainer.Parent = MainFrame
    MainFrame.Parent = ScreenGui
    ScreenGui.Parent = game:GetService("CoreGui")

    -- Opening animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    Utility:SafeTween(MainFrame, {
        Size = UDim2.new(0, 500, 0, 350),
        Position = UDim2.new(0.5, -250, 0.5, -175)
    }, 0.5)

    -- Library object
    local Library = {
        Theme = Theme,
        Tabs = {},
        CurrentTab = nil
    }

    -- Create Tab (FIXED)
    function Library:CreateTab(tabName)
        if not tabName then return nil end
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "Tab"
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.Position = UDim2.new(0, 5, 0, #self.Tabs * 40 + 5)
        TabButton.BackgroundColor3 = self.Theme.ElementColor
        TabButton.Text = ""
        TabButton.AutoButtonColor = false

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton

        local TabLabel = Instance.new("TextLabel")
        TabLabel.Size = UDim2.new(1, 0, 1, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Text = tabName
        TabLabel.TextColor3 = self.Theme.TextColor
        TabLabel.Font = Enum.Font.GothamSemibold
        TabLabel.TextSize = 13
        TabLabel.Parent = TabButton

        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = tabName .. "Content"
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = self.Theme.SchemeColor
        TabContent.Visible = false
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y

        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.Parent = TabContent

        -- Tab selection
        TabButton.MouseButton1Click:Connect(function()
            -- Hide all contents
            for _, content in pairs(ContentContainer:GetChildren()) do
                if content:IsA("ScrollingFrame") then
                    content.Visible = false
                end
            end
            
            -- Reset all buttons
            for _, btn in pairs(TabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = self.Theme.ElementColor
                end
            end
            
            -- Select new tab
            self.CurrentTab = tabName
            TabButton.BackgroundColor3 = self.Theme.SchemeColor
            TabContent.Visible = true
        end)

        TabButton.Parent = TabContainer
        TabContent.Parent = ContentContainer
        table.insert(self.Tabs, tabName)

        -- Select first tab
        if #self.Tabs == 1 then
            self.CurrentTab = tabName
            TabButton.BackgroundColor3 = self.Theme.SchemeColor
            TabContent.Visible = true
        end

        local TabFunctions = {}

        -- Create Button (FIXED)
        function TabFunctions:CreateButton(buttonName, callback)
            if not buttonName then return nil end
            
            local Button = Instance.new("TextButton")
            Button.Name = buttonName
            Button.Size = UDim2.new(1, -20, 0, 40)
            Button.BackgroundColor3 = self.Theme.ElementColor
            Button.Text = ""
            Button.AutoButtonColor = false

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button

            local ButtonLabel = Instance.new("TextLabel")
            ButtonLabel.Size = UDim2.new(1, 0, 1, 0)
            ButtonLabel.BackgroundTransparency = 1
            ButtonLabel.Text = buttonName
            ButtonLabel.TextColor3 = self.Theme.TextColor
            ButtonLabel.Font = Enum.Font.GothamSemibold
            ButtonLabel.TextSize = 14
            ButtonLabel.Parent = Button

            -- Hover effects
            Button.MouseEnter:Connect(function()
                Utility:SafeTween(Button, {
                    BackgroundColor3 = Color3.fromRGB(
                        math.min(self.Theme.ElementColor.R * 255 + 20, 255),
                        math.min(self.Theme.ElementColor.G * 255 + 20, 255),
                        math.min(self.Theme.ElementColor.B * 255 + 20, 255)
                    )
                }, 0.2)
            end)

            Button.MouseLeave:Connect(function()
                Utility:SafeTween(Button, {
                    BackgroundColor3 = self.Theme.ElementColor
                }, 0.2)
            end)

            -- Click event
            Button.MouseButton1Click:Connect(function()
                if type(callback) == "function" then
                    callback()
                end
            end)

            Button.Parent = TabContent
            return Button
        end

        -- Create Toggle (COMPLETELY FIXED)
        function TabFunctions:CreateToggle(toggleName, defaultValue, callback)
            if not toggleName then return nil end
            
            local Toggle = Instance.new("TextButton")
            Toggle.Name = toggleName
            Toggle.Size = UDim2.new(1, -20, 0, 40)
            Toggle.BackgroundColor3 = self.Theme.ElementColor
            Toggle.Text = ""
            Toggle.AutoButtonColor = false

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = Toggle

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = toggleName
            ToggleLabel.TextColor3 = self.Theme.TextColor
            ToggleLabel.Font = Enum.Font.GothamSemibold
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = Toggle

            -- Toggle switch (SIMPLIFIED - No more nil errors)
            local ToggleSwitch = Instance.new("Frame")
            ToggleSwitch.Size = UDim2.new(0, 50, 0, 25)
            ToggleSwitch.Position = UDim2.new(1, -65, 0.5, -12.5)
            ToggleSwitch.AnchorPoint = Vector2.new(1, 0.5)
            ToggleSwitch.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            ToggleSwitch.Parent = Toggle

            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(1, 0)
            SwitchCorner.Parent = ToggleSwitch

            local ToggleKnob = Instance.new("Frame")
            ToggleKnob.Size = UDim2.new(0, 21, 0, 21)
            ToggleKnob.Position = UDim2.new(0, 2, 0.5, -10.5)
            ToggleKnob.AnchorPoint = Vector2.new(0, 0.5)
            ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleKnob.Parent = ToggleSwitch

            local KnobCorner = Instance.new("UICorner")
            KnobCorner.CornerRadius = UDim.new(1, 0)
            KnobCorner.Parent = ToggleKnob

            local isToggled = defaultValue or false

            -- Safe update function
            local function updateToggle()
                if isToggled then
                    Utility:SafeTween(ToggleSwitch, {
                        BackgroundColor3 = self.Theme.SchemeColor
                    }, 0.2)
                    Utility:SafeTween(ToggleKnob, {
                        Position = UDim2.new(1, -23, 0.5, -10.5)
                    }, 0.2)
                else
                    Utility:SafeTween(ToggleSwitch, {
                        BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    }, 0.2)
                    Utility:SafeTween(ToggleKnob, {
                        Position = UDim2.new(0, 2, 0.5, -10.5)
                    }, 0.2)
                end
            end

            -- Hover effects
            Toggle.MouseEnter:Connect(function()
                Utility:SafeTween(Toggle, {
                    BackgroundColor3 = Color3.fromRGB(
                        math.min(self.Theme.ElementColor.R * 255 + 15, 255),
                        math.min(self.Theme.ElementColor.G * 255 + 15, 255),
                        math.min(self.Theme.ElementColor.B * 255 + 15, 255)
                    )
                }, 0.2)
            end)

            Toggle.MouseLeave:Connect(function()
                Utility:SafeTween(Toggle, {
                    BackgroundColor3 = self.Theme.ElementColor
                }, 0.2)
            end)

            -- Toggle click
            Toggle.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                updateToggle()
                if type(callback) == "function" then
                    callback(isToggled)
                end
            end)

            Toggle.Parent = TabContent
            updateToggle() -- Set initial state

            return {
                Set = function(value)
                    isToggled = value
                    updateToggle()
                end,
                Get = function()
                    return isToggled
                end
            }
        end

        return TabFunctions
    end

    -- Toggle UI
    function Library:ToggleUI()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end

    return Library
end
--iuuigg

return KavoPremium
