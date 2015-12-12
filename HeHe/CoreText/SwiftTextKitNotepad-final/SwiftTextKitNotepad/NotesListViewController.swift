//
//  NotesListViewController.swift
//  SwiftTextKitNotepad
//
//  Created by Gabriel Hauber on 18/07/2014.
//  Copyright (c) 2014 Gabriel Hauber. All rights reserved.
//

import UIKit

class NotesListViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "preferredContentSizeChanged:",
      name: UIContentSizeCategoryDidChangeNotification,
      object: nil)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    // whenever this view controller appears, reload the table. This allows it to reflect any changes
    // made whilst editing notes
    tableView.reloadData()
  }

  func preferredContentSizeChanged(notification: NSNotification) {
    tableView.reloadData()
  }

  // #pragma mark - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

    let note = notes[indexPath.row]
    let font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    let textColor = UIColor(red: 0.175, green: 0.458, blue: 0.831, alpha: 1)
    let attributes = [
      NSForegroundColorAttributeName : textColor,
      NSFontAttributeName : font,
      NSTextEffectAttributeName : NSTextEffectLetterpressStyle
    ]
    let attributedString = NSAttributedString(string: note.title, attributes: attributes)

    cell.textLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)

    cell.textLabel?.attributedText = attributedString
    
    return cell
  }

  let label: UILabel = {
    let temporaryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Int.max, height: Int.max))
    temporaryLabel.text = "test"
    return temporaryLabel
    }()

  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    label.sizeToFit()
    return label.frame.height * 1.7
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      notes.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
  }

  // #pragma mark - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if let editorVC = segue.destinationViewController as? NoteEditorViewController {

      if "CellSelected" == segue.identifier {
        if let path = tableView.indexPathForSelectedRow() {
          editorVC.note = notes[path.row]
        }
      } else if "AddNewNote" == segue.identifier {
        let note = Note(text: " ")
        editorVC.note = note
        notes.append(note)
      }
    }
  }

}
