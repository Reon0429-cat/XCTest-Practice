//
//  XCTest_PracticeTests.swift
//  XCTest-PracticeTests
//
//  Created by 大西玲音 on 2021/12/29.
//

import XCTest
@testable import XCTest_Practice

final class Animal {
    private let person: Person
    init() {
        self.person = Person(name: "玲音")
    }
    func fullName() -> String {
        // Animalクラス以外の値を利用する
        // 暗黙的入力
        return person.add大西()
    }
}

final class Person {
    let name: String
    init(name: String) {
        self.name = name
    }
    func add大西() -> String {
        return "大西" + name
    }
}

class XCTest_PracticeTests: XCTestCase {
    
    // 明示的入出力
    func doSomething(int: Int) -> Int {
        return 2 * int
    }
    
    func testSomething() {
        let expected = 20
        let actual = doSomething(int: 10)
        XCTAssertEqual(expected, actual)
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
