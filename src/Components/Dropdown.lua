local Roact = require(script.Parent.Parent.Parent.Roact)

local Dropdown = Roact.Component:extend("Dropdown")

function Dropdown:init()
	self.state = {
		open = false
	}
end

function Dropdown:render()
	local listChildren = {
		Layout = Roact.createElement("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	}

	for index, listItem in pairs(self.props.ListItems) do
		listChildren["ListObject"..index] = Roact.createElement("Frame", {
			Size = UDim2.new(1, 0, 0, self.props.ListItemHeight),
			LayoutOrder = index,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(1, 1, 1),
			ZIndex = 2,
		}, {
			Padding = Roact.createElement("UIPadding", {
				PaddingBottom = UDim.new(0, 4),
			}),

			Button = Roact.createElement("TextButton", {
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				Text = "",
				BackgroundColor3 = Color3.new(1, 1, 1),
				ZIndex = 2,

				[Roact.Event.Activated] = function()
					listItem.OnActivated()
					self:setState( {open = false} )
					self.props.OnClosed()
				end,
			}, {
				Padding = Roact.createElement("UIPadding", {
					PaddingLeft = UDim.new(0, 4)
				}),

				Text = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Text = listItem.Text,
					ZIndex = 2,
					TextXAlignment = Enum.TextXAlignment.Left,
				})
			}),
		})
	end

	local menu
	local button

	if self.state.open then
		menu = Roact.createElement("Frame", {
			Size = UDim2.new(1, 0, 0, self.props.ListItemHeight * self.props.ListSize),
			BorderColor3 = Color3.new(0, 0, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			ZIndex = 2,
		}, listChildren)
	else
		button = Roact.createElement("TextButton", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = self.props.CurrentText,

			[Roact.Event.Activated] = function()
				self:setState( {open = true} )
			end,
		})
	end

	return Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.new(1, 1, 1)
	}, {
		button = button,
		menu = menu,
	})
end

return Dropdown
