import Day07
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1 = 255048101
func partOne() {
    let parsedInput = parsePartOne(content)
    let answer = parsedInput.rows
        .sorted()
        .enumerated()
        .reduce(0) { current, enumeration in
            let (index, row) = enumeration
            return current + (index + 1) * row.bid
        }
    print(answer)
}

// Part 2 = 253718286
func partTwo() {
    let wrongAnswers = [
        254424055: "too high",
        253698848: "too low",
        251224936: "too low"
    ]
    let parsedInput = parsePartOne(content)
    let answer = parsedInput.rows
        .sorted(by: Row.wildCardLessThan)
        .enumerated()
        .reduce(0) { current, enumeration in
            let (index, row) = enumeration
            return current + (index + 1) * row.bid
        }
    if let existing = wrongAnswers[answer] {
        print(existing)
    } else {
        print(answer)
    }
}

partTwo()
