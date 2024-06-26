//
//  TopAnimeDescriptionCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import UIKit
import SnapKit

class TopAnimeDescriptionCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopAnimeDescriptionCollectionViewCell"
    
    private var viewBounds = CGRect()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = Resources.Colors.secondaryTextColor
        textView.alpha = 0.6
        textView.isEditable = false
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
        viewBounds = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(descriptionTextView)
        addSubview(furtherButton)
    }
    
    private func configureConstraints() {
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            descriptionTextViewHeightConstraint = make.height.equalTo(130).constraint
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        furtherButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
    }
    
//    @objc private func makeDescriptionTextViewLarger() {
//        let size = descriptionTextView.sizeThatFits(CGSize(width: descriptionTextView.frame.width, height: CGFloat.greatestFiniteMagnitude))
//        descriptionTextViewHeightConstraint?.update(offset: size.height)
//        furtherButton.isHidden = false  // Optionally hide the button after expanding
//        delegate?.reloadCell(self)
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionTextView.text = nil
        furtherButton.isHidden = false  // Reset the button visibility
//        descriptionTextViewHeightConstraint?.update(offset: 130)  // Reset to initial height
    }
    
    public func configure(with viewModel: TopAnimeDescriptionCollectionViewCellViewModel) {
        descriptionTextView.text = viewModel.getDescription()
    }
}
