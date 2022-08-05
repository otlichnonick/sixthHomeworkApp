//
//  TextScreen.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 03.08.2022.
//

import SwiftUI
import WidgetKit

struct TextScreen: View {
    @EnvironmentObject private var viewModel: ViewModel
    
    var placeholder: String {
        viewModel.text.isEmpty ? "Введите сюда текст" : ""
    }
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $viewModel.text)
                    .foregroundColor(.black)
                    .frame(height: UIScreen.main.bounds.width * 0.3)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(16)
                    .onChange(of: viewModel.text, perform: { text in
                        viewModel.setForSuffixes(new: text)
                        WidgetCenter.shared.reloadTimelines(ofKind: "SuffixWidjet")
                    })
                
                Text(placeholder)
                    .padding(8)
                    .foregroundColor(.gray)
            }
            
            Button {
                viewModel.text = ""
            } label: {
                Text("Очистить текст")
            }
            .buttonStyle(.bordered)
            
            HStack {
                Text(viewModel.text)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                
                Spacer()
            }
            
            Spacer()
        }
        .frame(width: .customWidth())
        .padding(.vertical)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct TextScreen_Previews: PreviewProvider {
    static var previews: some View {
        TextScreen()
    }
}
