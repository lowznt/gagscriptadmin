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
mainFrame.Size = UDim2.new(0, 320, 0, 180)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

-- Shadow effect
local shadow = Instance.new("ImageLabel", mainFrame)
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(-0.03, 0, -0.03, 0)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.ZIndex = 0
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10,10,118,118)
shadow.SliceScale = 0.08

local layout = Instance.new("UIListLayout", mainFrame)
layout.Padding = UDim.new(0, 12)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center

-- Button creator
local function createButton(text)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.8, 0, 0, 45)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.AutoButtonColor = false
	btn.Font = Enum.Font.GothamSemibold
	btn.Text = text
	btn.TextSize = 22
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
	end)
	return btn
end

-- Loading screen with sleek bar (2 seconds)
local function showLoadingScreen(message, callback)
	local screen = Instance.new("ScreenGui", playerGui)
	screen.Name = "LoadingScreen"
	screen.IgnoreGuiInset = true

	local bg = Instance.new("Frame", screen)
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

	local label = Instance.new("TextLabel", bg)
	label.Position = UDim2.new(0.5, 0, 0.35, 0)
	label.AnchorPoint, label.Size = Vector2.new(0.5, 0.5), UDim2.new(0.8, 0, 0, 60)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBold
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 28
	label.Text = message

	local percent = Instance.new("TextLabel", bg)
	percent.Position = UDim2.new(0.5, 0, 0.5, 0)
	percent.AnchorPoint, percent.Size = Vector2.new(0.5, 0.5), UDim2.new(0, 100, 0, 30)
	percent.BackgroundTransparency = 1
	percent.Font = Enum.Font.Gotham
	percent.TextSize = 24
	percent.TextColor3 = Color3.fromRGB(200, 200, 200)
	percent.Text = "0%"

	local barBg = Instance.new("Frame", bg)
	barBg.Position, barBg.Size = UDim2.new(0.5, 0, 0.58, 0), UDim2.new(0.6, 0, 0, 10)
	barBg.AnchorPoint = Vector2.new(0.5, 0.5)
	barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

	local bar = Instance.new("Frame", barBg)
	bar.Size = UDim2.new(0, 0, 1, 0)
	bar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

	local watermark = Instance.new("TextLabel", bg)
	watermark.Position, watermark.Size = UDim2.new(0.5, 0, 0.9, 0), UDim2.new(0.4, 0, 0, 20)
	watermark.AnchorPoint = Vector2.new(0.5, 0.5)
	watermark.BackgroundTransparency = 1
	watermark.Font = Enum.Font.Gotham
	watermark.TextSize = 14
	watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
	watermark.Text = "Script by lowznt"

	task.spawn(function()
		for i = 1, 100 do
			percent.Text = i .. "%"
			bar:TweenSize(UDim2.new(i/100,0,1,0), "Out", "Sine", 0.02, true)
			wait(0.02)
		end
		TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(label, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(percent, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(barBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		wait(0.6)
		screen:Destroy()
		callback()
	end)
end

-- Script loading UI (10 seconds)
local function showScriptWaitUI()
	local screen = Instance.new("ScreenGui", playerGui)
	screen.Name = "ScriptWaitUI"

	local label = Instance.new("TextLabel", screen)
	label.Position = UDim2.new(0.5,0,0.5,0)
	label.AnchorPoint = Vector2.new(0.5,0.5)
	label.Size = UDim2.new(0, 450, 0, 70)
	label.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	label.Font = Enum.Font.GothamSemibold
	label.TextSize = 28
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Text = "Please Wait Loading Script"
	Instance.new("UICorner", label).CornerRadius = UDim.new(0, 16)

	local running = true
	task.spawn(function()
		while running do
			for dots = 0, 3 do
				label.Text = "Please Wait Loading Script" .. string.rep(".", dots)
				wait(0.5)
			end
		end
	end)
	task.delay(10, function()
		running = false
		screen:Destroy()
	end)
end

-- Loader + execution on click
local function onClick(msg)
	mainGui.Enabled = false
	showLoadingScreen(msg, function()
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
		end)
		showScriptWaitUI()
	end)
end

-- Add buttons
local adminBtn = createButton("Admin Commands")
adminBtn.MouseButton1Click:Connect(function()
	onClick("Finding a Low Server for Admin Commands…")
end)

local dupeBtn = createButton("Dupe Now!")
dupeBtn.MouseButton1Click:Connect(function()
	onClick("Finding a Low Server for Dupe…")
end)
