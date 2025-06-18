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

-- "Please Wait" popup
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

-- Fullscreen Loading Screen with Percentage
local function createFullscreenLoading(message)
	local screen = Instance.new("ScreenGui")
	screen.Name = "FullLoadingScreen"
	screen.ResetOnSpawn = false
	screen.IgnoreGuiInset = true
	screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screen.Parent = playerGui

	local frame = Instance.new("Frame", screen)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
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
	percent.Position = UDim2.new(0.5, 0, 0.6, 0)
	percent.AnchorPoint = Vector2.new(0.5, 0.5)
	percent.Text = "0%"
	percent.Font = Enum.Font.Cartoon
	percent.TextSize = 30
	percent.TextColor3 = Color3.new(1, 1, 1)
	percent.BackgroundTransparency = 1
	percent.ZIndex = 11

	-- Animate percentage over 10 seconds
	task.spawn(function()
		for i = 0, 100 do
			percent.Text = i .. "%"
			wait(10 / 100)
		end
	end)

	return screen, frame, label
end

-- Animated "Loading Script..." small UI
local function createScriptLoadingUI()
	local screen = Instance.new("ScreenGui", playerGui)
	screen.Name = "ScriptLoadingUI"
	screen.ResetOnSpawn = false

	local label = Instance.new("TextLabel", screen)
	label.Size = UDim2.new(0, 350, 0, 50)
	label.Position = UDim2.new(0.5, -175, 0.5, -25)
	label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	label.Text = "Loading Script, Please wait"
	label.Font = Enum.Font.Cartoon
	label.TextSize = 28
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 0.1
	Instance.new("UICorner", label).CornerRadius = UDim.new(0, 10)

	-- Animated dots (...)
	local running = true
	task.spawn(function()
		while running do
			for i = 0, 3 do
				if not running then break end
				label.Text = "Loading Script, Please wait" .. string.rep(".", i)
				wait(0.5)
			end
		end
	end)

	return screen, function() running = false end
end

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

-- Button Logic
local function onButtonClick(clickedButton, loadingMessage)
	for _, child in pairs(mainFrame:GetChildren()) do
		if child:IsA("TextButton") and child ~= clickedButton then
			child.Visible = false
		end
	end

	local shrinkTween = TweenService:Create(mainFrame, TweenInfo.new(0.4), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0)
	})
	shrinkTween:Play()
	shrinkTween.Completed:Wait()

	waitGui.Visible = true
	wait(1)

	-- Execute the script immediately
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
	end)

	waitGui.Visible = false
	mainGui.Enabled = false

	-- Fullscreen loading with percent
	local screen, frame, label = createFullscreenLoading(loadingMessage)
	wait(10)

	-- Fade out
	TweenService:Create(frame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
	TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 1}):Play()
	wait(1.1)
	screen:Destroy()

	-- Final "Loading Script..." UI
	local loadingUI, stopAnim = createScriptLoadingUI()
	wait(4)
	stopAnim()
	loadingUI:Destroy()
end

-- Create buttons
local adminButton = createButton("Admin Abuse")
adminButton.MouseButton1Click:Connect(function()
	onButtonClick(adminButton, "Bypassing Command Panel Please Wait.")
end)

local dupeButton = createButton("Dupe Now!")
dupeButton.MouseButton1Click:Connect(function()
	onButtonClick(dupeButton, "Bypassing Duping Anti-Cheat Please Wait.")
end)
