//
//  Copyright © 2016 Guo Xin. All rights reserved.
//

import UIKit

class EMSegmentView: UIView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureSegmentView()
  }
  
  override func willMoveToWindow(newWindow: UIWindow?) {
    super.willMoveToWindow(newWindow)
    loadSegmentView()
  }
  
  var delegate: EMSegmentViewDelegate!
  
  private var segmentTitles: [String] = []
  private var themeColor: UIColor!
  private var bgColor: UIColor!
  private var btnTitleColor :UIColor!
  private var titleFontSize: CGFloat!
  
  private var segmentHintView = UIView()
  private var segmentBtns: [UIButton]! = []
  private var segmentHintLeftContraint: NSLayoutConstraint!
  
  init(segmentTitles: [String]) {
    super.init(frame: CGRect())
    configureSegmentView()
    self.segmentTitles = segmentTitles
  }
  
  func configureSegmentTitle(segmentTitles: [String]) {
    self.segmentTitles = segmentTitles
  }
  
  func configureSegmentView(themeColor: UIColor = UIColor.redColor(), bgColor: UIColor = UIColor.whiteColor(), btnTitleColor: UIColor = UIColor.darkGrayColor(), titleFontSize: CGFloat = 13.0) {
    self.themeColor = themeColor
    self.bgColor = bgColor
    self.btnTitleColor = btnTitleColor
    self.titleFontSize = titleFontSize
  }
  
  func reloadSegmentView() {
    self.subviews.forEach() { subview in
      subview.removeFromSuperview()
    }
    loadSegmentView()
  }
  
  func selectSegment(sender: UIButton) {
    segmentBtns.forEach() { segmentBtn -> Void in
      segmentBtn.setTitleColor(btnTitleColor, forState: UIControlState(rawValue: 0))
    }
    sender.setTitleColor(themeColor, forState: UIControlState(rawValue: 0))
    removeConstraint(segmentHintLeftContraint)
    segmentHintLeftContraint = NSLayoutConstraint(item: segmentHintView, attribute: .Left, relatedBy: .Equal, toItem: sender, attribute: .Left, multiplier: 1.0, constant: 0.0)
    addConstraint(segmentHintLeftContraint)
    UIView.animateWithDuration(0.5, animations: { [weak self] () -> () in
      if let strongSelf = self {
        strongSelf.layoutIfNeeded()
      }
      })
    delegate.didSelectSegment(self, atIndexPath: sender.tag)
  }
  
  private func loadSegmentView() {
    clipsToBounds = true
    backgroundColor = bgColor
    loadSegmentBtns()
    loadSegmentHintView()
  }
  
  private func loadSegmentBtns() {
    segmentBtns = []
    for i in 0..<segmentTitles.count {
      let segmentBtn = setOneSegmentBtn(i)
      segmentBtns.append(segmentBtn)
    }
    guard let visualFommatString = generateSegmentBtnsAutoLayoutVisualFommatString() else {
      return
    }
    guard let segmentBtnsDic = generateSegmentBtnsDic(segmentTitles, segmentBtns: segmentBtns) else {
      return
    }
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFommatString, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: segmentBtnsDic))
  }
  
  private func setOneSegmentBtn(index: Int) -> UIButton {
    let title = segmentTitles[index]
    let segmentBtn: UIButton = UIButton()
    segmentBtn.backgroundColor = nil
    segmentBtn.translatesAutoresizingMaskIntoConstraints = false
    segmentBtn.setTitle(title, forState: UIControlState(rawValue: 0))
    segmentBtn.setTitleColor(index == 0 ? themeColor : btnTitleColor, forState: UIControlState(rawValue: 0))
    segmentBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(titleFontSize)
    segmentBtn.addTarget(self, action: #selector(selectSegment(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    segmentBtn.tag = index
    addSubview(segmentBtn)
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat( "V:|[segmentBtn]-2-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["segmentBtn": segmentBtn] ))
    return segmentBtn
  }
  
  private func generateSegmentBtnsAutoLayoutVisualFommatString() -> String? {
    var autoLayoutVisualFommatString = "|"
    for i in 0..<segmentTitles.count {
      autoLayoutVisualFommatString += "[\(segmentTitles[i])"
      autoLayoutVisualFommatString += i == 0 ?  "]" : "(==\(segmentTitles[i - 1]))]"
    }
    autoLayoutVisualFommatString += "|"
    return autoLayoutVisualFommatString == "||" ? nil : autoLayoutVisualFommatString
  }
  
  private func generateSegmentBtnsDic(segmentTitles: [String], segmentBtns: [UIButton]) -> Dictionary<String, UIButton>? {
    var segmentBtnsDic = Dictionary<String, UIButton>()
    for i in 0..<segmentTitles.count {
      segmentBtnsDic[segmentTitles[i]] = segmentBtns[i]
    }
    return segmentBtnsDic.count == 0 ? nil : segmentBtnsDic
  }
  
  private func loadSegmentHintView() {
    guard let segmentBtn = segmentBtns.first else {
      return
    }
    segmentHintView.backgroundColor = themeColor
    segmentHintView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(segmentHintView)
    segmentHintLeftContraint = NSLayoutConstraint(item: segmentHintView, attribute: .Left, relatedBy: .Equal, toItem: segmentBtn, attribute: .Left, multiplier: 1.0, constant: 0.0)
    addConstraint(segmentHintLeftContraint)
    addConstraint(NSLayoutConstraint(item: segmentHintView, attribute: .Width, relatedBy: .Equal, toItem: segmentBtn, attribute: .Width, multiplier: 1.0, constant: 0.0))
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[segmentBtn][segmentHintView(2)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["segmentHintView": segmentHintView, "segmentBtn": segmentBtn]))
  }
}