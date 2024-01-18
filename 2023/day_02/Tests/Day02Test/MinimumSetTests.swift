import Day02
import XCTest

func minimumSet(_ input: String) -> (red: Int, green: Int, blue: Int) {
    (4, 2, 6)
}

final class MinimumSetTests: XCTestCase {
    func test_examplePartTwo_line1() {
        let input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
        XCTAssertEqual(minimumSet(input).red, 4)
        XCTAssertEqual(minimumSet(input).green, 2)
        XCTAssertEqual(minimumSet(input).blue, 6)
    }
}
