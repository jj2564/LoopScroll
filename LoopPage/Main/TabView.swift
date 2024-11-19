//
//  MutipleViewPage.swift
//  LoopPage
//
//  Created by IrvingHuang on 2024/11/7.
//

import SwiftUI

class MultipleViewModel: ObservableObject {
    @Published var currentPage: Int = 1
//    var totalPage: Int = 8
}


struct MultipleViewPage: View {
    @EnvironmentObject var viewModel: MultipleViewModel
    
    var body: some View {
        TabView(selection: $viewModel.currentPage) {
            LabelPageView(pageIndex: 8 + 1)
                .tag(0)
            
            ForEach(1...8, id: \.self) { pageIndex in
                LabelPageView(pageIndex: pageIndex)
                    .tag(pageIndex)
            }
            
            LabelPageView(pageIndex: 0)
                .tag(8 + 1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .modifier(
            InfiniteLoopModifier(
                currentPage: $viewModel.currentPage)
        )
        .environment(\.colorScheme, .dark)
    }
}



fileprivate struct InfiniteLoopModifier: ViewModifier {
    @Binding var currentPage: Int
    
    @State private var previousPage: Int?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if previousPage == nil {
                    previousPage = currentPage
                }
            }
            .onChange(of: currentPage) { oldValue, newPage in
                guard newPage != previousPage else { return }
                
                if newPage == 9 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        currentPage = 8
                        
                        DispatchQueue.main.async {
                            previousPage = 8
                            currentPage = 1
                        }
                    }
                }
                else if newPage == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        currentPage = 1
                        
                        DispatchQueue.main.async {
                            previousPage = 1
                            currentPage = 8
                        }
                    }
                } else {
                    previousPage = newPage
                }
            }
    }
}
