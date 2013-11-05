-- TO DO:
-- Make code make sense (actually comment some stuff)

 ------------------------------------------------
-- vv Don't mess with any of thi	    vv --
 ------------------------------------------------

local delay = 2
local playerName = UnitName("player")
local starttimer = 0					-- This is the thing that does the thing that does the thing
local timer = 0							-- This is the other thing that tracks the time so we can do stuff
local numItems = 0						-- This thing that stores how many things we have in the thing
local curLine = 1						-- This thing counts how many things we've sung
local temptable = {} 					-- This thing is a table and enjoys long walks on the beach
local tempinfotable = {} 				-- This thing is another table and enjoys short walks by the pond
local Telephone = CreateFrame("FRAME")	-- This thing is a frame and shit
local currentsong = "none"				-- This thing is the current song we're listening to and things
-- Some globals for use elsewhere...
TelephoneVersionNumber = GetAddOnMetadata("_TelephoneADV", "Version")
TelephoneAuthor = GetAddOnMetadata("_TelephoneADV", "Author")
TelephoneLastUpdate = GetAddOnMetadata("_TelephoneADV", "X-Date")

print("Hey, |cffffff77" .. playerName .. "|r, I told you stop stop calling me! (version: |cffffff77" .. TelephoneVersionNumber .. "|r (|cffffff77" .. TelephoneLastUpdate .. "|r))");

-- Telephone_Categories ----------------
function Telephone_Categories(rest)
local songcat = ""
local songname = ""
local songdesc = ""
local found = false
local allcats = ""
	if rest ~= "" then
		for i,v in pairs(TelephoneInfo) do
			songcat = TelephoneInfo[i]["Category"]
			songname = TelephoneInfo[i]["Name"]
			songdesc = TelephoneInfo[i]["Description"]

			if songcat == rest then -- If they entered an existing category tell them songs in it
				if found == false then
					print("Items found within category \"|cffffff77"..songcat.."|r\":")
				end
				found = true
				print("-    \"|cffffff77" .. songname .. "|r\" - "..songdesc)
			end
		end
		if found == false then
			print("Did not find the \"|cffffff77" .. rest .. "|r\" category, listing all categories...")
			for i,v in pairs(TelephoneInfo) do
				songcat = TelephoneInfo[i]["Category"]
					if not strmatch(allcats, songcat) then
						print("-    \"|cffffff77" .. songcat .. "|r\"")
					end
				allcats = allcats .. " " .. songcat
			end
		end
	else
		print("Listing all categories:")				
		for i,v in pairs(TelephoneInfo) do
		songcat = TelephoneInfo[i]["Category"]
			if not strmatch(allcats, songcat) then
				print("-    \"|cffffff77" .. songcat .. "|r\"")
			end
			allcats = allcats .. " " .. songcat
		end
	end
end

-- Telephone_Stop ----------------------
function Telephone_Stop(msg)
	if starttimer == 1 then
		starttimer = 0
		curLine = 1
		print("Stopping \"|cffffff77" .. currentsong .. "|r\".")
	else
		print("No song is playing.")
	end
end

-- Telephone_Sing ----------------------
function Telephone_Sing(msg)
	if starttimer == 1 then
		curLine = 1
		starttimer = 0
		print("Stopping \"|cffffff77" .. currentsong .. "|r\", changing to: \"|cffffff77" .. msg .. "|r\".")
	end
	temptable = TelephoneSongs[msg]
	tempinfotable = TelephoneInfo[msg]
	numItems = #temptable
	currentsong = tempinfotable["Name"]
	delay = tempinfotable["Delay"]
	print("Playing: \"|cffffff77" .. currentsong .. "|r\". With " .. numItems .. " lines, it will take roughly " .. numItems * delay .. " seconds to finish.")
	starttimer = 1
end

-- Telephone_List ----------------------
function Telephone_List(msg)
	print("Current list of songs:")
	local n = 1
	for i,v in pairs(TelephoneInfo) do
		numItems = #TelephoneSongs[i]
		tempinfotable = TelephoneInfo[i]
		delay = tempinfotable["Delay"]
		print(n .. ". |cffffff77" .. tempinfotable["Name"] .. "|r - " .. tempinfotable["Description"] .. " (" .. numItems .. " lines, " .. numItems * delay .. " secs)")
		n = n + 1
	end
end

-- Telephone_Help ----------------------
function Telephone_Help()
	print("Hello there, welcome to |cffffff77Telephone v" .. TelephoneVersionNumber .. "|r!");
	print("\"|cffffff77/te <songname>|r\" (without the '<>') to sing a song!");
	print("\"|cffffff77/te list|r\" to see all current songs");
	print("\"|cffffff77/te cat|r\" to see all current categories");
	print("You can also search for a song by typing \"|cffffff77/te <searchterm>|r\", where <searchterm> is what you want to search for.")
end

