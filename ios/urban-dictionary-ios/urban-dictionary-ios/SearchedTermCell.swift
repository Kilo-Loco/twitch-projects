//
//  SearchedTermCell.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import DeclareUI
import KiloLocoKit
import UIKit

class SearchedTermCell: UITableViewCell {
    
    private lazy var label = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureSubviews() {
        contentView.addSubview(label)
        
        label.declare.toSuperviewGuide()
    }
    
    func populate(with searchedTerm: SearchedTerm) {
        label.text = searchedTerm.value
    }
    
}

extension SearchedTermCell: Reusable {}
