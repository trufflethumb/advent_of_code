import Day07
import XCTest

final class Day07PartTwoTest: XCTestCase {
    func test_examplePartTwo_line1_wildCardStrength() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.rows[0].hand.strength(countWildCards: true), .onePair)
    }

    func test_examplePartTwo_line4_wildCardStrength() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.rows[3].hand.strength(countWildCards: true), .four)
    }
}
