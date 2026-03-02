package body Testy.Tests is
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

   procedure Expect (Test : in out Test_Context; Expected : Boolean; Message : String) is
   begin
      if Expected then
         Test.Passed_Count := Test.Passed_Count + 1;
      else
         Test.Failed_Count := Test.Failed_Count + 1;
         Test.Failed_Expectations.Append (String_Holders.To_Holder (Message));
      end if;
   end Expect;

   procedure Expect_Raises (Test : in out Test_Context;
                            Proc : Raising_Procedure)
   is
      use Exceptions;

      function No_Exception_Message return String is
      begin
         return "expected an exception to be raised, but none was raised";
      end No_Exception_Message;
   begin
      Proc.all;

      Test.Failed_Count := Test.Failed_Count + 1;
      Test.Failed_Expectations.Append (String_Holders.To_Holder (No_Exception_Message));
   exception
      when others =>
         Test.Passed_Count := Test.Passed_Count + 1;
   end Expect_Raises;

   procedure Expect_Raises (Test : in out Test_Context;
                            Proc : Raising_Procedure;
                            Expected : Exceptions.Exception_Id)
   is
      use Exceptions;

      function No_Exception_Message return String is
      begin
         return "expected " & Exception_Name (Expected) &
                " to be raised, but none was raised";
      end No_Exception_Message;

      function Wrong_Exception_Message (E : Exception_Occurrence) return String
      is
      begin
         return "expected " & Exception_Name (Expected) &
                " to be raised, but " & Exception_Name (E) & " was raised";
      end Wrong_Exception_Message;
   begin
      Proc.all;

      Test.Failed_Count := Test.Failed_Count + 1;
      Test.Failed_Expectations.Append (String_Holders.To_Holder (No_Exception_Message));
   exception
      when E : others =>
         if Exceptions.Exception_Identity (E) = Expected then
            Test.Passed_Count := Test.Passed_Count + 1;
         else
            Test.Failed_Count := Test.Failed_Count + 1;
            Test.Failed_Expectations.Append (String_Holders.To_Holder (Wrong_Exception_Message (E)));
         end if;
   end Expect_Raises;

   procedure Expect_Raises (Test : in out Test_Context;
                            Proc : Raising_Procedure;
                            Expected : Exceptions.Exception_Id;
                            Expected_Message : String)
   is
      use Exceptions;

      function No_Exception_Message return String is
      begin
         return "expected " & Exception_Name (Expected) &
                " with '" & Expected_Message & "'" &
                " to be raised, but none was raised";
      end No_Exception_Message;

      function Wrong_Exception_Message (E : Exception_Occurrence) return String
      is
      begin
         return "expected " & Exception_Name (Expected) &
                " with '" & Expected_Message & "'" &
                " to be raised, but " & Exception_Name (E) &
                " with '" & Exception_Message (E) & "' was raised";
      end Wrong_Exception_Message;
   begin
      Proc.all;

      Test.Failed_Count := Test.Failed_Count + 1;
      Test.Failed_Expectations.Append (String_Holders.To_Holder (No_Exception_Message));
   exception
      when E : others =>
         if Exceptions.Exception_Identity (E) = Expected and then
            Exceptions.Exception_Message (E) = Expected_Message
         then
            Test.Passed_Count := Test.Passed_Count + 1;
         else
            Test.Failed_Count := Test.Failed_Count + 1;
            Test.Failed_Expectations.Append (String_Holders.To_Holder (Wrong_Exception_Message (E)));
         end if;
   end Expect_Raises;
end Testy.Tests;
