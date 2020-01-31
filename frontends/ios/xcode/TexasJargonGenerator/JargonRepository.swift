import Combine
import Foundation

protocol JargonRepository {
    func fetchJargon() -> AnyPublisher<Jargon, Error>
}
