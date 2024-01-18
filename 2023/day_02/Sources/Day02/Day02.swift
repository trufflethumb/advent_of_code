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
    public private(set) var cubes: [Cube: Int] = [:]
    public var isPossible = true

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
