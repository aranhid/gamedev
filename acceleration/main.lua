require "vector"
require "mover"

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    love.graphics.setBackgroundColor(128 / 255, 128 / 255, 128 / 255)
    
    location = Vector:create(200, height / 2)
    wlocation = Vector:create(600, height / 2)
    velocity = Vector:create(0, 0)
    mover = Mover:create(location, velocity)
    wmover = Mover:create(wlocation, velocity)

    wind = Vector:create(0.01, 0)
    isWind = false
    gravity = Vector:create(0, 0.01)
    isGravity = false
    floating = Vector:create(0, -0.02)
    isFloating = false

    
end

function love.draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 119/255, 190/255, 0.5)
    love.graphics.rectangle("fill", 100, 100, 200, 200)
    love.graphics.setColor(190/255, 0, 0, 0.5)
    love.graphics.rectangle("fill", 400, 400, 200, 200)
    love.graphics.setColor(r, g, b, a)
    mover:draw()
    wmover:draw()
    love.graphics.print(tostring(mover.velocity), mover.location.x + mover.size, mover.location.y)
    love.graphics.print(tostring(wmover.velocity), wmover.location.x + wmover.size, wmover.location.y)
    love.graphics.print("w: " .. tostring(isWind) .. " g: " .. tostring(isGravity) .. " f: " .. tostring(isFloating))
end

function love:update()
    if isGravity then
        mover:applyForce(gravity)
        wmover:applyForce(gravity)
    end
    if isWind then
        mover:applyForce(wind)
        wmover:applyForce(wind)
    end
    if isFloating then
        mover:applyForce(floating)
        wmover:applyForce(floating)
    end

    -- mover:applyForce(gravity)
    -- wmover:applyForce(gravity)
    -- mover:applyForce(wind)
    -- wmover:applyForce(wind * -1)

    checkFriction(mover)
    checkFriction(wmover)

    mover:update()
    mover:checkBoundaries()
    wmover:update()
    wmover:checkBoundaries()
end

function love.keypressed(key)
    if key == 'g' then
        isGravity = not isGravity
    end
    if key == 'f' then
        isFloating = not isFloating
    end
    if key == 'w' then
        isWind = not isWind
        if isWind then
            wind = wind * -1
        end
    end
end

function checkFriction(mover)
    if mover.location.x > 100 and mover.location.x < 300 and mover.location.y > 100 and mover.location.y < 300 then
        local friction = mover.velocity:norm()
        if friction then
            friction:mul(0.005)
            mover:applyForce(friction)
        end
    end
    if mover.location.x > 400 and mover.location.x < 600 and mover.location.y > 400 and mover.location.y < 600 then
        local friction = (mover.velocity * -1):norm()
        if friction then
            friction:mul(0.005)
            mover:applyForce(friction)
        end
    end
end