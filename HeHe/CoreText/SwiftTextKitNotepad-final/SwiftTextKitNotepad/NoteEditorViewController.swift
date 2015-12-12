//
//  NoteEditorViewController.swift
//  SwiftTextKitNotepad
//
//  Created by Gabriel Hauber on 18/07/2014.
//  Copyright (c) 2014 Gabriel Hauber. All rights reserved.
//

import UIKit

class NoteEditorViewController: UIViewController, UITextViewDelegate {

  var textView: UITextView!
  var textStorage: SyntaxHighlightTextStorage!

  var note: Note!
  var timeView: TimeIndicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()

    createTextView()
    textView.scrollEnabled = true

    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "preferredContentSizeChanged:",
      name: UIContentSizeCategoryDidChangeNotification,
      object: nil)

    timeView = TimeIndicatorView(date: note.timestamp)
    textView.addSubview(timeView)

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
  }

  func preferredContentSizeChanged(notification: NSNotification) {
    textStorage.update()
    updateTimeIndicatorFrame()
  }

  func textViewDidEndEditing(textView: UITextView) {
    note.contents = textView.text
  }

  override func viewDidLayoutSubviews() {
    updateTimeIndicatorFrame()
    textView.frame = view.bounds
  }

  func updateTimeIndicatorFrame() {
    timeView.updateSize()
    timeView.frame = CGRectOffset(timeView.frame, textView.frame.width - timeView.frame.width, 0)

    let exclusionPath = timeView.curvePathWithOrigin(timeView.center)
    textView.textContainer.exclusionPaths = [exclusionPath]
  }

  func createTextView() {
    // 1. Create the text storage that backs the editor
    let attrs = [NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
    let attrString = NSAttributedString(string: note.contents, attributes: attrs)
    textStorage = SyntaxHighlightTextStorage()
    textStorage.appendAttributedString(attrString)

    let newTextViewRect = view.bounds

    // 2. Create the layout manager
    let layoutManager = NSLayoutManager()

    // 3. Create a text container
    let containerSize = CGSize(width: newTextViewRect.width, height: CGFloat.max)
    let container = NSTextContainer(size: containerSize)
    container.widthTracksTextView = true
    layoutManager.addTextContainer(container)
    textStorage.addLayoutManager(layoutManager)

    // 4. Create a UITextView
    textView = UITextView(frame: newTextViewRect, textContainer: container)
    textView.delegate = self
    view.addSubview(textView)
  }

  func updateTextViewSizeForKeyboardHeight(keyboardHeight: CGFloat) {
    textView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - keyboardHeight)
  }

  func keyboardDidShow(notification: NSNotification) {
    if let rectValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
      let keyboardSize = rectValue.CGRectValue().size
      updateTextViewSizeForKeyboardHeight(keyboardSize.height)
    }
  }

  func keyboardDidHide(notification: NSNotification) {
    updateTextViewSizeForKeyboardHeight(0)
  }
}
