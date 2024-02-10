local component = require("component");
local traffic = component.traffic_light_card
local os = require("os")
local thread = require("thread")
local m = component.modem -- get primary modem component
local sides = require("sides")
local computer = require("computer")

-- Warning this script contains bulbs from a custom edited version of traffic control to use this script fine Left2 and Right2 for yellows and remove the 2 from that and it will work

local colors = require("colors")
m.broadcast(455, "on")

function setBundledOutput(color, state) 
    m.broadcast(455, color, state, sides.back)

  end
 
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
-- key
-- S Stright
-- Y stright bulb
-- T Turn Bulb
-- L Left
-- R Right
-- Middle Frame


-- north 1 LT, 2 YS , 3 YS , 4 RT
-- south 5 LT, 6 YS, 7 YS , 8 RT
-- east 9 L , 10 ML , 11 MR,12 R
-- west 13 L, 14 R

el = {1}
es = {1, 2}
ws = {3, 4}
ews = {1, 2,3, 4}
ns = {5,6,7,8}

local cardport = 455
local port = 370
m.open(port)


os.sleep(60)
-- start script

setBundledOutput(colors.cyan, 200)
os.sleep(2)
setLights(ews, "Red", "on")
setLights(ns, "Red", "on")
os.sleep(4)


local loop2 = thread.create(function() 
    while true do
       
-- e left
setLights(es, "Green", "on")
setLights(el, "GreenArrowLeft", "on", false)

os.sleep(12)
setLights(el, "GreenArrowLeft", "off", false)
setLights(el, "YellowArrowLeft", "on", false)
os.sleep(3)
setLights(el, "YellowArrowLeft", "off", false)
os.sleep(1)
setLights(ws, "Green", "on")
os.sleep(20)
setLights(ews, "Yellow", "on")
os.sleep(5)
setLights(ews, "Red", "on")
os.sleep(1)

-- ns
setLights(ns, "Green", "on")
os.sleep(17)
setLights(ns, "Yellow", "on")
os.sleep(3)
setLights(ns, "Red", "on")
os.sleep(1)

        





    end

  end)

  local loop3 = thread.create(function()
    while true do
      local name, receiver, sender, port, distance, on = computer.pullSignal()
      if name == "modem_message" then
        if(on == "stop") then
          m.broadcast(cardport, 1,1,1 , "OFF")
          
          computer.shutdown(false)
        end
        if(on == "restart") then
          m.broadcast(cardport, 1,1,1 , "OFF")
         
          computer.shutdown(true)
        end
      
      end
  
      end
      end)


      thread.waitForAny({loop2, loop3})

