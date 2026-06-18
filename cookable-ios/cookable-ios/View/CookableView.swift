//
//  CookableView.swift
//  cookable-ios
//
//  Created by Safa Auliya Hidayat on 18/06/26.
//

import SwiftUI

struct CookableView: View {
    private let fullText = "Cookable."

    @State private var displayedText = ""
    @State private var showCursor = true

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(displayedText.enumerated()), id: \.offset) { _, char in
                Text(String(char))
                    .foregroundColor(
                        displayedText.prefix(displayedText.distance(from: displayedText.startIndex, to: displayedText.firstIndex(of: char) ?? displayedText.startIndex) + 1).count <= 4
                        ? Color(hex: "1A8917")
                        : Color(hex: "1A1A1A")
                    )
            }

            Rectangle()
                .fill(Color(hex: "1A8917"))
                .frame(width: 2, height: 60)
                .opacity(showCursor ? 1 : 0)
        }
        .font(.system(size: 52, weight: .bold))
        .onAppear {
            startTyping()

            withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                showCursor.toggle()
            }
        }
    }

    private func startTyping() {
        displayedText = ""

        for (index, character) in fullText.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.12) {
                displayedText.append(character)
            }
        }
    }
}

#Preview {
    CookableView()
}
