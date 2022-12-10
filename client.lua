local NDCore = exports['nd-core']:GetCoreObject()

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }
  


--- Конфиг ---
--- Да започнеш лова на пилета
local startX = 2388.37  
local startY = 5045.8
local startZ = 46.37

--- Разфасоване
local portionX = -95.72   
local portionY = 6207.15
local portionZ = 31.03

--- Разфасоване
local portionX2 = -100.52   
local portionY2 = 6202.48
local portionZ2 = 31.03

--- Опаковане
local packingX = -106.44    
local packingY = 6204.29
local packingZ = 31.02

--- Опаковане
local packingX2 = -104.20   
local packingY2 = 6206.45
local packingZ2 = 31.02

--- Продажба
local sellX = 180.18841    
local sellY = -1637.882
local sellZ = 29.291751

local chicken1
local chicken2
local chicken3
local Caught1 = 0
local Caught2 = 0
local Caught3 = 0
local andsplashed = 0
local share = false
local prop
local zapakowaneDoauta = false
local karton
local mieso
local packs = 0

--- Местоположение 
Citizen.CreateThread(function()
	local lapaniek = AddBlipForCoord(startX, startY, startZ)
		SetBlipSprite (lapaniek, 126)
		SetBlipDisplay(lapaniek, 4)
		SetBlipScale  (lapaniek, 0.6)
		SetBlipColour (lapaniek, 46)
		SetBlipAsShortRange(lapaniek, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Пилешка ферма')
		EndTextCommandSetBlipName(lapaniek)
	local rzeznia = AddBlipForCoord(portionX, portionY, portionZ)
		SetBlipSprite (rzeznia, 514)
		SetBlipDisplay(rzeznia, 4)
		SetBlipScale  (rzeznia, 0.7)
		SetBlipColour (rzeznia, 46)
		SetBlipAsShortRange(rzeznia, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Кланица')
		EndTextCommandSetBlipName(rzeznia)
	local skupk = AddBlipForCoord(sellX, sellY, sellZ)
		SetBlipSprite (skupk, 207)
		SetBlipDisplay(skupk, 4)
		SetBlipScale  (skupk, 0.5)
		SetBlipColour (skupk, 46)
		SetBlipAsShortRange(skupk, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Търговец на пилешко месо')
		EndTextCommandSetBlipName(skupk)
end)

--- Citizen 
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, startX, startY, startZ)
			
		if dist <= 20.0 then
		DrawMarker(27, startX, startY, startZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		else
		Citizen.Wait(1500)
		end
		
		if dist <= 2.5 then
		DrawText3D(startX, startY, startZ, "~g~[E]~w~Старт")
		end
			
		if dist <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
			TriggerServerEvent("nd-chickenjob:startChicken")
			LapChicken()
			end			
		end
	end
end)

Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, portionX, portionY, portionZ)
		local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, portionX2, portionY2, portionZ2)
		local distP = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packingX, packingY, packingZ)
		local distP2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packingX2, packingY2, packingZ2)

		if dist <= 25.0 then
		DrawMarker(27, portionX, portionY, portionZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, portionX2, portionY2, portionZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, packingX, packingY, packingZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, packingX2, packingY2, packingZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		else
		Citizen.Wait(1500)
		end
		
		if dist <= 2.5 then
		DrawText3D(portionX, portionY, portionZ, "~g~[E]~w~Разфасоване")
		end

		if dist <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
				portioning(1)
			end			
		end
		
		if dist2 <= 2.5 then
		DrawText3D(portionX2, portionY2, portionZ2, "~g~[E]~w~Разфасоване")
		end

		if dist2 <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
				portioning(2)
			end			
		end
		--
		if distP <= 2.5 and packs == 0 then
		DrawText3D(packingX, packingY, packingZ, "~g~[E]~w~Опаковай пиле")
		elseif distP <= 2.5 and packs == 1 then
		DrawText3D(packingX, packingY, packingZ, "~r~[G]~w~Спрете опаковането")
		DrawText3D(packingX, packingY, packingZ+0.1, "~g~[E]~w~Продължи опаковането")
		end

		if distP <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then 
			packingg(1)
			elseif IsControlJustPressed(0, Keys['G']) then
			packed(1)
			end			
		end
		
		if distP2 <= 2.5 and packs == 0 then
		DrawText3D(packingX2, packingY2, packingZ2, "~g~[E]~w~Опаковай пиле")
		elseif distP2 <= 2.5 and packs == 1 then
		DrawText3D(packingX2, packingY2, packingZ2, "~r~[G]~w~Спрете опакованет")
		DrawText3D(packingX2, packingY2, packingZ2+0.1, "~g~[E]~w~Продължи опаковането")
		end

		if distP2 <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
			packingg(2)
			elseif IsControlJustPressed(0, Keys['G']) then
			packed(2)
			end		
		end	
	end
end)


Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX, sellY, sellZ)
	
	if dist <= 20.0 then
	--DrawMarker(0, sellX, sellY, sellZ-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
	else
	Citizen.Wait(1000)
	end
	
	if dist <= 2.0 then
	DrawText3D(sellX, sellY, sellZ+0.1, "~g~[E]~w~Продай")
		if IsControlJustPressed(0, Keys['E']) then 
		packedsell()
		end	
	end
end
end)


