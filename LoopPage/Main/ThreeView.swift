//
//  ThreeView.swift
//  LoopPage
//
//  Created by IrvingHuang on 2024/11/7.
//

import SwiftUI

struct InfiniteTabPageView<Content: View>: View {
    @GestureState private var dragTranslation: CGFloat = .zero
    @State private var offset: CGFloat = .zero
    @State private var width: CGFloat = .zero
    private let animationDuration: CGFloat = 0.1
    
    @Binding var currentPage: Int
    let count: Int
    let content: (_ page: Int) -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let width = geometry.size.width
                
                content(pageIndex(currentPage + 1))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(x: width)
                    .id("right")
                
                content(pageIndex(currentPage - 1))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(x: -width)
                    .id("left")
                
                content(pageIndex(currentPage))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(x: 0)
                    .id("center")
            }
            .onAppear {
                width = geometry.size.width
            }
            .onChange(of: geometry.size.width) {
                width = $1
            }
            .contentShape(Rectangle())
            .offset(x: dragTranslation + offset)
            .gesture(dragGesture)
            .clipped()
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .updating($dragTranslation) { value, state, _ in
                let translation = min(width, max(-width, value.translation.width))
                state = translation
            }
            .onEnded { value in
                let dragThreshold = width / 4
                let predictEndOffset = value.predictedEndTranslation.width
                offset = min(width, max(-width, value.translation.width))
                
                let movement = if offset < -dragThreshold || predictEndOffset < -width {
                    1 // foward
                } else if offset > dragThreshold || predictEndOffset > width {
                    -1 // back
                } else {
                    0
                }
                
                let targetOffset = CGFloat(movement) * -width
                withAnimation(.easeOut(duration: animationDuration)) {
                    offset = targetOffset
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                    currentPage = pageIndex(currentPage + movement)
                    offset = 0
                }
            }
    }
    
    private func pageIndex(_ x: Int) -> Int {
        (x + count) % count
    }
}

struct TestInfinite: View {
    let count = 8
    @State private var currentPage: Int = 0
    
    var body: some View {
        InfiniteTabPageView(currentPage: $currentPage, count: count) { pageIndex in
            VStack {
                LabelPageView(pageIndex: pageIndex)
                    .id(pageIndex)
            }
        }
    }
}

#Preview {
    TestInfinite()
}
