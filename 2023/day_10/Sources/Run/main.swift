import Day10
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1 = 7145
func partOne() {
    let steps = parsePartOne(content).boundary().count
    print((steps + 1)/2)
}
//partOne()



func partTwo() {
    let enclosedTiles = parsePartOne(content).enclosedTiles()
    print(enclosedTiles)
}
partTwo()
// Part 2
