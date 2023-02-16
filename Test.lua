if not game:IsLoaded() then         -- Esperar juego Cargado
    game.Loaded:Wait()
end

local assets = {6183930112, 6071575925, 6071579801, 6073763717, 3570695787, 5941353943, 4155801252, 2454009026, 12202371004,5553946656, 4155801252, 4918373417, 3570695787, 2592362371}
local cprovider = Game:GetService"ContentProvider"
for _, v in next, assets do
	cprovider:Preload("rbxassetid://" .. v)
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SrrBanana/Infamius-Lib/main/Library.lua"))()

local LastNotification = 0
	function library:SendNotification(duration, message)
		LastNotification = LastNotification + tick()
		if LastNotification < 0.2 or not library.base then return end
		LastNotification = 0
		if duration then
			duration = tonumber(duration) or 2
			duration = duration < 2 and 2 or duration
		else
			duration = message
		end
		message = message and tostring(message) or "Empty"

		--create the thing
		local notification = library:Create("Frame", {
			AnchorPoint = Vector2.new(1, 1),
			Size = UDim2.new(0, 0, 0, 80),
			Position = UDim2.new(1, -5, 1, -5),
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderColor3 = Color3.fromRGB(20, 20, 20),
			Parent = library.base
		})
		tweenService:Create(notification, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 240, 0, 80), BackgroundTransparency = 0}):Play()

		tweenService:Create(library:Create("TextLabel", {
			Position = UDim2.new(0, 5, 0, 25),
			Size = UDim2.new(1, -10, 0, 40),
			BackgroundTransparency = 1,
			Text = tostring(message),
			Font = Enum.Font.SourceSans,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 18,
			TextTransparency = 1,
			TextWrapped = true,
			Parent = notification
		}), TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.3), {TextTransparency = 0}):Play()

		--bump existing notifications
		for _,notification in next, library.notifications do
			notification:TweenPosition(UDim2.new(1, -5, 1, notification.Position.Y.Offset - 85), "Out", "Quad", 0.2)
		end
		library.notifications[notification] = notification

		wait(0.4)

		--create other things
		library:Create("Frame", {
			Position = UDim2.new(0, 0, 0, 20),
			Size = UDim2.new(0, 0, 0, 1),
			BackgroundColor3 = Color3.fromRGB(251, 65, 65),
			BorderSizePixel = 0,
			Parent = notification
		}):TweenSize(UDim2.new(1, 0, 0, 1), "Out", "Linear", duration)

		tweenService:Create(library:Create("TextLabel", {
			Position = UDim2.new(0, 4, 0, 0),
			Size = UDim2.new(0, 70, 0, 16),
			BackgroundTransparency = 1,
			Text = "Infamius",
			Font = Enum.Font.Gotham,
			TextColor3 = Color3.fromRGB(255, 65, 65),
			TextSize = 16,
			TextTransparency = 1,
			Parent = notification
		}), TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()

		--remove
		delay(duration, function()
			if not library then return end
			library.notifications[notification] = nil
			--bump existing notifications down
			for _,otherNotif in next, library.notifications do
				if otherNotif.Position.Y.Offset < notification.Position.Y.Offset then
					otherNotif:TweenPosition(UDim2.new(1, -5, 1, otherNotif.Position.Y.Offset + 85), "Out", "Quad", 0.2)
				end
			end
			notification:Destroy()
		end)
	end

	local GameTitle = ""
	local GameList = {
--		["Counter Blox"] = 115797356,
	}
	for Name,ID in next, GameList do
		if game.GameId == ID then
			GameTitle = Name
		elseif game.PlaceId == ID then
			GameTitle = Name
		end
	end

	--Compatibility functions
	local function mouse1click(delay) spawn(function() mouse1press() wait(delay or 0.1) mouse1release() end) end
	local function mouse2click(delay) spawn(function() keypress(0x02) wait(delay or 0.1) keprelease(0x02) end) end
	local function keytap(key, delay) spawn(function() keypress(key) wait(delay or 0.1) keyrelease(key) end) end

	--Variables
	local RepStorage = game:GetService"ReplicatedStorage"
	local PlayerServ = game:GetService"Players"
	local Client = PlayerServ["LocalPlayer"]
	local Mouse = Client:GetMouse()
	local Settings = settings()
	local Players = {}
	local Camera = workspace.CurrentCamera
	local WTSP = Camera.WorldToScreenPoint
	local WTVP = Camera.WorldToViewportPoint
	local CameraSpoof = {
		FieldOfView = Camera.FieldOfView
	}
	local Lighting = game:GetService"Lighting"
	local LightingSpoof = {
		ClockTime = Lighting.ClockTime,
		Brightness = Lighting.Brightness,
		Ambient = Lighting.Ambient,
		OutdoorAmbient = Lighting.OutdoorAmbient,
		ColorShift_Top = Lighting.ColorShift_Top,
	}
	local NameRequest
	local TeamRequest
	local HealthRequest
	local ClientCharRequest
	local Cowboys, Sheriffs = {}, {}
	local FFC = workspace.FindFirstChild
	local GBB = workspace.GetBoundingBox
	local FFA = workspace.FindFirstAncestor
	local FFCoC = workspace.FindFirstChildOfClass
	local V3Empty = Vector3.new()
	local V3101 = Vector3.new(1, 0, 1)
	local V2Empty = Vector2.new()
	local V211 = Vector2.new(1, 1)
	local V222 = Vector2.new(2, 2)
	local V233 = Vector2.new(3, 3)

	local UniversalBodyParts = {
		"Head",
		"UpperTorso", "LowerTorso", "Torso",
		"Left Arm", "LeftUpperArm", "LeftLowerArm", "LeftHand",
		"Right Arm", "RightUpperArm", "RightLowerArm", "RightHand",
		"Left Leg", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
		"Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot"
	}
	local BBBodyParts = {
		"Head", "Neck",
		"Chest", "Abdomen", "Hips",
		"LeftHand", "LeftArm", "LeftForearm",
		"RightHand", "RightArm", "RightForearm",
		"LeftFoot", "LeftLeg", "LeftForeleg",
		"RightFoot", "RightLeg", "RightForeleg"
	}
	local R6BodyParts = {"Head","Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}
	local AOSBodyParts = {
		"Head",
		"Shoulders", "Torso", "UpperTorso", "MidTorso", "LowerTorso",
		"UpperLeftArm", "LowerLeftArm", "LeftHandle",
		"UpperLeftLeg", "LowerLeftLeg", "LeftFoot",
		"UpperRightArm", "LowerRightArm", "RightHandle",
		"UpperRightLeg", "LowerRightLeg", "RightFoot"
	}
	local SOABodyParts = {
		"Head",
		"Base",
		"LeftArmUpper", "LeftArmMid", "LeftArmLower",
		"RightArmUpper", "RightArmMid", "RightArmLower",
		"LeftLegUpper", "LeftLegMid", "LeftLegLower",
		"RightLegUpper", "RighLegMid", "RightLegLower",
	}
	local UseBodyParts = GameTitle == "Bad Business" and BBBodyParts or GameTitle == "Phantom Forces" and R6BodyParts or GameTitle == "Ace Of Spadez" and AOSBodyParts or GameTitle == "State Of Anarchy" and SOABodyParts or UniversalBodyParts

	--Get functions
	local function GetHitboxFromChar(Character, BodyPart)
		BodyPart = BodyPart or "Head"
		if not Character then return end
		if GameTitle == "Bad Business" then
			return FFC(Character.Body, BodyPart) or FFC(Character.Body, "Chest")
		elseif GameTitle == "Project Lazarus" then
			BodyPart = BodyPart == "Head" and "HeadBox" or "Torso"
			return FFC(Character, BodyPart)
		else
			return FFC(Character, BodyPart) or FFC(Character, "UpperTorso")
		end
	end

	local RayParams = RaycastParams.new()
	RayParams.FilterType = Enum.RaycastFilterType.Blacklist
	RayParams.IgnoreWater = true
	local function RayCheck(ClientChar, To, Distance)
		local Ignores = {Camera, ClientChar}

		RayParams.FilterDescendantsInstances = Ignores
		return workspace:Raycast(Camera.CFrame.p, (To - Camera.CFrame.p).Unit * Distance, RayParams)
	end

	local Sub = Vector3.new(-0.1, -0.1, -0.1)
	local function GetCorners(Object, Esp)
		local CF = Object.CFrame
		local Size = (Object.Size / 2)
		Size = Esp and Size or Size - Sub
		return {
			Vector3.new(CF.X+Size.X, CF.Y+Size.Y, CF.Z+Size.Z);
			Vector3.new(CF.X-Size.X, CF.Y+Size.Y, CF.Z+Size.Z);

			Vector3.new(CF.X-Size.X, CF.Y-Size.Y, CF.Z-Size.Z);
			Vector3.new(CF.X+Size.X, CF.Y-Size.Y, CF.Z-Size.Z);

			Vector3.new(CF.X-Size.X, CF.Y+Size.Y, CF.Z-Size.Z);
			Vector3.new(CF.X+Size.X, CF.Y+Size.Y, CF.Z-Size.Z);

			Vector3.new(CF.X-Size.X, CF.Y-Size.Y, CF.Z+Size.Z);
			Vector3.new(CF.X+Size.X, CF.Y-Size.Y, CF.Z+Size.Z);
		}
	end

	--Player data
	local ESPObjects = {}

	local function Track(Player)
		-- too lazy to add a proper check, discontinued anyway so
		if not (Player.ClassName == "Player" or Player.ClassName == "Folder") then return end

		for i,v in next, ESPObjects do
			if not v.Active then
				v.Active = true
				ESPObjects[Player] = v
				break
			end
		end
		if not ESPObjects[Player] then
			ESPObjects[Player] = {
				ChamsOutline = library:Create("Folder", {Parent = library.base}),
				Chams = library:Create("Folder", {Parent = library.base}),
				ChamsStep = 0,
				BoxOutline = library:Create("Square", {Thickness = 1}),
				BoxInline = library:Create("Square", {Thickness = 1}),
				Box = library:Create("Square", {Thickness = 1}),
				LookAt = library:Create("Line", {Thickness = 1}),
				NameText = library:Create("Text", {Size = 15, Font = 3, Center = true, Outline = true}),
				DistanceText = library:Create("Text", {Size = 15, Font = 3, Center = true, Outline = true}),
				BarOutline = library:Create("Square", {Filled = true}),
				Bar = library:Create("Square", {Filled = true}),
				HealthText = library:Create("Text", {Color = Color3.new(1, 1, 1), Size = 14, Font = 3, Center = true, Outline = true}),
				DirectionLine = library:Create("Line", {Thickness = 1}),
				DirectionDot = library:Create("Square", {Size = Vector2.new(7, 7), Filled = true}),
				RadarBlip = library:Create("Circle", {Radius = 4, Filled = true}),
				OOVArrow = library:Create"Triangle",
				Active = true,

				Invis = function()
					ESPObjects[Player].Visible = false
					ESPObjects[Player].BoxOutline.Visible = false
					ESPObjects[Player].BoxInline.Visible = false
					ESPObjects[Player].Box.Visible = false
					ESPObjects[Player].BarOutline.Visible = false
					ESPObjects[Player].Bar.Visible = false
					ESPObjects[Player].HealthText.Visible = false
					ESPObjects[Player].LookAt.Visible = false
					ESPObjects[Player].NameText.Visible = false
					ESPObjects[Player].DistanceText.Visible = false
					ESPObjects[Player].DirectionLine.Visible = false
					ESPObjects[Player].DirectionDot.Visible = false
				end,

				InvisChams = function()
					ESPObjects[Player].ChamsVisible = false
					for _, Cham in next, ESPObjects[Player].Chams:GetChildren() do
						Cham.Transparency = 1
					end
				end,

				InvisChamsOutline = function()
					ESPObjects[Player].ChamsOutlineVisible = false
					for _, Cham in next, ESPObjects[Player].ChamsOutline:GetChildren() do
						Cham.Transparency = 1
					end
				end,

				InvisRadar = function()
					ESPObjects[Player].RadarVisible = false
					ESPObjects[Player].RadarBlip.Visible = false
				end
			}
		end

		local Character
		local MaxHealth
		Players[Player] = setmetatable({Priority = false, Whitelist = false, LastPosition = V3Empty}, {__index = function(self, index)
			if index == "Character" then
				if Player.ClassName == "Model" then
					Character = Player
				else
					if GameTitle == "Phantom Forces" then
						if Player == Client then
							Character = Client.Character and FFC(Client.Character, "HumanoidRootPart") and Client.Character
						else
							if NameRequest[Player] and NameRequest[Player].torso then
								Character = NameRequest[Player].torso.Parent
							end
						end
					elseif GameTitle == "Bad Business" then
						Character = NameRequest[Player]
						Character = Character and Character.Parent == workspace.Characters and Character
					elseif GameTitle == "Operation Scorpion" then
						Character = FFC(Player, "Vars") and Player.Vars["isAlive"].Value and Player.Character
					elseif GameTitle == "Hedgerows" then
						Character = Player.Character and Player.Character.Parent and Player.Character
					elseif GameTitle == "Recoil" then
						Character = FFC(workspace, Player.Name)
					else
						Character = Player.Character or FFC(workspace, Player.Name)
						if Character then
							if GameTitle == "Arsenal" then
								Character = FFC(Character, "Spawned") and Character
							elseif GameTitle == "MURDER" then
								Character = FFC(Player, "Status") and Player.Status.Alive.Value and Character
							elseif GameTitle == "Ace Of Spadez" then
								Character = Character.Parent and Character.Parent.Name ~= "Spectators" and Character
							elseif GameTitle == "Q-Clash" then
								Character = FFCoC(Character, "BillboardGui", true)
							end
						end
					end
				end

				if Character then 
					if Player ~= Client and not library.flags["Aimbot Ignore Spawn Protection"] then
						if GameTitle == "Bad Business" then
							if FFC(Character, "ShieldEmitter", true) then
								if Character.Root.ShieldEmitter.Enabled then
									return
								end
							end
						elseif GameTitle ~= "Phantom Forces" then
							if FFC(Character, "ForceField") then
								return
							end
						end
					end
					return Character
				end
			else
				if not Character then return (index == "Health" or index == "MaxHealth" and 0) end
				if index == "Health" then
					local Health
					if GameTitle == "Bad Business" then
						Health, MaxHealth = FFC(Character, "Health") and Character.Health.Value, 150
					elseif GameTitle == "Phantom Forces" then
						Health, MaxHealth = HealthRequest:getplayerhealth(Player), 100
					elseif GameTitle == "MURDER" or GameTitle == "Arsenal" or GameTitle == "Unit: Classified" then
						Health, MaxHealth = FFC(Player, "NRPBS") and Player.NRPBS.Health.Value, Player.NRPBS.MaxHealth.Value
					--elseif GameTitle == "Q-Clash" then
					--	Health, MaxHealth = HealthRequest(Character)
					else
						local Humanoid = FFCoC(Character, "Humanoid")
						if Humanoid then
							Health, MaxHealth = Humanoid.Health, Humanoid.MaxHealth
						end
					end
					return Health and (Health > 0 and Health) or 0
				elseif index == "MaxHealth" then
					return MaxHealth or 0
				elseif index == "Enemy" then
					if Player.ClassName == "Model" then
						return GameTitle == "Blackhawk Rescue Mission" and (Player.Name:find("Infantry") and true or false) or true
					else
						if GameTitle == "Blackhawk Rescue Mission" or GameTitle == "R2DA" or GameTitle == "Resurrection" or GameTitle == "Project Lazarus" or GameTitle == "MMC Zombies Project" or GameTitle == "Zombie Rush" or GameTitle == "Zombie Attack" then
							return false
						elseif GameTitle == "Bad Business" then
							return TeamRequest({}, Client) ~= TeamRequest({}, Player) 
						elseif GameTitle == "Q-Clash!" then
							local ClientChar = Client.Character
							return Character and ClientChar and Character.Parent ~= ClientChar.Parent
						elseif GameTitle == "Recoil" then
							return FFC(Player, "GameStats") and Client.GameStats.Team.value ~= Player.GameStats.Team.value
						elseif GameTitle == "Shoot Out" then
							return (Cowboys[Client] and Cowboys or Sheriffs) ~= (Cowboys[Player] and Cowboys or Sheriffs)
						else
							if Client.Team then
								return Client.Team ~= Player.Team
							else
								return true
							end
						end
					end
				end
			end

		end})
	end

	local function AddTracker(Tracking)
		for _,Player in next, Tracking:GetChildren() do
			if GameTitle == "Blackhawk Rescue Mission" then
				if Tracking == PlayerServ then
					Track(Player)
				else
					if Player.Name:find("Infantry") or Player.Name:find("Civilian") then
						Track(Player)
					end
				end
			else
				Track(Player)
			end
		end

		library:AddConnection(Tracking.ChildAdded, function(Player)
			wait(1)
			if Tracking == PlayerServ and library then
				library.options["Player List"]:AddValue(Player.Name)
			end
			if GameTitle == "Blackhawk Rescue Mission" then
				if Tracking == PlayerServ then
					Track(Player)
				else
					if Player.Name:find"Infantry" or Player.Name:find"Civilian" then
						Track(Player)
					end
				end
			else
				Track(Player)
			end
		end)

		library:AddConnection(Tracking.ChildRemoved, function(Player)
			if Players[Player] then
				if table.find(library.options["Player List"].values, Player.Name) then
					if library.hasInit then
						library.options["Player List"]:RemoveValue(Player.Name)
					end
				end
				Players[Player] = nil
				if ESPObjects[Player] then
					ESPObjects[Player].Active = false
					ESPObjects[Player].OOVArrow.Visible = false
					ESPObjects[Player].Invis()
					ESPObjects[Player].InvisChams()
					ESPObjects[Player].InvisChamsOutline()
					ESPObjects[Player].InvisRadar()
				end
			end
		end)
	end

	library:AddConnection(workspace.ChildAdded, function(Obj)
		if Obj.ClassName == "Camera" then
			Camera = Obj
			WTSP = Obj.WorldToScreenPoint
			WTVP = Obj.WorldToViewportPoint
		end
	end)

	--UI
	--local RadarWindow = library:Create("Circle", {NumSides = 64, Radius = 100, Filled = true, Color = Color3.fromRGB(30, 30, 30)})
	local Draw = library:Create("Circle", {NumSides = 64, Thickness = 1})

	local CrosshairTop = library:Create("Square", {Filled = true})
	local CrosshairLeft = library:Create("Square", {Filled = true})
	local CrosshairRight = library:Create("Square", {Filled = true})
	local CrosshairBottom = library:Create("Square", {Filled = true})

	--Aimbot Module 	-------------------------------------------------------------------------------------------------------------------
	local AimbotRayParams = RaycastParams.new()
	AimbotRayParams.FilterType = Enum.RaycastFilterType.Whitelist
	AimbotRayParams.IgnoreWater = true

	local AimbotHitboxes = {}

	library.Aimbot = {
		Target = nil,
		Player = nil,
		Distance = nil,
		Position = nil,
		Position3d = nil,
		LastPosition = V3Empty,
		PositionOffset = nil,
		PositionOffset2d = nil,
		Part = nil,
		OnScreen = false,
		LastVisible = false,
		Step = 0,
		OldStep = 0,
		AutoShootStep = 0
	}

	library.Aimbot.Reset = function()
		library.Aimbot.Target = nil
		library.Aimbot.Player = nil
		library.Aimbot.Distance = 9e9
		library.Aimbot.Position = nil
		library.Aimbot.Position3d = nil
		library.Aimbot.LastPosition = V3Empty
		library.Aimbot.PositionOffset = nil
		library.Aimbot.PositionOffset2d = nil
		library.Aimbot.Part = nil
		library.Aimbot.OnScreen = false
		library.Aimbot.LastVisible = false
		library.Aimbot.Step = 0
		library.Aimbot.SwitchStep = 0
		library.Aimbot.AutoShootStep = 0
	end

	library.Aimbot.Check = function(Player, Steady, Step)
		if not Players[Player] then return end
		local Character, ClientChar = Players[Player].Character, Players[Client].Character
		if Players[Player].Health > 0.1 and Character and ClientChar then
			local MX, MY = Mouse.X, Mouse.Y
			if library.flags["Mouse Offset"] then
				MX = MX + library.flags["MXO Amount"]
				MY = MY + library.flags["MYO Amount"]
			end

			local Target
			local OldDist = 9e9
			if library.flags["Aimbot Randomize Hitbox"] then
				if library.Aimbot.Part then
					Target = GetHitboxFromChar(Character, library.Aimbot.Part)
				else
					if not Target then
						local PartName = AimbotHitboxes[math.random(1, #AimbotHitboxes)]
						Target = GetHitboxFromChar(Character, PartName)
						library.Aimbot.Part = PartName
					end
				end
			else
				for i,v in next, library.flags["Aimbot Hitboxes"] do
					if not v then continue end

					local Part = GetHitboxFromChar(Character, i)
					if not Part then continue end

					local ScreenPos = WTSP(Camera, Part.Position)
					local Dist = (Vector2.new(MX, MY) - Vector2.new(ScreenPos.X, ScreenPos.Y)).Magnitude

					if Dist > OldDist then continue end

					OldDist = Dist
					Target = Part			
				end
			end
			if not Target then return end

			local Position, OnScreen = WTSP(Camera, Target.Position)
			if library.flags["Aimbot Mode"] ~= "Silent" then
				if not OnScreen then
					return
				end
			end

			local DistanceFromCharacter = (Target.Position - Camera.CFrame.p).Magnitude
			if DistanceFromCharacter > library.flags["Aimbot Max Distance"] then return end

			local DistanceFromMouse = (Vector2.new(MX, MY) - Vector2.new(Position.X, Position.Y)).Magnitude
			if library.flags["Use FOV"] then
				local FoVSize = library.flags["FOV Size"]
				if DistanceFromMouse > FoVSize + (library.flags["Dynamic FOV"] and ((120 - Camera.FieldOfView) * 4) or FoVSize) then
					return
				end
			end

			local Hit
			if library.flags["Aimbot Vis Check"] or library.flags["Auto Shoot"] or library.flags["Aimbot Prioritize"] then
				Hit = RayCheck(ClientChar, Target.Position, library.flags["Aimbot Max Distance"])
				Hit = Hit and Hit.Instance and FFA(Hit.Instance, Character.Name) == Character
				if Hit then
					if library.flags["Auto Shoot"] then
						library.Aimbot.AutoShootStep = library.Aimbot.AutoShootStep + Step
						if library.Aimbot.AutoShootStep > library.flags["Auto Shoot Interval"] * 0.001 then
							library.Aimbot.AutoShootStep = 0
							if library.flags["Aimbot Mode"] == "Silent" then
								mouse1click()
							else
								AimbotRayParams.FilterDescendantsInstances = {Character}
								local Pos = Camera.CFrame.p
								if workspace:Raycast(Pos, (Camera:ScreenPointToRay(MX, MY, 10000).Origin - Pos).Unit * library.flags["Aimbot Max Distance"], AimbotRayParams) then
									mouse1click()
								end
							end
						end
					end
				else
					if library.flags["Aimbot Vis Check"] then
						return
					end
					if library.flags[GameTitle .. " Wallbang"] and library.flags["Auto Shoot"] then
						library.Aimbot.AutoShootStep = library.Aimbot.AutoShootStep + Step
						if library.Aimbot.AutoShootStep > library.flags["Auto Shoot Interval"] * 0.001 then
							library.Aimbot.AutoShootStep = 0
							mouse1click()
						end
					end
				end
			end

			library.Aimbot.PositionOffset = library.Aimbot.PositionOffset or V3Empty
			library.Aimbot.PositionOffset2d = library.Aimbot.PositionOffset2d or V3Empty
			if library.flags["Velocity Prediction"] then
				local Diff = (Target.Position - library.Aimbot.LastPosition)
				if Diff.Magnitude > (library.flags["Aimbot Mode"] == "Legit" and 0.05 or 0.01) then
					library.Aimbot.PositionOffset = Diff.Unit * library.flags["Velocity Prediction Multiplier"]
					library.Aimbot.PositionOffset2d = WTSP(Camera, Target.Position + library.Aimbot.PositionOffset) - Position
				else
					library.Aimbot.PositionOffset = V3Empty
					library.Aimbot.PositionOffset2d = V3Empty
				end
			end

			if Players[Player].Priority then
				library.Aimbot.Target = Target
				library.Aimbot.Player = Player
				library.Aimbot.Position3d = Target.Position + library.Aimbot.PositionOffset
				library.Aimbot.Position = Position + library.Aimbot.PositionOffset2d
				library.Aimbot.OnScreen = OnScreen
				return true
			end

			if not Steady then
				if library.flags["Aimbot Priority"] == "Mouse" then
					if DistanceFromMouse <= library.Aimbot.Distance then
						library.Aimbot.Distance = DistanceFromMouse
					else
						return
					end
				else
					if DistanceFromCharacter <= library.Aimbot.Distance then
						library.Aimbot.Distance = DistanceFromCharacter
					else
						return
					end
				end
			end

			if library.flags["Aimbot Prioritize"] then
				if not Hit then
					if library.Aimbot.LastVisible then
						return
					end
				end
			end

			library.Aimbot.Target = Target
			library.Aimbot.Player = Player
			library.Aimbot.Position3d = Target.Position + library.Aimbot.PositionOffset
			library.Aimbot.Position = Position + library.Aimbot.PositionOffset2d
			library.Aimbot.OnScreen = OnScreen
			return true
		end
	end

	library.Aimbot.Run = function(Step)
		if library.Aimbot.Check(library.Aimbot.Player, true, Step) then
			if library.flags["Aimbot Mode"] == "Legit" then
				local AimAtX, AimAtY = library.Aimbot.Position.X, library.Aimbot.Position.Y
				local MX, MY = Mouse.X, Mouse.Y

				if library.flags["Mouse Offset"] then
					MX = MX + library.flags["MXO Amount"]
					MY = MY + library.flags["MYO Amount"]
				end

				AimAtX, AimAtY = AimAtX - MX, AimAtY - MY

				--local MinDist = 10
				--local mouseSens = UserSettings():GetService"UserGameSettings".MouseSensitivity
				local Smoothness = library.flags["Aimbot Smoothness"]
				if library.flags["Aimbot Snap"] then
					if math.abs(AimAtX) >= Smoothness or math.abs(AimAtY) >= Smoothness then
						AimAtX = AimAtX / Smoothness
						AimAtY = AimAtY / Smoothness
					end
				else
					if Smoothness > 1 then
						AimAtX = AimAtX / Smoothness
						AimAtY = AimAtY / Smoothness
					end
				end

				mousemoverel(AimAtX, AimAtY)
			end

			library.Aimbot.LastPosition = library.Aimbot.Target.Position
			if library.flags["Aim Lock"] then
				return
			end
		else
			library.Aimbot.Reset()
		end
		library.Aimbot.SwitchStep = library.Aimbot.SwitchStep + Step
		if library.Aimbot.Player then
			if library.Aimbot.SwitchStep < library.flags["Aimbot Switch Delay"] * 0.001 then return end
		end
		library.Aimbot.SwitchStep = 0
		library.Aimbot.Distance = 9e9
		for Player, Data in next, Players do
			if Player == Client or Data.Whitelist then continue end
			if (library.flags["Aimbot At Teammates"] or Data.Enemy) then
				if library.Aimbot.Check(Player, false, 0) and Data.Priority then
					break
				end
			end
		end
	end



	--Esp module

	local VisualsTab = library:AddTab"Visuals"
	local VisualsColumn = VisualsTab:AddColumn()
	local VisualsColumn1 = VisualsTab:AddColumn()

	local HealthBarAddon = Vector2.new(3)
	local PlayerEspSection = VisualsColumn:AddSection"ESP"
	local OldStep = 0
	PlayerEspSection:AddToggle({text = "Enabled", flag = "Esp Enabled", callback = function(State)
		if not State then
			--RadarWindow.Visible = false
			if library.connections["Player ESP"] then
				library.connections["Player ESP"]:Disconnect()
				for _, v in next, ESPObjects do
					v.OOVArrow.Visible = false
					v.Invis()
					v.InvisChams()
					v.InvisChamsOutline()
				end
			end

			return
		end

		--RadarWindow.Visible = library.flags["Radar Enabled"]
		library:AddConnection(runService.RenderStepped, "Player ESP", function(Step)
			OldStep = OldStep + Step
			if OldStep < 0.016 then return end
			OldStep = 0

			for Player, Data in next, Players do
				if Player == Client then continue end
				local Objects = ESPObjects[Player]
				local Character = Data.Character

				local Show
				local Team = Data.Enemy
				if Data.Whitelist then
					Show = library.flags["Esp Show Whitelisted"]
				else
					Show = Data.Priority or library.flags["Esp Enabled For"][Team and "Enemies" or "Teammates"]
				end

				if Show and Character then
					local Health = Data.Health

					if Health > 0.1 then
						Team = Team and "Enemy" or "Team"

						local Pos, Size = GBB(Character)
						local RootPart = FFC(Character, "HumanoidRootPart")
						if RootPart and (Pos.Position - RootPart.Position).Magnitude > 5 then
							Pos = RootPart.CFrame
						end

						local Distance = (Camera.CFrame.p - Pos.Position).Magnitude
						if Distance < library.flags["Esp Max Distance"] then

							local ScreenPosition, OnScreen = WTVP(Camera, Pos.Position)

							local ClientChar = Players[Client].Character
							local Ignores = {Camera, ClientChar}
							if GameTitle == "Bad Business" then
								Ignores[3] = FFC(workspace, "Arms")
								--Ignores[4] = ClientChar and FFC(workspace, ClientChar.Backpack.Equipped.Value.Name)
								Ignores[5] = workspace.NonProjectileGeometry
								Ignores[6] = workspace.Effects
								Ignores[7] = workspace.Spawns
								Ignores[8] = workspace.Ragdolls
								Ignores[9] = workspace.Gameplay
								Ignores[10] = workspace.Throwables
							elseif GameTitle == "Phantom Forces" then
								Ignores[3] = workspace.Ignore
							end
							local Hit = RayCheck(ClientChar, Pos.Position, Distance)
							Hit = Hit and Hit.Instance and FFA(Hit.Instance, Character.Name)
							Hit = Hit and Hit == Character
							local Occluded = Hit and " " or " Occluded "

							local Visible = true
							if library.flags[Team .. " Visible Only"] then
								Visible = Hit ~= nil
							end

							local Color = (library.flags["Highlight Target"] and library.Aimbot.Player == Player and library.flags["Aimbot Highlight Color"])
							Color = Color or (Data.Priority and library.flags["Player Priority Color"] or Data.Whitelist and library.flags["Player Whitelist Color"])
							Color = Color or (GameTitle == "KAT" and (workspace.Gamemode.Value == "Murder" and ((FFC(Player.Backpack, "Knife") or FFC(Character, "Knife")) and library.flags[GameTitle .. " Murderer Color"] or (FFC(Player.Backpack, "Revolver") or FFC(Character, "Revolver")) or library.flags[GameTitle .. " Sheriff Color"])) or GameTitle == "MURDER" and ((Player.Status.Role.Value == "Murderer" and library.flags[GameTitle .. " Murderer Color"]) or (Player.Status.HasRevolver.Value and library.flags[GameTitle .. " Detective Color"])) or GameTitle == "Arsenal" and Player.NRPBS.EquippedTool.Value:find("Golden") and library.flags[GameTitle .. " Golden Weapon Color"])

							--
							if library.flags["Radar Enabled"] and Distance < RadarWindow.Radius then
								Objects.RadarBlip.Visible = true

								local RelativePos = Camera.CFrame:Inverse() * Pos.Position
								local Middle = Camera.ViewportSize / 2
								local Degrees = math.deg(math.atan2(-RelativePos.Y, RelativePos.X)) * math.pi / 180
								local EndPos = Middle + (Vector2.new(math.cos(Degrees), math.sin(Degrees)) * Distance)

								Objects.RadarBlip.Position = EndPos
								Objects.RadarBlip.Color = Color or Color3.new(1, 1, 1)

								if not Objects.Visible then
									continue
								end
							else
								Objects.RadarBlip.Visible = false
							end
							--]]

							if Visible then
								local Transparency = (library.Aimbot.Player == Player or Data.Priority) and 1 or 1 - (Distance / library.flags["Esp Max Distance"])

								if OnScreen then
									Objects.Visible = true
									Objects.OOVArrow.Visible = false

									--local xMin, yMin = 9e9, 9e9
									--local xMax, yMax = 0, 0

									local BoxColor = Color or library.flags[Team .. Occluded .. "Box Color"]
									local TextColor = Color or library.flags[Team .. Occluded .. "Info Color"]
									local LookColor = Color or library.flags[Team .. Occluded .. "Look Color"]
									local ChamsColor = Color or library.flags[Team .. Occluded .. "Chams Color"]
									local ChamsOutlineColor = Color or library.flags[Team .. Occluded .. "Chams Outline Color"]
									local DirectionColor = Color or library.flags[Team .. Occluded .. "Direction Color"]

									--Chams
									if library.flags[Team .. " Chams Enabled"] and Distance < 600 then
										Objects.ChamsVisible = true
										Objects.Chams.Parent = library.base
										Objects.ChamsStep = Objects.ChamsStep + Step
										if Objects.ChamsStep > 0.2 then
											Objects.ChamsStep = 0
											for _, PartName in next, UseBodyParts do
												local Part = FFC((GameTitle == "Bad Business" and Character.Body or Character), PartName, true)
												if Part then
													local Cham = FFC(Objects.Chams, PartName) or (function()
														return library:Create("BoxHandleAdornment", {
															Name = PartName,
															AlwaysOnTop = true,
															ZIndex = 2,
															Parent = Objects.Chams
														})
													end)()

													Cham.Size = Part.Size
													Cham.Adornee = Part
													Cham.Transparency = library.flags[Team .. " Chams Transparency"]
													Cham.Color3 = ChamsColor

													if library.flags[Team .. " Chams Outline"] then
														Objects.ChamsOutlineVisible = true
														Objects.ChamsOutline.Parent = library.base
														Cham = FFC(Objects.ChamsOutline, PartName) or (function()
															return library:Create("BoxHandleAdornment", {
																Name = PartName,
																AlwaysOnTop = true,
																ZIndex = 1,
																Parent = Objects.ChamsOutline
															})
														end)()

														Cham.Size = Part.Size * 1.2
														Cham.Adornee = Part
														Cham.Transparency = library.flags[Team .. " Chams Transparency"]
														Cham.Color3 = ChamsOutlineColor
													else
														if Objects.ChamsOutlineVisible then
															Objects.InvisChamsOutline()
														end
													end
												else
													local Cham = FFC(Objects.Chams, PartName)
													if Cham then
														Cham.Visible = false
													end
													Cham = FFC(Objects.ChamsOutline, PartName)
													if Cham then
														Cham.Visible = true
													end
												end
											end
										end
									else
										if Objects.ChamsVisible then
											Objects.InvisChams()
											Objects.InvisChamsOutline()
										end
									end

									--ESP
									local Height = (Camera.CFrame - Camera.CFrame.p) * Vector3.new(0, (math.clamp(Size.Y, 1, 10) + 0.5) / 2, 0)
									Height = math.abs(WTSP(Camera, Pos.Position + Height).Y - WTSP(Camera, Pos.Position - Height).Y)
									--local ViewportSize = Camera.ViewportSize
									--local Size = ((ViewportSize.X + ViewportSize.Y) / Distance) * (1 - (Camera.FieldOfView / 200))
									Size = library.round(Vector2.new(Height / 2, Height))
									local Position = library.round(Vector2.new(ScreenPosition.X, ScreenPosition.Y) - (Size / 2))

									if library.flags[Team .. " Box Enabled"] then
										Objects.Box.Visible = true
										Objects.Box.Color = BoxColor
										Objects.Box.Size = Size
										Objects.Box.Position = Position
										Objects.Box.Transparency = Transparency

										Objects.BoxOutline.Visible = true
										Objects.BoxOutline.Size = Size + V222
										Objects.BoxOutline.Position = Position - V211
										Objects.BoxOutline.Transparency = Transparency

										Objects.BoxInline.Visible = true
										Objects.BoxInline.Size = Size - V222
										Objects.BoxInline.Position = Position + V211
										Objects.BoxInline.Transparency = Transparency
									else
										Objects.Box.Visible = false
										Objects.BoxOutline.Visible = false
										Objects.BoxInline.Visible = false
									end

									if library.flags[Team .. " Health Enabled"] then
										local MaxHealth = Data.MaxHealth
										local HealthPerc = Health / MaxHealth
										local Position = Position - HealthBarAddon
										local Size = Vector2.new(1, Size.Y)

										Objects.BarOutline.Visible = true
										Objects.BarOutline.Position = Position - V211
										Objects.BarOutline.Size = Size + V222
										Objects.BarOutline.Transparency = Transparency

										Objects.Bar.Visible = true
										Objects.Bar.Color = Color3.new(1 - HealthPerc, HealthPerc, 0.2)
										Objects.Bar.Position = Position + Vector2.new(0, Size.Y)
										Objects.Bar.Size = Vector2.new(1, -Size.Y * HealthPerc)
										Objects.Bar.Transparency = Transparency

										Objects.HealthText.Visible = HealthPerc < 0.99
										Objects.HealthText.Position = Objects.Bar.Position + Objects.Bar.Size - Vector2.new(0, 7)
										Objects.HealthText.Text = tostring(library.round(Health)) or ""
										Objects.HealthText.Transparency = Transparency
									else
										Objects.BarOutline.Visible = false
										Objects.Bar.Visible = false
										Objects.HealthText.Visible = false
									end

									if library.flags[Team .. " Info"] then
										Objects.NameText.Visible = true
										Objects.NameText.Text = GameTitle == "Blackhawk Rescue Mission" and (Player.ClassName == "Model" and (Player.Name:find("Infantry") and "Infantry" or "Civilian")) or Player.Name
										Objects.NameText.Position = Position + Vector2.new(Size.X / 2, -Objects.NameText.TextBounds.Y - 1)
										Objects.NameText.Color = TextColor
										Objects.NameText.Transparency = Transparency

										Objects.DistanceText.Visible = true
										Objects.DistanceText.Text = "[" .. library.round(Distance) .. "m]"
										Objects.DistanceText.Position = Position + Vector2.new(Size.X / 2, Size.Y + 2)
										Objects.DistanceText.Color = TextColor
										Objects.DistanceText.Transparency = Transparency
									else
										Objects.NameText.Visible = false
										Objects.DistanceText.Visible = false
									end

									if library.flags[Team .. " Look Enabled"] then
										HeadPosition = GetHitboxFromChar(Character, "Head")
										if HeadPosition then
											Objects.LookAt.Visible = true
											HeadPosition1 = WTVP(Camera, HeadPosition.Position)
											local To = WTVP(Camera, HeadPosition.Position + (HeadPosition.CFrame.LookVector * 8))

											Objects.LookAt.From = Vector2.new(HeadPosition1.X, HeadPosition1.Y)
											Objects.LookAt.To = Vector2.new(To.X, To.Y)
											Objects.LookAt.Color = LookColor
											Objects.LookAt.Transparency = Transparency
										else
											Objects.LookAt.Visible = false
										end
									else
										Objects.LookAt.Visible = false
									end

									if library.flags[Team .. " Direction Enabled"] then
										Objects.DirectionLine.Visible = true

										Position = Position + (Size / 2)
										local PositionOffset2d = V2Empty
										local Diff = (Pos.Position - Data.LastPosition)
										if Diff.Magnitude > 0.01 then
											PositionOffset2d = library.round(Vector2.new(WTSP(Camera, Pos.Position + (Diff.Unit * 4)).X, Position.Y) - Position)
										end

										Objects.DirectionLine.From = Position
										Objects.DirectionLine.To = Position + PositionOffset2d
										Objects.DirectionLine.Color = DirectionColor
										Objects.DirectionLine.Transparency = Transparency

										if Distance < 600 then
											Objects.DirectionDot.Visible = true
											Objects.DirectionDot.Position = Objects.DirectionLine.To - V233
											Objects.DirectionDot.Color = DirectionColor
											Objects.DirectionDot.Transparency = Transparency
										else
											Objects.DirectionDot.Visible = false
										end
									else
										Objects.DirectionLine.Visible = false
										Objects.DirectionDot.Visible = false
									end

									Data.LastPosition = Pos.Position
									continue
								end
								if library.flags[Team .. " OOV Arrows"] then
									Objects.OOVArrow.Visible = true
									Objects.OOVArrow.Color = Color or library.flags[Team .. Occluded .. "OOV Arrows Color"]

									local RelativePos = Camera.CFrame:Inverse() * Pos.Position
									local Middle = Camera.ViewportSize / 2
									local Degrees = math.deg(math.atan2(-RelativePos.Y, RelativePos.X)) * math.pi / 180
									local EndPos = Middle + (Vector2.new(math.cos(Degrees), math.sin(Degrees)) * library.flags[Team .. " Out Of View Scale"])

									Objects.OOVArrow.PointB = EndPos + (-(Middle - EndPos).Unit * 15)
									Objects.OOVArrow.PointA = EndPos
									Objects.OOVArrow.PointC = EndPos
									Objects.OOVArrow.Transparency = Transparency

									if not Objects.Visible then
										continue
									end
								end
							end
						end
					end
				end

				Objects.OOVArrow.Visible = false
				if Objects.Visible then
					Objects.Invis()
					Objects.InvisChams()
					Objects.InvisChamsOutline()
					Objects.InvisRadar()
				end
			end
		end)
	end}):AddList({flag = "Esp Enabled For", values = {"Enemies", "Teammates"}, multiselect = true}):AddBind({callback = function()
		library.options["Esp Enabled"]:SetState(not library.flags["Esp Enabled"])
	end})
	PlayerEspSection:AddSlider({text = "Max Distance", textpos = 2, flag = "Esp Max Distance", value = 5000, min = 0, max = 10000})
	PlayerEspSection:AddToggle({text = "Show Whitelisted Players", flag = "Esp Show Whitelisted"})

	--PlayerEspSection:AddDivider"Radar"
	--PlayerEspSection:AddToggle({text = "Enabled", flag = "Radar Enabled", callback = function(State)
	--	RadarWindow.Visible = State and library.flags["Esp Enabled"]
	--end})
	local VisualsWorld = VisualsColumn:AddSection"Lighting"
	VisualsWorld:AddToggle({text = "Clock Time"}):AddSlider({flag = "Clock Time Amount", min = 0, max = 24, float = 0.1, value = LightingSpoof.ClockTime})
	VisualsWorld:AddToggle({text = "Brightness"}):AddSlider({flag = "Brightness Amount", min = 0, max = 100, float = 0.1, value = LightingSpoof.Brightness})
	VisualsWorld:AddToggle({text = "Ambient", flag = "Ambient Lighting"}):AddColor({flag = "Outdoor Ambient", color = LightingSpoof.OutdoorAmbient}):AddColor({flag = "Indoor Ambient", color = LightingSpoof.Ambient})
	VisualsWorld:AddToggle({text = "Color Shift"}):AddColor({flag = "Color Shift Top", color = LightingSpoof.ColorShift_Top})

	local VisualsMiscSection = VisualsColumn:AddSection"Misc"

	VisualsMiscSection:AddToggle({text = "FOV Changer", callback = function(State)
		library.options["Dynamic Custom FOV"].main.Visible = State
	end}):AddSlider({flag = "FOV Amount", min = 0, max = 120})
	VisualsMiscSection:AddToggle({text = "Dynamic", flag = "Dynamic Custom FOV"})
	VisualsMiscSection:AddToggle({text = "Zoom", flag = "FOV Zoom Enabled"}):AddSlider({flag = "FOV Zoom Amount", min = 5, max = 50}):AddBind({flag = "FOV Zoom Key", mode = "hold"})

	VisualsMiscSection:AddDivider"Crosshair"
	VisualsMiscSection:AddToggle({text = "Enabled", flag = "Crosshair Enabled", callback = function(State)
		library.options["Crosshair T-Shape"].main.Visible = State
		library.options["Crosshair Size"].main.Visible = State
		library.options["Crosshair Gap"].main.Visible = State
		library.options["Crosshair Thickness"].main.Visible = State
		CrosshairTop.Visible = State and not library.flags["Crosshair T-Shape"]
		CrosshairLeft.Visible = State
		CrosshairRight.Visible = State
		CrosshairBottom.Visible = State
	end}):AddColor({callback = function(Color)
		CrosshairTop.Color = Color
		CrosshairLeft.Color = Color
		CrosshairRight.Color = Color
		CrosshairBottom.Color = Color
	end, trans = 1, calltrans = function(Transparency)
		CrosshairTop.Transparency = Transparency
		CrosshairLeft.Transparency = Transparency
		CrosshairRight.Transparency = Transparency
		CrosshairBottom.Transparency = Transparency
	end})
	VisualsMiscSection:AddToggle({text = "T-Shape", flag = "Crosshair T-Shape", callback = function(State)
		CrosshairTop.Visible = library.flags["Crosshair Enabled"] and not State
	end})
	VisualsMiscSection:AddSlider({text = "Size", textpos = 2, flag = "Crosshair Size", min = 1, max = 500, callback = function(Value)
		local Thickness = library.flags["Crosshair Thickness"]
		CrosshairTop.Size = Vector2.new(Thickness, -Value)
		CrosshairLeft.Size = Vector2.new(-Value, Thickness)
		CrosshairRight.Size = Vector2.new(Value, Thickness)
		CrosshairBottom.Size = Vector2.new(Thickness, Value)
	end})
	VisualsMiscSection:AddSlider({text = "Gap", textpos = 2, flag = "Crosshair Gap", min = 0, max = 20, float = 0.5})
	VisualsMiscSection:AddSlider({text = "Thickness", textpos = 2, flag = "Crosshair Thickness", min = 1, max = 20, float = 0.5, callback = function(Value)
		local Size = library.flags["Crosshair Size"]
		CrosshairTop.Size = Vector2.new(Value, -Size)
		CrosshairLeft.Size = Vector2.new(-Size, Value)
		CrosshairRight.Size = Vector2.new(Size, Value)
		CrosshairBottom.Size = Vector2.new(Value, Size)
	end})

	local PlayerEspEnemySection = VisualsColumn1:AddSection"Enemies"
	PlayerEspEnemySection:AddToggle({text = "Visible Only", flag = "Enemy Visible Only"})

	PlayerEspEnemySection:AddToggle({text = "Box", flag = "Enemy Box Enabled"}):AddColor({flag = "Enemy Occluded Box Color", color = Color3.fromRGB(245, 120, 65)}):AddColor({flag = "Enemy Box Color", color = Color3.fromRGB(240, 40, 50)})

	PlayerEspEnemySection:AddToggle({text = "Info", flag = "Enemy Info"}):AddColor({flag = "Enemy Occluded Info Color", color = Color3.fromRGB(255, 140, 30)}):AddColor({flag = "Enemy Info Color", color = Color3.fromRGB(240, 30, 40)})

	PlayerEspEnemySection:AddToggle({text = "Health", flag = "Enemy Health Enabled"})

	PlayerEspEnemySection:AddToggle({text = "Out Of View", flag = "Enemy OOV Arrows", callback = function(State)
		library.options["Enemy Out Of View Scale"].main.Visible = State
	end}):AddColor({flag = "Enemy Occluded OOV Arrows Color", color = Color3.fromRGB(255, 140, 30)}):AddColor({flag = "Enemy OOV Arrows Color", color = Color3.fromRGB(240, 30, 40)})
	PlayerEspEnemySection:AddSlider({text = "Scale", textpos = 2, flag = "Enemy Out Of View Scale", min = 100, max = 500})

	PlayerEspEnemySection:AddToggle({text = "Look Direction", flag = "Enemy Look Enabled"}):AddColor({flag = "Enemy Occluded Look Color", color = Color3.fromRGB(240, 120, 80)}):AddColor({flag = "Enemy Look Color", color = Color3.fromRGB(240, 60, 20)})

	PlayerEspEnemySection:AddToggle({text = "Velocity", flag = "Enemy Direction Enabled"}):AddColor({flag = "Enemy Occluded Direction Color", color = Color3.fromRGB(240, 120, 80)}):AddColor({flag = "Enemy Direction Color", color = Color3.fromRGB(240, 60, 20)})

	PlayerEspEnemySection:AddToggle({text = "Chams", flag = "Enemy Chams Enabled"}):AddSlider({text = "Transparency", flag = "Enemy Chams Transparency", min = 0, max = 1, float = 0.1}):AddColor({flag = "Enemy Occluded Chams Color", color = Color3.fromRGB(245, 120, 65)}):AddColor({flag = "Enemy Chams Color", color = Color3.fromRGB(240, 40, 50)})
	PlayerEspEnemySection:AddToggle({text = "Outline", flag = "Enemy Chams Outline"}):AddColor({flag = "Enemy Occluded Chams Outline Color", color = Color3.fromRGB(245, 120, 65)}):AddColor({flag = "Enemy Chams Outline Color", color = Color3.fromRGB(240, 40, 50)})

	local PlayerEspTeamSection = VisualsColumn1:AddSection"Teammates"
	PlayerEspTeamSection:AddToggle({text = "Visible Only", flag = "Team Visible Only"})

	PlayerEspTeamSection:AddToggle({text = "Box", flag = "Team Box Enabled"}):AddColor({flag = "Team Occluded Box Color", color = Color3.fromRGB(20, 50, 255)}):AddColor({flag = "Team Box Color", color = Color3.fromRGB(40, 255, 180)})

	PlayerEspTeamSection:AddToggle({text = "Info", flag = "Team Info"}):AddColor({flag = "Team Occluded Info Color", color = Color3.fromRGB(20, 120, 255)}):AddColor({flag = "Team Info Color", color = Color3.fromRGB(40, 240, 130)})

	PlayerEspTeamSection:AddToggle({text = "Health", flag = "Team Health Enabled"})

	PlayerEspTeamSection:AddToggle({text = "Out Of View", flag = "Team OOV Arrows", callback = function(State)
		library.options["Team Out Of View Scale"].main.Visible = State
	end}):AddColor({flag = "Team Occluded OOV Arrows Color", color = Color3.fromRGB(20, 120, 255)}):AddColor({flag = "Team OOV Arrows Color", color = Color3.fromRGB(40, 240, 130)})
	PlayerEspTeamSection:AddSlider({text = "Scale", textpos = 2, flag = "Team Out Of View Scale", min = 100, max = 500})

	PlayerEspTeamSection:AddToggle({text = "Look Direction", flag = "Team Look Enabled"}):AddColor({flag = "Team Occluded Look Color", color = Color3.fromRGB(40, 80, 230)}):AddColor({flag = "Team Look Color", color = Color3.fromRGB(40, 250, 100)})

	PlayerEspTeamSection:AddToggle({text = "Velocity", flag = "Team Direction Enabled"}):AddColor({flag = "Team Occluded Direction Color", color = Color3.fromRGB(240, 120, 80)}):AddColor({flag = "Team Direction Color", color = Color3.fromRGB(240, 60, 20)})

	PlayerEspTeamSection:AddToggle({text = "Chams", flag = "Team Chams Enabled"}):AddSlider({text = "Transparency", flag = "Team Chams Transparency", min = 0, max = 1, float = 0.1}):AddColor({flag = "Team Occluded Chams Color", color = Color3.fromRGB(20, 50, 255)}):AddColor({flag = "Team Chams Color", color = Color3.fromRGB(40, 255, 180)})
	PlayerEspTeamSection:AddToggle({text = "Outline", flag = "Team Chams Outline"}):AddColor({flag = "Team Occluded Chams Outline Color", color = Color3.fromRGB(80, 100, 255)}):AddColor({flag = "Team Chams Outline Color", color = Color3.fromRGB(80, 255, 200)})

	--Misc stuff
	local MiscTab = library:AddTab"Misc"
	local MiscColumn = MiscTab:AddColumn()
	local MiscColumn1 = MiscTab:AddColumn()
	local MiscMain = MiscColumn:AddSection"Main"
	MiscMain:AddButton({text = "Copy Discord invite", callback = function() setclipboard("https://discord.gg/") end})
	MiscMain:AddButton({text = "aaa", callback = function() library:LoadConfig(Default)end})
	if syn then
		MiscMain:AddSlider({text = "Set FPS Cap", min = 60, max = 300, callback = function(Value) setfpscap(Value) end})
	end
	local Lagging
	MiscMain:AddToggle({text = "Lag Switch", callback = function()
		Lagging = false
		Settings.Network.IncomingReplicationLag = 0
	end}):AddSlider({text = "Timeout", flag = "Lag Switch Timeout", min = 1, max = 10, float = 0.1, suffix = "s"}):AddBind({callback = function()
		if library.flags["Lag Switch"] then
			Lagging = not Lagging
			Settings.Network.IncomingReplicationLag = Lagging and 1000 or 0
			if Lagging then
				local LagStart = tick()
				while Lagging do
					wait(1)
					if tick() - LagStart >= library.flags["Lag Switch Timeout"] then
						library.options["Lag Switch"].callback()
					end
				end
			end
		end
	end})

	local PlayerList = MiscColumn1:AddSection"Player List"
	PlayerList:AddList({flag = "Player List", textpos = 2, skipflag = true, max = 10, values = (function() local t = {} for _, Player in next, PlayerServ:GetPlayers() do if Player ~= Client then table.insert(t, Player.Name) end end return t end)(), callback = function(Value)
		local Player = Players[FFC(PlayerServ, Value)]
		library.options["Set Player Priority"]:SetState(Player and Player.Priority, true)
		library.options["Set Player Whitelist"]:SetState(Player and Player.Whitelist, true)
	end})
	PlayerList:AddToggle({text = "Priority", skipflag = true, style = 2, flag = "Set Player Priority", callback = function(State)
		local Player = Players[FFC(PlayerServ, library.flags["Player List"])]
		if Player then
			Player.Priority = State
			if State then
				library.options["Set Player Whitelist"]:SetState(false)
			end
		end
	end}):AddColor({flag = "Player Priority Color", color = Color3.fromRGB(255, 255, 0)})
	PlayerList:AddToggle({text = "Whitelist", skipflag = true, style = 2, flag = "Set Player Whitelist", callback = function(State)
		local Player = Players[FFC(PlayerServ, library.flags["Player List"])]
		if Player then
			Player.Whitelist = State
			if State then
				library.options["Set Player Priority"]:SetState(false)
			end
		end
	end}):AddColor({flag = "Player Whitelist Color", color = Color3.fromRGB(0, 255, 255)})

	--Hooks
	local OldCallingScript
	OldCallingScript = hookfunction(getcallingscript, function()
		return OldCallingScript() or {}
	end)

	local Old_new
	Old_new = hookmetamethod(game, "__newindex", function(t, i, v)
		if checkcaller() or not library then return Old_new(t, i, v) end

		if t == Lighting then
			if i == "ClockTime" then
				LightingSpoof[i] = v
				v = library.flags["ClockTime"] and library.flags["Clock Time Amount"] or v
			elseif i == "Brightness" then
				LightingSpoof[i] = v
				v = library.flags["Brightness"] and library.flags["Brightness Amount"] or v
			elseif i == "Ambient" or i == "OutdoorAmbient" then
				LightingSpoof[i] = v
				v = library.flags["Ambient Lighting"] and (i == "Ambient" and library.flags["Indoor Ambient"] or library.flags["Outdoor Ambient"]) or v
			elseif i == "ColorShift_Top" then
				LightingSpoof[i] = v
				v = library.flags["Color Shift"] and library.flags["Color Shift Top"] or v
			end
		elseif t == Camera then
			if i == "FieldOfView" then
				CameraSpoof[i] = v
				v = (library.flags["FOV Zoom Enabled"] and library.flags["FOV Zoom Key"] and (50 - library.flags["FOV Zoom Amount"])) or library.flags["FOV Changer"] and (library.flags["Dynamic Custom FOV"] and (CameraSpoof.FieldOfView + library.flags["FOV Amount"]) or library.flags["FOV Amount"]) or v
			end
		end

		return Old_new(t, i, v)
	end)

	local Old_index


	local Old_call
	Old_call= hookmetamethod(game, "__namecall", function(self, ...)
		if checkcaller() or not library then return Old_call(self, ...) end

		local Args = {...}
		local Method = getnamecallmethod()

		

		return Old_call(self, unpack(Args))
	end)

	--Games
	local Loaded, LoadError = true
	library.flagprefix = GameTitle

	Loaded, LoadError = pcall(function()

	end)

	library.flagprefix = nil

	if VisualsTab.canInit then
		AddTracker(PlayerServ)
	end

	--Always running
	library:AddConnection(runService.RenderStepped, function()
		local MX, MY = Mouse.X, Mouse.Y + 36
		if library.flags["Mouse Offset"] then
			MX = MX + library.flags["MXO Amount"]
			MY = MY + library.flags["MYO Amount"]
		end

		if Draw.Visible then
			Draw.Position = Vector2.new(MX, MY)
		end

		--if RadarWindow.Visible then
		--	RadarWindow.Position = Vector2.new(MX, MY)
		--end

		if CrosshairBottom.Visible then
			local Thickness = library.flags["Crosshair Thickness"] / 2
			local TX, TY = MX - Thickness, MY - Thickness
			CrosshairTop.Position = Vector2.new(TX, MY - library.flags["Crosshair Gap"])
			CrosshairLeft.Position = Vector2.new(MX - library.flags["Crosshair Gap"], TY)
			CrosshairRight.Position = Vector2.new(MX + library.flags["Crosshair Gap"], TY)
			CrosshairBottom.Position = Vector2.new(TX, MY + library.flags["Crosshair Gap"])
		end
		
		Lighting.ClockTime = library.flags["Clock Time"] and library.flags["Clock Time Amount"] or LightingSpoof.ClockTime
		Lighting.Brightness = library.flags["Brightness"] and library.flags["Brightness Amount"] or LightingSpoof.Brightness
		Lighting.Ambient = library.flags["Ambient Lighting"] and library.flags["Indoor Ambient"] or LightingSpoof.Ambient
		Lighting.OutdoorAmbient = library.flags["Ambient Lighting"] and library.flags["Outdoor Ambient"] or LightingSpoof.OutdoorAmbient
		Lighting.ColorShift_Top = library.flags["Color Shift"] and library.flags["Color Shift Top"] or LightingSpoof.ColorShift_Top

		Camera.FieldOfView = (library.flags["FOV Zoom Enabled"] and library.flags["FOV Zoom Key"] and (50 - library.flags["FOV Zoom Amount"])) or library.flags["FOV Changer"] and (library.flags["Dynamic Custom FOV"] and (CameraSpoof.FieldOfView + library.flags["FOV Amount"]) or library.flags["FOV Amount"]) or CameraSpoof.FieldOfView
	end)

	library:Init()

	delay(1, function() library:LoadConfig(tostring(getgenv().autoload)) end)

	if not getgenv().silent then
		if Loaded then
			library:SendNotification(5, "Loaded " .. (GameTitle or "universal features") .. " successfully")
		else
			library:SendNotification(5, "Failed to load " .. (GameTitle or "universal features") .. " (error copied to clipboard)")
			setclipboard(LoadError)
		end
	end

	if not library:GetConfigs()[1] then
		writefile(library.foldername .. "/Default" .. library.fileext, loadstring(game:HttpGet("https://raw.githubusercontent.com/Jan5106/uwuware_final/main/default_config.lua", true))())
		library.options["Config List"]:AddValue"Default"
		library:LoadConfig"Default"
	end
spawn(function ()
	library:LoadConfig(library.flags["Config List"])
end)
