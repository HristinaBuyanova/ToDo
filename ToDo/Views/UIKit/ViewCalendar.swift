import UIKit

protocol CalendarUIViewDelegate: AnyObject {
    func didTapButton(_ button: UIButton)
}

final class ViewCalendar: UIView {

    weak var delegate: CalendarUIViewDelegate?

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .backPrimary
        tableView.separatorInset = .zero
        tableView.separatorColor = .supportSeparator
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 20
        tableView.contentInset.bottom = 50
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.identifier)
        tableView.register(CalendarTableViewHeader.self, forHeaderFooterViewReuseIdentifier: CalendarTableViewHeader.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 75, height: 75)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .backPrimary
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10)
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let addButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(paletteColors: [.white, .systemBlue])
            .applying(UIImage.SymbolConfiguration(pointSize: 51, weight: .regular, scale: .default))
        button.setImage(UIImage(systemName: "plus.circle.fill")?.withConfiguration(config), for: .normal)
        button.layer.cornerRadius = 51/2
        button.layer.shadowColor = UIColor.labelTertiary.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = .init(width: 0, height: 8)
        button.layer.shadowOpacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAppearance()
        setupLayout()
        setupTargets()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        [collectionView, tableView, separatorView, addButton].forEach {
            addSubview($0)
        }
    }

    private func setupAppearance() {
        backgroundColor = .backPrimary
        separatorView.backgroundColor = .supportSeparator
    }

    private func setupTargets() {
        addButton.addTarget(self, action: #selector(tapOnButton(_:)), for: .touchUpInside)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),

            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.topAnchor.constraint(equalTo: collectionView.bottomAnchor,constant: 5),

            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            addButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 49),
            addButton.widthAnchor.constraint(equalToConstant: 51),
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    @objc private func tapOnButton(_ sender: UIButton) {
        delegate?.didTapButton(sender)
    }

}

