//
//  FifthHomeworkAppApp.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 03.08.2022.
//

import SwiftUI

@main
struct FifthHomeworkAppApp: App {
    @StateObject var viewModel: ViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
