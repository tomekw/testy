with Ada.Exceptions;

with Testy.Tests;

package Testy.Reporters is
   type Reporter is abstract tagged null record;

   procedure Start_Suite (Self : in out Reporter; Tests_Count : Natural; Seed : Seed_Type) is abstract;

   procedure End_Suite (Self : in out Reporter; Passed_Count : Natural; Failed_Count : Natural; Error_Count : Natural) is abstract;

   procedure Start_Test (Self : in out Reporter; Name : String) is abstract;

   procedure End_Test (Self : in out Reporter; Name : String; Ctx : Tests.Test_Context) is abstract;

   procedure End_Test (Self : in out Reporter; Name : String; E : Exceptions.Exception_Occurrence) is abstract;
end Testy.Reporters;
