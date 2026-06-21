//
//  DetailRecipeView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct DetailRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appState: AppState

    @State private var hasReachedBottom = false

    let recipe: Recipe

    private let allIngredients = IngredientRepository.loadIngredients()

    var body: some View {

        ZStack(alignment: .topLeading) {

            ScrollView {
                VStack(spacing: 24) {

                    RecipeHeaderImage(recipe: recipe)
                    RecipeInfo(recipe: recipe)
                    IngredientsDetail(
                        recipe: recipe,
                        allIngredients: allIngredients
                    )

                    InstructionsDetail(recipe: recipe)

                    GeometryReader { proxy in
                        Color.clear
                            .preference(
                                key: ScrollOffsetKey.self,
                                value: proxy.frame(in: .global).maxY
                            )
                    }
                    .frame(height: 1)
                }
                .padding(.bottom, 40)
            }

            .onPreferenceChange(ScrollOffsetKey.self) { _ in
                DispatchQueue.main.async {
                    hasReachedBottom = true
                }
            }

            .ignoresSafeArea()
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
            .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
        }

        .safeAreaInset(edge: .bottom) {

            VStack(spacing: 8) {

                Button {
                    appState.finishRecipeFlow()
                } label: {
                    Text("Finish")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .glassEffect(
                            .regular.tint(.cookableGreen).interactive(),
                            in: Capsule()
                        )
                }
                .disabled(!hasReachedBottom)
                .opacity(hasReachedBottom ? 1 : 0.4)
                .animation(.easeInOut, value: hasReachedBottom)

             
                if !hasReachedBottom {
                    Text("Scroll to the end to finish cooking 👇")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 12)
            .background(.ultraThinMaterial)
        }

        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    DetailRecipeView(recipe: Recipe.mock)
        .environmentObject(AppState())
}
