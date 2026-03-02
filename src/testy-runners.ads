with Ada.Containers.Vectors;

with Testy.Reporters;
with Testy.Tests;

package Testy.Runners is
   type Runner is tagged private;

   function Create return Runner;

   procedure Add (Self : in out Runner; Name : String; Proc : Tests.Test_Procedure);

   procedure Run (Self : in out Runner; Reporter : in out Reporters.Reporter'Class);

private

   type Test_Case is record
      Name_Holder : String_Holders.Holder;
      Tested_Procedure : Tests.Test_Procedure;
   end record;

   package Test_Case_Vectors is new Containers.Vectors
     (Index_Type => Positive, Element_Type => Test_Case);

   type Runner is tagged record
      Items : Test_Case_Vectors.Vector;
   end record;
end Testy.Runners;
