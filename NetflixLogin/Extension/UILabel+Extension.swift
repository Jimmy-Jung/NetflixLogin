//
//  UILabel+Extension.swift
//  NetflixLogin
//
//  Created by 정준영 on 2023/09/18.
//

import UIKit

extension UILabel {
    func shakeLabel(
        shakeText: String,
        textColor: UIColor = .red,
        durationTime: Double,
        textWillDisappear: Bool,
        prepareHandler: (() -> Void)? = nil,
        completionHandler: (() -> Void)? = nil
    ) {
        prepareHandler?()
        self.text = shakeText
        self.textColor = textColor
        self.shake()
        if textWillDisappear {
            DispatchQueue.main.asyncAfter(deadline: .now() + durationTime) {
                completionHandler?()
            }
        }
    }
}
