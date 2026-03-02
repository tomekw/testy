package body Testy.Tests is
   procedure Expect (Test : in out Test_Context; Expected : Boolean; Message : String) is
   begin
      if Expected then
         Test.Passed_Count := Test.Passed_Count + 1;
      else
         Test.Failed_Count := Test.Failed_Count + 1;
         Test.Failed_Expectations.Append (String_Holders.To_Holder (Message));
      end if;
   end Expect;

   function Passed_Count (Self : Test_Context) return Natural is
   begin
      return Self.Passed_Count;
   end Passed_Count;

   function Failed_Count (Self : Test_Context) return Natural is
   begin
      return Self.Failed_Count;
   end Failed_Count;

   function Failed_Expectations (Self : Test_Context) return Failure_Vectors.Vector is
   begin
      return Self.Failed_Expectations;
   end Failed_Expectations;
end Testy.Tests;
