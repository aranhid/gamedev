require("vector")

function love.load()
    vector1 = Vector:create(-5, 10)
    vector2 = Vector:create(-5, 10)

    vector = vector1 + vector2
    print(vector)
    vector = vector1 - vector2
    print(vector)
    vector = vector1 * 2
    print(vector)
    vector = vector1 / 5
    print(vector)
    vector3 = Vector:create(3, 0)
    print(vector3:mag())
    print(vector3:norm())
end