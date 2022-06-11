/*
Purpose: Create a date dimension for Power BI
Author: mikko@feellike.io
Notes: Enjoy it!
*/

(#"Lang EN / FI" as text,#"Start Year" as number, #"How many years to future?" as number, #"Use Iso Week true/false" as logical)=>
let
    // For testing purposes
    // #"Lang EN / FI" = "EN",
    // #"Start Year" = 2018,
    // #"How many years to future?" = 1,
    // #"Use Iso Week true/false" = true,

    //Capture the parameters
    Language = Text.Lower(#"Lang EN / FI"),
    ToFuture = #"How many years to future?",
    StartDate = #date(#"Start Year",1 , 1),
    UseIsoWeek = #"Use Iso Week true/false",

    //Abbreviations
    _qtr = if Language = "fi" then "Q" else "Q",
    _month = if Language = "fi" then "KK" else "M",
    _week = if Language = "fi" then "VKO" else "W",
    _lang = if Language = "fi" then "fi-FI" else "en-US",
    _last = if Language = "fi" then "ed." else "Last",
    _months = if Language = "fi" then "kk" else "Months",
    _days = if Language = "fi" then "pv" else "Days",

    //Current Date
    TodaysDate = Date.From(DateTimeZone.FixedLocalNow()),
    EndDate = Date.AddYears(Date.EndOfYear(TodaysDate),ToFuture),

    // Language support
    Substitutions = [
            Before = "Aikaisemmin",
            #"Before last" = "Toissa",
            Previous = "Edellinen",
            Current = "Kuluva",
            Next = "Seuraava",
            After = "Jälkeen",
            Other = "Muu"
    ],

    // Get the number of dates that will be required for the table
    GetDateCount = Duration.Days(EndDate - StartDate)+1,

    // Take the count of dates and turn it into a list of dates
    GetDateList = List.Dates(StartDate, GetDateCount, 
    #duration(1,0,0,0)),

    // Convert the list into a table
    DateListToTable = Table.FromList(GetDateList, 
    Splitter.SplitByNothing(), {"Date"}, null, ExtraValues.Error),

    // Create number columns
    YearNumber = Table.AddColumn(DateListToTable, "Year", each Date.Year([Date])),
    InsertISOYear = Table.AddColumn(YearNumber, "Year ISO", each Date.Year(Date.AddDays([Date],3-Date.DayOfWeek([Date],1))), type number),
    QuarterNumber = Table.AddColumn(InsertISOYear , "Quarter", each Date.QuarterOfYear([Date])),
    MonthNumber = Table.AddColumn(QuarterNumber, "Month", each Date.Month([Date])),
    UsWeekNumber = Table.AddColumn(MonthNumber , "US Week Number", each Date.WeekOfYear([Date])),
    IsoWeekNumber = Table.AddColumn(UsWeekNumber, "Iso Week Number", each 
        if Number.RoundDown((Date.DayOfYear([Date])-(Date.DayOfWeek([Date], Day.Monday)+1)+10)/7)=0
        then Number.RoundDown((Date.DayOfYear(#date(Date.Year([Date])-1,12,31))-(Date.DayOfWeek(#date(Date.Year([Date])-1,12,31), Day.Monday)+1)+10)/7) 
        else if (Number.RoundDown((Date.DayOfYear([Date])-(Date.DayOfWeek([Date], Day.Monday)+1)+10)/7)=53 and (Date.DayOfWeek(#date(Date.Year([Date]),12,31), Day.Monday)+1<4)) then 1
        else  Number.RoundDown((Date.DayOfYear([Date])-(Date.DayOfWeek([Date], Day.Monday)+1)+10)/7)
    ),

    // Create name columns
    MonthName = Table.AddColumn(IsoWeekNumber , "Month Name", each Date.MonthName([Date],_lang)),
    DayOfWeekName = Table.AddColumn(MonthName , "Day Name", each Date.DayOfWeekName([Date],_lang)),
    DayOfWeekOrder = Table.AddColumn(DayOfWeekName , "Day-Name-Order", each Date.DayOfWeek([Date],Day.Monday)),
    
    // Select used week type Use Iso Week / Regular
    Week = Table.AddColumn(DayOfWeekOrder, "Week", each 
        if UseIsoWeek = false then [US Week Number] 
        else [Iso Week Number]
    ),
    YearForWeek = Table.AddColumn(Week, "YearForWeek", each 
        if UseIsoWeek = false then [Year] 
        else [Year ISO]
    ),

    // Add yearly columns
    AddYearQuarter = Table.AddColumn(YearForWeek, "Year / Quarter", each Number.ToText([Year]) & "/" & _qtr & Number.ToText([Quarter])),
    AddYearMonth = Table.AddColumn(AddYearQuarter, "Year / Month", each Number.ToText([Year]) & "/" & _month & Date.ToText([Date], "MM")),
    AddYearWeek = Table.AddColumn(AddYearMonth, "Year / Week", each Number.ToText([YearForWeek]) & "/"& _week & Number.ToText([Week],"00")),
    CreateSequentialYearWeekNo = Table.NestedJoin( //join table by iteration of self
        AddYearWeek, // table from previous step
        {"Year / Week"}, // join by column
        Table.AddIndexColumn( // table where week number has index
            Table.Distinct( // get only distinct year weeks
                Table.SelectColumns(AddYearWeek,{"Year / Week"}) // select only column year week
            ), 
        "YearWeek-Order", 0, 1, Int64.Type),
        {"Year / Week"}, // join by column 
        "Totals", 
        JoinKind.LeftOuter
    ),
    YearWeekOrder = Table.ExpandTableColumn(CreateSequentialYearWeekNo, "Totals", {"YearWeek-Order"}, {"YearWeek-Order"}),
    YearWeekDay = Table.AddColumn(YearWeekOrder, "Year / Week / Day", each Number.ToText([YearForWeek]) & "/" & Number.ToText([Week]) & "/" & Text.Range(Date.DayOfWeekName([Date], _lang),0,2) & " ("& Number.ToText(Date.Day([Date])) & "." & Date.ToText([Date], "MM") &")"),
    
    // Add Last N Days
    LastNDays = Table.AddColumn(YearWeekDay, "Last N Days", each
        if [Date]>Date.From(Date.AddDays(DateTime.LocalNow(),-7)) and [Date]<=Date.From(DateTime.LocalNow()) then "1. " & _last & " 7 " & _days else
        if [Date]>Date.From(Date.AddDays(DateTime.LocalNow(),-30)) and [Date]<=Date.From(DateTime.LocalNow()) then "2. " & _last & " 8-30 " & _days else
        if [Date]>Date.From(Date.AddDays(DateTime.LocalNow(),-90)) and [Date]<=Date.From(DateTime.LocalNow()) then "3. " & _last & " 31-90 " & _days else
        if [Date]>Date.From(Date.AddDays(DateTime.LocalNow(),-365)) and [Date]<=Date.From(DateTime.LocalNow()) then "4. " & _last & " 91-365 " & _days else
        null
    ),

    // Add Last N Months
    LastNMonths = Table.AddColumn(LastNDays, "Last N Months", each
        if [Date]>Date.From(Date.AddMonths(DateTime.LocalNow(),-3)) and [Date]<=Date.From(DateTime.LocalNow()) then "1. " & _last & " 3 " & _months else
        if [Date]>Date.From(Date.AddMonths(DateTime.LocalNow(),-12)) and [Date]<=Date.From(DateTime.LocalNow()) then "2. " & _last & " 4-12 " & _months else
        if [Date]>Date.From(Date.AddMonths(DateTime.LocalNow(),-24)) and [Date]<=Date.From(DateTime.LocalNow()) then "3. " & _last & " 13-24 " & _months else
        null
    ),

    // Add dynamic periods for years
    PeriodYear = Table.AddColumn(LastNMonths, "Period-Year", each
        if Date.Year( Date.From( Date.AddYears (DateTimeZone.FixedLocalNow(),-2) ) ) >= Date.Year([Date]) then "Before" else
        if Date.Year( Date.From( Date.AddYears (DateTimeZone.FixedLocalNow(),-1) ) ) = Date.Year([Date]) then "Previous" else
        if Date.Year( Date.From(DateTimeZone.FixedLocalNow()) ) = Date.Year([Date]) then "Current" else
        if Date.Year( Date.AddYears(Date.From(DateTimeZone.FixedLocalNow()),1) ) = Date.Year([Date]) then "Next" 
        else "After"
    ),
    PeriodYearOrder = Table.AddColumn(PeriodYear , "PeriodYear-Order", each
        if Date.Year( Date.From( Date.AddYears (DateTimeZone.FixedLocalNow(),-2) ) ) >= Date.Year([Date]) then 1 else
        if Date.Year( Date.From( Date.AddYears (DateTimeZone.FixedLocalNow(),-1) ) ) = Date.Year([Date]) then 3 else
        if Date.Year( Date.From(DateTimeZone.FixedLocalNow()) ) = Date.Year([Date]) then 4 else
        if Date.Year( Date.AddYears(Date.From(DateTimeZone.FixedLocalNow()),1) ) = Date.Year([Date]) then 5
        else 6
       ),

    // Add dynamic periods for months
    PeriodMonth = Table.AddColumn(PeriodYearOrder, "Period-Month", each
        if Date.AddMonths(Date.StartOfMonth(TodaysDate),-1) > [Date] then "Before" else 
        if Date.IsInPreviousMonth([Date]) then "Previous" else 
        if Date.IsInCurrentMonth([Date]) then "Current" else
        if Date.IsInNextMonth([Date]) then "Next" 
        else "After"
    ),
    PeriodMonthOrder = Table.AddColumn(PeriodMonth,"Period-Month-Order", each 
        if Date.AddMonths(Date.StartOfMonth(TodaysDate),-1) > [Date] then 1 else 
        if Date.IsInPreviousMonth([Date]) then 2 else 
        if Date.IsInCurrentMonth([Date]) then 3 else
        if Date.IsInNextMonth([Date]) then 4 
        else 5
    ),

    // Add dynamic periods for weeks
    PeriodWeek = Table.AddColumn(PeriodMonthOrder, "Period-Week", each
        if Date.StartOfWeek(TodaysDate) > [Date] then "Before" else
        if Date.IsInPreviousNWeeks([Date],1) then "Previous" else
        if Date.IsInCurrentWeek([Date]) then "Current" else
        if Date.IsInNextWeek([Date]) then "Next" 
        else "After"
       ),
    PeriodWeekOrder = Table.AddColumn(PeriodWeek, "Period-Week-Order", each 
        if Date.StartOfWeek(TodaysDate) > [Date] then 1 else 
        if Date.IsInPreviousNWeeks([Date],1) then 2 else
        if Date.IsInCurrentWeek([Date]) then 3 else
        if Date.IsInNextWeek([Date]) then 4 
        else 5
       ),

    // Add dynamic periods for days after current date
    AfterToday = Table.AddColumn(PeriodWeekOrder,"TodayOrAfter", each 
        if [Date] >= TodaysDate then true else false
    ),

    // Week was selected before this, remove extra columns
    RemovedExtraColumns = Table.RemoveColumns(AfterToday,{"US Week Number", "Iso Week Number", "YearForWeek"}),

    // Change correct data types
    CorrectTypes = Table.TransformColumnTypes(RemovedExtraColumns,{
        {"Date", type date}, {"Year", Int64.Type}, {"Quarter", Int64.Type}, {"Month", Int64.Type}, 
        {"Week", Int64.Type}, {"Year ISO", Int64.Type}, {"YearWeek-Order", Int64.Type}, 
        {"PeriodYear-Order", Int64.Type}, {"Period-Month-Order", Int64.Type}, 
        {"Period-Week-Order", Int64.Type}, {"TodayOrAfter", type logical}, {"Year / Quarter", type text}, 
        {"Year / Month", type text}, {"Year / Week", type text}, {"Year / Week / Day", type text}, 
        {"Last N Days", type text}, {"Last N Months", type text}, {"Period-Year", type text}, 
        {"Period-Month", type text}, {"Period-Week", type text}, {"Month Name", type text}, {"Day Name", type text}
    }),

    HeadersLang = Table.RenameColumns(CorrectTypes,{
        {"Date", "Pvm"}, {"Year", "Vuosi"}, {"Quarter", "Kvartaali"}, {"Month", "Kuukausi"}, 
        {"Week", "Viikko"}, {"Year / Quarter", "Vuosi / Kvartaali"}, {"Year / Month", "Vuosi / Kuukausi"}, 
        {"Year / Week", "Vuosi / Viikko"}, {"YearWeek-Order", "vuosi-viikko-järj"}, 
        {"Year / Week / Day", "Vuosi / Vko / Pv"}, {"YearWeekDay-Order", "vuosi-vko-pv-järj"}, 
        {"Last N Days", "Edelliset N päivää"}, {"Last N Months", "Edelliset N Kuukautta"}, 
        {"Period-Year", "Jakso-Vuosi"}, {"PeriodYear-Order", "jakso-vuosi-järj"}, {"Period-Month", "Jakso-Kuukausi"},
        {"Period-Month-Order", "jakso-kuukausi-järj"}, {"Period-Week", "Jakso-Viikko"}, 
        {"Period-Week-Order", "jakso-viikko-järj"}, {"TodayOrAfter", "NytTaiMyöhemmin"}, {"Year ISO", "Vuosi (ISO)"},
        {"Month Name", "Kuukauden Nimi"}, {"Day Name", "Päivän Nimi"}
        }),
    
    ContentLang = Table.TransformColumns(HeadersLang, {
        {"Jakso-Vuosi", each Record.FieldOrDefault(Substitutions, _, _)},
        {"Jakso-Viikko", each Record.FieldOrDefault(Substitutions, _, _)},
        {"Jakso-Kuukausi", each Record.FieldOrDefault(Substitutions, _, _)}
    }),
    SelectLang = if Language = "fi" then ContentLang else CorrectTypes 
in
    SelectLang