function love.load()
    love.window.setMode(640, 480)
end
function love.update(dt)
end
function love.draw()
    love.graphics.clear(0, 0, 0)
    love.graphics.setColor(0.6, 0.6, 0.6)
    local w, h = love.graphics.getDimensions()
    local fh = love.graphics.getFont():getHeight()
    love.graphics.printf ("Hello World!", 0, h/2 - fh/2, w, "center")
end



