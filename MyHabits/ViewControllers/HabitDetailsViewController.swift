//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Денис Штоколов on 20.07.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habit: Habit?
    
    private let habitEditViewController = HabitViewController()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: "HabitDetailsTableViewCell")
        tableView.backgroundColor = UIColor(named: "darkWhite")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let habit = habitEditViewController.habit {
            self.habit = habit
            if !HabitsStore.shared.habits.contains(habit) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        title = habit?.name
        navigationController?.navigationBar.tintColor = UIColor(named: "violet")
    }
    
    private func layout() {
        
        view.backgroundColor = UIColor(named: "darkWhite")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(edit))
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func edit() {
        
        habitEditViewController.habit = habit
        habitEditViewController.state = .edit
        
        let editNavigationController = UINavigationController(rootViewController: habitEditViewController)
        editNavigationController.modalPresentationStyle = .fullScreen
        present(editNavigationController, animated: true, completion: nil)
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitDetailsTableViewCell", for: indexPath) as! HabitDetailsTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.date.text = dateFormatter.string(from: HabitsStore.shared.dates[HabitsStore.shared.dates.count - indexPath.row - 1])
        
        if let isHabit = habit {
            if HabitsStore.shared.habit(isHabit, isTrackedIn: HabitsStore.shared.dates[HabitsStore.shared.dates.count - indexPath.row - 1]) {
                cell.tintColor = UIColor(named: "violet")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
}
