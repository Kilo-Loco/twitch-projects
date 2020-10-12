//
//  HistoryView.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import DeclareUI
import KiloLocoKit
import UIKit

class HistoryView: UIView {

    private lazy var tableView = UITableView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(
            SearchedTermCell.self,
            forCellReuseIdentifier: SearchedTermCell.reuseIdentifier
        )
    }
    
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
        addSubview(tableView)
        
        tableView.declare.toSuperviewGuide()
    }
    
    func bindTableView<Manager: UITableViewDataSource & UITableViewDelegate>(to manager: Manager) {
        tableView.dataSource = manager
        tableView.delegate = manager
    }
    
    func reload() {
        tableView.reloadData()
    }

}
