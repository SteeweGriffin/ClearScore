//
//  UserMapper.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation

protocol UserMapperProtocol {
    func map(body: Data) -> User?
}

struct UserMapper: UserMapperProtocol {

    func map(body: Data) -> User? {
        let decoder = JSONDecoder()
        return try? decoder.decode(User.self, from: body)
    }
}
