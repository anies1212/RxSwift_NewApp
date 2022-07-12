//
//  NewsTableViewController.swift
//  RxSwift_NewsApp
//
//  Created by anies1212 on 2022/07/12.
//

import UIKit
import RxCocoa
import RxSwift

class NewsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    private let bag = DisposeBag()
    private var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateNews()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
        cell.titleLabel.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func populateNews(){
        
        URLRequest.load(resource: ArticlesList.all).subscribe(onNext: { result in
            if let result = result {
                self.articles = result.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }).disposed(by: bag)
    }


}

