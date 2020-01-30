import Combine
import Foundation
@testable import TexasJargonGenerator

class StubJargonRepository: JargonRepository {
    var fetchJargonReturn: Jargon?

    func fetchJargon() -> AnyPublisher<Jargon, Error> {
        return Future<Jargon, Error> { promise in
            promise(.success(self.fetchJargonReturn!))
        }
        .eraseToAnyPublisher()
    }
}
