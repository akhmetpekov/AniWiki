//
//  MangaListView.swift
//  AniWiki
//
//  Created by Erik on 02.06.2024.
//

import UIKit
import SnapKit

protocol MangaListViewDelegate: AnyObject {
    func mangaDetail(_ manga: MangaFull)
}

class MangaListView: UIView {
    
    var collectionView: UICollectionView?
    
    public weak var delegate: MangaListViewDelegate?
    
    private let viewModel = MangaListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSections(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MangaRecommendationsCollectionViewCell.self, forCellWithReuseIdentifier: MangaRecommendationsCollectionViewCell.identifier)
        collectionView.register(MangaTopCollectionViewCell.self, forCellWithReuseIdentifier: MangaTopCollectionViewCell.identifier)
        collectionView.register(MangaSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MangaSectionHeader.identifier)
        collectionView.backgroundColor = Resources.Colors.primaryBackgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    
    private func createSections(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section: NSCollectionLayoutSection
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case .recommendations:
            section = viewModel.createRecommendationsSection()
        case .top:
            section = viewModel.createTopSection()
        }
        
        return section
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
        viewModel.delegate = self
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = Resources.Colors.primaryBackgroundColor
        addSubview(spinner)
        bringSubviewToFront(spinner)
        spinner.startAnimating()
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubview(collectionView)
        viewModel.fetchTopManga()
        viewModel.fetchMangaRecommendations()
    }
    
    private func configureConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        spinner.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.center.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        guard let collectionView = collectionView else {
            return
        }
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension MangaListView: MangaListViewViewModelDelegate {
    func didSelectedManga() {
        spinner.startAnimating()
    }
    
    func didLoadMangaRecommendations(_ manga: MangaFull) {
        delegate?.mangaDetail(manga)
        spinner.stopAnimating()
    }
    
    func didLoadTopManga() {
        spinner.stopAnimating()
        guard let collectionView = collectionView else {
            return
        }
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            collectionView.alpha = 1
        }
    }
}
