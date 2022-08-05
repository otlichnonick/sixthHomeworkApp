//
//  ContentView.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 03.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            TextScreen()
                .tabItem {
                    Label {
                        Text("Текст")
                    } icon: {
                        Image(systemName: "text.book.closed.fill")
                    }
                }
                .tag(0)
            
            SuffixListScreen()
                .tabItem {
                    Label {
                        Text("Список")
                    } icon: {
                        Image(systemName: "list.bullet")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
