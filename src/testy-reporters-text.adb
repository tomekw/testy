with Ada.Text_IO;

package body Testy.Reporters.Text is
   overriding
   procedure Start_Suite (Self : in out Text_Reporter; Tests_Count : Natural) is
   begin
      Text_IO.New_Line;
      Text_IO.Put_Line ("Running" & Tests_Count'Image & " tests...");
      Text_IO.New_Line;
   end Start_Suite;

   overriding
   procedure End_Suite (Self : in out Text_Reporter;
                        Passed_Count : Natural;
                        Failed_Count : Natural;
                        Error_Count : Natural)
   is
      Total_Count : constant Natural := Passed_Count + Failed_Count + Error_Count;
   begin
      Text_IO.New_Line;
      Text_IO.Put_Line ("Results:" &
                        Passed_Count'Image & " passed," &
                        Failed_Count'Image & " failed," &
                        Error_Count'Image & " errors," &
                        Total_Count'Image & " total.");
      Text_IO.New_Line;
   end End_Suite;

   overriding
   procedure Start_Test (Self : in out Text_Reporter; Name : String) is
   begin
      null;
   end Start_Test;

   overriding
   procedure End_Test (Self : in out Text_Reporter; Name : String; Ctx : Tests.Test_Context) is
   begin
      if Ctx.Failed_Count = 0 then
         Text_IO.Put_Line ("[PASS]: " & Name);
      else
         Text_IO.Put_Line ("[FAIL]: " & Name);

         for F of Ctx.Failed_Expectations loop
            Text_IO.Put_Line ("  - Expectation failed: " & F.Element);
         end loop;
      end if;
   end End_Test;

   overriding
   procedure End_Test (Self : in out Text_Reporter; Name : String; E : Exceptions.Exception_Occurrence) is
      use Exceptions;
   begin
      Text_IO.Put_Line ("[ERROR]: " & Name);
      if Exception_Message (E) = "" then
         Text_IO.Put_Line ("  - raised " & Exception_Name (E));
      else
         Text_IO.Put_Line ("  - raised " & Exception_Name (E) & ": " & Exception_Message (E));
      end if;
   end End_Test;
end Testy.Reporters.Text;
