//
//  UtilClass.swift
//  CircularProgressBar
//
//  Created by vishal on 11/15/17.
//  Copyright © 2017 vishal. All rights reserved.
//

import UIKit

class VCircularProgressBar {

    var ProgrssWidth : CGFloat = 10.0
    var ProgressColor = UIColor.red
    private var viewCustom = UIView()
    private var array = [[CGFloat:CGFloat]]()
    private var ProgrssCircleRadius = CGFloat()
    let Startlbl = UILabel()
    let Endlbl = UILabel()
    var lastProgress = 1
    let path3 = UIBezierPath()
    let shapeLayer3 = CAShapeLayer()
    convenience init(_ addIntoView:UIView,radius:CGFloat) {
        self.init()
        ProgrssCircleRadius = radius
        viewCustom = addIntoView
        array = self.GetCirclePoints(midX: addIntoView.frame.midX, midY: addIntoView.frame.midY, radius: radius)
    }
    
    
    
    func MakeProgressBar(ProgressPercentage:Int) -> Void {
        
        
        Startlbl.frame = CGRect.init(x: 0, y: 0, width: ProgrssWidth, height:ProgrssWidth)
        Startlbl.layer.cornerRadius = Startlbl.frame.width/2
        Startlbl.layer.masksToBounds = true
        Startlbl.backgroundColor = ProgressColor
        Startlbl.center = CGPoint.init(x: Array(array[0].keys)[0], y: Array(array[0].values)[0])
        viewCustom.addSubview(Startlbl)
        
        
        if ProgressPercentage == 0{
            ReloadView()
        }
        let ProgressBarProgress = (ProgressPercentage * 359)/100
        
        if ProgressPercentage > 1 {
            DispatchQueue.main.async(execute: {
                for i in self.lastProgress...ProgressBarProgress {
                    let xpos = Array(self.array[i-1].keys)[0]
                    let ypos = Array(self.array[i-1].values)[0]
                    
                    let xpos1 = Array(self.array[i].keys)[0]
                    let ypos1 = Array(self.array[i].values)[0]
                    
                    
                    self.path3.move(to: CGPoint.init(x: xpos, y: ypos))
                    self.path3.addLine(to:CGPoint.init(x: xpos1, y:ypos1))
                    
                    self.shapeLayer3.path = self.path3.cgPath
                    self.shapeLayer3.strokeColor = self.ProgressColor.cgColor
                    self.shapeLayer3.lineWidth = self.ProgrssWidth
                    self.viewCustom.layer.addSublayer(self.shapeLayer3)
                    if i == ProgressBarProgress
                    {
                        self.lastProgress = ProgressBarProgress
                    }
                }
            })
        }
        
        
        Endlbl.frame = CGRect.init(x: 0, y: 0, width: ProgrssWidth, height:ProgrssWidth)
        Endlbl.layer.cornerRadius = Endlbl.frame.width/2
        Endlbl.layer.masksToBounds = true
        Endlbl.backgroundColor = ProgressColor
        Endlbl.center = CGPoint.init(x: Array(array[ProgressBarProgress].keys)[0], y: Array(array[ProgressBarProgress].values)[0])
        viewCustom.addSubview(Endlbl)
    }
    
    private func ReloadView() {
        self.Startlbl.removeFromSuperview()
        self.Endlbl.removeFromSuperview()
        shapeLayer3.removeFromSuperlayer()
        path3.removeAllPoints()
        lastProgress = 1
    }
    
    
    private func GetCirclePoints(midX:CGFloat, midY:CGFloat, radius:CGFloat) -> [[CGFloat:CGFloat]] {
        
        var array = [[CGFloat:CGFloat]]()
        var temp090x = [CGFloat:CGFloat]()
        var temp90180x = [CGFloat:CGFloat]()
        var temp180270x = [CGFloat:CGFloat]()
        var temp270360x = [CGFloat:CGFloat]()
        
        for i in 1...360 {
            
            let xPos = midX + radius * sin(CGFloat(i))
            let yPos =  midY + radius*cos(CGFloat(i))
            
            if  xPos > midX &&  yPos < midY {
                temp090x[xPos] = yPos
            }else if xPos > midX && yPos > midY {
                temp90180x[xPos] = yPos
            }else if xPos < midX && yPos > midY {
                temp180270x[xPos] = yPos
            }else if xPos < midX && yPos < midY {
                temp270360x[xPos] = yPos
            }
        }
        
        let tempSorted090x = BubbleAsceSort(array: temp090x)
        let tempSorted90180x = BubbleDescSort(array: temp90180x)
        let tempSorted180270x = BubbleDescSort(array: temp180270x)
        let tempSorted270360x = BubbleAsceSort(array: temp270360x)
        
        for item in tempSorted090x {
            array.append(item)
        }
        for item in tempSorted90180x {
            array.append(item)
        }
        for item in tempSorted180270x {
            array.append(item)
        }
        for item in tempSorted270360x {
            array.append(item)
        }
        return array
    }
    
    private func BubbleDescSort(array : [CGFloat:CGFloat]) -> [[CGFloat:CGFloat]] {
        var sortedArray = Array(array.keys)
        var sortedvalueArray = Array(array.values)
        var sortedAboveIndex = sortedArray.count-1 // Assume all values are not in order
        repeat {
            var lastSwapIndex = 0
            
            for i in 1...sortedAboveIndex{
                if (sortedArray[i] as AnyObject) as! CGFloat > (sortedArray[i - 1] as AnyObject) as! CGFloat  {
                    sortedArray.swapAt(i, i-1)
                    sortedvalueArray.swapAt(i, i-1)
                    lastSwapIndex = i
                }
            }
            sortedAboveIndex = lastSwapIndex
            
        } while (sortedAboveIndex != 0)
        var index = 0
        var arr = [[CGFloat:CGFloat]]()
        for item in sortedArray {
            var dic = [CGFloat:CGFloat]()
            dic[item] = sortedvalueArray[index]
            arr.append(dic)
            index += 1
        }
        return arr
    }
    
    
    private func BubbleAsceSort(array : [CGFloat:CGFloat]) -> [[CGFloat:CGFloat]] {
        var sortedArray = Array(array.keys)
        var sortedvalueArray = Array(array.values)
        var sortedAboveIndex = sortedArray.count-1 // Assume all values are not in order
        repeat {
            var lastSwapIndex = 0
            
            for i in 1...sortedAboveIndex{
                if (sortedArray[i - 1] as AnyObject) as! CGFloat > (sortedArray[i] as AnyObject) as! CGFloat {
                    sortedArray.swapAt(i, i-1)
                    sortedvalueArray.swapAt(i, i-1)
                    lastSwapIndex = i
                }
            }
            sortedAboveIndex = lastSwapIndex
            
        } while (sortedAboveIndex != 0)
        var index = 0
        var arr = [[CGFloat:CGFloat]]()
        for item in sortedArray {
            var dic = [CGFloat:CGFloat]()
            dic[item] = sortedvalueArray[index]
            arr.append(dic)
            index += 1
        }
        return arr
    }
}
