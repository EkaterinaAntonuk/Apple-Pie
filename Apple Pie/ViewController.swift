//
//  ViewController.swift
//  Apple Pie
//
//  Created by Ekaterina Kuznetsova on 29.03.2022.
//

import UIKit

class ViewController: UIViewController {
// Mark: - IB Outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    //Mark: - properties
    var currentGame: Game!
    let incorrectMovesAllowed = 7
    var listOfWords = [
    "Дели",
    "Шанхай",
    "Сан-Паулу",
    "Мехико",
    "Каир",
    "Мумбаи",
    "Пекин",
    "Дакка",
    "Осака",
    "Нью-Йорк",
    "Карачи",
    "Буэнос-Айрес",
    "Чунцин",
    "Стамбул",
    "Калькутта",
    "Манила",
    "Лагос",
    "Рио-де-Жанейро",
    "Тяньцзинь",
    "Киншаса",
    "Гуанчжоу",
    "Лос-Анджелес",
    "Москва",
    "Шэньчжэнь",
    "Лахор",
    "Бангалор",
    "Париж",
    "Богота",
    "Джакарта",
    "Ченнай",
    "Лима",
    "Бангкок",
    "Сеул",
    "Нагоя",
    "Хайдарабад",
    "Лондон",
    "Тегеран",
    "Чикаго",
    "Чэнду",
    "Нанкин",
    "Ухань",
    "Хошимин",
    "Луанда",
    "Ахмедабад",
    "Куала Лумпур",
    "Сиань",
    "Гонконг",
    "Дунгуань",
    "Ханчжоу",
    "Фошань",
    "Шэньян",
    "Эр-Рияд",
    "Багдад",
    "Сантьяго",
    "Сурат",
    "Мадрид",
    "Сучжоу",
    "Пуна",
    "Харбин",
    "Хьюстон",
    "Даллас",
    "Торонто",
    "Дар-эс-Салам",
    "Майами",
    "Белу-Оризонти",
    "Сингапур",
    "Филадельфия",
    "Атланта",
    "Фукуока",
    "Хартум",
    "Барселона",
    "Йоханнесбург",
    "Санкт-Петербург",
    "Циндао",
    "Далянь",
    "Вашингтон",
    "Янгон",
    "Александрия",
    "Цзинань",
    "Гвадалахара"
    ].shuffled()
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    //Mark: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    
    func newRound() {
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateUI()
            return
        }
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func updateCorrectWordLabel() {
        var displayWord = [String]()
        for letter in currentGame.guessedWord {
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateState() {
        if currentGame.incorrectMovesRemaining < 1 {
        totalLosses += 1
        } else if currentGame.guessedWord == currentGame.word {
           totalWins += 1
        } else {
        updateUI()
    }
    }
    
    func updateUI() {
        let movesRemaining = currentGame.incorrectMovesRemaining
        let imageNumber = (movesRemaining + 64) % 8
        let image = "Tree\(imageNumber)"
        treeImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выйгрыши: \(totalWins), проигрыши: \(totalLosses)"
    }
// Mark: - IB Actions

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
}

