//
//  User.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation

struct User: Codable {

    let personaType: PersonaType
    let creditReportInfo: CreditReportInfo
    
    enum PersonaType: String, Codable, CaseIterableLastUnknown {
        case inexperienced = "INEXPERIENCED"
        case unknown
    }
    
    struct CreditReportInfo: Codable {
        let score: Int
        let scoreBand: Int
        let maxScoreValue: Int
        let minScoreValue: Int
        let percentageCreditUsed: Int
        let currentShortTermDebt: Int
        let currentShortTermCreditLimit: Int
        let currentLongTermDebt: Int
        let daysUntilNextReport: Int
    }
}
