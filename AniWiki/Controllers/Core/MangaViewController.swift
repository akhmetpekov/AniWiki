//
//  AnimeViewController.swift
//  AniWiki
//
//  Created by Erik on 05.05.2024.
//

import UIKit

final class MangaViewController: UIViewController {
    private let searchTextField = MangaTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Resources.Colors.primaryBackgroundColor
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        view.addSubview(searchTextField)
    }
    
    private func configureConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(40)
        }
    }
}
