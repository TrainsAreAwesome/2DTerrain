-- A simple terrain maker
-- Mwgie#8873


math.randomseed(os.time())

local lastState = ''
local CurrentState = ''
local terrain = ''
local hillUp = [[/
]]
local hillDown = [[
\\
]]
for i = 1, 100 do

local function printState()
terrain = terrain .. CurrentState
lastState = CurrentState
CurrentState = ''
end

local function RandomState()
    if lastState == '_' then 
    local number = math.random(1,4)
    if number == 1 then CurrentState = '_'
        elseif number == 2 then CurrentState = hillUp
             elseif number == 3 then CurrentState = '|'
                 elseif number == 4 then CurrentState = '~'
                    end
                    end
                    
if lastState == '/' then
    local number = math.random(1,4)
    if number == 1 then CurrentState = hillUp
        elseif number == 2 then CurrentState = hillUp
            elseif number == 3 then CurrentState = hillDown
            else CurrentState = '_'
            end end




printState()
end

local function temp()
    
    CurrentState = '_'
    
    printState()

end

local function states()
    if lastState == '' then 
    temp() elseif
    lastState ~= '' then
    RandomState()
end end

states()
end
print(terrain)