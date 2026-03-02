package body Testy_Test is
   function Add (A, B : Integer) return Integer is
   begin
      return A + B;
   end Add;

   procedure Test_Two_Plus_Two (T : in out Test_Context) is
   begin
      T.Expect (Add (2, 2) = 4, "expected 4");
   end Test_Two_Plus_Two;

   procedure Test_Two_Plus_One (T : in out Test_Context) is
      Result : constant Integer := Add (2, 2);
   begin
      T.Expect (Result = 3, "expected 3, got:" & Result'Image);
   end Test_Two_Plus_One;

   procedure Test_Divide_By_Zero (T : in out Test_Context) is
   begin
      raise Constraint_Error with "divide by 0";
   end Test_Divide_By_Zero;

   procedure E_No_E is
   begin
      null;
   end E_No_E;

   procedure Test_E_No_E (T : in out Test_Context) is
   begin
      T.Expect_Raises (E_No_E'Access);
   end Test_E_No_E;

   procedure E_Wrong_E is
   begin
      raise Constraint_Error with "foo";
   end E_Wrong_E;

   procedure Test_Program_Error (T : in out Test_Context) is
   begin
      T.Expect_Raises (E_Wrong_E'Access, Program_Error'Identity);
   end Test_Program_Error;

   procedure Test_Constraint_Error_With_Message (T : in out Test_Context) is
   begin
      T.Expect_Raises (E_Wrong_E'Access, Constraint_Error'Identity, "bar");
   end Test_Constraint_Error_With_Message;
end Testy_Test;
