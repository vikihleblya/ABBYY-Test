import Foundation
import SwiftDate

extension NSDate{
    func convertToLocalDate() -> String{
        let date = self as Date
        let currentRegion = Region(calendar: Calendars.gregorian, zone: TimeZone.current, locale: Locale.current)
        SwiftDate.defaultRegion = currentRegion
        return date.toFormat("MMM d, yyyy 'at' hh:mm a", locale: Locale.current)
    }
}
