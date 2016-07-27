//
//  Copyright © 2016 Guo Xin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EMSegmentViewDelegate{

  @IBOutlet var segmentView: EMSegmentView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    segmentView.delegate = self
    segmentView.configureSegmentTitle(["BUY", "RENT", "SOLD"])
    
    let segView: EMSegmentView = EMSegmentView(segmentTitles: ["A", "B"])
    segView.delegate = self
    segView.configureSegmentView(UIColor.purpleColor())
    segView.frame = CGRectMake(20, 20, 320, 35)
    view.addSubview(segView)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

