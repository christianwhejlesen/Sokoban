Game = {}
-- Private:
local cellSize = 23;
local bgColor = { 36/255, 92/255, 117/255, 100/100 };
local fgColor = { 255/255, 255/255, 255/255, 100/100 };

local player = '@';
local playerOnStorage = '+';
local box = '$';
local boxOnStorage = '*';
local storage = '.';
local wall = '#';
local empty = ' ';

-- Private:
local colors = {
    [player] = {.64, .53, 1},
    [playerOnStorage] = {.62, .47, 1},
    [box] = {1, .79, .49},
    [boxOnStorage] = {.59, 1, .5},
    [storage] = {.61, .9, 1},
    [wall] = {1, .58, .82},
    bgColor = bgColor,
    fgColor = fgColor,
};
local gamevariables = {
    cellSize = cellSize,
    player = player,
    playerOnStorage = playerOnStorage,
    box = box,
    boxOnStorage = boxOnStorage,
    storage = storage,
    wall = wall,
    empty = empty,
};

--Public:


-- Public:
function Game.getColors()
    return colors;
end

function Game.getGameVariables()
    return gamevariables;
end

function Game.draw(levels)
    for y, row in ipairs(levels) do
        for x, cell in ipairs(row) do
            if cell ~= empty then
                love.graphics.setColor(colors[cell])
                love.graphics.rectangle('fill', (x - 1) * cellSize, (y - 1) * cellSize, cellSize, cellSize);
                love.graphics.setColor(colors.fgColor)
                love.graphics.print(levels[y][x], (x - 1) * cellSize, (y - 1) * cellSize);
            end
        end
    end

end

return Game;