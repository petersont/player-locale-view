local Roact = require(script.Parent.Parent.Parent.Roact)
local Modalifier = require(script.Parent.Modalifier)

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
			ZIndex = 3,
		}, {
			Padding = Roact.createElement("UIPadding", {
				PaddingBottom = UDim.new(0, 4),
			}),

			Button = Roact.createElement("TextButton", {
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				Text = "",
				BackgroundColor3 = Color3.new(1, 1, 1),
				ZIndex = 3,

				[Roact.Event.Activated] = function()
					listItem.OnActivated()
					self:setState({
						open = false
					})
				end,
			}, {
				Padding = Roact.createElement("UIPadding", {
					PaddingLeft = UDim.new(0, 4)
				}),

				Text = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Text = listItem.Text,
					ZIndex = 3,
					TextXAlignment = Enum.TextXAlignment.Left,
				})
			}),
		})
	end

	local visibleChildren

	if self.state.open then
		visibleChildren = {
			modalifier = Roact.createElement(Modalifier, {
				Window = self.props.Window,
				ZIndex = 2,
				OnClosed = function()
					self:setState({
						open = false
					})
				end,
				Render = function()
					return Roact.createElement("Frame", {
						Size = UDim2.new(1, 0, 0, #(self.props.ListItems) * self.props.ListItemHeight),
						BorderColor3 = Color3.new(0, 0, 0),
						BackgroundColor3 = Color3.new(1, 1, 1),
						ZIndex = 3,
					}, listChildren)
				end
			})
		}
	else
		visibleChildren = {
			button = Roact.createElement("TextButton", {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = self.props.CurrentText,

				[Roact.Event.Activated] = function()
					self:setState({
						open = true
					})
				end
			})
		}
	end

	return Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.new(1, 1, 1)
	}, visibleChildren)
end

return Dropdown
