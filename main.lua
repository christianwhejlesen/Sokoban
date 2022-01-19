--Requires
local game = require("func.game");
local level = require("func.level");
local player = require("func.player");

--Variables
local levels;
local gameOver = false;
local curLevel = 1;

--Initialize
local colors = game.getColors();
local gameVar = game.getGameVariables();
local numOfLevels = level.getNumberOfLevels();



function love.keyreleased( key )
    if key == 'escape' then
        love.event.quit();
    end
    
    if not gameOver then
        if key == 'up' or key == 'down' or key == 'left' or key == 'right' then
            local dx = 0;
            local dy = 0;

            if key == 'left' then
                dx = -1;
            elseif key == 'right' then
                dx = 1;
            elseif key == 'up' then
                dy = -1;
            elseif key == 'down' then
                dy = 1;
            end
            if (math.abs(dx) + math.abs(dy) == 1) then
                if player.move(levels, gameVar, { dx = dx, dy = dy}) then
                    curLevel = curLevel + 1;
                    if curLevel > numOfLevels then
                        curLevel = 1;
                    end
                    levels = level.getLevels(curLevel);
                end
            end

        elseif key == 'r' then
            levels = level.getLevels(curLevel);
        elseif key == 'n' then
            curLevel = curLevel + 1;
            if curLevel > numOfLevels then
                curLevel = 1;
            end
            levels = level.getLevels(curLevel);
        elseif key == 'p' then
            curLevel = curLevel - 1;
            if curLevel < 1 then
                curLevel = numOfLevels;
            end
            levels = level.getLevels(curLevel);
        end
    end
end

function love.load()
    love.graphics.setBackgroundColor( colors.bgColor );
    levels = level.getLevels(curLevel);
end

function love.update( dt )

end

function love.draw()
    game.draw(levels);
end