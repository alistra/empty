//
//  ViewController.swift
//  tic_tac_toe
//
//  Created by Piotr Mielcarzewicz on 20/10/16.
//  Copyright © 2016 Piotr Mielcarzewicz. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var play: UIBarButtonItem!
    @IBOutlet weak var reset: UIBarButtonItem!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var board: UIImageView!
    @IBOutlet weak var mode: UISegmentedControl!
    
    
    let nought = "nought.png"
    let cross = "cross.png"
    var aiBegins = 0
    var isPlaying = false
    var player = 1
    var availableField: [Int] = [0,0,0,0,0,0,0,0,0,0]
    let winningCombinations = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    
    @IBAction func reset_game(_ sender: AnyObject)
    {

        aiBegins = 0
        isPlaying = false
        mode.isHidden = false
        label.text = nil
        player = 1
        for i in 1...9
        {
            button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: .normal)
            availableField[i] = 0
        }
        reset.isEnabled = false
        play.isEnabled = true
    }

    
    @IBAction func begin_game(_ sender: AnyObject)
    {
        
        isPlaying = true
        play.isEnabled = false
        reset.isEnabled = true
        mode.isHidden = true
        if mode.selectedSegmentIndex == 0
        {
            aiBegins = Int(arc4random_uniform(2))
            if aiBegins == 1
            {
                let image = UIImage(named: nought)
                AI()
                for x in 1...9
                {
                    if availableField[x] == 1
                    {
                        let field = view.viewWithTag(x) as! UIButton
                        field.setImage(nil, for: .normal)
                        field.setImage(image, for: .normal)
                    }
                }
                
            }
            player = 2
        }
        else
        {
            label.text = "O player turn"
        }
    }
    
    
    
    @IBAction func buttonPressed(_ sender: AnyObject)
    {
        
        if isPlaying
        {
            if availableField[sender.tag] == 0
            {
                if player == 1
                {
                    let image = UIImage(named: "nought.png")
                    sender.setImage(image, for: .normal)
                    label.text = "X player turn"
                    availableField[sender.tag] = 1
                    player = 2
                    
                }
                else if player == 2
                {
                    availableField[sender.tag] = 2
                    
                    if mode.selectedSegmentIndex == 0
                    {
                        var image: UIImage
                        if aiBegins == 1
                        {
                            image = UIImage(named: nought)!
                            let playerImage = UIImage(named: cross)
                            sender.setImage(playerImage, for: .normal)
                        }
                        else
                        {
                            image = UIImage(named: cross)!
                            let playerImage = UIImage(named: nought)
                            sender.setImage(playerImage, for: .normal)
                        }
                        AI()
                        for x in 1...9
                        {
                            if availableField[x] == 1
                            {
                                let temp = view.viewWithTag(x) as! UIButton
                                temp.setImage(nil, for: .normal)
                                temp.setImage(image, for: .normal)
                            }
                        }
                    }
                    else
                    {
                        let playerImage = UIImage(named: cross)
                        sender.setImage(playerImage, for: .normal)
                        label.text = "O player turn"
                        player = 1
                    }
                }
            }
            endOfGame()
        }
        
        
    }
    
    
    
    func endOfGame()
    {
        for combination in winningCombinations
        {
            if availableField[combination[0]] != 0 && availableField[combination[0]] == availableField[combination[1]] && availableField[combination[1]] == availableField[combination[2]]
            {
                label.center = CGPoint(x: label.center.x - 400, y: label.center.y)
                
                if availableField[combination[0]] == 1
                {
                    if mode.selectedSegmentIndex == 0
                    {
                        label.text = "AI won!"
                    }
                    else
                    {
                        label.text = "O player won!"
                    }
                    
                    
                }
                else
                {
                    if mode.selectedSegmentIndex == 0
                    {
                        label.text = "Player won!"
                    }
                    else
                    {
                        label.text = "X player won!"
                    }
                }
                
                UIView.animate(withDuration: 0.6, animations: {
                    self.label.center = CGPoint(x: self.label.center.x + 400, y: self.label.center.y)
                })
                isPlaying = false
            }
        }
        
        var draw = true
        
        for x in 1...9
        {
            if availableField[x] == 0
            {
                draw = false
                break
            }
        }
        
        if draw
        {
            label.center = CGPoint(x: label.center.x - 400, y: label.center.y)
            label.text = "It's a draw!"
            UIView.animate(withDuration: 0.6, animations: {
                self.label.center = CGPoint(x: self.label.center.x + 400, y: self.label.center.y)
            })
            isPlaying = false
        }
    }
    
    
    
    func step1() -> Bool
    {
        let a = availableField
        
        for x in winningCombinations
        {
            if a[x[0]] == a[x[1]]   &&  a[x[0]] == 1    &&  a[x[2]] == 0
            {
                availableField[x[2]] = 1
                return true
            }
            else if a[x[0]] == a[x[2]]  &&  a[x[0]] == 1    &&  a[x[1]] == 0
            {
                availableField[x[1]] = 1
                return true
            }
            else if a[x[1]] == a[x[2]]  &&  a[x[1]] == 1    &&  a[x[0]] == 0
            {
                availableField[x[0]] = 1
                return true
            }
        }
        return false
    }
    
    func step2() -> Bool
    {
        let a = availableField
        
        for x in winningCombinations
        {
            if a[x[0]] == a[x[1]]   &&  a[x[0]] == 2    &&  a[x[2]] == 0
            {
                availableField[x[2]] = 1
                return true
            }
            else if a[x[0]] == a[x[2]]  &&  a[x[0]] == 2    &&  a[x[1]] == 0
            {
                availableField[x[1]] = 1
                return true
            }
            else if a[x[1]] == a[x[2]]  &&  a[x[1]] == 2    &&  a[x[0]] == 0
            {
                availableField[x[0]] = 1
                return true
            }
        }
        return false
    }
    
    func countTokens(fields: [Int], token: Int) -> Int
    {
        var result = 0
        var tokenCount: Int
        var spareCell: Int
        
        for x in 0...2 // Horizontal
        {
            tokenCount = 0
            spareCell = -1
            for y in [1,2,3]
            {
                if fields[y+x*3] == token
                {
                    tokenCount += 1
                }
                else if fields[y+x*3] == 0
                {
                    spareCell = fields[y+x*3]
                }
            }
            if tokenCount == 2  &&  spareCell != -1
            {
                result += 1
            }
        }
        
        for x in 0...2 // Vertical
        {
            tokenCount = 0
            spareCell = -1
            for y in [1,4,7]
            {
                if fields[y+x] == token
                {
                    tokenCount += 1
                }
                else if fields[y+x] == 0
                {
                    spareCell = fields[y+x]
                }
            }
            if tokenCount == 2  &&  spareCell != -1
            {
                result += 1
            }
        }
        
        tokenCount = 0 // Top-Left to Lower-Right Diagonal
        spareCell = -1
        for x in [1,5,9]
        {
            if fields[x] == token
            {
                tokenCount += 1
            }
            else if fields[x] == 0
            {
                spareCell = fields[x]
            }
        }
        if tokenCount == 2  &&  spareCell != -1
        {
            result += 1
        }
        
        tokenCount = 0 // Top-Right to Lower-Left Diagonal
        spareCell = -1
        for x in [3,5,7]
        {
            if fields[x] == token
            {
                tokenCount += 1
            }
            else if fields[x] == 0
            {
                spareCell = fields[x]
            }
        }
        if tokenCount == 2  &&  spareCell != -1
        {
            result += 1
        }
   
        return result
    }
    
    func step3() -> Bool
    {
        var dummyField = availableField
        
        for i in 1...9
        {
            if dummyField[i] != 0
            {
                continue
            }
            
            dummyField[i] = 1
            
            if countTokens(fields: dummyField, token: 2) >= 2
            {
                availableField[i] = 1
                return true
            }
            
            dummyField[i] = 0
        }
        
        return false
    }
    
    func step4() -> Bool
    {
        var dummyField = availableField
        
        for i in 1...9
        {
            if dummyField[i] != 0
            {
                continue
            }
            
            dummyField[i] = 2
            
            if countTokens(fields: dummyField, token: 1) >= 2
            {
                availableField[i] = 1
                return true
            }
            
            dummyField[i] = 0
        }
        
        return false
    }
    
    func step5() -> Bool
    {
        if availableField[5] == 0
        {
            availableField[5] = 1
            return true
        }
        
        return false
    }
    
    
    
    func step6() -> Bool
    {
        if availableField[1] == 2  &&  availableField[9] == 0
        {
            availableField[9] = 1
            return true
        }
        else if availableField[3] == 2  &&  availableField[7] == 0
        {
            availableField[7] = 1
            return true
        }
        else if availableField[7] == 2  &&  availableField[3] == 0
        {
            availableField[3] = 1
            return true
        }
        else if availableField[9] == 2  &&  availableField[1] == 0
        {
            availableField[1] = 1
            return true
        }
        return false
    }
    
    func step7() -> Bool
    {
        if availableField[1] == 0
        {
            availableField[1] = 1
            return true
        }
        else if availableField[3] == 0
        {
            availableField[3] = 1
            return true
        }
        else if availableField[7] == 0
        {
            availableField[7] = 1
            return true
        }
        else if availableField[9] == 0
        {
            availableField[9] = 1
            return true
        }
        return false
    }
    
    func step8() -> Bool
    {
        if availableField[2] == 0
        {
            availableField[2] = 1
            return true
        }
        else if availableField[4] == 0
        {
            availableField[4] = 1
            return true
        }
        else if availableField[8] == 0
        {
            availableField[8] = 1
            return true
        }
        else if availableField[6] == 0
        {
            availableField[6] = 1
            return true
        }
        return false
    }
    

    //let winningCombinations = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  
    func AI()
    {
        if step1() { return } //If the AI has two in a row, it can place a third to get three in a row.
        if step2() { return } //If the player has two in a row, the AI must play the third themselves to block the player.
        if step3() { return } //Create an opportunity where AI can win in two ways.
        if step4() { return } //Block Player's Fork
        if step5() { return } //AI plays the center.
        if step6() { return } //If the player is in the corner, AI plays the opposite corner.
        if step7() { return } //AI plays an empty corner.
        if step8() { return } //AI lays an empty side.
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.board.frame = CGRect(x: self.board.center.x, y: self.board.center.y, width: 0, height: 0)
        UIView.animate(withDuration: 0.8) {
            self.board.frame = CGRect(x: self.board.center.x - 144, y: self.board.center.y - 145.5, width: 288, height: 291)
        }
    }


}

