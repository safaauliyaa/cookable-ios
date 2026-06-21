//
//  IngredientInfoSheet.swift
//  cookable-ios
//
//  Created by Safa Auliya on 19/06/26.
//

import SwiftUI

struct IngredientInfoSheet : View {

    @Environment(\.dismiss) private var dismiss
    @Binding var selectedIngredients: [Ingredient]

    var body: some View {

        NavigationStack {

            VStack(spacing: 0) {

                List {

                    ForEach(selectedIngredients) { ingredient in

                        Text(ingredient.name)
                            .font(.body)

                            .swipeActions {

                                Button(
                                    role: .destructive
                                ) {

                                    selectedIngredients.removeAll {
                                        $0.id == ingredient.id
                                    }

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

                    print("Continue")

                } label: {

                    Text("Continue")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            Color(
                                red: 26/255,
                                green: 137/255,
                                blue: 23/255
                            )
                        )
                        .clipShape(Capsule())
                }
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
                    }
                }
            }
        }
    }
}


#Preview {
    IngredientInfoSheet(
        selectedIngredients: .constant([])
    )
}
