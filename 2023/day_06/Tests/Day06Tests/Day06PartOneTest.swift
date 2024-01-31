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
        return Input(times: [7], distances: [9])
    }

    func test_examplePartOne_race1() {
        let sut = parse(input)
        XCTAssertEqual(sut.times[0], 7)
        XCTAssertEqual(sut.distances[0], 9)
    }
}
