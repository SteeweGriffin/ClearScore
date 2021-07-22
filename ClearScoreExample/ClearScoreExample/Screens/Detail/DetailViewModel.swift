//
//  DetailViewModel.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation

protocol DetailViewModelType {
    var screenTitle: String { get }
    var personaType: (title: String, value: String) { get }
    var score: (title: String, value: String) { get }
    var scoreBand: (title: String, value: String) { get }
    var currentShortTermDebt: (title: String, value: String) { get }
    var currentShortTermCreditLimit: (title: String, value: String) { get }
    var currentLongTermDebt: (title: String, value: String) { get }
    var daysUntilNextReport: (title: String, value: String) { get }
}

struct DetailViewModel: DetailViewModelType {
    
    // MARK: - Public properties
    
    var screenTitle: String { "Detail" }
    var personaType: (title: String, value: String) { ("Type", user.personaType.rawValue) }
    var score: (title: String, value: String) { ("Score", "\(user.creditReportInfo.score)") }
    var scoreBand: (title: String, value: String) { ("Score Band", "\(user.creditReportInfo.scoreBand)") }
    var currentShortTermDebt: (title: String, value: String) { ("Short term debt", user.creditReportInfo.currentShortTermDebt.GBP) }
    var currentShortTermCreditLimit: (title: String, value: String) { ("Short term credit limit", user.creditReportInfo.currentShortTermCreditLimit.GBP) }
    var currentLongTermDebt: (title: String, value: String) { ("Long term debt", user.creditReportInfo.currentLongTermDebt.GBP) }
    var daysUntilNextReport: (title: String, value: String) { ("Days until next report", "\(user.creditReportInfo.daysUntilNextReport)") }
    
    // MARK: - Priate properties
    
    private var user: User
    
    // MARK: - Public methods
    
    init(user: User) {
        self.user = user
    }
}
