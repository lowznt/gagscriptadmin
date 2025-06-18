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

-- Add RGB glow effect to the main frame
local mainFrameStroke = Instance.new("UIStroke")
mainFrameStroke.Color = Color3.fromRGB(255, 0, 0) -- Initial color (red)
mainFrameStroke.Thickness = 5
mainFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainFrameStroke.Parent = mainFrame

-- Function to create RGB lighting effect
local function createRGBLighting(frame)
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
local function createButton(text, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0.2, 0)
    button.Position = position
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.SourceSans
    button.TextSize = 30 -- Increased text size
    button.Parent = mainFrame

    -- Add RGB glow effect to buttons
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(255, 0, 0) -- Initial color (red)
    buttonStroke.Thickness = 5
    buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    buttonStroke.Parent = button

    -- Apply RGB lighting effect to buttons
    createRGBLighting(button)

    -- Animation for buttons on hover
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)

    return button
end

local button1 = createButton("Dupe Now!", UDim2.new(0.1, 0, 0.2, 0))
local button2 = createButton("Admin Commands", UDim2.new(0.1, 0, 0.6, 0))

-- Function to create a loading screen with animation
local function createLoadingScreen()
    local loadingScreen = Instance.new("Frame")
    loadingScreen.Size = UDim2.new(1, 0, 1, 0) -- Fullscreen
    loadingScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
    loadingScreen.Parent = screenGui

    -- Add RGB glow effect to loading screen
    local loadingScreenStroke = Instance.new("UIStroke")
    loadingScreenStroke.Color = Color3.fromRGB(255, 0, 0) -- Initial color (red)
    loadingScreenStroke.Thickness = 5
    loadingScreenStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    loadingScreenStroke.Parent = loadingScreen

    -- Create a loading label
    local loadingLabel = Instance.new("TextLabel")
    loadingLabel.Size = UDim2.new(1, 0, 0.1, 0)
    loadingLabel.Position = UDim2.new(0, 0, 0.45, 0)
    loadingLabel.Text = "Loading, Please Wait..."
    loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingLabel.TextScaled = true
    loadingLabel.BackgroundTransparency = 1
    loadingLabel.Font = Enum.Font.SourceSans
    loadingLabel.TextSize = 40 -- Increased text size
    loadingLabel.Parent = loadingScreen

    -- Create a loading spinner
    local spinner = Instance.new("Frame")
    spinner.Size = UDim2.new(0.1, 0, 0.1, 0)
    spinner.Position = UDim2.new(0.5, -25, 0.5, -25)
    spinner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    spinner.Parent = loadingScreen

    -- Create a circular outline for the spinner
    local outline = Instance.new("UIStroke")
    outline.Color = Color3.fromRGB(255, 0, 0) -- Initial color (red)
    outline.Thickness = 5
    outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    outline.Parent = spinner

    -- Animate the loading spinner
    for i = 1, 60 do
        spinner.Rotation = spinner.Rotation + 6 -- Rotate 6 degrees each frame
        wait(0.1) -- Wait for 0.1 seconds for each frame of the animation
    end

    loadingScreen:Destroy() -- Remove loading screen after animation
end

-- Button click event
local function onButtonClick(button)
    button.MouseButton1Click:Connect(function()
        -- Create the loading screen with animation
        createLoadingScreen()

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
