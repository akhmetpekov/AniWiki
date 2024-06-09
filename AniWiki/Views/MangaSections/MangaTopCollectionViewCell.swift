//
//  MangaTopCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 08.06.2024.
//

import UIKit

class MangaTopCollectionViewCell: UICollectionViewCell {
    static let identifier = "MangaTopCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Antonio-Bold", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let bottomPlate: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return uiView
    }()
    
    private let topNumber: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.primaryTintColor
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topNumber.layer.masksToBounds = true
        topNumber.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        imageView.addSubview(bottomPlate)
        bottomPlate.addSubview(titleLabel)
        imageView.addSubview(topNumber)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomPlate.snp.makeConstraints { make in
            make.height.equalTo(65)
            make.leading.trailing.bottom.equalTo(imageView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
        }
        
        topNumber.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        topNumber.text = nil
    }
    
    public func configure(with viewModel: MangaTopViewCellViewModel) {
        titleLabel.text = viewModel.mangaName
        topNumber.text = viewModel.topNumber
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
    }
}
