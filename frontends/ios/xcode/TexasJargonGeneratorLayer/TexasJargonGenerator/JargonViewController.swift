import Combine
import JargonRepositories
import UIKit

class JargonViewController: UIViewController {
    private let jargonView = JargonView(frame: .zero)
    private let remoteJargonRepository: JargonRepository
    private let localJargonRepository: JargonRepository

    var subscriberSet: Set<AnyCancellable> = []

    init(
        remoteJargonRepository: JargonRepository,
        localJargonRepository: JargonRepository
    ) {
        self.remoteJargonRepository = remoteJargonRepository
        self.localJargonRepository = localJargonRepository

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = jargonView

        jargonView.remotePhraseButton.addTarget(
            self,
            action: #selector(remotePhraseButtonTapped),
            for: .touchUpInside
        )

        jargonView.localPhraseButton.addTarget(
            self,
            action: #selector(localPhraseButtonTapped),
            for: .touchUpInside
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc private func remotePhraseButtonTapped() {
        remoteJargonRepository
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

    @objc private func localPhraseButtonTapped() {
        localJargonRepository
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
