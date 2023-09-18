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
    var recommendInfoLabelCenterYConstraint: Constraint?
    let email = "Jimmy@gmail.com"
    let password = "a123456"
    let recommend = "123456"
    
    private lazy var titleLabel = UILabel()
        .text("JIMMYFLIX")
        .textColor(.systemRed)
        .font(.systemFont(ofSize: 40, weight: .black))
        .textAlignment(.center)
    
    lazy var emailTextField = UITextField()
        .backgroundColor(.clear)
        .textColor(.label)
        .autocorrectionType(.no)
        .autocapitalizationType(.none)
        .spellCheckingType(.no)
        .keyboardType(.emailAddress)
    
    lazy var emailInfoLabel = UILabel()
        .text("이메일주소 또는 전화번호")
        .font(.systemFont(ofSize: 14))
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
        .font(.systemFont(ofSize: 14))
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
    
    lazy var recommendTextField = UITextField()
        .backgroundColor(.clear)
        .textColor(.label)
        .autocorrectionType(.no)
        .autocapitalizationType(.none)
        .spellCheckingType(.no)
        .keyboardType(.numberPad)
    
    lazy var recommendInfoLabel = UILabel()
        .text("추천 코드 입력")
        .font(.systemFont(ofSize: 14))
        .textColor(.secondaryLabel)
    
    lazy var recommendTextFieldView = UIView()
        .backgroundColor(.secondarySystemFill)
        .cornerRadius(5)
        .clipsToBounds(true)
        .addSubView(recommendInfoLabel)
        .addSubView(recommendTextField)
    
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
    
    lazy var defaultRecommendLabel = UILabel()
        .text("Recommend: \(recommend)")
        .font(.systemFont(ofSize: 18, weight: .medium))
        .textColor(.secondaryLabel)
        .textAlignment(.center)
    
    lazy var stackView: UIStackView = UIStackView()
        .spacing(18)
        .axis(.vertical)
        .distribution(.fillEqually)
        .alignment(.fill)
        .addArrangedSubview(titleLabel)
        .addArrangedSubview(UIView())
        .addArrangedSubview(UIView())
        .addArrangedSubview(emailTextFieldView)
        .addArrangedSubview(passwordTextFieldView)
        .addArrangedSubview(recommendTextFieldView)
        .addArrangedSubview(loginButton)
        .addArrangedSubview(joinButton)
        .addArrangedSubview(passwordResetButton)
        .addArrangedSubview(defaultEmailLabel)
        .addArrangedSubview(defaultPasswordLabel)
        .addArrangedSubview(defaultRecommendLabel)
    
    
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
            self.emailInfoLabelCenterYConstraint =  $0.centerY.equalTo(emailTextFieldView).constraint
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
            self.passwordInfoLabelCenterYConstraint = $0.centerY.equalTo(passwordTextFieldView).constraint
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
        
        recommendInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(emailTextFieldView).offset(8)
            $0.trailing.equalTo(emailTextFieldView).offset(-8)
            self.recommendInfoLabelCenterYConstraint =  $0.centerY.equalTo(recommendTextFieldView).constraint
        }
        
        recommendTextField.snp.makeConstraints {
            $0.top.equalTo(recommendTextFieldView).offset(15)
            $0.bottom.equalTo(recommendTextFieldView).offset(-2)
            $0.leading.equalTo(recommendTextFieldView).offset(8)
            $0.trailing.equalTo(recommendTextFieldView).offset(-8)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo((textViewHeight * stackViewCount) + (space * (stackViewCount - 1)))
        }
    }
}
