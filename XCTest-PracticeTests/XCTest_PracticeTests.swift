//
//  XCTest_PracticeTests.swift
//  XCTest-PracticeTests
//
//  Created by 大西玲音 on 2021/12/29.
//

import XCTest
@testable import XCTest_Practice

protocol ReadableRepositoryContract {
    func read() -> Int
}

class ImplicitInput {
    private let repository: ReadableRepositoryContract
    init(repository: ReadableRepositoryContract) {
        self.repository = repository
    }
    func reduce () -> Int {
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

// 本番用のクラス
class ReadableRepository: ReadableRepositoryContract {
    private let data: ImplicitInput.Data
    init(data: ImplicitInput.Data) {
        self.data = data
    }
    func read() -> Int {
        return self.data.double()
    }
}

// 本番でImplicitInputを使う場合
let repository = ReadableRepository(
    data: ImplicitInput.Data(value: 5)
)
let implicitInput = ImplicitInput(repository: repository)
let result = implicitInput.reduce()

// スタブを定義する
class ReadableRepositoryStub: ReadableRepositoryContract {
    private let base: Int
    init(base: Int) {
        self.base = base
    }
    func read() -> Int {
        return self.base
    }
}

class XCTest_PracticeTests: XCTestCase {
    
    func testMultiplication() {
        let int = 4
        let expected = 3
        let repositoryStub = ReadableRepositoryStub(base: int)
        let input = ImplicitInput(repository: repositoryStub)
        let actual = input.reduce()
        XCTAssertEqual(actual, expected)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
