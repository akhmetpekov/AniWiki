//
//  TopViewController.swift
//  AniWiki
//
//  Created by Erik on 05.05.2024.
//

import UIKit
import SnapKit

final class TopViewController: UIViewController, TopAnimeListViewDelegate {
    
    private let topAnimeListView = TopAnimeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        topAnimeListView.delegate = self
        view.addSubview(topAnimeListView)
    }
    
    private func configureConstraints() {
        topAnimeListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func topAnimeListView(_ topAnimeListView: TopAnimeListView, didSelectAnime anime: Top) {
        let viewModel = AnimeDetailViewViewModel(anime: anime)
        let detailVC = AnimeDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
