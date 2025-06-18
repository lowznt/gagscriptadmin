-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Main GUI Setup
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "CustomGui"
mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 300, 0, 160)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
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

-- Hoverable Button Creator
local function createButton(name)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.8, 0, 0, 40)
	btn.Text = name
	btn.Font = Enum.Font.Cartoon
	btn.TextSize = 24
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
	btn.AutoButtonColor = false
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

	-- Hover effect
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 90, 90)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
	end)

	return btn
end

-- Loading Screen with Progress Bar (2 seconds)
local function showLoadingScreen(message, callback)
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

	local watermark = Instance.new("TextLabel", frame)
	watermark.Text = "Script by lowznt"
	watermark.Font = Enum.Font.Cartoon
	watermark.TextSize = 16
	watermark.TextColor3 = Color3.fromRGB(180, 180, 180)
	watermark.BackgroundTransparency = 1
	watermark.Size = UDim2.new(1, 0, 0, 30)
	watermark.Position = UDim2.new(0.5, 0, 0.97, 0)
	watermark.AnchorPoint = Vector2.new(0.5, 1)

	-- Animate Progress (2s)
	task.spawn(function()
		for i = 1, 100 do
			percent.Text = i .. "%"
			progressBar:TweenSize(UDim2.new(i / 100, 0, 1, 0), "Out", "Sine", 0.02, true)
			wait(2 / 100)
		end

		-- Fade out
		TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(label, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(percent, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(progressBar, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(progressBarBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(watermark, TweenInfo.new(0.5), {TextTransparency = 1}):Play()

		wait(0.6)
		screen:Destroy()
		callback()
	end)
end

-- Animated "Please Wait Loading Script..." UI
local function showLoadingScriptUI()
	local screen = Instance.new("ScreenGui", playerGui)
	screen.Name = "ScriptWaitUI"
	screen.ResetOnSpawn = false

	local label = Instance.new("TextLabel", screen)
	label.Size = UDim2.new(0, 400, 0, 60)
	label.Position = UDim2.new(0.5, -200, 0.5, -30)
	label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	label.Text = "Please Wait Loading Script"
	label.Font = Enum.Font.Cartoon
	label.TextSize = 30
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 0.1
	Instance.new("UICorner", label).CornerRadius = UDim.new(0, 10)

	local running = true
	task.spawn(function()
		while running do
			for i = 0, 3 do
				if not running then return end
				label.Text = "Please Wait Loading Script" .. string.rep(".", i)
				wait(0.5)
			end
		end
	end)

	task.delay(10, function()
		running = false
		screen:Destroy()
	end)
end

-- Load External Script
local function runScript()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
	end)
end

-- Button Click Logic
local function onButtonClick(btn, msg)
	mainGui.Enabled = false
	for _, child in ipairs(mainFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child.Visible = false
		end
	end

	showLoadingScreen(msg, function()
		-- Run script and show loading message at the same time
		showLoadingScriptUI()
		runScript()
	end)
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
