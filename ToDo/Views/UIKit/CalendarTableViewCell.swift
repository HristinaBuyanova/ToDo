import UIKit

final class CalendarTableViewCell: UITableViewCell {

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
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let strikeThroughView: UIView = {
        let view = UIView()
        view.backgroundColor = .labelTertiary
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    func configureCell(todoItem: TodoItem) {
        titleLabel.text = todoItem.text
        titleLabel.textColor = todoItem.isDone ? .labelTertiary : .labelPrimary
        strikeThroughView.isHidden = !todoItem.isDone
        if let hex = todoItem.color {
            colorView.isHidden = false
            colorView.backgroundColor = UIColor(hex: hex)
        } else {
            colorView.isHidden = true
        }
    }

    private func setupViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(colorView)
        cardView.addSubview(strikeThroughView)
    }

    private func setupAppearance() {
        selectionStyle = .none
        self.backgroundColor = .backSecondary
        contentView.backgroundColor = .backSecondary
        cardView.backgroundColor = .backSecondary
    }

    private func setupLayout() {
                NSLayoutConstraint.activate([

                    cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
                    cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
                    cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                    cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),

                    strikeThroughView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                    strikeThroughView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
                    strikeThroughView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
                    strikeThroughView.heightAnchor.constraint(equalToConstant: 1),

                    titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                    titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
                    titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),

                    colorView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                    colorView.topAnchor.constraint(greaterThanOrEqualTo: cardView.topAnchor),
                    colorView.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor),
                    colorView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
                    colorView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
                    colorView.heightAnchor.constraint(equalToConstant: 15),
                    colorView.widthAnchor.constraint(equalToConstant: 15)
                ])
    }
}
