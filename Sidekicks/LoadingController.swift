//
//  LoadingController.swift
//  Sidekicks
//
//  Created by Jacob Paris on 2/04/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import UIKit

class LoadingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("timeToMoveOn"), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timeToMoveOn(){
        self.performSegueWithIdentifier("goToHome", sender: self)
    }


}

