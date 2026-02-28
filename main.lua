function love.load()
    love.window.setMode(640, 480)
    font = love.graphics.newFont(24)
    love.graphics.setFont(font)
    waveTime = 0
    phase = "flash"
    phaseTime = 0
end
function love.update(dt)
    phaseTime = phaseTime + dt
    if phase == "flash" and phaseTime > 0.5 then
        phase = "testpattern"
        phaseTime = 0
    end
    waveTime = waveTime + dt
end
function love.draw()
    if phase == "flash" then
        local w, h = love.graphics.getDimensions()
        local duration = 0.5
        local alpha = 1 - math.min(phaseTime / duration, 1)
        local radius = phaseTime * 1000
        love.graphics.clear(0, 0, 0)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.circle("fill", w/2, h/2, radius, 100)
    elseif phase == "testpattern" then
        local w, h = love.graphics.getDimensions()
        for i = 0, 7 do
            local x = i * (w/8)
            if i == 0 then
                love.graphics.setColor(1, 0, 0)
            elseif i == 1 then
                love.graphics.setColor(0, 1, 0)
            elseif i == 2 then
                love.graphics.setColor(0, 0, 1)
            elseif i == 3 then
                love.graphics.setColor(1, 1, 1)
            elseif i == 4 then
                love.graphics.setColor(0, 1, 1)
            elseif i == 5 then
                love.graphics.setColor(1, 0, 1)
            elseif i == 6 then
                love.graphics.setColor(1, 1, 0)
            else
                love.graphics.setColor(0.2, 0.2, 0.2)
            end
            love.graphics.rectangle("fill", x, 0, w/8, h)
        end
        local font = love.graphics.getFont()
        local fh = font:getHeight()
        local text = "NO SIGNAL"
        local totalWidth = font:getWidth(text)
        local startX = (w - totalWidth) / 2
        local baseY = h/2 - fh/2
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(text, startX, baseY)
    elseif phase == "main" then
        amplitude = 10
        wavePhase = 0.5
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
            local offset = amplitude * math.sin(waveTime + (i - 1) * wavePhase)
            love.graphics.print(c, x, baseY + offset)
        end
        love.graphics.setColor(0, 0, 0, 0.63)
        for y = 0, h, 2 do
            love.graphics.rectangle("fill", 0, y, w, 1)
        end
    end
end



