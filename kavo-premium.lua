-- Kavo Premium - Fixed & Enhanced Version
-- By CK Hub - Completely Rewritten000000

local KavoPremium = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Premium Themes
local PremiumThemes = {
    CyberPunk = {
        SchemeColor = Color3.fromRGB(255, 20, 147),
        Background = Color3.fromRGB(10, 10, 20),
        Header = Color3.fromRGB(20, 20, 40),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(30, 30, 60),
        AccentColor = Color3.fromRGB(0, 255, 255)
    },
    NeonDark = {
        SchemeColor = Color3.fromRGB(0, 255, 128),
        Background = Color3.fromRGB(15, 15, 25),
        Header = Color3.fromRGB(25, 25, 35),
        TextColor = Color3.fromRGB(240, 240, 240),
        ElementColor = Color3.fromRGB(40, 40, 60),
        AccentColor = Color3.fromRGB(255, 255, 0)
    },
    RoyalGold = {
        SchemeColor = Color3.fromRGB(255, 215, 0),
        Background = Color3.fromRGB(30, 25, 15),
        Header = Color3.fromRGB(50, 40, 20),
        TextColor = Color3.fromRGB(255, 250, 240),
        ElementColor = Color3.fromRGB(70, 60, 30),
        AccentColor = Color3.fromRGB(192, 192, 192)
    },
    OceanBlue = {
        SchemeColor = Color3.fromRGB(0, 150, 255),
        Background = Color3.fromRGB(10, 20, 40),
        Header = Color3.fromRGB(20, 40, 80),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(30, 60, 120),
        AccentColor = Color3.fromRGB(0, 255, 255)
    }
}

-- Utility Functions
local Utility = {}

function Utility:TweenObject(obj, properties, duration, easingStyle, easingDirection)
    if not obj or not properties then return end
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.Out
    local tweenInfo = TweenInfo.new(duration or 0.3, easingStyle, easingDirection)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

function Utility:CreateRippleEffect(button)
    if not button then return end
    local ripple = Instance.new("ImageLabel")
    ripple.Name = "Ripple"
    ripple.Image = "rbxassetid://4560909609"
    ripple.BackgroundTransparency = 1
    ripple.ImageTransparency = 0.6
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.ImageColor3 = button.BackgroundColor3 or Color3.fromRGB(255, 255, 255)
    ripple.Parent = button
    ripple.ZIndex = 10
    
    self:TweenObject(ripple, {
        Size = UDim2.new(2, 0, 2, 0),
        ImageTransparency = 1
    }, 0.5)
    
    delay(0.5, function()
        if ripple then
            ripple:Destroy()
        end
    end)
end

