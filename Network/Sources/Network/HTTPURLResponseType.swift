//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import Foundation

public protocol HTTPURLResponseType: AnyObject {
    var statusCode: Int { get }
}

extension HTTPURLResponse: HTTPURLResponseType {}

