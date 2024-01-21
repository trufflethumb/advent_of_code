import Day04
import XCTest

func parse(_ input: String) -> ([Int], [Int]) {
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

final class Day04PartOneTest: XCTestCase {
    func test_examplePartOne_line1() {
        let input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
        let (winningNumbers, numbers) = parse(input)
        XCTAssertEqual(winningNumbers, [41, 48, 83, 86, 17])
        XCTAssertEqual(numbers, [83, 86, 6, 31, 17, 9, 48, 53])
    }

    func test_examplePartOne_line2() {
        let input = "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19"
        let (winningNumbers, numbers) = parse(input)
        XCTAssertEqual(winningNumbers, [13, 32, 20, 16, 61])
        XCTAssertEqual(numbers, [61, 30, 68, 82, 17, 32, 24, 19])
    }
}
