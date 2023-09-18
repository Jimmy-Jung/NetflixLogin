//
//  String+Extension.swift
//  NetflixLogin
//
//  Created by 정준영 on 2023/09/12.
//

import Foundation

extension String {
    // MARK: - ID,PW 형식 검사 메서드
    
    //이메일 형식 검사, 정규식을 사용
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    //비밀번호 형식 검사, 6-10자리, 영문 대소문자 및 숫자가 모두 포함되어 있어야함
    func isValidPassword() -> Bool {
        let passwordRegEx = "(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,10}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    func isValidRecommend() -> Bool {
        let recommendRegEx = "[0-9]{6}"
        let recommendTest = NSPredicate(format: "SELF MATCHES %@", recommendRegEx)
        return recommendTest.evaluate(with: self)
    }
}
