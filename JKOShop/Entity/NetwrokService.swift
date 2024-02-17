//
//  NetwrokService.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import RxSwift

protocol NetworkService {
    func request<T: Endpoint>(_ endpoint: T) -> Observable<T.Model>
}

struct APIService: NetworkService {
    func request<T: Endpoint>(_ endpoint: T) -> Observable<T.Model> {
        do {
            let data = try endpoint.getData()
            let model = try JSONDecoder().decode(T.Model.self, from: data)
            return .just(model)
                .delay(.milliseconds(800), scheduler: MainScheduler.instance)
        } catch {
            print("errro \(error.localizedDescription)")
            return .error(error)
        }
    }
}
