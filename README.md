# Testy [![Tests](https://github.com/tomekw/testy/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/tomekw/testy/actions/workflows/test.yml)

A testing library in Ada. Part of [Tada](https://github.com/tomekw/tada).

## Status

This is alpha software. I'm actively working it. YMMV.

Tested on Linux x86_64, MacOS ARM and Windows x86_64.

## Usage

``` ada
--  tests/foo_tests.ads
with Testy.Tests;

package Foo_Tests is
   use Testy.Tests;

   procedure Foo_Starts_With_F (T : in out Test_Context);

   procedure Foo_Raises (T : in out Test_Context);
end Foo_Tests;
```

``` ada
--  tests/foo_tests.adb
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
```

``` ada
--  tests/tests_main.adb
with Testy.Runners;
with Testy.Reporters.Text;

with Foo_Tests;

procedure Tests_Main is
   use Testy;

   Test_Runner : Runners.Runner := Runners.Create;
   Test_Reporter : Reporters.Text.Text_Reporter;
begin
   Test_Runner.Add ("Foo starts with F", Foo_Tests.Foo_Starts_With_F'Access);
   Test_Runner.Add ("Foo raises", Foo_Tests.Foo_Raises'Access);

   Test_Runner.Run (Test_Reporter);
end Tests_Main;
```

``` shell
$ tada test

Running 2 tests...

[PASS]: Foo starts with F
[PASS]: Foo raises

Results: 2 passed, 0 failed, 0 errors, 2 total.
```

## Disclaimer

This codebase is written by hand. Claude Code is used for Socratic design exploration and code review.

## License

[EUPL](LICENSE)
