local component = require("component");
local traffic = component.traffic_light_card
local os = require("os")
local thread = require("thread")

local sides = require("sides")
local computer = require("computer")
local rs = component.proxy(component.list("redstone")())

-- Warning this script contains bulbs from a custom edited version of traffic control to use this script fine Left2 and Right2 for yellows and remove the 2 from that and it will work

local colors = require("colors")


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


local nl = {1}
local ns = {1, 2}
local ss = {3, 4}
local nss = {1,2,3,4}
local sr = {4}
local e = {5, 6}
local er = {6}



os.sleep(60)
-- start script

setBundledOutput(colors.cyan, 200)





os.sleep(8)




local loop2 = thread.create(function() 
    while true do
        print("Triffic light us18 Dirt Road")
       
        setLights(ns, "Green", "on")
        setLights(nl, "GreenArrowLeft", "on", false)
        setLights(er, "GreenArrowRight", "on", false)
        os.sleep(12)
        setLights(nl, "GreenArrowLeft", "off", false)
        setLights(er, "GreenArrowRight", "off", false)
        setLights(nl, "YellowArrowLeft", "on", false)
        setLights(er, "YellowArrowRight", "on", false)
        os.sleep(3)
        setLights(nl, "YellowArrowLeft", "off", false)
        setLights(er, "YellowArrowRight", "off", false)
        os.sleep(1)
        setLights(ss, "Green", "on")
        os.sleep(30)
        setLights(nss, "Yellow", "on")
        os.sleep(3)
        setLights(nss, "Red", "on")
        os.sleep(1)
        setLights(e, "Green", "on")
        setLights(er, "GreenArrowRight", "on", false)
        setLights(sr, "GreenArrowRight", "on", false)
        os.sleep(20)
        setLights(e, "Yellow", "on")
        setLights(er, "YellowArrowRight", "on", false)
        setLights(sr, "GreenArrowRight", "off", false)
        setLights(sr, "YellowArrowRight", "on", false)
        os.sleep(3)
        setLights(e, "Red", "on")
        setLights(sr, "YellowArrowRight", "off", false)
        os.sleep(1)

          
            

    




    end

  end)

  
      thread.waitForAny({loop2})

