TelephoneIOP = CreateFrame("Frame")
TelephoneIOP.name = "Telephone";
InterfaceOptions_AddCategory(TelephoneIOP);

---------------------------------------------------------------
-------------------------- MAIN MENU --------------------------
---------------------------------------------------------------
-- Header at the top of the 'Telephone' category
local MainHeader = TelephoneIOP:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	MainHeader:SetParent(TelephoneIOP)
	MainHeader:SetPoint("TOPLEFT", TelephoneIOP, "TOPLEFT", 10, -10)
	MainHeader:SetText("Telephone Help")

-- Main body of text - help information
local MainText = TelephoneIOP:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	MainText:SetParent(TelephoneIOP)
	MainText:SetPoint("TOPLEFT", TelephoneIOP, "TOPLEFT", 10, -40)
	MainText:SetJustifyH("LEFT")

-- Split 'text' over multiple lines to make it easier to edit here
	local text = "Telephone Slash Commands (/te or /telephone)"
	text = text .. "|n|cffffff77help|r|cffffffff: prints help text to the chat frame|r"
	text = text .. "|n|cffffff77list|r|cffffffff: prints a list of songs to the chat frame|r"
	text = text .. "|n|cffffff77<songname>|r|cffffffff: starts singing a song!|r"
	text = text .. "|n|cffffff77category (or cat)|r|cffffffff: prints a list of categories to the chat frame|r"
	text = text .. "|n        |cffffffff If a category is specified (eg. /te cat songs) then it will|n         print a list of songs in that category|r"
	text = text .. "|n|cffffff77<searchterm>|r|cffffffff: searches for a song containing the term you|nspecify|r"

	MainText:SetText("|cffffffff" .. text .. "|r")

local AboutText = TelephoneIOP:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	AboutText:SetParent(TelephoneIOP)
	AboutText:SetPoint("TOPLEFT", TelephoneIOP, "BOTTOMLEFT", 10, 25)
	AboutText:SetJustifyH("LEFT")
	AboutText:SetText("Author: " .. TelephoneAuthor)
	
local AboutText2 = TelephoneIOP:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	AboutText2:SetParent(TelephoneIOP)
	AboutText2:SetPoint("TOPRIGHT", TelephoneIOP, "BOTTOMRIGHT", -10, 25)
	AboutText2:SetJustifyH("RIGHT")
	AboutText2:SetText("Version: " .. TelephoneVersionNumber .. " ("..TelephoneLastUpdate..")")
	
---------------------------------------------------------------
---------------------- 'CREATE' SUB MENU ----------------------
---------------------------------------------------------------
local CreateSubMenu = CreateFrame("Frame")
	CreateSubMenu.name = "Create"
	CreateSubMenu.parent = "Telephone"
	InterfaceOptions_AddCategory(CreateSubMenu);

local CreateHeader = CreateSubMenu:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	CreateHeader:SetParent(CreateSubMenu)
	CreateHeader:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 10, -10)
	CreateHeader:SetText("Create A New Song")

-- Enter a name...
-- Top left
local EANameText = CreateSubMenu:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	EANameText:SetParent(CreateSubMenu)
	EANameText:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 10, -40)
	EANameText:SetJustifyH("LEFT")
	EANameText:SetText("|cffffffffEnter a name:|r")

local EANameEditBox = CreateFrame("EditBox", "EnterAName", CreateSubMenu, "InputBoxTemplate")
	EANameEditBox:SetFont("Fonts\\FRIZQT__.TTF", 11)
	EANameEditBox:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 15, -55)
	EANameEditBox:SetWidth(150)
	EANameEditBox:SetHeight(15)
    EANameEditBox:SetAutoFocus(false)

-- Enter a category...
-- Bottom left
local EACategoryText = CreateSubMenu:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	EACategoryText:SetParent(CreateSubMenu)
	EACategoryText:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 10, -80)
	EACategoryText:SetJustifyH("LEFT")
	EACategoryText:SetText("|cffffffffEnter a category:|r")

local EACategory = CreateFrame("EditBox", "EnterACategory", CreateSubMenu, "InputBoxTemplate")
	EACategory:SetFont("Fonts\\FRIZQT__.TTF", 11)
	EACategory:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 15, -95)
	EACategory:SetWidth(150)
	EACategory:SetHeight(15)
    EACategory:SetAutoFocus(false)
	
-- Enter a description...
-- Top right
local EADescriptionText = CreateSubMenu:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	EADescriptionText:SetParent(CreateSubMenu)
	EADescriptionText:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 200, -40)
	EADescriptionText:SetJustifyH("LEFT")
	EADescriptionText:SetText("|cffffffffEnter a description:|r")

local EADescriptionEditBox = CreateFrame("EditBox", "EnterADescription", CreateSubMenu, "InputBoxTemplate")
	EADescriptionEditBox:SetFont("Fonts\\FRIZQT__.TTF", 11)
	EADescriptionEditBox:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 205, -55)
	EADescriptionEditBox:SetWidth(150)
	EADescriptionEditBox:SetHeight(15)
    EADescriptionEditBox:SetAutoFocus(false)

