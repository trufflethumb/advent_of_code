import Foundation

public struct Input {
    public let seeds: [Int]
    public let maps: [[[Int]]]
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

