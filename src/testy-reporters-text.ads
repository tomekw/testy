package Testy.Reporters.Text is
   type Text_Reporter is new Reporter with private;

   overriding
   procedure Start_Suite (Self : in out Text_Reporter; Tests_Count : Natural; Seed : Seed_Type);

   overriding
   procedure End_Suite (Self : in out Text_Reporter; Passed_Count : Natural; Failed_Count : Natural; Error_Count : Natural);

   overriding
   procedure Start_Test (Self : in out Text_Reporter; Name : String);

   overriding
   procedure End_Test (Self : in out Text_Reporter; Name : String; Ctx : Tests.Test_Context);

   overriding
   procedure End_Test (Self : in out Text_Reporter; Name : String; E : Exceptions.Exception_Occurrence);

private

   type Text_Reporter is new Reporter with null record;
end Testy.Reporters.Text;
