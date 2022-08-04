//
//  ViewModel.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 03.08.2022.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var text: String = "Сегодня солнце зашло за тучи, сегодня волны бьют так больно, я видел, как умирает надежда Ямайки - моя душа плачет! Какая боль, какая боль! Аргентина-Ямайка: 5-0"
    @Published private var sortIsAscending: Bool = true
    @Published var searchText: String = ""
    @Published var sortedWholeListSuffix: [(String, Int)] = .init()
    @Published var sortedTopTenSuffixList: [(String, Int)] = .init()

    private var bag: Set<AnyCancellable> = .init()
    
    private var wholeListSuffix: [(String, Int)] {
        calculateSuffixesNumber()
            .sorted { sortIsAscending ? $0.0 < $1.0 : $0.0 > $1.0 }
    }
    
    private var topTenSuffixList: [(String, Int)] {
        calculateSuffixesNumber()
            .sorted(by: { $0.1 > $1.1 })
            .prefix(10)
            .sorted { $0.1 == $1.1 ? $0.0 < $1.0 : false }
    }
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let strongSelf = self else { return }
                strongSelf.sortedWholeListSuffix = value.isEmpty ? strongSelf.wholeListSuffix : strongSelf.wholeListSuffix.filter({ $0.0.contains(value.lowercased()) })
                strongSelf.sortedTopTenSuffixList = value.isEmpty ? strongSelf.topTenSuffixList : strongSelf.topTenSuffixList.filter({ $0.0.contains(value.lowercased()) })
            })
            .store(in: &bag)
    }
    
    func sortAscending() {
        sortIsAscending = true
    }
    
    func sortDescending() {
        sortIsAscending = false
    }
    
    private func calculateSuffixesNumber() -> [(String, Int)] {
        var store: [(string: String, int: Int)] = .init()
        for string in getSuffixes() {
            if store.contains(where: { $0.string == string }) {
                let index = store.firstIndex(where: { $0.string == string })!
                store[index].int += 1
            } else {
                store.append((string: string, int: 1))
            }
        }
        
        return store
    }
    
    private func getSuffixes() -> [String] {
        text
            .components(separatedBy: .init(charactersIn: ",-!?;: "))
            .filter({ $0.count > 2 })
            .map({ String($0.lowercased().suffix(3)) })
    }
}
