//
//  IngredientsDetail.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct IngredientsDetail: View {

    let ingredients: [RecipeIngredient]

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack {

                Text("Ingredients")
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()

                Image(systemName: "chevron.up")
                    .font(.headline)
            }

            VStack(alignment: .leading, spacing: 24) {

                ForEach(ingredients) { ingredient in

                    HStack(spacing: 16) {

                        Text(ingredient.emoji)
                            .font(.title2)

                        Text(ingredient.name)
                            .font(.title3)
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
}


extension IngredientsDetail {

    var emoji: String {

        switch name.lowercased() {

        case "egg":
            return "🥚"

        case "broccoli":
            return "🥦"

        case "tomato":
            return "🍅"

        case "chicken":
            return "🍗"

        case "beef":
            return "🥩"

        case "shrimp":
            return "🦐"

        case "tofu":
            return "🧈"

        default:
            return "🍴"
        }
    }
}

#Preview {
    IngredientsDetail(
        ingredients: recipe.ingredients
    )
}
