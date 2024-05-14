//
//  AnimeDetailViewController.swift
//  AniWiki
//
//  Created by Erik on 13.05.2024.
//

import UIKit

final class AnimeDetailViewController: UIViewController {
    private let viewModel: AnimeDetailViewViewModel
    
    init(viewModel: AnimeDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
}