-- Telephone_Search ----------------------
function Telephone_Search(msg)
	local found = ""
	local foundnum = 0
	local ifoundit = ""

	for i,v in pairs(TelephoneSongs) do
		if strmatch(i, msg) then
			found = found .. i .. ","
			foundnum = foundnum + 1
			ifoundit = i
		end
	end
	found = strtrim(found, ",")
	if foundnum == 1 then
		temptable = TelephoneSongs[ifoundit]
		tempinfotable = TelephoneInfo[ifoundit]
		numItems = #temptable
		currentsong = tempinfotable["Name"]
		delay = tempinfotable["Delay"]

		print("Found only one song containing \"|cffffff77" .. msg .. "|r\" so starting to play \"|cffffff77" .. tempinfotable["Name"] .. "|r\" (\"/te stop\" to stop)")
		starttimer = 1
		curLine = 1
	elseif foundnum > 1 then
		print("Telephone found multiple entries containing the string |cffffff77" .. msg .. "|r:")
		local tbl = { strsplit(",",found,foundnum) }
		local songname = ""
		local songdesc = ""
		local n = 1
		for i,v in pairs(tbl) do
			tempinfotable = TelephoneInfo[v]
			songname = tempinfotable["Name"]
			songdesc = tempinfotable["Description"]
			print(n..". |cffffff77"..songname.."|r - "..songdesc)
			n=n+1
		end
	--------------------------------------------------------------------
	-- DID NOT FIND A SONG TITLE, SEARCHING THROUGH SONG DESCRIPTIONS --
	--------------------------------------------------------------------
	elseif foundnum == 0 then
			for i,v in pairs(TelephoneInfo) do
			songdesc = strlower(TelephoneInfo[i]["Description"])
				if strmatch(songdesc, msg) then
					found = found .. i .. ","
					foundnum = foundnum + 1
					ifoundit = i
				end
			end
				found = strtrim(found, ",")
			if foundnum == 1 then
			temptable = TelephoneSongs[ifoundit]
			tempinfotable = TelephoneInfo[ifoundit]
			numItems = #temptable
			currentsong = tempinfotable["Name"]
			delay = tempinfotable["Delay"]

			print("Found only one song description containing \"|cffffff77" .. msg .. "|r\" so starting to play \"|cffffff77" .. tempinfotable["Name"] .. "|r\" (\"/te stop\" to stop)")
			starttimer = 1
			curLine = 1

			elseif foundnum > 0 then
				print("Did not find a title containing \"|cffffff77" .. msg .. "|r\", searching through decriptions...")
				local tbl = { strsplit(",",found,foundnum) }
				local songname = ""
				local songdesc = ""
				local n = 1
				for i,v in pairs(tbl) do
					songname = TelephoneInfo[v]["Name"]
					songdesc = TelephoneInfo[v]["Description"]
					print(n..". |cffffff77"..songname.."|r - "..songdesc)
					n=n+1
				end

				elseif foundnum == 0 then
					print("Unrecognised command: \"|cffffff77" .. msg .. "|r\"")
					print("Accepted commands: \"|cffffff77/te <songname>|r\", \"|cffffff77/te <searchterm>|r\" , \"|cffffff77/te list|r\", \"|cffffff77/te cat|r\" and \"|cffffff77/te help|r\"")
				end
	end
end

SLASH_TELEPHONE1, SLASH_TELEPHONE2 = '/te', '/telephone';
function SlashCmdList.TELEPHONE(msg, editbox)
	msg = strlower(msg)
	local command, rest = msg:match("^(%S*)%s*(.-)$");
	if (command == 'category' or command == 'cat') then
		Telephone_Categories(rest)
	elseif msg == 'stop' then 	
		Telephone_Stop(msg)
	elseif TelephoneSongs[msg] ~= nil and #TelephoneSongs[msg] > 0 then
		Telephone_Sing(msg)
	elseif msg == 'list' then
		Telephone_List(msg)
	elseif msg == 'help' then
		Telephone_Help()
	elseif strlen(msg) > 0 then
		Telephone_Search(msg)
	else
		InterfaceOptionsFrame_OpenToCategory(TelephoneIOP)
	end
end

Telephone:Show();
Telephone:SetScript("OnUpdate",
function (self, elapsed)
if starttimer == 1 then
	timer = timer + elapsed
	if (timer >= delay) then
		if curLine > numItems then 
			starttimer = 0
			curLine = 1
			print("|cffffff77"..currentsong.."|r finished playback.")
		else
			if GetNumRaidMembers() > 0 then
				SendChatMessage(temptable[curLine],"RAID")
			elseif GetNumPartyMembers() > 0 then
				SendChatMessage(temptable[curLine],"PARTY")
			else
				SendChatMessage(temptable[curLine],"SAY")
			end
			curLine = curLine + 1
			timer = 0
		end
	end
end
end
);
