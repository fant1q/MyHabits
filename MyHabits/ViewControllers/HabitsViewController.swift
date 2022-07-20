//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Денис Штоколов on 28.06.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold , scale: .large)
        button.setBackgroundImage(UIImage(systemName: "plus", withConfiguration: largeConfig)?.withTintColor(UIColor(named: "violet") ?? UIColor(), renderingMode: .alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(onAddButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let header: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Сегодня"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    private lazy var collection: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "progressCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "habitCell")
        collectionView.backgroundColor = .systemGray5
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    @objc private func onAddButtonClicked() {
        let navigationController = UINavigationController(rootViewController: HabitViewController())
        navigationController.modalPresentationStyle = .overFullScreen
        self.present(navigationController, animated: true)
    }
    
    @objc private func loadList(notification: NSNotification) {
        self.collection.reloadData()
    }
    
    private func layout() {
        view.backgroundColor = UIColor(named: "darkWhite")
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        [addButton, header, collection].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            header.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 12),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            collection.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 12),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressCell", for: indexPath) as! ProgressCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.setupCell()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitCell", for: indexPath) as! HabitCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.habit = HabitsStore.shared.habits[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            
            let habitDetailsView = HabitDetailsViewController()
            habitDetailsView.habit = HabitsStore.shared.habits[indexPath.row]
            habitDetailsView.title = HabitsStore.shared.habits[indexPath.row].name
            navigationController?.pushViewController(habitDetailsView, animated: true)
            
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width = UIScreen.main.bounds.width - 16
            return CGSize(width: width, height: 55)
        } else {
            let width = UIScreen.main.bounds.width - 16
            return CGSize(width: width, height: 130)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }
}
