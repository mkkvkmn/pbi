<!-- Convert list to table -->
VAR int_path_len = PATHLENGTH(Fact[Field]) --Lasketaan, montako riviä taulukkoon tulee
VAR table =  --Muuttaa |:lla erotetun sanalistan taulukoksi
    SELECTCOLUMNS(
        ADDCOLUMNS(
            GENERATESERIES(1,int_path_len) 
            ,"SomeValues",PATHITEM(Fact[Field],''[Value],TEXT)
        )
        ,"SomeValues", [SomeValues]
    )