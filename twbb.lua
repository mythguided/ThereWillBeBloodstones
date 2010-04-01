ThereWillBeBloodstones = CreateFrame("frame")

ThereWillBeBloodstones.value = {}
local value = ThereWillBeBloodstones.value
value[36912] = {} -- Saronite Ore
value[36912].kind="ore"
value[36912].results = {
			[36918] = .04,
			[36924] = .04,
			[36921] = .04,
			[36933] = .04,
			[36927] = .04,
			[36930] = .04,
			[36917] = .275,
			[36923] = .275,
			[36920] = .275,
			[36932] = .275,
			[36926] = .275,
			[36929] = .275,
			[36919] = 0,
			[36925] = 0,
			[36922] = 0,
			[36934] = 0,
			[36928] = 0,
			[36931] = 0,
			[46849] = 0
		}
value[36918] = {} -- BR, or Scarlet Ruby
value[36918].kind="gem"
value[36924] = {} -- BB, or Sky Sapphire
value[36924].kind="gem"
value[36921] = { } -- BY, or Autumn's Glow
value[36921].kind="gem"
value[36933]= { } -- BG, or Forest Emerald
value[36933].kind="gem"
value[36927]= {  } -- BP, or Twilight Opal
value[36930] = { } -- BO, or Monarch Topaz
value[36917]= {  } -- GR, or Bloodstone
value[36923] = {  } -- GB, or Chalcedony
value[36920]= {  } -- GY, or Sun Crystal
value[36932]= {  } -- GG, or Dark Jade
value[36926] = {  } -- GP, or Shadow Crystal
value[36929] = {  } -- GO, or Huge Citrine
value[36910] = { }  -- Titanium Ore
value[36927].kind="gem"
value[36930].kind="gem"
value[36917].kind="gem"
value[36923].kind="gem"
value[36920].kind="gem"
value[36932].kind="gem"
value[36926].kind="gem"
value[36929].kind="gem"
value[36910].kind="ore"
value[36910].results ={
			[36918] = .04,
			[36924] = .04,
			[36921] = .04,
			[36933] = .04,
			[36927] = .04,
			[36930] = .04,
			[36917] = .25,
			[36923] = .25,
			[36920] = .25,
			[36932] = .25,
			[36926] = .25,
			[36929] = .25,
			[36919] = .04,
			[36925] = .04,
			[36922] = .04,
			[36934] = .04,
			[36928] = .04,
			[36931] = .04,
			[46849] = .75
		}
value[36909] = {} -- Cobalt Ore
value[36909].kind="ore"
value[36909].results = {
			[36918] = .011,
			[36924] = .011,
			[36921] = .011,
			[36933] = .011,
			[36927] = .011,
			[36930] = .011,
			[36917] = .375,
			[36923] = .375,
			[36920] = .375,
			[36932] = .375,
			[36926] = .375,
			[36929] = .375,
			[36919] = 0,
			[36925] = 0,
			[36922] = 0,
			[36934] = 0,
			[36928] = 0,
			[36931] = 0,
			[46849] = 0
		}
value[36919] = {} -- PR, or Cardinal Ruby
value[36925] = {} -- PB, or Majestic Zircon
value[36922] = {} -- PY, or King's Amber
value[36934] = {} -- PG, or Eye of Zul
value[36928] = {} -- PP, or Dreadstone
value[36931] = {} -- PO, or Ametrine
value[36919].kind="gem"
value[36925].kind="gem"
value[36922].kind="gem"
value[36934].kind="gem"
value[36928].kind="gem"
value[36931].kind="gem"
value[46849] = {} -- Titanium Powder
value[46849].kind="currency"

local TWBBdb,debug={},true
TWBBevil = value


ThereWillBeBloodstones:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
ThereWillBeBloodstones:RegisterEvent("ADDON_LOADED")
function ThereWillBeBloodstones:Print(...) ChatFrame1:AddMessage(string.join(" ", "|cFF33FF99There Will Be Bloodstones!|r:", ...)) end

