# segment-view-swift(practice project)

####Create a segment view with interface builder
Add a view to your father view and than set your controller to be a delegate.

`segmentView.delegate = self`<br>
`segmentView.configureSegmentTitles(["A", "B", "C"])`<br>

You can config it with the method.
 
`configureSegmentView(themeColor: UIColor, bgColor: UIColor, btnTitleColor: UIColor, segmentBtnsHeight: CGFloat, titleFontSize: CGFloat)`<br>

Every para has a default value. You can set what you like.
####Create a segment view with interface builder
`segmentView = EMSegmentView(["A", "B", "C"])`

#####The protocol method in your controller
`func didSelectSegment(segmentView: EMSegmentView, atIndexPath indexPath: Int)`<br>

- this is the segment button click event, do what you want, and give you the indexpath to show which button you pressed.
