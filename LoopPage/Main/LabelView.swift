//
//  LabelView.swift
//  LoopPage
//
//  Created by IrvingHuang on 2024/11/7.
//

import SwiftUI

struct LabelPageView: View {
    
    let pageIndex: Int
    
    var body: some View {
        viewcell
    }
    
    @ViewBuilder
    private var viewcell: some View {
        LabelViewWrapper(pageIndex: pageIndex)
    }
}


class LabelView: UIView, ObservableObject {
    var pageIndex: Int {
        didSet { numberLabel.text = "\(pageIndex)" }
    }
    let uuid = UUID()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(pageIndex: Int) {
        self.pageIndex = pageIndex
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        numberLabel.text = "\(pageIndex)"
        addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    deinit { }
}


struct LabelViewWrapper: UIViewRepresentable {
    let pageIndex: Int
    
    @StateObject private var labelView = LabelView(pageIndex: 0)
    func makeUIView(context: Context) -> LabelView {
        labelView.pageIndex = pageIndex
        print("page \(pageIndex) | \(labelView.uuid) | makeUIView")
        return labelView
    }
    
    func updateUIView(_ labelView: LabelView, context: Context) {
    }
    
    static func dismantleUIView(_ labelView: LabelView, coordinator: Void) {
        print("page \(labelView.pageIndex) | \(labelView.uuid) | dismantleUIView")
    }
}
