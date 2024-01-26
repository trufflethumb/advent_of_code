import Day05
import XCTest

func minLocation(rangesOfSeedInput input: Input) -> Int {
    var seeds = [Int]()
    for i in stride(from: 0, to: input.seeds.count, by: 2) {
        seeds.append(
            contentsOf:
                Array(input.seeds[i]..<input.seeds[i] + input.seeds[i + 1])
        )
    }
    return seeds.map { seed in
        print("seed: \(seed)")
        let n = numbers(fromSeed: seed, using: input.maps)
        print(n)
        return n.last!
    }
    .min()!
}

final class Day05PartTwoTest: XCTestCase {
    func test_examplePartTwo_line1() {
        let input = parse(input)
        let sut = minLocation(rangesOfSeedInput: input)
        XCTAssertEqual(sut, 46)
    }
}
