import Foundation

public func getCalibration(_ input: String) -> Int {
    var lhs: Int!
    var rhs: Int!
    for c in input {
        if c.isNumber {
            lhs = Int(String(c))!
            break
        }
    }
    for c in input.reversed() {
        if c.isNumber {
            rhs = Int(String(c))!
            break
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
