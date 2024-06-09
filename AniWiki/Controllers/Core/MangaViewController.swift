//
//  AnimeViewController.swift
//  AniWiki
//
//  Created by Erik on 05.05.2024.
//

import UIKit
import SnapKit

final class MangaViewController: UIViewController, MangaListViewDelegate {
    
    private let mangaListView = MangaListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = Resources.Colors.primaryBackgroundColor
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        mangaListView.delegate = self
        view.addSubview(mangaListView)
    }
    
    private func configureConstraints() {
        mangaListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func mangaDetail(_ manga: MangaFull) {
        let viewModel = MangaDetailViewViewModel(manga: manga)
        let detailVC = MangaDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
