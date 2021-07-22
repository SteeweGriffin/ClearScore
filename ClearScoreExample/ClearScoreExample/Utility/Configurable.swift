//
//  ViewConfigurable.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation
import UIKit

protocol Configurable {
    associatedtype T
    func configure(_ input: T?)
}
