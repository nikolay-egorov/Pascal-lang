begin
    x := 12321.1e1;
    a := 33E0;
    a -= a;
    I := I+2;  
    Char(c) := Bool(2 + 3);
    
    while i<=100 do  
      begin
      WriteLn ('I =',i);
      I := I+2;  
      end;  
      
    X := X/2;  
    with data, v do begin
        s1 := 5;
    end;
    
    atRes := @(3 * 5);
    
    // I'm comment hohoho
    
    
    with TheCustomer do  
      begin  
      Name := 'Michael';  
      Flight := 'PS901';  
      end;
    
        
    for i in Enumerable do
        pass;
    
    for j in [1..13] do
        pass;
    
    begin  
        for i := 1 to 2 do ;  
    end;  
    
    repeat  
         X := X**2  
    until x<10e-3;
    
    for I:=1 to 20 do  
        A[I] := I;  
    I := PInteger(Unaligned(@A[13]))^;  
    
    
    begin  
        P := @MyProc;  
    end;
    
    
    if foo <> 14 then
    begin
        foo := 47e1;
        bar := 36 < 2;
    end
    else
    begin
        foo := 125
    end;
    
    WriteLn('Pascal is an easy language !');  
    Doit();
    
    label  
        jumpto;  
    
    
    Jumpto :  
      Statement;  

    goto jumpto;  
    
    
    {  
       My beautiful function returns an interesting result,  
       but only if the argument A is less than B.  
    }  
    
    
    { Comment 1 (* comment 2 *) }  
    (* Comment 1 { comment 2 } *)  
    { comment 1 // Comment 2 }  
    (* comment 1 // Comment 2 *)  
    // comment 1 (* comment 2 *)  
    // comment 1 { comment 2 }
    
    (* This is an old style comment *)  
    {  This is a Turbo Pascal comment }  
    // This is a Delphi comment. All is ignored till the end of the line.
    
    Integer('A');  
    Char(4875);  
    Word(@Buffer);
    

    W:=[mon,tue] + [wed,thu,fri]; // equals [mon,tue,wed,thu,fri]  
    PrintDays(W);  
    W:=[mon,tue,wed] - [wed];     // equals [mon,tue]  
    PrintDays(W);  
    W:=[mon,tue,wed] -[wed,thu];     // also equals [mon,tue]  
    PrintDays(W);  
    W:=[mon,tue,wed]*[wed,thu,fri]; // equals [wed]  
    PrintDays(W);
    W:=[mon,tue,wed]><[wed,thu,fri]; // equals [mon,tue,thu,fri]  
    PrintDays(W);  
    if [mon,tue] <= WorkWeek then  
        Writeln('Must work on monday and tuesday');  
    if Weekend >= [sun] then  
        Writeln('Can rest on sunday');          

    
    repeat
      doHomeWork(1, 1, foo)
    until i <= 10  
end 