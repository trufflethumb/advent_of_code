import Day02
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1
print(sumIDs(content))

// Part 2
print(sumPowers(content))
