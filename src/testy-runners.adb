with Ada.Command_Line;
with Ada.Numerics.Discrete_Random;

package body Testy.Runners is
   function Random_Seed return Seed_Type is
      subtype Seed_Range is Natural range Seed_Type'Range;
      package Random is new Numerics.Discrete_Random (Seed_Range);

      Generator : Random.Generator;
   begin
      Random.Reset (Generator);

      return Random.Random (Generator);
   end Random_Seed;

   function Create return Runner is
   begin
      return (Items => Test_Case_Vectors.Empty_Vector);
   end Create;

   function Create (Name : String; Proc : Tests.Test_Procedure) return Test_Case is
   begin
      return (Name_Holder => String_Holders.To_Holder (Name), Tested_Procedure => Proc);
   end Create;

   procedure Add (Self : in out Runner; Name : String; Proc : Tests.Test_Procedure) is
   begin
      Self.Items.Append (Create (Name, Proc));
   end Add;

   procedure Shuffle (Items : in out Test_Case_Vectors.Vector; Seed : Seed_Type) is
      subtype Index_Range is Positive range Items.First_Index .. Items.Last_Index;

      package Random is new Numerics.Discrete_Random (Index_Range);

      Generator : Random.Generator;
   begin
      Random.Reset (Generator, Seed);

      for I in Items.First_Index .. Items.Last_Index - 1 loop
         declare
            J : Index_Range;
         begin
            loop
               J := Random.Random (Generator);
               exit when J >= I;
            end loop;

            declare
               Tmp : constant Test_Case := Items (J);
            begin
               Items (J) := Items (I);
               Items (I) := Tmp;
            end;
         end;
      end loop;
   end Shuffle;

   procedure Run (Self : in out Runner; Reporter : in out Reporters.Reporter'Class; Seed : Seed_Type := Random_Seed) is
      Passed_Count : Natural := 0;
      Failed_Count : Natural := 0;
      Error_Count : Natural := 0;
      Tests_Count : constant Natural := Natural (Self.Items.Length);
   begin
      Shuffle (Self.Items, Seed);

      Reporter.Start_Suite (Tests_Count, Seed);

      for Test of Self.Items loop
         declare
            Ctx : Tests.Test_Context;
         begin
            Reporter.Start_Test (Test.Name_Holder.Element);

            Test.Tested_Procedure (Ctx);

            if Ctx.Failed_Count = 0 then
               Passed_Count := Passed_Count + 1;
            else
               Failed_Count := Failed_Count + 1;
            end if;

            Reporter.End_Test (Test.Name_Holder.Element, Ctx);
         exception
            when E : others =>
               Error_Count := Error_Count + 1;
               Reporter.End_Test (Test.Name_Holder.Element, E);
         end;
      end loop;

      Reporter.End_Suite (Passed_Count, Failed_Count, Error_Count);

      if Failed_Count /= 0 or else Error_Count /= 0 then
         Command_Line.Set_Exit_Status (Command_Line.Failure);
      end if;
   end Run;
end Testy.Runners;
