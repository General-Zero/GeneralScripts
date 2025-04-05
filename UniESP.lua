local Players = game.Players
local lp = Players.LocalPlayer
local playergui = lp:WaitForChild("PlayerGui")

-- Gui

local gui = Instance.new("ScreenGui")
gui.Name = "Gui"
gui.Parent = playergui
gui.Enabled = true
gui.ResetOnSpawn = false
local button = Instance.new("TextButton", gui)
button.Name = "Definitely_not_a_cheat_script"
button.TextScaled = true
button.Visible = true
button.Size = UDim2.new(0, 150, 0, 40)
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.Text = "ESP: Off"
button.Position = UDim2.new(0, 25, 0, 25)

-- Functions

local guitable = {}

local function esp(player)
    if player == lp then return end
    if player.Character and player.Character:FindFirstChild("Head") then
        local head = player.Character.Head
        if head:FindFirstChild("BillboardGui") then return end
        local maingui = Instance.new("BillboardGui", head)
        maingui.Size = UDim2.new(0, 50, 0, 20)
        maingui.StudsOffset = Vector3.new(0, 0, 0)
        maingui.AlwaysOnTop = true
        local namegui = Instance.new("TextLabel", maingui)
        namegui.Size = UDim2.new(1, 0, 1, 0)
        namegui.BackgroundTransparency = 1
        namegui.TextScaled = true
        namegui.TextColor3 = Color3.fromRGB(35, 20, 15)
        namegui.Text = "Name: " .. player.Name
        local box = Instance.new("Frame", maingui)
        box.Size = UDim2.new(0.5, 0, 0, 50)
        box.BackgroundTransparency = 1
        local UIStroke = Instance.new("UIStroke", box)
        UIStroke.Thickness = 1
        UIStroke.Color = Color3.fromRGB(225, 225, 225)
        local UICorner = Instance.new("UICorner", maingui)
        UICorner.CornerRadius = UDim.new(0, 5)
        guitable[player] = maingui
    end
end

-- Esp On/Off

local OnEsp = false

-- functions

  -- Destroy Esp

local function del(player)
    if guitable[player] then
        guitable[player]:Destroy()
        guitable[player] = nil
    end
end

  -- Setup Esp
local function setupESP(player)
    if player == lp then return end
    
    if player.Character then
        esp(player)
    end
    
    player.CharacterAdded:Connect(function(char)
        wait(1)
        esp(player)
    end)
end

button.MouseButton1Click:Connect(function()
    OnEsp = not OnEsp
    button.Text = OnEsp and "Esp: On" or "Esp: Off"
    for _, player in pairs(Players:GetPlayers()) do
        if OnEsp then
            setupESP(player)
        else
            del(player)
        end
    end
end)

-- crappy shet

Players.PlayerAdded:Connect(function(player)
    if OnEsp then
        setupESP(player)
    end
end)

Players.PlayerRemoving:Connect(del)
