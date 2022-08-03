//
//  SuffixListScreen.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 03.08.2022.
//

import SwiftUI

struct SuffixListScreen: View {
    @EnvironmentObject private var viewModel: ViewModel
    @State private var selection: Int = 0
    
    var showWholeList: Bool {
        selection == 0
    }
    
    init() {
        UITextField.appearance().placeholder = "поиск суффикса"
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Picker("", selection: $selection) {
                Text("Весь список")
                    .tag(0)
                
                Text("Топ 10")
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if showWholeList {
                wholeList
            } else {
                topTenList
            }
                        
            TextField("", text: $viewModel.searchText)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 30)
        }
        .frame(width: .customWidth())
    }
}

struct SuffixListScreen_Previews: PreviewProvider {
    static var previews: some View {
        SuffixListScreen()
    }
}

extension SuffixListScreen {
    var topTenList: some View {
        SuffixList(list: viewModel.sortedTopTenSuffixList)
    }
}

extension SuffixListScreen {
    var wholeList: some View {
        VStack(spacing: 30) {
            HStack {
                Button {
                    viewModel.sortAscending()
                } label: {
                    Text("Сортировать от А к Я")
                }
                
                Spacer()
                
                Button {
                    viewModel.sortDescending()
                } label: {
                    Text("Сортировать от Я к А")
                }
            }
            .buttonStyle(.bordered)
            .font(.footnote)
            
            SuffixList(list: viewModel.sortedWholeListSuffix)
        }
    }
}
