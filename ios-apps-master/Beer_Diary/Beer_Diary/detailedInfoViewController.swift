//
//  detailedInfoViewController.swift
//  Beer_Diary
//
//  Created by Piotr Mielcarzewicz on 14/11/16.
//  Copyright © 2016 Piotr Mielcarzewicz. All rights reserved.
//

import UIKit

class detailedInfoViewController: UIViewController {
    
    
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var breweryName: UILabel!
    @IBOutlet weak var style: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var aroma: UILabel!
    @IBOutlet weak var appearance: UILabel!
    @IBOutlet weak var palate: UILabel!
    @IBOutlet weak var taste: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var thoughts: UITextView!
    
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        beerName.text = "Beer Name: " + detailed.name
        breweryName.text = "Brewery Name: " + detailed.brewery
        style.text = "Style: " + detailed.style
        country.text = "Country: " + detailed.country
        score.text = "Score: \(detailed.overall)/5"
        aroma.text = "Aroma: \(detailed.aroma)/10"
        appearance.text = "Appearance: \(detailed.appearance)/5"
        palate.text = "Palate: \(detailed.palate)/5"
        taste.text = "Taste: \(detailed.taste)/10"
        date.text = "Date: \(detailed.date)"
        thoughts.text = "Thoughts: " + detailed.thoughts
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
