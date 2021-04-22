-- A simple terrain maker
-- Mwgie#8873
-- Version AT3


math.randomseed(os.time())

local terrainXPosition = 1
local terrainYPosition = 1
local lastState = ''
local CurrentState = ''
local terrain = {
''
}
local hillUp = [[/
]]
local hillDown = '\\'

local function AddNewLineToBottomOfTerrain()
if terrainYPosition == #terrain then
    table.insert(terrain, string.rep(' ', terrainXPosition))
    end
end

local function AddToTerrain()
    
    terrain[terrainYPosition] = terrain[terrainYPosition] .. CurrentState
    terrainXPosition = terrainXPosition + 1
    lastState = CurrentState
    CurrentState = ''
    
end

local function GenerateNextPeiceOfTerrainFromFlat()
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

local function GenerateNextPeiceOfTerrainFromHillUp()
    if terrainYPosition == 1 then
        table.insert(terrain, 1, string.rep(' ', terrainXPosition))
    end

    local number = math.random(1,4)
    if number == 1 or number == 2 then 
        CurrentState = hillUp
    elseif number == 3 then
        CurrentState = hillDown
    else 
        CurrentState = '_'
    end 
end

local function GenerateNextPeiceOfTerrainFromHillDown()
    
    AddNewLineToBottomOfTerrain()
    
    local number = math.random(1,3)
     if number == 1 or number == 2 then 
        CurrentState = hillDown
     elseif number == 3 then
        CurrentState = '_'
     end
end

local function GenerateNextPeiceOfTerrainFromWater()

    local number = math.random(1,3)
    if number == 1 or number == 2 then 
        CurrentState = '~'
    elseif number == 3 then
        CurrentState = '_'
    end
end

local function GenerateNextPeiceOfTerrainFromCliff()

    AddNewLineToBottomOfTerrain()

    local number = math.random(1,4)
    if number == 1 or number == 2 then 
        CurrentState = '|'
    elseif number == 3 then
        CurrentState = '_'
    elseif number == 4 then
        CurrentState = '\\'
    end
end

local function GenerateNextPeiceOfTerrain()
    if lastState == '_' then 
        GenerateNextPeiceOfTerrainFromFlat()
    end
    
    if lastState == '/' then
        GenerateNextPeiceOfTerrainFromHillUp()
    end

    if lastState == '\\' then
        GenerateNextPeiceOfTerrainFromHillDown()
    end

    if lastState == '~' then
        GenerateNextPeiceOfTerrainFromWater()
    end

    if lastState == '|' then
        GenerateNextPeiceOfTerrainFromCliff()
    end

    terrainXPosition = terrainXPosition + 1

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

for i = 1, #terrain do
print(terrain[i])
end