//
//  TopAnimeSearchBar.swift
//  AniWiki
//
//  Created by Erik on 01.06.2024.
//

import UIKit
import Combine

class TopAnimeSearchBar: UICollectionReusableView {
    static let identifier = "TopAnimeSearchBar"
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search anime"
        searchBar.backgroundColor = Resources.Colors.primaryBackgroundColor
        searchBar.barTintColor = Resources.Colors.primaryBackgroundColor
        searchBar.returnKeyType = .done
        searchBar.autocorrectionType = .no
        searchBar.tintColor = Resources.Colors.primaryTintColor
        return searchBar
    }()
    
    var textPublisher: AnyPublisher<String, Never> {
        searchBar.searchTextField.textPublisher
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(searchBar)
    }
    
    private func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
