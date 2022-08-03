//
//  SuffixRow.swift
//  FifthHomeworkApp
//
//  Created by Anton Agafonov on 03.08.2022.
//

import SwiftUI

struct SuffixRow: View {
    let row: (String, Int)
    
    var body: some View {
        HStack {
            Text(row.0)
            
            Spacer()
            
            Text("\(row.1)")
        }
        .font(.body)
    }
}

struct SuffixRow_Previews: PreviewProvider {
    static var previews: some View {
        SuffixRow(row: ("сол", 1))
    }
}