function ThereWillBeBloodstones:SetUpIndexFunction()
	for i,v in pairs(value) do
		if v.kind=="ore" then
			local mymetatbl = {
				__index = function(tbl,key)
							if key=="raw" then return GetAuctionBuyout(i) end
							if key=="expected" then
								local worth=0
								for itemcode,prob in pairs(v.results) do
									worth = worth + prob*GetAuctionBuyout(itemcode)
								end
								return worth/5
							end
						end
			}
			setmetatable(v, mymetatbl)
		else
			local mymetatbl = {
			__index = function(tbl,key) if key=="raw" then return GetAuctionBuyout(i) end end
			}
			setmetatable(v,mymetatbl)
		end
	end
end

--~ function ThereWillBeBloodstones:SetUpExpectedValues()
--~ 	for i,v in pairs(value) do
--~ 		if v.kind=="ore" then
--~ 			local oldmetatbl = getmetatable(v)
--~ 			local oldidx = oldmetatbl.__index
--~ 			local mymetatbl = {
--~ 				__index = function(tbl,key)
--~ 							if key=="expected" then
--~ 								local worth = 0
--~ 								for itemcode,prob in pairs(v.results) do
--~ 									worth = worth + prob*value[itemcode].raw
--~ 								end
--~ 								return worth/5
--~ 							else
--~ 								if oldidx then return oldidx(tbl,key) end
--~ 							end
--~ 						end
--~ 					}
--~ 			setmetatable(v,mymetatbl)
--~ 		end

--~ 	end
--~ end

function ThereWillBeBloodstones:ADDON_LOADED(event, addon)
	if addon:lower() ~= "therewillbebloodstones" then return end

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	if IsLoggedIn() then self:PLAYER_LOGIN() else self:RegisterEvent("PLAYER_LOGIN") end
end

--~ function ThereWillBeBloodstones:CalculateGemValues()
--~ 	value.br, value.bb, value.by, value.bg, value.bp, value.bo, value.gr, value.gb, value.gy, value.gg, value.gp, value.go = GetAuctionBuyout(36918), GetAuctionBuyout(36924),GetAuctionBuyout(36921),GetAuctionBuyout(36933),GetAuctionBuyout(36927),GetAuctionBuyout(36930),GetAuctionBuyout(36917),GetAuctionBuyout(36923),GetAuctionBuyout(36920),GetAuctionBuyout(36932),GetAuctionBuyout(36926),GetAuctionBuyout(36929)
--~ 	if debug then
--~ 		local link
--~ 		_,link = GetItemInfo(36918)
--~ 		self:Print("Value of a " .. link .. " is " .. value.br/10000 .. "g")
--~ 		_,link = GetItemInfo(36924)
--~ 		self:Print("Value of a " .. link .. " is " .. value.bb/10000 .. "g")
--~ 	end
--~ end

--~ function ThereWillBeBloodstones:CalculateSaroniteValues()
--~ 	self:CalculateGemValues()
--~ 	value.S = GetAuctionBuyout(36912)
--~  local  S,G,B,br,bb,by,bg,bp,bo,gr,gb,gy,gg,gp,go = GetAuctionBuyout(36912),.24,.18*6,GetAuctionBuyout(36918),GetAuctionBuyout(36924),GetAuctionBuyout(36921),GetAuctionBuyout(36933),GetAuctionBuyout(36927),GetAuctionBuyout(36930),GetAuctionBuyout(36917),GetAuctionBuyout(36923),GetAuctionBuyout(36920),GetAuctionBuyout(36932),GetAuctionBuyout(36926),GetAuctionBuyout(36929); WG,WB=G*(gr+gb+gy+gg+gp+go)/6,B*(br+bb+by+bg+bp+bo)/6;local _,Slink = GetItemInfo(36912);ChatFrame1:AddMessage("Expected value of auctioning 5x"..Slink.." is ".. (5*S/10000).."g");ChatFrame1:AddMessage("Expected value of auctioning the gems from prospecting 5x"..Slink.." is " .. ((WG+WB)/10000) .. "g")
--~ end

--~ function ThereWillBeBloodstones:CalculateTitaniumValues()
--~ end

--~ function ThereWillBeBloodstones:CalculateCobaltValues()
--~ end

