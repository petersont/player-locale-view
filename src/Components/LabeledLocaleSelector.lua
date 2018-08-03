local Roact = require(script.Parent.Parent.Roact)

local LocaleSelector = require(script.Parent.LocaleSelector)

local LabeledLocaleSelector = Roact.Component:extend("LabeledLocaleSelector")

function LabeledLocaleSelector:render()
    return Roact.createElement("Frame", {
            Size = UDim2.new(0, 300, 0, 30),
            BackgroundTransparency = 1.0,
            BorderSizePixel = 0,
            LayoutOrder = self.props.LayoutOrder,
        }, {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 5)
            }),

            LocaleIdLabel = Roact.createElement("TextLabel", {
                Text = self.props.LabelText,
                TextXAlignment = "Right",
                BackgroundTransparency = 1.0,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 50, 0, 30),
                LayoutOrder = 0
            }),

            LocaleSelectorGroup = Roact.createElement(LocaleSelector, {
                Size = UDim2.new(0, 200, 0, 30),
                InitialLocaleId = self.props.InitLocaleId,
                SetLocaleId = self.props.SetLocaleId,
                LayoutOrder = 1
            }),
        })
end

return LabeledLocaleSelector
