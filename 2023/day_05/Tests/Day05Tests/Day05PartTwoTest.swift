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
    
    func test_examplePartTwo() {
        let input = parse(input)
        let label = ["soil", "fertilizer", "water", "light", "temperature", "humidity", "location"]
        zip(label, input.maps).forEach { label, map in
            print(label)
            for row in map {
                let destStart = row[0]
                let sourceStart = row[1]
                let count = row[2]
                let diff = destStart - sourceStart
                let lhs = sourceStart
                let rhs = sourceStart + count
                let trans = "\(lhs)-\(rhs): \(diff)"
                let resultLHS = lhs + diff
                let resultRHS = rhs + diff
                let result = "\(resultLHS) - \(resultRHS)"
                print(trans + " = " + result)
            }
            print("--\n")
        }
    }

    func test_splitRange() {
        let input = parse(input)
        let label = ["soil", "fertilizer", "water", "light", "temperature", "humidity", "location"]
        zip(label, input.maps).forEach { label, map in
            print(label)
            for row in map {
                let destStart = row[0]
                let sourceStart = row[1]
                let count = row[2]
                let diff = destStart - sourceStart
                let lhs = sourceStart
                let rhs = sourceStart + count
                let trans = "\(lhs)-\(rhs): \(diff)"
                print(trans)
                //
                //
                //
                //                let resultLHS = lhs + diff
                //                let resultRHS = rhs + diff
                //
                //                processed.append(resultLHS..<resultRHS)
                //                let result = "\(resultLHS) - \(resultRHS)"
                //                print(trans + " = " + result)
            }
            print("--\n")
        }
    }
}
