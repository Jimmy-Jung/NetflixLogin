//
//  LoginViewController.swift
//  NetflixLogin
//
//  Created by 정준영 on 2023/09/12.
//

import UIKit

final class LoginViewController: UIViewController {
    var loginView: LoginView!
    var loginViewModel: LoginViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView = LoginView()
        loginViewModel = LoginViewModel()
        configureUI()
        setupAddTarget()
        binding()
    }
    private func configureUI() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAddTarget() {
        [loginView.emailTextField, loginView.passwordTextField, loginView.recommendTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: [.editingDidBegin, .editingChanged])
            $0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        }
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        loginView.passwordSecureButton.addTarget(self, action: #selector(secureButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func binding() {
        loginViewModel.emailValid.bind { [unowned self] value in
            loginView.emailInfoLabel.textColor = value ? .systemGreen : .secondaryLabel
            loginView.loginButton.isEnabled(loginViewModel.checkBothValid())
        }
        
        loginViewModel.passwordValid.bind { [unowned self] value in
            loginView.passwordInfoLabel.textColor = value ? .systemGreen : .secondaryLabel
            loginView.loginButton.isEnabled(loginViewModel.checkBothValid())
        }
        
        loginViewModel.recommendValid.bind { [unowned self] value in
            loginView.recommendInfoLabel.textColor = value ? .systemGreen : .secondaryLabel
            loginView.loginButton.isEnabled(loginViewModel.checkBothValid())
        }
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension LoginViewController {
    
    @objc func secureButtonTapped(_ sender: UIButton) {
        loginView.passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func loginButtonTapped(_ sender: UIButton) {
        let loginCheck = loginViewModel.checkLogin()
        switch loginCheck {
            
        case .success(_):
            transition(viewController: NextViewController(), style: .present)
        case .failure(let error):
            switch error {
                
            case .email:
                self.loginView.emailInfoLabel.shakeLabel(shakeText: error.errorDescription, durationTime: 3, textWillDisappear: false)
            case .password:
                self.loginView.passwordInfoLabel.shakeLabel(shakeText: error.errorDescription, durationTime: 3, textWillDisappear: false)
            case .recommend:
                self.loginView.recommendInfoLabel.shakeLabel(shakeText: error.errorDescription, durationTime: 3, textWillDisappear: false)
            }
        }
        
    }
    // MARK: - 텍스트필드 델리게이트
    //텍스트필드 편집 시작할때의 설정 - 문구가 위로올라가면서 크기 작아지고, 오토레이아웃 업데이트
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == loginView.emailTextField {
            loginViewModel.email.value = textField.text!
            loginView.emailTextFieldView.backgroundColor = .systemGray6
            loginView.emailInfoLabel.font(.systemFont(ofSize: 11))
            // 오토레이아웃 업데이트
            loginView.emailInfoLabelCenterYConstraint?.update(offset: -13)
        }
        
        if textField == loginView.passwordTextField {
            loginViewModel.password.value = textField.text!
            loginView.passwordTextFieldView.backgroundColor = .systemGray6
            loginView.passwordInfoLabel.font(.systemFont(ofSize: 11))
            // 오토레이아웃 업데이트
            loginView.passwordInfoLabelCenterYConstraint?.update(offset: -13)
        }
        
        if textField == loginView.recommendTextField {
            loginViewModel.recommend.value = textField.text!
            loginView.recommendTextFieldView.backgroundColor = .systemGray6
            loginView.recommendInfoLabel.font(.systemFont(ofSize: 11))
            // 오토레이아웃 업데이트
            loginView.recommendInfoLabelCenterYConstraint?.update(offset: -13)
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.2) {
            self.loginView.stackView.layoutIfNeeded()
        }
    }
    
    
    // 텍스트필드 편집 종료되면 백그라운드 색 변경 (글자가 한개도 입력 안되었을때는 되돌리기)
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == loginView.emailTextField {
            loginView.emailInfoLabel.text = "이메일주소 또는 전화번호"
            loginView.emailTextFieldView.backgroundColor(.secondarySystemFill)
            // 빈칸이면 원래로 되돌리기
            if loginView.emailTextField.text == "" {
                loginView.emailInfoLabel.font(.systemFont(ofSize: 14))
                loginView.emailInfoLabelCenterYConstraint?.update(offset: 0)
            }
        }
        if textField == loginView.passwordTextField {
            loginView.passwordInfoLabel.text = "비밀번호"
            loginView.passwordTextFieldView.backgroundColor(.secondarySystemFill)
            // 빈칸이면 원래로 되돌리기
            if loginView.passwordTextField.text == "" {
                loginView.passwordInfoLabel.font(.systemFont(ofSize: 14))
                loginView.passwordInfoLabelCenterYConstraint?.update(offset: 0)
            }
        }
        
        if textField == loginView.recommendTextField {
            loginView.recommendInfoLabel.text = "추천 코드 입력"
            loginView.recommendTextFieldView.backgroundColor(.secondarySystemFill)
            // 빈칸이면 원래로 되돌리기
            if loginView.recommendTextField.text == "" {
                loginView.recommendInfoLabel.font(.systemFont(ofSize: 14))
                loginView.recommendInfoLabelCenterYConstraint?.update(offset: 0)
            }
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.3) {
            self.loginView.stackView.layoutIfNeeded()
        }
    }
}
