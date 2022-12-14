//
//  ViewModel.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 03.08.2022.
//

import Foundation
import Combine
import SwiftUI

class ViewModel: ObservableObject {
    static let shared: ViewModel = .init()
    @Published var text: String = ""
    @Published private var sortIsAscending: Bool = true
    @Published var searchText: String = ""
    @Published var searchSuffix: String = ""
    @Published var searchModels: [SearchModel]!
    @Published var wholeListSuffix: [(String, Int)] = .init()
    @Published var topTenSuffixList: [(String, Int)] = .init()
    private var bag: Set<AnyCancellable> = .init()
    private let textStore: TextStore = .init()
    
    var sortedWholeListSuffix: [(String, Int)] {
        searchSuffix.isEmpty ? wholeListSuffix : wholeListSuffix.filter({ $0.0.contains(searchSuffix.lowercased()) })
    }
    
    var sortedTopTenSuffixList: [(String, Int)] {
        searchSuffix.isEmpty ? topTenSuffixList : topTenSuffixList.filter({ $0.0.contains(searchSuffix.lowercased()) })
    }
    
    init() {
        bindings()
        text = textStore.text
        searchModels = textStore.searchModels
    }
    
    func getColorForModel(with time: Double) -> Color {
        guard let max = textStore.maxTime,
              let min = textStore.minTime else { return Color.gray }
        print("max = \(max), min = \(min)")
        switch time {
        case time where time == max:
            return Color(red: 1, green: 0, blue: 0)
        case time where time == min:
            return Color(red: 0, green: 1, blue: 0)
        default:
            let interval = max - min
            return Color(red: time/interval, green: 1 - time/interval, blue: 0)
        }
    }
    
    func setForSuffixes(new text: String) {
        textStore.setForSuffixes(new: text)
    }
    
    func sortAscending() {
        sortIsAscending = true
    }
    
    func sortDescending() {
        sortIsAscending = false
    }
    
    private func bindings() {
        $text
            .sink { [weak self] newText in
                guard let strongSelf = self else { return }
                
                strongSelf.wholeListSuffix = strongSelf.calculateSuffixesNumber(from: newText)
                    .sorted { strongSelf.sortIsAscending ? $0.0 < $1.0 : $0.0 > $1.0 }
                
                strongSelf.topTenSuffixList = strongSelf.calculateSuffixesNumber(from: newText)
                    .sorted(by: { $0.1 > $1.1 })
                    .prefix(10)
                    .sorted { $0.1 == $1.1 ? $0.0 < $1.0 : false }
            }
            .store(in: &bag)
        
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let strongSelf = self else { return }
                strongSelf.searchSuffix = value
                if value.count == 3 {
                    let startTime = CFAbsoluteTimeGetCurrent()
                    _ = strongSelf.wholeListSuffix.filter({ $0.0.contains(value.lowercased()) })
                    let diffTime = CFAbsoluteTimeGetCurrent() - startTime
                    print("diffTime", diffTime)
                    strongSelf.textStore.searchModelsAppend(new: SearchModel(time: diffTime, suffix: value.lowercased()))
                }
                strongSelf.searchModels = strongSelf.textStore.searchModels
            })
            .store(in: &bag)
    }
    
    private func calculateSuffixesNumber(from text: String) -> [(String, Int)] {
        var store: [(string: String, int: Int)] = .init()
        for string in getSuffixes(from: text) {
            if store.contains(where: { $0.string == string }) {
                let index = store.firstIndex(where: { $0.string == string })!
                store[index].int += 1
            } else {
                store.append((string: string, int: 1))
            }
        }
        
        return store
    }
    
    private func getSuffixes(from text: String) -> [String] {
        text
            .components(separatedBy: .init(charactersIn: ",-!?;:\n "))
            .filter({ $0.count > 2 })
            .map({ String($0.lowercased().suffix(3)) })
    }
}