-- Code

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    --DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end



function LapChicken()
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), 2385.963, 5047.333, 46.400, 0, 0, 1)
	RequestModel(GetHashKey('a_c_hen'))
	while not HasModelLoaded(GetHashKey('a_c_hen')) do
	Wait(1)
	end
	chicken1 = CreatePed(26, "a_c_hen", 2370.262, 5052.913, 46.437, 276.351, true, false)
	chicken2 = CreatePed(26, "a_c_hen", 2372.040, 5059.604, 46.444, 223.595, true, false)
	chicken3 = CreatePed(26, "a_c_hen", 2379.192, 5062.992, 46.444, 195.477, true, false)
	TaskReactAndFleePed(chicken1, GetPlayerPed(-1))
	TaskReactAndFleePed(chicken2, GetPlayerPed(-1))
	TaskReactAndFleePed(chicken3, GetPlayerPed(-1))
	Citizen.Wait(500)
	DoScreenFadeIn(500)
	share = true
end


function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end


Citizen.CreateThread(function()
    while true do
    Citizen.Wait(5)
	
if share == true then
	local chicken1Coords = GetEntityCoords(chicken1)
	local chicken2Coords = GetEntityCoords(chicken2)
	local chicken3Coords = GetEntityCoords(chicken3)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken1Coords.x, chicken1Coords.y, chicken1Coords.z)
	local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken2Coords.x, chicken2Coords.y, chicken2Coords.z)
	local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken3Coords.x, chicken3Coords.y, chicken3Coords.z)
	
	if andsplashed == 3 then
	Caught1 = 0
	Caught2 = 0
	Caught3 = 0
	andsplashed = 0
	share = false
	NDCore.Functions.Notify("Take Alived Chiken To Process Area ..", "primary")
	TriggerServerEvent("nd-chickenjob:getNewChicken")
	end
	
	if dist <= 1.0 then
	DrawText3D(chicken1Coords.x, chicken1Coords.y, chicken1Coords.z+0.5, "~o~[E]~b~Хвани")
		if IsControlJustPressed(0, Keys['E']) then 
		Caught1 = 1
		hewassplashed()
		end	
	elseif dist2 <= 1.0 then
		DrawText3D(chicken2Coords.x, chicken2Coords.y, chicken2Coords.z+0.5, "~o~[E]~b~Хвани")
		if IsControlJustPressed(0, Keys['E']) then 
		Caught2 = 1
		hewassplashed()
		end	
	elseif dist3 <= 1.0 then
		DrawText3D(chicken3Coords.x, chicken3Coords.y, chicken3Coords.z+0.5, "~o~[E]~b~Хвани")
		if IsControlJustPressed(0, Keys['E']) then 
		Caught3 = 1
		hewassplashed()
		end	
	end
else
Citizen.Wait(500)
end	
end
end)



