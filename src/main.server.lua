local Toolbar = plugin:CreateToolbar("Player Locale")
local Button = Toolbar:CreateButton("Hide/Show", "", "")

local PlayerLocaleView = require(script.Parent.Components.PlayerLocaleView)

local Roact = require(script.Parent.Parent.Roact)

local Window = plugin:CreateDockWidgetPluginGui("LocalizationTesting", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Left))
Window.Title = "Localization Testing"

local game_LocalizationService_RobloxForcePlayModeRobloxLocaleId = "en-us"
local game_LocalizationService_RobloxForcePlayModeGameLocaleId = "en-us"

canAccess, result = pcall(function() return game.LocalizationService.RobloxForcePlayModeRobloxLocaleId end)

local params
if canAccess then
    local Localization = game:GetService("LocalizationService")
    params = {
        SetRobloxLocaleId = function(localeId) game.LocalizationService.RobloxForcePlayModeRobloxLocaleId = localeId end,
        SetGameLocaleId = function(localeId) game.LocalizationService.RobloxForcePlayModeGameLocaleId = localeId end,
        InitialRobloxLocaleId = game.LocalizationService.RobloxForcePlayModeRobloxLocaleId,
        InitialGameLocaleId = game.LocalizationService.RobloxForcePlayModeGameLocaleId,
    }
else
    params = {
        SetRobloxLocaleId = function(localeId) game_LocalizationService_RobloxForcePlayModeRobloxLocaleId = localeId end,
        SetGameLocaleId = function(localeId) game_LocalizationService_RobloxForcePlayModeGameLocaleId = localeId end,
        InitialRobloxLocaleId = game_LocalizationService_RobloxForcePlayModeRobloxLocaleId,
        InitialGameLocaleId = game_LocalizationService_RobloxForcePlayModeGameLocaleId,
    }
end

Roact.mount(Roact.createElement(PlayerLocaleView, params), Window)

Button.Click:Connect(
    function()
        Window.Enabled = not Window.Enabled
    end
)

