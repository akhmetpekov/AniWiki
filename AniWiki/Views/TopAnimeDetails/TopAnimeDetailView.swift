//
//  AnimeDetailView.swift
//  AniWiki
//
//  Created by Erik on 13.05.2024.
//

import UIKit

final class TopAnimeDetailView: UIView {
    private let viewModel: TopAnimeDetailViewViewModel
    
    var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init(frame: CGRect, viewModel: TopAnimeDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        backgroundColor = .systemPurple
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubview(collectionView)
        addSubview(spinner)
    }
    
    private func configureConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        
        spinner.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TopAnimePhotoCollectionViewCell.self, forCellWithReuseIdentifier: TopAnimePhotoCollectionViewCell.identifier)
        collectionView.register(TopAnimeDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: TopAnimeDescriptionCollectionViewCell.identifier)
        collectionView.register(TopAnimeTrailerCollectionViewCell.self, forCellWithReuseIdentifier: TopAnimeTrailerCollectionViewCell.identifier)
        collectionView.register(TopAnimeInformationCollectionViewCell.self, forCellWithReuseIdentifier: TopAnimeInformationCollectionViewCell.identifier)
        collectionView.register(TopAnimeSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TopAnimeSectionHeader.identifier)
        collectionView.backgroundColor = Resources.Colors.primaryBackgroundColor
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section: NSCollectionLayoutSection
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case .photo:
            section = viewModel.createPhotoSection()
        case .description:
            section = viewModel.createDescriptionSection()
        case .trailer:
            section = viewModel.createTrailerSection()
        case .information:
            section = viewModel.createInformationSection()
        }
        
        if sectionIndex != 0 {
            section.boundarySupplementaryItems = [viewModel.createHeaderItem()]
        }
        return section
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