function hewassplashed()
	LoadDict('move_jump')
	TaskPlayAnim(GetPlayerPed(-1), 'move_jump', 'dive_start_run', 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
	Citizen.Wait(600)
	SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	Citizen.Wait(1000)
	ragdoll = true
	local chanceofsplashes = math.random(1,100)
	if chanceofsplashes <= 60 then
			NDCore.Functions.Notify("Успяхте да хванете 1 пиле!", "success")
			if Caught1 == 1 then
				DeleteEntity(chicken1)
				Caught1 = 0
				andsplashed = andsplashed +1
			elseif Caught2 == 1 then
				DeleteEntity(chicken2)
				Caught2 = 0
				andsplashed = andsplashed +1
			elseif Caught3 == 1 then
				DeleteEntity(chicken3)
				Caught3 = 0
				andsplashed = andsplashed +1
			end
		else
		NDCore.Functions.Notify("Пилето избяга от ръцете ти!", "error")
	end
end


function packingg(stanowisko)
	local inventory =  NDCore.Functions.GetPlayerData()
	
	NDCore.Functions.TriggerCallback('NDCore:HasItem', function(result)
		if result then
			SetEntityHeading(GetPlayerPed(-1), 40.0)
			local PedCoords = GetEntityCoords(GetPlayerPed(-1))
			mieso = CreateObject(GetHashKey('prop_cs_steak'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
			AttachEntityToEntity(mieso, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			karton = CreateObject(GetHashKey('prop_cs_clothes_box'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
			AttachEntityToEntity(karton, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
			packs = 1
			LoadDict("anim@heists@ornate_bank@grab_cash_heels")
			TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
			FreezeEntityPosition(GetPlayerPed(-1), true)
			NDCore.Functions.Progressbar("wash-", "Опаковане..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
			TriggerServerEvent("nd-chickenjob:getpackedChicken",2)
			NDCore.Functions.Notify("Продължете да опаковате пилета или отидете до превозното средство и го съхранявайте .", "primary")
			ClearPedTasks(GetPlayerPed(-1))
			DeleteEntity(karton)
			DeleteEntity(mieso)
			end, function() -- Cancel
				--isWashing = false
				ClearPedTasksImmediately(player)
				FreezeEntityPosition(player, false)
			end)
		else
		
		NDCore.Functions.Notify("Нямате какво да опаковате!", "error")
		end
	end, 'slaughteredchicken')
end


function packed(stanowisko)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	zapakowaneDoauta = true
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	packs = 0
	while zapakowaneDoauta do
	Citizen.Wait(250)
	
	local coords    = GetEntityCoords(GetPlayerPed(-1))
	LoadDict('anim@heists@box_carry@')
	
		if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and zapakowaneDoauta == true then
		TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
		
		zapakowaneDoauta = false
		NDCore.Functions.Notify("You stopped packing!", "error")
		LoadDict('anim@heists@narcotics@trash')
		TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		Citizen.Wait(900)
		ClearPedTasks(GetPlayerPed(-1))
		DeleteEntity(prop)
	
	end
end


function portioning(position)
	local inventory =  NDCore.Functions.GetPlayerData()
	
	NDCore.Functions.TriggerCallback('NDCore:HasItem', function(result)
		if result then
			local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
			LoadDict(dict)
			FreezeEntityPosition(GetPlayerPed(-1),true)
			TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			local PedCoords = GetEntityCoords(GetPlayerPed(-1))
			nozyk = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
			AttachEntityToEntity(nozyk, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
			if position == 1 then
			SetEntityHeading(GetPlayerPed(-1), 311.0)
			kurczak = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)
			SetEntityRotation(kurczak,90.0, 0.0, 45.0, 1,true)
			NDCore.Functions.Progressbar("Cut-", "Разфасоване..", 25000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
			
			NDCore.Functions.Notify("Сега опаковайте закланото пиле!", "primary")
			TriggerServerEvent("nd-chickenjob:getcutChicken", 1)
			FreezeEntityPosition(GetPlayerPed(-1),false)
			DeleteEntity(kurczak)
			DeleteEntity(nozyk)
			end, function() -- Cancel
				FreezeEntityPosition(GetPlayerPed(-1),false)
				DeleteEntity(kurczak)
				DeleteEntity(nozyk)
				ClearPedTasks(GetPlayerPed(-1))
			end)
			elseif position == 2 then
			SetEntityHeading(GetPlayerPed(-1), 222.0)
			kurczak = CreateObject(GetHashKey('prop_int_cf_chick_01'),-100.39, 6201.56, 29.99, true, true, true)
			SetEntityRotation(kurczak,90.0, 0.0, -45.0, 1,true)

			NDCore.Functions.Progressbar("Cut-", "Разфасоване..", 25000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()

			NDCore.Functions.Notify("Сега опаковайте закланото пиле!", "primary")
			TriggerServerEvent("nd-chickenjob:getcutChicken", 1)
			FreezeEntityPosition(GetPlayerPed(-1),false)
			DeleteEntity(kurczak)
			DeleteEntity(nozyk)
			end, function() -- Cancel
				FreezeEntityPosition(GetPlayerPed(-1),false)
				DeleteEntity(kurczak)
				DeleteEntity(nozyk)
				ClearPedTasks(GetPlayerPed(-1))
			end)
			end
			
		else
			NDCore.Functions.Notify("Нямате никакви пилета!", "error")
		end
	end, 'alivechicken')
end

function packedsell()
	local inventory =  NDCore.Functions.GetPlayerData()
	NDCore.Functions.TriggerCallback('NDCore:HasItem', function(result)
		if result then
			local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
			prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
			SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
			LoadDict('amb@medic@standing@tendtodead@idle_a')
			TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
			NDCore.Functions.Progressbar("Cut-", "Продажба на пилета..", 10000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function()
				TriggerServerEvent("nd-chickenjob:sell",3)
				ClearPedTasks(GetPlayerPed(-1))
				DeleteEntity(prop)
			end, function() -- Cancel
				LoadDict('amb@medic@standing@tendtodead@exit')
				TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
				ClearPedTasks(GetPlayerPed(-1))
				DeleteEntity(prop)
				FreezeEntityPosition(GetPlayerPed(-1),false)
			end)
		else
			NDCore.Functions.Notify("Нямате какво да продавате!", "error")
		end
	
	end, 'packagedchicken')
end

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end
