import XCTest

@testable import TexasJargonGenerator

class JargonViewControllerTests: XCTestCase {
    override func setUp() {}

    func testTappingPhraseButtonDisplaysJargon() {
        let expectedPhrase = "hot dang"

        let stubJargonRepository = StubJargonRepository()
        stubJargonRepository.fetchJargonReturn = Jargon(phrase: expectedPhrase)

        let jargonViewController = JargonViewController(jargonRepository: stubJargonRepository)

        let phraseLabel = jargonViewController.view.viewWithTag(JargonView.Tags.phraseLabel) as? UILabel
        XCTAssertNotEqual(phraseLabel?.text, expectedPhrase)

        let phraseButton = jargonViewController.view.viewWithTag(JargonView.Tags.phraseButton) as? UIButton

        phraseButton!.sendActions(for: .touchUpInside)

        DispatchQueue.main.async {
            XCTAssertEqual(phraseLabel?.text, expectedPhrase)
        }
    }
}
