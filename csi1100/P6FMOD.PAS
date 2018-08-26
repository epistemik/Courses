program P6f (Input, Output);
{Program to perform a variety of computations for
     geometric figures; this version illustrates overall
     program control using repeat.}
{uses Crt;}
var
     FigureOption,
     CalculationOption : Char;          {Input Variables}
{**********************************************************************}
     procedure GetValidFigureOption (var FigureOption : Char);
     {Procedure to display the menu and get user's choice}
     const
          FigureOptionPrompt = 'Enter desired option ';
          VerificationPrompt = 'Are you sure you wish to quit ? (Y/N)';
     var
          ValidOption : Boolean;          {Control Variable}
          Verify : Char;
     {------------------------------------------------------------------}
          procedure DisplayMenu;
          {Procedure to display the menu}
          const
               MenuLine1 = 'Main Menu';
               MenuLine2 = 'Geometric Figure    Code';
               MenuLine3 = 'Square               S';
               MenuLine4 = 'Rectangle            R';
               MenuLine5 = 'Triangle             T';
               MenuLine6 = 'Quit                 Q';
          begin     {DisplayMenu}
               {Clrscr;}
               Writeln (MenuLine1);
               Writeln;
               Writeln (MenuLine2);
               Writeln (MenuLine3);
               Writeln (MenuLine4);
               Writeln (MenuLine5);
               Writeln (Menuline6);
               Writeln;
          end;       {DisplayMenu}
     {------------------------------------------------------------------}
          procedure ValidateFigureOption (Option : Char;
                                     var ValidOption : Boolean);
          {Procedure to test validity of figure option entered
               by user}
          begin   {ValidateFigureOption}
               if (Option = 'R') or (Option = 'S') or
                  (Option = 'T') or (Option = 'Q') then
                        ValidOption := True
               else
                   begin
                        ValidOption := False;
                        Writeln ('Invalid figure option : ',Option)
                   end   {if}
          end;    {ValidateFigureOption}
     {------------------------------------------------------------------}
     begin     {GetValidFigureOption}
          DisplayMenu;
          repeat
                Write (FigureOptionPrompt);
                Readln (FigureOption);
                FigureOption := UpCase (FigureOption);
                ValidateFigureOption(FigureOption,ValidOption);
                if FigureOption = 'Q' then
                   begin
                        Write (VerificationPrompt);
                        Readln (Verify);
                        if UpCase (Verify) <> 'Y' then
                           ValidOption := False
                   end  {if}
          until ValidOption
     end;   {GetValidFigureOption}
{----------------------------------------------------------------------}
     procedure GetValidComputationOption
                  (var ComputationOption : Char);
     {Procedure to get valid computation option}
     begin  {GetValidComputationOption}
          Writeln ('Computation options not implemented')
     end;   {GetValidCompuationOption}
{----------------------------------------------------------------------}
     procedure SquareComputations (ComputationOption : Char);
     {Procedure to perform computations for a square}
     begin  {SquareComputations}
          Writeln ('Square computations not implemented')
     end;   {SquareComputations}
{----------------------------------------------------------------------}
     procedure RectangleComputations (ComputationOption : Char);
     {Procedure to perform computations for rectangle}
     begin  {RectangleComputations}
          Writeln ('Rectangle computations not implemented')
     end;   {RectangleComputations}
{----------------------------------------------------------------------}
     procedure TriangleComputations (ComputationOption : Char);
     {Procedure to perform computations for Triangle}
     begin  {TriangleComputations}
          Writeln ('Triangle computations not implemented')
     end;    {TriangleComputations}
{----------------------------------------------------------------------}
     procedure Wait;
     begin  {Wait}
          Writeln ('Press <Enter> to continue ');
          Readln
     end;   {Wait}
{**********************************************************************}
begin   {Main Program}

{1.0 Process user requests until FigureOption = 'Q'}

     repeat
           GetValidFigureOption (FigureOption);
           if FigureOption <> 'Q' then
              begin
                   GetValidComputationOption (CalculationOption);
                   case FigureOption of
                        'S' : SquareComputations (CalculationOption);
                        'R' : RectangleComputations (CalculationOption);
                        'T' : TriangleComputations (CalculationOption)
                   end;   {case}
                   Wait;
            end   {if}
     until FigureOption = 'Q'

end.     {Main Program}
