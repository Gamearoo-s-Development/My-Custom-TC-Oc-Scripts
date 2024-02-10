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
local sl = {2}
local nsl = {1,2}
local nr = {3}
local sr = {4}
local nsr = {3,4}



local ss = {5,6}
local ns = {7,8}


local nss = {5,6,7,8}


local wl = {9}
local ws = {10,11}
local es = {12,13}
local wes = {10,11,12,13}


os.sleep(60)
-- start script

setBundledOutput(colors.cyan, 200)





os.sleep(8)




local loop2 = thread.create(function() 
    while true do
        print("Triffic light us18 Dirt Road")
       
          -- component.debug.runCommand("clone -1872 57 -1451 -1872 57 -1451 -1887 69 -1468")
          -- component.debug.runCommand("clone -1876 57 -1437 -1876 57 -1437 -1887 69 -1451")
          os.sleep(0.1)
          setLights(sl, "GreenArrowLeft", "on")
          setLights(nl, "YellowArrowLeft2", "flash")
          setLights(ss, 'Green', "on")
          os.sleep(12)
          setLights(sl, "YellowArrowLeft", "on")
          os.sleep(3)
          -- component.debug.runCommand("clone -1875 57 -1451 -1875 57 -1451 -1887 69 -1468")
          -- component.debug.runCommand("clone -1874 57 -1437 -1874 57 -1437 -1887 69 -1451")
          os.sleep(0.1)
          setLights(sl, "RedArrowLeft", "on")
          os.sleep(1)
          setLights(ns, "Green", "on")
          setLights(sl, "YellowArrowLeft2", "flash")
          setLights(nsr, "YellowArrowRight2", "flash")
          os.sleep(30)
          
          setLights(nss, "Yellow", "on")
          setLights(nsl, "YellowArrowLeft", "on")
          setLights(sr, "YellowArrowRight", "on")
          os.sleep(3)
          setLights(nss, "Red", "on")
          setLights(nsl, "RedArrowLeft", "on")
          setLights(sr, "RedArrowRight", "on")
          os.sleep(1)
          -- component.debug.runCommand("clone -1878 57 -1451 -1878 57 -1451 -1878 69 -1468")
          -- component.debug.runCommand("clone -1882 57 -1446 -1882 57 -1446 -1902 69 -1460")
          os.sleep(0.1)
          setLights(wl, "GreenArrowLeft", "on")
          setLights(ws, "Green", "on")
          setLights(nr, "GreenArrowRight", "on")
          os.sleep(12)
          -- component.debug.runCommand("clone -1880 57 -1451 -1880 57 -1451 -1878 69 -1468")
          -- component.debug.runCommand("clone -1882 57 -1444 -1882 57 -1444 -1902 69 -1460")
          os.sleep(0.1)
          setLights(wl, "YellowArrowLeft", "on")
          setLights(nr, "YellowArrowRight", "on")
          os.sleep(3)
          setLights(wl, "RedArrowLeft", "on")
          setLights(nr, "RedArrowRight", "on")
          os.sleep(1)
          setLights(wl, "YellowArrowLeft2", "flash")
          setLights(es, "Green", "on")
          os.sleep(20)
          setLights(wl, "YellowArrowLeft", "on")
          setLights(wes, "Yellow", "on")
          os.sleep(3)
          setLights(wl, "RedArrowLeft", "on")
          setLights(wes, "Red", "on")
          os.sleep(1)

    




    end

  end)

  
      thread.waitForAny({loop2})

