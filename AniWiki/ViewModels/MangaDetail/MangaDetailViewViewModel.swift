//
//  MangaDetailViewViewModel.swift
//  AniWiki
//
//  Created by Erik on 03.06.2024.
//

import UIKit

final class MangaDetailViewViewModel: NSObject {
    enum MangaFullSectionTypes {
        case photo(viewModel: MangaFullPhotoCollectionViewCellViewModel)
        case title(viewModel: MangaFullTitleCollectionViewCellViewModel)
        case baseInfo(viewModel: MangaFullBaseInfoCollectionViewCellViewModel)
        case information(viewModel: MangaFullInformationCollectionViewCellViewModel)
        case description(viewModel: MangaFullDescriptionCollectionViewCellViewModel)
        case genres(viewModel: MangaFullGenresCollectionViewCellViewModel)
    }
    
    private let manga: MangaFull
    public var sections: [MangaFullSectionTypes] = []
    public var sectionTitles: [String] = []
        
    init(manga: MangaFull) {
        self.manga = manga
        super.init()
        setupSections()
    }
    
    private func setupSections() {
        guard let imageUrl = manga.images?.jpg?.largeImageURL, let mangaName = manga.title, let mangaSecondTitle = manga.titleJapanese else { return }
        guard let startDate = manga.published?.prop?.from?.year, let type = manga.type, let score = manga.score, let scoredBy = manga.scoredBy else { return }
        let status = manga.status ?? "Null"
        let chapters = manga.chapters ?? 0
        let favorites = manga.favorites ?? 0
        let authors = manga.authors ?? nil
        let publishing = manga.serializations ?? nil
        let synopsis = manga.synopsis ?? ""
        guard let genres = manga.genres else { return }
        sections.append(.photo(viewModel: MangaFullPhotoCollectionViewCellViewModel(imageUrl: URL(string: imageUrl))))
        sections.append(.title(viewModel: MangaFullTitleCollectionViewCellViewModel(title: mangaName, secondTitle: mangaSecondTitle)))
        sections.append(.baseInfo(viewModel: MangaFullBaseInfoCollectionViewCellViewModel(startDate: startDate, type: type, score: score, scoredBy: scoredBy)))
        sections.append(.information(viewModel: MangaFullInformationCollectionViewCellViewModel(status: status, chapters: chapters, favorites: favorites, authors: authors, publishers: publishing)))
        sections.append(.description(viewModel: MangaFullDescriptionCollectionViewCellViewModel(synopsis: synopsis)))
        sections.append(.genres(viewModel: MangaFullGenresCollectionViewCellViewModel(genres: genres)))
        
        sectionTitles.append("Information")
    }
    
    public var title: String? {
        manga.title
    }
    
    public func createPhotoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(300)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createTitleSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(70)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createBaseInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(30)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInformationSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(140)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeaderItem()]
        return section
    }
    
    public func createDescriptionSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(175)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createGenresSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return header
    }
    
    
}
