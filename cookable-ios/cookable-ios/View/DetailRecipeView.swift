//
//  DetailRecipeView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct DetailRecipeView: View {

    @Environment(\.dismiss) private var dismiss

    let recipe: Recipe

    private let allIngredients =
        IngredientRepository.loadIngredients()

    var body: some View {

        ZStack(alignment: .topLeading) {

            ScrollView {

                VStack(spacing: 24) {

                    RecipeHeaderImage(recipe: recipe)
                        .padding(.top, -60)

                    RecipeInfo(recipe: recipe)

                    IngredientsDetail(
                        recipe: recipe,
                        allIngredients: allIngredients
                    )

                    InstructionsDetail(
                        recipe: recipe
                    )
                }
            }
            .overlay(alignment: .top) {

                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(height: 80)
                    .ignoresSafeArea(edges: .top)
            }
            .overlay(alignment: .topLeading) {

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(width: 48, height: 48)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .padding(.top, 24)
                .padding(.leading, 24)
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 8,
                    y: 4
                )
            }
        }
//        .ignoresSafeArea()
    }
}

#Preview {
    DetailRecipeView(recipe: Recipe.mock)
}
