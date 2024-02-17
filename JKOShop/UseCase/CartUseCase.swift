//
//  CartUseCase.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation

protocol CartUseCase {
    func getCurrentChartItems() -> [CartViewCellViewModel]
    func canCheckOut() -> Bool
    func toggleItems(_ cell: CartViewCellViewModel)
}
