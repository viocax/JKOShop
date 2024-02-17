//
//  CartViewCellViewModel.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import protocol Kingfisher.Resource

protocol Selectable {
    var isSelected: Bool { get set }
}

protocol OrderCellDisplayModel {
    var id: String { get }
    var image: Resource { get }
    var title: String { get }
    var price: String { get }
}

typealias CartViewCellViewModel = OrderCellDisplayModel & Selectable
