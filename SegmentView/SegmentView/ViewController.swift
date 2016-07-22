//
//  Copyright © 2016 Guo Xin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EMSegmentViewDelegate {

  @IBOutlet var segmentView: EMSegmentView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    segmentView.delegate = self
    
    let segView: EMSegmentView = EMSegmentView()
    segView.delegate = self
    segView.configureSegmentView(UIColor.purpleColor())
    segView.frame = CGRectMake(0, 20, 320, 85)
    segView.tag = 1
    view.addSubview(segView)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func segmentTitlesForSegmentView(segmentView: EMSegmentView) -> [String] {
    return segmentView.tag == 1 ? ["A", "B"] : ["BUY", "RENT", "SOLD"]
  }
  
  func contentViewForSegmentView(segmentView: EMSegmentView) -> UIView {
    let searchAreaView = UIView()
    
    let searchImageView = UIImageView(image: UIImage(named: "tabSearchActive"))
    searchImageView.translatesAutoresizingMaskIntoConstraints = false
    searchAreaView.addSubview(searchImageView)
    
    searchAreaView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-17-[searchImageView(16)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["searchImageView": searchImageView]))
    
    let searchTextField = UITextField()
    searchTextField.translatesAutoresizingMaskIntoConstraints = false
    searchTextField.placeholder = "Search suburbs"
    searchAreaView.addSubview(searchTextField)
    
    searchAreaView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[searchImageView(16)]-10-[searchTextField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["searchImageView": searchImageView, "searchTextField": searchTextField]))
    searchAreaView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-17-[searchTextField(16)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["searchTextField": searchTextField]))
    
    return searchAreaView
  }
}

