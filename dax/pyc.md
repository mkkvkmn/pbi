--cumulative previous year

(cpy) = 
CALCULATE(
    [Measure],
    DATESYTD(
        DATEADD(Date[Date],-1,YEAR)
    )
)