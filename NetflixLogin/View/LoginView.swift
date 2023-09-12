//
//  LoginView.swift
//  NetflixLogin
//
//  Created by 정준영 on 2023/09/12.
//

import UIKit
import JimmyKit
import SnapKit

final class LoginView: UIView {
    private let textViewHeight: CGFloat = 40
    private let space: CGFloat = 18
    private lazy var stackViewCount = CGFloat(stackView.arrangedSubviews.count)
    var emailInfoLabelCenterYConstraint: Constraint?
    var passwordInfoLabelCenterYConstraint: Constraint?
    let email = "Jimmy@gmail.com"
    let password = "a123456"
    
    lazy var emailTextField = UITextField()
        .backgroundColor(.clear)
        .textColor(.label)
        .autocorrectionType(.no)
        .autocapitalizationType(.none)
        .spellCheckingType(.no)
        .keyboardType(.emailAddress)
    
    lazy var emailInfoLabel = UILabel()
        .text("이메일주소 또는 전화번호")
        .font(.systemFont(ofSize: 18))
        .textColor(.secondaryLabel)
    
    lazy var emailTextFieldView = UIView()
        .backgroundColor(.secondarySystemFill)
        .cornerRadius(5)
        .clipsToBounds(true)
        .addSubView(emailInfoLabel)
        .addSubView(emailTextField)
    
    lazy var passwordTextField = UITextField()
        .backgroundColor(.clear)
        .textColor(.label)
        .autocorrectionType(.no)
        .autocapitalizationType(.none)
        .spellCheckingType(.no)
        .isSecureTextEntry(true)
    
    lazy var passwordInfoLabel = UILabel()
        .text("비밀번호")
        .font(.systemFont(ofSize: 18))
        .textColor(.secondaryLabel)
    
    lazy var passwordSecureButton = UIButton(configuration: .plain())
        .baseForegroundColor(.secondaryLabel)
        .titleWithFont(title: "표시", size: 14, weight: .light)
    
    lazy var passwordTextFieldView = UIView()
        .backgroundColor(.secondarySystemFill)
        .cornerRadius(5)
        .clipsToBounds(true)
        .addSubView(passwordTextField)
        .addSubView(passwordInfoLabel)
        .addSubView(passwordSecureButton)
    
    
    lazy var loginButton = UIButton(configuration: .filled())
        .cornerStyle(.medium)
        .baseForegroundColor(.white)
        .baseBackgroundColor(.systemGreen)
        .titleWithFont(title: "로그인", size: 16, weight: .heavy)
        .isEnabled(false)
    
    lazy var joinButton = UIButton(configuration: .filled())
        .cornerStyle(.medium)
        .baseForegroundColor(.white)
        .baseBackgroundColor(.systemBlue)
        .titleWithFont(title: "회원가입", size: 16, weight: .heavy)
    
    lazy var passwordResetButton = UIButton(configuration: .plain())
        .titleWithFont(title: "비밀번호 재설정", size: 18, weight: .bold)
        .baseForegroundColor(.label)
        .titleAlignment(.center)
    
    lazy var defaultEmailLabel = UILabel()
        .text("Email: \(email)")
        .font(.systemFont(ofSize: 18, weight: .medium))
        .textColor(.secondaryLabel)
        .textAlignment(.center)
    
    lazy var defaultPasswordLabel = UILabel()
        .text("Password: \(password)")
        .font(.systemFont(ofSize: 18, weight: .medium))
        .textColor(.secondaryLabel)
        .textAlignment(.center)
    
    lazy var stackView: UIStackView = UIStackView()
        .spacing(18)
        .axis(.vertical)
        .distribution(.fillEqually)
        .alignment(.fill)
        .addArrangedSubview(emailTextFieldView)
        .addArrangedSubview(passwordTextFieldView)
        .addArrangedSubview(loginButton)
        .addArrangedSubview(joinButton)
        .addArrangedSubview(UIView())
        .addArrangedSubview(passwordResetButton)
        .addArrangedSubview(defaultEmailLabel)
        .addArrangedSubview(defaultPasswordLabel)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupAutoLayout()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .systemBackground
        addSubView(stackView)
    }
    
    private func setupAutoLayout() {
        
        emailInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(emailTextFieldView).offset(8)
            $0.trailing.equalTo(emailTextFieldView).offset(-8)
            self.emailInfoLabelCenterYConstraint =  $0.centerY.equalTo(emailTextFieldView).offset(-3).constraint
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextFieldView).offset(15)
            $0.bottom.equalTo(emailTextFieldView).offset(-2)
            $0.leading.equalTo(emailTextFieldView).offset(8)
            $0.trailing.equalTo(emailTextFieldView).offset(-8)
        }
        
        passwordInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(passwordTextFieldView).offset(8)
            $0.trailing.equalTo(passwordTextFieldView).offset(-8)
            self.passwordInfoLabelCenterYConstraint = $0.centerY.equalTo(passwordTextFieldView).offset(-3).constraint
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextFieldView).offset(15)
            $0.bottom.equalTo(passwordTextFieldView).offset(-2)
            $0.leading.equalTo(passwordTextFieldView).offset(8)
            $0.trailing.equalTo(passwordSecureButton.snp.leading).offset(-8)
        }
        
        passwordSecureButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextFieldView).offset(15)
            $0.bottom.equalTo(passwordTextFieldView).offset(-15)
            $0.trailing.equalTo(passwordTextFieldView).offset(-8)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo((textViewHeight * stackViewCount) + (space * (stackViewCount - 1)))
        }
    }
}
