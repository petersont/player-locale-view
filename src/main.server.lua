local Toolbar = plugin:CreateToolbar("Player Locale")
local Button = Toolbar:CreateButton("Hide/Show", "", "")

local PlayerLocaleView = require(script.Parent.Components.PlayerLocaleView)

local Roact = require(script.Parent.Parent.Roact)

local Window = plugin:CreateDockWidgetPluginGui("LocalizationTesting",
	DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Left))
Window.Title = "Localization Testing"

local canAccess = pcall(function() return game.LocalizationService.RobloxForcePlayModeRobloxLocaleId end)

local params
if canAccess then
	local LocalizationService = game:GetService("LocalizationService")
	params = {
		Window = Window,
		SetRobloxLocaleId = function(localeId)
			LocalizationService.RobloxForcePlayModeRobloxLocaleId = localeId
		end,
		SetGameLocaleId = function(localeId)
			LocalizationService.RobloxForcePlayModeGameLocaleId = localeId
		end,
		InitialRobloxLocaleId = LocalizationService.RobloxForcePlayModeRobloxLocaleId,
		InitialGameLocaleId = LocalizationService.RobloxForcePlayModeGameLocaleId,
	}
else
	--[[DEBUG CODE]]
	local test_gameLocaleId = "en-us"
	local test_robloxLocaleId = "en-us"
	params = {
		Window = Window,
		SetRobloxLocaleId = function(localeId)
			print("setting roblox locale to "..localeId)
			test_robloxLocaleId = localeId
		end,
		SetGameLocaleId = function(localeId)
			print("setting game locale to "..localeId)
			test_gameLocaleId = localeId
		end,
		InitialRobloxLocaleId = test_robloxLocaleId,
		InitialGameLocaleId = test_gameLocaleId,
	}
	--[[END DEBUG CODE]]
end

Roact.mount(Roact.createElement(PlayerLocaleView, params), Window)

Button.Click:Connect(
	function()
		Window.Enabled = not Window.Enabled
	end
)

