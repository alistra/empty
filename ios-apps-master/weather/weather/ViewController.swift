//
//  ViewController.swift
//  weather
//
//  Created by Piotr Mielcarzewicz on 15/10/16.
//  Copyright © 2016 Piotr Mielcarzewicz. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var app_name: UILabel!
    @IBOutlet weak var check_button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var guide: UILabel!
    @IBOutlet weak var weatherInfo: UILabel!
    
    
       
    let replacements = ["ą": "a", "ó": "o", "ę": "e", "ł": "l", "ń": "n", "ż": "z", "ź": "z", " ": "-"]
    
    @IBAction func checkWeather(_ sender: AnyObject)
    {
        var wasSuccesful = false
        var temp_textField = textField.text
        
        for x in replacements
        {
           temp_textField = temp_textField?.replacingOccurrences(of: x.key, with: x.value)
        }
        
        let attemptedURL = URL(string: "http://www.weather-forecast.com/locations/" + temp_textField! + "/forecasts/latest")
        
        if let url = attemptedURL
        {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let urlContent = data
                {
                    let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                    let websiteArray = webContent! .components(separatedBy: "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if websiteArray.count > 1
                    {
                        
                        var wheatherArray = websiteArray[1].components(separatedBy: "</span>")
                        
                        if wheatherArray.count > 1
                        {
                            
                            wasSuccesful = true
                            wheatherArray[0] = wheatherArray[0].replacingOccurrences(of: "&deg;", with: "°")
                            
                            DispatchQueue.main.async
                                {
                                    UIView.animate(withDuration: 0.5, animations: {
                                        self.weatherInfo.alpha = 0
                                        self.weatherInfo.text = wheatherArray[0]
                                        self.weatherInfo.alpha = 1
                                    })
                                }
                            
                        }
                        
                    }
                }
                
            }
            if wasSuccesful == false
            {
                DispatchQueue.main.async
                {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.weatherInfo.alpha = 0
                        self.weatherInfo.text = "Couldn't find the weather for that City"
                        self.weatherInfo.alpha = 1
                    })
                }
            }
            task.resume()
        }
        else
        {
            DispatchQueue.main.async
            {
                UIView.animate(withDuration: 0.5, animations: {
                    self.weatherInfo.alpha = 0
                    self.weatherInfo.text = "Couldn't find the weather for that City"
                    self.weatherInfo.alpha = 1
                })
            }
        }
        
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        weatherInfo.alpha = 0
        textField.center = CGPoint(x: textField.center.x, y: textField.center.y + 500)
        app_name.center = CGPoint(x: app_name.center.x, y: app_name.center.y + 500)
        guide.center = CGPoint(x: guide.center.x, y: guide.center.y + 500)
        check_button.center = CGPoint(x: check_button.center.x, y: check_button.center.y + 500)
        UIView.animate(withDuration: 1)
        {
            self.textField.center = CGPoint(x: self.textField.center.x, y: self.textField.center.y - 500)
            self.app_name.center = CGPoint(x: self.app_name.center.x, y: self.app_name.center.y - 500)
            self.guide.center = CGPoint(x: self.guide.center.x, y: self.guide.center.y - 500)
            self.check_button.center = CGPoint(x: self.check_button.center.x, y: self.check_button.center.y - 500)
        }
    }


}

