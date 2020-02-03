import Foundation

public struct Jargon: Codable, Equatable {
    public let phrase: String

    public static func == (lhs: Jargon, rhs: Jargon) -> Bool {
        return lhs.phrase == rhs.phrase
    }
}
