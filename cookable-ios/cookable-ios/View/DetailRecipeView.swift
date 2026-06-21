//
//  DetailRecipeView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct DetailRecipeView: View {

    let recipe: Recipe
    private let allIngredients =
        IngredientRepository.loadIngredients()

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                RecipeHeaderImage(recipe: recipe)

                IngredientsDetail(
                    recipe: recipe,
                    allIngredients: allIngredients
                )

                InstructionsDetail(
                    recipe: recipe
                )
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    DetailRecipeView(recipe: Recipe.mock)
}
