function love.load()
    love.window.setMode(640, 480)
    font = love.graphics.newFont(24)
    love.graphics.setFont(font)
    waveTime = 0
    phase = "flash"
    phaseTime = 0
end
function love.update(dt)
    w, h = love.graphics.getDimensions()
    phaseTime = phaseTime + dt
    if phase == "flash" and phaseTime > 0.9 then
        phase = "testpattern"
        phaseTime = 0
    end
    if phase == "testpattern" and phaseTime > 2.5 then
        phase = "glitch"
        phaseTime = 0
    end
    if phase == "glitch" and phaseTime >= 0.5 then
        phase = "fadeout"
        phaseTime = 0
    end
    if phase == "fadeout" and phaseTime > 0.8 then
        phase = "main"
        phaseTime = 0
        driveInOffset = w
    end
    if phase == "main" and driveInOffset > 0 then
        driveInOffset = math.max(0, driveInOffset - w * dt / 0.5)
    end
    waveTime = waveTime + dt
end
function love.keypressed(key)
    if key == "r" and love.keyboard.isDown("lctrl", "rctrl") and love.keyboard.isDown("lshift", "rshift") then
        phase = "flash"
        phaseTime = 0
        waveTime = 0
        driveInOffset = nil
    end
end
function love.draw()
    if phase == "flash" then
        if phaseTime < 0.25 then
            love.graphics.clear(0, 0, 0)
            love.graphics.setColor(1, 1, 1)
            love.graphics.circle("fill", w/2, h/2, 6, 32)
        else
            local expansionTime = phaseTime - 0.25
            local duration = 0.65
            local alpha = 1 - math.min(expansionTime / duration, 1)
            local radius = expansionTime * 1000
            love.graphics.clear(0, 0, 0)
            love.graphics.setColor(1, 1, 1, alpha)
            love.graphics.circle("fill", w/2, h/2, radius, 100)
    end
    elseif phase == "testpattern" then
        local fadeAlpha = math.min(phaseTime / 2, 1)
        for i = 0, 7 do
            local x = i * (w/8)
            if i == 0 then
                love.graphics.setColor(1, 0, 0, fadeAlpha)
            elseif i == 1 then
                love.graphics.setColor(0, 1, 0, fadeAlpha)
            elseif i == 2 then
                love.graphics.setColor(0, 0, 1, fadeAlpha)
            elseif i == 3 then
                love.graphics.setColor(1, 1, 1, fadeAlpha)
            elseif i == 4 then
                love.graphics.setColor(0, 1, 1, fadeAlpha)
            elseif i == 5 then
                love.graphics.setColor(1, 0, 1, fadeAlpha)
            elseif i == 6 then
                love.graphics.setColor(1, 1, 0, fadeAlpha)
            else
                love.graphics.setColor(0.2, 0.2, 0.2, fadeAlpha)
            end
            love.graphics.rectangle("fill", x, 0, w/8, h)
        end
        local font = love.graphics.getFont()
        local fh = font:getHeight()
        local text = "NO SIGNAL"
        local totalWidth = font:getWidth(text)
        local startX = (w - totalWidth) / 2
        local baseY = h/2 - fh/2
        local padding = 16
        local boxW = font:getWidth(text) + 2 * padding
        local boxH =  fh + 2 * padding
        local boxX = (w - boxW) / 2
        local boxY = (h - boxH) / 2
        love.graphics.setColor(1, 1, 1, fadeAlpha)
        love.graphics.rectangle("fill", boxX, boxY, boxW, boxH)
        love.graphics.setColor(0, 0, 0, fadeAlpha)
        love.graphics.setLineWidth(4)
        love.graphics.rectangle("line", boxX, boxY, boxW, boxH)
        love.graphics.setLineWidth(1)
        love.graphics.print(text, startX, baseY)
        love.graphics.setColor(0, 0, 0, fadeAlpha)
        love.graphics.print(text, startX, baseY)
        love.graphics.setColor(0, 0, 0, 0.63)
        for y = 0, h, 2 do
            love.graphics.rectangle("fill", 0, y, w, 1)
        end
    elseif phase == "glitch" then
        local barColors = { {1,0,0}, {0,1,0}, {0,0,1}, {1,1,1}, {0,1,1}, {1,0,1}, {1,1,0}, {0.2,0.2,0.2} }
        love.graphics.clear(0, 0, 0)
        local bandH = 8
        for bandY = 0, h, bandH do
            local offset = love.math.random(-22, 22)
            for i = 0, 7 do
                local c = barColors[i + 1]
                love.graphics.setColor(c[1], c[2], c[3])
                local bx = i * (w / 8) + offset
                love.graphics.rectangle("fill", bx, bandY, w/8 + 2, bandH + 2)
            end
        end
        for _ = 1, 25 do
            local ax = love.math.random(0, math.max(0, w - 30))
            local ay = love.math.random(0, math.max(0, h - 20))
            local aw = love.math.random(4, 28)
            local ah = love.math.random(3, 14)
            local ac = barColors[love.math.random(1, 8)]
            love.graphics.setColor(ac[1], ac[2], ac[3])
            love.graphics.rectangle("fill", ax, ay, aw, ah)
        end                       
    elseif phase == "fadeout" then
        love.graphics.clear(0, 0, 0)
        local alpha = math.min(phaseTime / 0.8, 1)
        love.graphics.setColor(0, 0, 0, alpha)
        love.graphics.rectangle("fill", 0, 0, w, h)
    elseif phase == "main" then
        amplitude = 10
        wavePhase = 0.5
        love.graphics.clear(0, 0, 0)
        love.graphics.setColor(0.15, 0.80, 0.1)
        local text = "Adventures in Demosceneland"
        local font = love.graphics.getFont()
        local fh = font:getHeight()
        local totalWidth = font:getWidth(text)
        local startX = (w - totalWidth) / 2 + (driveInOffset or 0)
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



