import Day03
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1
let wrongAnswers = [424683: "too low"]
let result = findParts(content).reduce(0, +)
let answer = 540212
if let found = wrongAnswers[result] {
    print("Got one of the wrong results: \(result) is \(found)")
} else if answer == result {
    print("You got it right: \(answer)")
} else {
    print("New wrong results: \(result)")
}

// Part 2
