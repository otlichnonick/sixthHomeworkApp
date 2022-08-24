//
//  SuffixSearchHistoryScreen.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 23.08.2022.
//

import SwiftUI

struct SuffixSearchHistoryScreen: View {
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("История поиска суффиксов")
                .font(.title2)
            
            list()
                .padding(.horizontal)

            Spacer()
        }
    }
}

struct SuffixSearchHistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        SuffixSearchHistoryScreen()
    }
}

extension SuffixSearchHistoryScreen {
    @ViewBuilder
    func list() -> some View  {
        if viewModel.searchModels.isEmpty {
            HStack {
                Text("Список пуст")
                    .padding(.top)
                
                Spacer()
            }
        } else {
            ForEach(viewModel.searchModels, id: \.self) { item in
                HStack {
                    Text(item.suffix)
                    
                    Spacer()
                    
                    Text("\(round(item.time * 1000000) / 1000000) с")
                }
                .padding()
                .background(viewModel.getColorForModel(with: item.time))
                .cornerRadius(16)
            }
        }
    }
}
