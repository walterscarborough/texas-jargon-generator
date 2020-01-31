import XCTest

@testable import TexasJargonGenerator

class JargonViewControllerTests: XCTestCase {
    override func setUp() {}

    func testTappingLocalPhraseButtonDisplaysJargon() {
        let expectedPhrase = "hot dang"

        let stubLocalJargonRepository = StubJargonRepository()
        stubLocalJargonRepository.fetchJargonReturn = Jargon(phrase: expectedPhrase)

        let jargonViewController = JargonViewController(
            remoteJargonRepository: StubJargonRepository(),
            localJargonRepository: stubLocalJargonRepository
        )

        let phraseLabel = jargonViewController.view.viewWithTag(JargonView.Tags.phraseLabel.rawValue) as? UILabel
        XCTAssertNotEqual(phraseLabel?.text, expectedPhrase)

        let phraseButton = jargonViewController.view
            .viewWithTag(JargonView.Tags.localPhraseButton.rawValue) as? UIButton

        phraseButton!.sendActions(for: .touchUpInside)

        DispatchQueue.main.async {
            XCTAssertEqual(phraseLabel?.text, expectedPhrase)
        }
    }

    func testTappingRemotePhraseButtonDisplaysJargon() {
        let expectedPhrase = "hot dang"

        let stubRemoteJargonRepository = StubJargonRepository()
        stubRemoteJargonRepository.fetchJargonReturn = Jargon(phrase: expectedPhrase)

        let jargonViewController = JargonViewController(
            remoteJargonRepository: stubRemoteJargonRepository,
            localJargonRepository: StubJargonRepository()
        )

        let phraseLabel = jargonViewController.view.viewWithTag(JargonView.Tags.phraseLabel.rawValue) as? UILabel
        XCTAssertNotEqual(phraseLabel?.text, expectedPhrase)

        let phraseButton = jargonViewController.view
            .viewWithTag(JargonView.Tags.remotePhraseButton.rawValue) as? UIButton

        phraseButton!.sendActions(for: .touchUpInside)

        DispatchQueue.main.async {
            XCTAssertEqual(phraseLabel?.text, expectedPhrase)
        }
    }
}
