//
//  DetailViewController.swift
//  SeSAC-Study2
//
//  Created by 정준영 on 2023/07/26.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var labelCollection: [UILabel]!
    var user: UserInfo!
    override func viewDidLoad() {
        super.viewDidLoad()

        labelCollection[0].text = user.email
        labelCollection[1].text = user.password
        labelCollection[2].text = user.nickName
        labelCollection[3].text = user.location ?? ""
        labelCollection[4].text = user.reference ?? ""
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    
    

}
