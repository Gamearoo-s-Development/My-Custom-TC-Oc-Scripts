local component = require("component");
local traffic = component.traffic_light_card
local os = require("os")
local thread = require("thread")
local m = component.modem -- get primary modem component
local sides = require("sides")
local computer = require("computer")

-- Warning this script contains bulbs from a custom edited version of traffic control to use this script fine Left2 and Right2 for yellows and remove the 2 from that and it will work

local colors = require("colors")
-- m.broadcast(455, "on")

-- function setBundledOutput(color, state) 
--     m.broadcast(455, color, state, sides.back)

--   end
 
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

li = {1,2,3}
all = {1,2,3,4,5,6,7}
yellow = {4,5,6,7}



setLights(all, "Red", "off")

os.sleep(1)
-- start script

-- setBundledOutput(colors.cyan, 200)
-- os.sleep(2)
-- setLights(sws, "Red", "on")
-- setLights(ns, "Red", "on")
-- os.sleep(4)

local on = false;
local time = os.date("*t")



local loop2 = thread.create(function() 
    -- 6am- 9am
    --5pm - 8pm
    while true do
        time = os.date("*t")
        -- ram off
        if (time.hour >= 21 and time.hour <= 5) then
            print("off")
            
            if(not on) then
               os.sleep(1)
            else
                on = false

                setLights(yellow, "Yellow", "off")
                setLights(li, "Green", "on")
                os.sleep(4)
                setLights(li, "Green", "off")
            end
          end
          -- ramp on morning
          if (time.hour >= 6 and time.hour <= 9) then
            print("on")
            if(not on) then
                on = true

                setLights(li, "Green", "on")
                setLights(yellow, "Yellow", "flash")
                os.sleep(6)
                setLights(li, "Yellow", "on")
                os.sleep(3)
                setLights(li, "Red", "on")
                os.sleep(1)
            else

                setLights(li, "Green", "on")
                os.sleep(1)
                setLights(li, "Red", "on")
                os.sleep(4)

            end
          end
          -- ramp off
          if (time.hour >= 10 and time.hour <= 16)  then
            print("off 2")
            if(not on) then
                os.sleep(1)
             else
                 on = false
 
                 setLights(yellow, "Yellow", "off")
                 setLights(li, "Green", "on")
                 os.sleep(4)
                 setLights(li, "Green", "off")
             end
          end
          -- ramp on afternoon
          if (time.hour >= 17 and time.hour <= 20)  then
            print("off 2")
            if(not on) then
                on = true

                setLights(li, "Green", "on")
                setLights(yellow, "Yellow", "flash")
                os.sleep(6)
                setLights(li, "Yellow", "on")
                os.sleep(3)
                setLights(li, "Red", "on")
                os.sleep(1)
            else

                setLights(li, "Green", "on")
                os.sleep(1)
                setLights(li, "Red", "on")
                os.sleep(4)

            end
          end


          os.sleep(1)

    end

  end)

  local loop3 = thread.create(function()
    while true do
        print("1")
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

