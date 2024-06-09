//
//  MangaFullInformationCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 06.06.2024.
//

import UIKit

class MangaFullInformationCollectionViewCell: UICollectionViewCell {
    static let identifier = "MangaFullInformationCollectionViewCell"
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = Resources.Colors.unselectedItemColor
        label.text = "Title Status"
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let chaptersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = Resources.Colors.unselectedItemColor
        label.text = "Uploaded chapters"
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let favouritesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = Resources.Colors.unselectedItemColor
        label.text = "Favourites number"
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = Resources.Colors.unselectedItemColor
        label.text = "Author"
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = Resources.Colors.unselectedItemColor
        label.text = "Publisher"
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let statusText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let chaptersText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let favouritesText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let authorText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let publisherText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        addSubview(statusLabel)
        addSubview(chaptersLabel)
        addSubview(favouritesLabel)
        addSubview(authorLabel)
        addSubview(publisherLabel)
        addSubview(statusText)
        addSubview(chaptersText)
        addSubview(favouritesText)
        addSubview(authorText)
        addSubview(publisherText)
    }
    
    private func configureConstraints() {
        statusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        statusText.snp.makeConstraints { make in
            make.leading.equalTo(statusLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview()
        }
        
        chaptersLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusLabel)
            make.top.equalTo(statusLabel.snp.bottom).offset(4)
            make.width.equalTo(statusLabel)
        }
        
        chaptersText.snp.makeConstraints { make in
            make.leading.equalTo(chaptersLabel.snp.trailing)
            make.top.equalTo(statusText.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        favouritesLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusLabel)
            make.top.equalTo(chaptersLabel.snp.bottom).offset(4)
            make.width.equalTo(chaptersLabel)
        }
        
        favouritesText.snp.makeConstraints { make in
            make.leading.equalTo(chaptersLabel.snp.trailing)
            make.top.equalTo(chaptersText.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusLabel)
            make.top.equalTo(favouritesLabel.snp.bottom).offset(4)
            make.width.equalTo(favouritesLabel)
        }
        
        authorText.snp.makeConstraints { make in
            make.leading.equalTo(chaptersLabel.snp.trailing)
            make.top.equalTo(favouritesText.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        publisherLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusLabel)
            make.top.equalTo(authorLabel.snp.bottom).offset(4)
            make.width.equalTo(authorLabel)
        }
        
        publisherText.snp.makeConstraints { make in
            make.leading.equalTo(chaptersLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalTo(authorText.snp.bottom).offset(4)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    public func configure(with viewModel: MangaFullInformationCollectionViewCellViewModel) {
        statusText.text = viewModel.statusConverted
        chaptersText.text = String(viewModel.chapters)
        favouritesText.text = String(viewModel.favorites)
        authorText.text = viewModel.authorsConverted
        publisherText.text = viewModel.publlishersConverted
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
