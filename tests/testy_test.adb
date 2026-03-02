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
      --  T.Expect (Result = 3, "expected 3, got:" & Result'Image);
   end Test_Divide_By_Zero;
end Testy_Test;
