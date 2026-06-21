//
//  IngredientsDetail.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct IngredientsDetail: View {

    let recipe: Recipe
    let allIngredients: [Ingredient]

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack {
                Text("Ingredients")
                    .font(.title3.bold())

                Spacer()
            }
//            Text("Loaded: \(allIngredients.count)")
            ForEach(recipe.ingredients) { ingredient in

                HStack(spacing: 12) {

                    Text(
                        allIngredients.first {
                            $0.id == ingredient.id || $0.name.lowercased() == ingredient.name.lowercased()
                        }?.emoji ?? "🍽️"
                    )
                    .font(.title2)

                    Text(ingredient.name)
                        .font(.body)

                    Spacer(minLength: 12)

                    if let amount = ingredient.amount {
                        Text(amount)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            Spacer()
                .frame(height: 2)
            
            Divider()
                .frame(height: 2)
                    .background(Color.black.opacity(0.15))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
    }
}

#Preview {
    IngredientsDetail(
        recipe: .mock,
        allIngredients: IngredientRepository.loadIngredients()
    )
}
