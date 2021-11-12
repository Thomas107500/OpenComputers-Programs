--Requirement to run: Internet Card


local internet = require("internet")

print("Checking availability of https://ocwebapi.thomas107500.repl.co/api/...")

local content = ""
local result = internet.request("https://ocwebapi.thomas107500.repl.co/api/ping")

for chunk in result do content = content..chunk end

if(content == "pong") then
    print("pong received, API is Online")
else    
    print("Failed. returned content: " .. content)
end