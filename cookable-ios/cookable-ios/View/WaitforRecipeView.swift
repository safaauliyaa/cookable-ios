//
//  WaitforRecipeView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 18/06/26.
//

import SwiftUI

struct WaitforRecipeView: View {

    @State private var animate = false

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            Text(
                "\(Text("Finding").foregroundStyle(.cookableGreen)) the best"
            )

            Text(
                "\(Text("recipes").foregroundStyle(.cookableGreen)) for you..."
            )

//            Text(displayedText + "|")
//                .font(.system(size: 44, weight: .bold))
//                .foregroundStyle(.clear)
//                .overlay(alignment: .trailing) {
//
//                    Rectangle()
//                        .fill(Color(hex: "1A8917"))
//                        .frame(width: 2, height: 50)
//                        .opacity(showCursor ? 1 : 0)
//                }

        }
        .font(.system(size: 40, weight: .bold))
        .opacity(animate ? 1 : 0.65)
        .animation(
            .easeInOut(duration: 1.2)
                .repeatForever(autoreverses: true),
            value: animate
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    WaitforRecipeView()
}
