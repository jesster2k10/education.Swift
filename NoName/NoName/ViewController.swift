//
//  ViewController.swift
//  NoName
//
//  Created by Родыгин Дмитрий on 14.01.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = ["zTest 1", "zTest 2","zTest 3","zTest 4","zTest 5"]
    var locationDataSource = ["location zTest 1", "location zTest 2","location zTest 3","location zTest 4","location zTest 5"]
    var typeDataSource = ["type zTest 1", "type zTest 2","type zTest 3","type zTest 4","type zTest 5"]
    var visitedDataSource = [true,false,false,false,false]
    
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
        
        if visitedDataSource[indexPath.row] {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        cell.thumbnailImageView.layer.cornerRadius = 10.0
        //Разрешает быть картинке обрезанной:
        cell.thumbnailImageView.clipsToBounds = true
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "Что сделать?", preferredStyle: .ActionSheet)
        let cancelMenu = UIAlertAction(title: "Отменить", style: .Cancel, handler: nil)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let isVisitedAction = UIAlertAction(title: "Я был сдесь", style: .Default, handler: { (action: UIAlertAction) -> Void in
            cell?.accessoryType = .Checkmark
            self.visitedDataSource[indexPath.row] = true
        })
        let notVisitedAction = UIAlertAction(title: "Меня сдеть не было", style: .Default, handler: { (action: UIAlertAction) -> Void in
            cell?.accessoryType = .None
            self.visitedDataSource[indexPath.row] = false
            })
        
        let callActionHandler = { (action: UIAlertAction) -> Void in
            let alertMessage = UIAlertController(title: "Сервис недоступен", message: "Читай это сообщение два раза сверху вниз, справо налево, до прозрения.", preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        
        let callAction = UIAlertAction(title: "Набрать " + "\(indexPath.row)", style: .Default, handler: callActionHandler)
        
        optionMenu.addAction(cancelMenu)
        optionMenu.addAction(callAction)
        if visitedDataSource[indexPath.row] {
            optionMenu.addAction(notVisitedAction)
        } else {
            optionMenu.addAction(isVisitedAction)
        }
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath    indexPath: NSIndexPath) {
//        
//    }
    
    //Действие при свапе вдоль ячейки:
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .Default, title: "Поделиться", handler: { (action, indexPath) -> Void in
            let defaultText = "Just checking in at" + self.dataSource[indexPath.row]
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.presentViewController(activityController, animated: true, completion: nil)
            })
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Удалить", handler: { (action, indexPath) -> Void in
            self.dataSource.removeAtIndex(indexPath.row)
            self.locationDataSource.removeAtIndex(indexPath.row)
            self.typeDataSource.removeAtIndex(indexPath.row)
            self.visitedDataSource.removeAtIndex(indexPath.row)
                
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            })
        
        shareAction.backgroundColor = UIColor.blueColor()
        return [deleteAction, shareAction]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! DetailViewController
                destinationController.cellImage = "nnm"
                destinationController.nameLabel = dataSource[indexPath.row]
                destinationController.locationLabel = locationDataSource[indexPath.row]
            }
        }
    }
    
    //Убрать статус бар:
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

