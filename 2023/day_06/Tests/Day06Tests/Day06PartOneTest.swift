import Day06
import XCTest

final class Day06PartOneTest: XCTestCase {
    func test_examplePartOne_race1() {
        let sut = parse(input)
        XCTAssertEqual(sut.times[0], 7)
        XCTAssertEqual(sut.distances[0], 9)
        XCTAssertEqual(sut.times[1], 15)
        XCTAssertEqual(sut.distances[1], 40)
    }

    func test_examplePartOne_race1_waysToWin() {
        let parsedInput = parse(input)
        let time = parsedInput.times[0]
        let record = parsedInput.distances[0]
        let sut = waysToWin(timeLimit: time, record: record)
        XCTAssertEqual(sut, 4)
    }

    func test_examplePartOne_race2_waysToWin() {
        let parsedInput = parse(input)
        let time = parsedInput.times[1]
        let record = parsedInput.distances[1]
        let sut = waysToWin(timeLimit: time, record: record)
        XCTAssertEqual(sut, 8)
    }

    func test_examplePartOne_race3_waysToWin() {
        let parsedInput = parse(input)
        let time = parsedInput.times[2]
        let record = parsedInput.distances[2]
        let sut = waysToWin(timeLimit: time, record: record)
        XCTAssertEqual(sut, 9)
    }

    func test_examplePartOne_allRaces_waysToWin() {
        let parsedInput = parse(input)
        let sut = zip(parsedInput.times, parsedInput.distances)
            .map(waysToWin)
            .reduce(1, *)
        XCTAssertEqual(sut, 288)
    }
}
