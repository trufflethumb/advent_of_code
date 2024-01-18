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

public func determinePossibility(_ input: String) -> (id: Int, isPossible: Bool) {
    let components = input.components(separatedBy: ": ")
    let id = Int(components[0].components(separatedBy: .whitespaces)[1])!
    for draw in components[1].components(separatedBy: "; ") {
        for cubeType in draw.components(separatedBy: ", ") {
            let statement = cubeType.components(separatedBy: " ")
            let count = Int(statement[0])!
            let color = Cube(rawValue: statement[1])!
            if count > color.limit {
                return (id, false)
            }
        }
    }
    return (id, true)
}

public func sumIDs(_ input: String) -> Int {
    input.components(separatedBy: .newlines)
        .map(determinePossibility)
        .filter(\.isPossible)
        .map(\.id)
        .reduce(0, +)
}
