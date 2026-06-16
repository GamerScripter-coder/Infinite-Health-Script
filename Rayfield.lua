local RayfieldModule = {}
local RM = RayfieldModule  
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local function CreateWindowAndReturn(NameWindow, WindowIcon, WLoadingTitle, WLoadingSubTitle)
	return Rayfield:CreateWindow({
		Name = NameWindow.."(CheaterHub)",
		Icon = WindowIcon,
		LoadingTitle = WLoadingTitle.."(CheaterHub)",
		LoadingSubtitle = WLoadingSubTitle.."(CheaterHub)",
		ConfigurationSaving = {
			Enabled = true,
			FolderName = nil,
			FileName = "CheaterHub"
		}
	})
end

local function CreateTabAndReturn(Window, Name, Img)
	return Window:CreateTab(Name.."(CheaterHub)", Img)
end

local function CreateButton(Tab, BtnName, Clickfunc)
	return Tab:CreateButton({
		Name = BtnName.."(CheaterHub)",
		Callback = function()
			Clickfunc()
		end
	})
end

local function CreateToggle(Tab, TogName, TogFlag, Changefunc)
	return Tab:CreateToggle({
		Name = TogName.."(CheaterHub)",
		CurrentValue = false,
		Flag = TogFlag,
		Callback = function(v)
			Changefunc(v)
		end
	})
end

local function CreateSlider(Tab, SlidName, SlidFlag, CurrentV, Inc, SlidRange, Changefunc)
	return Tab:CreateSlider({
		Name = SlidName.."(CheaterHub)",
		Range = SlidRange,
		Increment = Inc,
		CurrentValue = CurrentV,
		Flag = SlidFlag,
		Callback = function(v)
			Changefunc(v)
		end
	})
end

local function CreateInput(Tab, InpName, InpFlag, InpHolder, Changefunc)
	return Tab:CreateInput({
		Name = InpName.."(CheaterHub)",
		CurrentValue = "",
		PlaceholderText = InpHolder,
		RemoveTextAfterFocusLost = false,
		Flag = InpFlag,
		Callback = function(t)
			Changefunc(t)
		end
	})
end

local function CreateDropDown(Tab, Name, Options, Current, MulOp, F, func)
	return Tab:CreateDropdown({
		Name = Name,
        Options = Options,
        CurrentOption = Current,
        MultipleOptions = MulOp,
        Flag = F,
        Callback = function(Options)
			func(Options)
		end
	})
end

local function CreateLabel(Tab, Name, Icon)
   Tab:CreateLabel(Name.."(CheaterHub)", Icon, Color3.fromRGB(255,255,255), false)
end

function RM:CWAR(NameWindow, WindowIcon, WLoadingTitle, WLoadingSubTitle)
  return CreateWindowAndReturn(NameWindow, WindowIcon, WLoadingTitle, WLoadingSubTitle)
end

function RM:CTAR(Window, Name, Img)
  return CreateTabAndReturn(Window, Name, Img)
end

function RM:CB(Tab, BtnName, Clickfunc)
  CreateButton(Tab, BtnName, Clickfunc)
end

function RM:CT(Tab, TogName, TogFlag, Changefunc)
  CreateToggle(Tab, TogName, TogFlag, Changefunc)
end

function RM:CS(Tab, SlidName, SlidFlag, CurrentV, Inc, SlidRange, Changefunc)
  CreateSlider(Tab, SlidName, SlidFlag, CurrentV, Inc, SlidRange, Changefunc)
end

function RM:CI(Tab, InpName, InpFlag, InpHolder, Changefunc)
  CreateInput(Tab, InpName, InpFlag, InpHolder, Changefunc)
end

function RM:CDD(Tab, Name, Options, Current, MulOp, F, func)
	return CreateDropDown(Tab, Name, Options, Current, MulOp, F, func)
end

function RM:LoadConfig()
	Rayfield:LoadConfiguration()
end

function RM:GetInfo(modfunc)
	if modfunc == "CWAR" then
		print("Required For CWAR: NameWindow, WindowIcon, WLoadingTitle, WLoadingSubTitle")
	end
	if modfunc == "CTAR" then
		print("Required For CTAR: Window, Name, Img")
	end
	if modfunc == "CB" then
		print("Required For CB: Tab, BtnName, Clickfunc")
	end
	if modfunc == "CT" then
		print("Required For CT: Tab, TogName, TogFlag, Changefunc")
	end
	if modfunc == "CS" then
		print("Required For CS: Tab, SlidName, SlidFlag, CurrentV, Inc, SlidRange, Changefunc")
	end
	if modfunc == "CI" then
		print("Required For CI: Tab, InpName, InpFlag, InpHolder, Changefunc")
	end
	if modfunc == "CDD" then
		print("Required For CDD: Tab, Name, Options, Current, MulOp, F, func")
	end
end

return RM
