import Day04
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1
let attempts = [23742, 23740]
let answer = 23678
let result = sumPoints(content)

if attempts.contains(result) {
    print("Wrong: \(result)")
} else if answer == result {
    print("You got it!")
} else {
    print("New result: \(result)")
}

// Part 2
