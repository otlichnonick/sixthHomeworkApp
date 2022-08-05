//
//  MediumWidgetScreen.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 05.08.2022.
//

import SwiftUI

struct MediumWidgetScreen: View {
    let entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color(uiColor: UIColor.systemTeal)
            
            HStack {
                VStack {
                    ForEach(entry.suffixes.prefix(5), id: \.0) { suffix in
                        HStack {
                            Text("\(suffix.0) - \(suffix.1)")
                            Spacer()
                        }
                        .font(.body)
                        .foregroundColor(.black)
                    }
                }
                
                VStack(spacing: 30) {
                    Link(destination: Constants.suffixListUrl) {
                        Button(action: {}) {
                            Text("все суффиксы")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    Link(destination: Constants.textUrl) {
                        Button(action: {}) {
                            Text("смотреть текст")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .padding(.horizontal)
        }
        
    }
}

