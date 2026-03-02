with Ada.Containers.Vectors;
with Ada.Exceptions;

package Testy.Tests is
   type Test_Context is tagged private;

   type Test_Procedure is access procedure (Test : in out Test_Context);
   type Raising_Procedure is access procedure;

   package Failure_Vectors is new Containers.Vectors
     (Index_Type => Positive,
      Element_Type => String_Holders.Holder,
      "=" => String_Holders."=");

   function Passed_Count (Self : Test_Context) return Natural;

   function Failed_Count (Self : Test_Context) return Natural;

   function Failed_Expectations (Self : Test_Context) return Failure_Vectors.Vector;

   procedure Expect (Test : in out Test_Context; Expected : Boolean; Message : String);

   procedure Expect_Raises (Test : in out Test_Context;
                            Proc : Raising_Procedure);

   procedure Expect_Raises (Test : in out Test_Context;
                            Proc : Raising_Procedure;
                            Expected : Exceptions.Exception_Id);

   procedure Expect_Raises (Test : in out Test_Context;
                            Proc : Raising_Procedure;
                            Expected : Exceptions.Exception_Id;
                            Expected_Message : String);
private

   type Test_Context is tagged record
      Passed_Count : Natural := 0;
      Failed_Count : Natural := 0;
      Failed_Expectations : Failure_Vectors.Vector;
   end record;
end Testy.Tests;
