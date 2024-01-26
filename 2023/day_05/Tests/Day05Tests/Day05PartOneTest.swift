import Day05
import XCTest

struct Input {
    let seeds: [Int]
    let maps: [[[Int]]]
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
    let maps = input.ranges(of: "map:")
    let seeds = parseMap(input, seedIndex, maps[0]).flatMap { $0 }
    var sources = [[[Int]]]()
    var previous = maps[0]

    for map in maps.dropFirst() {
        sources.append(parseMap(input, previous, map))
        previous = map
    }

    sources.append(parseMap(input, previous, input.endIndex..<input.endIndex))

    return Input(
        seeds: seeds,
        maps: sources
    )
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

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 69
        """
        let sut = parse(input)
        XCTAssertEqual(sut.seeds, [79, 14, 55, 13])
        XCTAssertEqual(sut.maps, [
        [[50, 98, 2],
         [52, 50, 48]],

        [[49, 53, 8],
         [0, 11, 42],
         [42, 0, 7],
         [57, 7, 4]],

        [[88, 18, 7],
         [18, 25, 70]],

        [[45, 77, 23],
         [81, 45, 19],
         [68, 64, 13],],

        [[0, 69, 1],
         [1, 0, 69],]
        ])
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
        18 25 71

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 70
        """
        let sut = parse(input)
        XCTAssertEqual(sut.seeds, [79, 14, 55, 15])
        XCTAssertEqual(sut.maps, [
            [[50, 98, 3],
             [52, 50, 49]],

            [[49, 53, 8],
             [0, 11, 42],
             [42, 0, 7],
             [57, 7, 3]],

            [[88, 18, 7],
             [18, 25, 71]],

            [[45, 77, 23],
             [81, 45, 19],
             [68, 64, 13],],

            [[0, 69, 1],
             [1, 0, 70],]
        ])
    }
}
