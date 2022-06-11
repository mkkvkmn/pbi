/*
Purpose: Create a list of dates between two dates
Author: mikko@feellike.io
Notes: Enjoy it!
*/
    
(StartDate as date, EndDate as date) =>
let
    // For testing
    // StartDate = Date.From(DateTimeZone.FixedLocalNow()),
    // EndDate = Date.AddYears(Date.EndOfYear(StartDate),0),

    // Capture parameters as numbers
    Start = Number.From(StartDate),
    End = Number.From(EndDate),

    // Create a List
    Dates = {Start..End}
in
    Dates