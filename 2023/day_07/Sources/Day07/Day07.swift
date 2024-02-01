import Foundation

extension Int: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard value.count == 1 else {
            fatalError("Invalid input")
        }

        switch value {
        case "A":
            self = 14
        case "K":
            self = 13
        case "Q":
            self = 12
        case "J":
            self = 11
        case "T":
            self = 10
        default:
            if let parsed = Int(value) {
                self = parsed
                return
            }
            fatalError("Invalid input")
        }
    }
}

public struct Hand: ExpressibleByArrayLiteral, Equatable {
    let cards: [Int]

    public init(arrayLiteral elements: Int...) {
        guard elements.count == 5 else {
            fatalError("Invalid input")
        }
        cards = elements
    }

    init(_ cards: [Int]) {
        self.cards = cards
    }

    public func strength(countWildCards: Bool = false) -> Strength {
        let dict = cards.reduce(into: [Int: Int]()) { current, next in
            current[next, default: 0] += 1
        }
        var pairs = 0
        var threeOfAKinds = 0
        var wildCards = 0

        for (key, value) in dict {
            if countWildCards && key == "J" {
                wildCards = value
                continue
            }
            switch value {
            case 2:
                pairs += 1
            case 3:
                threeOfAKinds += 1
            case 4:
                return .four
            case 5:
                return .five
            default:
                continue
            }
        }

        switch wildCards {
        case 5, 4:
            return .five
        case 3:
            if pairs == 1 {
                return .five
            }
            return .four
        case 2:
            if pairs == 1 {
                return .four
            } else if threeOfAKinds == 1 {
                return .five
            }
            return .three
        case 1:
            if pairs == 2 {
                return .fullHouse
            } else if pairs == 1 {
                return .three
            } else if threeOfAKinds == 1 {
                return .four
            }
        default:
            break
        }

        if pairs == 1 && threeOfAKinds == 1 {
            return .fullHouse
        } else if threeOfAKinds == 1 {
            return .three
        } else if pairs == 2 {
            return .twoPairs
        } else if pairs == 1 {
            return .onePair
        } else {
            return .high
        }
    }
}

extension Hand: Comparable {

    private static func compare(lhs: Hand, rhs: Hand, getter: (Hand) -> Strength) -> Bool {
        if getter(lhs).rawValue == getter(rhs).rawValue {
            var i = 0
            while lhs.cards[i] == rhs.cards[i] && i < 5 {
                i += 1
            }
            return lhs.cards[i] < rhs.cards[i]
        } else {
            return getter(lhs).rawValue < getter(rhs).rawValue
        }
    }

    public static func < (lhs: Hand, rhs: Hand) -> Bool {
        compare(lhs: lhs, rhs: rhs, getter: { $0.strength() })
    }

    public static func wildCardLessThan(lhs: Hand, rhs: Hand) -> Bool {
        compare(lhs: lhs, rhs: rhs, getter: { $0.strength(countWildCards: true) })
    }
}

public enum Strength: Int {
    case high
    case onePair
    case twoPairs
    case three
    case fullHouse
    case four
    case five
}


public struct Row: Comparable {
    public let hand: Hand
    public let bid: Int

    public static func < (lhs: Row, rhs: Row) -> Bool {
        lhs.hand < rhs.hand
    }
}

public struct PartOneInput {
    public let rows: [Row]
}

public func parsePartOne(_ input: String) -> PartOneInput {
    let components = input.components(separatedBy: .newlines)
    let rows = components
        .filter { !$0.isEmpty }
        .map { line in
            let parts = line.components(separatedBy: .whitespaces)
            let cards = parts[0].map(String.init).map(Int.init)
            let hand = Hand(cards)
            let bid = Int(parts[1])!
            return (hand, bid)
        }
        .map(Row.init)

    return PartOneInput(rows: rows)
}
