//
//  TableViewCell.swift
//  UITableViewTest
//
//  Created by Danil Bochkarev on 18.03.2023.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public properties
    let numberLabel = UILabel()
    let imageCoin = UIImageView()
    let nameCoin = UILabel()
    let priceCoin = UILabel()
}

//MARK: - Setup CustomCell for UITableViewCell
extension CustomCell {
    func initialize() {
        numberLabel.textAlignment = .center
        numberLabel.numberOfLines = 0
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = .systemFont(ofSize: 16, weight: .medium)
        numberLabel.tintColor = .black
        contentView.addSubview(numberLabel)
        
        imageCoin.clipsToBounds = true
        imageCoin.contentMode = .scaleAspectFit
        imageCoin.layer.cornerRadius = 25
        contentView.addSubview(imageCoin)
        
        nameCoin.textAlignment = .center
        nameCoin.numberOfLines = 0
        nameCoin.translatesAutoresizingMaskIntoConstraints = false
        nameCoin.font = .systemFont(ofSize: 18, weight: .regular)
        nameCoin.tintColor = .black
        contentView.addSubview(nameCoin)
        
        priceCoin.textAlignment = .center
        priceCoin.numberOfLines = 0
        priceCoin.translatesAutoresizingMaskIntoConstraints = false
        priceCoin.font = .systemFont(ofSize: 16, weight: .semibold)
        priceCoin.tintColor = .black.withAlphaComponent(0.7)
        contentView.addSubview(priceCoin)
        
        
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(35)
        }
        
        imageCoin.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.left.equalTo(numberLabel).inset(40)
        }
        
        nameCoin.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageCoin).inset(80)
        }
        
        priceCoin.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameCoin).inset(80)
        }
    }
}
