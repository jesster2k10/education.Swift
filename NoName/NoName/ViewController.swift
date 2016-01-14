//
//  ViewController.swift
//  NoName
//
//  Created by Родыгин Дмитрий on 14.01.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource = ["zTest 1", "zTest 2","zTest 3","zTest 4","zTest 5"]
    var locationDataSource = ["location zTest 1", "location zTest 2","location zTest 3","location zTest 4","location zTest 5"]
    var typeDataSource = ["type zTest 1", "type zTest 2","type zTest 3","type zTest 4","type zTest 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        
        cell.thumbnailImageView?.image = UIImage(named: "nnm")
        cell.nameLabel?.text = dataSource[indexPath.row]
        cell.locationLabel?.text = locationDataSource[indexPath.row]
        cell.typeLabel?.text = typeDataSource[indexPath.row]
        
        cell.thumbnailImageView.layer.cornerRadius = 30.0
        //Разрешает быть картинке обрезанной:
        cell.thumbnailImageView.clipsToBounds = true
        
        return cell
    }
    
    //Убрать статус бар:
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

