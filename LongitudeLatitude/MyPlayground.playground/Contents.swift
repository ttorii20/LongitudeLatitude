//: Playground - noun: a place where people can play

import Foundation


//==========let
let R = 6378.137
let rad = M_PI / 180 //1 radian
let len = 2 * M_PI * R / 360 // 緯度経度1度あたりの距離

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


//==========func

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

func rad(a:Point,b:Point ) -> Double{
    /*
     atan2(sin(x2-x1),cos(y1)tan(y2)-sin(y1)cos(x2-x1))
     */
    return (180/M_PI) * atan2( sin( b.x - a.x ), cos(a.y) * tan(b.y) - sin( a.y ) * cos(b.x - a.x) )
}





let A = Point(lon:10 ,lat:50)
let B = Point(lon:5 ,lat:20)



dist(a:A , b:B)
dist2(a:A , b:B)
rad(a:A , b:B)


var start = Date()
for _ in 0..<100{
    dist(a:A , b:B)
}
var elapsed = NSDate().timeIntervalSince(start)
print(elapsed)



start = Date()
for _ in 0..<100{
    dist2(a:A , b:B)
}
elapsed = NSDate().timeIntervalSince(start)
print(elapsed)







