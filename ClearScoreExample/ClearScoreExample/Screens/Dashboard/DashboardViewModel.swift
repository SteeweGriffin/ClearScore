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
    var user: User? { get }
    var statePublisher: Published<DashboardViewModelState>.Publisher { get }
    func fetchUser()
}

enum DashboardViewModelState: Equatable {
    case idle
    case loading
    case error(message: String)
    case dataAvailable(viewModel: DashboardCircleViewModelType)
    
    static func == (lhs: DashboardViewModelState, rhs: DashboardViewModelState) -> Bool {
        switch (lhs, rhs) {
        case (idle, idle),
             (loading, loading),
             (dataAvailable(_), dataAvailable(_)):
            return true
        case (error(let lhsMessage), error(let rhsMessage)):
            return lhsMessage == rhsMessage
        default: return false
        }
    }
}

final class DashboardViewModel: DashboardViewModelType {

    // MARK: - Public properties
    
    var statePublisher: Published<DashboardViewModelState>.Publisher { $state }
    var screenTitle: String { return "Dashboard" }
    var user: User?
    
    // MARK: - Private properties
    
    private let repository: UserRepositoryType
    private var cancellables = Set<AnyCancellable>()
   
    @Published private var state: DashboardViewModelState = .idle
    
    // MARK: - Public methods
    
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
            let circleViewModel = DashbaordCircleViewModel(creditReportInfo: user.creditReportInfo)
            self?.state = .dataAvailable(viewModel: circleViewModel)
        }.store(in: &cancellables)

    }
    
}
