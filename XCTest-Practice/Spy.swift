//
//  Spy.swift
//  XCTest-Practice
//
//  Created by 大西玲音 on 2021/12/31.
//

import Foundation

protocol WritableRepositoryContract {
    func write(int: Int)
}

// 良いパターン
class ImplicitOutput {
    private let repository: WritableRepositoryContract
    init(repository: WritableRepositoryContract) {
        self.repository = repository
    }
    func write(int: Int) {
        self.repository.write(int: int)
    }
    class Data {
        var value: Int?
        init(value: Int?) {
            self.value = value
        }
    }
}

// 本番用
class WritableRepository: WritableRepositoryContract {
    private let data: ImplicitOutput.Data
    init(data: ImplicitOutput.Data) {
        self.data = data
    }
    func write(int: Int) {
        self.data.value = int
    }
}

// スパイオブジェクト
class WritableRepositorySpy: WritableRepositoryContract {
    private(set) var callArguments = [Int]()
    // 偽物の振る舞いをおこなっている箇所
    func write(int: Int) {
        callArguments += [int]
    }
}
