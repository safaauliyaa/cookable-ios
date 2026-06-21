//
//  RecipeInfo.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct RecipeInfo: View {

    let recipe: Recipe

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Text(recipe.title)
                .font(.title)
                .bold()

            Text(recipe.description)
                .font(.body)
                .foregroundStyle(.secondary)

            Divider()
                .frame(height: 2)
                    .background(Color.black.opacity(0.15))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
    }
}
#Preview {
    RecipeInfo(recipe: Recipe.mock)
}
