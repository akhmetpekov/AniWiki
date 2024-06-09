//
//  MangaFullPhotoCollectionViewCell.swift
//  AniWiki
//
//  Created by Erik on 04.06.2024.
//

import Foundation
import UIKit

class MangaFullPhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "MangaFullPhotoCollectionViewCell"
    
    var context = CIContext(options: nil)
    
    private let blurredBackgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredView = UIVisualEffectView(effect: blurEffect)
        blurredView.contentMode = .scaleAspectFill
        return blurredView
    }()
    
    private let darkOverlayView: UIView = {
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return overlayView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
        backgroundColor = .black
        contentView.addSubview(blurredBackgroundView)
        contentView.addSubview(darkOverlayView)
        contentView.addSubview(imageView)
    }
    
    private func configureConstraints() {
        blurredBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        darkOverlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    public func configure(with viewModel: MangaFullPhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                    self?.applyBlurEffect(to: image)
                }
            case .failure:
                break
            }
        }
    }
    
    private func applyBlurEffect(to image: UIImage?) {
        guard let image = image else { return }
        DispatchQueue.global().async {
            let ciImage = CIImage(image: image)
            let blurFilter = CIFilter(name: "CIGaussianBlur")
            blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
            blurFilter?.setValue(10.0, forKey: kCIInputRadiusKey)
            
            guard let outputImage = blurFilter?.outputImage,
                  let cgImage = self.context.createCGImage(outputImage, from: ciImage!.extent) else {
                return
            }
            
            let blurredImage = UIImage(cgImage: cgImage)
            
            DispatchQueue.main.async {
                self.blurredBackgroundView.contentView.layer.contents = blurredImage.cgImage
            }
        }
    }
}
