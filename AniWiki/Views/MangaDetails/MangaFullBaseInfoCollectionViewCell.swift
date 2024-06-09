//
//  MangaFullBaseInfoCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 05.06.2024.
//

import UIKit

class MangaFullBaseInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "MangaFullBaseInfoCollectionViewCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .bottom
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let startYearLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = Resources.Colors.unselectedItemColor
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        label.textColor = Resources.Colors.unselectedItemColor
        return label
    }()
    
    private let scoreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        stackView.backgroundColor = .systemPink
        stackView.alignment = .bottom
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont(name: Resources.Fonts.PoppinsSemibold, size: 14)
        label.textColor = Resources.Colors.unselectedItemColor
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let scoredByLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 12)
        label.textColor = Resources.Colors.unselectedItemColor
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(stackView)
        stackView.addArrangedSubview(startYearLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(scoreStackView)
        scoreStackView.addArrangedSubview(starImage)
        scoreStackView.addArrangedSubview(scoreLabel)
        scoreStackView.addArrangedSubview(scoredByLabel)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scoreStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        startYearLabel.text = nil
        typeLabel.text = nil
        scoreLabel.text = nil
        scoredByLabel.text = nil
    }
    
    public func configure(with viewModel: MangaFullBaseInfoCollectionViewCellViewModel) {
        startYearLabel.text = viewModel.year
        typeLabel.text = viewModel.type
        scoreLabel.text = String(viewModel.score)
        scoredByLabel.text = viewModel.scoredByString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
