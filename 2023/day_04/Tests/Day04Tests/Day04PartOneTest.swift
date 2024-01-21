import Day04
import XCTest

final class Day04PartOneTest: XCTestCase {
    func test_examplePartOne_line1() {
        let input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
        let (winningNumbers, numbers) = parse(input)
        XCTAssertEqual(winningNumbers, [41, 48, 83, 86, 17])
        XCTAssertEqual(numbers, [83, 86, 6, 31, 17, 9, 48, 53])
        XCTAssertEqual(points(winningNumbers, numbers), 8)
    }

    func test_examplePartOne_line2() {
        let input = "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19"
        let (winningNumbers, numbers) = parse(input)
        XCTAssertEqual(winningNumbers, [13, 32, 20, 16, 61])
        XCTAssertEqual(numbers, [61, 30, 68, 82, 17, 32, 24, 19])
        XCTAssertEqual(points(winningNumbers, numbers), 2)
    }

    func test_examplePartOne_line3() {
        let input = "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1"
        let (winningNumbers, numbers) = parse(input)
        XCTAssertEqual(winningNumbers, [1, 21, 53, 59, 44])
        XCTAssertEqual(numbers, [69, 82, 63, 72, 16, 21, 14, 1])
        XCTAssertEqual(points(winningNumbers, numbers), 2)
    }
}
