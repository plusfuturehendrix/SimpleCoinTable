//
//  ViewController.swift
//  CoinTableView
//
//  Created by Danil Bochkarev on 03.04.2023.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    //MARK: - Public properties
    var symbols: [String] = []
    var images = [String]()
    var currentPrices: [Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        addViewConstraints()
        
        apiManager.fetchCoinData { [weak self] (result, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Ошибка запроса: \(error.localizedDescription)")
                    return
                }
                guard let result = result, let data = result["data"] as? [[String: Any]] else {
                    print("Ошибка получения данных")
                    return
                }
                self?.symbols = data.compactMap({ $0["symbol"] as? String })
                self?.images = data.compactMap({ $0["image"] as? String })
                self?.currentPrices = data.compactMap({ $0["currentPrice"] as? Double })
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Private properties
    private var tableView = UITableView()
    private var apiManager = APIManager()
}


//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        cell.numberLabel.text = String((indexPath.row) + 1)
        
        
        if images.isEmpty {
            cell.imageCoin.image = UIImage(named: "123df")
        } else {
            let url = URL(string: images[indexPath.row])
            cell.imageCoin.kf.setImage(with: url)
        }
        
        cell.nameCoin.text = symbols.isEmpty ? "BTC" : symbols[indexPath.row].uppercased()
        cell.priceCoin.text = currentPrices.isEmpty ? "999$" : "\(currentPrices[indexPath.row])$"

       
        return cell
    }
}

////MARK: - UITableViewDelegate
//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(123)
//    }
//}

extension ViewController {
    private func addViewConstraints() {
        tableView.rowHeight = 70
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

