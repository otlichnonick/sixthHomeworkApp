//
//  SuffixList.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 03.08.2022.
//

import SwiftUI

struct SuffixList: View {
    let list: [(String, Int)]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(list, id: \.self.0) { row in
                    SuffixRow(row: row)
                }
            }
        }    }
}

struct SuffixList_Previews: PreviewProvider {
    static var previews: some View {
        SuffixList(list: [("моя", 1)])
    }
}
