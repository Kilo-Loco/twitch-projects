//
//  TermDetailsViewController.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import UIKit

class TermDetailsViewController: UIViewController {

    private let term: Term
    private let ui = TermDetailsView()
    
    init(term: Term) {
        self.term = term
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        ui.populate(with: term)
    }
    
}
