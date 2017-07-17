//
//  ViewController.swift
//  LongitudeLatitude
//
//  Created by 鳥居隆弘 on 2017/07/17.
//  Copyright © 2017年 鳥居隆弘. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lat_A: UITextField!
    @IBOutlet weak var lat_B: UITextField!
    @IBOutlet weak var lon_A: UITextField!
    @IBOutlet weak var lon_B: UITextField!
    
    @IBOutlet weak var calc_times: UITextField!
    
    @IBOutlet weak var dist_1: UILabel!
    @IBOutlet weak var dist_2: UILabel!
    
    @IBOutlet weak var calcTime_1: UILabel!
    
    @IBOutlet weak var calcTime_2: UILabel!
    
    
    @IBOutlet weak var rad_1: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calcStart(_ sender: Any) {
        
        let A = Point(lon: Double( lon_A.text! ) ?? 0 ,lat: Double( lat_A.text! ) ?? 0 )
        let B = Point(lon: Double( lon_B.text! ) ?? 0 ,lat: Double( lat_B.text! ) ?? 0 )
        
        dist_1.text = dist(a:A , b:B).description
        dist_2.text = dist2(a:A , b:B).description
        rad_1.text = rad(a:A , b:B).description
        
        var counter = 0
        if Int(calc_times.text!) == nil { calc_times.text = 1.description
            counter = 1
        }else{
            counter = Int(calc_times.text!)!
        }
        
        let start1 = Date()
        for _ in 0..<counter {
            dist(a:A , b:B)
        }
        let elapsed1 = NSDate().timeIntervalSince(start1)
        print(elapsed1)
        
        let start2 = Date()
        for _ in 0..<counter {
            dist2(a:A , b:B)
        }
        let elapsed2 = NSDate().timeIntervalSince(start2)
        print(elapsed2)
        
        let start3 = Date()
        for _ in 0..<counter {
            dist3(a:A , b:B)
        }
        let elapsed3 = NSDate().timeIntervalSince(start3)
        print(elapsed3)
        
        calcTime_1.text = elapsed1.description
        calcTime_2.text = elapsed2.description
        
    }
}

extension ViewController{
    
    func dist(a:Point,b:Point ) -> Double{
        /*
         三平方、球面は考慮しない
         */
        return sqrt( pow(len * (b.lat - a.lat) , 2) + pow(len*( b.lon - a.lon) , 2) )
    }
    
    func dist2(a:Point,b:Point ) -> Double{
        /*
         球面三角法
         dist = Rcos-1(sin(y1)sin(y2)+cos(y1)cos(x2-x1))
         */
        return R * acos( (sin( a.y ) * sin(b.y )) + ( cos( a.y ) * cos( b.y ) * cos( b.x  - a.x ) )  )
    }
    
    func dist3(a:Point,b:Point ) -> Double{
        /*
         CoreLocationライブラリ
         */
        let pointA: CLLocation = CLLocation(latitude: a.lat , longitude: a.lon )
        let pointB: CLLocation = CLLocation(latitude: b.lat , longitude: b.lon )
        return pointB.distance(from: pointA)
        
    }
    
    
    func rad(a:Point,b:Point ) -> Double{
        /*
         atan2(sin(x2-x1),cos(y1)tan(y2)-sin(y1)cos(x2-x1))
         */
        return (180/Double.pi) * atan2( sin( b.x - a.x ), cos(a.y) * tan(b.y) - sin( a.y ) * cos(b.x - a.x) )
    }
    
    
}



//==========let
let R = 6378.137
let rad = Double.pi / 180 //1 radian
let len = 2 * Double.pi * R / 360 // 緯度経度1度あたりの距離

//==========struct
struct Point{
    var lon:Double = 0.0 //経度 x
    var lat:Double = 0.0 //緯度 y
    var x:Double{           //経度 xラジアン
        get{
            return lon * rad
        }
    }
    var y:Double{           //緯度 yラジアン
        get{
            return lat * rad
        }
    }
}


