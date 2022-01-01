//
//  XCTest_PracticeTests.swift
//  XCTest-PracticeTests
//
//  Created by 大西玲音 on 2021/12/29.
//

import XCTest
@testable import XCTest_Practice

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

class XCTest_PracticeTests: XCTestCase {
    
    // 8文字以上であること
        // 数字が2文字含まれており、合計7文字入力された場合にfalseが返されること
        // 数字が2文字含まれており、合計8文字入力された場合にtrueが返されること
        // 数字が2文字含まれており、合計9文字入力された場合にtrueが返されること
    // 数字が2文字以上利用されていること
        // 数字以外を7文字と数字が1文字入力された場合にfalseが返されること
        // 数字以外を7文字と数字が2文字入力された場合にtrueが返されること
        // 数字以外を7文字と数字が3文字入力された場合にtrueが返されること
    
    func test数字が2文字含まれており_合計7文字入力された場合にfalseが返されること() {
        XCTAssertFalse(validate(password: "abcde12"))
    }
        
    func test数字が2文字含まれており_合計8文字入力された場合にtrueが返されること() {
        XCTAssertTrue(validate(password: "abcdef12"))
    }
    
    func test数字が2文字含まれており_合計9文字入力された場合にtrueが返されること() {
        XCTAssertTrue(validate(password: "abcdefg12"))
    }
    
    func test数字以外を7文字と数字が1文字入力された場合にfalseが返されること() {
        XCTAssertFalse(validate(password: "abcdefg1"))
    }
    
    func test数字以外を7文字と数字が2文字入力された場合にtrueが返されること() {
        XCTAssertTrue(validate(password: "abcdefg12"))
    }
    
    func test数字以外を7文字と数字が3文字入力された場合にtrueが返されること() {
        XCTAssertTrue(validate(password: "abcdefg123"))
    }
    
    
    
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
