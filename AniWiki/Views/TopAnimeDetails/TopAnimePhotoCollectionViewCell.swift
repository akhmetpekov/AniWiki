//
//  TopAnimePhotoCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 22.05.2024.
//

import UIKit
import SwiftyStarRatingView

class TopAnimePhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopAnimePhotoCollectionViewCell"
    
    private var viewBounds = CGRect()
    private let gradientLayer = CAGradientLayer()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gradientView: UIView = {
        let someView = UIView()
        return someView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Antonio-Bold", size: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let baseInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let starScore: SwiftyStarRatingView = {
        let score = SwiftyStarRatingView()
        score.backgroundColor = .clear
        score.spacing = 1
        score.maximumValue = 5
        score.minimumValue = 0
        score.tintColor = Resources.Colors.scoreColor
        score.allowsHalfStars = true
        score.accurateHalfStars = true
        return score
    }()
    
    private let scoredByLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.6
        label.font = UIFont(name: "Poppins-SemiBold", size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
        viewBounds = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        gradientLayer.colors = [Resources.Colors.primaryBackgroundColor.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = viewBounds
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        imageView.addSubview(gradientView)
        gradientView.addSubview(titleLabel)
        gradientView.addSubview(baseInfo)
        gradientView.addSubview(starScore)
        gradientView.addSubview(scoredByLabel)
        imageView.layoutIfNeeded()
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(baseInfo.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        baseInfo.snp.makeConstraints { make in
            make.bottom.equalTo(starScore.snp.top).offset(-16)
            make.centerX.equalTo(titleLabel)
            make.width.equalTo(titleLabel)
        }
        
        starScore.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalToSuperview().multipliedBy(0.33)
            make.centerX.equalToSuperview().offset(-30)
            make.height.equalTo(20)
        }
        
        scoredByLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(20)
            make.leading.equalTo(starScore.snp.trailing).offset(10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        baseInfo.text = nil
        starScore.value = 0
        scoredByLabel.text = nil
    }
    
    public func configure(with viewModel: TopAnimePhotoCollectionViewCellViewModel) {
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
        
        let animeTitle = viewModel.animeName
        let genres = viewModel.genres
        let type = viewModel.type
        let year = viewModel.year
        let score = viewModel.getScore()
        let scoredBy = viewModel.getScoredBy()
        var genreNames: [String] = []
        for genre in genres {
            guard let genreName = genre.name else { return }
            genreNames.append(genreName)
        }
        let genreInfo = genreNames.joined(separator: ", ")
        let baseInfoText = "\(genreInfo) | \(type) | \(year)"
        DispatchQueue.main.async {
            self.titleLabel.text = animeTitle
            self.baseInfo.text = baseInfoText
            self.starScore.value = score
            self.scoredByLabel.text = scoredBy
        }
    }
}
