local Roact = require(script.Parent.Parent.Parent.Roact)

local Modalifier = Roact.Component:extend("Modalifier")

function Modalifier:init()
	self.state = {
		contentAbsolutePosition = Vector2.new(0, 0),
		showing = false,
	}
end

function Modalifier:render()
	local visibleChildren = {}
	if self.state.showing then
		visibleChildren = {
			content = self.props.Render(self.state.contentAbsolutePosition)
		}
	end

	return Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,

		[Roact.Change.AbsolutePosition] = function(instance)
			spawn( function()
				self:setState({
					contentAbsolutePosition = instance.AbsolutePosition,
					showing = true,
				})
			end)
		end,
	}, {
		Portal = Roact.createElement(Roact.Portal, {
			target = self.props.Window,
		}, {
			Curtain = Roact.createElement("TextButton", {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = "",
				ZIndex = self.props.ZIndex,

				[Roact.Event.Activated] = function()
					self.props.OnClosed()
				end,
			}, visibleChildren)
		})
	})
end

return Modalifier
