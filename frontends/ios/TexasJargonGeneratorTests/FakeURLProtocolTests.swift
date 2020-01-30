import Combine
import Foundation
import XCTest

class FakeURLProtocolTests: XCTestCase {
    var subscriberSet: Set<AnyCancellable>?

    override func setUp() {
        subscriberSet = []
        FakeURLProtocol.resetState()
    }

    private enum HTTPError: Error {
        case unexpectedStatus
    }

    func testFakeURLProtocolCanSetResponseStatus() {
        let expectationFinished = expectation(description: "finished")

        let someURL = URL(string: "http://localhost:8080/someNonexistentEndpoint")!
        FakeURLProtocol.testURLs = [someURL: "my fancy message".data(using: .unicode)!]
        FakeURLProtocol.response = HTTPURLResponse(
            url: someURL,
            statusCode: 123,
            httpVersion: nil,
            headerFields: nil
        )
        let urlSession = FakeURLProtocol.createURLSession()

        urlSession.dataTaskPublisher(for: someURL)
            .tryMap { data, response -> Data in

                let httpResponse = response as? HTTPURLResponse

                XCTAssertEqual(httpResponse!.statusCode, 123)

                return data
            }
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished: do {
                        break
                    }
                    case .failure: do {
                        XCTFail()
                    }
                    }
                }, receiveValue: { _ in
                    expectationFinished.fulfill()
                }
            ).store(in: &subscriberSet!)

        wait(for: [expectationFinished], timeout: 3)
    }

    func testFakeURLProtocolCanSetResponseDataByURL() {
        let expectationFinished = expectation(description: "finished")

        let someURL = URL(string: "http://localhost:8080/someNonexistentEndpoint")!
        let someOtherURL = URL(string: "http://localhost:7000/someOtherNonexistentEndpoint")!
        FakeURLProtocol.testURLs = [
            someURL: "my fancy message".data(using: .utf8)!,
            someOtherURL: "my other fancy message".data(using: .utf8)!,
        ]
        FakeURLProtocol.response = HTTPURLResponse(
            url: someURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let urlSession = FakeURLProtocol.createURLSession()

        urlSession.dataTaskPublisher(for: someURL)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished: do {
                        break
                    }
                    case .failure: do {
                        XCTFail()
                    }
                    }
                }, receiveValue: { data, _ in
                    XCTAssertEqual(String(decoding: data, as: UTF8.self), "my fancy message")

                    expectationFinished.fulfill()
                }
            ).store(in: &subscriberSet!)

        wait(for: [expectationFinished], timeout: 3)
    }

    func testFakeURLProtocolCanSetResponseErrors() {
        let expectationFinished = expectation(description: "finished")

        let someURL = URL(string: "http://localhost:8080/someNonexistentEndpoint")!
        FakeURLProtocol.testURLs = [someURL: "my fancy message".data(using: .utf8)!]
        FakeURLProtocol.response = HTTPURLResponse(
            url: someURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        FakeURLProtocol.error = HTTPError.unexpectedStatus

        let urlSession = FakeURLProtocol.createURLSession()

        urlSession.dataTaskPublisher(for: someURL)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished: do {
                        XCTFail()
                    }
                    case let .failure(httpError): do {
                        XCTAssertNotNil(httpError)
                        expectationFinished.fulfill()
                    }
                    }
                }, receiveValue: { _, _ in
                    XCTFail()
                }
            ).store(in: &subscriberSet!)

        wait(for: [expectationFinished], timeout: 3)
    }
}
