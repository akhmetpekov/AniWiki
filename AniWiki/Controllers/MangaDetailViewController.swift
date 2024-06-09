//
//  MangaDetailViewController.swift
//  AniWiki
//
//  Created by Erik on 03.06.2024.
//

import UIKit
import SnapKit

class MangaDetailViewController: UIViewController {
    private let viewModel: MangaDetailViewViewModel
    
    private let detailView: MangaDetailView
    
    init(viewModel: MangaDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = MangaDetailView(frame: .zero, viewModel: viewModel)
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

extension MangaDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MangaFullPhotoCollectionViewCell.identifier, for: indexPath) as? MangaFullPhotoCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .title(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MangaFullTitleCollectionViewCell.identifier, for: indexPath) as? MangaFullTitleCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .baseInfo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MangaFullBaseInfoCollectionViewCell.identifier, for: indexPath) as? MangaFullBaseInfoCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .information(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MangaFullInformationCollectionViewCell.identifier, for: indexPath) as? MangaFullInformationCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .description(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MangaFullDescriptionCollectionViewCell.identifier, for: indexPath) as? MangaFullDescriptionCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .genres(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MangaFullGenresCollectionViewCell.identifier, for: indexPath) as? MangaFullGenresCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }

        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MangaDetailSectionHeader.identifier, for: indexPath) as? MangaDetailSectionHeader else {
            fatalError("Cannot dequeue section header")
        }

        let sectionType = viewModel.sections[indexPath.section]
        let sectionTitle: String

        switch sectionType {
        case .photo:
            return UICollectionReusableView()
        case .title:
            return UICollectionReusableView()
        case .baseInfo:
            return UICollectionReusableView()
        case .information:
            sectionTitle = "Information"
        case .description:
            return UICollectionReusableView()
        case .genres:
            return UICollectionReusableView()
        }
        sectionHeader.configureSectionCell(label: sectionTitle.capitalized)
        return sectionHeader
    }
    
    
}

class UIUtility {
    static var tabBarHeight: CGFloat {
        if #available(iOS 15.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }?
                .rootViewController?.tabBarController?.tabBar.frame.height ?? 0
        } else {
            return UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController?.tabBarController?.tabBar.frame.height ?? 0
        }
    }
}
