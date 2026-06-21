//
//  RecipeCardView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct RecipeCardView: View {

    let recipe: Recipe

    var body: some View {

        ZStack(alignment: .bottomLeading) {

            Image(recipe.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 240)
                .clipped()

            VStack(alignment: .leading, spacing: 8) {

                Text(recipe.title)
                    .font(.title3.bold())

                HStack {

                    ForEach(recipe.ingredients.prefix(3), id: \.self) {
                        ingredient in

                        Text(ingredient)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .overlay {
                                Capsule()
                                    .stroke(.black.opacity(0.4))
                            }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.ultraThinMaterial)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
}
