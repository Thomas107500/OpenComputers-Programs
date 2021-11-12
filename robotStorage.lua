--currently silo expansion direction is hardcoded to be north

local robotcommon = require("robotCommon")
local inventoryController = require("component").inventory_controller

local chests = {} --{{x,y,z,side}}
local chestContent = {} --{{slot 1 item,slot 2 item}}
local interfaceChest --{x,y,z,side}

print("Initializing Storage System...")
local Vector3_current,facing = robotcommon.getCoord()

interfaceChest = {Vector3_current,facing}

