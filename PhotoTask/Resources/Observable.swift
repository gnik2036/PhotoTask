//
//  Observable.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 08/01/2022.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
           listener?(value)
        }
    }
    
    private var listener : ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    func bind(_ clouser: @escaping (T) -> Void) {
        clouser(value)
        listener = clouser
    }
    
}
