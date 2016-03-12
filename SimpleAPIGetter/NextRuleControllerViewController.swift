//
//  NextRuleControllerViewController.swift
//  SimpleAPIGetter
//
//  Created by 阪田祐宇 on 2016/03/11.
//  Copyright © 2016年 fefe. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class NextRuleControllerViewController: UIViewController {
    @IBOutlet var rule:UILabel?
    @IBOutlet var map:UILabel?
    @IBOutlet var time:UILabel?
    @IBOutlet var map_img1:UIImageView?
    @IBOutlet var map_img2:UIImageView?
    
    var maps:JSON?
    let map_images:[String] = [
        "arowana.jpeg",
        "antyobi.jpg",
        "kinmedai.jpg",
        "sionome.jpeg",
        "syotturu.jpeg",
        "tatiuo.jpg",
        "dekaline.jpg",
        "negitoro.jpg",
        "hakofugu.jpg",
        "hirame.jpg",
        "hokke.jpg",
        "masaba.jpg",
        "mahimahi.jpeg",
        "mozuku.jpg",
        "mongara.jpeg",
        "bbasu.jpg"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        getSplatoonInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: UIStoryboardSegue) {}
    
    func getNowRule() {
        let urlString = "http://splapi.retrorocket.biz/gachi/next"
        Alamofire.request(.GET, urlString)
            .responseJSON { responce in
                if let base = responce.result.value {
                    let result = JSON(base)
                    result.forEach { (key, json) in
                        let format = NSDateFormatter()
                        format.dateFormat = "HH:mm:ss"
                        let start = String(json[0]["start"]).componentsSeparatedByString("T")[1]
                        let end = String(json[0]["end"]).componentsSeparatedByString("T")[1]
                        self.rule?.text = String(json[0]["rule"])
                        self.map?.text = String(json[0]["maps"][0]) + "\n" + String(json[0]["maps"][1])
                        self.time?.text = start + "~" + end
                        let map_index_one = self.maps?.arrayValue.indexOf(json[0]["maps"][0])
                        let map_index_twe = self.maps?.arrayValue.indexOf(json[0]["maps"][1])
                        self.map_img1?.image = UIImage(named: self.map_images[Int(map_index_one!)])
                        self.map_img2?.image = UIImage(named: self.map_images[Int(map_index_twe!)])
                    }
                }
        }
    }
    
    func getSplatoonInfo() {
        let urlString = "http://splapi.retrorocket.biz/maps"
        Alamofire.request(.GET, urlString)
            .responseJSON { responce in
                if let base = responce.result.value {
                    let result = JSON(base)
                    result.forEach { (key, value) in
                        self.maps = value
                    }
                    self.getNowRule()
                }
        }
    }

}
