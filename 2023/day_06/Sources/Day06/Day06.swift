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

public func accelerationDuration(timeLimit: Int, record: Int) -> Int {
    var accDuration = 0
    var jumpSize = timeLimit + 1
    // prevent an infinite loop
    var iterations = 0

    // a value of 63 is chosen as the iteration limit because the upper limit of Int is 2^63 - 1, and the binary search algo is O(log(N)) where log is base 2
    while iterations < 63 {
        let speed = 1 * accDuration // v = a * t
        let timeRemaining = timeLimit - accDuration
        let distance = timeRemaining * speed

        let previousJumpSize = jumpSize
        jumpSize /= 2
        jumpSize = max(1, jumpSize)
        
        if previousJumpSize == jumpSize {
            accDuration += 1
            break
        } else if distance == record {
            break
        } else if distance > record {
            accDuration -= jumpSize
        } else {
            accDuration += jumpSize
        }

        iterations += 1
    }
    return accDuration
}

public func waysToWin(timeLimit: Int, record: Int) -> Int {
    let accDuration = accelerationDuration(timeLimit: timeLimit, record: record)

    // We add one because the number of trials is equal to the timeLimit plus one. This is because we also count the one when t = timeLimit. This results in an odd number of trials for an even timeLimit.
    return timeLimit + 1 - 2 * accDuration
}

public func parseSingleRace(_ input: String) -> Input {
    let components = input.components(separatedBy: .newlines)
    let times = components[0].replacingOccurrences(of: " ", with: "").components(separatedBy: ":").compactMap(Int.init)
    let distances = components[1].replacingOccurrences(of: " ", with: "").components(separatedBy: ":").compactMap(Int.init)
    return Input(times: times, distances: distances)
}
