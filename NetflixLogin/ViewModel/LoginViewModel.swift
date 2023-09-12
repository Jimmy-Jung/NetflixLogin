//
//  LoginViewModel.swift
//  NetflixLogin
//
//  Created by 정준영 on 2023/09/12.
//

import UIKit

protocol LoginViewModelProtocol {
    var email: Observable<String> { get set }
    var password: Observable<String> { get set }
    var emailValid: Observable<Bool> { get set }
    var passwordValid: Observable<Bool> { get set }
    func checkBothValid() -> Bool
}

final class LoginViewModel: LoginViewModelProtocol {
    var email = Observable<String>("")
    var password = Observable<String>("")
    var emailValid = Observable<Bool>(false)
    var passwordValid = Observable<Bool>(false)
    
    init() {
        self.binding()
    }
    
    func binding() {
        email.bind { [unowned self] value in
            self.emailValid.value = value.isValidEmail()
        }
        password.bind { [unowned self] value in
            self.passwordValid.value = value.isValidPassword()
        }
    }
    
    func checkBothValid() -> Bool {
        return emailValid.value && passwordValid.value
    }
}
