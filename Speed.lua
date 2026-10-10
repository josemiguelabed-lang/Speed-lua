
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local speed = 1

local gui = Instance.new("ScreenGui")
gui.Name = "SpeedPanel"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local icon = Instance.new("TextButton")
icon.Size = UDim2.fromOffset(55, 55)
icon.Position = UDim2.new(0, 25, 0.4, 0)
icon.Text = "⚡"
icon.TextSize = 28
icon.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
icon.TextColor3 = Color3.new(1, 1, 1)
icon.Parent = gui

Instance.new("UICorner", icon).CornerRadius =
    UDim.new(1, 0)

local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(190, 140)
panel.Position = UDim2.new(0, 90, 0.4, 0)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
panel.Visible = false
panel.Parent = gui

Instance.new("UICorner", panel)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "SPEED CONTROL"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Parent = panel

local label = Instance.new("TextLabel")
label.Position = UDim2.fromOffset(0, 35)
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "Speed: x1"
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1
label.Parent = panel

local minus = Instance.new("TextButton")
minus.Position = UDim2.fromOffset(10, 80)
minus.Size = UDim2.fromOffset(50, 40)
minus.Text = "-"
minus.Parent = panel

local plus = Instance.new("TextButton")
plus.Position = UDim2.fromOffset(130, 80)
plus.Size = UDim2.fromOffset(50, 40)
plus.Text = "+"
plus.Parent = panel

local function applySpeed()
    label.Text = "Speed: x" .. speed

    local character = player.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = 16 * speed
    end
end

icon.Activated:Connect(function()
    panel.Visible = not panel.Visible
end)

plus.Activated:Connect(function()
    speed = math.min(100, speed + 1)
    applySpeed()
end)

minus.Activated:Connect(function()
    speed = math.max(1, speed - 1)
    applySpeed()
end)

player.CharacterAdded:Connect(function()
    task.wait(1)
    applySpeed()
end)

-- Move the floating icon with touch or mouse
local dragging = false
local moved = false
local startInput
local startPos

icon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        moved = false
        startInput = input.Position
        startPos = icon.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if not dragging then return end

    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - startInput

        if delta.Magnitude > 8 then
            moved = true
        end

        icon.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
