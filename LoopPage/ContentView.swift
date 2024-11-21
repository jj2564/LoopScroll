//
//  ContentView.swift
//  LoopPage
//
//  Created by IrvingHuang on 2024/11/7.
//

import SwiftUI

struct ContentView: View {
    @StateObject var multipleViewModel: MultipleViewModel = MultipleViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink {
                    MultipleViewPage()
                        .environmentObject(multipleViewModel)
                } label: {
                    Text("Go to Multiple View Page")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink {
                    TestInfinite()
                        .environmentObject(multipleViewModel)
                } label: {
                    Text("Go to Test Infinite")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink {
                    TestPageView()
                        .environmentObject(multipleViewModel)
                } label: {
                    Text("Go to Test Page View")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
