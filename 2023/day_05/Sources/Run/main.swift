import Day05
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1, answer = 379811651
let parsedInput = parse(content)
//print(minLocation(parsedInput))

// Part 2, answer = 27992443
let wrongAnswers = [58556595: "58556595 is too high"]
let rangeBasedSeed = inputToRangedSeed(parsedInput)
let operationalMap = inputToOperationalMap(parsedInput)
let answer = findLowestLocation(seedRanges: findLocationRanges(rangedBasedSeed: rangeBasedSeed, operationalMap: operationalMap))
if let existingAnswer = wrongAnswers[answer] {
    print(existingAnswer)
} else {
    print("New answer: \(answer)")
}
