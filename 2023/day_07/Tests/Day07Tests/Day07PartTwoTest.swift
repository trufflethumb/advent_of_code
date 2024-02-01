import Day07
import XCTest

struct PartTwoInput {
    let name: String
}

func parsePartTwo(_ input: String) -> PartTwoInput {
    .init(name: "1")
}

final class Day07PartTwoTest: XCTestCase {
    func test_examplePartTwo_line1() {
        let sut = parsePartTwo(example)
        XCTAssertEqual(sut.name, "1")
    }
}
