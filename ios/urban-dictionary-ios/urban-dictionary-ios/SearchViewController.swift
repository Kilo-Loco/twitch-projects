//
//  SearchViewController.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import Amplify
import Combine
import UIKit

class SearchViewController: UIViewController {

    private var tokens = Set<AnyCancellable>()
    
    private let ui = SearchView()
    
    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    private func configureView() {
        ui.delegate = self
    }
    
    private func updateHistory(with searchTerm: String) {
        let searchedTerm = SearchedTerm(value: searchTerm)
        
        Amplify.DataStore.save(searchedTerm)
            .sink { (completion) in
                print(completion)
            } receiveValue: { result in
                print("Added \(searchedTerm.value) to history")
            }
            .store(in: &tokens)
    }
    
    private func navigateToResult(for searchTerm: String) {
        let termsVC = TermsViewController(searchTerm: searchTerm)
        navigationController?.pushViewController(termsVC, animated: true)
    }
}

extension SearchViewController: SearchViewDelegate {
    func didTapSearch(for searchTerm: String) {
        updateHistory(with: searchTerm)
        navigateToResult(for: searchTerm)
    }
}
