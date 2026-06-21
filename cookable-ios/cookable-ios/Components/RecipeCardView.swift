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

            VStack(alignment: .leading, spacing: 12) {

                Text(recipe.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)

                HStack(spacing: 8) {
                        
                    ForEach(recipe.ingredients.prefix(3)) { ingredient in

                        Text(ingredient.name)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .overlay {
                                Capsule()
                                    .stroke(Color.primary, lineWidth: 1.2)
                            }
                    }
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.15), lineWidth: 1)
            }
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            .padding([.horizontal, .bottom], 12)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
}

extension Recipe {

    static let mock = Recipe(
        id: "1",
        title: "Broccoli Omelette",
        description: "Simple omelette with broccoli.",
        imageName: "eggtomatobroccoli",
        ingredients: [
            RecipeIngredient(
                id: "1",
                name: "Egg",
                amount: "2"
            ),
            RecipeIngredient(
                id: "2",
                name: "Broccoli",
                amount: "100g"
            ),
            RecipeIngredient(
                id: "3",
                name: "Tomato",
                amount: "1"
            )
        ],
        instructions: [
            "Beat eggs",
            "Cook"
        ]
    )
}

#Preview {
    RecipeCardView(recipe: .mock)
}
