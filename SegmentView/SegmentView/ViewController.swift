//
//  Copyright © 2016 Guo Xin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EMSegmentViewDelegate{

  @IBOutlet var segmentView: EMSegmentView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Create with Interface Builder
    segmentView.delegate = self
    segmentView.configureSegmentTitle(["BUY", "RENT", "SOLD"])
    
    //Create with code
    let segView: EMSegmentView = EMSegmentView(segmentTitles: ["BUY", "RENT", "SOLD"])
    segView.delegate = self
    segView.configureSegmentView(UIColor.purpleColor())
    view.addSubview(segView)
    segView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[segView(300)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["segView": segView]))
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-140-[segView(35)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["segView": segView]))
    self.view.addConstraint(NSLayoutConstraint(item: segView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

