//
//  AnimeViewController.swift
//  MVP
//
//  Created by Navi on 01/08/22.
//

import UIKit

class AnimeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var animeList: [Anime] = []
    var presenter = AnimePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Anime Characters"
        presenter.setDelegate(for: self)
        setupTable()
        fetchData()
    }

    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func fetchData() {
        presenter.fetchAnimeList()
    }
}

extension AnimeViewController: AnimePresenterDelegate {
    func didFetch(animeList: [Anime]) {
        self.animeList = animeList
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension AnimeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let name = animeList[indexPath.row].animeName.localizedUppercase
        presenter.displayAlert(with: name)
    }
}

extension AnimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = animeList[indexPath.row].animeName.localizedUppercase
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
