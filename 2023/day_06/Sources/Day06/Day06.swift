import Foundation

public struct Input {
    public let times: [Int]
    public let distances: [Int]

    public init(times: [Int], distances: [Int]) {
        self.times = times
        self.distances = distances
    }
}

public func parse(_ input: String) -> Input {
    let components = input.components(separatedBy: .newlines)
    let times = components[0].components(separatedBy: .whitespaces).compactMap(Int.init)
    let distances = components[1].components(separatedBy: .whitespaces).compactMap(Int.init)
    return Input(times: times, distances: distances)
}

public func allDistances(timeLimit: Int) -> [Int] {
    var distances = [Int](repeating: 0, count: (timeLimit + 1) / 2)
    for accelerationDuration in 0 ..< (timeLimit + 1) / 2 {
        let speed = accelerationDuration
        let timeRemaining = timeLimit - accelerationDuration
        distances[accelerationDuration] = timeRemaining * speed
    }
    return distances
}

public func waysToWin(_ distances: [Int], record: Int) -> Int {
    let count = distances
        .filter { $0 > record }
        .count

    if distances.count.isMultiple(of: 2) {
        return count * 2
    } else {
        return count * 2 + 1
    }
}
