//
//  RecipeRepository.swift
//  cookable-ios
//
//  Created by Safa Auliya Hidayat on 21/06/26.
//

import Foundation

struct RecipeRepository {
    
    static func loadRecipes() -> [Recipe] {

        guard let url = Bundle.main.url(
            forResource: "recipes",
            withExtension: "json"
        ) else {

            print("❌ recipes.json NOT FOUND")

            return []
        }

        print("✅ recipes.json FOUND")

        do {
            let data = try Data(contentsOf: url)
            let cleanedData = removeCommentLines(from: data)

            let recipes = try JSONDecoder().decode(
                [Recipe].self,
                from: cleanedData
            )

            print("✅ Recipes loaded:", recipes.count)

            return recipes

        } catch {

            print("❌ JSON Decode Error:", error)

            return []
        }
    }

//    static func loadRecipes() -> [Recipe] {
//
//        guard let url = Bundle.main.url(
//            forResource: "recipes",
//            withExtension: "json"
//        ) else {
//            return []
//        }
//
//        do {
//            let data = try Data(contentsOf: url)
//            let cleanedData = removeCommentLines(from: data)
//
//            return try JSONDecoder().decode(
//                [Recipe].self,
//                from: cleanedData
//            )
//        } catch {
//            print(error)
//            return []
//        }
//    }

    static func searchRecipes(matching selectedIngredients: [Ingredient]) async -> [Recipe] {
        await Task.detached(priority: .userInitiated) {
            await loadRecipes(matching: selectedIngredients)
        }.value
    }

    static func loadRecipes(matching selectedIngredients: [Ingredient]) -> [Recipe] {

        let recipes = loadRecipes()

        print("👀 Selected Ingredients:", selectedIngredients)
        print("👀 Recipes available:", recipes.count)

        guard !selectedIngredients.isEmpty else {
            return recipes
        }
//    static func loadRecipes(matching selectedIngredients: [Ingredient]) -> [Recipe] {
//        let recipes = loadRecipes()
//
//        guard !selectedIngredients.isEmpty else {
//            return recipes
//        }

        let selectedKeys = Set(
            selectedIngredients.flatMap {
                [normalized($0.id), normalized($0.name)]
            }
        )

        return recipes
            .compactMap { recipe -> (recipe: Recipe, matchCount: Int)? in
                let recipeKeys = Set(
                    recipe.ingredients.flatMap {
                        [normalized($0.id), normalized($0.name)]
                    }
                )

                let matchCount = recipeKeys.intersection(selectedKeys).count
                guard matchCount > 0 else {
                    return nil
                }

                return (recipe, matchCount)
            }
            .sorted { first, second in
                if first.matchCount == second.matchCount {
                    let firstCompleteness = Double(first.matchCount) / Double(first.recipe.ingredients.count)
                    let secondCompleteness = Double(second.matchCount) / Double(second.recipe.ingredients.count)
                    if abs(firstCompleteness - secondCompleteness) < 0.0001 {
                        return first.recipe.title < second.recipe.title
                    }
                    return firstCompleteness > secondCompleteness
                }

                return first.matchCount > second.matchCount
            }
            .map(\.recipe)
    }

    private static func normalized(_ value: String) -> String {
        value
            .lowercased()
            .replacingOccurrences(of: "_", with: "-")
            .replacingOccurrences(of: " ", with: "-")
    }

    private static func removeCommentLines(from data: Data) -> Data {
        guard let content = String(data: data, encoding: .utf8) else {
            return data
        }

        let cleanedContent = content
            .split(separator: "\n", omittingEmptySubsequences: false)
            .filter { !$0.trimmingCharacters(in: .whitespaces).hasPrefix("//") }
            .joined(separator: "\n")

        return Data(cleanedContent.utf8)
    }
}
