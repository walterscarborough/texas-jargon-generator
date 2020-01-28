import Combine
import XCTest

@testable import TexasJargonGenerator

class JargonRepositoryTest: XCTestCase {
    func testFetchJargonReturnsExpectedJargon() {
        let expectationFinished = expectation(description: "finished")

        let urlSession = URLSession.shared

        let jargonRepository = JargonRepository(urlSession: urlSession)

        let expectedJargon = Jargon(
            phrase: "dang"
        )

        let cancellable = jargonRepository.fetchJargon()

        var cancellableSet: Set<AnyCancellable> = []
        cancellable.sink(
            receiveCompletion: { error in
                XCTFail("error is: \(error)")
            }, receiveValue: { actualJargon in
                XCTAssertEqual(actualJargon, expectedJargon)
                expectationFinished.fulfill()
            }
        ).store(in: &cancellableSet)

        wait(for: [expectationFinished], timeout: 3)
    }
}
