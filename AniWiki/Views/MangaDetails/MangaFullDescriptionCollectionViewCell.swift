//
//  MangaFullDescriptionCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 06.06.2024.
//

import UIKit
import SnapKit

class MangaFullDescriptionCollectionViewCell: UICollectionViewCell {
    static let identifier = "MangaFullDescriptionCollectionViewCell"
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.alpha = 0.6
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.showsVerticalScrollIndicator = false
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.font = UIFont(name: "Poppins-Light", size: 14)
        return textView
    }()
    
    private let furtherButton: UIButton = {
        let button = UIButton()
        button.setTitle("Further...", for: .normal)
        button.titleLabel?.font = UIFont(name: Resources.Fonts.PoppinsLight, size: 14)
        button.titleLabel?.textColor = Resources.Colors.primaryTintColor
//        button.addTarget(self, action: #selector(makeDescriptionTextViewLarger), for: .touchUpInside)
        return button
    }()
    
    private var descriptionTextViewHeightConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        addSubview(descriptionTextView)
        addSubview(furtherButton)
    }
    
    private func configureConstraints() {
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            descriptionTextViewHeightConstraint = make.height.equalTo(130).constraint
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        furtherButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: MangaFullDescriptionCollectionViewCellViewModel) {
        descriptionTextView.text = viewModel.synopsis
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
