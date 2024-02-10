local component = require("component");
local traffic = component.traffic_light_card
local thread = require("thread")
local os = require("os")
local redstone = component.redstone


trafficLight = {}
lightPOS = traffic.listBlockPos()
 
for i = 1, #lightPOS do
  trafficLight[i] = lightPOS[i]
end
 
function setLights(id,state,mode,forceClear)
  -- F is the boolean for Flashing, S is the boolean for Steady/On
  local f = false
  local s = false
 
  --  Clear signal if flag to forceClear isn't set to false
  if forceClear ~= false then
    if (type(id) == "table") then
      for itr = 1, #id do
        traffic.clearStates(trafficLight[id[itr]][1],trafficLight[id[itr]][2],trafficLight[id[itr]][3])
      end
    elseif (type(id) == "string") then
      traffic.clearStates(trafficLight[id][1],trafficLight[id][2],trafficLight[id][3])
    end
  end
 
  --  Determine mode
  if mode ~= nil then
    --    Flashing
    if string.lower(mode) == "flash" then
      s = true
      f = true
    --   Steady
    elseif string.lower(mode) == "on" then
      s = true
      f = false
      --    Off
    else
      s = false
      f = false
    end
  else
    s = false
    f = false
  end
 
  --  Apply to signal
  if (type(id) == "table" and state ~= nil) then
    for itr = 1, #id do
      traffic.setState(trafficLight[id[itr]][1],trafficLight[id[itr]][2],trafficLight[id[itr]][3],state,s,f)
    end
 
  elseif (type(id) == "string" and state ~= nil) then
    traffic.setState(trafficLight[id][1],trafficLight[id][2],trafficLight[id][3],state,s,f)
  end
end

street = {1,2,3,4}
fire = {5,6,7,8,9,10}

setLights(street, "Green", "on")
setLights(fire, "Yellow", "off")

local sides = require("sides")
local colors = require("colors")

local loop2 = thread.create(function() 
    while true do

        if(redstone.getBundledInput(sides.front, colors.red ) >= 15) then
            redstone.setBundledOutput(sides.front, colors.blue, 20)
            
            setLights(street, "Yellow", "on")
            os.sleep(3)
            setLights(street, "Red", "on")
            os.sleep(2)
            setLights(fire, "Yellow", "flash")
            os.sleep(20)
            setLights(fire, "Yellow", "on")
            setLights(street, "Red", "flash")
            os.sleep(10)
            redstone.setBundledOutput(sides.front, colors.blue, 0)
            setLights(fire, "Yellow", "off")
            setLights(street, "Green", "on")

        end

        os.sleep(1)
    end
end)

thread.waitForAny({loop2})