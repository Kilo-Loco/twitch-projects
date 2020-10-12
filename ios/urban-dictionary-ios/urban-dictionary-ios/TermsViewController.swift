//
//  TermsViewController.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import Combine
import UIKit

class TermsViewController: UIViewController {
    
    private var tokens = Set<AnyCancellable>()
    private var terms = [Term]()

    private let collectionViewManager = TermsCollectionViewManager()
    private let networkingService = NetworkingService()
    private let searchTerm: String
    private let ui = TermsView()
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = searchTerm
        configureView()
        getTerms()
    }

    private func configureView() {
        ui.bindCollectionView(to: collectionViewManager)
        configureManager()
    }
    
    private func configureManager() {
        collectionViewManager.cellForRow = { collectionView, indexPath, term in
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TermCell.reuseIdentifier,
                for: indexPath
            )
            
            let termCell = cell as? TermCell
            termCell?.populate(with: term)
            
            return cell
        }
        
        collectionViewManager.selectedItemPublisher
            .sink { [weak self] indexPath in
                guard let term = self?.terms[indexPath.item] else { return }
                self?.navigateToDetails(for: term)
            }
            .store(in: &tokens)
    }
    
    private func getTerms() {
        networkingService.define(searchTerm) { [weak self] result in
            switch result {
            case .success(let terms):
                self?.terms = terms
                self?.collectionViewManager.set(terms)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func navigateToDetails(for term: Term) {
        let termDetailsVC = TermDetailsViewController(term: term)
        navigationController?.pushViewController(termDetailsVC, animated: true)
    }
}
