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

        VStack {

            RecipeHeaderImage(recipe: recipe)

            IngredientsDetail(
                recipe: recipe,
                allIngredients: allIngredients
            )
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    DetailRecipeView(recipe: Recipe.mock)
}
