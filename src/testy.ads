with Ada.Containers.Indefinite_Holders;

package Testy is
   use Ada;

   subtype Seed_Type is Natural range 0 .. 99_999;

   package String_Holders is new Containers.Indefinite_Holders (String);
end Testy;
