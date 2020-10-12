//
//  SearchView.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import DeclareUI
import KiloLocoKit
import UIKit

protocol SearchViewDelegate: AnyObject {
    func didTapSearch(for searchTerm: String)
}

class SearchView: UIView {

    private lazy var textField = UITextField.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Enter a term"
    }
    
    private lazy var searchButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Search", for: .normal)
        $0.backgroundColor = .systemPurple
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
    }
    
    private lazy var stackView = UIStackView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 16
    }
    
    weak var delegate: SearchViewDelegate?
    
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
        stackView.addArrangedSubviews(textField, searchButton)
        addSubview(stackView)
        
        textField.declare
            .constrainTo(
                .leading,
                .trailing
            )
            .height(40)
        
        searchButton.declare
            .width(150)
            .height(50)
        
        stackView.declare
            .centerVertically()
            .constrainTo(
                .leadingWithOffset(16),
                .trailingWithOffset(16)
            )
    }
    
    @objc
    private func didTapSearchButton() {
        let searchTerm = textField.text ?? ""
        delegate?.didTapSearch(for: searchTerm)
    }
}
