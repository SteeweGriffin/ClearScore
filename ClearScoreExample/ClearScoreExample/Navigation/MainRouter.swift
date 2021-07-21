//
//  MainRouter.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation
import UIKit

protocol MainRouterProtocol {
    func displayDashboard()
    func displayDetail(_ user: User)
    func displayError(_ message: String)
}

struct MainRouter: MainRouterProtocol {

    // MARK: - Private properties

    private let navigation: NavigationControllerType

    // MARK: - Public methods

    init(with navigation: NavigationControllerType) {
        self.navigation = navigation
    }

    func displayDashboard() {
        let viewModel = DashboardViewModel()
        let controller = DashboardViewController(input: viewModel, navigation: self)
        navigation.setControllerAsRoot(controller)
    }
    
    func displayDetail(_ user: User) {
//        let viewModel = RocketDetailViewModel(rocket)
//        let controller = RocketDetailViewController(input: viewModel, navigation: self)
        let controller = ViewController()
        navigation.pushController(controller, animated: true)
    }

    func displayError(_ message: String) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: "OPS!", message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        navigation.presentController(alertController, animated: true)
    }
}
