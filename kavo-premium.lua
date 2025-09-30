-- Kavo Premium - Enhanced UI Library
-- Redesigned with modern features and better performance

local KavoPremium = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- Enhanced color schemes
local PremiumThemes = {
    CyberPunk = {
        SchemeColor = Color3.fromRGB(255, 20, 147),  -- Hot Pink
        Background = Color3.fromRGB(10, 10, 20),
        Header = Color3.fromRGB(20, 20, 40),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(30, 30, 60),
        AccentColor = Color3.fromRGB(0, 255, 255)   -- Cyan
    },
    NeonDark = {
        SchemeColor = Color3.fromRGB(0, 255, 128),  -- Green
        Background = Color3.fromRGB(15, 15, 25),
        Header = Color3.fromRGB(25, 25, 35),
        TextColor = Color3.fromRGB(240, 240, 240),
        ElementColor = Color3.fromRGB(40, 40, 60),
        AccentColor = Color3.fromRGB(255, 255, 0)   -- Yellow
    },
    RoyalGold = {
        SchemeColor = Color3.fromRGB(255, 215, 0),  -- Gold
        Background = Color3.fromRGB(30, 25, 15),
        Header = Color3.fromRGB(50, 40, 20),
        TextColor = Color3.fromRGB(255, 250, 240),
        ElementColor = Color3.fromRGB(70, 60, 30),
        AccentColor = Color3.fromRGB(192, 192, 192) -- Silver
    },
    OceanBlue = {
        SchemeColor = Color3.fromRGB(0, 150, 255),  -- Blue
        Background = Color3.fromRGB(10, 20, 40),
        Header = Color3.fromRGB(20, 40, 80),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(30, 60, 120),
        AccentColor = Color3.fromRGB(0, 255, 255)   -- Cyan
    }
}

-- Utility functions
local Utility = {}

function Utility:TweenObject(obj, properties, duration, easingStyle, easingDirection)
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.Out
    local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
    TweenService:Create(obj, tweenInfo, properties):Play()
end

