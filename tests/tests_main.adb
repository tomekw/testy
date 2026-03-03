with Testy.Runners;
with Testy.Reporters.Text;

with Foo_Tests;

procedure Tests_Main is
   use Testy;

   Test_Runner : Runners.Runner := Runners.Create;
   Test_Reporter : Reporters.Text.Text_Reporter;
begin
   Test_Runner.Add ("Foo starts with F", Foo_Tests.Foo_Starts_With_F'Access);
   Test_Runner.Add ("Foo raises", Foo_Tests.Foo_Raises'Access);

   Test_Runner.Run (Test_Reporter);
end Tests_Main;
