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

    func comparisonValue(wildCards: Bool) -> Int {
        if wildCards && self == "J" {
            return 1
        }
        return self
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
        let wildCards = if countWildCards {
            cards.filter { $0 == "J" }.count
        } else {
            0
        }

        var dict = cards.reduce(into: [Int: Int]()) { current, next in
            current[next, default: 0] += 1
        }

        let maxRepeatedCard = dict.max { lhs, rhs in
            let (_, valueL) = lhs
            let (_, valueR) = rhs
            return valueL < valueR
        }!

        dict[maxRepeatedCard.key] = maxRepeatedCard.value + wildCards

        var pairs = 0
        var threeOfAKinds = 0
        var fourOfAKinds = 0

        for value in dict.values {
            switch value {
            case 2:
                pairs += 1
            case 3:
                threeOfAKinds += 1
            case 4:
                fourOfAKinds += 1
            case 5, 6:
                return .five
            default:
                continue
            }
        }

        if fourOfAKinds == 1 {
            return .four
        } else if pairs == 1 && threeOfAKinds == 1 {
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

    private static func compare(lhs: Hand, rhs: Hand, wildCards: Bool) -> Bool {
        let lhsStrength = lhs.strength(countWildCards: wildCards).rawValue
        let rhsStrength = rhs.strength(countWildCards: wildCards).rawValue
        if lhsStrength == rhsStrength {
            var i = 0
            while lhs.cards[i].comparisonValue(wildCards: wildCards) == rhs.cards[i].comparisonValue(wildCards: wildCards) && i < 5 {
                i += 1
            }
            return lhs.cards[i].comparisonValue(wildCards: wildCards) < rhs.cards[i].comparisonValue(wildCards: wildCards)
        } else {
            return lhsStrength < rhsStrength
        }
    }

    public static func < (lhs: Hand, rhs: Hand) -> Bool {
        compare(lhs: lhs, rhs: rhs, wildCards: false)
    }

    public static func wildCardLessThan(lhs: Hand, rhs: Hand) -> Bool {
        compare(lhs: lhs, rhs: rhs, wildCards: true)
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

    public static func wildCardLessThan(lhs: Row, rhs: Row) -> Bool {
        Hand.wildCardLessThan(lhs: lhs.hand, rhs: rhs.hand)
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
