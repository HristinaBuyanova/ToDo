import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {

    static var identifier = "CollectionCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .labelSecondary
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .backPrimary
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.supportSeparator.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAppearance()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            cardView.layer.borderColor = UIColor.supportSeparator.cgColor
        }
    }

    override var isSelected: Bool {
        didSet {
            setupSelectedStyle(isSelected)
        }
    }

    func configureCell(text: String) {
        titleLabel.setAttributedText(text.replacingOccurrences(of: " ", with: "\n"), lineSpacing: 10)
    }

    private func setupViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)

    }

    private func setupAppearance() {
        [self, contentView].forEach { $0.backgroundColor = .backPrimary }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8)
        ])
    }

    private func setupSelectedStyle(_ isSelected: Bool) {
        cardView.layer.borderWidth = isSelected ? 1 : 0
        cardView.backgroundColor =  isSelected ? .backSecondary : .backPrimary
    }

}

private extension UILabel {
    func setAttributedText(_ text: String, lineSpacing: CGFloat = 10) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail
        attributedText = NSMutableAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
    }
}
