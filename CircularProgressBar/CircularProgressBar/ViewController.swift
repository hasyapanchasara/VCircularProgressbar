//
//  ViewController.swift
//  CircularProgressBar
//
//  Created by vishal on 11/14/17.
//  Copyright © 2017 vishal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var i = 0
    var timer = Timer()
    var obj = VCircularProgressBar()
    @IBOutlet weak var lblPercentage: UILabel!
    
    @IBOutlet weak var btnDownload: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //make Instanse of VCircularProgressBar
        obj = VCircularProgressBar.init(self.view, radius: 100)
        obj.ProgressColor = UIColor.black
        obj.ProgrssWidth = 10.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lblPercentage.textColor =  UIColor.green
    }
    
    @objc func loadViewCustom() {
        if i < 101 {
            lblPercentage.text = "\(i)%"
            
            if i < 50
            {
                lblPercentage.textColor =  UIColor.green
            }
            else if i > 50 && i < 70
            {
                lblPercentage.textColor =  UIColor.yellow
            }
            else if i > 70
            {
                lblPercentage.textColor =  UIColor.red
            }
            //call the Method Of for draw ProgressBar circular
            obj.MakeProgressBar(ProgressPercentage: i)
            i += 1
        }else{
            timer.invalidate()
            btnDownload.setTitle("Start Download", for: .normal)
            btnDownload.tag = 0
            i = 0
        }
    }
    
    
    @IBAction func StartDownload(_ sender: UIButton) {
        
        if sender.tag == 0{
            sender.tag = 1
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.loadViewCustom), userInfo: nil, repeats: true)
            sender.setTitle("Stop Download", for: .normal)
        }else{
            sender.tag = 0
            sender.setTitle("Start Download", for: .normal)
            timer.invalidate()
            i = 0
        }
     }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

