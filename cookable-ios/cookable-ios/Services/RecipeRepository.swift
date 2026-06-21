//
//  RecipeRepository.swift
//  cookable-ios
//
//  Created by Safa Auliya Hidayat on 21/06/26.
//

import Foundation

struct RecipeRepository {

    static func loadRecipes() -> [Recipe] {

        guard
            let url = Bundle.main.url(
                forResource: "recipes",
                withExtension: "json"
            ),
            let data = try? Data(contentsOf: url),
            let recipes = try? JSONDecoder().decode(
                [Recipe].self,
                from: data
            )
        else {
            return []
        }

        return recipes
    }
}
