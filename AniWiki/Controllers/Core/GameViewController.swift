//
//  GameViewController.swift
//  AniWiki
//
//  Created by Erik on 05.05.2024.
//

import UIKit

final class GameViewController: UIViewController {
    private let guessAnimeView = GuessAnimeView()
    private let animesViewModel = GuessAnimeViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = Resources.Colors.primaryBackgroundColor
        setupUI()
        configureConstraints()
        configureAnimeView()
    }
    
    private func setupUI() {
        view.addSubview(guessAnimeView)
    }
    
    private func configureConstraints() {
        guessAnimeView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func configureAnimeView() {
        guessAnimeView.configure(with: animesViewModel)
    }
}
