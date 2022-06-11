/*
Modified from: 
https://eriksvensen.wordpress.com/2019/11/26/powerquery-calculate-the-iso-date-from-year-and-a-week-number/
*/

(Year as number, Week as number) as date =>
let
    //test
    // TheYear = 2018,
    // TheWeek = 1,
    //
    offsetToISO = Date.AddDays(#date(Year,1,1),-4),
    dayOfWeek = Date.DayOfWeek(offsetToISO),
    offset = -dayOfWeek + (Week * 7),
    isoWeekDate = Date.EndOfWeek(Date.AddDays(offsetToISO, offset),Day.Monday)
in
    isoWeekDate