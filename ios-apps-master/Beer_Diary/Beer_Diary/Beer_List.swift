//
//  Beer_List.swift
//  Beer_Diary
//
//  Created by Piotr Mielcarzewicz on 13/11/16.
//  Copyright © 2016 Piotr Mielcarzewicz. All rights reserved.
//

import UIKit

var BeerList = [BeerItem]()
var detailed = BeerItem()

class Beer_List: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredBeers = [BeerItem]()
    
    func filterContentForSearchText(searchText: String, scope: String = "All")
    {
        filteredBeers = BeerList.filter{ beer in
            return beer.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.object(forKey: "name") != nil
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
            
            tname = UserDefaults.standard.object(forKey: "name") as! [String]
            tbrewery = UserDefaults.standard.object(forKey: "brewery") as! [String]
            tstyle = UserDefaults.standard.object(forKey: "style") as! [String]
            tcountry = UserDefaults.standard.object(forKey: "country") as! [String]
            tthoughts = UserDefaults.standard.object(forKey: "thoughts") as! [String]
            taroma = UserDefaults.standard.object(forKey: "aroma") as! [Int]
            tappearance = UserDefaults.standard.object(forKey: "appearance") as! [Int]
            tpalate = UserDefaults.standard.object(forKey: "palate") as! [Int]
            ttaste = UserDefaults.standard.object(forKey: "taste") as! [Int]
            tscore = UserDefaults.standard.object(forKey: "score") as! [Float]
            tdate = UserDefaults.standard.object(forKey: "date") as! [NSDate]
            
            
            
            for x in 0..<tname.count
            {
                var beer = BeerItem()
                beer.name = tname[x]
                beer.brewery = tbrewery[x]
                beer.style = tstyle[x]
                beer.country = tcountry[x]
                beer.thoughts = tthoughts[x]
                beer.aroma = taroma[x]
                beer.appearance = tappearance[x]
                beer.palate = tpalate[x]
                beer.taste = ttaste[x]
                beer.overall = tscore[x]
                beer.thoughts = tthoughts[x]
                beer.date = tdate[x]
                BeerList.append(beer)
            }
            
            
            tableView.reloadData()
            
            
        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if searchController.isActive && searchController.searchBar.text != ""
        {
            return filteredBeers.count
        }
        
        return BeerList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath)

        let beer: BeerItem
        
        if searchController.isActive && searchController.searchBar.text != ""
        {
            beer = filteredBeers[indexPath.row]
        }
        else
        {
            beer = BeerList[indexPath.row]
        }
        
        cell.textLabel?.text = "\(beer.name) - \(beer.overall)/5"
        cell.detailTextLabel?.text = beer.brewery
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            BeerList.remove(at: indexPath.row)
            saveData()
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "detailed1"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                if searchController.isActive && searchController.searchBar.text != ""
                {
                    detailed = filteredBeers[indexPath.row]
                }
                else
                {
                    detailed = BeerList[indexPath.row]
                }
            }
            
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



extension Beer_List: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}


