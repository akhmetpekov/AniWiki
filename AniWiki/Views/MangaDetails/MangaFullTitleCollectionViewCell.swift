//
//  MangaFullTitleCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 05.06.2024.
//

import UIKit

class MangaFullTitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "MangaFullTitleCollectionViewCell"
    
    private let mangaName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: Resources.Fonts.AntonioBold, size: 23)
        label.textColor = .white
        return label
    }()
    
    private let mangaSecondName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: Resources.Fonts.PoppinsLight, size: 13)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        backgroundColor = Resources.Colors.primaryBackgroundColor
        addSubview(mangaName)
        addSubview(mangaSecondName)
    }
    
    private func configureConstraints() {
        mangaName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        mangaSecondName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.top.equalTo(mangaName.snp.bottom).offset(10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mangaName.text = nil
        mangaSecondName.text = nil
    }
    
    public func configure(with viewModel: MangaFullTitleCollectionViewCellViewModel) {
        mangaName.text = viewModel.title
        mangaSecondName.text = viewModel.secondTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
