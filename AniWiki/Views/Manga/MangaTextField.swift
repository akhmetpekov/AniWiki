//
//  TopAnimeSearchTextField.swift
//  AniWiki
//
//  Created by Erik on 01.06.2024.
//

import UIKit

class MangaTextField: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        placeholder = "Manga"
        backgroundColor = Resources.Colors.primaryBackgroundColor
        barTintColor = Resources.Colors.primaryBackgroundColor
    }
    
    override func layoutSubviews() {
        
    }
    
    private func configureConstraints() {
        
    }
}
