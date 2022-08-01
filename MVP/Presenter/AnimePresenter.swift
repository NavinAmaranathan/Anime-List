//
//  AnimePresenter.swift
//  MVP
//
//  Created by Navi on 01/08/22.
//

import Foundation
import UIKit

typealias AnimePresenterType = AnimePresenterDelegate & UIViewController

protocol AnimePresenterDelegate: AnyObject {
    func didFetch(animeList: [Anime])
}

class AnimePresenter {
    weak var delegate: AnimePresenterType?
    
    func setDelegate(for delegate: AnimePresenterType) {
        self.delegate = delegate
    }
    
    func fetchAnimeList() {
        guard let url = URL(string: "https://anime-facts-rest-api.herokuapp.com/api/v1") else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let dataReceived = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(AnimeResponse.self, from: dataReceived)
                self?.delegate?.didFetch(animeList: response.animeList)
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }
    
    func displayAlert(with title: String) {
        let alert = UIAlertController(title: title,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        delegate?.present(alert, animated: true)
    }
}
