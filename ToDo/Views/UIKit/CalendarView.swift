

import SwiftUI

struct CalendarView: UIViewControllerRepresentable {

    typealias UIViewControllerType = UINavigationController

    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: CalendarViewController())
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {

    }

}
