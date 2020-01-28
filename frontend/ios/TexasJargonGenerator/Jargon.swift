import Foundation

struct Jargon: Codable, Equatable {
    let phrase: String

    static func == (lhs: Jargon, rhs: Jargon) -> Bool {
        return lhs.phrase == rhs.phrase
    }
}
