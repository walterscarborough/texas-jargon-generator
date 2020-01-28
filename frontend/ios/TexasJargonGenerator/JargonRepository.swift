import Combine
import Foundation

struct JargonRepository {
    let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchJargon(url: URL = URL(string: "http://127.0.0.1:8080/jargon")!) -> AnyPublisher<Jargon, Error> {
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
