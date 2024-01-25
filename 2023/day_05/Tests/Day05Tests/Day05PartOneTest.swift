import Day05
import XCTest

struct Input {
    let seeds: [Int]
    let seedToSoil: [[Int]]
    let fertilizerToWater: [[Int]]
}

func parseMap(_ input: String, _ rangeLHS: Range<String.Index>, _ rangeRHS: Range<String.Index>) -> [[Int]] {
    input[rangeLHS.upperBound..<rangeRHS.lowerBound]
        .components(separatedBy: .newlines)
        .map {
            $0
                .components(separatedBy: .whitespaces)
                .compactMap(Int.init)
        }
        .filter { !$0.isEmpty }
}

func parse(_ input: String) -> Input {
    let seedIndex = input.range(of: "seeds: ")!
    let seedToSoilIndex = input.range(of: "seed-to-soil map:")!
    let fertilizerToWaterIndex = input.range(of: "fertilizer-to-water map:")!
    let waterToLightIndex = input.range(of: "water-to-light map:")!
    let seeds = parseMap(input, seedIndex, seedToSoilIndex).flatMap { $0 }

    let seedToSoil = parseMap(input, seedToSoilIndex, fertilizerToWaterIndex)
    let fertilizerToWater = parseMap(input, fertilizerToWaterIndex, waterToLightIndex)
    return Input(seeds: seeds, seedToSoil: seedToSoil, fertilizerToWater: fertilizerToWater)
}

final class Day05PartOneTest: XCTestCase {
    func test_examplePartOne() {
        let input = """
        seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48
        
        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4

        water-to-light map:
        88 18 7
        18 25 70
        """
        let sut = parse(input)
        XCTAssertEqual(sut.seeds, [79, 14, 55, 13])
        XCTAssertEqual(sut.seedToSoil, [[50, 98, 2], [52, 50, 48]])
        XCTAssertEqual(sut.fertilizerToWater,
        [[49, 53, 8],
        [0, 11, 42],
        [42, 0, 7],
        [57, 7, 4]]
        )
    }

    func test_examplePartOne_differentInput() {
        let input = """
        seeds: 79 14 55 15

        seed-to-soil map:
        50 98 3
        52 50 49

        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 3
        
        water-to-light map:
        88 18 7
        18 25 70
        """
        let sut = parse(input)
        XCTAssertEqual(sut.seeds, [79, 14, 55, 15])
        XCTAssertEqual(sut.seedToSoil, [[50, 98, 3], [52, 50, 49]])
        XCTAssertEqual(sut.fertilizerToWater,
                       [[49, 53, 8],
                        [0, 11, 42],
                        [42, 0, 7],
                        [57, 7, 3]]
        )
    }
}
