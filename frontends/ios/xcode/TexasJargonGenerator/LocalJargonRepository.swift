import Combine
import Foundation
import RandomJargon

class LocalJargonRepository: JargonRepository {
    func fetchJargon() -> AnyPublisher<Jargon, Error> {
        return Future<Jargon, Error> { promise in
            let randomPhrase = RandomJargonGenerator.generatePhrase()

            let randomJargon = Jargon(phrase: randomPhrase!)

            promise(.success(randomJargon))
        }
        .eraseToAnyPublisher()
    }
}
