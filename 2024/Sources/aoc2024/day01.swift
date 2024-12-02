import Foundation

func parse(_ day: Int) throws -> String {
    let file = String(format: "input%.2d", day)
    guard let input = Bundle.module.url(forResource:file, withExtension: "txt") else {
        throw NSError(domain: "Unable to find file", code: 0)
    } 
    return try String(contentsOf: input)
}

func toArray(_ string: String) -> ([Int], [Int]) {
    var lhs: [Int] = []
    var rhs: [Int] = []
    let lines = string.split(separator: "\n")
    for line in lines {
        let numbers = String(line).components(separatedBy: "   ").compactMap(Int.init)
        guard numbers.count == 2 else {
            fatalError("Invalid number of elements")
        }
        lhs.append(numbers[0])
        rhs.append(numbers[1])
    }
    return (lhs, rhs)
}

func distances(lhs: Int, rhs: Int) -> Int {
    return abs(rhs - lhs)
}

func simScore(input: String) -> Int {
    let (lhs, rhs) = toArray(input)
    let occurrenceTable = rhs.reduce(into: [Int: Int]()) {
        $0[$1, default: 0] += 1
    }
    var sum = 0
    for number in lhs {
        if let occurrences = occurrenceTable[number] {
            sum += number * occurrences
        }
    }
    return sum
}

func sum(input: String) -> Int {
    var (lhs, rhs) = toArray(input)
    lhs.sort()
    rhs.sort()
    var sum: Int = 0
    for (l, r) in zip(lhs, rhs) {
        sum += distances(lhs: l, rhs: r)
    }
    return sum
}
