import Day01
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)
let answer = sumCalibrationDocumentValues(content)
let wrongAnswers = [54953, 54960]
let rightAnswerPartTwo = 54925
if rightAnswerPartTwo == answer {
    print("You got it right, it is \(answer)")
} else if wrongAnswers.contains(answer) {
    print("Ended up with one of the previously wrong answers: \(answer)")
} else {
    print("New answer: \(answer)")
}