-- Main Library Function
function KavoPremium.CreateLib(windowName, themeName)
    -- Default values
    windowName = windowName or "Premium UI"
    themeName = themeName or "CyberPunk"
    
    -- Get theme with fallback
    local Theme = PremiumThemes[themeName] or PremiumThemes.CyberPunk
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KavoPremium_" .. tostring(math.random(1000, 9999))
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Main Container
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer"
    MainContainer.Size = UDim2.new(0, 550, 0, 400)
    MainContainer.Position = UDim2.new(0.5, -275, 0.5, -200)
    MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    MainContainer.BackgroundColor3 = Theme.Background
    MainContainer.BorderSizePixel = 0
    
    -- UI Corner
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainContainer
    
    -- UI Stroke (Glow Effect)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Theme.SchemeColor
    UIStroke.Thickness = 2
    UIStroke.Transparency = 0.7
    UIStroke.Parent = MainContainer
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.BackgroundColor3 = Theme.Header
    Header.BorderSizePixel = 0
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = windowName
    Title.TextColor3 = Theme.TextColor
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
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
    
    CloseButton.MouseEnter:Connect(function()
        Utility:TweenObject(CloseButton, {ImageColor3 = Color3.fromRGB(255, 50, 50)}, 0.2)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        Utility:TweenObject(CloseButton, {ImageColor3 = Theme.TextColor}, 0.2)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Utility:TweenObject(MainContainer, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }, 0.3)
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 130, 1, -45)
    TabContainer.Position = UDim2.new(0, 0, 0, 45)
    TabContainer.BackgroundColor3 = Theme.Header
    TabContainer.BorderSizePixel = 0
    
    local TabContainerCorner = Instance.new("UICorner")
    TabContainerCorner.CornerRadius = UDim.new(0, 12)
    TabContainerCorner.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -130, 1, -45)
    ContentContainer.Position = UDim2.new(0, 130, 0, 45)
    ContentContainer.BackgroundColor3 = Theme.Background
    ContentContainer.BorderSizePixel = 0
    
    -- Assemble UI
    Header.Parent = MainContainer
    TabContainer.Parent = MainContainer
    ContentContainer.Parent = MainContainer
    MainContainer.Parent = ScreenGui
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Opening Animation
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    Utility:TweenObject(MainContainer, {
        Size = UDim2.new(0, 550, 0, 400),
        Position = UDim2.new(0.5, -275, 0.5, -200)
    }, 0.5, Enum.EasingStyle.Back)
    
    -- Library Object
    local Library = {
        Theme = Theme,
        Tabs = {},
        CurrentTab = nil
    }
    
    -- Create Tab Function
    function Library:CreateTab(tabName)
        if not tabName then return nil end
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "Tab"
        TabButton.Size = UDim2.new(1, -10, 0, 40)
        TabButton.Position = UDim2.new(0, 5, 0, #self.Tabs * 45 + 5)
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
        
        -- Hover Effects
        TabButton.MouseEnter:Connect(function()
            if self.CurrentTab ~= tabName then
                Utility:TweenObject(TabButton, {
                    BackgroundColor3 = Color3.fromRGB(
                        math.min(self.Theme.ElementColor.R * 255 + 20, 255),
                        math.min(self.Theme.ElementColor.G * 255 + 20, 255),
                        math.min(self.Theme.ElementColor.B * 255 + 20, 255)
                    )
                }, 0.2)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if self.CurrentTab ~= tabName then
                Utility:TweenObject(TabButton, {
                    BackgroundColor3 = self.Theme.ElementColor
                }, 0.2)
            end
        end)
        
        -- Tab Selection
        TabButton.MouseButton1Click:Connect(function()
            -- Hide all tab contents
            for _, content in pairs(ContentContainer:GetChildren()) do
                if content:IsA("ScrollingFrame") then
                    content.Visible = false
                end
            end
            
            -- Reset all tab buttons
            for _, btn in pairs(TabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    Utility:TweenObject(btn, {
                        BackgroundColor3 = self.Theme.ElementColor
                    }, 0.2)
                end
            end
            
            -- Select new tab
            self.CurrentTab = tabName
            Utility:TweenObject(TabButton, {
                BackgroundColor3 = self.Theme.SchemeColor
            }, 0.2)
            
            TabContent.Visible = true
            Utility:CreateRippleEffect(TabButton)
        end)
        
        -- Add to UI
        TabButton.Parent = TabContainer
        TabContent.Parent = ContentContainer
        table.insert(self.Tabs, tabName)
        
        -- Select first tab
        if #self.Tabs == 1 then
            self.CurrentTab = tabName
            TabButton.BackgroundColor3 = self.Theme.SchemeColor
            TabContent.Visible = true
        end
        
        -- Tab Functions
        local TabFunctions = {}
        
        -- Create Button
        function TabFunctions:CreateButton(buttonName, callback, buttonIcon)
            if not buttonName then return nil end
            
            local Button = Instance.new("TextButton")
            Button.Name = buttonName
            Button.Size = UDim2.new(1, -20, 0, 45)
            Button.BackgroundColor3 = self.Theme.ElementColor
            Button.Text = ""
            Button.AutoButtonColor = false
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Parent = Button
            
            local ButtonLabel = Instance.new("TextLabel")
            ButtonLabel.Size = UDim2.new(1, -50, 1, 0)
            ButtonLabel.Position = UDim2.new(0, 15, 0, 0)
            ButtonLabel.BackgroundTransparency = 1
            ButtonLabel.Text = buttonName
            ButtonLabel.TextColor3 = self.Theme.TextColor
            ButtonLabel.Font = Enum.Font.GothamSemibold
            ButtonLabel.TextSize = 14
            ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
            ButtonLabel.Parent = Button
            
            -- Hover Effects
            Button.MouseEnter:Connect(function()
                Utility:TweenObject(Button, {
                    BackgroundColor3 = Color3.fromRGB(
                        math.min(self.Theme.ElementColor.R * 255 + 15, 255),
                        math.min(self.Theme.ElementColor.G * 255 + 15, 255),
                        math.min(self.Theme.ElementColor.B * 255 + 15, 255)
                    )
                }, 0.2)
            end)
            
            Button.MouseLeave:Connect(function()
                Utility:TweenObject(Button, {
                    BackgroundColor3 = self.Theme.ElementColor
                }, 0.2)
            end)
            
            -- Click Event
            Button.MouseButton1Click:Connect(function()
                Utility:CreateRippleEffect(Button)
                if type(callback) == "function" then
                    callback()
                end
            end)
            
            Button.Parent = TabContent
            return Button
        end
        
        -- Create Toggle (FIXED VERSION)
        function TabFunctions:CreateToggle(toggleName, defaultValue, callback)
            if not toggleName then return nil end
            
            local Toggle = Instance.new("TextButton")
            Toggle.Name = toggleName
            Toggle.Size = UDim2.new(1, -20, 0, 40)
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
            ToggleLabel.Parent = Toggle
            
            -- Toggle Switch
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
            
            local function updateToggle()
                if isToggled then
                    Utility:TweenObject(ToggleSwitch, {
                        BackgroundColor3 = self.Theme.SchemeColor
                    }, 0.2)
                    Utility:TweenObject(ToggleKnob, {
                        Position = UDim2.new(1, -23, 0.5, -10.5)
                    }, 0.2)
                else
                    Utility:TweenObject(ToggleSwitch, {
                        BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    }, 0.2)
                    Utility:TweenObject(ToggleKnob, {
                        Position = UDim2.new(0, 2, 0.5, -10.5)
                    }, 0.2)
                end
            end
            
            -- Hover Effects
            Toggle.MouseEnter:Connect(function()
                Utility:TweenObject(Toggle, {
                    BackgroundColor3 = Color3.fromRGB(
                        math.min(self.Theme.ElementColor.R * 255 + 15, 255),
                        math.min(self.Theme.ElementColor.G * 255 + 15, 255),
                        math.min(self.Theme.ElementColor.B * 255 + 15, 255)
                    )
                }, 0.2)
            end)
            
            Toggle.MouseLeave:Connect(function()
                Utility:TweenObject(Toggle, {
                    BackgroundColor3 = self.Theme.ElementColor
                }, 0.2)
            end)
            
            -- Toggle Click
            Toggle.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                updateToggle()
                Utility:CreateRippleEffect(Toggle)
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
    
    -- Toggle UI Visibility
    function Library:ToggleUI()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
    
    return Library
end

return KavoPremium
