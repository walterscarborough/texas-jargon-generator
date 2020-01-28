import Foundation

struct Jargon: Decodable, Equatable {
    let phrase: String

    static func == (lhs: Jargon, rhs: Jargon) -> Bool {
        return lhs.phrase == rhs.phrase
    }
}
