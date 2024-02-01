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

public func waysToWin(timeLimit: Int, record: Int) -> Int {
    var minWin = 0

    for accelerationDuration in 1 ... (timeLimit + 1) / 2 {
        let speed = accelerationDuration
        let timeRemaining = timeLimit - accelerationDuration
        let distance = timeRemaining * speed
        if distance > record {
            minWin = accelerationDuration
            break
        }
    }

    // We add one because the number of trials is equal to the timeLimit plus one. This is because we also count the one when t = timeLimit. This results in an odd number of trials for an even timeLimit.
    return timeLimit + 1 - 2 * minWin
}

public func parseSingleRace(_ input: String) -> Input {
    let components = input.components(separatedBy: .newlines)
    let times = components[0].replacingOccurrences(of: " ", with: "").components(separatedBy: ":").compactMap(Int.init)
    let distances = components[1].replacingOccurrences(of: " ", with: "").components(separatedBy: ":").compactMap(Int.init)
    return Input(times: times, distances: distances)
}
