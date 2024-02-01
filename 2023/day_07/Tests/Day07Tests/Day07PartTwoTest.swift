import Day07
import XCTest

final class Day07PartTwoTest: XCTestCase {
    func test_examplePartTwo_line1_wildCardStrength() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.rows[0].hand.strength(countWildCards: true), .onePair)
    }

    func test_examplePartTwo_line4_wildCardStrength() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.rows[1].hand.strength(countWildCards: true), .four)
        XCTAssertEqual(sut.rows[2].hand.strength(countWildCards: true), .twoPairs)
        XCTAssertEqual(sut.rows[3].hand.strength(countWildCards: true), .four)
        XCTAssertEqual(sut.rows[4].hand.strength(countWildCards: true), .four)
    }

    func test_comparisonOfStrength() {
        let lhs = Hand("JKKK2")
        let rhs = Hand("QQQQ2")
        let sut = Hand.wildCardLessThan(lhs: lhs, rhs: rhs)
        XCTAssertTrue(sut)
    }

    func test_rank() {
        let lhs = Hand("T55J5")
        let rhs = Hand("QQQJA")
        let sut = Hand.wildCardLessThan(lhs: lhs, rhs: rhs)
        XCTAssertTrue(sut)
    }

    func test_rank2() {
        let lhs = Hand("QQQJA")
        let rhs = Hand("KTJJT")
        let sut = Hand.wildCardLessThan(lhs: lhs, rhs: rhs)
        XCTAssertTrue(sut)
    }

    func test_examplePartTwo() {
        let input = parsePartOne(example)
        var answer = 0
        input.rows
            .sorted(by: Row.wildCardLessThan)
            .enumerated()
            .forEach { index, row in
                answer += (index + 1) * row.bid
            }
        XCTAssertEqual(answer, 5905)
    }
}
