import Day10
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1 = 7145
func partOne() {
    let input = parsePartOne(content)
    let steps = boundary(input).count
    print((steps + 1)/2)
}
partOne()



// Part 2
