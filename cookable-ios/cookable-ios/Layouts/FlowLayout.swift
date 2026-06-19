//
//  FlowLayout.swift
//  cookable-ios
//
//  Created by Safa Auliya Hidayat on 18/06/26.
//

import SwiftUI

struct FlowLayout: Layout {

    var spacing: CGFloat = 8

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {

        let maxWidth = proposal.width ?? 0

        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var rowHeight: CGFloat = 0

        for view in subviews {

            let size = view.sizeThatFits(.unspecified)

            if currentX + size.width > maxWidth {

                currentX = 0
                currentY += rowHeight + spacing
                rowHeight = 0
            }

            currentX += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }

        return CGSize(
            width: maxWidth,
            height: currentY + rowHeight
        )
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {

        var currentX = bounds.minX
        var currentY = bounds.minY
        var rowHeight: CGFloat = 0

        for view in subviews {

            let size = view.sizeThatFits(.unspecified)

            if currentX + size.width > bounds.maxX {

                currentX = bounds.minX
                currentY += rowHeight + spacing
                rowHeight = 0
            }

            view.place(
                at: CGPoint(x: currentX, y: currentY),
                proposal: ProposedViewSize(size)
            )

            currentX += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

#Preview {
    FlowLayout {
        Text("Apple")
        Text("Carrot")
        Text("Tomato")
    }
}
