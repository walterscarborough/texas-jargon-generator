import Combine
import Foundation

struct JargonRepository {
    let urlSession: URLSession

    func fetchJargon() -> AnyPublisher<Jargon, Error> {
        return urlSession.dataTaskPublisher(for: URL(string: "http://127.0.0.1:8080/jargon")!)
            .tryMap { output in
                return output.data
            }
            .decode(type: Jargon.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
