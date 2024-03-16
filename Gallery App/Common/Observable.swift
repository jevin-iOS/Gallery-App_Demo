//
//  Observable.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation

class Observable<T> {
    
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    private var listener: ((T?)->())?
    
    init(value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping ((T?) -> ())) {
        self.listener = listener
    }
}
