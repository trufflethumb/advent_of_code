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
            lhs = Int(String(input[i]))!
            break
        }
        guard j < input.endIndex else {
            i = input.index(after: i)
            j = i
            continue
        }
        if let number = dict[String(input[i...j])] {
            lhs = number
            break
        }
        j = input.index(after: j)
        if j - i == 5 {
            i = input.index(after: i)
            j = i
        }
    }
    j = input.index(before: input.endIndex)
    i = j
    while i >= input.startIndex {
        if input[i].isNumber {
            rhs = Int(String(input[i]))!
            break
        }
        guard j >= input.startIndex else {
            i = input.index(before: i)
            j = i
            continue
        }
        if let number = dict[String(input[i...j])] {
            rhs = number
            break
        }
        i = input.index(before: i)
        if j - i == 5 {
            j = input.index(before: j)
            i = j
        }
    }

    if lhs == nil {
        fatalError("lhs was not found")
    } else if rhs == nil {
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
