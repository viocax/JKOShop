//
//  MockService.swift
//  JKOShopTests
//
//  Created by drake on 2024/2/17.
//

import Foundation
@testable import JKOShop
@testable import RxSwift

class MockService: NetworkService {
    var injectRequest: Observable<Any> = .empty()
    func request<T: Endpoint>(_ endpoint: T) -> Observable<T.Model> {
        // force unwrapper just only in test
        return injectRequest.compactMap { $0 as? T.Model }
    }
}
