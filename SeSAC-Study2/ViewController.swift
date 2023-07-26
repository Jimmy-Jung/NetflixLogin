//
//  ViewController.swift
//  SeSAC-Study2
//
//  Created by 정준영 on 2023/07/19.
//

import UIKit
struct UserInfo {
    let email: String
    let password: String
    let nickName: String
    let location: String?
    let reference: String?
}

final class ViewController: UIViewController {

    @IBOutlet var textViewCollection: [UIView]!
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var textLabelCollection: [UILabel]!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet var checkBadgeCollection: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupLayout()
        setupJoinButton()
        setupTextField()
    }

    @IBAction func viewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func switchButtonTapped(_ sender: UISwitch) {
        textFieldCollection[1].isSecureTextEntry = sender.isOn
    }
    
    private func setupDelegate() {
        textFieldCollection.forEach { textField in
            textField.delegate = self
        }
    }
    
    private func setupLayout() {
        textViewCollection.forEach { view in
            view.layer.cornerRadius = 5
            view.layer.masksToBounds = true
        }
        
        switchButton.onTintColor = .systemPink
        switchButton.backgroundColor = .systemFill
    }
    
    private func setupTextField() {
        //기본값으로 텍스트 암호화
        textFieldCollection[1].isSecureTextEntry = true
        
        [textFieldCollection[0],
         textFieldCollection[1],
         textFieldCollection[2]].forEach{
            $0.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
    }
    
    private func setupJoinButton() {
        //로그인 버튼 색상
        joinButton.backgroundColor = .systemGray
        joinButton.setTitle("회원가입", for: .normal)
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.setTitleColor(.darkGray, for: .disabled)
        joinButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        joinButton.layer.cornerRadius = 5
        joinButton.layer.masksToBounds = true
        joinButton.isEnabled = false
    }

    @IBAction func joinButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "회원가입", message: "회원가입에 성공했습니다", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel) { [weak self] _ in
            self?.performSegue(withIdentifier: "toDetailVC", sender: self)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.user = UserInfo(
                email: textFieldCollection[0].text ?? "",
                password: textFieldCollection[1].text ?? "",
                nickName: textFieldCollection[2].text ?? "",
                location: textFieldCollection[3].text,
                reference: textFieldCollection[4].text
            )
        }
    }
    
}


extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case textFieldCollection[0]:
            textViewCollection[0].backgroundColor = .systemGray
            textLabelCollection[0].isHidden = true
        case textFieldCollection[1]:
            textViewCollection[1].backgroundColor = .systemGray
            textLabelCollection[1].isHidden = true
        case textFieldCollection[2]:
            textViewCollection[2].backgroundColor = .systemGray
            textLabelCollection[2].isHidden = true
        case textFieldCollection[3]:
            textViewCollection[3].backgroundColor = .systemGray
            textLabelCollection[3].isHidden = true
        case textFieldCollection[4]:
            textViewCollection[4].backgroundColor = .systemGray
            textLabelCollection[4].isHidden = true
        default:
            print("뭔가 잘못됨")
                  break
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case textFieldCollection[0]:
            textViewCollection[0].backgroundColor = .darkGray
            textLabelCollection[0].isHidden = !(textField.text?.isEmpty ?? true)
        case textFieldCollection[1]:
            textViewCollection[1].backgroundColor = .darkGray
            textLabelCollection[1].isHidden = !(textField.text?.isEmpty ?? true)
        case textFieldCollection[2]:
            textViewCollection[2].backgroundColor = .darkGray
            textLabelCollection[2].isHidden = !(textField.text?.isEmpty ?? true)
        case textFieldCollection[3]:
            textViewCollection[3].backgroundColor = .darkGray
            textLabelCollection[3].isHidden = !(textField.text?.isEmpty ?? true)
        case textFieldCollection[4]:
            textViewCollection[4].backgroundColor = .darkGray
            textLabelCollection[4].isHidden = !(textField.text?.isEmpty ?? true)
        default:
            print("뭔가 잘못됨")
                  break
        }
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else {return}
        switch textField {
        case textFieldCollection[0]:
            print("1")
            checkBadgeCollection[0].tintColor = isValidEmail(testStr: text) ? .systemGreen : .systemGray6
        case textFieldCollection[1]:
            checkBadgeCollection[1].tintColor = isValidPassword(password: text) ? .systemGreen : .systemGray6
        case textFieldCollection[2]:
            checkBadgeCollection[2].tintColor = text.count > 0 ? .systemGreen : .systemGray6
        default: break
        }
        // 체크 활성화 되면 로그인버튼 활성화
        if checkBadgeCollection[0].tintColor == .systemGreen && checkBadgeCollection[1].tintColor == .systemGreen && checkBadgeCollection[2].tintColor == .systemGreen {
            joinButton.isEnabled = true
            joinButton.backgroundColor = .white
        } else {
            joinButton.isEnabled = false
            joinButton.backgroundColor = .systemGray
        }
    }
    
    //이메일 형식 검사, 정규식을 사용
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //비밀번호 형식 검사, 최소6자리, 영문 대소문자 및 숫자가 모두 포함되어 있어야함
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
}

