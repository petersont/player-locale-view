local Roact = require(script.Parent.Parent.Parent.Roact)
local Curtain = require(script.Parent.Curtain)

local Modalifier = Roact.Component:extend("Modalifier")

function Modalifier:init()
	self.state = {
		position = Vector2.new(0, 0),
	}
end

function Modalifier:render()
	return Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),

		[Roact.Change.AbsolutePosition] = function(instance)
			self:setState({
				position = instance.AbsolutePosition
			})
		end,
	}, {
		curtain = Roact.createElement(Curtain, {
			Window = self.props.Window,
			ZIndex = self.props.ZIndex,
			OnClosed = self.props.OnClosed,
		}),

		content = self.props.Render(self.state.position)
	})
end

function Modalifier:didMount()
	self:setState({
		position = self.props.InitialPosition
	})
end

return Modalifier
