//
//  HabitDetailsViewCellTableViewCell.swift
//  MyHabits
//
//  Created by Денис Штоколов on 20.07.2022.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    let date: UILabel = {
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        contentView.addSubview(date)
        
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8)
        ])
    }
}
