function love.load()
    love.window.setMode(640, 480)
    font = love.graphics.newFont(24)
    love.graphics.setFont(font)
    waveTime = 0
end
function love.update(dt)
    waveTime = waveTime + dt
end
function love.draw()
    amplitude = 12
    phase = 0.4
    love.graphics.clear(0, 0, 0)
    love.graphics.setColor(0.15, 0.80, 0.1)
    local text = "Adventures in Demosceneland"
    local font = love.graphics.getFont()
    local fh = font:getHeight()
    local w, h = love.graphics.getDimensions()
    local totalWidth = font:getWidth(text)
    local startX = (w - totalWidth) / 2
    local baseY = h/2 - fh/2
    for i = 1, #text do
        local c = text:sub(i, i)
        local x = startX + font:getWidth(text:sub(1, i-1))
        local offset = amplitude * math.sin(waveTime + (i - 1) * phase)
        love.graphics.print(c, x, baseY + offset)
    end
    love.graphics.setColor(0, 0, 0, 0.6)
        for y = 0, h, 2 do
            love.graphics.rectangle("fill", 0, y, w, 1)
        end
end



