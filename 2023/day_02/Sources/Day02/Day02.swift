import Foundation

public enum Cube: String {
    case red, green, blue

    var limit: Int {
        switch self {
        case .red: 12
        case .green: 13
        case .blue: 14
        }
    }
}

public struct Game {
    public let id: Int
    private(set) var cubes: [Cube: Int] = [:]
    public private(set) var isPossible = true

    mutating func add(_ cube: Cube, count: Int) {
        let existing = cubes[cube, default: Int.min]
        cubes[cube] = max(existing, count)
        isPossible = isPossible && count <= cube.limit
    }

    public var reds: Int {
        cubes[.red] ?? 0
    }

    public var greens: Int {
        cubes[.green] ?? 0
    }

    public var blues: Int {
        cubes[.blue] ?? 0
    }

    public var power: Int {
        reds * greens * blues
    }
}

public func parseGame(_ input: String) -> Game {
    let components = input.components(separatedBy: ": ")
    let id = Int(components[0].components(separatedBy: .whitespaces)[1])!
    var game = Game(id: id)
    for draw in components[1].components(separatedBy: "; ") {
        for cubeType in draw.components(separatedBy: ", ") {
            let statement = cubeType.components(separatedBy: " ")
            let count = Int(statement[0])!
            let cube = Cube(rawValue: statement[1])!
            game.add(cube, count: count)
        }
    }
    return game
}

public func sumIDs(_ input: String) -> Int {
    input.components(separatedBy: .newlines)
        .map(parseGame)
        .filter(\.isPossible)
        .map(\.id)
        .reduce(0, +)
}

public func sumPowers(_ input: String) -> Int {
    input.components(separatedBy: .newlines)
        .map(parseGame)
        .map(\.power)
        .reduce(0, +)
}

public func minimumSet(_ input: String) -> (red: Int, green: Int, blue: Int) {
    let game = parseGame(input)
    return (game.reds, game.greens, game.blues)
}

public func power(_ input: String) -> Int {
    parseGame(input).power
}
