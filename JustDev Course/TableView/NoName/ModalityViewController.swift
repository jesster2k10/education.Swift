//
//  ModalityViewController.swift
//  TableView lesson
//
//  Created by Родыгин Дмитрий on 28.01.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import UIKit

class ModalityViewController: UIViewController {

    @IBOutlet weak var backgrounImage: UIImageView!
    @IBOutlet weak var stack: UIStackView!
    var rating : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scale = CGAffineTransformMakeScale(0, 0)
        let translation = CGAffineTransformMakeTranslation(0, 500)
        stack.transform = CGAffineTransformConcat(scale, translation)

        
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        
        backgrounImage.addSubview(blurEffectView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: {
            self.stack.transform = CGAffineTransformIdentity }, completion: nil)
    }
    
    @IBAction func rateSelect(sender: UIButton) {
        switch sender.tag {
        case 1: rating = "dislike"
        case 2: rating = "good"
        case 3: rating = "great"
        default: break
        }
        performSegueWithIdentifier("unwindToDetail", sender: sender)
    }

}
