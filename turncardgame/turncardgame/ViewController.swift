//
//  ViewController.swift
//  turncardgame
//
//  Created by 詹昆宬 on 2021/3/10.
//

import UIKit

class ViewController: UIViewController {
    
    var flipFlag:Bool! = false
    
    var emojiChoices = ["👻", "🎃", "👿", "👺", "☠️", "🤖", "👾", "🤡"]
    
    var emojiDict:Dictionary<Card,String> = [:]
    
    lazy var game = MatchingGame(numberOfPairsOfCards: (cardButtons.count+1)/2)
    {
        didSet{
            
        }
    }
    
    var flipsCount:Int! = 0
    {
        didSet{
            flipsCountLabel.text = "\(String(flipsCount))"
        }
    }
    
    var scoreCount:Int! = 0
    {
        didSet{
            scoreCountLabel.text = "\(String(scoreCount))"
        }
    }
    
    @IBOutlet weak var flipAllButton: UIButton!
    
    @IBOutlet weak var flipsCountLabel: UILabel!
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBOutlet var cardButtons:
        [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func flipAll(_ sender: Any) {
        flipFlag = !flipFlag
        game.chooseAll(flag: flipFlag)
        updateViewFromModel()
    }
    
    @IBAction func reset(_ sender: UIButton) {
        game.clearAll()
        emojiDict.removeAll()
        game = MatchingGame(numberOfPairsOfCards: (cardButtons.count+1)/2)
        emojiChoices = ["👻", "🎃", "👿", "👺", "☠️", "🤖", "👾", "🤡"]
        updateViewFromModel()
        flipsCount = 0;
        scoreCount = 0;
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("not in the collection")
        }
        
        flipsCount += 1;
        scoreCount = game.score;
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isMatched {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 0.5)
            }
            else if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
    }
    
    func emoji(for card: Card) -> String{
        if emojiDict[card] == nil, emojiChoices.count>0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emojiDict[card] = emojiChoices.remove(at: randomIndex)
        }
        
        return emojiDict[card] ?? "?"
    }
}

