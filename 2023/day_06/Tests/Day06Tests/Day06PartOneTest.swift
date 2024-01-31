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

    func test_examplePartOne_race1_allDistances() {
        let parsedInput = parse(input)
        let sut = allDistances(timeLimit: parsedInput.times[0])
        XCTAssertEqual(sut, [0, 6, 10, 12])
    }

    func test_examplePartOne_race1_waysToWin() {
        let parsedInput = parse(input)
        let distances = allDistances(timeLimit: parsedInput.times[0])
        let sut = waysToWin(distances, record: parsedInput.distances[0])
        XCTAssertEqual(sut, 4)
    }

    func test_examplePartOne_race2_waysToWin() {
        let parsedInput = parse(input)
        let distances = allDistances(timeLimit: parsedInput.times[1])
        let sut = waysToWin(distances, record: parsedInput.distances[1])
        XCTAssertEqual(sut, 8)
    }

    func test_examplePartOne_race3_waysToWin() {
        let parsedInput = parse(input)
        let distances = allDistances(timeLimit: parsedInput.times[2])
        let sut = waysToWin(distances, record: parsedInput.distances[2])
        XCTAssertEqual(sut, 9)
    }

    func test_examplePartOne_allRaces_waysToWin() {
        let parsedInput = parse(input)
        let sut = zip(parsedInput.times.map(allDistances(timeLimit:)), parsedInput.distances)
            .map(waysToWin)
            .reduce(1, *)
        XCTAssertEqual(sut, 288)
    }
}
