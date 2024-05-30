//
//  TopAnimeDescriptionCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import UIKit

class TopAnimeDescriptionCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopAnimeDescriptionCollectionViewCell"
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = Resources.Colors.secondaryTextColor
        textView.alpha = 0.6
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.showsVerticalScrollIndicator = true
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.font = UIFont(name: "Poppins-Light", size: 14)
        return textView
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
        addSubview(descriptionTextView)
    }
    
    private func configureConstraints() {
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionTextView.text = nil
    }
    
    public func configure(with viewModel: TopAnimeDescriptionCollectionViewCellViewModel) {
        descriptionTextView.text = viewModel.getDescription()
    }
}
