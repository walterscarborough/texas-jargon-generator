import Combine
import Foundation
import RandomJargon

public class LocalJargonRepository: JargonRepository {
    public init() {}

    public func fetchJargon() -> AnyPublisher<Jargon, Error> {
        return Future<Jargon, Error> { promise in
            let randomPhrase = RandomJargonGenerator.generatePhrase()

            let randomJargon = Jargon(phrase: randomPhrase!)

            promise(.success(randomJargon))
        }
        .eraseToAnyPublisher()
    }
}
