//
//  LoginViewModel.swift
//  NetflixLogin
//
//  Created by 정준영 on 2023/09/12.
//

import UIKit

enum LoginError: Error {
    case email
    case password
    case recommend
    
    var errorDescription: String {
        switch self {
            
        case .email:
            return "등록되지 않은 이메일 입니다."
        case .password:
            return "등록되지 않은 비밀번호 입니다."
        case .recommend:
            return "등록되지 않은 추천 코드 입니다."
        }
    }
}

protocol LoginViewModelProtocol {
    var email: Observable<String> { get set }
    var password: Observable<String> { get set }
    var recommend: Observable<String> { get set }
    var emailValid: Observable<Bool> { get set }
    var passwordValid: Observable<Bool> { get set }
    var recommendValid: Observable<Bool> { get set }
    func checkBothValid() -> Bool
    func checkLogin() -> Result<Bool, LoginError>
}

final class LoginViewModel: LoginViewModelProtocol {
    
    let validEmail = "Jimmy@gmail.com"
    let validPassword = "a123456"
    let validRecommend = "123456"
    
    var email = Observable<String>("")
    var password = Observable<String>("")
    var recommend = Observable<String>("")
    var emailValid = Observable<Bool>(false)
    var passwordValid = Observable<Bool>(false)
    var recommendValid = Observable<Bool>(false)
    
    init() {
        self.binding()
    }
    
    private func binding() {
        email.bind { [unowned self] value in
            self.emailValid.value = value.isValidEmail()
        }
        password.bind { [unowned self] value in
            self.passwordValid.value = value.isValidPassword()
        }
        recommend.bind { [unowned self] value in
            self.recommendValid.value = value.isValidRecommend()
        }
    }
    
    func checkBothValid() -> Bool {
        return emailValid.value && passwordValid.value && recommendValid.value
    }
    
    func checkLogin() -> Result<Bool, LoginError> {
        if email.value != validEmail {
            return .failure(.email)
        }
        
        if password.value != validPassword {
            return .failure(.password)
        }
        
        if recommend.value != validRecommend {
            return .failure(.recommend)
        }
        return .success(true)
    }
}
