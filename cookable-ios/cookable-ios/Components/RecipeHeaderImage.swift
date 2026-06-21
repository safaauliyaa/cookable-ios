//
//  RecipeHeaderImage.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct RecipeHeaderImage: View {
    @Environment(\.dismiss) private var dismiss

    let recipe: Recipe

    var body: some View {

        ZStack(alignment: .topLeading) {

            Image(recipe.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 320)
                .clipped()
                .clipShape(
                    UnevenRoundedRectangle(
                        bottomLeadingRadius: 36,
                        bottomTrailingRadius: 36
                    )
                )
            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                            .background(.ultraThinMaterial)
                            .overlay {
                                        Circle()
                                            .stroke(.white.opacity(0.3), lineWidth: 1)
                                    }
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
//                .background(
//                    Color(red: 248/255, green: 250/255, blue: 247/255)
//                        .ignoresSafeArea(edges: .top)
//                )
            }
        }
    }
}

#Preview {
    RecipeHeaderImage(recipe: Recipe.mock)
}
