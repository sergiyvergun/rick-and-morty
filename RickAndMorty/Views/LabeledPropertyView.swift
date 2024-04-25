//
//  LabeledPropertyView.swift
//  RickAndMorty
//
//  Created by Sergiy Vergun on 25/04/2024.
//

import SwiftUI

struct LabeledPropertyView: View {
    let label: String
    let value: String
    
    var body: some View {
        LabeledContent() {
            Text(value).fontWeight(.medium).foregroundColor(.black)
        } label: {
            Text(label).foregroundColor(.secondary).fontWeight(.regular)
        }
    }
}

#Preview {
    LabeledPropertyView(label: "Label", value: "Value")
}
