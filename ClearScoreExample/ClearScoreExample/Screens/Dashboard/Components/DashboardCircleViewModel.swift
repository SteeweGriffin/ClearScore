//
//  DashboardCircleViewModel.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation

protocol DashboardCircleViewModelType {
    var title: String { get }
    var subtitle: String { get }
    var valueString: String { get }
    var valuePercentage: Float { get }
}

struct DashboardCircleViewModel: DashboardCircleViewModelType {
    
    // MARK: - Private properties
    
    private var creditReportInfo: User.CreditReportInfo
    
    // MARK: - Public properties
    
    var title: String { return "Your credit score is" }
    var subtitle: String { return "out of \(creditReportInfo.maxScoreValue)" }
    var valueString: String { return "\(creditReportInfo.score)" }
    var valuePercentage: Float {
        let input = Float(creditReportInfo.score)
        let min = Float(creditReportInfo.minScoreValue)
        let max = Float(creditReportInfo.maxScoreValue)
        return (input - min) / (max - min)
    }
    
    // MARK: - Public methods
    
    init(creditReportInfo: User.CreditReportInfo) {
        self.creditReportInfo = creditReportInfo
    }
}
