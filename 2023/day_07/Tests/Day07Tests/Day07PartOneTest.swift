import Day07
import XCTest

final class Day07PartOneTest: XCTestCase {
    func test_examplePartOne_line1() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.rows[0].hand, [3, 2, 10, 3, 13])
        XCTAssertEqual(sut.rows[0].bid, 765)
    }

    func test_examplePartOne_line2() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.rows[1].hand, [10, 5, 5, "J", 5])
        XCTAssertEqual(sut.rows[1].bid, 684)
    }

    func test_examplePartOne_line1_strength() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.rows[0].hand.strength(), .onePair)
    }

    func test_examplePartOne_line2_strength() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.rows[1].hand.strength(), .three)
    }

    func test_examplePartOne() {
        let input = parsePartOne(example)
        var answer = 0
        input.rows
            .sorted()
            .enumerated()
            .forEach { index, row in
                answer += (index + 1) * row.bid
            }
        XCTAssertEqual(answer, 6440)
    }
}
