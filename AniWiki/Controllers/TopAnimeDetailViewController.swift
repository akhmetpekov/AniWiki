//
//  AnimeDetailViewController.swift
//  AniWiki
//
//  Created by Erik on 13.05.2024.
//

import UIKit

final class TopAnimeDetailViewController: UIViewController {
    private let viewModel: TopAnimeDetailViewViewModel
    
    private let detailView: TopAnimeDetailView
    
    init(viewModel: TopAnimeDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = TopAnimeDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    private func setupUI() {
        title = viewModel.title
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
    }
    
    private func configureConstraints() {
        detailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
}

extension TopAnimeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .trailer:
            return 1
        case .information:
            return 1
        case .raiting:
            return 1
        case .studio:
            return 1
        case .description:
            return 1
        case .producers:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopAnimePhotoCollectionViewCell.identifier, for: indexPath) as? TopAnimePhotoCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .trailer(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopAnimeTrailerCollectionViewCell.identifier, for: indexPath) as? TopAnimeTrailerCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .information(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopAnimeInformationCollectionViewCell.identifier, for: indexPath) as? TopAnimeInformationCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .raiting(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopAnimeRaitingCollectionViewCell.identifier, for: indexPath) as? TopAnimeRaitingCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .studio(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopAnimeStudioCollectionViewCell.identifier, for: indexPath) as? TopAnimeStudioCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .description(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopAnimeDescriptionCollectionViewCell.identifier, for: indexPath) as? TopAnimeDescriptionCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .producers(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopAnimeProducersCollectionViewCell.identifier, for: indexPath) as? TopAnimeProducersCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }

        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TopAnimeSectionHeader.identifier, for: indexPath) as? TopAnimeSectionHeader else {
            fatalError("Cannot dequeue section header")
        }

        let sectionType = viewModel.sections[indexPath.section]
        let sectionTitle: String

        switch sectionType {
        case .photo:
            return UICollectionReusableView()
        case .trailer:
            sectionTitle = "Trailer"
        case .information:
            sectionTitle = "Information"
        case .raiting:
            sectionTitle = "Raiting"
        case .studio:
            sectionTitle = "Studio"
        case .description:
            sectionTitle = "Description"
        case .producers:
            sectionTitle = "Producers"
        }
        sectionHeader.configureSectionCell(label: sectionTitle.capitalized)
        return sectionHeader
    }
    
}
