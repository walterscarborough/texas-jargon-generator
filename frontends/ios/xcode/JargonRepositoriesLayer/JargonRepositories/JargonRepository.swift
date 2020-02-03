import Combine
import Foundation

public protocol JargonRepository {
    func fetchJargon() -> AnyPublisher<Jargon, Error>
}
