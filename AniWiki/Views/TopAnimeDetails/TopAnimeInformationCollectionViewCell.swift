//
//  TopAnimeInformationCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import UIKit

class TopAnimeInformationCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopAnimeInformationCollectionViewCell"
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    private let episodesLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    private let raitingLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    private let titleEnglishLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    private let titleJapaneseLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    private let studiosLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    private let producersLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.secondaryTextColor
        label.font = UIFont(name: "Poppins-Regular", size: 15)
        label.numberOfLines = 4
        label.textAlignment = .left
        return label
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
        addSubview(rankLabel)
        addSubview(episodesLabel)
        addSubview(durationLabel)
        addSubview(statusLabel)
        addSubview(genresLabel)
        addSubview(raitingLabel)
        addSubview(sourceLabel)
        addSubview(titleEnglishLabel)
        addSubview(titleJapaneseLabel)
        addSubview(studiosLabel)
        addSubview(producersLabel)
        
    }
    
    private func configureConstraints() {
        rankLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        episodesLabel.snp.makeConstraints { make in
            make.top.equalTo(rankLabel.snp.bottom).offset(3)
            make.leading.equalTo(rankLabel)
            make.trailing.equalTo(rankLabel)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.top.equalTo(episodesLabel.snp.bottom).offset(3)
            make.leading.equalTo(episodesLabel)
            make.trailing.equalTo(episodesLabel)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(durationLabel.snp.bottom).offset(3)
            make.leading.equalTo(episodesLabel)
            make.trailing.equalTo(episodesLabel)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(3)
            make.leading.equalTo(episodesLabel)
            make.trailing.equalTo(episodesLabel)
        }
        
        raitingLabel.snp.makeConstraints { make in
            make.top.equalTo(genresLabel.snp.bottom).offset(3)
            make.leading.equalTo(episodesLabel)
            make.trailing.equalTo(episodesLabel)
        }
        
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(raitingLabel.snp.bottom).offset(3)
            make.leading.equalTo(episodesLabel)
            make.trailing.equalTo(episodesLabel)
        }
        
        titleEnglishLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceLabel.snp.bottom).offset(3)
            make.leading.equalTo(episodesLabel)
            make.trailing.equalTo(episodesLabel)
        }
        
        titleJapaneseLabel.snp.makeConstraints { make in
            make.top.equalTo(titleEnglishLabel.snp.bottom).offset(3)
            make.leading.equalTo(episodesLabel)
            make.trailing.equalTo(episodesLabel)
        }
        
        studiosLabel.snp.makeConstraints { make in
            make.top.equalTo(titleJapaneseLabel.snp.bottom).offset(3)
            make.leading.equalTo(episodesLabel)
            make.trailing.equalTo(episodesLabel)
        }
        
        producersLabel.snp.makeConstraints { make in
            make.top.equalTo(studiosLabel.snp.bottom).offset(3)
            make.leading.equalTo(episodesLabel)
            make.trailing.equalTo(episodesLabel)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankLabel.text = nil
        episodesLabel.text = nil
        durationLabel.text = nil
        statusLabel.text = nil
        genresLabel.text = nil
        raitingLabel.text = nil
        sourceLabel.text = nil
        titleEnglishLabel.text = nil
        titleJapaneseLabel.text = nil
        studiosLabel.text = nil
        producersLabel.text = nil
    }
    
    public func configure(with viewModel: TopAnimeInformationCollectionViewCellViewModel) {
        
        let secondaryTextColor = Resources.Colors.primaryTintColor
        
        let rankText = "Rank: #\(viewModel.rank)"
        rankLabel.labelChange(For: rankText, color: secondaryTextColor, from: 5, to: rankText.count - 5)
        
        let episodesText = "Episodes: \(viewModel.episodes)"
        episodesLabel.labelChange(For: episodesText, color: secondaryTextColor, from: 9, to: episodesText.count - 9)
        
        let durationText = "Duration: \(viewModel.duration)"
        durationLabel.labelChange(For: durationText, color: secondaryTextColor, from: 9, to: durationText.count - 9)
        
        let statusText = "Status: \(viewModel.status)"
        statusLabel.labelChange(For: statusText, color: secondaryTextColor, from: 8, to: statusText.count - 8)
        
        let genresText = "Genres: \(viewModel.getGenres())"
        genresLabel.labelChange(For: genresText, color: secondaryTextColor, from: 8, to: genresText.count - 8)
        
        let ratingText = "Rating: \(viewModel.rating)"
        raitingLabel.labelChange(For: ratingText, color: secondaryTextColor, from: 8, to: ratingText.count - 8)
        
        let sourceText = "Source: \(viewModel.source)"
        sourceLabel.labelChange(For: sourceText, color: secondaryTextColor, from: 8, to: sourceText.count - 8)
        
        let titleEnglishText = "Title English: \(viewModel.titleEnglish)"
        titleEnglishLabel.labelChange(For: titleEnglishText, color: secondaryTextColor, from: 14, to: titleEnglishText.count - 14)
        
        let titleJapaneseText = "Title Japanese: \(viewModel.titleJapanese)"
        titleJapaneseLabel.labelChange(For: titleJapaneseText, color: secondaryTextColor, from: 15, to: titleJapaneseText.count - 15)
        
        let studiosText = "Studios: \(viewModel.getStudios())"
        studiosLabel.labelChange(For: studiosText, color: secondaryTextColor, from: 8, to: studiosText.count - 8)
        
        let producersText = "Producers: \(viewModel.getProducers())"
        producersLabel.labelChange(For: producersText, color: secondaryTextColor, from: 10, to: producersText.count - 10)
    }
}
