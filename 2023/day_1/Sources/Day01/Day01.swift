import Foundation

public class TrieNode: CustomStringConvertible {

    public init(value: Character) {
        self.value = value
    }

    public init(string: String) {
        let array = Array(string)
        self.value = array[0]
        add(Array(array.dropFirst()))
    }

    let value: Character
    public var children = [TrieNode]()

    public func add(string: String) {
        add(Array(string))
    }

    private func add(_ array: [Character]) {
        guard let first = array.first else { return }
        for child in children {
            if child.value == first {
                child.add(Array(array.dropFirst()))
                return
            }
        }
        let newChild = TrieNode(value: first)
        children.append(newChild)
        add(array)
    }

    public func contains(string: String) -> Bool {
        contains(array: Array(string))
    }

    public func contains(array: [Character]) -> Bool {
        guard !array.isEmpty else { return true }
        guard array[0] == value else { return false }

        let next = array.dropFirst()

        guard !next.isEmpty else { return true }

        for child in children {
            if child.contains(Array(next)) {
                return true
            }
        }
        return false
    }

    public var description: String {
        String(value) + children.map(\.description).joined()
    }
}

public struct NumbersTrie {

    public static let speltOut = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    public static let tries: [Character: TrieNode] = {
        var dict = [Character: TrieNode]()
        for string in speltOut {
            let char = string[string.startIndex]
            let value = dict[char, default: TrieNode(value: char)]
            dict[char] = value
            value.add(string: String(string.dropFirst()))
        }
        return dict
    }()

    public static func contains(_ input: [Character]) -> Bool {
        let char = input[input.startIndex]
        return tries[char]?.contains(array: input) ?? false
    }

    public static func contains(_ input: String) -> Bool {
        let char = input[input.startIndex]
        return tries[char]?.contains(string: input) ?? false
    }

}

public func getCalibration(_ input: String) -> Int {
    let input = Array(input)
    var l = 0
    var r = 0

    while l < input.count - 1 && r < input.count - 1 {
        r += 3
        let result = Array(input[l...r])
        while NumbersTrie.contains(result) {
            r += 1
        }
    }

    var lhs: Int!
    var rhs: Int!
    for c in input {
        if c.isNumber {
            lhs = Int(String(c))!
            break
        }
    }
    for c in input.reversed() {
        if c.isNumber {
            rhs = Int(String(c))!
            break
        }
    }
    return lhs * 10 + rhs
}


public func sumCalibrationDocumentValues(_ input: String) -> Int {
    input
        .components(separatedBy: .newlines)
        .map(getCalibration)
        .reduce(0, +)
}
