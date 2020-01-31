@testable import RandomJargon
import XCTest

class RandomJargonTests: XCTestCase {
    func testRandomJargonGeneratorGeneratesPhrases() {
        var phrases: Set<String> = []

        for _ in 0 ... 1000 {
            let phrase = RandomJargonGenerator.generatePhrase()
            phrases.insert(phrase!)
        }

        XCTAssertGreaterThan(phrases.count, 1)
    }
}
