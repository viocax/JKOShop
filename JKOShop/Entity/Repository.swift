//
//  Repository.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation

protocol RepositoryProtocol: AnyObject {
    func getShopItemOfChart() -> [ShopItemsViewModel]
    func addToChart(_ item: ShopItemsViewModel)

    func removeItemInChart(_ items: [ShopItemsViewModel])

    var selectKeys: [String] { get set }
    // TODO: 可能是跟server溝通再存入db會比較合適，，這邊為了方便就丟在這
    func getHistory() -> [ShopItemsViewModel]
    func saveToHistory(_ items: [ShopItemsViewModel])
}

class Repository {
    static let shared: Repository = .init()
    private var currentChart: [ShopItemsViewModel] = []
    private var selectedToPurChaseKey: Set<String> = .init()
    private var historyRecord: [ShopItemsViewModel] = []
    private init() { }
}

// MARK: RepositoryProtocol
extension Repository: RepositoryProtocol {
    var selectKeys: [String] {
        get {
            return Array(selectedToPurChaseKey)
        }
        set {
            selectedToPurChaseKey = Set(newValue)
        }
    }
    func addToChart(_ item: ShopItemsViewModel) {
        currentChart.append(item)
    }
    func removeItemInChart(_ items: [ShopItemsViewModel]) {
        items.forEach { item in
            if let index = currentChart.firstIndex(where: { $0.identifier == item.identifier }) {
                currentChart.remove(at: index)
            }
        }
    }
    func getShopItemOfChart() -> [ShopItemsViewModel] {
        return currentChart
    }
    func getHistory() -> [ShopItemsViewModel] {
        return historyRecord
    }
    func saveToHistory(_ items: [ShopItemsViewModel]) {
        historyRecord += items
    }
}
