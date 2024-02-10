local component = require("component");
local traffic = component.traffic_light_card
local os = require("os")
local thread = require("thread")

local sides = require("sides")
local computer = require("computer")

-- Warning this script contains bulbs from a custom edited version of traffic control to use this script fine Left2 and Right2 for yellows and remove the 2 from that and it will work

local colors = require("colors")

local rs = component.proxy(component.list("redstone")())


function setBundledOutput(color, state) 
  

    rs.setBundledOutput(sides.back, {[color] = state})



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



local nl = {1}
local sl = {2}
local nsl = {1,2}
local ns = {3,4}
local ss = {5, 6}
local nss = {3,4,5,6}
local nsr = {7,8,9}
local wel = {10, 11}
local wes = {10,11, 12, 13}






os.sleep(60)
-- start script

setBundledOutput(colors.cyan, 200)


os.sleep(8)


local loop2 = thread.create(function() 
    while true do


        setLights(nl, "GreenArrowLeft", "on")
        setLights(sl, "YellowArrowLeft2", "flash")
        setLights(ns, "Green", "on")
        os.sleep(12)
        setLights(nl, "YellowArrowLeft", "on")
        os.sleep(3)
        setLights(nl, "RedArrowLeft", "on")
        os.sleep(1)
        setLights(ss, "Green", "on")
        setLights(nl, "YellowArrowLeft2", "flash")
        os.sleep(30)
        setLights(nsl, "YellowArrowLeft", "on")
        setLights(nss, "Yellow", "on")
        os.sleep(3)
        setLights(nsl, "RedArrowLeft", "on")
        setLights(nss, "Red", "on")
        os.sleep(1)
        setLights(nsr, "GreenArrowRight", "on")
        setLights(wel, "GreenArrowLeft", "on", false)
        os.sleep(12)
        setLights(nsr, "YellowArrowRight", "on")
        setLights(wel, "GreenArrowLeft", "off", false)
        setLights(wel, "YellowArrowLeft", "on", false)
        os.sleep(3)
        setLights(nsr, "RedArrowRight", "on")
        setLights(wel, "YellowArrowLeft", "off", false)
        os.sleep(1)
        setLights(wes, "Green", "on")
        os.sleep(20)
        setLights(wes, "Yellow", "on")
        os.sleep(3)
        setLights(wes, "Red", "on")
        os.sleep(1)





    end

  end)

  


      thread.waitForAny({loop2})

