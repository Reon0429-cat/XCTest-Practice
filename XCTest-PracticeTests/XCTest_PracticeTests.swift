//
//  XCTest_PracticeTests.swift
//  XCTest-PracticeTests
//
//  Created by 大西玲音 on 2021/12/29.
//

import XCTest
@testable import XCTest_Practice

// スタブ
protocol AuthManagerProtocol {
    var isLoggedIn: Bool { get }
}

class AuthManagerStub: AuthManagerProtocol {
    var isLoggedIn: Bool = false
}

class DialogManager {
    private let authManager: AuthManagerProtocol
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
    var shouldShowLoginDialog: Bool {
        !authManager.isLoggedIn
    }
}


// モック
protocol LoggerProtocol {
    func sendLog(message: String)
}

class Logger: LoggerProtocol {
    func sendLog(message: String) {
        // 本番用のログ送信の実装
    }
}

class LoggerMock: LoggerProtocol {
    var invokedSendLog = false
    var invokedSendLogCount = 0
    var sendLogProperties = [String]()
    func sendLog(message: String) {
        invokedSendLog = true
        invokedSendLogCount += 1
        sendLogProperties.append(message)
    }
}

class Calculator {
    private let logger: LoggerProtocol
    init(logger: LoggerProtocol) {
        self.logger = logger
    }
    private enum CalcAction {
        case add(Int)
    }
    private var calcActions = [CalcAction]()
    func add(num: Int) {
        calcActions.append(.add(num))
    }
    func calc() -> Int {
        logger.sendLog(message: "Start calc.")
        var total = 0
        calcActions.forEach { calcAction in
            switch calcAction {
            case .add(let num):
                logger.sendLog(message: "Add \(num).")
                total += num
            }
        }
        logger.sendLog(message: "Total is \(total).")
        logger.sendLog(message: "Finish calc.")
        return total
    }
}






class XCTest_PracticeTests: XCTestCase {
    
    func testAdd() {
        let loggerMock = LoggerMock()
        let calculator = Calculator(logger: loggerMock)
        let expectedSendMessages = [
            "Start calc.",
            "Add 1.",
            "Total is 1.",
            "Finish calc."
        ]
        calculator.add(num: 1)
        XCTAssertEqual(calculator.calc(), 1)
        // モックに記録された情報をテスト
        XCTAssertTrue(loggerMock.invokedSendLog)
        XCTAssertEqual(loggerMock.invokedSendLogCount, 4)
        XCTAssertEqual(loggerMock.sendLogProperties, expectedSendMessages)
    }
    
    func testShowLoginDialog_ログイン済み() {
        let authManagerStub = AuthManagerStub()
        authManagerStub.isLoggedIn = true
        let dialogManager = DialogManager(authManager: authManagerStub)
        XCTAssertFalse(dialogManager.shouldShowLoginDialog)
    }
    
    func testShowLoginDialog_未ログイン() {
        let authManagerStub = AuthManagerStub()
        authManagerStub.isLoggedIn = false
        let dialogManager = DialogManager(authManager: authManagerStub)
        XCTAssertTrue(dialogManager.shouldShowLoginDialog)
    }
    
    // 正しい非同期処理のテスト
    func testAsyncString() {
        let exp = XCTestExpectation(description: "Async String")
        asyncString { string in
            XCTAssertEqual(string, "文字列A")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        
        // 間違った非同期処理のテスト
        // アサーションが評価されていないためテストが成功する
        asyncString { string in
            XCTAssertEqual(string, "文字列B")
        }
    }
    
    func testDivideWhenDivisionByZero() {
        XCTAssertThrowsError(try divide(3, by: 0)) { error in
            let error = error as? OperationError
            XCTAssertEqual(error, OperationError.divisionByZero)
        }
    }
    
    // 8文字以上であること
    // 数字が2文字含まれており、合計7文字入力された場合にfalseが返されること
    // 数字が2文字含まれており、合計8文字入力された場合にtrueが返されること
    // 数字が2文字含まれており、合計9文字入力された場合にtrueが返されること
    // 数字が2文字以上利用されていること
    // 数字以外を7文字と数字が1文字入力された場合にfalseが返されること
    // 数字以外を7文字と数字が2文字入力された場合にtrueが返されること
    // 数字以外を7文字と数字が3文字入力された場合にtrueが返されること
    
    func test数字以外を7文字と数字が1文字入力された場合にfalseが返されること() {
        XCTAssertFalse(validate(password: "abcdefg1"))
    }
    
    func test数字以外を7文字と数字が2文字入力された場合にtrueが返されること() {
        XCTAssertTrue(validate(password: "abcdefg12"))
    }
    
    func test数字以外を7文字と数字が3文字入力された場合にtrueが返されること() {
        XCTAssertTrue(validate(password: "abcdefg123"))
    }
    
    func testパスワードバリデーションの文字数() {
        XCTContext.runActivity(named: "数字が2文字以上含まれている場合") { _ in
            XCTContext.runActivity(named: "合計7文字が入力された場合") { _ in
                XCTAssertFalse(validate(password: "abcde12"))
            }
            XCTContext.runActivity(named: "合計8文字入力された場合") { _ in
                XCTAssertTrue(validate(password: "abcdef12"))
            }
            XCTContext.runActivity(named: "合計9文字入力された場合") { _ in
                XCTAssertTrue(validate(password: "abcdefg12"))
            }
        }
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
