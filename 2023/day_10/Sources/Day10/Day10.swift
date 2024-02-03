import Foundation

public struct PartOneInput {
    public let startingPosition: Coordinate
    public let map: [[MapElement]]

    public var startingDirections: [Direction] {
        var directions = [Direction]()
        // left
        if let c = char(at: startingPosition.left), c == .dash {
            directions.append(.left)
        }
        // right
        if let c = char(at: startingPosition.right), c == .dash {
            directions.append(.right)
        }
        // up
        if let c = char(at: startingPosition.up), c == .pipe {
            directions.append(.up)
        }
        // down
        if let c = char(at: startingPosition.down), c == .pipe {
            directions.append(.down)
        }
        return directions
    }

    public func char(at coord: Coordinate) -> MapElement? {
        guard map.indices.contains(coord.x),
              map[0].indices.contains(coord.y) else {
            return nil
        }
        return map[coord.x][coord.y]
    }

    public func next(at coord: Coordinate, currentDirection: Direction) -> Direction? {
        let element = char(at: coord)
        switch (element, currentDirection) {
        case (.dot, _):
            return nil
        case (.l, .left):
            return .up
        case (.l, .down):
            return .right
        case (.dash, .left):
            return .left
        case (.dash, .right):
            return .right
        case (.f, .up):
            return .right
        case (.f, .left):
            return .down
        case (.seven, .right):
            return .down
        case (.seven, .up):
            return .left
        case (.j, .down):
            return .left
        case (.j, .right):
            return .up
        case (.pipe, .up):
            return .up
        case (.pipe, .down):
            return .down
        default:
            return nil
        }
    }
}

public enum MapElement: Character, ExpressibleByStringLiteral {
    case dot = "."
    case l = "L"
    case dash = "-"
    case f = "F"
    case seven = "7"
    case j = "J"
    case pipe = "|"
    case start = "S"

    public init(stringLiteral value: String) {
        let value = Character(value)
        self = MapElement(rawValue: value)!
    }
}

public struct Coordinate: Equatable, ExpressibleByArrayLiteral {
    public let x: Int
    public let y: Int

    public init(arrayLiteral elements: Int...) {
        x = elements[0]
        y = elements[1]
    }

    var left: Coordinate { [x, y - 1] }
    var right: Coordinate { [x, y + 1] }
    var up: Coordinate { [x - 1, y] }
    var down: Coordinate { [x + 1, y] }

    public func go(_ direction: Direction) -> Coordinate {
        switch direction {
        case .up:
            up
        case .down:
            down
        case .left:
            left
        case .right:
            right
        }
    }
}

public extension Array where Element == MapElement {
    var string: String {
        String(map(\.rawValue))
    }
}

public enum Direction {
    case up, down, left, right
}

public func parsePartOne(_ input: String) -> PartOneInput {
    let components = input
        .components(separatedBy: .newlines)
        .filter { !$0.isEmpty }
    var startingPosition: Coordinate!
    var array = [[MapElement]]()
    var lineArray = [MapElement]()
    for (x, line) in components.enumerated() {
        for (y, character) in line.enumerated() {
            if startingPosition == nil, character == "S" {
                startingPosition = [x, y]
            }
            lineArray.append(MapElement(rawValue: character)!)
        }
        array.append(lineArray)
        lineArray.removeAll(keepingCapacity: true)
    }

    return PartOneInput(startingPosition: startingPosition, map: array)
}
