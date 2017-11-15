# VCircularProgressbar

# Requirements
Xcode 8+          
Swift 3.0, Swift 4.0                   
iOS 8+                        
ARC

# Basic usage
## drag and drop the VCircularProgressBar.swift Class to your project. ##

**Make instance of VCircularProgressBar**

```
let obj = VCircularProgressBar.init(self.view, radius: 100)
obj.ProgressColor = UIColor.black
obj.ProgrssWidth = 10.0
```
**call this method every percentage and set the percentage into parameter**
```
obj.MakeProgressBar(ProgressPercentage: 50)
```

**Observer ( Delegate )**
```
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
```

<a href="https://github.com/vishalkalola1/VCircularProgressbar/blob/master/Progress.gif"><img src="https://github.com/vishalkalola1/VCircularProgressbar/blob/master/Progress.gif" title=""/></a>
