//
//  CatListView.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 07/05/24.
//

import UIKit

class CatListView: UIView {
    
    private lazy var breedList: UITableView = {
        return UITableView()
    }()
    
    init() {
        // Chamamos um método da UIView para inicialização
        super.init(frame: .zero)
        
        setupView()
    }
    
    // O método a seguir é obrigatório na classe UIView
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {

    }
    
    private func setupView() {
        setupSubviews()
        setupLayout()
    }
    
    private func setupSubviews() {
        breedList.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(breedList)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            breedList.topAnchor.constraint(equalTo: self.topAnchor),
            breedList.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            breedList.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            breedList.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}


