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
    
//    var dataSource = ["zTest 1", "zTest 2","zTest 3","zTest 4","zTest 5"]
//    var locationDataSource = ["location zTest 1", "location zTest 2","location zTest 3","location zTest 4","location zTest 5"]
//    var typeDataSource = ["type zTest 1", "type zTest 2","type zTest 3","type zTest 4","type zTest 5"]
//    var visitedDataSource = [true,false,false,false,false]
    
    var dataSource : [DataSource] = [
        DataSource(name: "zTest 1", type: "zType 1", location: "zLocate 1", isVisited: true, rating: "dislike"),
        DataSource(name: "zTest 2", type: "zType 2", location: "zLocate 2", isVisited: false, rating: "great"),
        DataSource(name: "zTest 3", type: "zType 3", location: "zLocate 3-test-test-test-test-test-test-test-test", isVisited: false, rating: "good"),
        DataSource(name: "zTest 4", type: "zType 4", location: "zLocate 4", isVisited: false, rating: "rating"),
        DataSource(name: "zTest 5", type: "zType 5", location: "zLocate 5", isVisited: true, rating: "rating"),
        DataSource(name: "zTest 4", type: "zType 4", location: "zLocate 4", isVisited: false, rating: "rating"),
        DataSource(name: "zTest 4", type: "zType 4", location: "zLocate 4", isVisited: false, rating: "rating"),
        DataSource(name: "zTest 4", type: "zType 4", location: "zLocate 4", isVisited: false, rating: "rating"),
        DataSource(name: "zTest 4", type: "zType 4", location: "zLocate 4", isVisited: false, rating: "rating"),
        DataSource(name: "zTest 4", type: "zType 4", location: "zLocate 4", isVisited: false, rating: "rating")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //cell resize
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
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
        cell.nameLabel?.text = dataSource[indexPath.row].name
        cell.locationLabel?.text = dataSource[indexPath.row].location
        cell.typeLabel?.text = dataSource[indexPath.row].type
        
        dataSource[indexPath.row].isVisited ? (cell.accessoryType = .Checkmark) : (cell.accessoryType = .None)
        
        cell.thumbnailImageView.layer.cornerRadius = 10.0
        //Разрешает быть картинке обрезанной:
        cell.thumbnailImageView.clipsToBounds = true
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let optionMenu = UIAlertController(title: nil, message: "Что сделать?", preferredStyle: .ActionSheet)
//        let cancelMenu = UIAlertAction(title: "Отменить", style: .Cancel, handler: nil)
//        
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        let isVisitedAction = UIAlertAction(title: "Я был сдесь", style: .Default, handler: { (action: UIAlertAction) -> Void in
//            cell?.accessoryType = .Checkmark
//            self.visitedDataSource[indexPath.row] = true
//        })
//        let notVisitedAction = UIAlertAction(title: "Меня сдеть не было", style: .Default, handler: { (action: UIAlertAction) -> Void in
//            cell?.accessoryType = .None
//            self.visitedDataSource[indexPath.row] = false
//            })
//        
//        let callActionHandler = { (action: UIAlertAction) -> Void in
//            let alertMessage = UIAlertController(title: "Сервис недоступен", message: "Читай это сообщение два раза сверху вниз, справо налево, до прозрения.", preferredStyle: .Alert)
//            alertMessage.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
//            self.presentViewController(alertMessage, animated: true, completion: nil)
//        }
//        
//        let callAction = UIAlertAction(title: "Набрать " + "\(indexPath.row)", style: .Default, handler: callActionHandler)
//        
//        optionMenu.addAction(cancelMenu)
//        optionMenu.addAction(callAction)
//        if visitedDataSource[indexPath.row] {
//            optionMenu.addAction(notVisitedAction)
//        } else {
//            optionMenu.addAction(isVisitedAction)
//        }
//        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath    indexPath: NSIndexPath) {
//        
//    }
    
    //Действие при свапе вдоль ячейки:
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//        let shareAction = UITableViewRowAction(style: .Default, title: "Поделиться", handler: { (action, indexPath) -> Void in
//            let defaultText = "Just checking in at" + self.dataSource[indexPath.row].name
//            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
//            self.presentViewController(activityController, animated: true, completion: nil)
//            })
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Удалить", handler: { (action, indexPath) -> Void in
            self.dataSource.removeAtIndex(indexPath.row)
                
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            })
        
        let moreAction = UITableViewRowAction(style: .Default, title: "Еще", handler: {(action, indexPath) -> Void in
            let optionMenu = UIAlertController(title: nil, message: "Выберите действие:" , preferredStyle: .ActionSheet)
            let cancelAction = UIAlertAction(title: "Отменить", style: .Cancel, handler: nil)
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            let isVisited = UIAlertAction(title: "Я был тут", style: .Default, handler: { (action) -> Void in
                cell?.accessoryType = .Checkmark
                self.dataSource[indexPath.row].isVisited = true
            })
            let notVisited = UIAlertAction(title: "Я тут не был", style: .Default, handler: {(action) -> Void in
                cell?.accessoryType = .None
                self.dataSource[indexPath.row].isVisited = false
            })
            
            let callAction = UIAlertAction(title: "Позвонить " + "\(self.dataSource[indexPath.row].name)", style: .Default, handler: {(action) -> Void in
                let alertMessage = UIAlertController(title: "Ошибка", message: "В данный момент невозможно позвонить на этот номер", preferredStyle: .Alert)
                alertMessage.addAction(UIAlertAction(title: "Ок", style: .Destructive, handler: nil))
                self.presentViewController(alertMessage, animated: true, completion: nil)
            })
            
            let shareAction = UIAlertAction(title: "Поделиться", style: .Default, handler: {(action) -> Void in
                let defaultText = "Я тут: " + self.dataSource[indexPath.row].name
                let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            })
            
            self.dataSource[indexPath.row].isVisited ? optionMenu.addAction(notVisited) : optionMenu.addAction(isVisited)
            optionMenu.addAction(cancelAction)
            optionMenu.addAction(callAction)
            optionMenu.addAction(shareAction)
            self.presentViewController(optionMenu, animated: true, completion: nil)
            //Скрыть ActionsForRow
            tableView.setEditing(false, animated: true)
        })
        
        moreAction.backgroundColor = UIColor.grayColor()
        return [deleteAction, moreAction]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! DetailViewController
                destinationController.data = dataSource[indexPath.row]
            }
        }
    }
    
    //Спрятать navigation bar при свайпе
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        
        tableView.reloadData()
        
    }
    
    //Убрать статус бар:
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

