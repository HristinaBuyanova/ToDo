import SwiftUI

struct CategoryView: UIViewControllerRepresentable {

    typealias UIViewControllerType = UINavigationController
    @Binding var category: Category?

    func makeUIViewController(
        context: Context
    ) -> UINavigationController {
        UINavigationController(
            rootViewController: CategoryViewController(category: $category)
        )
    }

    func updateUIViewController(
        _ uiViewController: UINavigationController,
        context: Context
    ) { }

}

#Preview {
    @State var category: Category? = Category()
    return CategoryView(category: $category)
        .ignoresSafeArea()
}
