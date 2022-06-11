<!-- Running Total -->
VAR todays_date = IF( MAX('Date'[Date]) < [Date Data Updated], MAX('Date'[Date]), [Date Data Updated] )
VAR result = 
    CALCULATE(
        [Measure],
        'Date'[Date] <= todays_date,
        ALL('Date'[Date])
    )
VAR show = NOT(ISBLANK([Measure]))    
RETURN
    IF(show,result)