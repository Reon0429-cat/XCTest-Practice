//
//  Stub.swift
//  XCTest-Practice
//
//  Created by 大西玲音 on 2021/12/31.
//

import Foundation

protocol ReadableRepositoryContract {
    func read() -> Int
}

class ImplicitInput {
    private let repository: ReadableRepositoryContract
    init(repository: ReadableRepositoryContract) {
        self.repository = repository
    }
    // こいつをテストしたい
    func reduce() -> Int {
        return repository.read() - 1
    }
    class Data {
        let value: Int
        init(value: Int) {
            self.value = value
        }
        func double() -> Int {
            return value * 2
        }
    }
}

// 本番用クラス
class ReadableRepository: ReadableRepositoryContract {
    private let data: ImplicitInput.Data
    init(data: ImplicitInput.Data) {
        self.data = data
    }
    func read() -> Int {
        return data.double()
    }
}

// スタブクラス
class ReadableRepositoryStub: ReadableRepositoryContract {
    private let base: Int
    init(base: Int) {
        self.base = base
    }
    func read() -> Int {
        return self.base
    }
}
