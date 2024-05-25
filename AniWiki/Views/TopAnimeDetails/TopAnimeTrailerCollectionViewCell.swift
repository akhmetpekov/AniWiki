//
//  TopAnimeTrailerCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import UIKit
import youtube_ios_player_helper

class TopAnimeTrailerCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopAnimeTrailerCollectionViewCell"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var videoPlayer: YTPlayerView = {
        let player = YTPlayerView()
        return player
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(spinner)
        spinner.startAnimating()
        addSubview(videoPlayer)
        videoPlayer.delegate = self
    }
    
    private func configureConstraints() {
        spinner.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
        
        videoPlayer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: TopAnimeTrailerCollectionViewCellViewModel) {
        guard let videoID = viewModel.getTrailerID() else { return }
        videoPlayer.load(withVideoId: videoID)
    }
}

extension TopAnimeTrailerCollectionViewCell: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        spinner.stopAnimating()
    }
}
