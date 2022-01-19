Player = {}

function Player.move(level, gameVar, move)

    local playerPos;
    local beyond;
    local complete = true;

    local nextAdjacent = {
        [gameVar.empty] = gameVar.player,
        [gameVar.storage] = gameVar.playerOnStorage
    };
    local nextCurrent = {
        [gameVar.player] = gameVar.empty,
        [gameVar.playerOnStorage] = gameVar.storage
    };
    local nextBeyond = {
        [gameVar.empty] = gameVar.box,
        [gameVar.storage] = gameVar.boxOnStorage
    };
    local nextAdjacentPush = {
        [gameVar.box] = gameVar.player,
        [gameVar.boxOnStorage] = gameVar.playerOnStorage
    };

    for y, row in ipairs(level) do
        for x, cell in ipairs(row) do
            if cell == gameVar.player or cell == gameVar.playerOnStorage then
                playerPos = { px = x, py = y};
                break;
            end
        end
    end

    if level[playerPos.py + move.dy + move.dy] then
        beyond = level[playerPos.py + move.dy + move.dy][playerPos.px + move.dx + move.dx];
    end
    
    local current = level[playerPos.py][playerPos.px];
    local adjacent = level[playerPos.py + move.dy][playerPos.px + move.dx];
    
    if nextAdjacent[adjacent] then
        level[playerPos.py][playerPos.px] = nextCurrent[current];
        level[playerPos.py + move.dy][playerPos.px + move.dx] = nextAdjacent[adjacent];

    elseif nextAdjacentPush[adjacent] and gameVar.box and nextBeyond[beyond] then
            level[playerPos.py][playerPos.px] = nextCurrent[current];
            level[playerPos.py + move.dy][playerPos.px + move.dx] = nextAdjacentPush[adjacent];
            level[playerPos.py + move.dy + move.dy][playerPos.px + move.dx + move.dx] = nextBeyond[beyond];
    end

    for y, row in ipairs(level) do
        for x, cell in ipairs(row) do
            if cell == gameVar.box then
                complete = false;
                break;
            end
        end
    end
    return complete;
end

return Player;