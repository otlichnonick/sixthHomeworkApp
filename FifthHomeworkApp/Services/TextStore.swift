//
//  TextStore.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 05.08.2022.
//

import Foundation

class TextStore {
    private(set) var text: String = ""
    private let defaults = UserDefaults(suiteName: "group.home.FifthHomeworkApp")!
    private let textKey = "text"
    
    init() {
        text = getText()
        print("text from userDefaults", text)
    }
    
    private func getText() -> String {
        defaults.string(forKey: textKey) ?? "Сегодня солнце зашло за тучи, сегодня волны бьют так больно, я видел, как умирает надежда Ямайки - моя душа плачет! Какая боль, какая боль! Аргентина-Ямайка: 5-0"
    }
    
    func setForSuffixes(new newText: String) {
        text = newText
        defaults.set(newText, forKey: textKey)
        print("newText", newText)
    }
}
