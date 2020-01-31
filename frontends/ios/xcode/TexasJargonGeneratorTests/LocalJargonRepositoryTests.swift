import Combine
import XCTest

@testable import TexasJargonGenerator

class LocalJargonRepositoryTests: XCTestCase {
    var subscriberSet: Set<AnyCancellable>?

    override func setUp() {
        subscriberSet = []
    }

    func testFetchJargonReturnsJargon() {
        let expectationFinished = expectation(description: "finished")

        let jargonRepository = LocalJargonRepository()

        let subscriber = jargonRepository.fetchJargon()

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
                XCTAssertGreaterThan(actualJargon.phrase.count, 0)
                expectationFinished.fulfill()
            }
        ).store(in: &subscriberSet!)

        wait(for: [expectationFinished], timeout: 3)
    }
}
