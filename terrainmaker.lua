-- A simple terrain maker
-- Mwgie#8873
-- Version AT3


math.randomseed(os.time())

local terrainXPosition = 1
local terrainYPosition = 1
local lastState = '_'
local CurrentState = '_'
local terrain = {
''
}
local hillUp = [[/
]]
local hillDown = '\\'
local function hillDownLeveling()

    if terrainYPosition == #terrain then
        table.insert(terrain, string.rep(' ', terrainXPosition))
    end
    
    terrainYPosition = terrainYPosition - 1

    if terrainYPosition == 0 then
        terrainYPosition = 1 
    end

end

local function hillUpLeveling()
    
    if terrainYPosition == 1 then
        table.insert(terrain, 1, string.rep(' ', terrainXPosition))
    end
    
    terrainYPosition = terrainYPosition + 1
end

local function AddToTerrain()
    
    if CurrentState == hillUp then 
        hillUpLeveling()
    elseif CurrentState == hillDown or CurrentState == '|' then
        hillDownLeveling()
    end
    terrain[terrainYPosition] = terrain[terrainYPosition] .. CurrentState
    print(terrainXPosition)
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
    
    if lastState == hillUp then
        GenerateNextPeiceOfTerrainFromHillUp()
    end

    if lastState == hillDown then
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

print('How much terrain do you want to generate?')

local terrainAmount = io.read()

for i = 1, tonumber(terrainAmount) do

    GenerateNextPeiceOfTerrain()

    AddToTerrain()

end

for i = 1, #terrain do
    print(terrain[i])
end