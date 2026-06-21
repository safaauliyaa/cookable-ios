//
//  DetailRecipeView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct DetailRecipeView: View {

    let recipe: Recipe

    var body: some View {

        VStack {

            RecipeHeaderImage(recipe: recipe)

            // content lainnya
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    DetailRecipeView(recipe: Recipe.mock)
}
