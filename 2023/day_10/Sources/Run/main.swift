import Day10
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1
func partOne() {
    let input = parsePartOne(content)
    var steps = 0
    var currentDirection = input.startingDirections[0]
    var currentCoordinate = input.startingPosition.go(currentDirection)
    while let next = input.next(at: currentCoordinate, currentDirection: currentDirection) {
        steps += 1
        currentDirection = next
        currentCoordinate = currentCoordinate.go(next)
    }
    print((steps + 1)/2)
}
partOne()



// Part 2
