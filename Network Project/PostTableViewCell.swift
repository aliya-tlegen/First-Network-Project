//
//  TableViewCell.swift
//  Network Project
//
//  Created by Алия Тлеген on 08.08.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Private Variables -

    private let title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let body: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Initialization -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration -
    
    func configure(model: Post) {
        title.text = model.title
        body.text = model.body
    }
    
    // MARK: - Setup -
    
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
