//
//  OrderCheckingUseCase.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import RxSwift

protocol OrderCheckingUseCase {
    func checkOut() -> Observable<Void>
    func getItemsToCheckOut() -> Observable<[OrderCellDisplayModel]>
    func getFooterInfo() -> OrderFooterViewModel
}
