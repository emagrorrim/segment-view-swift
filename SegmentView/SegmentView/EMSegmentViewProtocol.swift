//
//  Copyright © 2016 Guo Xin. All rights reserved.
//

import UIKit

protocol EMSegmentViewDelegate {
  func segmentTitlesForSegmentView(segmentView: EMSegmentView) -> [String]
  func contentViewForSegmentView(SegmentView: EMSegmentView) -> UIView
  func didSelectSegment(segmentView: EMSegmentView, atIndexPath indexPath: Int)
}

extension EMSegmentViewDelegate {
  func didSelectSegment(segmentView: EMSegmentView, atIndexPath indexPath: Int) {}
}
