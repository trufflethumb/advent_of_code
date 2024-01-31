import Day06
import XCTest

final class Day06PartOneTest: XCTestCase {
    let input = """
    Time:      7  15   30
    Distance:  9  40  200
    """
    
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
        XCTAssertEqual(sut, [0, 6, 10, 12, 12, 10, 6, 0])
    }

    func test_examplePartOne_race1_waysToWin() {
        let parsedInput = parse(input)
        let distances = allDistances(timeLimit: parsedInput.times[0])
        let sut = waysToWin(distances, record: parsedInput.distances[0])
        XCTAssertEqual(sut, 4)
    }

    func test_examplePartOne_allRaces_waysToWin() {
        let parsedInput = parse(input)
        let sut = zip(parsedInput.times.map(allDistances(timeLimit:)), parsedInput.distances)
            .map(waysToWin)
            .reduce(1, *)
        XCTAssertEqual(sut, 288)
    }
}
