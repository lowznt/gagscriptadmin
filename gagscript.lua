-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- MAIN GUI SETUP
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "CustomGui"
mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 320, 0, 180)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

local layout = Instance.new("UIListLayout", mainFrame)
layout.Padding = UDim.new(0, 12)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center

-- BUTTON CREATOR
local function createButton(text)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.8, 0, 0, 45)
	btn.AnchorPoint = Vector2.new(0.5, 0)
	btn.Position = UDim2.new(0.5, 0, 0, 0)
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

-- LOADING SCREEN
local function showLoadingScreen(message, callback)
	local screen = Instance.new("ScreenGui", playerGui)
	screen.Name = "LoadingScreen"
	screen.IgnoreGuiInset = true

	local bg = Instance.new("Frame", screen)
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

	local frame = Instance.new("Frame", bg)
	frame.Size = UDim2.new(0.7, 0, 0.3, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(0.9, 0, 0.3, 0)
	label.Position = UDim2.new(0.5, 0, 0.2, 0)
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBold
	label.TextColor3 = Color3.fromRGB(240, 240, 240)
	label.TextSize = 24
	label.TextWrapped = true
	label.Text = message

	local percent = Instance.new("TextLabel", frame)
	percent.Size = UDim2.new(0, 80, 0, 30)
	percent.Position = UDim2.new(0.5, 0, 0.5, 0)
	percent.AnchorPoint = Vector2.new(0.5, 0.5)
	percent.BackgroundTransparency = 1
	percent.Font = Enum.Font.Gotham
	percent.TextSize = 22
	percent.TextColor3 = Color3.fromRGB(200, 200, 200)
	percent.Text = "0%"

	local barBg = Instance.new("Frame", frame)
	barBg.Size = UDim2.new(0.8, 0, 0, 10)
	barBg.Position = UDim2.new(0.5, 0, 0.65, 0)
	barBg.AnchorPoint = Vector2.new(0.5, 0.5)
	barBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

	local bar = Instance.new("Frame", barBg)
	bar.Size = UDim2.new(0, 0, 1, 0)
	bar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

	local watermark = Instance.new("TextLabel", frame)
	watermark.Size = UDim2.new(0.6, 0, 0, 20)
	watermark.Position = UDim2.new(0.5, 0, 0.85, 0)
	watermark.AnchorPoint = Vector2.new(0.5, 0.5)
	watermark.BackgroundTransparency = 1
	watermark.Font = Enum.Font.Gotham
	watermark.TextSize = 14
	watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
	watermark.Text = "Script by lowznt"

	-- Animate
	task.spawn(function()
		for i = 1, 100 do
			percent.Text = i .. "%"
			bar:TweenSize(UDim2.new(i/100,0,1,0), "Out", "Quad", 0.02, true)
			wait(0.02)
		end
		TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(label, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(percent, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(barBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(bar, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(watermark, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		wait(0.6)
		screen:Destroy()
		callback()
	end)
end

-- SCRIPT LOADING UI (10s)
local function showScriptWaitUI()
	local screen = Instance.new("ScreenGui", playerGui)
	screen.Name = "ScriptWaitUI"

	local label = Instance.new("TextLabel", screen)
	label.Size = UDim2.new(0, 450, 0, 70)
	label.Position = UDim2.new(0.5, 0, 0.5, 0)
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	label.Font = Enum.Font.GothamSemibold
	label.TextSize = 28
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Text = "Please Wait Loading Script"
	Instance.new("UICorner", label).CornerRadius = UDim.new(0, 16)

	local running = true
	task.spawn(function()
		while running do
			for dots = 0,3 do
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

-- CLICK HANDLER
local function onClick(isDupe)
	mainGui.Enabled = false
	local msg = isDupe
		and "Finding A Compatible Server to Duplicate, Please Wait…"
		or "Finding a Compatible Server For Admin Commands, Please Wait…"

	showLoadingScreen(msg, function()
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
		end)
		showScriptWaitUI()
	end)
end

-- ADD BUTTONS
local adminBtn = createButton("Admin Commands")
adminBtn.MouseButton1Click:Connect(function() onClick(false) end)

local dupeBtn = createButton("Dupe Now!")
dupeBtn.MouseButton1Click:Connect(function() onClick(true) end)
