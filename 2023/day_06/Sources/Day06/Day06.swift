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

    for accelerationDuration in 0 ..< (timeLimit + 1) / 2 {
        let speed = accelerationDuration
        let timeRemaining = timeLimit - accelerationDuration
        let distance = timeRemaining * speed
        if distance > record {
            minWin = accelerationDuration
            break
        }
    }

    let symmetricCount = ((timeLimit + 1) / 2 - minWin) * 2

    // We add one when timeLimit is even because
    // the number of trials is equal to the timeLimit
    // plus one. This is because we also count the one
    // when t = timeLimit. This results in an odd number
    // of trials for an even timeLimit.
    if timeLimit.isMultiple(of: 2) {
        return symmetricCount + 1
    } else {
        return symmetricCount
    }
}

public func parseSingleRace(_ input: String) -> Input {
    let components = input.components(separatedBy: .newlines)
    let times = components[0].replacingOccurrences(of: " ", with: "").components(separatedBy: ":").compactMap(Int.init)
    let distances = components[1].replacingOccurrences(of: " ", with: "").components(separatedBy: ":").compactMap(Int.init)
    return Input(times: times, distances: distances)
}
