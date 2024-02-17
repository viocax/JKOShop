//
//  HistoryOrderUseCase.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import RxSwift

protocol HistoryOrderUseCase {
    func getHistoryList() -> Observable<[ShopItemsViewModel]>
}
