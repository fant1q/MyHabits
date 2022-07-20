//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Денис Штоколов on 06.07.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGray2
        return label
    }()
    
    private let percent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGray2
        return label
    }()
    
    private let progress: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressViewStyle = .bar
        progress.tintColor = UIColor(named: "violet")
        progress.trackTintColor = .systemGray2
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        layoutIfNeeded()
        prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        progress.setProgress(HabitsStore.shared.todayProgress, animated: true)
        percent.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        [name, percent, progress].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            percent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            percent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            progress.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            progress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            progress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            progress.heightAnchor.constraint(equalToConstant: 5)
            
        ])
    }
}
