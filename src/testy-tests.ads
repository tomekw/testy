with Ada.Containers.Vectors;

package Testy.Tests is
   type Test_Context is tagged private;

   type Test_Procedure is access procedure (Test : in out Test_Context);

   package Failure_Vectors is new Containers.Vectors
     (Index_Type => Positive,
      Element_Type => String_Holders.Holder,
      "=" => String_Holders."=");

   procedure Expect (Test : in out Test_Context; Expected : Boolean; Message : String);

   function Passed_Count (Self : Test_Context) return Natural;

   function Failed_Count (Self : Test_Context) return Natural;

   function Failed_Expectations (Self : Test_Context) return Failure_Vectors.Vector;
private

   type Test_Context is tagged record
      Passed_Count : Natural := 0;
      Failed_Count : Natural := 0;
      Failed_Expectations : Failure_Vectors.Vector;
   end record;
end Testy.Tests;
