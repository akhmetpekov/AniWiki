//
//  GuessAnimeAnswerView.swift
//  AniWiki
//
//  Created by Erik on 13.06.2024.
//

import UIKit

class GuessAnimeAnswerView: UIView {
    
    private let transparrentBackground: UIView = {
        let someView = UIView()
        someView.backgroundColor = Resources.Colors.primaryBackgroundColor.withAlphaComponent(0.7)
        return someView
    }()
    
    private let answerView: UIView = {
        let someView = UIView()
        someView.backgroundColor = Resources.Colors.primaryTintColor
        someView.alpha = 1
        return someView
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.text = "Wrong Answer!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: Resources.Fonts.PoppinsBold, size: 16)
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Try another answer"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 14)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        isHidden = true
        addSubview(transparrentBackground)
        transparrentBackground.addSubview(answerView)
        answerView.addSubview(answerLabel)
        answerView.addSubview(captionLabel)
        answerView.addSubview(closeButton)
    }
    
    private func configureConstraints() {
        transparrentBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        answerView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
            make.center.equalToSuperview()
        }
        
        answerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        captionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    @objc private func closeButtonTapped() {
        isHidden = true
    }
    
    public func configure(titleLabel: String, captionLabel: String, answerType: Bool) {
        answerLabel.text = titleLabel
        self.captionLabel.text = captionLabel
        if answerType {
            answerView.backgroundColor = .systemGreen
        } else {
            answerView.backgroundColor = Resources.Colors.primaryTintColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        answerView.layer.masksToBounds = true
        answerView.layer.cornerRadius = 14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


