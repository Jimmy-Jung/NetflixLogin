//
//  NextViewController.swift
//  NetflixLogin
//
//  Created by 정준영 on 2023/09/12.
//

import UIKit

final class NextViewController: UIViewController {
    let label = UILabel()
        .text("로그인 성공!")
        .font(.systemFont(ofSize: 30, weight: .bold))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor(.systemBackground)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
