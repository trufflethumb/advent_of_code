import Day06
import XCTest

final class Day06PartOneTest: XCTestCase {
    let input = """
    Time:      7  15   30
    Distance:  9  40  200
    """

    struct Input {
        let times: [Int]
        let distances: [Int]
    }

    func parse(_ input: String) -> Input {
        let components = input.components(separatedBy: .newlines)
        let times = components[0].components(separatedBy: .whitespaces).compactMap(Int.init)
        let distances = components[1].components(separatedBy: .whitespaces).compactMap(Int.init)
        return Input(times: times, distances: distances)
    }

    func test_examplePartOne_race1() {
        let sut = parse(input)
        XCTAssertEqual(sut.times[0], 7)
        XCTAssertEqual(sut.distances[0], 9)
        XCTAssertEqual(sut.times[1], 15)
        XCTAssertEqual(sut.distances[1], 40)
    }
}
