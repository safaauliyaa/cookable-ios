//
//  IngredientInfoSheet.swift
//  cookable-ios
//
//  Created by Safa Auliya on 19/06/26.
//

import SwiftUI

struct IngredientInfoSheet: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {

        NavigationStack {

            VStack {
                
                
                
            }
            .navigationTitle("Current Ingredients")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    IngredientInfoSheet()
}
