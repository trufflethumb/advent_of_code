import Day03
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1
func partOne() {
    let wrongAnswers = [424683: "too low"]
    let result = findSumOfParts(findParts(content))
    let answer = 540212
    if let found = wrongAnswers[result] {
        print("Got one of the wrong results: \(result) is \(found)")
    } else if answer == result {
        print("You got it right: \(answer)")
    } else {
        print("New wrong results: \(result)")
    }
}
partOne()

// Part 2
func partTwo() {
    let wrongAnswers = [Int: String]()
    let result = findSumOfGearRatios(findGearRatios(parse(content)))
    let answer = 87605697
    if let found = wrongAnswers[result] {
        print("Got one of the wrong results: \(result) is \(found)")
    } else if answer == result {
        print("You got it right: \(answer)")
    } else {
        print("New wrong results: \(result)")
    }
}
partTwo()
