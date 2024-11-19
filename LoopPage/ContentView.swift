//
//  ContentView.swift
//  LoopPage
//
//  Created by IrvingHuang on 2024/11/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        MultipleViewPage()
        TestInfinite()
//        TestPageView()
            .environmentObject(MultipleViewModel())
    }
}
