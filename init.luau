local placeId: number = game.PlaceId
local templateCode: string = "https://raw.githubusercontent.com/Laelmano24/mini-script/refs/heads/main/scripts/"

loadstring(game:HttpGet(templateCode .. placeId .. ".luau"))()
