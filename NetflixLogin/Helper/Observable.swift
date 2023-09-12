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
    
    // 초기화 할 때는 didSet이 실행되지 않는다. 메모리에 단순 올라가기만 하기 때문
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (_ value: T) -> Void) {
        listener = closure
    }
}
