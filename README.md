# segment-view-swift(practice project)

####Create a segment view with interface builder
Add a view to your father view and than set your controller to be a delegate.

`segmentView.delegate = self`

You can config it with the method. 

`configureSegmentView(themeColor: UIColor, bgColor: UIColor, btnTitleColor: UIColor, segmentBtnsHeight: CGFloat, titleFontSize: CGFloat)`

Every para has a default value. You can set what you like.

#####The protocol method in your controller
`func segmentTitlesForSegmentView(segmentView: EMSegmentView) -> [String]`
`func contentViewForSegmentView(SegmentView: EMSegmentView) -> UIView`
`func didSelectSegment(segmentView: EMSegmentView, atIndexPath indexPath: Int)`

- first one is the segment title, return a string array
- second is the content view, show what you want to show under segment
- third one is the segment button click event, do what you want, and give you the indexpath to show which button you pressed.