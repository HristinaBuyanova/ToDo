import UIKit

final class CategoryTableViewCell: UITableViewCell {

    static var identifier = "TableCell"

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .backSecondary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelPrimary
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupAppearance()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        colorView.layer.cornerRadius = 0.5 * colorView.bounds.size.width
    }

    func configureCell(category: Category) {
        titleLabel.text = category.text
        if let hex = category.color {
            colorView.isHidden = false
            colorView.backgroundColor = UIColor(hex: hex)
        } else {
            colorView.isHidden = true
        }
    }

    private func setupViews() {
        contentView.addSubview(cardView)
        [titleLabel, colorView].forEach {
            cardView.addSubview($0)
        }
    }

    private func setupAppearance() {
        selectionStyle = .none
        [self, contentView, cardView].forEach { view in
            view.backgroundColor = .backSecondary
        }
    }

    private func setupLayout() {

        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),

            colorView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            colorView.topAnchor.constraint(greaterThanOrEqualTo: cardView.topAnchor),
            colorView.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor),
            colorView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 20),
            colorView.widthAnchor.constraint(equalToConstant: 20),

            titleLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: cardView.topAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
        ])
    }

}
