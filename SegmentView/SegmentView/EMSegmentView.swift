//
//  Copyright © 2016 Guo Xin. All rights reserved.
//

import UIKit

class EMSegmentView: UIView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func willMoveToWindow(newWindow: UIWindow?) {
    super.willMoveToWindow(newWindow)
    if self.themeColor == nil {
      configureSegmentView()
    }
    loadSegmentView()
  }
  
  var delegate: EMSegmentViewDelegate!
  
  private var segmentTitles: [String] = []
  private var themeColor: UIColor!
  private var bgColor: UIColor!
  private var btnTitleColor :UIColor!
  private var segmentBtnsHeight: CGFloat!
  private var titleFontSize: CGFloat!
  private var contentView: UIView = UIView()
  
  private var segmentHintView = UIView()
  private var segmentBtns: [UIButton]! = []
  private var segmentHintLeftContraint: NSLayoutConstraint!
  
  init() {
    super.init(frame: CGRect())
    configureSegmentView()
  }
  
  func configureSegmentView(themeColor: UIColor = UIColor.redColor(), bgColor: UIColor = UIColor.whiteColor(), btnTitleColor: UIColor = UIColor.darkGrayColor(), segmentBtnsHeight: CGFloat = 35.0, titleFontSize: CGFloat = 13.0) {
    self.themeColor = themeColor
    self.bgColor = bgColor
    self.btnTitleColor = btnTitleColor
    self.segmentBtnsHeight = segmentBtnsHeight
    self.titleFontSize = titleFontSize
  }
  
  func reloadSegmentView() {
    self.subviews.forEach() { subview in
      subview.removeFromSuperview()
    }
    loadSegmentView()
  }
  
  private func loadSegmentView() {
    layer.cornerRadius = 4.0
    clipsToBounds = true
    backgroundColor = bgColor
    guard let delegate = self.delegate else {
      return
    }
    segmentTitles = delegate.segmentTitlesForSegmentView(self)
    contentView = delegate.contentViewForSegmentView(self)
    loadSegmentBtns()
    loadSegmentHintView()
    loadContentView()
  }
  
  private func loadSegmentBtns() {
    segmentBtns = []
    for i in 0..<segmentTitles.count {
      let title = segmentTitles[i]
      let segmentBtn: UIButton = UIButton()
      segmentBtn.backgroundColor = nil
      segmentBtn.translatesAutoresizingMaskIntoConstraints = false
      segmentBtn.setTitle(title, forState: UIControlState(rawValue: 0))
      segmentBtn.setTitleColor(i == 0 ? themeColor : btnTitleColor, forState: UIControlState(rawValue: 0))
      segmentBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(titleFontSize)
      segmentBtn.addTarget(self, action: #selector(selectSegment(_:)), forControlEvents: UIControlEvents.TouchUpInside)
      segmentBtn.tag = i
      addSubview(segmentBtn)
      segmentBtns.append(segmentBtn)
      
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat( "V:|[segmentBtn(height)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["height": segmentBtnsHeight], views: ["segmentBtn": segmentBtn] ))
    }
    guard let visualFommatString = generateSegmentBtnsAutoLayoutVisualFommatString() else {
      return
    }
    guard let segmentBtnsDic = generateSegmentBtnsDic(segmentTitles, segmentBtns: segmentBtns) else {
      return
    }
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFommatString, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: segmentBtnsDic))
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
  
  private func loadContentView() {
    addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[contentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["contentView": contentView]))
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[segmentHintView][contentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["contentView": contentView, "segmentHintView": segmentHintView]))
  }
}