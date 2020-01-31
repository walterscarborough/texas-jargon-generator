import Combine
import UIKit

class JargonViewController: UIViewController {
    private let jargonView = JargonView(frame: .zero)
    private let jargonRepository: JargonRepository
    var subscriberSet: Set<AnyCancellable> = []

    init(jargonRepository: JargonRepository) {
        self.jargonRepository = jargonRepository

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = jargonView

        jargonView.remotePhraseButton.addTarget(
            self,
            action: #selector(phraseButtonTapped),
            for: .touchUpInside
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc private func phraseButtonTapped() {
        jargonRepository
            .fetchJargon()
            .sink(receiveCompletion: { result in
                switch result {
                case .finished: do {
                    break
                }
                case .failure: do {
                    break
                }
                }
            }, receiveValue: { actualJargon in
                DispatchQueue.main.async {
                    self.jargonView.phraseLabel.text = actualJargon.phrase
                }
        }).store(in: &subscriberSet)
    }
}
