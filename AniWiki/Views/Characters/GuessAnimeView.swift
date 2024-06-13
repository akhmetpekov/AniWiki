//
//  GuessAnimeView.swift
//  AniWiki
//
//  Created by Erik on 09.06.2024.
//

import UIKit
import Combine

final class GuessAnimeView: UIView {
    
    private var cancellables = Set<AnyCancellable>()
    private var answer: String = ""
    private var viewModel: GuessAnimeViewViewModel?
    private let answerView = GuessAnimeAnswerView()
    
    private let guessAnimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.AntonioBold, size: 28)
        label.textColor = .white
        label.text = "Guess Anime By Poster"
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Resources.Colors.unselectedItemColor
        return imageView
    }()
    
    private let animeName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.PoppinsSemibold, size: 20)
        label.textColor = .white
        label.text = "???"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let answerTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.backgroundColor = Resources.Colors.tabbarBackgroundColor
        tf.textColor = .white
        tf.tintColor = Resources.Colors.primaryTintColor
        tf.autocapitalizationType = .sentences
        tf.autocorrectionType = .no
        tf.setLeftPaddingPoints(7)
        tf.placeholder = "Anime Name..."
        return tf
    }()
    
    private lazy var guessButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Resources.Colors.primaryTintColor
        button.setTitle("Guess", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapGuessButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        button.tintColor = Resources.Colors.unselectedItemColor
        button.addTarget(self, action: #selector(didResetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
        answerTextField.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 14
        guessButton.layer.masksToBounds = true
        guessButton.layer.cornerRadius = 14
    }
    
    private func setupUI() {
        addSubview(guessAnimeLabel)
        addSubview(imageView)
        addSubview(animeName)
        addSubview(answerTextField)
        addSubview(guessButton)
        addSubview(resetButton)
        addSubview(answerView)
    }
    
    private func configureConstraints() {
        guessAnimeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(guessAnimeLabel.snp.bottom).offset(15)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(260)
        }
        
        animeName.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(60)
        }
        
        answerTextField.snp.makeConstraints { make in
            make.top.equalTo(animeName.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        guessButton.snp.makeConstraints { make in
            make.top.equalTo(answerTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(60)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        answerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func didTapGuessButton() {
        let userAnswer = answerTextField.text?.lowercased() ?? ""
        let actualAnswer = answer.lowercased()
        
        var isSuccessful = false
        
        if userAnswer == actualAnswer {
            isSuccessful = true
        }
        
        if isSuccessful {
            answerTextField.text = ""
            animeName.text = answer
            answerView.isHidden = false
            answerView.configure(titleLabel: "Right Answer!", captionLabel: "Good Job", answerType: true)
        } else {
            answerTextField.text = ""
            answerView.isHidden = false
            answerView.configure(titleLabel: "Wrong Answer!", captionLabel: "Try another answer", answerType: false)
        }
    }
    
    private func showWrongAnswerView() {
        answerView.isHidden = false
    }
    
    @objc private func didResetButtonTapped() {
        answerTextField.text = ""
        animeName.text = "???"
        imageView.image = nil
        viewModel?.fetchAnime()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: GuessAnimeViewViewModel) {
        self.viewModel = viewModel
        viewModel.fetchAnime()
        viewModel.$animeName
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                print(name)
                self?.answer = name
            }
            .store(in: &cancellables)
        
        viewModel.$animeURL
            .compactMap { $0 }
            .flatMap { url -> AnyPublisher<Data, URLError> in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] data in
                self?.imageView.image = UIImage(data: data)
            })
            .store(in: &cancellables)
    }
}

extension GuessAnimeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        answerTextField.text = ""
        didTapGuessButton()
        return true
    }
}

