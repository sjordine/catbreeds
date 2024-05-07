//
//  CatListView.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 07/05/24.
//

import UIKit

class CatListView: UIView {

    init() {
            // Chamamos um método da UIView para inicialização
            super.init(frame: .zero)
        }

        // O método a seguir é obrigatório na classe UIView
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func setup() {
        self.backgroundColor = .red
    }

}
