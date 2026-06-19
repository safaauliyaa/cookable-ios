//
//  IngredientRepository.swift
//  cookable-ios
//
//  Created by Safa Auliya on 18/06/26.
//

import Foundation

final class IngredientRepository {

    static func loadIngredients() -> [Ingredient] {
        guard let url = Bundle.main.url(
            forResource: "ingredients",
            withExtension: "json"
        ) else {
            print("ingredients.json not found")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(
                [Ingredient].self,
                from: data
            )
        } catch {
            print(error)
            return []
        }
    }
}
