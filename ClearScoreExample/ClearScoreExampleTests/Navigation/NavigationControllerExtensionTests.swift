//
//  NavigationControllerExtensionTests.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import XCTest
@testable import ClearScoreExample

final class NavigationControllerExtensionTests: XCTestCase {

    private var sut: UINavigationController!
    private var controller: UIViewController!
    private var window: UIWindow!

    override func setUpWithError() throws {
        try super.setUpWithError()
        controller = UIViewController()
        sut = UINavigationController(rootViewController: controller)
        window = UIWindow()
        window.rootViewController = sut
        window.makeKeyAndVisible()
    }

    override func tearDownWithError() throws {
        sut = nil
        controller = nil
        window = nil
        try super.tearDownWithError()
    }

    func test_setControllerAsRoot() throws {
        // GIVEN
        let newController = UIViewController()

        // WHEN
        sut.setControllerAsRoot(newController)

        // THEN
        XCTAssertEqual(sut.viewControllers.count, 1)
        XCTAssertEqual(sut.viewControllers.first, newController)
    }

    func test_pushController() throws {
        // GIVEN
        let newController = UIViewController()

        // WHEN
        sut.pushController(newController, animated: false)

        // THEN
        XCTAssertEqual(sut.viewControllers.count, 2)
        XCTAssertEqual(sut.viewControllers.first, controller)
        XCTAssertEqual(sut.viewControllers.last, newController)
    }

    func test_presentController() throws {
        // GIVEN
        let newController = UIViewController()

        // WHEN
        sut.presentController(newController, animated: false)

        // THEN
        XCTAssertEqual(sut.viewControllers.count, 1)
        XCTAssertEqual(sut.presentedViewController, newController)
    }
}
