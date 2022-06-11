--src: https://www.sqlbi.com/articles/rolling-12-months-average-in-dax/
--rolling 12 month avg

(R12M) =
VAR NumOfMonths = 12
VAR LastCurrentDate = MAX ( 'Date'[Date] )
VAR Period = DATESINPERIOD ( 'Date'[Date], LastCurrentDate, - NumOfMonths, MONTH )
VAR Result =
    CALCULATE (
        AVERAGEX (
            VALUES ( 'Date'[Year/Month] ),
            [Measure]
        ),
        Period
    )
VAR FirstDateInPeriod = MINX ( Period, 'Date'[Date] )
VAR LastDateWithSales = MAX ( Sales[Order Date] )
RETURN
    IF ( FirstDateInPeriod <= LastDateWithSales, Result )