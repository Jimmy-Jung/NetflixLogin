//
//  ViewController.swift
//  SeSAC-Study2
//
//  Created by 정준영 on 2023/07/19.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var textViewCollection: [UIView]!
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var textLabelCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupLayout()
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
        
        //기본값으로 텍스트 암호화
        textFieldCollection[1].isSecureTextEntry = true
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
            textLabelCollection[0].isHidden = false
        case textFieldCollection[1]:
            textViewCollection[1].backgroundColor = .darkGray
            textLabelCollection[1].isHidden = false
        case textFieldCollection[2]:
            textViewCollection[2].backgroundColor = .darkGray
            textLabelCollection[2].isHidden = false
        case textFieldCollection[3]:
            textViewCollection[3].backgroundColor = .darkGray
            textLabelCollection[3].isHidden = false
        case textFieldCollection[4]:
            textViewCollection[4].backgroundColor = .darkGray
            textLabelCollection[4].isHidden = false
        default:
            print("뭔가 잘못됨")
                  break
        }
    }
}
