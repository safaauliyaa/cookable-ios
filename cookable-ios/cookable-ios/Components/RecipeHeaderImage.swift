//
//  RecipeHeaderImage.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct RecipeHeaderImage: View {

    let recipe: Recipe

    var body: some View {

        Image(recipe.imageName)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 280)
            .clipped()
            .clipShape(
                UnevenRoundedRectangle(
                    bottomLeadingRadius: 32,
                    bottomTrailingRadius: 32
                )
            )
    }
}
#Preview {
    RecipeHeaderImage(recipe: Recipe.mock)
}
