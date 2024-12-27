//
//  day19tests.swift
//  aoc2024
//
//  Created by Kevin Peng on 2024-12-26.
//
import Testing
import aoc2024

@Suite("Day19") struct Day19 {

    class Node {
        var children: [Character: Node] = [:]
        var isEnd = false
    }

    func insertIntoTrie(_ root: Node, _ word: [Character]) {
        var node: Node = root
        for char in word {
            if let next = node.children[char] {
                node = next
            } else {
                let newNode = Node()
                node.children[char] = newNode
                node = newNode
            }
        }
        node.isEnd = true
    }

    func makeRoot(_ towels: [[Character]]) -> Node {
        let root = Node()
        for towel in towels {
            insertIntoTrie(root, towel)
        }
        return root
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

    func processLineGemini(_ line: [Character], _ root: Node) -> Bool {
        func recurse(_ line: [Character], _ root: Node, memo: inout [String: Bool]) -> Bool {
            if let result = memo[String(line)] {
                return result
            }

            if line.isEmpty {
                return true
            }

            for i in 1 ... line.count {
                let prefix = line[0 ..< i]
                var currentNode: Node? = root

                for char in prefix {
                    if let next = currentNode?.children[char] {
                        currentNode = next
                    } else {
                        currentNode = nil
                        break
                    }
                }

                if let currentNode, currentNode.isEnd {
                    if recurse(Array(line[i...]), root, memo: &memo) {
                        memo[String(line)] = true
                        return true
                    }
                }
            }

            memo[String(line)] = false
            return false
        }

        var memo: [String: Bool] = [:]
        return recurse(line, root, memo: &memo)
    }

    // Memoization is a critical technique here to avoid redundant calculations,
    // in order to complete processing the input in reasonable time
    func processLine(_ line: [Character], _ root: Node) -> Bool {
        // Use recursion because we are trying to solve a sub problem repeatedly
        func recurse(_ index: Int, _ line: [Character], _ root: Node, _ memo: inout [Int: Bool]) -> Bool {
            if let result = memo[index] {
                return result
            }

            if index >= line.count {
                // return true because we have reached the end of the line
                // otherwise we would have returned false
                return true
            }

            for i in index ... line.count {
                // take different lengths of prefixes from the line
                let prefix = line[index ..< i]
                var currentNode: Node? = root

                // traverse the trie with the prefix
                for char in prefix {
                    // if we found a match, continue traversing
                    if let next = currentNode?.children[char] {
                        currentNode = next
                    } else {
                        // Otherwise, break out of the loop
                        // We set currentNode to nil because this prefix is not in the trie
                        currentNode = nil
                        break
                    }
                }

                // If we found a match and we reached the end of the trie node
                // we coutinue to solve the subproblem with the rest of the line
                if let currentNode, currentNode.isEnd {
                    if recurse(i, line, root, &memo) {
                        memo[index] = true
                        return true
                    }
                }
            }

            memo[index] = false
            return false
        }

        var memo: [Int: Bool] = [:]
        return recurse(0, line, root, &memo)
    }


    @Test func testProcessLine() throws {
        let (towelsArray, designs) = parseTowels(input)
        let towels = makeRoot(towelsArray)
        #expect(processLine(designs[0], towels))
        #expect(processLine(designs[5], towels))
        #expect(processLine(designs[7], towels) == false)
        #expect(processLine(designs[1], towels))
        #expect(processLine(designs[2], towels))
        #expect(processLine(designs[3], towels))
        #expect(processLine(designs[4], towels) == false)
        #expect(processLine(designs[6], towels))
    }

    @Test func part1LongRunning() throws {
        let (towelsArray, _) = parseTowels(try parse(19))
        let towels = makeRoot(towelsArray)
        let design = Array("brbwrrruwrrrubrwuugrbuuwuuwrwrbrrgububwurugbwwrb")
        #expect(processLine(design, towels) == false)
    }

    @Test func part1Special() throws {
        let (towelsArray, _) = parseTowels(try parse(19))
        let towels = makeRoot(towelsArray)
        let design = Array("uwgwguuguruwggwbrbwurruwgwwwurgbgwggwwbbubgugguuurgugugwu")
        #expect(processLine(design, towels) == true)
    }

    @Test func part1Special2() throws {
        let (towelsArray, _) = parseTowels(try parse(19))
        let towels = makeRoot(towelsArray)
        let design = Array("b")
        #expect(processLine(design, towels) == false)
    }

    @Test func part1() throws {
        let (towelsArray, designs) = parseTowels(try parse(19))
        let towels = makeRoot(towelsArray)
        var possibleDesigns = 0
        for design in designs {
            if processLine(design, towels) {
                possibleDesigns += 1
            }
        }
        #expect(possibleDesigns == 278)
    }
}
