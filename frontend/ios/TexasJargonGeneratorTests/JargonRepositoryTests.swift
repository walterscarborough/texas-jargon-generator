import Combine
import XCTest

@testable import TexasJargonGenerator

class JargonRepositoryTests: XCTestCase {
    var subscriberSet: Set<AnyCancellable>?

    override func setUp() {
        subscriberSet = []
        FakeURLProtocol.resetState()
    }

    func testFetchJargonReturnsExpectedJargon() {
        let expectationFinished = expectation(description: "finished")

        let jargonRepository = JargonRepository()

        let subscriber = jargonRepository.fetchJargon(url: URL(string: "http://localhost:8080/jargon")!)

        subscriber.sink(
            receiveCompletion: { result in
                switch result {
                case .finished: do {
                    break
                }
                case .failure: do {
                    XCTFail()
                }
                }
            }, receiveValue: { actualJargon in
                let expectedJargon = Jargon(
                    phrase: "dang"
                )

                XCTAssertEqual(actualJargon, expectedJargon)
                expectationFinished.fulfill()
            }
        ).store(in: &subscriberSet!)

        wait(for: [expectationFinished], timeout: 3)
    }

    func testFetchJargonReturnsOtherExpectedJargon() {
        let expectationFinished = expectation(description: "finished")

        let expectedJargon = Jargon(phrase: "gosh darn")

        let someURL = URL(string: "http://localhost:8080/someNonexistentEndpoint")!

        // swiftlint:disable force_try
        FakeURLProtocol.testURLs = [someURL: try! JSONEncoder().encode(expectedJargon)]
        // swiftlint:enable force_try

        FakeURLProtocol.response = HTTPURLResponse(
            url: someURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let urlSession = FakeURLProtocol.createURLSession()

        let jargonRepository = JargonRepository(urlSession: urlSession)

        let subscriber = jargonRepository.fetchJargon(url: someURL)

        subscriber.sink(
            receiveCompletion: { result in
                switch result {
                case .finished: do {
                    break
                }
                case .failure: do {
                    XCTFail()
                }
                }
            }, receiveValue: { actualJargon in
                XCTAssertEqual(actualJargon, expectedJargon)
                expectationFinished.fulfill()
            }
        ).store(in: &subscriberSet!)

        wait(for: [expectationFinished], timeout: 3)
    }

    func testFetchJargonFailsForBadHttpStatus() {
        let expectationFinished = expectation(description: "finished")

        let phrase = Jargon(phrase: "gosh darn")

        let someURL = URL(string: "http://localhost:8080/someNonexistentEndpoint")!

        // swiftlint:disable force_try
        FakeURLProtocol.testURLs = [someURL: try! JSONEncoder().encode(phrase)]
        // swiftlint:enable force_try

        FakeURLProtocol.response = HTTPURLResponse(
            url: someURL,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )
        let urlSession = FakeURLProtocol.createURLSession()

        let jargonRepository = JargonRepository(urlSession: urlSession)

        let subscriber = jargonRepository.fetchJargon(url: someURL)

        subscriber.sink(
            receiveCompletion: { result in
                switch result {
                case let .failure(error): do {
                    XCTAssertEqual(error.localizedDescription, HTTPError.non200Response.localizedDescription)
                    expectationFinished.fulfill()
                }
                default: do {
                    XCTFail()
                }
                }
            }, receiveValue: { _ in
                XCTFail()
            }
        ).store(in: &subscriberSet!)

        wait(for: [expectationFinished], timeout: 3)
    }

    func testFetchJargonFailsForBadData() {
        let expectationFinished = expectation(description: "finished")

        let someURL = URL(string: "http://localhost:8080/someNonexistentEndpoint")!
        FakeURLProtocol.testURLs = [someURL: "yolo".data(using: .unicode)!]
        FakeURLProtocol.response = HTTPURLResponse(
            url: someURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let urlSession = FakeURLProtocol.createURLSession()

        let jargonRepository = JargonRepository(urlSession: urlSession)

        let subscriber = jargonRepository.fetchJargon(url: someURL)

        subscriber.sink(
            receiveCompletion: { result in
                switch result {
                case let .failure(error): do {
                    XCTAssertNotNil(error)
                    expectationFinished.fulfill()
                }
                default: do {
                    XCTFail()
                }
                }
            }, receiveValue: { _ in
                XCTFail()
            }
        ).store(in: &subscriberSet!)

        wait(for: [expectationFinished], timeout: 3)
    }
}
