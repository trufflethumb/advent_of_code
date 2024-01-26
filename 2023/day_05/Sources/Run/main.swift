import Day05
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1, answer = 379811651
let parsedInput = parse(content)
print(minLocation(parsedInput))

// Part 2
