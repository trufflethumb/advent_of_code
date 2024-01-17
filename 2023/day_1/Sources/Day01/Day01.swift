import Foundation

let dict = [
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9,
    "zero": 0,
]

public func getCalibration(_ input: String) -> Int {
    guard !input.isEmpty else { return 0 }
    var lhs: Int!
    var rhs: Int!
    let input = Array(input)
    var i = input.startIndex
    var j = i
    while i < input.endIndex {
        if input[i].isNumber {
            if lhs == nil {
                lhs = Int(String(input[i]))!
            } else {
                rhs = Int(String(input[i]))!
            }
        } else if let number = dict[String(input[i...j])] {
            if lhs == nil {
                lhs = number
            } else {
                rhs = number
            }
            i = j + 1
            j = i
            continue
        }
        j = input.index(after: j)
        if j == input.endIndex {
            i = input.index(after: i)
            j = i
        }
    }
    if lhs == nil {
        fatalError("One of the numbers was not found")
    }
    if rhs == nil {
        rhs = lhs
    }
    return lhs * 10 + rhs
}


public func sumCalibrationDocumentValues(_ input: String) -> Int {
    input
        .components(separatedBy: .newlines)
        .map(getCalibration)
        .reduce(0, +)
}
