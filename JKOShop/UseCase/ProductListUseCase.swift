//
//  ProductListUseCase.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import class RxSwift.Observable

protocol ProductListUseCase {
    func resetPageCount() -> Observable<Void>
    func plusPage() -> Observable<Void>
    func getShoppingList() -> Observable<[ShopItemsViewModel]>
}

