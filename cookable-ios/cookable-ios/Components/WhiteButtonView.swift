//
//  WhiteButtonView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 18/06/26.
//

import SwiftUI

struct WhiteButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action:action) {
            HStack {
                Text(title)
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
//            .background(
//                Capsule()
//                    .fill(Color.white.opacity(0.9))
//            )
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        }
//        .glassEffect()
        .padding(.horizontal)
//        .border(.red)
    }
}


#Preview {
    WhiteButtonView(
        title: "Get Started"
    ) {
        print("Tapped")
    }
    .padding(.horizontal)
}
