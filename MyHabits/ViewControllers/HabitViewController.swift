//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Денис Штоколов on 04.07.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habit: Habit? {
        didSet {
            nameTextField.text = habit?.name
            colorPicker.backgroundColor = habit?.color
            datePicker.date = habit?.date ?? Date()
        }
    }
    
    enum State {
        case save
        case edit
    }
    
    var state: State = State.save
    
    private let headerOfName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .systemBackground
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.delegate = self
        return textField
    }()
    
    private let headerOfColorPicker: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Цвет"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let colorPicker: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let headerOfTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Время"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let headerOfDatePicker: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Каждый день в "
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = UIColor(named: "violet")
        picker.backgroundColor = .systemBackground
        picker.datePickerMode = .time
        picker.timeZone = .current
        return picker
    }()
    
    private lazy var picker: UIColorPickerViewController = {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        return picker
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .red
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesture()
        layout()
    }
    
    private func layout() {
        
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonTap))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "violet")
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "violet")
        navigationItem.title = "Создать"
        
        [headerOfName, nameTextField, headerOfColorPicker, colorPicker, headerOfTime, headerOfDatePicker, datePicker].forEach { view.addSubview($0) }
        
        if state == .edit {
            
            view.addSubview(deleteButton)
            
            NSLayoutConstraint.activate([
                
                deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
                
            ])
        }
        
        NSLayoutConstraint.activate([
            headerOfName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            headerOfName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            nameTextField.topAnchor.constraint(equalTo: headerOfName.bottomAnchor, constant: 12),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            headerOfColorPicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 18),
            headerOfColorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            colorPicker.topAnchor.constraint(equalTo: headerOfColorPicker.bottomAnchor, constant: 12),
            colorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            colorPicker.heightAnchor.constraint(equalToConstant: 40),
            colorPicker.widthAnchor.constraint(equalToConstant: 40),
            
            headerOfTime.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 18),
            headerOfTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            headerOfDatePicker.topAnchor.constraint(equalTo: headerOfTime.bottomAnchor, constant: 12),
            headerOfDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            datePicker.topAnchor.constraint(equalTo: headerOfTime.bottomAnchor, constant: 12),
            datePicker.leadingAnchor.constraint(equalTo: headerOfDatePicker.trailingAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        colorPicker.addGestureRecognizer(tapGesture)
    }
    
    @objc private func gestureAction() {
        self.present(picker, animated: true)
    }
    
    @objc private func saveButtonTap() {
        let newHabit = Habit(name: nameTextField.text!,
                             date: datePicker.date,
                             color: picker.selectedColor)
        let store = HabitsStore.shared
        
        if state == .save {
            store.habits.insert(newHabit, at: 0)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        } else {
            for (index, storage) in store.habits.enumerated() {
                if storage.name == habit?.name {
                    newHabit.trackDates = storage.trackDates
                    store.habits[index] = newHabit
                    habit? = newHabit
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func deleteHabit() {
        
        let store = HabitsStore.shared
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habit?.name ?? " ") ?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {
            _ in for (index, storageHabit) in store.habits.enumerated() {
                if storageHabit.name == self.habit?.name {
                    store.habits.remove(at: index)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                    self.navigationController?.dismiss(animated: false, completion: nil)
                    break
                }
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        colorPicker.backgroundColor = viewController.selectedColor
    }
}
