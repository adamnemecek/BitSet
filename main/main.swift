//
//  main.swift
//  main
//
//  Created by Adam Nemecek on 11/27/17.
//

import Foundation

let a: BitSet<UInt16> = [1,2,3,4, 10, 16]

print(a)
for e in a {
    print(e)
}


//public struct PitchSet: SetAlgebra, Collection, ExpressibleByArrayLiteral, CustomStringConvertible, Hashable {
//    public struct Index : Comparable {
//        fileprivate let value : Int
//
//        fileprivate init(_ value : Int) {
//            self.value = value
//        }
//
//        public static func ==(lhs: Index, rhs: Index) -> Bool {
//            return lhs.value == rhs.value
//        }
//
//        public static func <(lhs: Index, rhs: Index) -> Bool {
//            return lhs.value < rhs.value
//        }
//    }
//
//    public typealias Element = PC
//    public typealias IndexDistance = Int
//    private typealias Base = UInt16
//    private var content : Base
//
//    public init() {
//        content = 0
//    }
//
//    private init(content : Base) {
//        self.content = content
//    }
//
//    public var inverted : PitchSet {
//        let shift = Base.bitWidth - 12
//        let c = ((Base.max ^ content) << shift) >> shift
//        return PitchSet(content : c)
//    }
//
//
//    public init(arrayLiteral literal: Element...) {
//        content = literal.reduce(0) { $0 | (1 << $1.rawValue) }
//    }
//
//    public var hashValue: Int {
//        return content.hashValue
//    }
//
//    public var startIndex: Index {
//        /// we need to modulo by 32 because in the case where there are 0 elements,
//        /// we want a 0, not 32
//        return .init(content.trailingZeroBitCount % Base.bitWidth)
//    }
//
//    public var description: String {
//        return "PitchSet(\(map { $0.description }.joined(separator: ", ")))"
//    }
//
//    public var endIndex : Index {
//        let e = Base.bitWidth - content.leadingZeroBitCount
//        return .init(e)
//    }
//
//    public var count : IndexDistance {
//        return content.nonzeroBitCount
//    }
//
//    public subscript(index : Index) -> Element {
//        return Element(rawValue : UInt8(index.value))!
//    }
//
//    public func index(after i: Index) -> Index {
//
//        let j = i.value + 1
//        let mask  = (content >> j) << j
//
//        let n = content & mask
//        if n == 0 {
//            return endIndex
//        }
//        return .init(n.trailingZeroBitCount)
//    }
//
//    public var isEmpty: Bool {
//        return content == 0
//    }
//    /// Removes the elements of the set that are also in the given set and adds
//    /// the members of the given set that are not already in the set.
//    ///
//    /// In the following example, the elements of the `employees` set that are
//    /// also members of `neighbors` are removed from `employees`, while the
//    /// elements of `neighbors` that are not members of `employees` are added to
//    /// `employees`. In particular, the names `"Alicia"`, `"Chris"`, and
//    /// `"Diana"` are removed from `employees` while the names `"Forlani"` and
//    /// `"Greta"` are added.
//    ///
//    ///     var employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
//    ///     let neighbors: Set = ["Bethany", "Eric", "Forlani", "Greta"]
//    ///     employees.formSymmetricDifference(neighbors)
//    ///     print(employees)
//    ///     // Prints "["Diana", "Chris", "Forlani", "Alicia", "Greta"]"
//    ///
//    /// - Parameter other: A set of the same type.
//    public mutating func formSymmetricDifference(_ other: PitchSet) {
//        self = symmetricDifference(other)
//    }
//
//    /// Removes the elements of this set that aren't also in the given set.
//    ///
//    /// In the following example, the elements of the `employees` set that are
//    /// not also members of the `neighbors` set are removed. In particular, the
//    /// names `"Alicia"`, `"Chris"`, and `"Diana"` are removed.
//    ///
//    ///     var employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
//    ///     let neighbors: Set = ["Bethany", "Eric", "Forlani", "Greta"]
//    ///     employees.formIntersection(neighbors)
//    ///     print(employees)
//    ///     // Prints "["Bethany", "Eric"]"
//    ///
//    /// - Parameter other: A set of the same type as the current set.
//    public mutating func formIntersection(_ other: PitchSet) {
//        self = intersection(other)
//    }
//
//    /// Adds the elements of the given set to the set.
//    ///
//    /// In the following example, the elements of the `visitors` set are added to
//    /// the `attendees` set:
//    ///
//    ///     var attendees: Set = ["Alicia", "Bethany", "Diana"]
//    ///     let visitors: Set = ["Marcia", "Nathaniel"]
//    ///     attendees.formUnion(visitors)
//    ///     print(attendees)
//    ///     // Prints "["Diana", "Nathaniel", "Bethany", "Alicia", "Marcia"]"
//    ///
//    /// If the set already contains one or more elements that are also in
//    /// `other`, the existing members are kept.
//    ///
//    ///     var initialIndices = Set(0..<5)
//    ///     initialIndices.formUnion([2, 3, 6, 7])
//    ///     print(initialIndices)
//    ///     // Prints "[2, 4, 6, 7, 0, 1, 3]"
//    ///
//    /// - Parameter other: A set of the same type as the current set.
//    public mutating func formUnion(_ other: PitchSet) {
//        self = union(other)
//    }
//
//    /// Inserts the given element into the set unconditionally.
//    ///
//    /// If an element equal to `newMember` is already contained in the set,
//    /// `newMember` replaces the existing element. In this example, an existing
//    /// element is inserted into `classDays`, a set of days of the week.
//    ///
//    ///     enum DayOfTheWeek: Int {
//    ///         case sunday, monday, tuesday, wednesday, thursday,
//    ///             friday, saturday
//    ///     }
//    ///
//    ///     var classDays: Set<DayOfTheWeek> = [.monday, .wednesday, .friday]
//    ///     print(classDays.update(with: .monday))
//    ///     // Prints "Optional(.monday)"
//    ///
//    /// - Parameter newMember: An element to insert into the set.
//    /// - Returns: For ordinary sets, an element equal to `newMember` if the set
//    ///   already contained such a member; otherwise, `nil`. In some cases, the
//    ///   returned element may be distinguishable from `newMember` by identity
//    ///   comparison or some other means.
//    ///
//    ///   For sets where the set type and element type are the same, like
//    ///   `OptionSet` types, this method returns any intersection between the
//    ///   set and `[newMember]`, or `nil` if the intersection is empty.
//    @discardableResult
//    public mutating func update(with newMember: Element) -> Element? {
//        if insert(newMember).inserted {
//            return newMember
//        }
//        return nil
//    }
//
//    /// Removes the given element and any elements subsumed by the given element.
//    ///
//    /// - Parameter member: The element of the set to remove.
//    /// - Returns: For ordinary sets, an element equal to `member` if `member` is
//    ///   contained in the set; otherwise, `nil`. In some cases, a returned
//    ///   element may be distinguishable from `newMember` by identity comparison
//    ///   or some other means.
//    ///
//    ///   For sets where the set type and element type are the same, like
//    ///   `OptionSet` types, this method returns any intersection between the set
//    ///   and `[member]`, or `nil` if the intersection is empty.
//    @discardableResult
//    public mutating func remove(_ member: Element) -> Element? {
//        let contains = self.contains(member)
//        content &= ~(1 << member.rawValue)
//        if contains {
//            return member
//        }
//        return nil
//    }
//
//    /// Inserts the given element in the set if it is not already present.
//    ///
//    /// If an element equal to `newMember` is already contained in the set, this
//    /// method has no effect. In this example, a new element is inserted into
//    /// `classDays`, a set of days of the week. When an existing element is
//    /// inserted, the `classDays` set does not change.
//    ///
//    ///     enum DayOfTheWeek: Int {
//    ///         case sunday, monday, tuesday, wednesday, thursday,
//    ///             friday, saturday
//    ///     }
//    ///
//    ///     var classDays: Set<DayOfTheWeek> = [.wednesday, .friday]
//    ///     print(classDays.insert(.monday))
//    ///     // Prints "(true, .monday)"
//    ///     print(classDays)
//    ///     // Prints "[.friday, .wednesday, .monday]"
//    ///
//    ///     print(classDays.insert(.friday))
//    ///     // Prints "(false, .friday)"
//    ///     print(classDays)
//    ///     // Prints "[.friday, .wednesday, .monday]"
//    ///
//    /// - Parameter newMember: An element to insert into the set.
//    /// - Returns: `(true, newMember)` if `newMember` was not contained in the
//    ///   set. If an element equal to `newMember` was already contained in the
//    ///   set, the method returns `(false, oldMember)`, where `oldMember` is the
//    ///   element that was equal to `newMember`. In some cases, `oldMember` may
//    ///   be distinguishable from `newMember` by identity comparison or some
//    ///   other means.
//    @discardableResult
//    public mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element) {
//        let contains = self.contains(newMember)
//        content |= Base(newMember.rawValue)
//        return (contains, newMember)
//    }
//
//    /// Returns a new set with the elements that are either in this set or in the
//    /// given set, but not in both.
//    ///
//    /// In the following example, the `eitherNeighborsOrEmployees` set is made up
//    /// of the elements of the `employees` and `neighbors` sets that are not in
//    /// both `employees` *and* `neighbors`. In particular, the names `"Bethany"`
//    /// and `"Eric"` do not appear in `eitherNeighborsOrEmployees`.
//    ///
//    ///     let employees: Set = ["Alicia", "Bethany", "Diana", "Eric"]
//    ///     let neighbors: Set = ["Bethany", "Eric", "Forlani"]
//    ///     let eitherNeighborsOrEmployees = employees.symmetricDifference(neighbors)
//    ///     print(eitherNeighborsOrEmployees)
//    ///     // Prints "["Diana", "Forlani", "Alicia"]"
//    ///
//    /// - Parameter other: A set of the same type as the current set.
//    /// - Returns: A new set.
//    public func symmetricDifference(_ other: PitchSet) -> PitchSet {
//        return .init(content : content ^ other.content)
//    }
//
//    /// Returns a new set with the elements that are common to both this set and
//    /// the given set.
//    ///
//    /// In the following example, the `bothNeighborsAndEmployees` set is    made up
//    /// of the elements that are in *both* the `employees` and `neighbors` sets.
//    /// Elements that are in either one or the other, but not both, are left out
//    /// of the result of the intersection.
//    ///
//    ///     let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
//    ///     let neighbors: Set = ["Bethany", "Eric", "Forlani", "Greta"]
//    ///     let bothNeighborsAndEmployees = employees.intersection(neighbors)
//    ///     print(bothNeighborsAndEmployees)
//    ///     // Prints "["Bethany", "Eric"]"
//    ///
//    /// - Parameter other: A set of the same type as the current set.
//    /// - Returns: A new set.
//    ///
//    /// - Note: if this set and `other` contain elements that are equal but
//    ///   distinguishable (e.g. via `===`), which of these elements is present
//    ///   in the result is unspecified.
//    public func intersection(_ other: PitchSet) -> PitchSet {
//        return .init(content : content & other.content)
//    }
//
//    /// Returns a new set with the elements of both this and the given set.
//    ///
//    /// In the following example, the `attendeesAndVisitors` set is made up
//    /// of the elements of the `attendees` and `visitors` sets:
//    ///
//    ///     let attendees: Set = ["Alicia", "Bethany", "Diana"]
//    ///     let visitors = ["Marcia", "Nathaniel"]
//    ///     let attendeesAndVisitors = attendees.union(visitors)
//    ///     print(attendeesAndVisitors)
//    ///     // Prints "["Diana", "Nathaniel", "Bethany", "Alicia", "Marcia"]"
//    ///
//    /// If the set already contains one or more elements that are also in
//    /// `other`, the existing members are kept.
//    ///
//    ///     let initialIndices = Set(0..<5)
//    ///     let expandedIndices = initialIndices.union([2, 3, 6, 7])
//    ///     print(expandedIndices)
//    ///     // Prints "[2, 4, 6, 7, 0, 1, 3]"
//    ///
//    /// - Parameter other: A set of the same type as the current set.
//    /// - Returns: A new set with the unique elements of this set and `other`.
//    ///
//    /// - Note: if this set and `other` contain elements that are equal but
//    ///   distinguishable (e.g. via `===`), which of these elements is present
//    ///   in the result is unspecified.
//    public func union(_ other: PitchSet) -> PitchSet {
//        return .init(content : content | other.content)
//    }
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func ==(lhs: PitchSet, rhs: PitchSet) -> Bool {
//        return lhs.content == rhs.content
//    }
//
//    public func contains(_ member: Element) -> Bool {
//        return (content & Base(member.rawValue)) != 0
//    }
//
//}

