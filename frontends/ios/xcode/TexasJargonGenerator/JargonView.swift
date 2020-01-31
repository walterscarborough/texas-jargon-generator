import UIKit

class JargonView: UIView {
    let remotePhraseButton = UIButton(type: .roundedRect)
    let localPhraseButton = UIButton(type: .roundedRect)
    let phraseLabel = UILabel(frame: .zero)
    enum Tags: Int {
        case remotePhraseButton = 1
        case localPhraseButton
        case phraseLabel
    }

    private let phraseStack = UIStackView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        tagSubviews()
        styleSubviews()
        setupAutolayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(phraseStack)

        phraseStack.addArrangedSubview(phraseLabel)
        phraseStack.addArrangedSubview(remotePhraseButton)
        phraseStack.addArrangedSubview(localPhraseButton)
    }

    private func tagSubviews() {
        remotePhraseButton.tag = Tags.remotePhraseButton.rawValue
        localPhraseButton.tag = Tags.localPhraseButton.rawValue
        phraseLabel.tag = Tags.phraseLabel.rawValue
    }

    private func styleSubviews() {
        phraseStack.axis = .vertical
        phraseStack.distribution = .fillEqually

        remotePhraseButton.backgroundColor = UIColor.red
        localPhraseButton.backgroundColor = UIColor.purple
        phraseLabel.backgroundColor = UIColor.green
        phraseStack.layer.backgroundColor = UIColor.blue.cgColor

        localPhraseButton.setTitle("Get Local Phrase", for: .normal)
        remotePhraseButton.setTitle("Get Remote Phrase", for: .normal)
        phraseLabel.text = "Yolo!"

        backgroundColor = UIColor.yellow
    }

    private func setupAutolayout() {
        let layoutGuide = safeAreaLayoutGuide

        NSLayoutConstraint.useAndActivateConstraints([
            phraseStack.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            phraseStack.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            phraseStack.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            phraseStack.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
        ])
    }
}
