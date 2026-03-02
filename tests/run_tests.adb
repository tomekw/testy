with Testy.Runners;
with Testy.Reporters.Text;

with Testy_Test;

procedure Run_Tests is
   use Testy;

   Test_Runner : Runners.Runner := Runners.Create;
   Test_Reporter : Reporters.Text.Text_Reporter;
begin
   Test_Runner.Add ("Two plus two is four", Testy_Test.Test_Two_Plus_Two'Access);
   Test_Runner.Add ("Two plus one is three", Testy_Test.Test_Two_Plus_One'Access);
   Test_Runner.Add ("Divide by zero", Testy_Test.Test_Divide_By_Zero'Access);
   Test_Runner.Add ("Any exception", Testy_Test.Test_E_No_E'Access);
   Test_Runner.Add ("Concrete exception", Testy_Test.Test_Program_Error'Access);
   Test_Runner.Add ("Concrete exception with message", Testy_Test.Test_Constraint_Error_With_Message'Access);

   Test_Runner.Run (Test_Reporter);
end Run_Tests;
