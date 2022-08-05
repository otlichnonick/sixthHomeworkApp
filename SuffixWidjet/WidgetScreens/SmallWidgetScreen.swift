//
//  SmallWidgetScreen.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 05.08.2022.
//

import SwiftUI

struct SmallWidgetScreen: View {
    let entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color(uiColor: UIColor.systemMint)
            
            VStack {
                ForEach(entry.suffixes.prefix(3), id: \.0) { suffix in
                    HStack {
                        Text("\(suffix.0) - \(suffix.1)")
                        Spacer()
                    }
                    .font(.body)
                    .foregroundColor(.black)
                }
                
                    Button(action: {}) {
                        Text("все суффиксы")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.bordered)
            }
            .padding(.horizontal)
        }
        .widgetURL(Constants.suffixListUrl)
    }
}

