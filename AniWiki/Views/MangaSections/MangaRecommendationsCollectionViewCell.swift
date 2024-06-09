//
//  MangaRecommendationsCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 02.06.2024.
//

import UIKit

class MangaRecommendationsCollectionViewCell: UICollectionViewCell {
    static let identifier = "MangaRecommendationsCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let blackView: UIView = {
        let someView = UIView()
        someView.backgroundColor = .black
        someView.alpha = 0.5
        return someView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Antonio-Bold", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupU()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupU() {
        contentView.addSubview(imageView)
        imageView.addSubview(blackView)
        blackView.addSubview(titleLabel)
        backgroundColor = .systemGray
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = nil
    }
    
    public func configure(with viewModel: MangaRecommendationsViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure:
                break
            }
        }
        
        let mangaTitle = viewModel.mangaName
        DispatchQueue.main.async {
            self.titleLabel.text = mangaTitle
        }
    }
}
