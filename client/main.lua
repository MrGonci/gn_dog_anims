ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)



RegisterKeyMapping("MenuAnims", Config.keymap_name, "keyboard", Config.key);
RegisterCommand("MenuAnims", function()
	MenuAnims();
end)

MenuAnims = function()

	local id = PlayerPedId()
	local name = GetPlayerName(PlayerId())

	ESX.UI.Menu.CloseAll();

	ESX.UI.Menu.Open("default", GetCurrentResourceName(), "menu_perros", {
		title = Config.title,
		align = Config.align,
		elements = {
			{
				label = Config.sit_one,
				value = "sentarse"
			},
			{
				label = Config.sit_two,
				value = "sentarsedos"
			},
			{
				label = Config.sit_on_car,
				value = "sentarsecoche"
			},
			{
				label = Config.bark_one,
				value = "ladrar"
			},
			{
				label = Config.bark_two,
				value = "ladrardos"
			},
			{
				label = Config.sleep_one,
				value = "tumbarse"
			},
			{
				label = Config.sleep_two,
				value = "tumbarsedos"
			},
			{
				label = Config.piss_right,
				value = "mear"
			},
			{
				label = Config.piss_left,
				value = "meardos"
			},
			{
				label = Config.give_the_paw,
				value = "agpata"
			},
			{
				label = Config.receiving_caresses,
				value = "revcar"
			},
			{
				label = Config.draw_attention,
				value = "laten"
			},
			{
				label = Config.scratch,
				value = "ith"
			},
			{
				label = Config.scratch_the_door,
				value = "beg"
			},
			{
				label = Config.poop,
				value = "cagar"
			}
		}
	}, function(data, menu)
		if data.current.value == "sentarse" then
			hacerAnim(id, "creatures@rottweiler@amb@world_dog_sitting@base", "base")
		elseif data.current.value == "sentarsedos" then
			hacerAnim(id, "creatures@retriever@amb@world_dog_sitting@idle_a", "idle_b")
		elseif data.current.value == "sentarsecoche" then
			hacerAnim(id, "creatures@rottweiler@incar@", "sit")
		elseif data.current.value == "ladrar" then
			hacerAnim(id, "creatures@retriever@amb@world_dog_barking@idle_a", "idle_a")
		elseif data.current.value == "ladrardos" then
			hacerAnim(id, "creatures@rottweiler@amb@world_dog_barking@idle_a", "idle_a")
		elseif data.current.value == "tumbarse" then
			hacerAnim(id, "creatures@rottweiler@amb@sleep_in_kennel@", "sleep_in_kennel")
		elseif data.current.value == "tumbarsedos" then
			hacerAnim(id, "creatures@rottweiler@move", "dead_right")
		elseif data.current.value == "mear" then
			hacerAnim(id, "creatures@rottweiler@move", "pee_left_idle")
		elseif data.current.value == "meardos" then
			hacerAnim(id, "creatures@rottweiler@move", "pee_right_idle")
		elseif data.current.value == "agpata" then
			hacerAnim(id, "creatures@rottweiler@tricks@", "paw_right_loop")
		elseif data.current.value == "revcar" then
			hacerAnim(id, "creatures@rottweiler@tricks@", "petting_chop")
		elseif data.current.value == "laten" then
			hacerAnim(id, "creatures@rottweiler@indication@", "indicate_high")
		elseif data.current.value == "ith" then
			hacerAnim(id, "creatures@rottweiler@amb@world_dog_sitting@idle_a", "idle_a")
		elseif data.current.value == "beg" then
			hacerAnim(id, "creatures@rottweiler@tricks@", "beg_loop")
		elseif data.current.value == "cagar" then
			hacerAnim(id, "creatures@rottweiler@move", "dump_loop")
		end
	end, function(data, menu)
		menu.close();
	end)
end

function hacerAnim(source, dic, anima)
	local ad = dic
	local anim = anima
	local player = source
	
  
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
	  loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end
  
function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end