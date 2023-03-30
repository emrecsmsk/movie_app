//
//  Bindable.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 29.03.2023.
//

import Foundation


class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> Void)?
    
    func bind(observer: @escaping (T?) -> Void) {
        self.observer = observer
    }
    
}
