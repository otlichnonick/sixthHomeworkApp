//
//  TextStore.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 05.08.2022.
//

import Foundation

class TextStore {
    private(set) var text: String = ""
    private(set) var searchModels: [SearchModel] = .init()
    
    private let defaults = UserDefaults(suiteName: "group.home.FifthHomeworkApp")!
    private let textKey = "text"
    private let searchModelKey = "searchModelKey"
    
    var maxTime: Double? {
        searchModels.count > 1 ? searchModels.max(by: { $0.time < $1.time })?.time : nil
    }
    
    var minTime: Double? {
        searchModels.count > 1 ? searchModels.max(by: { $0.time > $1.time })?.time : nil
    }
    
    init() {
        text = getText()
        searchModels = getSuffixes()
    }
    
    private func getText() -> String {
        defaults.string(forKey: textKey) ?? "Сегодня солнце зашло за тучи, сегодня волны бьют так больно, я видел, как умирает надежда Ямайки - моя душа плачет! Какая боль, какая боль! Аргентина-Ямайка: 5-0"
    }
    
    func setForSuffixes(new newText: String) {
        text = newText
        defaults.set(newText, forKey: textKey)
    }
    
    private func getSuffixes() -> [SearchModel] {
        guard let data = defaults.value(forKey: searchModelKey) as? Data else { return [] }
        let suffixes = try? PropertyListDecoder().decode([SearchModel].self, from: data)
        return suffixes ?? []
    }
    
    func searchModelsAppend(new model: SearchModel) {
        print("model", model)
        searchModels.append(model)
        defaults.set(try? PropertyListEncoder().encode(searchModels), forKey: searchModelKey)
    }
}
