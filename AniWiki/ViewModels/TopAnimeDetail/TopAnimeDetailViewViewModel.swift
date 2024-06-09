//
//  AnimeDetailViewViewModel.swift
//  AniWiki
//
//  Created by Erik on 13.05.2024.
//

import UIKit

final class TopAnimeDetailViewViewModel {
    private let anime: UniObject
    
    enum AnimeDetailSectionType {
        case photo(viewModel: TopAnimePhotoCollectionViewCellViewModel)
        case trailer(viewModel: TopAnimeTrailerCollectionViewCellViewModel)
        case information(viewModel: TopAnimeInformationCollectionViewCellViewModel)
        case description(viewModel: TopAnimeDescriptionCollectionViewCellViewModel)
    }
    
    public var sections: [AnimeDetailSectionType] = []
    public var sectionTitles: [String] = []
    
    init(anime: UniObject) {
        self.anime = anime
        setupSections()
    }
    
    private func setupSections() {
        guard let imageUrl = anime.images?.jpg?.largeImageURL else { return }
        let trailerID = anime.trailer?.youtubeID ?? ""
        let type = anime.type ?? ""
        let episodes = anime.episodes ?? 0
        let duration = anime.duration ?? ""	
        let status = anime.status ?? ""
        let source = anime.source ?? ""
        let rating = anime.rating ?? ""
        let titleDefault = anime.title ?? ""
        let titleEnglish = anime.titleEnglish ?? ""
        let titleJapanese = anime.titleJapanese ?? ""
        let year = anime.year ?? 0
        guard let genres = anime.genres else { return }
        let score = anime.score ?? 0
        let scoredBy = anime.scoredBy ?? 0
        let rank = anime.rank ?? 0
        guard let studios = anime.studios else { return }
        let description = anime.synopsis ?? ""
        guard let producers = anime.producers else { return }
        
        sections.append(.photo(viewModel: .init(imageUrl: URL(string: imageUrl), animeName: titleDefault, genres: genres, year: year, type: type, score: score, scoredBy: scoredBy)))

        if !description.isEmpty {
            sections.append(.description(viewModel: .init(description: description)))
        }
        
        if !trailerID.isEmpty {
            sections.append(.trailer(viewModel: .init(trailerID: trailerID)))
        }
        sections.append(.information(viewModel: .init(episodes: episodes, duration: duration, status: status, source: source, titleEnglish: titleEnglish, titleJapanese: titleJapanese, rating: rating, genres: genres, rank: rank, studios: studios, producers: producers)))
        
        if !description.isEmpty {
            sectionTitles.append("Description")
        }
        
        if !trailerID.isEmpty {
            sectionTitles.append("Trailer")
        }
        
        sectionTitles.append("Information")
        
    }
    
    public var title: String? {
        anime.title
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
                heightDimension: .absolute(520)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createTrailerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(250)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeaderItem()]
        return section
    }
    
    public func createInformationSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(340)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createDescriptionSection() -> NSCollectionLayoutSection {
        let heightDimension = NSCollectionLayoutDimension.estimated(150)
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: heightDimension
            )
        )
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: heightDimension
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    public func createHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return header
    }
}
