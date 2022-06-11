--same day previous year

(sd py) = 
VAR current_date = 
COALESCE(
    CALCULATE(
        MAX(Fact[Date]),
        ALL(Fact)
    ),
    TODAY()
)
VAR compare_date = DATE(YEAR(current_date)-1,MONTH(current_date),DAY(current_date))
VAR compare_period = 
FILTER(
    DATEADD(VALUES(Date[Date]),-1,YEAR),
    Date[Date] <= compare_date
)
VAR result =
CALCULATE(
    [Measure (py)],
    DATESYTD(compare_period)
)
Return
    result