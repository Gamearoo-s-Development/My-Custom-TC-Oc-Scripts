local component = require("component");
local traffic = component.traffic_light_card
local os = require("os")
local thread = require("thread")
local m = component.modem -- get primary modem component
local sides = require("sides")
local computer = require("computer")
local rs = component.proxy(component.list("redstone")())

-- Warning this script contains bulbs from a custom edited version of traffic control to use this script fine Left2 and Right2 for yellows and remove the 2 from that and it will work

local colors = require("colors")
m.broadcast(123, "on")

function setBundledOutput(color, state) 
    m.broadcast(123, color, state, sides.back)

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

local nsl = {1,2}
local nss = {3,4,5,6}
local nsr = {7,8}
local wel = {9,10}
local wes ={ 11,12,13,14}


local cardport = 123
local port = 369
m.open(port)


os.sleep(60)
-- start script

setBundledOutput(colors.cyan, 200)




os.sleep(8)
local nightflash = true;
local mode = "normal" 
local wait = false;



local loop2 = thread.create(function() 
    while true do
        print("Triffic light us18 Dirt Road")
        -- N/S Left

      
          wait = true
         
        setLights(nsl, "GreenArrowLeft", "on")
        
        os.sleep(12)
       
        setLights(nsl, "YellowArrowLeft", "on")
     
        os.sleep(3)
     
        setLights(nsl, "RedArrowLeft", "on")
    
        os.sleep(1)
          
   
       
        -- n/s striaght
        setLights(nss, "Green", "on")
        setLights(nsr, "YellowArrowRight2", "flash")
        if(nightflash) then
          setLights(nsl, "YellowArrowLeft2", "flash")
        end
        
     
        os.sleep(30)
        
        setLights(nss, "Yellow", "on")
        if(nightflash) then
          setLights(nsl, "YellowArrowLeft", "on")
        end
        
    
        os.sleep(5)
        
      
        setLights(nss, "Red", "on")
        if(nightflash) then
          setLights(nsl, "RedArrowLeft", "on")
        end
        
      
        os.sleep(1)
       
        -- w left
      
        
        setLights(wel, "GreenArrowLeft", "on")
        setLights(nsr, "GreenArrowRight", "on")
        
    
        os.sleep(12)
        
        setLights(nsr, "YellowArrowRight", "on")
        setLights(wel, "YellowArrowLeft", "on")
      
        os.sleep(3)
       
        setLights(wel, "RedArrowLeft", "on")
        setLights(nsr, "RedArrowRight", "on")
        
  
        os.sleep(1)
        
        -- w/e striaght
        
        setLights(wes, "Green", "on")
  
        os.sleep(16)
      
       
        setLights(wes, "Yellow", "on")
      
        os.sleep(4)
        
       
        setLights(wes, "Red", "on")
        wait = false;
        
        os.sleep(3)

        





    end

  end)

  local loop3 = thread.create(function()
    while true do
      time = os.date("*t")
      print(time.hour)

      if (rs.getInput(sides.back) == 15) and (not wait) then
        -- setBundledOutput(colors.cyan, 0)
        mode = "flash"
        nightflash = false
      end

      if  (rs.getInput(sides.back) == 0) and  (mode == "flash")  then
        mode = "normal"
       

nightflash = true
      end

      os.sleep(1)
    end
      
      end)


      thread.waitForAny({loop2, loop3})

