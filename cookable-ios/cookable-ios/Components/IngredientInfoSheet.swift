//
//  IngredientInfoSheet.swift
//  cookable-ios
//
//  Created by Safa Auliya on 19/06/26.
//

import SwiftUI

struct IngredientInfoSheet : View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appState: AppState

    var body: some View {

        NavigationStack {

            VStack(spacing: 0) {

                List {

                    ForEach(appState.currentIngredients) { ingredient in

                        Text(ingredient.name)
                            .font(.body)

                            .swipeActions {

                                Button(
                                    role: .destructive
                                ) {

                                    appState.removeIngredient(ingredient)

                                } label: {

                                    Label(
                                        "Delete",
                                        systemImage: "trash"
                                    )
                                }
                            }
                    }
                }
                .listStyle(.plain)
                
                Spacer()

                Button {
                    dismiss()
                    appState.startRecipeSearch()
                } label: {

                    Text("Find Recipes")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .glassEffect(
                            .regular.tint(.cookableGreen).interactive(),
                            in: Capsule()
                        )
                }
                .buttonStyle(.plain)
                .disabled(appState.currentIngredients.isEmpty)
                .opacity(appState.currentIngredients.isEmpty ? 0.5 : 1)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .padding()
            .navigationTitle("Current Ingredients")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    IngredientInfoSheet()
        .environmentObject(AppState())
}
