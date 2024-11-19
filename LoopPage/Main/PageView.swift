//
//  PageView.swift
//  LoopPage
//
//  Created by IrvingHuang on 2024/11/7.
//
// https://github.com/maxoog/InfiniteGallery/tree/main

import SwiftUI

struct TestPageView: View {
    let count: Int = 8
    
    @State private var currentCard: Int = 0
    
    var body: some View {
        _PagingView(
            config: .init(direction: .horizontal),
            page: $currentCard,
            views: cards
        )
        .animation(.default, value: currentCard)
    }
    
    private var cards: InfiniteArray<AnyView> {
        InfiniteArray(elements: (0 ..< count).map { index in
            AnyView(LabelPageView(pageIndex: index))
        })
    }
}

final class InfiniteArray<Content>: RandomAccessCollection {
    private var elements: [Content]
    
    init(elements: [Content]) {
        self.elements = elements
    }
    
    var startIndex: Int { Int(Int32.min) }
    var endIndex: Int { Int(Int32.max) }
    
    subscript(position: Int) -> Content {
        let index = (elements.count + (position % elements.count)) % elements.count
        return elements[index]
    }
}

