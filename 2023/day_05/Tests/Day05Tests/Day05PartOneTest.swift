import Day05
import XCTest


final class Day05PartOneTest: XCTestCase {
    func test_seedToSoil_seedOne() {
        let input = parse(input)
        let seed = input.seeds[0]
        let sut = destination(from: seed, using: input.maps[0])
        XCTAssertEqual(sut, 81)
    }

    func test_seedToSoil_seedTwo() {
        let input = parse(input)
        let seed = input.seeds[1]
        let sut = destination(from: seed, using: input.maps[0])
        XCTAssertEqual(sut, 14)
    }

    func test_seedToSoil_seedThree() {
        let input = parse(input)
        let seed = input.seeds[2]
        let sut = destination(from: seed, using: input.maps[0])
        XCTAssertEqual(sut, 57)
    }

    func test_seedToSoil_seedFour() {
        let input = parse(input)
        let seed = input.seeds[3]
        let sut = destination(from: seed, using: input.maps[0])
        XCTAssertEqual(sut, 13)
    }

    func test_seedToLocation_seedOne() {
        let input = parse(input)
        let seed = input.seeds[0]
        let sut = numbers(fromSeed: seed, using: input.maps)
        XCTAssertEqual(sut, [81, 81, 81, 74, 78, 78, 82])
    }

    func test_seedToLocation_seedTwo() {
        let input = parse(input)
        let seed = input.seeds[1]
        let sut = numbers(fromSeed: seed, using: input.maps)
        XCTAssertEqual(sut, [14, 53, 49, 42, 42, 43, 43])
    }

    func test_examplePartOne() {
        let sut = parse(input)
        XCTAssertEqual(sut.seeds, [79, 14, 55, 13])
        XCTAssertEqual(sut.maps, [
            [[50, 98, 2], [52, 50, 48]],
            [[0, 15, 37], [37, 52, 2], [39, 0, 15]],
            [[49, 53, 8], [0, 11, 42], [42, 0, 7], [57, 7, 4]],
            [[88, 18, 7], [18, 25, 70]],
            [[45, 77, 23], [81, 45, 19], [68, 64, 13]],
            [[0, 69, 1], [1, 0, 69]],
            [[60, 56, 37], [56, 93, 4]]])
        XCTAssertEqual(minLocation(sut), 35)
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

        humidity-to-location map:
        60 56 37
        56 93 5
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
             [1, 0, 70],],

            [[60, 56, 37],
             [56, 93, 5],]
        ])
    }

    var input: String {
        """
        seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48

        soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15

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

        humidity-to-location map:
        60 56 37
        56 93 4
        """
    }
}
