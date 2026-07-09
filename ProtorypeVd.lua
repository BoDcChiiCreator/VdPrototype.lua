-- Buat ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VD_UI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Buat Frame utama (background)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true  -- Biar bisa digeser
mainFrame.Parent = screenGui

-- Efek blur (opsional, tapi keren)
local blur = Instance.new("BlurEffect")
blur.Size = 10
blur.Parent = mainFrame

-- Judul
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
title.BackgroundTransparency = 0.5
title.Text = "🔧 Script Tools"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Tombol fitur (contoh)
local buttons = {
    {Name = "Auto Parry", Color = Color3.fromRGB(0, 150, 255)},
    {Name = "ESP Player", Color = Color3.fromRGB(255, 50, 50)},
    {Name = "Speed Boost", Color = Color3.fromRGB(50, 255, 50)},
    {Name = "Auto Farm", Color = Color3.fromRGB(255, 200, 0)},
    {Name = "God Mode", Color = Color3.fromRGB(200, 50, 255)},
    {Name = "Teleport", Color = Color3.fromRGB(255, 100, 0)}
}

-- Buat tombol-tombol
local yOffset = 50
for i, btnData in ipairs(buttons) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, yOffset + (i-1) * 50)
    button.BackgroundColor3 = btnData.Color
    button.BackgroundTransparency = 0.3
    button.Text = btnData.Name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamSemibold
    button.BorderSizePixel = 0
    button.Parent = mainFrame
    
    -- Efek hover
    button.MouseEnter:Connect(function()
        button.BackgroundTransparency = 0.1
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundTransparency = 0.3
    end)
    
    -- Fungsi klik (contoh)
    button.MouseButton1Click:Connect(function()
        print(btnData.Name .. " diaktifkan!")
        -- Di sini nanti bisa diisi fungsi script
    end)
end

-- Tombol toggle UI (minimize)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 30, 0, 30)
toggleBtn.Position = UDim2.new(1, -35, 0, 5)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.BackgroundTransparency = 0.5
toggleBtn.Text = "−"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = mainFrame

local minimized = false
toggleBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        mainFrame.Size = UDim2.new(0, 300, 0, 40)
        for _, child in ipairs(mainFrame:GetChildren()) do
            if child:IsA("TextButton") and child ~= toggleBtn then
                child.Visible = false
            end
        end
        toggleBtn.Text = "+"
    else
        mainFrame.Size = UDim2.new(0, 300, 0, 400)
        for _, child in ipairs(mainFrame:GetChildren()) do
            if child:IsA("TextButton") and child ~= toggleBtn then
                child.Visible = true
            end
        end
        toggleBtn.Text = "−"
    end
end)