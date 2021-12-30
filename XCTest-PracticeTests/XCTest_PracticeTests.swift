//
//  XCTest_PracticeTests.swift
//  XCTest-PracticeTests
//
//  Created by 大西玲音 on 2021/12/29.
//

import XCTest
@testable import XCTest_Practice

class XCTest_PracticeTests: XCTestCase {
    
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
