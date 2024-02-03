import Day10
import XCTest

struct PartOneInput {
    let startingPosition: [Int]
    let map: [[Character]]
}

func parsePartOne(_ input: String) -> PartOneInput {
    let components = input.components(separatedBy: .newlines)
    var startingPosition = [Int]()
    var array = [[Character]]()
    var lineArray = [Character]()
    for (x, line) in components.enumerated() {
        for (y, character) in line.enumerated() {
            if startingPosition.isEmpty, character == "S" {
                startingPosition = [x, y]
            }
            lineArray.append(character)
        }
        array.append(lineArray)
        lineArray.removeAll(keepingCapacity: true)
    }
    return PartOneInput(startingPosition: startingPosition, map: array)
}

final class Day10PartOneTest: XCTestCase {
    func test_examplePartOne_startingPosition1() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.startingPosition, [1, 1])
    }

    func test_examplePartOne_startingPosition2() {
        let sut = parsePartOne(example2)
        XCTAssertEqual(sut.startingPosition, [1, 3])
    }

    func test_examplePartOne_2DArray() {
        let sut = parsePartOne(example)
        XCTAssertEqual(String(sut.map[0]), ".....")
        XCTAssertEqual(String(sut.map[1]), ".S-7.")
    }
}
