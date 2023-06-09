getgenv().webhookUrl = "" -- put discord webhook here

local http_request = http_request or request or HttpPost or syn.request

local function sendToWebhook(message)
    local data = {
        content = message
    }

    local headers = {
        ["Content-Type"] = "application/json"
    }

    local webhookUrl = getgenv().webhookUrl
    if not webhookUrl then
        print("webhookUrl is not set.")
        return
    end

    local success, response = pcall(function()
        return http_request({
            Url = webhookUrl,
            Method = "POST",
            Headers = headers,
            Body = game:GetService("HttpService"):JSONEncode(data)
        })
    end)

    if success then
        print("Message sent to Discord webhook!" .. message)
    else
        print("Failed to send message to Discord webhook. Error: " .. response)
    end
end

-- Event handler for chat messages
local function onPlayerChatted(message)
    sendToWebhook(message)
end

game.Players.LocalPlayer.Chatted:Connect(onPlayerChatted)
