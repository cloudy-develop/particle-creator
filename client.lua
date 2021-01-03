Citizen.CreateThread(function()
	Citizen.Wait(1)

	for i,var0 in pairs(config.particles) do
		table.insert(var0, { data = { distance = nil, enable = nil, handle = nil } })
	end

	while (true) do
		
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		for i,var0 in pairs(config.particles) do

			var0[1].data.distance = GetDistanceBetweenCoords(playerCoords, var0.coords.x, var0.coords.y, var0.coords.z, true)
			
			if (var0[1].data.distance < 800.0) then
				if not (var0[1].data.enable) then

					RequestNamedPtfxAsset(var0.dict)
					while not HasNamedPtfxAssetLoaded(var0.dict) do
						Citizen.Wait(1)
					end

					UseParticleFxAssetNextCall(var0.dict)

					var0[1].data.handle = StartParticleFxLoopedAtCoord(var0.name, var0.coords.x, var0.coords.y, var0.coords.z, 0.0, 0.0, 0.0, var0.scale, false, false, false, 0)
					var0[1].data.enable = true

				end
			else
				if (var0[1].data.enable) then

					StopParticleFxLooped(var0[1].data.handle, false)

					var0[1].data.handle = nil
					var0[1].data.enable = false

				end
			end

		end

		Citizen.Wait(500)
	end
end)