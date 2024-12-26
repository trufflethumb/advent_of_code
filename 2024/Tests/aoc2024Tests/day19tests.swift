//
//  day19tests.swift
//  aoc2024
//
//  Created by Kevin Peng on 2024-12-26.
//
import Testing
import aoc2024

@Suite("Day19") struct Day19 {

    class Node: Hashable, CustomStringConvertible, CustomDebugStringConvertible {
        static func == (lhs: Day19.Node, rhs: Day19.Node) -> Bool {
            lhs.value == rhs.value
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }

        var value: Character
        var children: Set<Node> = []

        init(value: Character) {
            self.value = value
        }

        func child(_ value: Character) -> Node? {
            children.first { node in
                node.value == value
            }
        }

        var isEnd: Bool {
            value == "."
        }

        var isLast: Bool {
            children.contains(Node(value: "."))
        }

        var description: String {
            String(value)
        }

        var debugDescription: String {
            description
        }
    }

    func treeString(_ node: Node, prefix: String = "") -> String {
        // Start with the current node's description
        var result = "\(prefix)\(node.description)\n"

        // Recur for each child, adding to the result
        for child in node.children {
            result += treeString(child, prefix: prefix + "   ")
        }
        return result
    }

    func makeDict(_ towels: [[Character]]) -> Node {
        let head = Node(value: "?")

        for towel in towels {
            var node: Node? = head
            for i in 0 ..< towel.count {
                node?.children.insert(Node(value: towel[i]))
                node = node?.child(towel[i])
            }
            node?.children.insert(Node(value: "."))
        }

        return head
    }

    func parseTowels(_ input: String) -> (towels: [[Character]], designs: [[Character]]) {
        let lines = input.components(separatedBy: .newlines)
        let towels = lines[0].components(separatedBy: ", ").map(Array.init)
        let designs = lines.dropFirst(2).map(Array.init)
        return (towels, designs)
    }

    let input = """
    r, wr, b, g, bwu, rb, gb, br
    
    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb
    """

    @Test func testParse() {
        let (towels, _) = parseTowels(input)
        let joined = String(towels.joined(separator: ", "))
        #expect(joined == "r, wr, b, g, bwu, rb, gb, br")
    }

    @Test func testMakeDict() {
        let (towels, _) = parseTowels(input)
        let towelDict = makeDict(towels)
        print(treeString(towelDict))
    }

    func processLine(_ line: [Character], _ towels: [[Character]]) -> Bool {
        var ref = [[Int]]()
        for i in 0 ..< line.count {
            var inner = [Int]()
            for towel in towels {
                var count = 0
                for k in 0 ..< towel.count where i + k < line.count {
                    if towel[k] == line[i + k] {
                        count += 1
                    } else {
                        break
                    }
                }
                if count == towel.count {
                    inner.append(count)
                }
            }
            ref.append(inner)
        }

        var i = 0
        var checking = 1
        while i < line.count, i >= 0, checking < line.count {
            if ref[i].contains(checking) {
                i += checking
                checking = 1
            } else if ref[i].isEmpty {
                i = max(0, i - 1)
                checking += 1
            } else {
                checking += 1
            }
        }

        return i == line.count
    }

    @Test func testProcessLine() throws {
        let (towels, designs) = parseTowels(input)
        #expect(processLine(designs[0], towels))
        #expect(processLine(designs[5], towels))
        #expect(processLine(designs[7], towels) == false)
        #expect(processLine(designs[1], towels))
        #expect(processLine(designs[2], towels))
        #expect(processLine(designs[3], towels))
        #expect(processLine(designs[4], towels) == false)
        #expect(processLine(designs[6], towels))
    }

    @Test func part1Special2() throws {
        let (towels, _) = parseTowels(try parse(19))
        let design = Array("b")
        #expect(processLine(design, towels) == false)
    }

    @Test func part1() throws {
        let (towels, designs) = parseTowels(try parse(19))
        var possibleDesigns = 0
        for design in designs {
            if processLine(design, towels) {
                possibleDesigns += 1
            }
        }
        //        print(possibleDesigns)
        #expect(possibleDesigns > 275)
        #expect(possibleDesigns < 400)
    }
}
