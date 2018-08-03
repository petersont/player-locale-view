local Roact = require(script.Parent.Parent.Parent.Roact)
local Curtain = require(script.Parent.Curtain)

local Modalifier = Roact.Component:extend("Modalifier")

function Modalifier:init()
end

function Modalifier:render()
	return Roact.createElement("Frame", {
			Size = UDim2.new(1, 0, 1, 0)
		}, {
			curtain = Roact.createElement(Curtain, {
				Window = self.props.Window,
				ZIndex = self.props.ZIndex,
				OnClosed = self.props.OnClosed,
			}),

			content = self.props.Render()
	})
end

return Modalifier
