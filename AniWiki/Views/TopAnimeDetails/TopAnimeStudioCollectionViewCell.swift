//
//  TopAnimeStudioCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import UIKit

class TopAnimeStudioCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopAnimeStudioCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
    }
    
    private func configureConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: TopAnimeStudioCollectionViewCellViewModel) {
        
    }
}