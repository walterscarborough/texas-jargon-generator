import UIKit

class JargonView: UIView {
    let remotePhraseButton = UIButton(type: .roundedRect)
    let phraseLabel = UILabel(frame: .zero)
    enum Tags {
        static let remotePhraseButton = 1
        static let phraseLabel = 2
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
    }

    private func tagSubviews() {
        remotePhraseButton.tag = Tags.remotePhraseButton
        phraseLabel.tag = Tags.phraseLabel
    }

    private func styleSubviews() {
        phraseStack.axis = .vertical
        phraseStack.distribution = .fillEqually

        remotePhraseButton.backgroundColor = UIColor.red
        phraseLabel.backgroundColor = UIColor.green
        phraseStack.layer.backgroundColor = UIColor.blue.cgColor

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