//
//  MockNavigationController.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation
import UIKit
@testable import ClearScoreExample

final class MockNavigationController: NavigationControllerType {

    private(set) var setControllerAsRootCallsCount = 0
    private(set) var pushControllerCallsCount = 0
    private(set) var presentControllerCallsCount = 0

    var expectedController: UIViewController?

    init() {}

    func setControllerAsRoot(_ controller: UIViewController) {
        setControllerAsRootCallsCount += 1
        expectedController = controller
    }

    func pushController(_ controller: UIViewController, animated: Bool) {
        pushControllerCallsCount += 1
        expectedController = controller
    }

    func presentController(_ controller: UIViewController, animated: Bool) {
        presentControllerCallsCount += 1
        expectedController = controller
    }
}
