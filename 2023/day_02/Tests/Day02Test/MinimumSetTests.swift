import Day02
import XCTest

func minimumSet(_ input: String) -> (red: Int, green: Int, blue: Int) {
    let game = parseGame(input)
    return (game.reds, game.greens, game.blues)
}

final class MinimumSetTests: XCTestCase {
    func test_examplePartTwo_line1() {
        let input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
        XCTAssertEqual(minimumSet(input).red, 4)
        XCTAssertEqual(minimumSet(input).green, 2)
        XCTAssertEqual(minimumSet(input).blue, 6)
    }

    func test_examplePartTwo_line2() {
        let input = "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
        XCTAssertEqual(minimumSet(input).red, 1)
        XCTAssertEqual(minimumSet(input).green, 3)
        XCTAssertEqual(minimumSet(input).blue, 4)
    }
}
