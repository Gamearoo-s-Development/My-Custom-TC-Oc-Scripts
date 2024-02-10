local component = require("component");
local traffic = component.traffic_light_card
local os = require("os")
local thread = require("thread")
 
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
    if string.lower(mode) == "flashing" then
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

-- first pase
local left = {1,2,3,4}
local striaght = {5,6,7,8}
-- second pase
local right = {9,10,11,12}
local stragt2 = {13, 14, 15, 16}

setLights(left, "RedArrowLeft", "on")
setLights(striaght, "StraightRed", "on")
setLights(right, "RedArrowRight", "on")
setLights(stragt2, "StraightRed", "on")
local loop2 = thread.create(function() 
    while true do
      

        print("Triffic light us19 i77")
        setLights(left, "GreenArrowLeft", "on")
        setLights(striaght, "StraightGreen", "on")
        os.sleep(30)
        setLights(left, "YellowArrowLeft", "on")
        setLights(striaght, "StraightYellow", "on")
        os.sleep(3)
        setLights(left, "RedArrowLeft", "on")
setLights(striaght, "StraightRed", "on")
        os.sleep(1)
        print("Triffic light us18 i77")
        setLights(right, "GreenArrowRight", "on")
        setLights(stragt2, "StraightGreen", "on")
        os.sleep(30)
        setLights(right, "YellowArrowRight", "on")
        setLights(stragt2, "StraightYellow", "on")
        os.sleep(3)
        setLights(right, "RedArrowRight", "on")
setLights(stragt2, "StraightRed", "on")
        os.sleep(1)





    end

  end)
  thread.waitForAny({loop2})

