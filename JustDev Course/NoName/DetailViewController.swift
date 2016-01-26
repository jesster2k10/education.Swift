//
//  DetailViewController.swift
//  TableView lesson
//
//  Created by Родыгин Дмитрий on 19.01.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var data = DataSource(name: "", type: "", location: "", isVisited: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "nnm")
        
        // Do any additional setup after loading the view.
        tableView.backgroundColor = UIColor.grayColor()
        
        title = data.name
        
        //cell resize
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DetailViewCustomTableViewCell
        cell.backgroundColor = UIColor.grayColor()
        
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = data.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = data.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = data.location
        case 3:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (data.isVisited) ? "Yes" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! DetailViewCustomTableViewCell
        
        if cell.fieldLabel.text == "Been here" {
            if data.isVisited {
                data.isVisited = false
                cell.valueLabel.text = "No"
            } else {
                data.isVisited = true
                cell.valueLabel.text = "Yes"
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backFromDetail" {
            
        }
    }
    
    //Показать navigation bar
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
