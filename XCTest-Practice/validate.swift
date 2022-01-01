//
//  validate.swift
//  XCTest-Practice
//
//  Created by 大西玲音 on 2022/01/02.
//

import Foundation

// 8文字以上であること
// 数字が2文字以上利用されること
// 上記を満たさない場合はNG
func validate(password: String) -> Bool {
    if password.count <= 7 {
        return false
    }
    let numString = password.components(
        separatedBy: CharacterSet.decimalDigits.inverted
    ).joined()
    return numString.count >= 2
}

func asyncString(completion: ((String) -> ())?) {
    DispatchQueue.global().async {
        sleep(3)
        completion?("文字列A")
    }
}

enum OperationError: Error {
    case divisionByZero
}

func divide(_ x: Int, by y: Int) throws -> Int {
    if y == 0 {
        throw OperationError.divisionByZero
    }
    return x / y
}
