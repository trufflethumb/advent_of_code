import Day06
import XCTest

final class Day06PartTwoTest: XCTestCase {
    func test_examplePartTwo_parsing() {
        let sut = parseSingleRace(input)
        XCTAssertEqual(sut.times, [71530])
        XCTAssertEqual(sut.distances, [940200])
    }

    func test_examplePartTwo() {
        let parsedInput = parseSingleRace(input)
        let sut = zip(parsedInput.times, parsedInput.distances)
            .map(waysToWin)
            .reduce(1, *)
        XCTAssertEqual(sut, 71503)
    }
}
