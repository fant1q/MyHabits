//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Денис Штоколов on 28.06.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private let infoText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.backgroundColor = .systemBackground
        let attributeHeader = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)]
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        let range = NSRange(location: 0, length: 21)
        let myString = NSMutableAttributedString(string: """
        
        Привычка за 21 день.
        
        Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
        
        1. Провести 1 день без обращение к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
        
        2. Выдержать 2 дня в прежнем состоянии самоконтроля.
        
        3. Отметить в дневнике первую неделю изменений и подвести первые итоги – что оказалось тяжело, что – легче, с чем еще предстоит серьезно бороться.
        
        4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
        
        5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
        
        6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
        """, attributes: attribute)
        myString.addAttributes(attributeHeader, range: range)
        textView.attributedText = myString
        textView.textAlignment = .natural
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    private func layout() {
        view.backgroundColor = UIColor(named: "darkWhite")
        self.navigationItem.title = "Информация"
        
        [scrollView, contentView, infoText].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            infoText.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
