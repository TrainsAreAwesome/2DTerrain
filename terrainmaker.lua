-- A simple terrain maker
-- Mwgie#8873

local terrainnumber = 0

math.randomseed(os.time())

local lastState = ''
local CurrentState = ''
local terrain = ''
local hillUp = [[ 
/]]
local hillDown = '\\'

local function AddToTerrain()
    terrain = terrain .. CurrentState
    lastState = CurrentState
    CurrentState = ''
end

local function GenerateNextPeiceOfTerrain()
    if lastState == '_' then 
        local number = math.random(1,4)
        if number == 1 then 
            CurrentState = '_'
        elseif number == 2 then 
            CurrentState = hillUp
        elseif number == 3 then 
            CurrentState = '|'
        elseif number == 4 then 
            CurrentState = '~'
        end
    end
                    
    if lastState == '/' then
        local number = math.random(1,4)
        if number == 1 then 
            CurrentState = hillUp
        elseif number == 2 then 
            CurrentState = hillUp
        elseif number == 3 then
            CurrentState = hillDown
        else 
            CurrentState = '_'
        end 
    end
    
    if lastState == '\\' then
        local number = math.random(1,3)
        if number == 1 then 
            CurrentState = hillDown
        elseif number == 2 then 
            CurrentState = hillDown
        elseif number == 3 then
            CurrentState = '_'
        end
    end
    if lastState == '~' then
        local number = math.random(1,3)
        if number == 1 then 
            CurrentState = '~'
        elseif number == 2 then 
            CurrentState = '~'
        elseif number == 3 then
            CurrentState = '_'
        end
    end
    if lastState == '|' then
        local number = math.random(1,4)
        if number == 1 then 
            CurrentState = '|'
        elseif number == 2 then 
            CurrentState = '|'
        elseif number == 3 then
            CurrentState = '_'
        elseif number == 4 then
            CurrentState == '\\'
        end
    end
end

local function temp()
        
    CurrentState = '_'
        
    AddToTerrain()

end

local function states()
    if lastState == '' then 
        temp() 
    elseif lastState ~= '' then
        GenerateNextPeiceOfTerrain()
    end 
end

print('How much terrain do you want to generate?')

local terrainAmount = io.read()


for i = 1, tonumber(terrainAmount) do

    GenerateNextPeiceOfTerrain()

    AddToTerrain()

    states() 

end

print(terrain)