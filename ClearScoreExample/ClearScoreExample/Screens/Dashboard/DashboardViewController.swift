//
//  DashboardViewController.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation
import UIKit
import Combine

final class DashboardViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let viewModel: DashboardViewModelType
    private let router: MainRouterProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Public methods
    
    required init(input: DashboardViewModelType, navigation: MainRouterProtocol) {
        viewModel = input
        router = navigation
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUser()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        view.backgroundColor = Color.background.uiColor
        title = viewModel.screenTitle
    }
    
    private func binding() {
        viewModel.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { state in
                print(state)
            }
            .store(in : &cancellables)
    }
}
