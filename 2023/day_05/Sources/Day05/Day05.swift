import Foundation

public struct Input {
    public let seeds: [Int]
    public let maps: [[[Int]]]

    public init(seeds: [Int], maps: [[[Int]]]) {
        self.seeds = seeds
        self.maps = maps
    }
}

public func parseMap(_ input: String, _ rangeLHS: Range<String.Index>, _ rangeRHS: Range<String.Index>) -> [[Int]] {
    input[rangeLHS.upperBound..<rangeRHS.lowerBound]
        .components(separatedBy: .newlines)
        .map {
            $0
                .components(separatedBy: .whitespaces)
                .compactMap(Int.init)
        }
        .filter { !$0.isEmpty }
}

public func parse(_ input: String) -> Input {
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

public func destination(from source: Int, using map: [[Int]]) -> Int {
    for row in map {
        let destStart = row[0]
        let sourceStart = row[1]
        let count = row[2]
        if (sourceStart..<(sourceStart + count)).contains(source) {
            return destStart - sourceStart + source
        }
    }
    return source
}

public func numbers(fromSeed seed: Int, using maps: [[[Int]]]) -> [Int] {
    var current = seed
    var result = [Int]()
    for map in maps {
        current = destination(from: current, using: map)
        result.append(current)
    }
    return result
}

public func minLocation(_ input: Input) -> Int {
    let maps = input.maps
    return input.seeds.map { seed in
        numbers(fromSeed: seed, using: maps).last!
    }
    .min()!
}

public func inputToOperationalMap(_ input: Input) -> [[[Int]]] {
    input.maps.map { map in
        let operations = map.map { row in
            let destStart = row[0]
            let sourceStart = row[1]
            let count = row[2]
            let diff = destStart - sourceStart
            let lhs = sourceStart
            let rhs = sourceStart + count
            return [lhs, rhs, diff]
        }
        return operations
    }
}

public func inputToRangedSeed(_ input: Input) -> [[Int]] {
    var seedInput = [[Int]]()
    for i in stride(from: 0, to: input.seeds.count, by: 2) {
        seedInput.append([
            input.seeds[i],
            input.seeds[i] + input.seeds[i + 1] - 1
        ])
    }
    return seedInput
}

public func findLocationRanges(rangedBasedSeed: [[Int]], operationalMap: [[[Int]]]) -> [[Int]] {

    var seedRanges = [[Int]]()

    for seed in rangedBasedSeed {
        var modified = [[Int]]()
        var unmodified = [seed]

        for individualMap in operationalMap {
            for row in individualMap {
                let localUnmodified = unmodified
                unmodified.removeAll()
                for unmoddedCandidate in localUnmodified {
                    let (moded, unmoded) = transform(unmoddedCandidate, row)
                    unmodified.append(contentsOf: unmoded)
                    modified.append(contentsOf: moded)
                }
            }
            unmodified.append(contentsOf: modified)
            modified.removeAll()
        }
        seedRanges.append(contentsOf: unmodified)
    }
    return seedRanges
}

public func findLowestLocation(seedRanges: [[Int]]) -> Int {
    var currentMin = Int.max
    for seedRange in seedRanges {
        currentMin = min(currentMin, seedRange[0])
        currentMin = min(currentMin, seedRange[1])
    }
    return currentMin
}

