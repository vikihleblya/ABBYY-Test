import Foundation
import SwiftDate

extension Date{
    func convertToLocalDate() -> String{
        let currentRegion = Region(calendar: Calendars.gregorian, zone: TimeZone.current, locale: Locale.current)
        SwiftDate.defaultRegion = currentRegion
        return self.toFormat("MMM d, yyyy 'at' hh:mm a", locale: Locale.current)
    }
}
