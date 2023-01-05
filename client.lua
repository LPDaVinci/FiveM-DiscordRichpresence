Citizen.CreateThread(function()
    while true do
		--Fahrzeugname
		--local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
		--if VehName == "NULL" then VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) end
		
		--Straßenname anhand der Koordinaten
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		
		--Gesamt Spieler Anzahl Variable
		-- local playerCount = #GetActivePlayers()
		
		
        local PlayerName = GetPlayerName(PlayerId())
        local id = GetPlayerServerId(PlayerId())
        -- ApplicationID für Discord bitte eine neue Application erstellen unter: https://discord.com/developers/applications/
        SetDiscordAppId(<YOURAPPLICATIONID>)
		--Ohne Schnickschnack nur Anzeige von ID und Name
        --SetRichPresence("ID: "..id.." | "..PlayerName.." | ") -- This will take the player name and the Id
        -- Image für das Große Icon was im Discord angezeigt wird
        -- Als Rich Presence Assets unter https://discord.com/developers/applications/ hinzufügen bei der Application
        SetDiscordRichPresenceAsset('network_logo')
		--Image für das kleine Runde Icon im DC bei der Aktivitätsanzeige
		SetDiscordRichPresenceAssetSmall('network_logo_small')
		
		
        -- Hier der Titel der angezeigt wird als Aktivität
        SetDiscordRichPresenceAssetText('NAME')
        --[[ 
            Hier kann man Buttons hinzufügen, die man anklicken kann z.B. Connect zum FiveM Server oder Discordserver
        ]]--
        SetDiscordRichPresenceAction(0, "Join NAME", "fivem://connect/<SERVERIP>")
        SetDiscordRichPresenceAction(1, "Join Discord", "<DISCORDLINK>")
        --Mehre Knöpfe hinzufügen hiermit
        --SetDiscordRichPresenceAction(1, "Example", "https://example.com")
		
		--Hier bitte nur was editieren, wenn man Ahnung hat Streethash wird zwar nicht benötigt aber ich hatte keine Lust die if Statements anzupassen
		   if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Sprintet in der Gegend herum")
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Rennt in der Gegend umher")
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Spaziert in der Gegend herum")
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Steht in der Gegend herum")
				end
			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				--MPH statt KMH anzeige im Discord 
				-- local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
				--KMH
				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 3.6)
				if MPH > 30 then
					SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Fährt gerade: " ..MPH.." KM/h")				
				elseif MPH == 0 then
					SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Parkt gerade")
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
					SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Ist in der Luft")
				else
					SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Ist gelandet")
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Schwimmt umher")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Segelt umher")
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("ID: "..id.." | "..PlayerName.." | ".."Ist in einem U-Boot")
			end
		end
		
		
        -- Updates jede Minute
        -- Citizen.Wait(60000)
		-- Update alle 10 Sekunden
		Citizen.Wait(10000)
		-- Update alle 1 Sekunde
		--Citizen.Wait(1000)
		-- Alle 5 Minuten Update
		--Citizen.Wait(300000)
		
    end
end)

		


