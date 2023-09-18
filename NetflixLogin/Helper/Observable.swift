//
//  Observable.swift
//  SeSAC3Unsplash
//
//  Created by 정준영 on 2023/09/12.
//

import Foundation

final class Observable<T> {
    private var listener: ((T) -> Void)?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (_ value: T) -> Void) {
        listener = closure
    }
}
