//
//  DashboardViewModel.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation
import Combine

protocol DashboardViewModelType {
    var screenTitle: String { get }
    var statePublisher: Published<DashboardViewModelState>.Publisher { get }
    func fetchUser()
}

enum DashboardViewModelState {
    case idle
    case loading
    case error(message: String)
    case dataAvailable(viewModel: User)
}

final class DashboardViewModel: DashboardViewModelType {

    var statePublisher: Published<DashboardViewModelState>.Publisher { $state }
    var screenTitle: String { return "Dashboard" }
    
    private let repository: UserRepositoryType
    private var cancellables = Set<AnyCancellable>()
    private var user: User?
    @Published private var state: DashboardViewModelState = .idle
    
    init(repository: UserRepositoryType = UserRepository()) {
        self.repository = repository
    }
    
    func fetchUser() {
        cancellables.forEach { $0.cancel() }
        state = .loading
        repository.fetchUser()
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.state = .error(message: error.localizedDescription)
                }
        } receiveValue: { [weak self] user in
            self?.user = user
            self?.state = .dataAvailable(viewModel: user)
        }.store(in: &cancellables)

    }
    
}
