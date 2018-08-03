local Roact = require(script.Parent.Parent.Parent.Roact)

local Curtain = Roact.Component:extend("Curtain")

function Curtain:init()
end

function Curtain:render()
	return Roact.createElement(Roact.Portal, {
		target = self.props.Window,
	}, {
		Curtain = Roact.createElement("TextButton", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = self.props.ZIndex,

			[Roact.Event.Activated] = function()
				self.props.OnClosed()
			end,
		})
	})
end

return Curtain
