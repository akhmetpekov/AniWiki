//
//  TopCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 07.05.2024.
//

import UIKit
import SnapKit

final class TopCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "TopCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let bottomPlate: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setupUI()
        configureConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Not Working Gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,
                                UIColor.black.withAlphaComponent(0.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        imageView.addSubview(bottomPlate)
        bottomPlate.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomPlate.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.leading.trailing.bottom.equalTo(imageView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    public func configure(with viewModel: TopCollectionViewCellViewModel) {
        titleLabel.text = viewModel.animeTitle
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}


