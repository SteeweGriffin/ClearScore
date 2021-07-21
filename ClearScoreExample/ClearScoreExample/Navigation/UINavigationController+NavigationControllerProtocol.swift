//
//  UINavigationController+NavigationControllerProtocol.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation
import UIKit

protocol NavigationControllerProtocol {
    func setControllerAsRoot(_ controller: UIViewController)
    func pushController(_ controller: UIViewController, animated: Bool)
    func presentController(_ controller: UIViewController, animated: Bool)
}

extension UINavigationController: NavigationControllerProtocol {

    func setControllerAsRoot(_ controller: UIViewController) {
        setViewControllers([controller], animated: false)
    }

    func pushController(_ controller: UIViewController, animated: Bool) {
        pushViewController(controller, animated: animated)
    }

    func presentController(_ controller: UIViewController, animated: Bool) {
        present(controller, animated: animated)
    }
}