-- Enter a delay...
-- Bottom right
local EADelayText = CreateSubMenu:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	EADelayText:SetParent(CreateSubMenu)
	EADelayText:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 200, -80)
	EADelayText:SetJustifyH("LEFT")
	EADelayText:SetText("|cffffffffEnter a delay:|r")

local EADelayEditBox = CreateFrame("EditBox", "EnterADelay", CreateSubMenu, "InputBoxTemplate")
	EADelayEditBox:SetFont("Fonts\\FRIZQT__.TTF", 11)
	EADelayEditBox:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 205, -95)
	EADelayEditBox:SetWidth(150)
	EADelayEditBox:SetHeight(15)
    EADelayEditBox:SetAutoFocus(false)

-- Help Text
local HelpText = CreateSubMenu:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	HelpText:SetParent(CreateSubMenu)
	HelpText:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 10, -120)
	HelpText:SetJustifyH("LEFT")
	HelpText:SetText("|cffffffffEnter the lyrics here. They should be in the format:|n[1] = \"This is the first line\",|n[2] = \"This is the second line\",|r")
local HelpText2 = CreateSubMenu:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	HelpText2:SetParent(CreateSubMenu)
	HelpText2:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 10, -155)
	HelpText2:SetJustifyH("LEFT")
	HelpText2:SetText("|cffffffffFor more detailed information look at the page where you downloaded|nthe addon, or read \"Lyrics.lua\" in the _TelephoneADV folder.|r")

-- Song Creation!
local MainEditBox = CreateFrame("EditBox", "MainEditBox", CreateSubMenu)
	MainEditBox:SetFont("Fonts\\FRIZQT__.TTF", 12)
	MainEditBox:SetPoint("TOPLEFT", CreateSubMenu, "TOPLEFT", 10, -190)
	MainEditBox:SetPoint("BOTTOMLEFT", CreateSubMenu, "BOTTOMLEFT", 10, 35)
	MainEditBox:SetWidth(390)
	MainEditBox:SetHeight(380)
	MainEditBox:SetMultiLine(true)
    MainEditBox:SetAutoFocus(false)
	MainEditBox:SetTextColor(1,1,1)
	MainEditBox:SetTextInsets(8,8,8,8)
	MainEditBox:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	MainEditBox:SetBackdropColor(.1,.1,.1,.5)
	MainEditBox:SetBackdropBorderColor(.5,.5,.5)
	MainEditBox:SetScript("OnEditFocusLost", focuslost)
	MainEditBox:SetScript("OnEscapePressed", MainEditBox.ClearFocus)
	
local ClearButton = CreateFrame("Button", nil, CreateSubMenu)
	ClearButton:SetWidth(100)
	ClearButton:SetHeight(20)
	ClearButton:SetPoint("LEFT", CreateSubMenu, "BOTTOMLEFT", 10, 20)
	ClearButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up.blp")
	ClearButton:GetNormalTexture():SetTexCoord(0,.64,0,.64)
	ClearButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight.blp")
	ClearButton:GetHighlightTexture():SetTexCoord(0,.64,0,.64)
	ClearButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-Button-Down.blp")
	ClearButton:GetPushedTexture():SetTexCoord(0,.64,0,.64)
	ClearButton:SetNormalFontObject("GameFontHighlight")
	ClearButton:SetText("Clear")
	local function ClearCreateBoxes()
		EANameEditBox:SetText("")
		EACategory:SetText("")
		EADescriptionEditBox:SetText("")
		EADelayEditBox:SetText("")
		MainEditBox:SetText("")
	end
	ClearButton:SetScript("OnClick", ClearCreateBoxes)
	
local SaveButton = CreateFrame("Button", nil, CreateSubMenu)
	SaveButton:SetWidth(100)
	SaveButton:SetHeight(20)
	SaveButton:SetPoint("RIGHT", CreateSubMenu, "BOTTOMRIGHT", -10, 20)
	SaveButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up.blp")
	SaveButton:GetNormalTexture():SetTexCoord(0,.64,0,.64)
	SaveButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight.blp")
	SaveButton:GetHighlightTexture():SetTexCoord(0,.64,0,.64)
	SaveButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-Button-Down.blp")
	SaveButton:GetPushedTexture():SetTexCoord(0,.64,0,.64)
	SaveButton:SetNormalFontObject("GameFontHighlight")
	SaveButton:SetText("Save")
	

---------------------------------------------------------------
----------------------- 'EDIT' SUB MENU -----------------------
---------------------------------------------------------------
local EditSubMenu = CreateFrame("Frame")
	EditSubMenu.name = "Edit"
	EditSubMenu.parent = "Telephone"
	InterfaceOptions_AddCategory(EditSubMenu);
	
local EditHeader = EditSubMenu:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	EditHeader:SetParent(EditSubMenu)
	EditHeader:SetPoint("TOPLEFT", EditSubMenu, "TOPLEFT", 10, -10)
	EditHeader:SetText("Edit An Existing Song")