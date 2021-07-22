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
    
    private lazy var loaderIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var dashboardView: DashboardCircleView = {
        let view = DashboardCircleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private enum Layout {
        static let padding: CGFloat = 20
    }
    
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
        setupUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard state == .idle else { return }
                self?.viewModel.fetchUser()
            }
            .store(in : &cancellables)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = Color.background.uiColor
        title = viewModel.screenTitle
        dashboardView.tapAction = { [weak self] in
            guard let user = self?.viewModel.user else { return }
            self?.router.displayDetail(user)
        }
        view.addSubview(dashboardView)
        NSLayoutConstraint.activate([dashboardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     dashboardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     dashboardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Layout.padding),
                                     dashboardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Layout.padding),
                                     dashboardView.heightAnchor.constraint(equalTo: dashboardView.widthAnchor)])
    }
    
    private func binding() {
        viewModel.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in : &cancellables)
    }
    
    private func handleState(_ state: DashboardViewModelState) {
        switch state {
        case .idle: break
        case .loading:
            self.toggleLoader(true)
        case .dataAvailable(let viewModel):
            self.toggleLoader(false)
            dashboardView.configure(viewModel)
            dashboardView.startAnimation()
        case .error(let message):
            self.toggleLoader(false)
            self.router.displayError(message)
        }
    }
    
    private func toggleLoader(_ value: Bool) {
        loaderIndicator.stopAnimating()
        loaderIndicator.removeFromSuperview()
        if value {
            view.addSubview(loaderIndicator)
            NSLayoutConstraint.activate([loaderIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                         loaderIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
            loaderIndicator.startAnimating()
        }
    }
}
