//
//  TopAnimePhotoCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 22.05.2024.
//

import UIKit

class TopAnimePhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopAnimePhotoCollectionViewCell"
    
    private let gradientLayer = CAGradientLayer()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemRed
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        imageView.addSubview(gradientView)
        gradientView.addSubview(titleLabel)
        gradientView.addSubview(baseInfo)
        imageView.layoutIfNeeded()
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(imageView.snp.height).multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        baseInfo.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(titleLabel)
            make.width.equalTo(titleLabel)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.colors = [Resources.Colors.primaryBackgroundColor.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = gradientView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
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
        
        let animeTitle = viewModel.getAnimeTitle()
        let genres = viewModel.getGenres()
        let type = viewModel.getType()
        let year = viewModel.getYear()
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
        }
    }
}
