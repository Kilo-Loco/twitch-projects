//
//  TermCell.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import DeclareUI
import KiloLocoKit
import UIKit

class TermCell: UICollectionViewCell {
    private lazy var wordLabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.adjustsFontForContentSizeCategory = true
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    private lazy var definitionLabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.adjustsFontForContentSizeCategory = true
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    private lazy var stackView = UIStackView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubViews() {
        stackView.addArrangedSubviews(wordLabel, definitionLabel)
        contentView.addSubview(stackView)
        
        stackView.declare.toSuperviewGuide()
    }
    
    func populate(with term: Term) {
        wordLabel.text = term.word
        definitionLabel.text = term.strippedDefinition
    }
}


extension TermCell: Reusable {}
