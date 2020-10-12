//
//  TermsView.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import KiloLocoKit
import UIKit

class TermsView: UIView {

    private lazy var collectionView: UICollectionView = {
        
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        
        let layout =  UICollectionViewCompositionalLayout.list(using: config)
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            TermCell.self,
            forCellWithReuseIdentifier: TermCell.reuseIdentifier
        )
        
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        configureSelf()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureSelf() {
        backgroundColor = .systemBackground
    }
    
    private func configureSubviews() {
        addSubview(collectionView)
        
        collectionView.declare.toSuperview()
    }
    
    func bindCollectionView(to manager: TermsCollectionViewManager) {
        manager.manage(collectionView)
    }
}
