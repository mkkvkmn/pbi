Acc. Sales ( PY) = 
VAR YearsBack = 1 
VAR SelectedYears = 
SELECTCOLUMNS(
	    ADDCOLUMNS(
	        VALUES('Date'[Year ISO]),
	        "Back",IF( NOT(ISBLANK([Year ISO])),YearsBack)
	    ),
	    "EditedYear",[Year ISO] - [Back]
	)
VAR SelectedWeeks = VALUES('Date'[Week])
VAR ResultWeek = 
CALCULATE(
    [Acc. Sales],
    ALL('Date'), //remove date context
    TREATAS(SelectedYears,'Date'[Year ISO]),//replace years with selected years
    TREATAS(SelectedWeeks,'Date'[Week]) //keep selected weeks
)
Return 
    ResultWeek
