import Day10
import XCTest

final class Day10PartTwoTest: XCTestCase {
    func test_trimmedRow_line1() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.trimRow(sut.map[0]).count, 0)
    }
    
    func test_trimmedRow_line2() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.trimRow(sut.map[1]).count, 3)
    }

    func test_trimmedRow_line3() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.trimRow(sut.map[2]).count, 3)
    }

    func test_examplePartTwo_line1() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.enclosedTiles(), 1)
    }
}
