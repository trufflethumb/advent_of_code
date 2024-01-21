import Foundation

public func parse(_ input: String) -> ([Int], [Int]) {
    guard let startIndex = input.firstIndex(of: ":") else {
        fatalError("Invalid input")
    }
    let winningNumberStart = input.index(after: startIndex)
    guard let numbersStart = input.firstIndex(of: "|") else {
        fatalError("Invalid input")
    }
    let winningNumbersList = String(input[winningNumberStart ..< numbersStart])

    let candidateNumberStart = input.index(after: numbersStart)
    let candidateNumbersList = String(input[candidateNumberStart...])

    let winningNumbers = winningNumbersList
        .components(separatedBy: .whitespaces)
        .compactMap(Int.init)

    let candidateNumbers = candidateNumbersList
        .components(separatedBy: .whitespaces)
        .compactMap(Int.init)

    return (winningNumbers, candidateNumbers)
}

public func points(_ winningNumbers: [Int], _ candidates: [Int]) -> Int {
    let numberOfWins = Set(winningNumbers)
        .intersection(Set(candidates))
        .count

    return 2.toThePower(of: numberOfWins - 1)
}

public func sumPoints(_ input: String) -> Int {
    input.components(separatedBy: .newlines)
        .filter { !$0.isEmpty }
        .map(parse)
        .map(points)
        .reduce(0, +)
}

public extension Int {
    func toThePower(of exp: Int) -> Int {
        if exp < 0 { return 0 }
        if exp == 0 { return 1 }
        var multiple = 1
        for _ in 0 ..< exp {
            multiple *= self
        }
        return multiple
    }
}
