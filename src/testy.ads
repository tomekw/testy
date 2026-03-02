with Ada.Containers.Indefinite_Holders;

package Testy is
   use Ada;

   package String_Holders is new Containers.Indefinite_Holders (String);
end Testy;