function ThereWillBeBloodstones:PrintExpectedValue(itemcode)
--~  local  S,G,B,br,bb,by,bg,bp,bo,gr,gb,gy,gg,gp,go = GetAuctionBuyout(36912),.24,.18*6,GetAuctionBuyout(36918),GetAuctionBuyout(36924),GetAuctionBuyout(36921),GetAuctionBuyout(36933),GetAuctionBuyout(36927),GetAuctionBuyout(36930),GetAuctionBuyout(36917),GetAuctionBuyout(36923),GetAuctionBuyout(36920),GetAuctionBuyout(36932),GetAuctionBuyout(36926),GetAuctionBuyout(36929); WG,WB=G*(gr+gb+gy+gg+gp+go)/6,B*(br+bb+by+bg+bp+bo)/6;local _,Slink = GetItemInfo(36912);ChatFrame1:AddMessage("Expected value of auctioning 5x"..Slink.." is ".. (5*S/10000).."g");ChatFrame1:AddMessage("Expected value of auctioning the gems from prospecting 5x"..Slink.." is " .. ((WG+WB)/10000) .. "g")
	local _, link = GetItemInfo(itemcode)
	if not self.value[itemcode] or self.value[itemcode].kind~="ore" then
		self:Print("Expected value of auctioning " .. link .. " is " ..
			((self.value[itemcode] and self.value[itemcode].raw) or
				GetAuctionBuyout(itemcode))/10000 .. "g")
	else
		self:Print("Expected value of auctioning " .. link .. " is " ..
				self.value[itemcode].raw/10000 ..
				"g\n    Expected value of auctioning the gems from prospecting a given "
				.. link .. " is " .. self.value[itemcode].expected/10000 .. "g")
	end
end


function ThereWillBeBloodstones:ChatOutput()
	for i,v in pairs(value) do
		if v.kind=="ore" then
			self:PrintExpectedValue(i)
		end
	end
end

function ThereWillBeBloodstones:SlashCmdParser(msg,editbox)
	-- if msg=="help" then
	if not GetAuctionBuyout then
		self:Print("This addon requires an auction history addon that provides support for the GetAuctionBuyout API.")
		self:Print("Examples of such addons include AuctionLite, Auctionator, & NutCounter.")
		self:Print("Please consider using one of these addons if you wish to make use of There Will Be Bloodstones!")
		return
	end
	if msg ==""  or msg == "all"then
		self:ChatOutput()
		return
	end
	if msg == "help" or not self:ItemSearch(msg) then
		self:Print("/twbb or /twbb all: Prints the auction house values of all known ores, & expected values of prospecting all known ores.")
		self:Print("/twbb <itemID> or /twbb <itemName> or /twbb <itemLink>: Prints the auction house value of the item, & the expected value of prospecting it if it's a known ore.")
	end
end

function ThereWillBeBloodstones:ItemSearch(msg)

	-- if it's just a number, try it as an itemID
	if (tonumber(msg)) then
		self:PrintExpectedValue(tonumber(msg))
		return true;
	end

	-- otherwise, assume it's either a name or an item link
	local _, link = GetItemInfo(msg)
	if not link then return false end
	local _, _, itemid = string.find(link, "Hitem:(%d+):");
	if itemid  and tonumber(itemid) then
		self:PrintExpectedValue(tonumber(itemid))
		return true
	end

	-- if we're here, that's bad.
	return false
end

function ThereWillBeBloodstones:PLAYER_LOGIN()
	if not GetAuctionBuyout then
		self:Print("This addon requires an auction history addon that provides support for the GetAuctionBuyout API.")
		self:Print("Examples of such addons include AuctionLite, Auctionator, & NutCounter.")
		self:Print("Please consider using one of these addons if you wish to make use of There Will Be Bloodstones!")
		return
	end
	self:SetUpIndexFunction()
	self:ChatOutput()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

SLASH_TWBB1 = "/twbb"
SlashCmdList["TWBB"] = function (msg,editbox)
	ThereWillBeBloodstones:SlashCmdParser(msg,editbox)
end
