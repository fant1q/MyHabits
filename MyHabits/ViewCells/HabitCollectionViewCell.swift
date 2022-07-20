//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Денис Штоколов on 06.07.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    public var habit: Habit? {
        didSet {
            nameOfHabit.text = habit?.name
            nameOfHabit.textColor = habit?.color
            timeofHabit.text = habit?.dateString
            checkButton.layer.borderColor = habit?.color.cgColor
            checker.text = "Счетчик: \((habit?.trackDates.count ?? 0))"
            if habit?.isAlreadyTakenToday == true {
                checkButton.backgroundColor = habit?.color
            } else { checkButton.backgroundColor = .white }
        }
    }
    
    private let nameOfHabit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemGray2
        return label
    }()
    
    private let timeofHabit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        return label
    }()
    
    private let checker: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular , scale: .medium)
        button.setBackgroundImage(UIImage(systemName: "checkmark", withConfiguration: config)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
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
    
    @objc private func buttonTap() {
        
        if habit?.isAlreadyTakenToday == false {
            checkButton.backgroundColor = habit?.color
            HabitsStore.shared.track(habit!)
            print("Пользователь успешно добавил привычку")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        } else {
            print("Привычка уже выполнена")
        }
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        [nameOfHabit, timeofHabit, checker, checkButton].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            nameOfHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameOfHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            timeofHabit.topAnchor.constraint(equalTo: nameOfHabit.bottomAnchor, constant: 8),
            timeofHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            checker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            checker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: 43),
            checkButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
