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
    let numberOfWins = wins(winningNumbers, candidates)
    return 2.toThePower(of: numberOfWins - 1)
}

public func wins(_ winningNumbers: [Int], _ candidates: [Int]) -> Int {
    Set(winningNumbers)
        .intersection(Set(candidates))
        .count
}

public func sumPoints(_ input: String) -> Int {
    input
        .components(separatedBy: .newlines)
        .filter { !$0.isEmpty }
        .map(parse)
        .map(points)
        .reduce(0, +)
}

public func sumScratchCardCount(_ input: String) -> Int {
    let wins = input
        .components(separatedBy: .newlines)
        .filter { !$0.isEmpty }
        .map(parse)
        .map(wins)

    return scratchCards(wins)
        .reduce(0, +)
}

public func scratchCards(_ wins: [Int]) -> [Int] {
    var cardTracker = [Int](repeating: 1, count: wins.count)
    for winIndex in 0 ..< wins.count {
        let numberOfAffectedCards = wins[winIndex]

        if numberOfAffectedCards > 0 {
            let lowerBound = min(wins.endIndex - 1, winIndex + 1)
            let upperBound = min(wins.endIndex - 1, winIndex + numberOfAffectedCards)
            for i in lowerBound ... upperBound {
                cardTracker[i] += cardTracker[winIndex]
            }
        }
    }
    return cardTracker
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
