//
//  MangaDetailView.swift
//  AniWiki
//
//  Created by Erik on 03.06.2024.
//

import UIKit

final class MangaDetailView: UIView {
    private let viewModel: MangaDetailViewViewModel
    
    var collectionView: UICollectionView?
    
    init(frame: CGRect, viewModel: MangaDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubview(collectionView)
    }
    
    private func configureConstraints() {
        guard let collectionView = collectionView else {
            return
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
        collectionView.register(MangaFullPhotoCollectionViewCell.self, forCellWithReuseIdentifier: MangaFullPhotoCollectionViewCell.identifier)
        collectionView.register(MangaFullTitleCollectionViewCell.self, forCellWithReuseIdentifier: MangaFullTitleCollectionViewCell.identifier)
        collectionView.register(MangaFullBaseInfoCollectionViewCell.self, forCellWithReuseIdentifier: MangaFullBaseInfoCollectionViewCell.identifier)
        collectionView.register(MangaFullInformationCollectionViewCell.self, forCellWithReuseIdentifier: MangaFullInformationCollectionViewCell.identifier)
        collectionView.register(MangaFullDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: MangaFullDescriptionCollectionViewCell.identifier)
        collectionView.register(MangaFullGenresCollectionViewCell.self, forCellWithReuseIdentifier: MangaFullGenresCollectionViewCell.identifier)
        collectionView.register(MangaDetailSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MangaDetailSectionHeader.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = Resources.Colors.primaryBackgroundColor
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section: NSCollectionLayoutSection
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case .photo:
            section = viewModel.createPhotoSection()
        case .title:
            section = viewModel.createTitleSection()
        case .baseInfo:
            section = viewModel.createBaseInfoSection()
        case .information:
            section = viewModel.createInformationSection()
        case .description:
            section = viewModel.createDescriptionSection()
        case .genres:
            section = viewModel.createGenresSection()
        }
        
        if sectionIndex != 0 && sectionIndex != 1 && sectionIndex != 2 && sectionIndex != 4 && sectionIndex != 5{
            section.boundarySupplementaryItems = [viewModel.createHeaderItem()]
        }
        return section
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

