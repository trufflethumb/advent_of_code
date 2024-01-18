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
    "1": 1,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9,
]

public func getCalibration(_ input: String) -> Int {
    guard !input.isEmpty else { return 0 }
    let input = Array(input)
    var lhs: Int!
    var rhs: Int!
    var lhsIndex = input.endIndex
    var rhsIndex = -1
    for (number, value) in dict {
        let ranges = input.ranges(of: number)
        if let first = ranges.first, first.lowerBound < lhsIndex {
            lhs = value
            lhsIndex = first.lowerBound
        }
        if let last = ranges.last, last.lowerBound > rhsIndex {
            rhs = value
            rhsIndex = last.lowerBound
        }
    }
    return lhs * 10 + rhs
}


public func sumCalibrationDocumentValues(_ input: String) -> Int {
    input
        .components(separatedBy: .newlines)
        .map(getCalibration)
        .reduce(0, +)
}
