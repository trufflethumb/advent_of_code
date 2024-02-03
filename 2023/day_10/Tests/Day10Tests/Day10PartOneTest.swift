import Day10
import XCTest

struct PartOneInput {
    let name: String
}

func parsePartOne(_ input: String) -> PartOneInput {
    .init(name: "1")
}

final class Day10PartOneTest: XCTestCase {
    func test_examplePartOne_line1() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.name, "1")
    }
}
