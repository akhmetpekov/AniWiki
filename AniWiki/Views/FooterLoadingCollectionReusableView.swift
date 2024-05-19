//
//  FooterLoadingCollectionReusableView.swift
//  AniWiki
//
//  Created by Erik on 14.05.2024.
//

import UIKit
import SnapKit

final class FooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "FooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
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
        backgroundColor = .systemBackground
        addSubview(spinner)
    }
    
    private func configureConstraints() {
        spinner.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.center.equalToSuperview()
        }
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
