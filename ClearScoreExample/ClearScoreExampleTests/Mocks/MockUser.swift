//
//  MockUser.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation
@testable import ClearScoreExample

extension User {
    static var mock: User {
        let creditReportInfo = CreditReportInfo(score: 478,
                                                scoreBand: 4,
                                                maxScoreValue: 700,
                                                minScoreValue: 0,
                                                percentageCreditUsed: 56,
                                                currentShortTermDebt: 1000,
                                                currentShortTermCreditLimit: 2000,
                                                currentLongTermDebt: 3000,
                                                daysUntilNextReport: 19)
        return User(personaType: .inexperienced, creditReportInfo: creditReportInfo)
    }
    
    var data: Data {
        try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
    
    private var json: [String: Any] {
        let creditReportInfoJson: [String: Any] = ["score": creditReportInfo.score,
                                                   "scoreBand": creditReportInfo.scoreBand,
                                                   "maxScoreValue": creditReportInfo.maxScoreValue,
                                                   "minScoreValue": creditReportInfo.minScoreValue,
                                                   "percentageCreditUsed": creditReportInfo.percentageCreditUsed,
                                                   "currentShortTermDebt": creditReportInfo.currentShortTermDebt,
                                                   "currentShortTermCreditLimit": creditReportInfo.currentShortTermCreditLimit,
                                                   "currentLongTermDebt": creditReportInfo.currentLongTermDebt,
                                                   "daysUntilNextReport": creditReportInfo.daysUntilNextReport]
        return ["personaType": personaType.rawValue,
                "creditReportInfo": creditReportInfoJson
        ]
    }
}
