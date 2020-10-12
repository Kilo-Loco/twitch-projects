//
//  HistoryViewController.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import Amplify
import Combine
import UIKit

class HistoryViewController: UIViewController {
    
    private var tokens = Set<AnyCancellable>()
    private var searchedTerms = [SearchedTerm]()
    private let ui = HistoryView()

    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHistory()
    }
    
    private func configureUI() {
        ui.bindTableView(to: self)
    }

    
    private func getHistory() {
        Amplify.DataStore.query(
            SearchedTerm.self,
            sort: .descending(SearchedTerm.keys.id)
        )
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { print($0) },
                receiveValue: { [weak self] searchedTerms in
                    self?.searchedTerms = searchedTerms
                    self?.ui.reload()
                }
            )
            .store(in: &tokens)
    }

    private func navigateToResults(for searchedTerm: SearchedTerm) {
        let termsVC = TermsViewController(searchTerm: searchedTerm.value)
        navigationController?.pushViewController(termsVC, animated: true)
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedTerms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchedTermCell.reuseIdentifier,
            for: indexPath
        )
        
        let searchedTerm = searchedTerms[indexPath.row]
        let searchedTermCell = cell as? SearchedTermCell
        searchedTermCell?.populate(with: searchedTerm)
        
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchedTerm = searchedTerms[indexPath.row]
        navigateToResults(for: searchedTerm)
    }
}
