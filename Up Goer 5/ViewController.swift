//
//  ViewController.swift
//  Up Goer 5
//
//  Created by Sam Ehrenstein on 10/21/16.
//  Copyright © 2016 MBHS Smartphone Programming Club. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    var motionManager:CMMotionManager!
    var going=false
    var score=0
    let mass=0.14
    let DEADBAND=0.3
    let STEP=0.02
    @IBOutlet var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scoreLabel.text="0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    When the button is released, we begin measuring acceleration. As long as |a| is close to 1, the device is in the air. It stops if this is not the case.
    */
    @IBAction func startMotion(sender:UIButton!){
        print("Starting")
        motionManager=CMMotionManager()
        going=true
        score=0
        scoreLabel.text="0"
        motionManager.deviceMotionUpdateInterval=STEP
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()){
            [weak self](data:CMDeviceMotion?, error:NSError?) in
            print("\((data?.userAcceleration)!)")
            let totalAccel=sqrt(pow((data?.userAcceleration.x)!,2.0)+pow((data?.userAcceleration.y)!,2.0)+pow((data?.userAcceleration.z)!,2.0))
            if(abs(totalAccel-1))<self!.DEADBAND{ //check if acceleration is within deadband of 1
                self!.score += 1
            } else {
                self!.motionManager.stopDeviceMotionUpdates()
            }
            self!.scoreLabel.text="\(self!.score)"
        }
    }
}

