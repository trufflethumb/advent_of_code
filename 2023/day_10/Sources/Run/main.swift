import Day10
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1 = 7145
func partOne() {
    let input = parsePartOne(content)
    var steps = 0
    var currentCoordinate = input.startingPosition
    var currentDirection = [Direction.up, .down, .left, .right]
        .compactMap { direction in
            if nil != input.next(at: currentCoordinate.go(direction), currentDirection: direction) {
                return direction
            }
            return nil
        }
        .first!
    currentCoordinate = currentCoordinate.go(currentDirection)
    while let next = input.next(at: currentCoordinate, currentDirection: currentDirection) {
        steps += 1
        currentDirection = next
        currentCoordinate = currentCoordinate.go(next)
    }
    print((steps + 1)/2)
}
partOne()



// Part 2
