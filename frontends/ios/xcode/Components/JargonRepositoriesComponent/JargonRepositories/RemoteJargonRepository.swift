import Combine
import Foundation

public struct RemoteJargonRepository: JargonRepository {
    let urlSession: URLSession
    let baseUrl: String

    public init(
        urlSession: URLSession = URLSession.shared,
        baseUrl: String = "http://127.0.0.1:8080"
    ) {
        self.urlSession = urlSession
        self.baseUrl = baseUrl
    }

    public func fetchJargon() -> AnyPublisher<Jargon, Error> {
        let url = URL(string: "\(baseUrl)/jargon")!
        return urlSession.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw HTTPError.non200Response
                }

                return data
            }
            .decode(type: Jargon.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
