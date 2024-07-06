import UIKit


protocol NewCategoryUIViewDelegate: AnyObject {
    func didChangeTextField(text: String)
}


final class NewCategoryUIView: UIView, BaseScrollableView {


    weak var delegate: NewCategoryUIViewDelegate?
    let scrollView = UIScrollView()


    private enum Constants {
        static let inset: CGFloat = 20
        enum ColorPicker {
            static let height: CGFloat = 250
        }
    }

    private let contentView = UIView()
    private let textField: TextFieldWithInset = {
        let textField = TextFieldWithInset()
        textField.placeholder = String(localized: "category.new.placeholder")
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .backSecondary
        textField.font = .systemFont(ofSize: 15, weight: .medium)
        return textField
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAppearance()
        setupLayout()
        setTargetForTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func addColorPickerAndLayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(
                equalTo: textField.bottomAnchor,
                constant: Constants.inset
            ),
            view.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.inset
            ),
            view.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -Constants.inset
            ),
            view.heightAnchor.constraint(equalToConstant: Constants.ColorPicker.height)
        ])
    }

    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(textField)
    }

    private func setupAppearance() {
        [self, scrollView, contentView].forEach {
            $0.backgroundColor = .backPrimary
        }
    }

    private func setTargetForTextField() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(
                equalTo: scrollView.safeAreaLayoutGuide.heightAnchor
            ),
            textField.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.inset
            ),
            textField.topAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                constant: Constants.inset
            ),
            textField.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -Constants.inset
            )
        ])
    }

    @objc private func textFieldChanged(_ textField: UITextField) {
        delegate?.didChangeTextField(text: textField.text ?? "")
    }

}

extension NewCategoryUIView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }

}

final class TextFieldWithInset: UITextField {

    private enum Constants {
        static let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Constants.padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Constants.padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Constants.padding)
    }

}

