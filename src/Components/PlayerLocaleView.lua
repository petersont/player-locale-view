local Roact = require(script.Parent.Parent.Parent.Roact)

local LabeledLocaleSelector = require(script.Parent.LabeledLocaleSelector)

local PlayerLocaleView = Roact.Component:extend("PlayerLocaleView")

function PlayerLocaleView:init()
end

function PlayerLocaleView:render()
	return Roact.createElement("Frame", {
			Size = UDim2.new(0, 300, 0, 70),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}, {
			Layout = Roact.createElement("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 5)
			}),

			Padding = Roact.createElement("UIPadding", {
				PaddingTop = UDim.new(0, 10)
			}),

			Roblox = Roact.createElement(LabeledLocaleSelector, {
				Window = self.props.Window,
				LabelText = "Roblox",
				InitialLocaleId = self.props.InitialRobloxLocaleId,
				SetLocaleId = self.props.SetRobloxLocaleId,
				LayoutOrder = 0
			}),

			Game = Roact.createElement(LabeledLocaleSelector, {
				Window = self.props.Window,
				LabelText = "Game",
				InitialLocaleId = self.props.InitialGameLocaleId,
				SetLocaleId = self.props.SetGameLocaleId,
				LayoutOrder = 1
			}),
		}
	)
end

return PlayerLocaleView
