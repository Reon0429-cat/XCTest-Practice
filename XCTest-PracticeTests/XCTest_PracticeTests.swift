//
//  XCTest_PracticeTests.swift
//  XCTest-PracticeTests
//
//  Created by 大西玲音 on 2021/12/29.
//

import XCTest
@testable import XCTest_Practice

struct User {
    let name: String
    func convert() -> String? {
        if name.isEmpty || name.count == 4 {
            return nil
        }
        return name
    }
}

class XCTest_PracticeTests: XCTestCase {
    
    let user1 = User(name: "REON")
    let user2 = User(name: "")
    let user3 = User(name: "ヤマモトタロウ")

    func testUser_引数の名前がconvertすると取得できること() {
        XCTContext.runActivity(named: "5文字の名前") { _ in
            XCTAssertEqual(user3.convert(),
                           "ヤマモトタロウ",
                           "ヤマモトタロウが一致すること")
        }
    }
    
    func testUser_から文字の場合はnilになること() {
        XCTContext.runActivity(named: "から文字") { _ in
            XCTAssertNil(user2.convert(), "から文字なのでnilになること")
        }
    }
    
    func testUser_４文字の場合はnilになること() {
        XCTContext.runActivity(named: "4文字の名前") { _ in
            XCTAssertNil(user1.convert(), "4文字なのでnilになること")
        }
    }
    
    func testRead() {
        let expected = 99
        let repository = ReadableRepositoryStub(base: 100)
        let input = ImplicitInput(repository: repository)
        let int = input.reduce()
        XCTAssertEqual(expected, int)
    }
    
    func testWrite() {
        let int = 2
        let expected = int
        let spy = WritableRepositorySpy()
        let output = ImplicitOutput(repository: spy)
        output.write(int: int)
        XCTAssertEqual(expected, spy.callArguments.first!)
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
