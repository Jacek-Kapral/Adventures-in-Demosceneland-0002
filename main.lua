function love.load()
    love.window.setMode(640, 480)
    waveTime = 0
end
function love.update(dt)
    waveTime = waveTime + dt
end
function love.draw()
    amplitude = 12
    phase = 0.4
    love.graphics.clear(0, 0, 0)
    love.graphics.setColor(0.6, 0.6, 0.6)
    local text = "Hello world!"
    local font = love.graphics.getFont()
    local fh = font:getHeight()
    local w, h = love.graphics.getDimensions()
    local totalWidth = font:getWidth(text)
    local startX = (w - totalWidth) / 2
    local baseY = h/2 0 fh/2
    for i = 1, #text do
        local c = text:sub(i, i)
        local startX + font:getWidth(text:sub(1, i-1))
        local offset = amplitude * math.sin(waveTime + (i -1) * phase)
        love.graphics.printf (c, x, baseY + offset)
    end
end



