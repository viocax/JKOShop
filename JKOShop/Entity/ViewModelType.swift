//
//  ViewModelType.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output

}
