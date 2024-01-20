import Day03
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1
let wrongAnswers = [424683: "too low"]
let result = findParts(content).reduce(0, +)
if let found = wrongAnswers[result] {
    print("Got one of the wrong results: \(result) is \(found)")
} else {
    print("New result, try it! \(result)")
}

// Part 2
