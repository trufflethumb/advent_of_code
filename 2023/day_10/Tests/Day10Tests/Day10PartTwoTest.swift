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

    func test_startingPositionReplacement() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.startingPositionReplacement(), .f)
    }

    func test_startingPositionReplacement2() {
        let sut = parsePartOne(example2)
        XCTAssertEqual(sut.startingPositionReplacement(), .f)
    }

    func test_startingPositionReplacement1b() {
        let sut = parsePartOne(example1b)
        XCTAssertEqual(sut.startingPositionReplacement(), .seven)
    }

    func test_examplePartTwo_example1() {
        let sut = parsePartOne(example1PartTwo)
        XCTAssertEqual(sut.enclosedTiles(), 4)
    }

    func test_examplePartTwo_example2() {
        let sut = parsePartOne(example2PartTwo)
        XCTAssertEqual(sut.enclosedTiles(), 8)
    }

}
