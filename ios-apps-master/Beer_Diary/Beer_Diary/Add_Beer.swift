//
//  Add_Beer.swift
//  Beer_Diary
//
//  Created by Piotr Mielcarzewicz on 13/11/16.
//  Copyright © 2016 Piotr Mielcarzewicz. All rights reserved.
//

import UIKit

struct BeerItem
{
    var name = ""
    var brewery = ""
    var style = ""
    var country = ""
    var thoughts = ""
    var aroma = 0
    var appearance = 0
    var palate = 0
    var taste = 0
    var overall:Float = 0
    var date = NSDate()
}

func saveData()
{
    var tname = [String]()
    var tbrewery = [String]()
    var tstyle = [String]()
    var tcountry = [String]()
    var tthoughts = [String]()
    var taroma = [Int]()
    var tappearance = [Int]()
    var tpalate = [Int]()
    var ttaste = [Int]()
    var tscore = [Float]()
    var tdate = [NSDate]()
    
    
    for x in BeerList
    {
        tname.append(x.name)
        tbrewery.append(x.brewery)
        tstyle.append(x.style)
        tcountry.append(x.country)
        tthoughts.append(x.thoughts)
        taroma.append(x.aroma)
        tappearance.append(x.appearance)
        tpalate.append(x.palate)
        ttaste.append(x.taste)
        tscore.append(x.overall)
        tdate.append(x.date)
    }
    
    UserDefaults.standard.set(tname, forKey: "name")
    UserDefaults.standard.set(tbrewery, forKey: "brewery")
    UserDefaults.standard.set(tstyle, forKey: "style")
    UserDefaults.standard.set(tcountry, forKey: "country")
    UserDefaults.standard.set(tthoughts, forKey: "thoughts")
    UserDefaults.standard.set(taroma, forKey: "aroma")
    UserDefaults.standard.set(tappearance, forKey: "appearance")
    UserDefaults.standard.set(tpalate, forKey: "palate")
    UserDefaults.standard.set(ttaste, forKey: "taste")
    UserDefaults.standard.set(tscore, forKey: "score")
    UserDefaults.standard.set(tdate, forKey: "date")
}

class Add_Beer: UIViewController {
 
    @IBOutlet weak var beerName: UITextField!
    @IBOutlet weak var breweryName: UITextField!
    @IBOutlet weak var styleName: UITextField!
    @IBOutlet weak var countryName: UITextField!
    @IBOutlet weak var aroma: UILabel!
    @IBOutlet weak var appearance: UILabel!
    @IBOutlet weak var palate: UILabel!
    @IBOutlet weak var taste: UILabel!
    @IBOutlet weak var overall: UILabel!
    @IBOutlet weak var thoughts: UITextView!
    @IBOutlet weak var aromaSlider: UISlider!
    @IBOutlet weak var appearanceSlider: UISlider!
    @IBOutlet weak var palateSlider: UISlider!
    @IBOutlet weak var tasteSlider: UISlider!
    
    
    var newItem = BeerItem()
    
    
    
    
    @IBAction func sliderAroma(_ sender: Any)
    {
        let tempVal = Int(aromaSlider.value)
        aromaSlider.value = Float(tempVal)
        newItem.aroma = tempVal
        aroma.text = "Aroma - \(tempVal)/10"
        newItem.overall = Float(Int(Float(newItem.aroma + newItem.appearance + newItem.palate + newItem.taste)/30*500))/100
        overall.text = "Overall - \((newItem.overall))/5"
    }
    
    @IBAction func sliderAppearance(_ sender: Any)
    {
        let tempVal = Int(appearanceSlider.value)
        appearanceSlider.value = Float(tempVal)
        newItem.appearance = tempVal
        appearance.text = "Appearance - \(tempVal)/5"
        newItem.overall = Float(Int(Float(newItem.aroma + newItem.appearance + newItem.palate + newItem.taste)/30*500))/100
        overall.text = "Overall - \((newItem.overall))/5"
    }
    
    @IBAction func sliderPalate(_ sender: Any)
    {
        let tempVal = Int(palateSlider.value)
        palateSlider.value = Float(tempVal)
        newItem.palate = tempVal
        palate.text = "Palate - \(tempVal)/5"
        newItem.overall = Float(Int(Float(newItem.aroma + newItem.appearance + newItem.palate + newItem.taste)/30*500))/100
        overall.text = "Overall - \((newItem.overall))/5"
    }
    
    @IBAction func sliderTaste(_ sender: Any)
    {
        let tempVal = Int(tasteSlider.value)
        tasteSlider.value = Float(tempVal)
        newItem.taste = tempVal
        taste.text = "Taste - \(tempVal)/10"
        newItem.overall = Float(Int(Float(newItem.aroma + newItem.appearance + newItem.palate + newItem.taste)/30*500))/100
        overall.text = "Overall - \((newItem.overall))/5"
    }
    
    
    @IBAction func add(_ sender: Any)
    {
        if let string = beerName.text
        {
            newItem.name = string
        }
        if let string = breweryName.text
        {
            newItem.brewery = string
        }
        if let string = styleName.text
        {
            newItem.style = string
        }
        if let string = countryName.text
        {
            newItem.country = string
        }
        if let string = thoughts.text
        {
            newItem.thoughts = string
        }
        
        
        
       if (newItem.aroma != 0) && (newItem.appearance != 0) && (newItem.palate != 0) && (newItem.taste != 0) && (newItem.name != "") && (newItem.brewery != "") && (newItem.style != "") && (newItem.country != "") && (newItem.thoughts != "")
       {
            newItem.date = NSDate()
        
            BeerList.append(newItem)
        
            //UserDefaults.standard.set(BeerList, forKey: "BeerList")
        
            let alert = UIAlertController(title: "Beer Added", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
        
            saveData()
        
            self.present(alert, animated: true, completion: nil)
        
            newItem.name = ""
            newItem.brewery = ""
            newItem.style = ""
            newItem.country = ""
            newItem.thoughts = ""
            newItem.aroma = 0
            newItem.appearance = 0
            newItem.palate = 0
            newItem.taste = 0
            newItem.overall = 0
            beerName.text = nil
            breweryName.text = nil
            styleName.text = nil
            countryName.text = nil
            aromaSlider.value = 1
            appearanceSlider.value = 1
            palateSlider.value = 1
            tasteSlider.value = 1
            aroma.text = "Aroma - 0/10"
            appearance.text = "Appearance - 0/5"
            palate.text = "Palate - 0/5"
            taste.text = "Taste - 0/10"
            overall.text = "Overall - 0/5"
            thoughts.text = "Wonderful! Very balanced which is not the case with every beer I have had. Hides the abv well! There’s like just a subtle hint of hops... It’s pretty great."
     
        }
        else
       {
            let alert = UIAlertController(title: "Fill every field", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
        
            self.present(alert, animated: true, completion: nil)
        
        }
    }


    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
