import Day10
import XCTest

final class Day10PartOneTest: XCTestCase {
    func test_examplePartOne_startingPosition1() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.startingPosition, [1, 1])
    }

    func test_examplePartOne_startingPosition2() {
        let sut = parsePartOne(example1b)
        XCTAssertEqual(sut.startingPosition, [1, 3])
    }

    func test_examplePartOne_2DArray() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.map[0], [MapElement](repeating: ".", count: 5))
        XCTAssertEqual(sut.map[1].string, ".S-7.")
    }

    func test_examplePartOne_startingDirections() {
        let sut = parsePartOne(example)
        XCTAssert(sut.startingDirections.contains(.right))
        XCTAssert(sut.startingDirections.contains(.down))
    }

    func test_examplePartOne_charAt() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.char(at: [1, 2]), .dash)
    }

    func test_examplePartOne_comingDirection() throws {
        let input = parsePartOne(example)
        let start: Coordinate = [1, 2]
        var direction = try XCTUnwrap(input.next(at: start, currentDirection: .right))
        XCTAssertEqual(direction, .right)
        direction = try XCTUnwrap(input.next(at: start.go(direction), currentDirection: .right))
        XCTAssertEqual(direction, .down)
    }

    func test_examplePartOne_completeExample() throws {
        let input = parsePartOne(example)
        var steps = 0
        var currentDirection = input.startingDirections[0]
        var currentCoordinate = input.startingPosition.go(currentDirection)
        while let next = input.next(at: currentCoordinate, currentDirection: currentDirection) {
            steps += 1
            currentDirection = next
            currentCoordinate = currentCoordinate.go(next)
        }
        XCTAssertEqual(steps, 7)
    }
}
