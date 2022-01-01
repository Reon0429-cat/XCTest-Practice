//
//  User.swift
//  XCTest-Practice
//
//  Created by 大西玲音 on 2022/01/01.
//

import Foundation

struct User {
    let name: String
    func convert() -> String? {
        if name.isEmpty || name.count == 4 {
            return nil
        }
        return name
    }
}
