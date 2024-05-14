//
//  TopAnimeListView.swift
//  AniWiki
//
//  Created by Erik on 07.05.2024.
//

import UIKit
import SnapKit

protocol TopAnimeListViewDelegate: AnyObject {
    func topAnimeListView(_ topAnimeListView: TopAnimeListView, didSelectAnime anime: Top)
}

final class TopAnimeListView: UIView {
    
    public weak var delegate: TopAnimeListViewDelegate?
    
    private let viewModel = TopListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: TopCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
        setupCollectionView()
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(collectionView)
        addSubview(spinner)
        spinner.startAnimating()
        viewModel.fetchTopAnime()
    }
    
    private func configureConstraints() {
        spinner.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension TopAnimeListView: TopListViewViewModelDelegate {
    func didSelectAnime(_ anime: Top) {
        delegate?.topAnimeListView(self, didSelectAnime: anime)
    }
    
    func didLoadTopAnime() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    
}
