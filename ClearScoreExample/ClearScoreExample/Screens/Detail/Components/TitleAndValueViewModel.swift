//
//  TitleAndValueViewModel.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation

protocol TitleAndValueViewModelType {
    var title: String { get }
    var value: String { get }
}

struct TitleAndValueViewModel: TitleAndValueViewModelType {
    let title: String
    let value: String
}
