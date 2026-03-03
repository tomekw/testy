package body Foo_Tests is
   function First_Letter (Foo : String) return Character is
   begin
      return Foo (Foo'First);
   end First_Letter;

   procedure Foo_Starts_With_F (T : in out Test_Context) is
      Result : constant Character := First_Letter ("Foo");
   begin
      T.Expect (Result = 'F', "expected 'F', got '" & Result & "'");
   end Foo_Starts_With_F;

   procedure Foo is
   begin
      raise Constraint_Error with "Foo raised";
   end Foo;

   procedure Foo_Raises (T : in out Test_Context) is
   begin
      T.Expect_Raises (Foo'Access);
      T.Expect_Raises (Foo'Access, Constraint_Error'Identity);
      T.Expect_Raises (Foo'Access, Constraint_Error'Identity, "Foo raised");
   end Foo_Raises;
end Foo_Tests;
