import UIKit

let currentDate = NSDate()

let dateFormatter = NSDateFormatter()

// Setting the locale.
dateFormatter.locale = NSLocale.currentLocale()
//dateFormatter.locale = NSLocale(localeIdentifier: "el_GR")
//dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR")


//
// CONVERTING FROM NSDATE TO STRING AND FROM STRING TO NSDATE
//
// All the available date formatter styles.
// Full style.
dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
var convertedDate = dateFormatter.stringFromDate(currentDate)

// Long style.
dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
convertedDate = dateFormatter.stringFromDate(currentDate)

// Medium style.
dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
convertedDate = dateFormatter.stringFromDate(currentDate)

// Short style.
dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
convertedDate = dateFormatter.stringFromDate(currentDate)


// Setting custom date formats.
dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
convertedDate = dateFormatter.stringFromDate(currentDate)

dateFormatter.dateFormat = "HH:mm:ss"
convertedDate = dateFormatter.stringFromDate(currentDate)


// Converting from String to NSDate.
var dateAsString = "24-12-2015 23:59"
dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
var newDate = dateFormatter.dateFromString(dateAsString)


dateAsString = "Thu, 08 Oct 2015 09:22:33 GMT"
dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
newDate = dateFormatter.dateFromString(dateAsString)


//
// NSDATE AND NSDATECOMPONENTS
//
// Converting NSDate to NSDateComponents.
let calendar = NSCalendar.currentCalendar()
let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: currentDate)

print("day = \(dateComponents.day)", "month = \(dateComponents.month)", "year = \(dateComponents.year)", "week of year = \(dateComponents.weekOfYear)", "hour = \(dateComponents.hour)", "minute = \(dateComponents.minute)", "second = \(dateComponents.second)", "nanosecond = \(dateComponents.nanosecond)" , separator: ", ", terminator: "")


// Converting NSDateComponents to NSDate.
let components = NSDateComponents()
components.day = 5
components.month = 01
components.year = 2016
components.hour = 19
components.minute = 30
newDate = calendar.dateFromComponents(components)

components.timeZone = NSTimeZone(abbreviation: "GMT")
newDate = calendar.dateFromComponents(components)

components.timeZone = NSTimeZone(abbreviation: "CST")
newDate = calendar.dateFromComponents(components)

components.timeZone = NSTimeZone(abbreviation: "CET")
newDate = calendar.dateFromComponents(components)



//
// COMPARING DATES AND TIME.
//
dateFormatter.dateFormat = "MMM dd, yyyy zzz"
dateAsString = "Oct 08, 2015 GMT"
var date1 = dateFormatter.dateFromString(dateAsString)!

dateAsString = "Oct 10, 2015 GMT"
var date2 = dateFormatter.dateFromString(dateAsString)!


// Comparing dates - Method #1
print("Earlier date is: \(date1.earlierDate(date2))")
print("Later date is: \(date1.laterDate(date2))")


// Comparing dates - Method #2
if date1.compare(date2) == NSComparisonResult.OrderedDescending {
    print("Date1 is Later than Date2")
}
else if date1.compare(date2) == NSComparisonResult.OrderedAscending {
    print("Date1 is Earlier than Date2")
}
else if date1.compare(date2) == NSComparisonResult.OrderedSame {
    print("Same dates")
}


// Comparing dates - Method #3
if date1.timeIntervalSinceReferenceDate > date2.timeIntervalSinceReferenceDate {
    print("Date1 is Later than Date2")
}
else if date1.timeIntervalSinceReferenceDate <  date2.timeIntervalSinceReferenceDate {
    print("Date1 is Earlier than Date2")
}
else {
    print("Same dates")
}


// Comparing time.
dateFormatter.dateFormat = "HH:mm:ss zzz"
dateAsString = "14:28:16 GMT"
date1 = dateFormatter.dateFromString(dateAsString)!

dateAsString = "19:53:12 GMT"
date2 = dateFormatter.dateFromString(dateAsString)!

if date1.earlierDate(date2) == date1 {
    if date1.isEqualToDate(date2) {
        print("Same time")
    }
    else {
        print("\(date1) is earlier than \(date2)")
    }
}
else {
    print("\(date2) is earlier than \(date1)")
}



//
// CALCULATING FUTURE AND PAST DATES
//
// Dates in the future.
let monthsToAdd = 2
let daysToAdd = 5

// Method #1
var calculatedDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Month, value: monthsToAdd, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))
calculatedDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: daysToAdd, toDate: calculatedDate!, options: NSCalendarOptions.init(rawValue: 0))


// Method #2
let newDateComponents = NSDateComponents()
newDateComponents.month = monthsToAdd
newDateComponents.day = daysToAdd

calculatedDate = NSCalendar.currentCalendar().dateByAddingComponents(newDateComponents, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))


// Method #3
// Add 1.5 hours to the current time.
let hoursToAddInSeconds: NSTimeInterval = 90 * 60
calculatedDate = currentDate.dateByAddingTimeInterval(hoursToAddInSeconds)


// Find a date in the past.
let numberOfDays = -5684718
calculatedDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: numberOfDays, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))

dateFormatter.dateFormat = "EEEE, MMM dd, yyyy GGG"
dateAsString = dateFormatter.stringFromDate(calculatedDate!)



//
// CALCULATING DATE DIFFERENCE
//
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
dateAsString = "2015-10-08 14:25:37"
date1 = dateFormatter.dateFromString(dateAsString)!

dateAsString = "2018-03-05 08:14:19"
date2 = dateFormatter.dateFromString(dateAsString)!


// Method #1
var diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: date1, toDate: date2, options: NSCalendarOptions.init(rawValue: 0))

print("The difference between dates is: \(diffDateComponents.year) years, \(diffDateComponents.month) months, \(diffDateComponents.day) days, \(diffDateComponents.hour) hours, \(diffDateComponents.minute) minutes, \(diffDateComponents.second) seconds")



let dateComponentsFormatter = NSDateComponentsFormatter()
dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Full

// Method #2
let interval = date2.timeIntervalSinceDate(date1)
dateComponentsFormatter.stringFromTimeInterval(interval)


// Method #3
dateComponentsFormatter.allowedUnits = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]
let autoFormattedDifference = dateComponentsFormatter.stringFromDate(date1, toDate: date2)
