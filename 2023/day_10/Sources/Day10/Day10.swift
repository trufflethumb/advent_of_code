import Foundation

public struct PartOneInput {
    public let startingPosition: Coordinate
    public let map: [[MapElement]]

    public var startingDirections: [Direction] {
        [Direction.up, .down, .left, .right]
            .compactMap { direction in
                if nil != next(at: startingPosition.go(direction), currentDirection: direction) {
                    return direction
                }
                return nil
            }
    }

    public func startingPositionReplacement() -> MapElement {
        let startingDirections = startingDirections
        let other: (Direction) -> Direction = { direction in
            startingDirections.first(where: { $0 != direction })!
        }
        var startingPositionReplacement: MapElement = .start
        if startingDirections.contains(.left) {
            switch other(.left) {
            case .down:
                startingPositionReplacement = .seven
            case .up:
                startingPositionReplacement = .j
            case .right:
                startingPositionReplacement = .dash
            default: break
            }
        } else if startingDirections.contains(.up) {
            switch other(.up) {
            case .down:
                startingPositionReplacement = .pipe
            case .left:
                startingPositionReplacement = .j
            case .right:
                startingPositionReplacement = .l
            default: break
            }
        } else if startingDirections.contains(.right) {
            switch other(.right) {
            case .down:
                startingPositionReplacement = .f
            case .left:
                startingPositionReplacement = .dash
            case .up:
                startingPositionReplacement = .l
            default: break
            }
        } else if startingDirections.contains(.down) {
            switch other(.down) {
            case .up:
                startingPositionReplacement = .pipe
            case .left:
                startingPositionReplacement = .j
            case .right:
                startingPositionReplacement = .l
            default: break
            }
        }
        return startingPositionReplacement
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

    public func cleanedMap() -> [[MapElement]] {
        let boundary = boundary()
        var copy = map
        for x in 0 ..< map.count {
            for y in 0 ..< map[0].count {
                if !boundary.contains([x, y]) {
                    copy[x][y] = .dot
                }
                if map[x][y] == .start {
                    copy[x][y] = startingPositionReplacement()
                }
            }
        }
        return copy
    }

    public func trimMap(_ map: [[MapElement]]) -> [ArraySlice<MapElement>] {
        map.map(trimRow)
    }

    public func trimRow(_ row: [MapElement]) -> ArraySlice<MapElement> {
        var startIndex: Int?
        var endIndex: Int?
        for i in 0 ..< (row.count + 1) / 2 {
            if startIndex != nil && endIndex != nil {
                break
            }

            if startIndex == nil && row[i] != .dot {
                startIndex = i
            }
            if endIndex == nil && row[row.endIndex - i - 1] != .dot {
                endIndex = row.endIndex - i - 1
            }
        }
        guard let startIndex, let endIndex else { return [] }
        return row[startIndex ... endIndex]
    }

    public func enclosedTiles() -> Int {
        var count = 0
        let cleanedMap = cleanedMap()
        let trimmedMap = trimMap(cleanedMap)
        for row in trimmedMap {
            var boundaryOdd = false
            var previousTurn: MapElement?
            for element in row {
                let isInside = boundaryOdd
                if let foundPreviousTurn = previousTurn {
                    var shouldToggle = false
                    var shouldRemove = false
                    switch foundPreviousTurn {
                    case .l:
                        shouldToggle = element == .seven
                        shouldRemove = element == .j
                    case .f:
                        shouldToggle = element == .j
                        shouldRemove = element == .seven
                    default:
                        break
                    }
                    if shouldToggle {
                        boundaryOdd.toggle()
                        previousTurn = nil
                    }
                    if shouldRemove {
                        previousTurn = nil
                    }
                } else if element == .pipe {
                    boundaryOdd.toggle()
                } else if [.l, .f].contains(element) {
                    previousTurn = element
                } else if element == .dot {
                    if isInside {
                        count += 1
                    }
                }
            }
        }
        return count
    }

    public func boundary() -> Set<Coordinate> {
        var currentDirection = startingDirections[0]
        var currentCoordinate = startingPosition.go(currentDirection)
        var coordinates: Set<Coordinate> = [currentCoordinate]

        while let next = next(at: currentCoordinate, currentDirection: currentDirection) {
            currentDirection = next
            currentCoordinate = currentCoordinate.go(next)
            coordinates.insert(currentCoordinate)
        }

        return coordinates
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

extension Coordinate: Hashable {}

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

