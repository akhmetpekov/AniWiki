//
//  MangaFullGenresCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 06.06.2024.
//

import UIKit

class MangaFullGenresCollectionViewCell: UICollectionViewCell {
    static let identifier = "MangaFullGenresCollectionViewCell"
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        addSubview(mainStackView)
    }
    
    private func configureConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    public func configure(with viewModel: MangaFullGenresCollectionViewCellViewModel) {
        let genresData = viewModel.genres
        var genres: [String] = []
        for genre in genresData {
            guard var genreName = genre.name else { continue }
            if genreName.hasPrefix("Award") {
                genreName = "Award"
            }
            genres.append(genreName)
        }
        
        mainStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var currentRowStackView = createRowStackView()
        mainStackView.addArrangedSubview(currentRowStackView)
        
        for (index, genre) in genres.enumerated() {
            if index % 4 == 0 && index != 0 {
                currentRowStackView = createRowStackView()
                mainStackView.addArrangedSubview(currentRowStackView)
            }
            
            let label = createGenreView(genre)
            currentRowStackView.addArrangedSubview(label)
        }
    }
    
    private func createGenreView(_ genre: String) -> UILabel {
        let genreLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.text = genre
            label.font = UIFont(name: Resources.Fonts.PoppinsRegular, size: 13)
            label.backgroundColor = Resources.Colors.unselectedItemColor
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 10
            label.snp.makeConstraints { make in
                make.width.equalTo(90)
                make.height.equalTo(30)
            }
            return label
        }()
        return genreLabel
    }
    
    private func createRowStackView() -> UIStackView {
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .leading
            stackView.spacing = 4
            return stackView
        }()
        return stackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
