-- A simple terrain maker
-- Mwgie#8873
-- Version AT4


math.randomseed(os.time())

local terrainXPosition = 1
local terrainYPosition = 1
local lastState = '_'
local CurrentState = '_'
local terrain = {
    ''
}
local hillUp = '/'

local hillDown = '\\'

local function UpdateXPositionOnString(xpos, ypos)
    -- if the length of the string is not equal to the xpos then
        -- take the xpos and minus off the length of the current string
            -- if the difference is more than 0 then
                -- add the amount of spaces equal to the distance
    if not #terrain[ypos] == xpos then
        local difference = xpos - #terrain[ypos]
        if difference > 0 then
            local spacesNeeded = string.rep(' ', difference)
            terrain[ypos] = terrain[ypos] .. spacesNeeded
        end
    end
end

local function hillDownLeveling()
    
    if terrainYPosition == #terrain then
        table.insert(terrain, string.rep(' ', terrainXPosition))
    end
    terrainYPosition = terrainYPosition + 1
    UpdateXPositionOnString(terrainXPosition, terrainYPosition)
end

local function hillUpLeveling()
    
    if terrainYPosition == 1 then
        table.insert(terrain, 1, string.rep(' ', terrainXPosition))
    else
        terrainYPosition = terrainYPosition - 1
    end
    UpdateXPositionOnString(terrainXPosition, terrainYPosition)
end

local function AddToTerrain()
    if CurrentState == hillUp then 
        hillUpLeveling()
    elseif CurrentState == hillDown or CurrentState == '|' then
        hillDownLeveling()
    end
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