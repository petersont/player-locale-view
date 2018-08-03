local Roact = require(script.Parent.Parent.Parent.Roact)

local Dropdown = require(script.Parent.Dropdown)
local LocaleSelector = Roact.Component:extend("LocaleSelector")

local localeInfos = {
	{ localeId = "en-us", name = "English (USA)" },
	{ localeId = "es-es", name = "Spanish (Spain)" },
	{ localeId = "fr-fr", name = "French (France)" },
	{ localeId = "it-it", name = "Italian (Italy)" },
	{ localeId = "pt-br", name = "Portuguese (Brazil)" },
	{ localeId = "de-de", name = "German (Germany)" },
	{ localeId = "ru-ru", name = "Russian (Russia)" },
	{ localeId = "zh-cn", name = "Chinese (China)" },
	{ localeId = "zh-tw", name = "Chinese (Taiwan)" },
	{ localeId = "ja-jp", name = "Japanese (Japan)" },
	{ localeId = "ko-kr", name = "Korean (South Korea)" },
}

local localeNameMap = {}

for i = 1, #localeInfos do
	local info = localeInfos[i]
	localeNameMap[info.localeId] = info.name
end

function LocaleSelector:init()
	self.state = {
		localeId = self.props.InitialLocaleId
	}

	self.textBoxRef = Roact.createRef()
end

local function getMenuTextForLocale(localeId)
	if localeId == "" then
		return "(default)"
	end
	return localeNameMap[localeId] or "(custom)"
end

function LocaleSelector:render()
	local function makeLocaleSetter(localeId)
		return function()
			self:setState({
				localeId = localeId
			})
		end
	end

	local ListItems = {}

	for index, item in pairs(localeInfos) do
		ListItems[index] = {
			Text = item.name,
			OnActivated = makeLocaleSetter(item.localeId),
		}
	end

	return Roact.createElement("Frame", {
		Size = self.props.Size,
		BackgroundTransparency = 1.0,
	}, {
		Layout = Roact.createElement("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0,5)
		}),

		LocaleNameDropdown = Roact.createElement("Frame", {
			Size = UDim2.new(0, 160, 0, 25),
			LayoutOrder = 0
		}, {
			Dropdown = Roact.createElement(Dropdown, {
				CurrentText = getMenuTextForLocale(self.state.localeId),
				ListItemHeight = 25,
				ListItems = ListItems
			}),
		}),

		LocaleIdTextBox = Roact.createElement("Frame", {
			Size = UDim2.new(0, 50, 0, 25),
			BorderSizePixel = 1,
			BackgroundColor3 = Color3.new(1, 1, 1),
			LayoutOrder = 1,
		}, {
			Padding = Roact.createElement("UIPadding", {
				PaddingLeft = UDim.new(0, 4)
			}),

			TextboxInternal = Roact.createElement("TextBox", {
				Size = UDim2.new(1, 0, 1, 0),
				Text = self.state.localeId,
				TextXAlignment = "Left",
				BackgroundTransparency = 1,

				[Roact.Ref] = self.textBoxRef,

				[Roact.Event.FocusLost] = function()
					self:setState({localeId = self.textBoxRef.current.Text})
				end
			})
		}),
	})
end

function LocaleSelector:didUpdate()
	self.props.SetLocaleId(self.state.localeId)
end

return LocaleSelector