function Utility:CreateRippleEffect(button)
    local ripple = Instance.new("ImageLabel")
    ripple.Name = "Ripple"
    ripple.Image = "rbxassetid://4560909609"
    ripple.BackgroundTransparency = 1
    ripple.ImageTransparency = 0.6
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.ImageColor3 = button.BackgroundColor3
    ripple.Parent = button
    
    Utility:TweenObject(ripple, {
        Size = UDim2.new(2, 0, 2, 0),
        ImageTransparency = 1
    }, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    delay(0.5, function()
        ripple:Destroy()
    end)
end

-- Enhanced Dragging with smooth movement
function KavoPremium:EnhancedDragging(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            Utility:TweenObject(frame, {BackgroundTransparency = 0.8}, 0.1)
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    Utility:TweenObject(frame, {BackgroundTransparency = 1}, 0.1)
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            Utility:TweenObject(parent, {
                Position = UDim2.new(
                    framePos.X.Scale, 
                    framePos.X.Offset + delta.X, 
                    framePos.Y.Scale, 
                    framePos.Y.Offset + delta.Y
                )
            }, 0.1)
        end
    end)
end

-- Main Library Creation
function KavoPremium.CreateLib(windowName, selectedTheme, premiumFeatures)
    windowName = windowName or "Premium UI"
    selectedTheme = PremiumThemes[selectedTheme] or PremiumThemes.CyberPunk
    premiumFeatures = premiumFeatures or {}
    
    -- Create main UI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KavoPremium_" .. HttpService:GenerateGUID(false):sub(1, 8)
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Main Container with glow effect
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer"
    MainContainer.Size = UDim2.new(0, 550, 0, 350)
    MainContainer.Position = UDim2.new(0.5, -275, 0.5, -175)
    MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    MainContainer.BackgroundColor3 = selectedTheme.Background
    MainContainer.BorderSizePixel = 0
    
    -- Glow Effect
    local UIGlow = Instance.new("UIStroke")
    UIGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIGlow.Color = selectedTheme.SchemeColor
    UIGlow.Thickness = 2
    UIGlow.Transparency = 0.7
    UIGlow.Parent = MainContainer
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainContainer
    
    -- Enhanced Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = selectedTheme.Header
    Header.BorderSizePixel = 0
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = windowName
    Title.TextColor3 = selectedTheme.TextColor
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close button with hover effect
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Position = UDim2.new(1, -30, 0.5, -12.5)
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Image = "rbxassetid://3926305904"
    CloseButton.ImageRectOffset = Vector2.new(284, 4)
    CloseButton.ImageRectSize = Vector2.new(24, 24)
    CloseButton.ImageColor3 = selectedTheme.TextColor
    
    CloseButton.MouseEnter:Connect(function()
        Utility:TweenObject(CloseButton, {ImageColor3 = Color3.fromRGB(255, 50, 50)}, 0.2)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        Utility:TweenObject(CloseButton, {ImageColor3 = selectedTheme.TextColor}, 0.2)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Utility:TweenObject(MainContainer, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Apply dragging to header
    KavoPremium:EnhancedDragging(Header, MainContainer)
    
    -- Tab system
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 120, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundColor3 = selectedTheme.Header
    TabContainer.BorderSizePixel = 0
    
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -120, 1, -40)
    ContentContainer.Position = UDim2.new(0, 120, 0, 40)
    ContentContainer.BackgroundColor3 = selectedTheme.Background
    ContentContainer.BorderSizePixel = 0
    
    -- Assemble UI
    Title.Parent = Header
    CloseButton.Parent = Header
    Header.Parent = MainContainer
    TabContainer.Parent = MainContainer
    ContentContainer.Parent = MainContainer
    MainContainer.Parent = ScreenGui
    ScreenGui.Parent = game.CoreGui
    
    -- Animation on open
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    Utility:TweenObject(MainContainer, {
        Size = UDim2.new(0, 550, 0, 350),
        Position = UDim2.new(0.5, -275, 0.5, -175)
    }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    local Library = {
        Theme = selectedTheme,
        Tabs = {},
        CurrentTab = nil
    }
    
    -- Enhanced Tab Creation
    function Library:CreateTab(tabName, tabIcon)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "Tab"
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.Position = UDim2.new(0, 5, 0, #self.Tabs * 40 + 5)
        TabButton.BackgroundColor3 = self.Theme.ElementColor
        TabButton.Text = ""
        TabButton.AutoButtonColor = false
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabButton
        
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Size = UDim2.new(1, -10, 1, 0)
        TabLabel.Position = UDim2.new(0, 10, 0, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Text = tabName
        TabLabel.TextColor3 = self.Theme.TextColor
        TabLabel.Font = Enum.Font.GothamSemibold
        TabLabel.TextSize = 14
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Tab content frame
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = tabName .. "Content"
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.ScrollBarThickness = 3
        TabContent.ScrollBarImageColor3 = self.Theme.SchemeColor
        TabContent.Visible = false
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 5)
        ContentLayout.Parent = TabContent
        
        -- Add hover effects
        TabButton.MouseEnter:Connect(function()
            if self.CurrentTab ~= tabName then
                Utility:TweenObject(TabButton, {
                    BackgroundColor3 = Color3.fromRGB(
                        self.Theme.ElementColor.R * 255 + 20,
                        self.Theme.ElementColor.G * 255 + 20,
                        self.Theme.ElementColor.B * 255 + 20
                    )
                }, 0.2)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if self.CurrentTab ~= tabName then
                Utility:TweenObject(TabButton, {BackgroundColor3 = self.Theme.ElementColor}, 0.2)
            end
        end)
        
        -- Tab selection
        TabButton.MouseButton1Click:Connect(function()
            -- Deselect previous tab
            if self.CurrentTab then
                Utility:TweenObject(TabContainer:FindFirstChild(self.CurrentTab .. "Tab"), {
                    BackgroundColor3 = self.Theme.ElementColor
                }, 0.2)
            end
            
            -- Hide previous content
            for _, content in pairs(ContentContainer:GetChildren()) do
                content.Visible = false
            end
            
            -- Select new tab
            self.CurrentTab = tabName
            Utility:TweenObject(TabButton, {
                BackgroundColor3 = self.Theme.SchemeColor
            }, 0.2)
            
            TabContent.Visible = true
            Utility:CreateRippleEffect(TabButton)
        end)
        
        -- Assemble tab
        TabLabel.Parent = TabButton
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
        
        -- Enhanced Button with icon support
        function TabFunctions:CreateButton(buttonName, callback, buttonIcon)
            local Button = Instance.new("TextButton")
            Button.Name = buttonName
            Button.Size = UDim2.new(1, -20, 0, 40)
            Button.BackgroundColor3 = self.Theme.ElementColor
            Button.Text = ""
            Button.AutoButtonColor = false
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Parent = Button
            
            local ButtonLabel = Instance.new("TextLabel")
            ButtonLabel.Size = UDim2.new(1, -50, 1, 0)
            ButtonLabel.Position = UDim2.new(0, 45, 0, 0)
            ButtonLabel.BackgroundTransparency = 1
            ButtonLabel.Text = buttonName
            ButtonLabel.TextColor3 = self.Theme.TextColor
            ButtonLabel.Font = Enum.Font.GothamSemibold
            ButtonLabel.TextSize = 14
            ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            -- Button icon
            if buttonIcon then
                local Icon = Instance.new("ImageLabel")
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.Position = UDim2.new(0, 15, 0.5, -10)
                Icon.BackgroundTransparency = 1
                Icon.Image = buttonIcon
                Icon.ImageColor3 = self.Theme.SchemeColor
                Icon.Parent = Button
            end
            
            -- Hover effects
            Button.MouseEnter:Connect(function()
                Utility:TweenObject(Button, {
                    BackgroundColor3 = Color3.fromRGB(
                        self.Theme.ElementColor.R * 255 + 15,
                        self.Theme.ElementColor.G * 255 + 15,
                        self.Theme.ElementColor.B * 255 + 15
                    )
                }, 0.2)
            end)
            
            Button.MouseLeave:Connect(function()
                Utility:TweenObject(Button, {BackgroundColor3 = self.Theme.ElementColor}, 0.2)
            end)
            
            -- Click effect
            Button.MouseButton1Click:Connect(function()
                Utility:CreateRippleEffect(Button)
                if callback then
                    callback()
                end
            end)
            
            ButtonLabel.Parent = Button
            Button.Parent = TabContent
            
            return Button
        end
        
        -- Enhanced Toggle with animation
        function TabFunctions:CreateToggle(toggleName, defaultValue, callback)
            local Toggle = Instance.new("TextButton")
            Toggle.Name = toggleName
            Toggle.Size = UDim2.new(1, -20, 0, 35)
            Toggle.BackgroundColor3 = self.Theme.ElementColor
            Toggle.Text = ""
            Toggle.AutoButtonColor = false
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 8)
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
            
            -- Toggle switch
            local ToggleSwitch = Instance.new("Frame")
            ToggleSwitch.Size = UDim2.new(0, 50, 0, 25)
            ToggleSwitch.Position = UDim2.new(1, -65, 0.5, -12.5)
            ToggleSwitch.AnchorPoint = Vector2.new(1, 0.5)
            ToggleSwitch.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            
            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(1, 0)
            SwitchCorner.Parent = ToggleSwitch
            
            local ToggleKnob = Instance.new("Frame")
            ToggleKnob.Size = UDim2.new(0, 21, 0, 21)
            ToggleKnob.Position = UDim2.new(0, 2, 0.5, -10.5)
            ToggleKnob.AnchorPoint = Vector2.new(0, 0.5)
            ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            
            local KnobCorner = Instance.new("UICorner")
            KnobCorner.CornerRadius = UDim.new(1, 0)
            KnobCorner.Parent = ToggleKnob
            
            local isToggled = defaultValue or false
            
            local function updateToggle()
                if isToggled then
                    Utility:TweenObject(ToggleSwitch, {BackgroundColor3 = self.Theme.SchemeColor}, 0.2)
                    Utility:TweenObject(ToggleKnob, {Position = UDim2.new(1, -23, 0.5, -10.5)}, 0.2)
                else
                    Utility:TweenObject(ToggleSwitch, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}, 0.2)
                    Utility:TweenObject(ToggleKnob, {Position = UDim2.new(0, 2, 0.5, -10.5)}, 0.2)
                end
            end
            
            Toggle.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                updateToggle()
                Utility:CreateRippleEffect(Toggle)
                if callback then
                    callback(isToggled)
                end
            end)
            
            ToggleKnob.Parent = ToggleSwitch
            ToggleSwitch.Parent = Toggle
            ToggleLabel.Parent = Toggle
            Toggle.Parent = TabContent
            
            updateToggle()
            
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
    
    -- Toggle UI visibility
    function Library:ToggleUI()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
    
    return Library
end

return KavoPremium
