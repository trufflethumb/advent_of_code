import Day05
import XCTest

final class Day05PartTwoTest: XCTestCase {
    func test_examplePartTwo_line1() {
        let input = parse(input)
        let sut = minLocation(rangesOfSeedInput: input)
        XCTAssertEqual(sut, 46)
    }
    
    func test_examplePartTwo() {
        let input = parse(input)
        let rangeBasedSeed = inputToRangedSeed(input)
        let operationalMap = inputToOperationalMap(input)
        let seedRanges = findLocationRanges(rangedBasedSeed: rangeBasedSeed, operationalMap: operationalMap)
        XCTAssertEqual(seedRanges, [[46, 56], [82, 85], [97, 98], [94, 97], [86, 90], [56, 60]])
        XCTAssertEqual(findLowestLocation(seedRanges: seedRanges), 46)
    }

    /*
     [
     [79, 82],
     [14, 43],
     [55, 86],
     [13, 35],
     ]
     */
    func test_individualSeed1() {
        let input = parse(input)
        [
            [79, 82],
            [14, 43],
            [55, 86],
            [13, 35],
        ].forEach { map in
            let seed = map[0]
            let location = map[1]
            let rangeBasedSeed = [[seed, seed + 1]]
            let operationalMap = inputToOperationalMap(input)
            let seedRanges = findLocationRanges(rangedBasedSeed: rangeBasedSeed, operationalMap: operationalMap)
            XCTAssertEqual(seedRanges, [[location, location + 1]])
        }
    }

    // Brute force approach for part two
    private func minLocation(rangesOfSeedInput input: Input) -> Int {
        var seeds = [Int]()
        for i in stride(from: 0, to: input.seeds.count, by: 2) {
            seeds.append(
                contentsOf:
                    Array(input.seeds[i]..<input.seeds[i] + input.seeds[i + 1])
            )
        }
        return seeds.map { seed in
            numbers(fromSeed: seed, using: input.maps).last!
        }
        .min()!
    }
}
