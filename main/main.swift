//
//  main.swift
//  main
//
//  Created by Adam Nemecek on 11/27/17.
//

import Foundation

//let a: BitSet<UInt32> = [1,2,3,4, 10, 31]
//
//print(a)
//print(a.count, a.startIndex, a.endIndex)
//for e in a {
//    print(e)
//}

//print(a)
let b: BitSet<UInt64> = [1,2,3,4, 30]


//for e in b {
//    print(e)
//}

public enum PC : UInt16 {
    case one
}

extension RawRepresentable {

}

public struct PitchSet: SetAlgebra, Collection, ExpressibleByArrayLiteral, CustomStringConvertible, Hashable {

    public typealias Base = UInt16
    public typealias Element = PC
    public typealias Index = BitSet<Base>.Index

    private var content : BitSet<Base>

    public init() {
        content = []
    }

    fileprivate init(content: BitSet<Base>) {
        self.content = content
    }

    public init(arrayLiteral literal: Element...) {
        content = .init(literal.map { $0.rawValue })
    }

    public var hashValue: Int {
        return content.hashValue
    }

    public var startIndex: Index {
        /// we need to modulo by 32 because in the case where there are 0 elements,
        /// we want a 0, not 32
        return content.startIndex
    }

    public var description: String {
        return content.description
    }

    public var endIndex : Index {
        return content.endIndex
    }

    public var count : IndexDistance {
        return content.count
    }

    public subscript(index : Index) -> Element {
        return Element(rawValue: content[index])!
    }

    public func index(after i: Index) -> Index {
        return content.index(after: i)
    }

    public var isEmpty: Bool {
        return content.isEmpty
    }
 
    public mutating func formSymmetricDifference(_ other: PitchSet) {
        self = symmetricDifference(other)
    }


    public mutating func formIntersection(_ other: PitchSet) {
        self = intersection(other)
    }

    public mutating func formUnion(_ other: PitchSet) {
        self = union(other)
    }

    @discardableResult
    public mutating func update(with newMember: Element) -> Element? {
        return content.update(with: newMember.rawValue).map { _ in newMember }
    }

    @discardableResult
    public mutating func remove(_ member: Element) -> Element? {
        return content.remove(member.rawValue).map { _ in member }
    }

    @discardableResult
    public mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element) {
        return (content.insert(newMember.rawValue).inserted, newMember)
    }

    public func symmetricDifference(_ other: PitchSet) -> PitchSet {
        return PitchSet(content: content.symmetricDifference(other.content))
    }

    public func intersection(_ other: PitchSet) -> PitchSet {
        return PitchSet(content: content.intersection(other.content))
    }

    public func union(_ other: PitchSet) -> PitchSet {
        return PitchSet(content: content.union(other.content))
    }

    public static func ==(lhs: PitchSet, rhs: PitchSet) -> Bool {
        return lhs.content == rhs.content
    }

    public func contains(_ member: Element) -> Bool {
        return content.contains(member.rawValue)
    }
}

