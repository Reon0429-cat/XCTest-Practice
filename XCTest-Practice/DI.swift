//
//  DI.swift
//  XCTest-Practice
//
//  Created by 大西玲音 on 2022/01/02.
//

import Foundation

// コンストラクタインジェクション
protocol UserRepositoryProtocol {
    func login()
}

// 本番用クラス
class UserRepository: UserRepositoryProtocol {
    func login() {
        print("本番")
    }
}

// 偽物クラス
class UserRepository偽物: UserRepositoryProtocol {
    func login() {
        print("偽物")
    }
}

class UserUseCase {
    private let repository: UserRepositoryProtocol
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    func login() {
        repository.login()
    }
}

let repositroy = UserRepository()
let userUseCase = UserUseCase(repository: repositroy)
//let userUseCase = UserUseCase(repository: repository偽物)


// セッターインジェクション
// イニシャライズ以降にコンポーネントを代入する
//protocol ViewModelProtocol {
//    func printName()
//}
//class ViewModel: ViewModelProtocol {
//    func printName() {
//        print("REON")
//    }
//}
//class ViewController: UIViewController {
//    private var viewModel: ViewModelProtocol?
//    func inject(viewModel: ViewModelProtocol) {
//        self.viewModel = viewModel
//    }
//    func printName() {
//        viewModel?.printName()
//    }
//}
//let vc = UIStoryboard(name: "VC", bundle: nil)
//    .instantiateInitialViewController() as! ViewController
//let viewModel = ViewModel()
//vc.inject(viewModel: viewModel)
//vc.printName() // REON
