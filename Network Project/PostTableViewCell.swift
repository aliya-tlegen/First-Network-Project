//
//  TableViewCell.swift
//  Network Project
//
//  Created by Алия Тлеген on 08.08.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
//    let identifier = "PostTableViewCell"

    private let title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let body: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Post) {
        title.text = model.title
        body.text = model.body
    }
    
    func setupViews() {
        contentView.addSubview(title)
        contentView.addSubview(body)
    }
    
    func setupConstraints() {
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(5)
        }
        body.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(7)
            $0.left.equalToSuperview().offset(5)
        }
    }
    
}
