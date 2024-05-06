//
//  TopViewController.swift
//  AniWiki
//
//  Created by Erik on 05.05.2024.
//

import UIKit

final class TopViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        Service.shared.execute(.listTopRequests, expecting: Top.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error))
            }
        }
        
    }
}
