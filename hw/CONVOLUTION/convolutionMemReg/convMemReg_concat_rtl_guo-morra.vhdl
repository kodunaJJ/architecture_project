
--------> /softl3/catapultc10_0a/64bit/Mgc_home/pkgs/hls_pkgs/src/funcs.vhd 

-- a package of attributes that give verification tools a hint about
-- the function being implemented
PACKAGE attributes IS
  ATTRIBUTE CALYPTO_FUNC : string;
  ATTRIBUTE CALYPTO_DATA_ORDER : string;
end attributes;

-----------------------------------------------------------------------
-- Package that declares synthesizable functions needed for RTL output
-----------------------------------------------------------------------

LIBRARY ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

PACKAGE funcs IS

-----------------------------------------------------------------
-- utility functions
-----------------------------------------------------------------

   FUNCTION TO_STDLOGIC(arg1: BOOLEAN) RETURN STD_LOGIC;
--   FUNCTION TO_STDLOGIC(arg1: STD_ULOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: STD_LOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: SIGNED(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGICVECTOR(arg1: STD_LOGIC) RETURN STD_LOGIC_VECTOR;

   FUNCTION maximum(arg1, arg2 : INTEGER) RETURN INTEGER;
   FUNCTION minimum(arg1, arg2 : INTEGER) RETURN INTEGER;
   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER;
   FUNCTION resolve_std_logic_vector(input1: STD_LOGIC_VECTOR; input2 : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
   
-----------------------------------------------------------------
-- logic functions
-----------------------------------------------------------------

   FUNCTION and_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION or_s (inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION xor_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;

   FUNCTION and_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;
   FUNCTION or_v (inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;
   FUNCTION xor_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- mux functions
-----------------------------------------------------------------

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC       ) RETURN STD_LOGIC;
   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC       ) RETURN STD_LOGIC_VECTOR;
   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- latch functions
-----------------------------------------------------------------
   FUNCTION lat_s(dinput: STD_LOGIC       ; clk: STD_LOGIC; doutput: STD_LOGIC       ) RETURN STD_LOGIC;
   FUNCTION lat_v(dinput: STD_LOGIC_VECTOR; clk: STD_LOGIC; doutput: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- tristate functions
-----------------------------------------------------------------
--   FUNCTION tri_s(dinput: STD_LOGIC       ; control: STD_LOGIC) RETURN STD_LOGIC;
--   FUNCTION tri_v(dinput: STD_LOGIC_VECTOR; control: STD_LOGIC) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- compare functions returning STD_LOGIC
-- in contrast to the functions returning boolean
-----------------------------------------------------------------

   FUNCTION "=" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "=" (l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "/="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "/="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "<="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "<="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "<" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "<" (l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION ">="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION ">="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION ">" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION ">" (l, r: SIGNED  ) RETURN STD_LOGIC;

   -- RETURN 2 bits (left => lt, right => eq)
   FUNCTION cmp (l, r: STD_LOGIC_VECTOR) RETURN STD_LOGIC;

-----------------------------------------------------------------
-- Vectorized Overloaded Arithmetic Operators
-----------------------------------------------------------------

   FUNCTION faccu(arg: UNSIGNED; width: NATURAL) RETURN UNSIGNED;
 
   FUNCTION fabs(arg1: SIGNED  ) RETURN UNSIGNED;

   FUNCTION "/"  (l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "MOD"(l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "REM"(l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "**" (l, r: UNSIGNED) RETURN UNSIGNED;

   FUNCTION "/"  (l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "MOD"(l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "REM"(l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "**" (l, r: SIGNED  ) RETURN SIGNED  ;

-----------------------------------------------------------------
--               S H I F T   F U C T I O N S
-- negative shift shifts the opposite direction
-- *_stdar functions use shift functions from std_logic_arith
-----------------------------------------------------------------

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION fshl(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshl(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION frot(arg1: STD_LOGIC_VECTOR; arg2: STD_LOGIC_VECTOR; signd2: BOOLEAN; sdir: INTEGER range -1 TO 1) RETURN STD_LOGIC_VECTOR;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR;

   -----------------------------------------------------------------
   -- *_stdar functions use shift functions from std_logic_arith
   -----------------------------------------------------------------
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;

-----------------------------------------------------------------
-- indexing functions: LSB always has index 0
-----------------------------------------------------------------

   FUNCTION readindex(vec: STD_LOGIC_VECTOR; index: INTEGER                 ) RETURN STD_LOGIC;
   FUNCTION readslice(vec: STD_LOGIC_VECTOR; index: INTEGER; width: POSITIVE) RETURN STD_LOGIC_VECTOR;

   FUNCTION writeindex(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC       ; index: INTEGER) RETURN STD_LOGIC_VECTOR;
   FUNCTION n_bits(p: NATURAL) RETURN POSITIVE;
   --FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; index: INTEGER) RETURN STD_LOGIC_VECTOR;
   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; enable: STD_LOGIC_VECTOR; byte_width: INTEGER;  index: INTEGER) RETURN STD_LOGIC_VECTOR ;

   FUNCTION ceil_log2(size : NATURAL) return NATURAL;
   FUNCTION bits(size : NATURAL) return NATURAL;    

   PROCEDURE csa(a, b, c: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR);
   PROCEDURE csha(a, b: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR);
   
END funcs;


--------------------------- B O D Y ----------------------------


PACKAGE BODY funcs IS

-----------------------------------------------------------------
-- utility functions
-----------------------------------------------------------------

   FUNCTION TO_STDLOGIC(arg1: BOOLEAN) RETURN STD_LOGIC IS
     BEGIN IF arg1 THEN RETURN '1'; ELSE RETURN '0'; END IF; END;
--   FUNCTION TO_STDLOGIC(arg1: STD_ULOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC IS
--     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: STD_LOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: SIGNED(0 DOWNTO 0)) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;

   FUNCTION TO_STDLOGICVECTOR(arg1: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
     VARIABLE result: STD_LOGIC_VECTOR(0 DOWNTO 0);
   BEGIN
     result := (0 => arg1);
     RETURN result;
   END;

   FUNCTION maximum (arg1,arg2: INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 > arg2) THEN
       RETURN(arg1) ;
     ELSE
       RETURN(arg2) ;
     END IF;
   END;

   FUNCTION minimum (arg1,arg2: INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 < arg2) THEN
       RETURN(arg1) ;
     ELSE
       RETURN(arg2) ;
     END IF;
   END;

   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 = arg2) THEN
       RETURN(seleq) ;
     ELSE
       RETURN(selne) ;
     END IF;
   END;

   FUNCTION resolve_std_logic_vector(input1: STD_LOGIC_VECTOR; input2: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len: INTEGER := input1'LENGTH;
     ALIAS input1a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input1;
     ALIAS input2a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input2;
     VARIABLE result: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     --synopsys translate_off
     FOR i IN len-1 DOWNTO 0 LOOP
       result(i) := resolved(input1a(i) & input2a(i));
     END LOOP;
     --synopsys translate_on
     RETURN result;
   END;

   FUNCTION resolve_unsigned(input1: UNSIGNED; input2: UNSIGNED) RETURN UNSIGNED IS
   BEGIN RETURN UNSIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1), STD_LOGIC_VECTOR(input2))); END;

   FUNCTION resolve_signed(input1: SIGNED; input2: SIGNED) RETURN SIGNED IS
   BEGIN RETURN SIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1), STD_LOGIC_VECTOR(input2))); END;

-----------------------------------------------------------------
-- Logic Functions
-----------------------------------------------------------------

   FUNCTION "not"(arg1: UNSIGNED) RETURN UNSIGNED IS
     BEGIN RETURN UNSIGNED(not STD_LOGIC_VECTOR(arg1)); END;
   FUNCTION and_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(and_v(inputs, 1)); END;
   FUNCTION or_s (inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(or_v(inputs, 1)); END;
   FUNCTION xor_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(xor_v(inputs, 1)); END;

   FUNCTION and_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     FOR i IN icnt2-1 DOWNTO 1 LOOP
       inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
       result := result AND inputsx(olenM1 DOWNTO 0);
     END LOOP;
     RETURN result;
   END;

   FUNCTION or_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     -- this if is added as a quick fix for a bug in catapult evaluating the loop even if inputs'LENGTH==1
     -- see dts0100971279
     IF icnt2 > 1 THEN
       FOR i IN icnt2-1 DOWNTO 1 LOOP
         inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
         result := result OR inputsx(olenM1 DOWNTO 0);
       END LOOP;
     END IF;
     RETURN result;
   END;

   FUNCTION xor_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     FOR i IN icnt2-1 DOWNTO 1 LOOP
       inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
       result := result XOR inputsx(olenM1 DOWNTO 0);
     END LOOP;
     RETURN result;
   END;

-----------------------------------------------------------------
-- Muxes
-----------------------------------------------------------------
   
   FUNCTION mux_sel2_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(1 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 4;
     ALIAS    inputs0: STD_LOGIC_VECTOR( inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector( size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "00" =>
       result := inputs0(1*size-1 DOWNTO 0*size);
     WHEN "01" =>
       result := inputs0(2*size-1 DOWNTO 1*size);
     WHEN "10" =>
       result := inputs0(3*size-1 DOWNTO 2*size);
     WHEN "11" =>
       result := inputs0(4*size-1 DOWNTO 3*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel3_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(2 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 8;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "000" =>
       result := inputs0(1*size-1 DOWNTO 0*size);
     WHEN "001" =>
       result := inputs0(2*size-1 DOWNTO 1*size);
     WHEN "010" =>
       result := inputs0(3*size-1 DOWNTO 2*size);
     WHEN "011" =>
       result := inputs0(4*size-1 DOWNTO 3*size);
     WHEN "100" =>
       result := inputs0(5*size-1 DOWNTO 4*size);
     WHEN "101" =>
       result := inputs0(6*size-1 DOWNTO 5*size);
     WHEN "110" =>
       result := inputs0(7*size-1 DOWNTO 6*size);
     WHEN "111" =>
       result := inputs0(8*size-1 DOWNTO 7*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel4_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(3 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 16;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "0000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "0001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "0010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "0011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "0100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "0101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "0110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "0111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "1000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "1001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "1010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "1011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "1100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "1101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "1110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "1111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel5_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(4 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 32;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0 );
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "00000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "00001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "00010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "00011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "00100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "00101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "00110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "00111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "01000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "01001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "01010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "01011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "01100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "01101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "01110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "01111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN "10000" =>
       result := inputs0( 17*size-1 DOWNTO 16*size);
     WHEN "10001" =>
       result := inputs0( 18*size-1 DOWNTO 17*size);
     WHEN "10010" =>
       result := inputs0( 19*size-1 DOWNTO 18*size);
     WHEN "10011" =>
       result := inputs0( 20*size-1 DOWNTO 19*size);
     WHEN "10100" =>
       result := inputs0( 21*size-1 DOWNTO 20*size);
     WHEN "10101" =>
       result := inputs0( 22*size-1 DOWNTO 21*size);
     WHEN "10110" =>
       result := inputs0( 23*size-1 DOWNTO 22*size);
     WHEN "10111" =>
       result := inputs0( 24*size-1 DOWNTO 23*size);
     WHEN "11000" =>
       result := inputs0( 25*size-1 DOWNTO 24*size);
     WHEN "11001" =>
       result := inputs0( 26*size-1 DOWNTO 25*size);
     WHEN "11010" =>
       result := inputs0( 27*size-1 DOWNTO 26*size);
     WHEN "11011" =>
       result := inputs0( 28*size-1 DOWNTO 27*size);
     WHEN "11100" =>
       result := inputs0( 29*size-1 DOWNTO 28*size);
     WHEN "11101" =>
       result := inputs0( 30*size-1 DOWNTO 29*size);
     WHEN "11110" =>
       result := inputs0( 31*size-1 DOWNTO 30*size);
     WHEN "11111" =>
       result := inputs0( 32*size-1 DOWNTO 31*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel6_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(5 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 64;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "000000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "000001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "000010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "000011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "000100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "000101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "000110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "000111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "001000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "001001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "001010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "001011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "001100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "001101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "001110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "001111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN "010000" =>
       result := inputs0( 17*size-1 DOWNTO 16*size);
     WHEN "010001" =>
       result := inputs0( 18*size-1 DOWNTO 17*size);
     WHEN "010010" =>
       result := inputs0( 19*size-1 DOWNTO 18*size);
     WHEN "010011" =>
       result := inputs0( 20*size-1 DOWNTO 19*size);
     WHEN "010100" =>
       result := inputs0( 21*size-1 DOWNTO 20*size);
     WHEN "010101" =>
       result := inputs0( 22*size-1 DOWNTO 21*size);
     WHEN "010110" =>
       result := inputs0( 23*size-1 DOWNTO 22*size);
     WHEN "010111" =>
       result := inputs0( 24*size-1 DOWNTO 23*size);
     WHEN "011000" =>
       result := inputs0( 25*size-1 DOWNTO 24*size);
     WHEN "011001" =>
       result := inputs0( 26*size-1 DOWNTO 25*size);
     WHEN "011010" =>
       result := inputs0( 27*size-1 DOWNTO 26*size);
     WHEN "011011" =>
       result := inputs0( 28*size-1 DOWNTO 27*size);
     WHEN "011100" =>
       result := inputs0( 29*size-1 DOWNTO 28*size);
     WHEN "011101" =>
       result := inputs0( 30*size-1 DOWNTO 29*size);
     WHEN "011110" =>
       result := inputs0( 31*size-1 DOWNTO 30*size);
     WHEN "011111" =>
       result := inputs0( 32*size-1 DOWNTO 31*size);
     WHEN "100000" =>
       result := inputs0( 33*size-1 DOWNTO 32*size);
     WHEN "100001" =>
       result := inputs0( 34*size-1 DOWNTO 33*size);
     WHEN "100010" =>
       result := inputs0( 35*size-1 DOWNTO 34*size);
     WHEN "100011" =>
       result := inputs0( 36*size-1 DOWNTO 35*size);
     WHEN "100100" =>
       result := inputs0( 37*size-1 DOWNTO 36*size);
     WHEN "100101" =>
       result := inputs0( 38*size-1 DOWNTO 37*size);
     WHEN "100110" =>
       result := inputs0( 39*size-1 DOWNTO 38*size);
     WHEN "100111" =>
       result := inputs0( 40*size-1 DOWNTO 39*size);
     WHEN "101000" =>
       result := inputs0( 41*size-1 DOWNTO 40*size);
     WHEN "101001" =>
       result := inputs0( 42*size-1 DOWNTO 41*size);
     WHEN "101010" =>
       result := inputs0( 43*size-1 DOWNTO 42*size);
     WHEN "101011" =>
       result := inputs0( 44*size-1 DOWNTO 43*size);
     WHEN "101100" =>
       result := inputs0( 45*size-1 DOWNTO 44*size);
     WHEN "101101" =>
       result := inputs0( 46*size-1 DOWNTO 45*size);
     WHEN "101110" =>
       result := inputs0( 47*size-1 DOWNTO 46*size);
     WHEN "101111" =>
       result := inputs0( 48*size-1 DOWNTO 47*size);
     WHEN "110000" =>
       result := inputs0( 49*size-1 DOWNTO 48*size);
     WHEN "110001" =>
       result := inputs0( 50*size-1 DOWNTO 49*size);
     WHEN "110010" =>
       result := inputs0( 51*size-1 DOWNTO 50*size);
     WHEN "110011" =>
       result := inputs0( 52*size-1 DOWNTO 51*size);
     WHEN "110100" =>
       result := inputs0( 53*size-1 DOWNTO 52*size);
     WHEN "110101" =>
       result := inputs0( 54*size-1 DOWNTO 53*size);
     WHEN "110110" =>
       result := inputs0( 55*size-1 DOWNTO 54*size);
     WHEN "110111" =>
       result := inputs0( 56*size-1 DOWNTO 55*size);
     WHEN "111000" =>
       result := inputs0( 57*size-1 DOWNTO 56*size);
     WHEN "111001" =>
       result := inputs0( 58*size-1 DOWNTO 57*size);
     WHEN "111010" =>
       result := inputs0( 59*size-1 DOWNTO 58*size);
     WHEN "111011" =>
       result := inputs0( 60*size-1 DOWNTO 59*size);
     WHEN "111100" =>
       result := inputs0( 61*size-1 DOWNTO 60*size);
     WHEN "111101" =>
       result := inputs0( 62*size-1 DOWNTO 61*size);
     WHEN "111110" =>
       result := inputs0( 63*size-1 DOWNTO 62*size);
     WHEN "111111" =>
       result := inputs0( 64*size-1 DOWNTO 63*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC) RETURN STD_LOGIC IS
   BEGIN RETURN TO_STDLOGIC(mux_v(inputs, sel)); END;

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
   BEGIN RETURN TO_STDLOGIC(mux_v(inputs, sel)); END;

   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS  --pragma hls_map_to_operator mux
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     CONSTANT size   : POSITIVE := inputs'LENGTH / 2;
     CONSTANT olen   : POSITIVE := inputs'LENGTH / 2;
     VARIABLE result : STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT inputs'LENGTH = olen * 2 SEVERITY FAILURE;
     --synopsys translate_on
       CASE sel IS
       WHEN '1'
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
            =>
         result := inputs0( size-1 DOWNTO 0);
       WHEN '0' 
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
            =>
         result := inputs0(2*size-1  DOWNTO size);
       WHEN others =>
         --synopsys translate_off
         result := resolve_std_logic_vector(inputs0(size-1 DOWNTO 0), inputs0( 2*size-1 DOWNTO size));
         --synopsys translate_on
       END CASE;
       RETURN result;
   END;
--   BEGIN RETURN mux_v(inputs, TO_STDLOGICVECTOR(sel)); END;

   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS --pragma hls_map_to_operator mux
     ALIAS    inputs0: STD_LOGIC_VECTOR( inputs'LENGTH-1 DOWNTO 0) IS inputs;
     ALIAS    sel0   : STD_LOGIC_VECTOR( sel'LENGTH-1 DOWNTO 0 ) IS sel;

     VARIABLE sellen : INTEGER RANGE 2-sel'LENGTH TO sel'LENGTH;
     CONSTANT size   : POSITIVE := inputs'LENGTH / 2;
     CONSTANT olen   : POSITIVE := inputs'LENGTH / 2**sel'LENGTH;
     VARIABLE result : STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
     TYPE inputs_array_type is array(natural range <>) of std_logic_vector( olen - 1 DOWNTO 0);
     VARIABLE inputs_array : inputs_array_type( 2**sel'LENGTH - 1 DOWNTO 0);
   BEGIN
     sellen := sel'LENGTH;
     --synopsys translate_off
     ASSERT inputs'LENGTH = olen * 2**sellen SEVERITY FAILURE;
     sellen := 2-sellen;
     --synopsys translate_on
     CASE sellen IS
     WHEN 1 =>
       CASE sel0(0) IS

       WHEN '1' 
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
            =>
         result := inputs0(  size-1 DOWNTO 0);
       WHEN '0' 
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
            =>
         result := inputs0(2*size-1 DOWNTO size);
       WHEN others =>
         --synopsys translate_off
         result := resolve_std_logic_vector(inputs0( size-1 DOWNTO 0), inputs0( 2*size-1 DOWNTO size));
         --synopsys translate_on
       END CASE;
     WHEN 2 =>
       result := mux_sel2_v(inputs, not sel);
     WHEN 3 =>
       result := mux_sel3_v(inputs, not sel);
     WHEN 4 =>
       result := mux_sel4_v(inputs, not sel);
     WHEN 5 =>
       result := mux_sel5_v(inputs, not sel);
     WHEN 6 =>
       result := mux_sel6_v(inputs, not sel);
     WHEN others =>
       -- synopsys translate_off
       IF(Is_X(sel0)) THEN
         result := (others => 'X');
       ELSE
       -- synopsys translate_on
         FOR i in 0 to 2**sel'LENGTH - 1 LOOP
           inputs_array(i) := inputs0( ((i + 1) * olen) - 1  DOWNTO i*olen);
         END LOOP;
         result := inputs_array(CONV_INTEGER( (UNSIGNED(NOT sel0)) ));
       -- synopsys translate_off
       END IF;
       -- synopsys translate_on
     END CASE;
     RETURN result;
   END;

 
-----------------------------------------------------------------
-- Latches
-----------------------------------------------------------------

   FUNCTION lat_s(dinput: STD_LOGIC; clk: STD_LOGIC; doutput: STD_LOGIC) RETURN STD_LOGIC IS
   BEGIN RETURN mux_s(STD_LOGIC_VECTOR'(doutput & dinput), clk); END;

   FUNCTION lat_v(dinput: STD_LOGIC_VECTOR ; clk: STD_LOGIC; doutput: STD_LOGIC_VECTOR ) RETURN STD_LOGIC_VECTOR IS
   BEGIN
     --synopsys translate_off
     ASSERT dinput'LENGTH = doutput'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     RETURN mux_v(doutput & dinput, clk);
   END;

-----------------------------------------------------------------
-- Tri-States
-----------------------------------------------------------------
--   FUNCTION tri_s(dinput: STD_LOGIC; control: STD_LOGIC) RETURN STD_LOGIC IS
--   BEGIN RETURN TO_STDLOGIC(tri_v(TO_STDLOGICVECTOR(dinput), control)); END;
--
--   FUNCTION tri_v(dinput: STD_LOGIC_VECTOR ; control: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
--     VARIABLE result: STD_LOGIC_VECTOR(dinput'range);
--   BEGIN
--     CASE control IS
--     WHEN '0' | 'L' =>
--       result := (others => 'Z');
--     WHEN '1' | 'H' =>
--       FOR i IN dinput'range LOOP
--         result(i) := to_UX01(dinput(i));
--       END LOOP;
--     WHEN others =>
--       -- synopsys translate_off
--       result := (others => 'X');
--       -- synopsys translate_on
--     END CASE;
--     RETURN result;
--   END;

-----------------------------------------------------------------
-- compare functions returning STD_LOGIC
-- in contrast to the functions returning boolean
-----------------------------------------------------------------

   FUNCTION "=" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "/="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "/="(l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;

   FUNCTION "<" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     VARIABLE diff: UNSIGNED(l'LENGTH DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT l'LENGTH = r'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     diff := ('0'&l) - ('0'&r);
     RETURN diff(l'LENGTH);
   END;
   FUNCTION "<"(l, r: SIGNED  ) RETURN STD_LOGIC IS
   BEGIN
     RETURN (UNSIGNED(l) < UNSIGNED(r)) xor (l(l'LEFT) xor r(r'LEFT));
   END;

   FUNCTION "<="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(r < l); END;
   FUNCTION "<=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(r < l); END;
   FUNCTION ">" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN r < l; END;
   FUNCTION ">"(l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN r < l; END;
   FUNCTION ">="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(l < r); END;
   FUNCTION ">=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(l < r); END;

   FUNCTION cmp (l, r: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
   BEGIN
     --synopsys translate_off
     ASSERT l'LENGTH = r'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     RETURN not or_s(l xor r);
   END;

-----------------------------------------------------------------
-- Vectorized Overloaded Arithmetic Operators
-----------------------------------------------------------------

   --some functions to placate spyglass
   FUNCTION mult_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a*b;
   END mult_natural;

   FUNCTION div_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a/b;
   END div_natural;

   FUNCTION mod_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a mod b;
   END mod_natural;

   FUNCTION add_unsigned(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a+b;
   END add_unsigned;

   FUNCTION sub_unsigned(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a-b;
   END sub_unsigned;

   FUNCTION sub_int(a,b : INTEGER) RETURN INTEGER IS
   BEGIN
     return a-b;
   END sub_int;

   FUNCTION concat_0(b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return '0' & b;
   END concat_0;

   FUNCTION concat_uns(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a&b;
   END concat_uns;

   FUNCTION concat_vect(a,b : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
   BEGIN
     return a&b;
   END concat_vect;





   FUNCTION faccu(arg: UNSIGNED; width: NATURAL) RETURN UNSIGNED IS
     CONSTANT ninps : NATURAL := arg'LENGTH / width;
     ALIAS    arg0  : UNSIGNED(arg'LENGTH-1 DOWNTO 0) IS arg;
     VARIABLE result: UNSIGNED(width-1 DOWNTO 0);
     VARIABLE from  : INTEGER;
     VARIABLE dto   : INTEGER;
   BEGIN
     --synopsys translate_off
     ASSERT arg'LENGTH = width * ninps SEVERITY FAILURE;
     --synopsys translate_on
     result := (OTHERS => '0');
     FOR i IN ninps-1 DOWNTO 0 LOOP
       --result := result + arg0((i+1)*width-1 DOWNTO i*width);
       from := mult_natural((i+1), width)-1; --2.1.6.3
       dto  := mult_natural(i,width); --2.1.6.3
       result := add_unsigned(result , arg0(from DOWNTO dto) );
     END LOOP;
     RETURN result;
   END faccu;

   FUNCTION  fabs (arg1: SIGNED) RETURN UNSIGNED IS
   BEGIN
     CASE arg1(arg1'LEFT) IS
     WHEN '1'
     --synopsys translate_off
          | 'H'
     --synopsys translate_on
       =>
       RETURN UNSIGNED'("0") - UNSIGNED(arg1);
     WHEN '0'
     --synopsys translate_off
          | 'L'
     --synopsys translate_on
       =>
       RETURN UNSIGNED(arg1);
     WHEN others =>
       RETURN resolve_unsigned(UNSIGNED(arg1), UNSIGNED'("0") - UNSIGNED(arg1));
     END CASE;
   END;

   PROCEDURE divmod(l, r: UNSIGNED; rdiv, rmod: OUT UNSIGNED) IS
     CONSTANT llen: INTEGER := l'LENGTH;
     CONSTANT rlen: INTEGER := r'LENGTH;
     CONSTANT llen_plus_rlen: INTEGER := llen + rlen;
     VARIABLE lbuf: UNSIGNED(llen+rlen-1 DOWNTO 0);
     VARIABLE diff: UNSIGNED(rlen DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT rdiv'LENGTH = llen AND rmod'LENGTH = rlen SEVERITY FAILURE;
     --synopsys translate_on
     lbuf := (others => '0');
     lbuf(llen-1 DOWNTO 0) := l;
     FOR i IN rdiv'range LOOP
       diff := sub_unsigned(lbuf(llen_plus_rlen-1 DOWNTO llen-1) ,(concat_0(r)));
       rdiv(i) := not diff(rlen);
       IF diff(rlen) = '0' THEN
         lbuf(llen_plus_rlen-1 DOWNTO llen-1) := diff;
       END IF;
       lbuf(llen_plus_rlen-1 DOWNTO 1) := lbuf(llen_plus_rlen-2 DOWNTO 0);
     END LOOP;
     rmod := lbuf(llen_plus_rlen-1 DOWNTO llen);
   END divmod;

   FUNCTION "/"  (l, r: UNSIGNED) RETURN UNSIGNED IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(l, r, rdiv, rmod);
     RETURN rdiv;
   END "/";

   FUNCTION "MOD"(l, r: UNSIGNED) RETURN UNSIGNED IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(l, r, rdiv, rmod);
     RETURN rmod;
   END;

   FUNCTION "REM"(l, r: UNSIGNED) RETURN UNSIGNED IS
     BEGIN RETURN l MOD r; END;

   FUNCTION "/"  (l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) /= to_X01(r(r'LEFT)) THEN
       rdiv := UNSIGNED'("0") - rdiv;
     END IF;
     RETURN SIGNED(rdiv); -- overflow problem "1000" / "11"
   END "/";

   FUNCTION "MOD"(l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
     CONSTANT rnul: UNSIGNED(r'LENGTH-1 DOWNTO 0) := (others => '0');
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) = '1' THEN
       rmod := UNSIGNED'("0") - rmod;
     END IF;
     IF rmod /= rnul AND to_X01(l(l'LEFT)) /= to_X01(r(r'LEFT)) THEN
       rmod := UNSIGNED(r) + rmod;
     END IF;
     RETURN SIGNED(rmod);
   END "MOD";

   FUNCTION "REM"(l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) = '1' THEN
       rmod := UNSIGNED'("0") - rmod;
     END IF;
     RETURN SIGNED(rmod);
   END "REM";

   FUNCTION mult_unsigned(l,r : UNSIGNED) return UNSIGNED is
   BEGIN
     return l*r; 
   END mult_unsigned;

   FUNCTION "**" (l, r : UNSIGNED) RETURN UNSIGNED IS
     CONSTANT llen  : NATURAL := l'LENGTH;
     VARIABLE result: UNSIGNED(llen-1 DOWNTO 0);
     VARIABLE fak   : UNSIGNED(llen-1 DOWNTO 0);
   BEGIN
     fak := l;
     result := (others => '0'); result(0) := '1';
     FOR i IN r'reverse_range LOOP
       --was:result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(result & (result*fak)), r(i)));
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR( concat_uns(result , mult_unsigned(result,fak) )), r(i)));

       fak := mult_unsigned(fak , fak);
     END LOOP;
     RETURN result;
   END "**";

   FUNCTION "**" (l, r : SIGNED) RETURN SIGNED IS
     CONSTANT rlen  : NATURAL := r'LENGTH;
     ALIAS    r0    : SIGNED(0 TO r'LENGTH-1) IS r;
     VARIABLE result: SIGNED(l'range);
   BEGIN
     CASE r(r'LEFT) IS
     WHEN '0'
   --synopsys translate_off
          | 'L'
   --synopsys translate_on
     =>
       result := SIGNED(UNSIGNED(l) ** UNSIGNED(r0(1 TO r'LENGTH-1)));
     WHEN '1'
   --synopsys translate_off
          | 'H'
   --synopsys translate_on
     =>
       result := (others => '0');
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END "**";

-----------------------------------------------------------------
--               S H I F T   F U C T I O N S
-- negative shift shifts the opposite direction
-----------------------------------------------------------------

   FUNCTION add_nat(arg1 : NATURAL; arg2 : NATURAL ) RETURN NATURAL IS
   BEGIN
     return (arg1 + arg2);
   END;
   
--   FUNCTION UNSIGNED_2_BIT_VECTOR(arg1 : NATURAL; arg2 : NATURAL ) RETURN BIT_VECTOR IS
--   BEGIN
--     return (arg1 + arg2);
--   END;
   
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shl(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: SIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shl(SIGNED(result), arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shr(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: SIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shr(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: UNSIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: UNSIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl_stdar(arg1: SIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: SIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: SIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: SIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_signed(
           fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl_stdar(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
        =>
         RETURN fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
        =>
         RETURN fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr_stdar(arg1: SIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: SIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl_stdar(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_signed(
           fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr_stdar(arg1, arg2, '0', olen); END;

   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshr_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshr_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;


   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
     VARIABLE temp: UNSIGNED(len-1 DOWNTO 0);
     --SUBTYPE  sw_range IS NATURAL range 1 TO len;
     VARIABLE sw: NATURAL range 1 TO len;
     VARIABLE temp_idx : INTEGER; --2.1.6.3
   BEGIN
     sw := 1;
     result := (others => sbit);
     result(ilen-1 DOWNTO 0) := arg1;
     FOR i IN arg2'reverse_range LOOP
       temp := (others => '0');
       FOR i2 IN len-1-sw DOWNTO 0 LOOP
         --was:temp(i2+sw) := result(i2);
         temp_idx := add_nat(i2,sw);
         temp(temp_idx) := result(i2);
       END LOOP;
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(concat_uns(result,temp)), arg2(i)));
       sw := minimum(mult_natural(sw,2), len);
     END LOOP;
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
     VARIABLE temp: UNSIGNED(len-1 DOWNTO 0);
     SUBTYPE  sw_range IS NATURAL range 1 TO len;
     VARIABLE sw: sw_range;
     VARIABLE result_idx : INTEGER; --2.1.6.3
   BEGIN
     sw := 1;
     result := (others => sbit);
     result(ilen-1 DOWNTO 0) := arg1;
     FOR i IN arg2'reverse_range LOOP
       temp := (others => sbit);
       FOR i2 IN len-1-sw DOWNTO 0 LOOP
         -- was: temp(i2) := result(i2+sw);
         result_idx := add_nat(i2,sw);
         temp(i2) := result(result_idx);
       END LOOP;
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(concat_uns(result,temp)), arg2(i)));
       sw := minimum(mult_natural(sw,2), len);
     END LOOP;
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: UNSIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: UNSIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshl(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshr(arg1x_pad(arg1l+1 DOWNTO 1), not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshl(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr(arg1x_pad(arg1l+1 DOWNTO 1), not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshr(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshl(arg1 & '0', not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshr(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl(arg1 & '0', not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl(arg1, arg2, '0', olen); END;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr(arg1, arg2, '0', olen); END;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl(arg1, arg2, '0', olen); END;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr(arg1, arg2, '0', olen); END;

   FUNCTION fshl(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshl(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshr(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshr(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshl(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshl(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshr(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshr(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;


   FUNCTION frot(arg1: STD_LOGIC_VECTOR; arg2: STD_LOGIC_VECTOR; signd2: BOOLEAN; sdir: INTEGER range -1 TO 1) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len: INTEGER := arg1'LENGTH;
     VARIABLE result: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     VARIABLE temp: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     SUBTYPE sw_range IS NATURAL range 0 TO len-1;
     VARIABLE sw: sw_range;
     VARIABLE temp_idx : INTEGER; --2.1.6.3
   BEGIN
     result := (others=>'0');
     result := arg1;
     sw := sdir MOD len;
     FOR i IN arg2'reverse_range LOOP
       EXIT WHEN sw = 0;
       IF signd2 AND i = arg2'LEFT THEN 
         sw := sub_int(len,sw); 
       END IF;
       -- temp := result(len-sw-1 DOWNTO 0) & result(len-1 DOWNTO len-sw)
       FOR i2 IN len-1 DOWNTO 0 LOOP
         --was: temp((i2+sw) MOD len) := result(i2);
         temp_idx := add_nat(i2,sw) MOD len;
         temp(temp_idx) := result(i2);
       END LOOP;
       result := mux_v(STD_LOGIC_VECTOR(concat_vect(result,temp)), arg2(i));
       sw := mod_natural(mult_natural(sw,2), len);
     END LOOP;
     RETURN result;
   END frot;

   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), FALSE, 1); END;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), FALSE, -1); END;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), TRUE, 1); END;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), TRUE, -1); END;

-----------------------------------------------------------------
-- indexing functions: LSB always has index 0
-----------------------------------------------------------------

   FUNCTION readindex(vec: STD_LOGIC_VECTOR; index: INTEGER                 ) RETURN STD_LOGIC IS
     CONSTANT len : INTEGER := vec'LENGTH;
     ALIAS    vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS vec;
   BEGIN
     IF index >= len OR index < 0 THEN
       RETURN 'X';
     END IF;
     RETURN vec0(index);
   END;

   FUNCTION readslice(vec: STD_LOGIC_VECTOR; index: INTEGER; width: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len : INTEGER := vec'LENGTH;
     CONSTANT indexPwidthM1 : INTEGER := index+width-1; --2.1.6.3
     ALIAS    vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS vec;
     CONSTANT xxx : STD_LOGIC_VECTOR(width-1 DOWNTO 0) := (others => 'X');
   BEGIN
     IF index+width > len OR index < 0 THEN
       RETURN xxx;
     END IF;
     RETURN vec0(indexPwidthM1 DOWNTO index);
   END;

   FUNCTION writeindex(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC       ; index: INTEGER) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len : INTEGER := vec'LENGTH;
     VARIABLE vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     CONSTANT xxx : STD_LOGIC_VECTOR(len-1 DOWNTO 0) := (others => 'X');
   BEGIN
     vec0 := vec;
     IF index >= len OR index < 0 THEN
       RETURN xxx;
     END IF;
     vec0(index) := dinput;
     RETURN vec0;
   END;

   FUNCTION n_bits(p: NATURAL) RETURN POSITIVE IS
     VARIABLE n_b : POSITIVE;
     VARIABLE p_v : NATURAL;
   BEGIN
     p_v := p;
     FOR i IN 1 TO 32 LOOP
       p_v := div_natural(p_v,2);
       n_b := i;
       EXIT WHEN (p_v = 0);
     END LOOP;
     RETURN n_b;
   END;


--   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; index: INTEGER) RETURN STD_LOGIC_VECTOR IS
--
--     CONSTANT vlen: INTEGER := vec'LENGTH;
--     CONSTANT ilen: INTEGER := dinput'LENGTH;
--     CONSTANT max_shift: INTEGER := vlen-ilen;
--     CONSTANT ones: UNSIGNED(ilen-1 DOWNTO 0) := (others => '1');
--     CONSTANT xxx : STD_LOGIC_VECTOR(vlen-1 DOWNTO 0) := (others => 'X');
--     VARIABLE shift : UNSIGNED(n_bits(max_shift)-1 DOWNTO 0);
--     VARIABLE vec0: STD_LOGIC_VECTOR(vlen-1 DOWNTO 0);
--     VARIABLE inp: UNSIGNED(vlen-1 DOWNTO 0);
--     VARIABLE mask: UNSIGNED(vlen-1 DOWNTO 0);
--   BEGIN
--     inp := (others => '0');
--     mask := (others => '0');
--
--     IF index > max_shift OR index < 0 THEN
--       RETURN xxx;
--     END IF;
--
--     shift := CONV_UNSIGNED(index, shift'LENGTH);
--     inp(ilen-1 DOWNTO 0) := UNSIGNED(dinput);
--     mask(ilen-1 DOWNTO 0) := ones;
--     inp := fshl(inp, shift, vlen);
--     mask := fshl(mask, shift, vlen);
--     vec0 := (vec and (not STD_LOGIC_VECTOR(mask))) or STD_LOGIC_VECTOR(inp);
--     RETURN vec0;
--   END;

   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; enable: STD_LOGIC_VECTOR; byte_width: INTEGER;  index: INTEGER) RETURN STD_LOGIC_VECTOR IS

     type enable_matrix is array (0 to enable'LENGTH-1 ) of std_logic_vector(byte_width-1 downto 0);
     CONSTANT vlen: INTEGER := vec'LENGTH;
     CONSTANT ilen: INTEGER := dinput'LENGTH;
     CONSTANT max_shift: INTEGER := vlen-ilen;
     CONSTANT ones: UNSIGNED(ilen-1 DOWNTO 0) := (others => '1');
     CONSTANT xxx : STD_LOGIC_VECTOR(vlen-1 DOWNTO 0) := (others => 'X');
     VARIABLE shift : UNSIGNED(n_bits(max_shift)-1 DOWNTO 0);
     VARIABLE vec0: STD_LOGIC_VECTOR(vlen-1 DOWNTO 0);
     VARIABLE inp: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE mask: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE mask2: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE enables: enable_matrix;
     VARIABLE cat_enables: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0 );
     VARIABLE lsbi : INTEGER;
     VARIABLE msbi : INTEGER;

   BEGIN
     cat_enables := (others => '0');
     lsbi := 0;
     msbi := byte_width-1;
     inp := (others => '0');
     mask := (others => '0');

     IF index > max_shift OR index < 0 THEN
       RETURN xxx;
     END IF;

     --initialize enables
     for i in 0 TO (enable'LENGTH-1) loop
       enables(i)  := (others => enable(i));
       cat_enables(msbi downto lsbi) := enables(i) ;
       lsbi := msbi+1;
       msbi := msbi+byte_width;
     end loop;


     shift := CONV_UNSIGNED(index, shift'LENGTH);
     inp(ilen-1 DOWNTO 0) := UNSIGNED(dinput);
     mask(ilen-1 DOWNTO 0) := UNSIGNED((STD_LOGIC_VECTOR(ones) AND cat_enables));
     inp := fshl(inp, shift, vlen);
     mask := fshl(mask, shift, vlen);
     vec0 := (vec and (not STD_LOGIC_VECTOR(mask))) or STD_LOGIC_VECTOR(inp);
     RETURN vec0;
   END;


   FUNCTION ceil_log2(size : NATURAL) return NATURAL is
     VARIABLE cnt : NATURAL;
     VARIABLE res : NATURAL;
   begin
     cnt := 1;
     res := 0;
     while (cnt < size) loop
       res := res + 1;
       cnt := 2 * cnt;
     end loop;
     return res;
   END;
   
   FUNCTION bits(size : NATURAL) return NATURAL is
   begin
     return ceil_log2(size);
   END;

   PROCEDURE csa(a, b, c: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR) IS
   BEGIN
     s    := conv_std_logic_vector(a, s'LENGTH) xor conv_std_logic_vector(b, s'LENGTH) xor conv_std_logic_vector(c, s'LENGTH);
     cout := ( (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(b, cout'LENGTH)) or (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(c, cout'LENGTH)) or (conv_std_logic_vector(b, cout'LENGTH) and conv_std_logic_vector(c, cout'LENGTH)) );
   END PROCEDURE csa;

   PROCEDURE csha(a, b: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR) IS
   BEGIN
     s    := conv_std_logic_vector(a, s'LENGTH) xor conv_std_logic_vector(b, s'LENGTH);
     cout := (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(b, cout'LENGTH));
   END PROCEDURE csha;

END funcs;

--------> /softl3/catapultc10_0a/64bit/Mgc_home/pkgs/siflibs/mgc_ioport_comps_v11.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2015 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------


--------------------------------------------------------------------
--                M G C _ I O P O R T _ C O M P S
--------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

PACKAGE mgc_ioport_comps_v11 IS

-- INPUT COMPONENTS

COMPONENT mgc_in_wire_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    d        : OUT std_logic_vector(width-1 DOWNTO 0);
    z        : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_in_wire_en_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    ld       : IN  std_logic;
    d        : OUT std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    z        : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_in_wire_wait_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    ld       : IN  std_logic;
    vd       : OUT std_logic;
    d        : OUT std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    vz       : IN  std_logic;
    z        : IN  std_logic_vector(width-1 DOWNTO 0)
   );
END COMPONENT;

COMPONENT mgc_chan_in_v2
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    sz_width : INTEGER
  );
  PORT (
    ld       : IN  std_logic;
    vd       : OUT std_logic;
    d        : OUT std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    vz       : IN  std_logic;
    z        : IN  std_logic_vector(width-1 DOWNTO 0);
    sd       : OUT std_logic_vector(sz_width-1 DOWNTO 0);
    sld      : IN  std_logic;
    sz       : IN std_logic_vector(sz_width-1 DOWNTO 0);
    slz      : OUT std_logic
   );
END COMPONENT;

COMPONENT mgc_in_wire_wait_nb_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    sz_width : INTEGER
  );
  PORT (
    ld       : IN  std_logic;
    vd       : OUT std_logic;
    d        : OUT std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    vz       : IN  std_logic;
    z        : IN  std_logic_vector(width-1 DOWNTO 0);
    sd       : OUT   std_logic_vector(sz_width-1 DOWNTO 0);
    sld      : in    std_logic
  );
END COMPONENT;

-- OUTPUT COMPONENTS

COMPONENT mgc_out_stdreg_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_out_stdreg_en_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    ld       : IN  std_logic;
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;


COMPONENT mgc_out_stdreg_wait_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    ld       : IN  std_logic;
    vd       : OUT std_logic;
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    vz       : IN  std_logic;
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_out_dreg_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_out_reg_pos_v2
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    ph_en    : INTEGER RANGE 0 TO 1;
    ph_arst  : INTEGER RANGE 0 TO 1;
    ph_srst  : INTEGER RANGE 0 TO 1
  );
  PORT (
    clk      : IN  std_logic;
    en       : IN  std_logic;
    arst     : IN  std_logic;
    srst     : IN  std_logic;
    ld       : IN  std_logic;
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_out_reg_neg_v2
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    ph_en    : INTEGER RANGE 0 TO 1;
    ph_arst  : INTEGER RANGE 0 TO 1;
    ph_srst  : INTEGER RANGE 0 TO 1
  );
  PORT (
    clk      : IN  std_logic;
    en       : IN  std_logic;
    arst     : IN  std_logic;
    srst     : IN  std_logic;
    ld       : IN  std_logic;
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_out_reg_v3
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    ph_clk   : INTEGER RANGE 0 TO 1;
    ph_en    : INTEGER RANGE 0 TO 1;
    ph_arst  : INTEGER RANGE 0 TO 1;
    ph_srst  : INTEGER RANGE 0 TO 1
  );
  PORT (
    clk      : IN  std_logic;
    en       : IN  std_logic;
    arst     : IN  std_logic;
    srst     : IN  std_logic;
    ld       : IN  std_logic;
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_out_buf_wait_v4
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    ph_clk   : INTEGER RANGE 0 TO 1;
    ph_en    : INTEGER RANGE 0 TO 1;
    ph_arst  : INTEGER RANGE 0 TO 1;
    ph_srst  : INTEGER RANGE 0 TO 1
  );
  PORT (
    clk      : IN  std_logic;
    en       : IN  std_logic;
    arst     : IN  std_logic;
    srst     : IN  std_logic;
    ld       : IN  std_logic;
    vd       : OUT std_logic;
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    vz       : IN  std_logic;
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_out_fifo_wait_v9
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    fifo_sz  : INTEGER;
    ph_clk   : INTEGER RANGE 0 TO 1;
    ph_en    : INTEGER RANGE 0 TO 1;
    ph_arst  : INTEGER RANGE 0 TO 1;
    ph_srst  : INTEGER RANGE 0 TO 1;
    ph_log2  : INTEGER
  );
  PORT (
    clk      : IN  std_logic;
    en       : IN  std_logic;
    arst     : IN  std_logic;
    srst     : IN  std_logic;
    ld       : IN  std_logic;
    vd       : OUT std_logic;
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    vz       : IN  std_logic;
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

-- implementation for mgc_out_fifo_wait
COMPONENT mgc_out_fifo_wait_core_v9
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    sz_width : INTEGER;
    fifo_sz  : INTEGER;
    ph_clk   : INTEGER RANGE 0 TO 1;
    ph_en    : INTEGER RANGE 0 TO 1;
    ph_arst  : INTEGER RANGE 0 TO 1;
    ph_srst  : INTEGER RANGE 0 TO 1;
    ph_log2  : INTEGER
  );
  PORT (
    clk      : IN  std_logic;
    en       : IN  std_logic;
    arst     : IN  std_logic;
    srst     : IN  std_logic;
    ld       : IN  std_logic;
    vd       : OUT std_logic;
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    vz       : IN  std_logic;
    z        : OUT std_logic_vector(width-1 DOWNTO 0);
    sd       : OUT std_logic_vector(sz_width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_out_prereg_en_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    ld       : IN  std_logic;
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    lz       : OUT std_logic;
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

-- INOUT COMPONENTS

COMPONENT mgc_inout_dreg_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    din      : OUT   std_logic_vector(width-1 DOWNTO 0);
    dout     : IN    std_logic_vector(width-1 DOWNTO 0);
    zin      : IN    std_logic_vector(width-1 DOWNTO 0);
    zout     : OUT   std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_inout_stdreg_en_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    ldin     : IN    std_logic;
    din      : OUT   std_logic_vector(width-1 DOWNTO 0);
    ldout    : IN    std_logic;
    dout     : IN    std_logic_vector(width-1 DOWNTO 0);
    lzin     : OUT   std_logic;
    zin      : IN    std_logic_vector(width-1 DOWNTO 0);
    lzout    : OUT   std_logic;
    zout     : OUT   std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_inout_stdreg_wait_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    ldin     : IN    std_logic;
    vdin     : OUT   std_logic;
    din      : OUT   std_logic_vector(width-1 DOWNTO 0);
    ldout    : IN    std_logic;
    vdout    : OUT   std_logic;
    dout     : IN    std_logic_vector(width-1 DOWNTO 0);
    lzin     : OUT   std_logic;
    vzin     : IN    std_logic;
    zin      : IN    std_logic_vector(width-1 DOWNTO 0);
    lzout    : OUT   std_logic;
    vzout    : IN    std_logic;
    zout     : OUT   std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_hid_tribuf_v1
  GENERIC (
    width    : INTEGER
  );
  PORT ( 
    I_SIG    : IN     std_logic_vector(width-1 DOWNTO 0);
    ENABLE   : IN     boolean ;
    O_SIG    : OUT    std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_inout_buf_wait_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    ph_clk   : INTEGER RANGE 0 TO 1;
    ph_en    : INTEGER RANGE 0 TO 1;
    ph_arst  : INTEGER RANGE 0 TO 1;
    ph_srst  : INTEGER RANGE 0 TO 1
  );
  PORT (
    clk      : IN    std_logic;
    en       : IN    std_logic;
    arst     : IN    std_logic;
    srst     : IN    std_logic;
    ldin     : IN    std_logic;
    vdin     : OUT   std_logic;
    din      : OUT   std_logic_vector(width-1 DOWNTO 0);
    ldout    : IN    std_logic;
    vdout    : OUT   std_logic;
    dout     : IN    std_logic_vector(width-1 DOWNTO 0);
    lzin     : OUT   std_logic;
    vzin     : IN    std_logic;
    zin      : IN    std_logic_vector(width-1 DOWNTO 0);
    lzout    : OUT   std_logic;
    vzout    : IN    std_logic;
    zout     : OUT   std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_inout_fifo_wait_v2
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    fifo_sz  : INTEGER;
    ph_clk   : INTEGER RANGE 0 TO 1;
    ph_en    : INTEGER RANGE 0 TO 1;
    ph_arst  : INTEGER RANGE 0 TO 1;
    ph_srst  : INTEGER RANGE 0 TO 1;
    ph_log2  : INTEGER
  );
  PORT (
    clk      : IN    std_logic;
    en       : IN    std_logic;
    arst     : IN    std_logic;
    srst     : IN    std_logic;
    ldin     : IN    std_logic;
    vdin     : OUT   std_logic;
    din      : OUT   std_logic_vector(width-1 DOWNTO 0);
    ldout    : IN    std_logic;
    vdout    : OUT   std_logic;
    dout     : IN    std_logic_vector(width-1 DOWNTO 0);
    lzin     : OUT   std_logic;
    vzin     : IN    std_logic;
    zin      : IN    std_logic_vector(width-1 DOWNTO 0);
    lzout    : OUT   std_logic;
    vzout    : IN    std_logic;
    zout     : OUT   std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

-- IO SYNCHRONIZATION

COMPONENT mgc_io_sync_v1
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    ld       : IN    std_logic;
    lz       : OUT   std_logic
  );
END COMPONENT;

-- IO SYNCHRONIZATION

COMPONENT mgc_in_sync_v1
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    vd       : OUT   std_logic;
    vz       : IN    std_logic
  );
END COMPONENT;

-- PIPE

COMPONENT mgc_bsync_rdy_v1
  GENERIC (
    rscid    : INTEGER;
    ready    : INTEGER RANGE 0 TO 1;
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    rd       : IN    std_logic;
    rz       : OUT   std_logic
  );
END COMPONENT;

COMPONENT mgc_bsync_vld_v1
  GENERIC (
    rscid    : INTEGER;
    ready    : INTEGER RANGE 0 TO 1;
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    vd       : OUT   std_logic;
    vz       : IN    std_logic
  );
END COMPONENT;

COMPONENT mgc_bsync_rv_v1
  GENERIC (
    rscid    : INTEGER;
    ready    : INTEGER RANGE 0 TO 1;
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    rd       : IN    std_logic;
    vd       : OUT   std_logic;
    rz       : OUT   std_logic;
    vz       : IN    std_logic
  );
END COMPONENT;

-- PIPE

COMPONENT mgc_pipe_v10
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER;
    sz_width : INTEGER;
    fifo_sz  : INTEGER;
    log2_sz  : INTEGER;
    ph_clk   : INTEGER RANGE 0 TO 1;
    ph_en    : INTEGER RANGE 0 TO 1;
    ph_arst  : INTEGER RANGE 0 TO 1;
    ph_srst  : INTEGER RANGE 0 TO 1
  );
  PORT (
    clk      : IN    std_logic;
    en       : IN    std_logic;
    arst     : IN    std_logic;
    srst     : IN    std_logic;
    ldin     : IN    std_logic;
    vdin     : OUT   std_logic;
    din      : OUT   std_logic_vector(width-1 DOWNTO 0);
    ldout    : IN    std_logic;
    vdout    : OUT   std_logic;
    dout     : IN    std_logic_vector(width-1 DOWNTO 0);
    sd       : OUT   std_logic_vector(sz_width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_sync_v1
  PORT (
    ldin     : IN    std_logic;
    vdin     : OUT   std_logic;
    ldout    : IN    std_logic;
    vdout    : OUT   std_logic
  );
END COMPONENT;

COMPONENT ccs_event_chan_v1 IS
  GENERIC (
    rscid    : INTEGER
  );
  PORT (
    ldout    : IN    std_logic;
    vdin     : OUT   std_logic
  );
END COMPONENT;

COMPONENT ccs_event_in_v1 IS
  GENERIC (
    rscid    : INTEGER
  );
  PORT (
    vzin : IN    std_logic;
    vdin : OUT   std_logic
  );
END COMPONENT;

COMPONENT ccs_event_out_v1 IS
  GENERIC (
    rscid    : INTEGER
  );
  PORT (
    ldout    : IN    std_logic;
    lzout    : OUT   std_logic
  );
END COMPONENT;

COMPONENT ccs_sync_chan_v1 IS
  GENERIC (
    rscid    : INTEGER
  );
  PORT (
    ldout    : IN    std_logic;
    vdout    : OUT   std_logic;
    ldin     : IN    std_logic;
    vdin     : OUT   std_logic
  );
END COMPONENT;

COMPONENT ccs_sync_in_v1 IS
  GENERIC (
    rscid    : INTEGER
  );
  PORT (
    vzin : IN    std_logic;
    lzin : OUT   std_logic;
    ldin : IN    std_logic;
    vdin : OUT   std_logic
  );
END COMPONENT;

COMPONENT ccs_sync_out_v1 IS
  GENERIC (
    rscid    : INTEGER
  );
  PORT (
    ldout : IN    std_logic;
    vdout : OUT   std_logic;
    lzout : OUT   std_logic;
    vzout : IN    std_logic
  );
END COMPONENT;


-- The start of the asynch CDC components
COMPONENT mgc_regfile_pos_v1
generic
(
  data_width   : integer;
  addr_width   : integer;
  num_of_words : integer;
  ph_en        : integer RANGE 0 to 1;
  ph_arst      : integer RANGE 0 to 1;
  ph_srst      : integer RANGE 0 to 1
);
port
(
  clk           : IN  std_logic;
  arst          : IN  std_logic;
  srst          : IN  std_logic;
  en            : IN  std_logic;
  write_en      : IN  std_logic;
  write_address : IN  std_logic_vector (addr_width - 1 downto 0);
  write_data    : IN  std_logic_vector (data_width - 1 downto 0);
  read_address  : IN  std_logic_vector (addr_width - 1 downto 0);
  read_data     : OUT std_logic_vector (data_width - 1 downto 0)
);
END COMPONENT;

COMPONENT mgc_regfile_neg_v1
generic
(
  data_width   : integer;
  addr_width   : integer;
  num_of_words : integer;
  ph_en        : integer RANGE 0 to 1;
  ph_arst      : integer RANGE 0 to 1;
  ph_srst      : integer RANGE 0 to 1
);
port
(
  clk           : IN  std_logic;
  arst          : IN  std_logic;
  srst          : IN  std_logic;
  en            : IN  std_logic;
  write_en      : IN  std_logic;
  write_address : IN  std_logic_vector (addr_width - 1 downto 0);
  write_data    : IN  std_logic_vector (data_width - 1 downto 0);
  read_address  : IN  std_logic_vector (addr_width - 1 downto 0);
  read_data     : OUT std_logic_vector (data_width - 1 downto 0)
);
END COMPONENT;

COMPONENT mgc_regfile_v1
generic
(
  data_width   : integer;
  addr_width   : integer;
  num_of_words : integer;
  ph_clk       : integer RANGE 0 TO 1;
  ph_en        : integer RANGE 0 to 1;
  ph_arst      : integer RANGE 0 to 1;
  ph_srst      : integer RANGE 0 to 1
);
port
(
  clk           : IN  std_logic;
  arst          : IN  std_logic;
  srst          : IN  std_logic;
  en            : IN  std_logic;
  write_en      : IN  std_logic;
  write_address : IN  std_logic_vector (addr_width - 1 downto 0);
  write_data    : IN  std_logic_vector (data_width - 1 downto 0);
  read_address  : IN  std_logic_vector (addr_width - 1 downto 0);
  read_data     : OUT std_logic_vector (data_width - 1 downto 0)
);
END COMPONENT;

COMPONENT mgc_in_ram_v1
generic
(
  ram_id            : integer;
  words             : integer;
  width             : integer;
  addr_width        : integer;
  re_active         : integer;
  num_byte_enables  : integer;
  no_of_ports       : integer
);
port
(
 id : out  STD_LOGIC_VECTOR((no_of_ports * width) - 1 downto 0);
 ad : in  STD_LOGIC_VECTOR((no_of_ports * addr_width) - 1 downto 0) ;
 rd : in  STD_LOGIC_VECTOR((no_of_ports * num_byte_enables) - 1 downto 0) ;
 iz : in  STD_LOGIC_VECTOR((no_of_ports * width) - 1 downto 0);
 az : out  STD_LOGIC_VECTOR((no_of_ports * addr_width) - 1 downto 0) ;
 rz : out  STD_LOGIC_VECTOR((no_of_ports * num_byte_enables) - 1 downto 0)
);
END COMPONENT;

COMPONENT mgc_out_ram_v1
generic
(
  ram_id            : integer;
  words             : integer;
  width             : integer;
  addr_width        : integer;
  we_active         : integer;
  num_byte_enables  : integer;
  no_of_ports       : integer
);
port
(
 id : in  STD_LOGIC_VECTOR((no_of_ports * width) - 1 downto 0);
 ad : in  STD_LOGIC_VECTOR((no_of_ports * addr_width) - 1 downto 0) ;
 rd : in  STD_LOGIC_VECTOR((no_of_ports * num_byte_enables) - 1 downto 0) ;
 iz : out  STD_LOGIC_VECTOR((no_of_ports * width) - 1 downto 0);
 az : out  STD_LOGIC_VECTOR((no_of_ports * addr_width) - 1 downto 0) ;
 rz : out  STD_LOGIC_VECTOR((no_of_ports * num_byte_enables) - 1 downto 0)
);
END COMPONENT;

COMPONENT mgc_inout_ram_v1
generic
(
  ram_id            : integer;
  words             : integer;
  width             : integer;
  addr_width        : integer;
  re_active         : integer;
  we_active         : integer;
  num_byte_enables  : integer;
  no_of_ports       : integer
);
port
(
 id  : out  STD_LOGIC_VECTOR((no_of_ports * width) - 1 downto 0);
 od  : in  STD_LOGIC_VECTOR((no_of_ports * width) - 1 downto 0);
 ad  : in  STD_LOGIC_VECTOR((no_of_ports * addr_width) - 1 downto 0) ;
 rd  : in  STD_LOGIC_VECTOR((no_of_ports * num_byte_enables) - 1 downto 0) ;
 wd  : in  STD_LOGIC_VECTOR((no_of_ports * num_byte_enables) - 1 downto 0) ;
 iz  : in  STD_LOGIC_VECTOR((no_of_ports * width) - 1 downto 0);
 oz  : out  STD_LOGIC_VECTOR((no_of_ports * width) - 1 downto 0);
 az  : out  STD_LOGIC_VECTOR((no_of_ports * addr_width) - 1 downto 0) ;
 rz  : out  STD_LOGIC_VECTOR((no_of_ports * num_byte_enables) - 1 downto 0);
 wz  : out  STD_LOGIC_VECTOR((no_of_ports * num_byte_enables) - 1 downto 0)
);
END COMPONENT;


COMPONENT funccall_inout_v1
generic
(
  ram_id           : integer;
  width           : integer;  -- models the concat of the return value (data)
  addr_width      : integer  -- models the concat of the input arguments (addr)
);
port
(
  d  : out  STD_LOGIC_VECTOR(width - 1 downto 0);
  ad : in  STD_LOGIC_VECTOR(addr_width - 1 downto 0) ;
  bd : in  STD_LOGIC;
  z  : in  STD_LOGIC_VECTOR(width - 1 downto 0);
  az : out  STD_LOGIC_VECTOR(addr_width - 1 downto 0) ;
  bz : out  STD_LOGIC
);
END COMPONENT;

END mgc_ioport_comps_v11;

--------> /softl3/catapultc10_0a/64bit/Mgc_home/pkgs/siflibs/mgc_io_sync_v1.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2015 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY mgc_io_sync_v1 IS
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    ld       : IN    std_logic;
    lz       : OUT   std_logic
  );
END mgc_io_sync_v1;

ARCHITECTURE beh OF mgc_io_sync_v1 IS
BEGIN

  lz <= ld;

END beh;


LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY mgc_in_sync_v1 IS
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    vd       : OUT   std_logic;
    vz       : IN    std_logic
  );
END mgc_in_sync_v1;

ARCHITECTURE beh OF mgc_in_sync_v1 IS
BEGIN

  vd <= vz;

END beh;



--------> /softl3/catapultc10_0a/64bit/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_comps.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;


USE work.funcs.all;

PACKAGE mgc_comps IS

COMPONENT mgc_not
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_and
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_nand
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_or
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_nor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_xor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_xnor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mux
  GENERIC (
    width  :  NATURAL;
    ctrlw  :  NATURAL;
    p2ctrlw : NATURAL := 0
  );
  PORT (
    a: in  std_logic_vector(width*(2**ctrlw) - 1 DOWNTO 0);
    c: in  std_logic_vector(ctrlw            - 1 DOWNTO 0);
    z: out std_logic_vector(width            - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mux1hot
  GENERIC (
    width  : NATURAL;
    ctrlw  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ctrlw - 1 DOWNTO 0);
    c: in  std_logic_vector(ctrlw       - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_reg_pos
  GENERIC (
    width  : NATURAL;
    has_a_rst : NATURAL;  -- 0 to 1
    a_rst_on  : NATURAL;  -- 0 to 1
    has_s_rst : NATURAL;  -- 0 to 1
    s_rst_on  : NATURAL;  -- 0 to 1
    has_enable : NATURAL; -- 0 to 1
    enable_on  : NATURAL  -- 0 to 1
  );
  PORT (
    clk: in  std_logic;
    d  : in  std_logic_vector(width-1 DOWNTO 0);
    z  : out std_logic_vector(width-1 DOWNTO 0);
    sync_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    sync_rst : in std_logic;
    async_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    async_rst : in std_logic;
    en : in std_logic
  );
END COMPONENT;

COMPONENT mgc_reg_neg
  GENERIC (
    width  : NATURAL;
    has_a_rst : NATURAL;  -- 0 to 1
    a_rst_on  : NATURAL;  -- 0 to 1
    has_s_rst : NATURAL;  -- 0 to 1
    s_rst_on  : NATURAL;   -- 0 to 1
    has_enable : NATURAL; -- 0 to 1
    enable_on  : NATURAL -- 0 to 1
  );
  PORT (
    clk: in  std_logic;
    d  : in  std_logic_vector(width-1 DOWNTO 0);
    z  : out std_logic_vector(width-1 DOWNTO 0);
    sync_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    sync_rst : in std_logic;
    async_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    async_rst : in std_logic;
    en : in std_logic
  );
END COMPONENT;

COMPONENT mgc_generic_reg
  GENERIC(
   width: natural := 8;
   ph_clk: integer range 0 to 1 := 1; -- clock polarity, 1=rising_edge
   ph_en: integer range 0 to 1 := 1;
   ph_a_rst: integer range 0 to 1 := 1;   --  0 to 1 IGNORED
   ph_s_rst: integer range 0 to 1 := 1;   --  0 to 1 IGNORED
   a_rst_used: integer range 0 to 1 := 1;
   s_rst_used: integer range 0 to 1 := 0;
   en_used: integer range 0 to 1 := 1
  );
  PORT(
   d: std_logic_vector(width-1 downto 0);
   clk: in std_logic;
   en: in std_logic;
   a_rst: in std_logic;
   s_rst: in std_logic;
   q: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_equal
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a : in  std_logic_vector(width-1 DOWNTO 0);
    b : in  std_logic_vector(width-1 DOWNTO 0);
    eq: out std_logic;
    ne: out std_logic
  );
END COMPONENT;

COMPONENT mgc_shift_l
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_r
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_bl
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_br
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_rot
  GENERIC (
    width  : NATURAL;
    width_s: NATURAL;
    signd_s: NATURAL;      -- 0:unsigned 1:signed
    sleft  : NATURAL;      -- 0:right 1:left;
    log2w  : NATURAL := 0; -- LOG2(width)
    l2wp2  : NATURAL := 0  --2**LOG2(width)
  );
  PORT (
    a : in  std_logic_vector(width  -1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width  -1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_sub
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add_ci
  GENERIC (
    width_a : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width_a, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width_a, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width_a,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width_a,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_addc
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_sub_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_addc_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     c: in std_logic_vector(0 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_addsub
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    add: in  std_logic;
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_accu
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_abs
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_z : NATURAL    -- <= width_a + width_b
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul_fast
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_z : NATURAL    -- <= width_a + width_b
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul_pipe
  GENERIC (
    width_a       : NATURAL;
    signd_a       : NATURAL;
    width_b       : NATURAL;
    signd_b       : NATURAL;
    width_z       : NATURAL; -- <= width_a + width_b
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 

  );
  PORT (
    a     : in  std_logic_vector(width_a-1 DOWNTO 0);
    b     : in  std_logic_vector(width_b-1 DOWNTO 0);
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic;
    s_rst : in  std_logic;
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_div
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_a-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mod
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_b-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_rem
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_b-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_csa
  GENERIC (
     width : NATURAL
  );
  PORT (
     a: in std_logic_vector(width-1 downto 0);
     b: in std_logic_vector(width-1 downto 0);
     c: in std_logic_vector(width-1 downto 0);
     s: out std_logic_vector(width-1 downto 0);
     cout: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_csha
  GENERIC (
     width : NATURAL
  );
  PORT (
     a: in std_logic_vector(width-1 downto 0);
     b: in std_logic_vector(width-1 downto 0);
     s: out std_logic_vector(width-1 downto 0);
     cout: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_rom
    GENERIC (
      rom_id : natural := 1;
      size : natural := 33;
      width : natural := 32
      );
    PORT (
      data_in : std_logic_vector((size*width)-1 downto 0);
      addr : std_logic_vector(ceil_log2(size)-1 downto 0);
      data_out : out std_logic_vector(width-1 downto 0)
    );
END COMPONENT;

END mgc_comps;

--------> /softl3/catapultc10_0a/64bit/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_generic_reg_beh.vhd 
LIBRARY ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity mgc_generic_reg is
  GENERIC(
   width: natural := 8;
   ph_clk: integer range 0 to 1 := 1; -- clock polarity, 1=rising_edge
   ph_en: integer range 0 to 1 := 1;
   ph_a_rst: integer range 0 to 1 := 1;   --  0 to 1 IGNORED
   ph_s_rst: integer range 0 to 1 := 1;   --  0 to 1 IGNORED
   a_rst_used: integer range 0 to 1 := 1;
   s_rst_used: integer range 0 to 1 := 0;
   en_used: integer range 0 to 1 := 1
  );
  PORT(
   d: std_logic_vector(width-1 downto 0);
   clk: in std_logic;
   en: in std_logic;
   a_rst: in std_logic;
   s_rst: in std_logic;
   q: out std_logic_vector(width-1 downto 0)
  );
end mgc_generic_reg;

architecture rtl of mgc_generic_reg is
begin
    BLK_S_RST_USED: if s_rst_used = 1 generate
      BLK_CLK_POS: if ph_clk = 1 generate
        process(a_rst, clk)
        begin
          IF conv_integer(a_rst) = ph_a_rst THEN
            q <= (others => '0');
          ELSIF (clk'event and clk = '1') then
            IF conv_integer(s_rst) = ph_s_rst then
              q <= (others => '0');
            ELSIF conv_integer(en) = ph_en then
              q <= d;
            end if;
          end if;
        end process;
      end generate BLK_CLK_POS;
      BLK_CLK_NEG: if ph_clk = 0 generate
        process(a_rst, clk)
        begin
          IF conv_integer(a_rst) = ph_a_rst THEN
            q <= (others => '0');
          ELSIF (clk'event and clk = '0') then
            IF conv_integer(s_rst) = ph_s_rst then
              q <= (others => '0');
            ELSIF conv_integer(en) = ph_en then
              q <= d;
            end if;
          end if;
        end process;
      end generate BLK_CLK_NEG;
    end generate BLK_S_RST_USED;
    
    BLK_S_RST_NOT_USED: if s_rst_used = 0 generate
      BLK_CLK_POS: if ph_clk = 1 generate
        process(a_rst, clk)
        begin
          IF conv_integer(a_rst) = ph_a_rst THEN
            q <= (others => '0');
          ELSIF (clk'event and clk = '1') then
            IF conv_integer(en) = ph_en then
              q <= d;
            end if;
          end if;
        end process;
      end generate BLK_CLK_POS;
      BLK_CLK_NEG: if ph_clk = 0 generate
        process(a_rst, clk)
        begin
          IF conv_integer(a_rst) = ph_a_rst THEN
            q <= (others => '0');
          ELSIF (clk'event and clk = '0') then
            IF conv_integer(en) = ph_en then
              q <= d;
            end if;
          end if;
        end process;
      end generate BLK_CLK_NEG;
    end generate BLK_S_RST_NOT_USED;
end rtl;

--------> /softl3/catapultc10_0a/64bit/Mgc_home/pkgs/siflibs/ram_dualport_be_fpga.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2015 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE IEEE.std_logic_1164.ALL ;
USE IEEE.std_logic_arith.ALL ;

PACKAGE dualport_ram_be_pkg IS

  COMPONENT dualport_ram_be
   GENERIC (ram_id           : integer;
            words            : integer;
            width            : integer;
            addr_width       : integer;
            a_reset_active   : integer;
            s_reset_active   : integer;
            enable_active    : integer;
            re_active        : integer;
            we_active        : integer;
            num_byte_enables : integer;
            clock_edge       : integer;
            num_input_registers          : integer;
            num_output_registers         : integer;
            no_of_dualport_readwrite_port  : integer
           );
     PORT (
           data_in    : IN  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 DOWNTO 0) ;
           addr       : IN  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * addr_width) - 1 DOWNTO 0) ;
           re         : IN  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 DOWNTO 0);
           we         : IN  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 DOWNTO 0);
           data_out   : OUT STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 DOWNTO 0);
           clk        : IN  std_logic;
           a_rst      : IN std_logic;
           s_rst      : IN std_logic;
           en         : IN std_logic
          );
  end component;
  component dualport_ram_be_port is
   generic (ram_id           : integer := 1;
            words            : integer := 256;
            width            : integer := 8;
            addr_width       : integer := 8;
            a_reset_active   : integer := 0;
            s_reset_active   : integer := 1;
            enable_active    : integer := 1;
            re_active        : integer := 1;
            we_active        : integer := 1;
            num_byte_enables : integer := 2;
            clock_edge       : integer := 1;
            num_input_registers          : integer := 1;
            num_output_registers         : integer := 0;
            no_of_dualport_readwrite_port  : integer := 2
     );
     port (
           data_in_d  : in  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 downto 0) ;
           addr_d     : in  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * addr_width) - 1 downto 0) ;
           re_d       : in  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 downto 0);
           we_d       : in  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 downto 0);
           data_out_d : out STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 downto 0);
           data_in    : out  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 downto 0) ;
           addr       : out  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * addr_width) - 1 downto 0) ;
           re         : out  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 downto 0);
           we         : out  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 downto 0);
           data_out   : in STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 downto 0);
           clk        : in  std_logic;
           a_rst      : in std_logic;
           s_rst      : in  std_logic;
           en         : in std_logic
          );
  end component;

end dualport_ram_be_pkg;

LIBRARY ieee;

USE IEEE.std_logic_1164.ALL ;
USE IEEE.std_logic_arith.ALL ;
USE IEEE.std_logic_unsigned.ALL ;

USE work.dualport_ram_be_pkg.ALL;


  ENTITY dualport_ram_be IS
   GENERIC (ram_id           : integer := 1;
            words            : integer := 256;
            width            : integer := 8;
            addr_width       : integer := 8;
            a_reset_active   : integer := 0;
            s_reset_active   : integer := 1;
            enable_active    : integer := 1;
            re_active        : integer := 1;
            we_active        : integer := 1;
            num_byte_enables : integer := 2;
            clock_edge       : integer := 1;
            num_input_registers          : integer := 1;
            num_output_registers         : integer := 0;
            no_of_dualport_readwrite_port  : integer := 2
     );
     PORT (
           data_in    : IN  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 DOWNTO 0) ;
           addr       : IN  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * addr_width) - 1 DOWNTO 0) ;
           re         : IN  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 DOWNTO 0);
           we         : IN  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 DOWNTO 0);
           data_out   : OUT STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 DOWNTO 0);
           clk        : IN  std_logic;
           a_rst      : IN std_logic;
           s_rst      : IN  std_logic;
           en         : IN std_logic
          );
  END dualport_ram_be ;
  
  ARCHITECTURE rtl OF dualport_ram_be IS
    TYPE mem_type IS ARRAY ((words)-1 DOWNTO 0) OF
                        STD_LOGIC_VECTOR(width - 1 DOWNTO 0) ;
    SIGNAL mem : mem_type ;
    SIGNAL data_ina  : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
    SIGNAL data_inb  : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
    SIGNAL rea       : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);
    SIGNAL reb       : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);
    SIGNAL wea       : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);
    SIGNAL web       : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);
    SIGNAL addra     : STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);
    SIGNAL addrb     : STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);

    TYPE d_array IS ARRAY (integer RANGE <>) OF STD_LOGIC_VECTOR(width-1 DOWNTO 0);
    TYPE addr_array IS ARRAY (integer RANGE <>) OF STD_LOGIC_VECTOR(addr_width-1 DOWNTO 0);
    TYPE en_array IS ARRAY (integer RANGE <>) OF STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);

    SIGNAL data_outa : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
    SIGNAL data_outb : STD_LOGIC_VECTOR(width-1 DOWNTO 0);

    SIGNAL data_outa_f : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
    SIGNAL data_outb_f : STD_LOGIC_VECTOR(width-1 DOWNTO 0);

    SIGNAL data_ina_f  : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
    SIGNAL data_inb_f  : STD_LOGIC_VECTOR(width-1 DOWNTO 0);

    SIGNAL addra_f     : STD_LOGIC_VECTOR(addr_width-1 DOWNTO 0);
    SIGNAL addrb_f     : STD_LOGIC_VECTOR(addr_width-1 DOWNTO 0);

    SIGNAL addra_reg   : STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);
    SIGNAL addrb_reg   : STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);

    SIGNAL rea_reg     : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);
    SIGNAL reb_reg     : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);

    SIGNAL rea_f       : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);
    SIGNAL reb_f       : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);

    SIGNAL wea_f       : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);
    SIGNAL web_f       : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);

    CONSTANT byte_width : integer := width / num_byte_enables;
    CONSTANT clock_edge_stdlogic : STD_LOGIC := conv_std_logic_vector(clock_edge,1)(0);

    FUNCTION cmp_ulogic_int(arg1 : STD_ULOGIC; arg2 : INTEGER) RETURN BOOLEAN IS
    BEGIN
      CASE arg2 IS
        WHEN 1 => RETURN arg1 = '1' OR arg1 = 'H';
        WHEN 0 => RETURN arg1 = '0' OR arg1 = 'L';
        WHEN OTHERS => ASSERT false
                       REPORT "Invalid value for phase"
                       SEVERITY FAILURE;
                         RETURN false;
      END CASE;
    END cmp_ulogic_int;

  BEGIN

    -- Split input busses for the 2 ports
    addra <= addr((2 * addr_width) - 1 DOWNTO addr_width);
    addrb <= addr(addr_width - 1 DOWNTO 0);
    data_ina <= data_in((2*width) - 1 DOWNTO width);
    data_inb <= data_in(width - 1 DOWNTO 0);

    rea <= re(1*num_byte_enables + num_byte_enables - 1 DOWNTO 1*num_byte_enables);
    reb <= re(0*num_byte_enables + num_byte_enables - 1 DOWNTO 0*num_byte_enables);
    wea <= we(1*num_byte_enables + num_byte_enables - 1 DOWNTO 1*num_byte_enables);
    web <= we(0*num_byte_enables + num_byte_enables - 1 DOWNTO 0*num_byte_enables);

    N_INREG_GT_1 : IF (num_input_registers > 1) GENERATE
     SIGNAL data_ina_inreg: d_array(num_input_registers-2 DOWNTO 0);
     SIGNAL data_inb_inreg: d_array(num_input_registers-2 DOWNTO 0);
     SIGNAL addra_inreg: addr_array(num_input_registers-2 DOWNTO 0);
     SIGNAL addrb_inreg: addr_array(num_input_registers-2 DOWNTO 0);
     SIGNAL rea_inreg : en_array(num_input_registers-2 DOWNTO 0);
     SIGNAL reb_inreg : en_array(num_input_registers-2 DOWNTO 0);
     SIGNAL wea_inreg : en_array(num_input_registers-2 DOWNTO 0);
     SIGNAL web_inreg : en_array(num_input_registers-2 DOWNTO 0);
 
     CONSTANT PWR: integer RANGE 0 TO 1 := 1;
     CONSTANT GND: integer RANGE 0 TO 1 := 0;
     CONSTANT GND_sig: std_logic := '0';
    BEGIN
      pipe: FOR i_in IN num_input_registers - 3 DOWNTO 0 GENERATE
        i_data_ina_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (data_ina_inreg(i_in), clk, en, a_rst, s_rst, data_ina_inreg(i_in+1));
        i_data_inb_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (data_inb_inreg(i_in), clk, en, a_rst, s_rst, data_inb_inreg(i_in+1));
        i_addra_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (addr_width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (addra_inreg(i_in), clk, en, a_rst, s_rst, addra_inreg(i_in+1));
        i_addrb_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (addr_width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (addrb_inreg(i_in), clk, en, a_rst, s_rst, addrb_inreg(i_in+1));
        i_rea_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (rea_inreg(i_in), clk, en, a_rst, s_rst, rea_inreg(i_in+1));
        i_reb_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (reb_inreg(i_in), clk, en, a_rst, s_rst, reb_inreg(i_in+1));
        i_wea_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (wea_inreg(i_in), clk, en, a_rst, s_rst, wea_inreg(i_in+1));
        i_web_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (web_inreg(i_in), clk, en, a_rst, s_rst, web_inreg(i_in+1));
      END GENERATE pipe;
                                                                                                                                                                                                      
      i_data_ina_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (data_ina, clk, en, a_rst, s_rst, data_ina_inreg(0));
      i_data_inb_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (data_inb, clk, en, a_rst, s_rst, data_inb_inreg(0));
      i_addra_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (addr_width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (addra, clk, en, a_rst, s_rst, addra_inreg(0));
      i_addrb_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (addr_width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (addrb, clk, en, a_rst, s_rst, addrb_inreg(0));
      i_rea_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (rea, clk, en, a_rst, s_rst, rea_inreg(0));
      i_reb_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (reb, clk, en, a_rst, s_rst, reb_inreg(0));
      i_wea_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (wea, clk, en, a_rst, s_rst, wea_inreg(0));
      i_web_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (web, clk, en, a_rst, s_rst, web_inreg(0));


      data_ina_f <= data_ina_inreg(num_input_registers-2);
      data_inb_f <= data_inb_inreg(num_input_registers-2);
      addra_f <= addra_inreg(num_input_registers-2);
      addrb_f <= addrb_inreg(num_input_registers-2);
      rea_f <= rea_inreg(num_input_registers-2);
      reb_f <= reb_inreg(num_input_registers-2);
      wea_f <= wea_inreg(num_input_registers-2);
      web_f <= web_inreg(num_input_registers-2);

    END GENERATE N_INREG_GT_1;

    INREG_EQ_1: IF num_input_registers = 1 GENERATE
      data_ina_f <= data_ina;
      data_inb_f <= data_inb;
      addra_f <= addra;
      addrb_f <= addrb;
      rea_f <= rea;
      reb_f <= reb;
      wea_f <= wea;
      web_f <= web;
    END GENERATE INREG_EQ_1;

    --pragma translate_off
    CHECK_ADDR_DONTCARE: PROCESS(clk)
    BEGIN
      IF ( clk'event AND clk = clock_edge_stdlogic ) THEN
        IF cmp_ulogic_int(en, enable_active) THEN
          
          FOR i IN 0 TO addr_width-1 LOOP
            IF (addra_f(i) = 'X' or addra_f(i) = 'Z') THEN              
              FOR j IN 0 TO num_byte_enables - 1 LOOP
                ASSERT cmp_ulogic_int(wea_f(j), we_active) = false
                  REPORT "Error: Dont-care address for pipelined dualport memory-write on port A"
                  SEVERITY FAILURE;

                ASSERT cmp_ulogic_int(rea_f(j), re_active) = false
                  REPORT "Error: Dont-care or High-Impedance address for pipelined dualport memory-read on port A"
                  SEVERITY FAILURE;				  
              END LOOP;
            END IF;
          END LOOP;
		  
          FOR i IN 0 TO addr_width-1 LOOP
            IF (addrb_f(i) = 'X' or addrb_f(i) = 'Z') THEN              
              FOR j IN 0 TO num_byte_enables - 1 LOOP
                ASSERT cmp_ulogic_int(web_f(j), we_active) = false
                  REPORT "Error: Dont-care address for pipelined dualport memory-write on port B"
                  SEVERITY FAILURE;
				  
                ASSERT cmp_ulogic_int(reb_f(j), re_active) = false
                  REPORT "Error: Dont-care or High-Impedance address for pipelined dualport memory-read on port B"
                  SEVERITY FAILURE;  
              END LOOP;
            END IF;
          END LOOP;
		  
        END IF;
      END IF;
      
      
    END PROCESS;
    --pragma translate_on
	
    MW : PROCESS (clk)
    VARIABLE addra_int : integer;           
    VARIABLE addrb_int : integer;           
    BEGIN
      IF ( clk'event AND clk = clock_edge_stdlogic ) THEN
        IF cmp_ulogic_int(en, enable_active) THEN
          
          addra_reg <= addra_f;
          rea_reg   <= rea_f;
            addra_int := conv_integer(addra_f);
          IF (addra_int < words AND addra_int >= 0) THEN
            FOR i IN 0 TO num_byte_enables - 1 LOOP
              IF cmp_ulogic_int(wea_f(i), we_active) THEN
                mem(addra_int)(i*byte_width + byte_width - 1 DOWNTO i*byte_width) <= data_ina_f(i*byte_width + byte_width - 1 DOWNTO i*byte_width);
              END IF;
            END LOOP;
          ELSE
            FOR i IN 0 TO num_byte_enables - 1 LOOP
                ASSERT cmp_ulogic_int(wea_f(i), we_active) = false
                  REPORT "Error: Out-of-bound pipelined dualport memory-write on port A"
                  SEVERITY FAILURE;
            END LOOP;
          END IF;
  
          addrb_reg <= addrb_f;
          reb_reg   <= reb_f;
            addrb_int := conv_integer(addrb_f);
          IF (addrb_int < words AND addrb_int >= 0) THEN
            FOR i IN 0 TO num_byte_enables - 1 LOOP
              IF cmp_ulogic_int(web_f(i), we_active) THEN
                mem(addrb_int)(i*byte_width + byte_width - 1 DOWNTO i*byte_width) <= data_inb_f(i*byte_width + byte_width - 1 DOWNTO i*byte_width);
              END IF;
            END LOOP;
          ELSE
            FOR i IN 0 TO num_byte_enables - 1 LOOP
                ASSERT cmp_ulogic_int(web_f(i), we_active) = false
                  REPORT "Error: Out-of-bound pipelined dualport memory-write on port B"
                  SEVERITY FAILURE;
            END LOOP;
          END IF;          

        END IF;
      END IF;
    END PROCESS;


    MR_A: PROCESS(mem, addra_reg, rea_reg)        
    VARIABLE addra_int: integer;
    BEGIN      
        addra_int := conv_integer(addra_reg);
      IF (addra_int < words AND addra_int >= 0) THEN
          -- data_outa_f <= mem(addra_int);
        FOR k IN 0 TO num_byte_enables - 1 LOOP
          IF cmp_ulogic_int(rea_reg(k), re_active) THEN
            data_outa_f(k*byte_width + byte_width - 1 DOWNTO k*byte_width) <= mem(addra_int)(k*byte_width + byte_width - 1 DOWNTO k*byte_width);
          ELSE
            data_outa_f(k*byte_width + byte_width - 1 DOWNTO k*byte_width) <= (OTHERS => 'X');
          END IF;
        END LOOP;
      ELSE
        data_outa_f <= (OTHERS => 'X');
      END IF;
    END PROCESS;

    MR_B: PROCESS(mem , addrb_reg, reb_reg)        
		VARIABLE addrb_int: integer;
    BEGIN      
        addrb_int := conv_integer(addrb_reg);
        IF (addrb_int < words AND addrb_int >= 0) THEN
          -- data_outb_f <= mem(addrb_int);
			FOR l IN 0 TO num_byte_enables - 1 LOOP
				IF cmp_ulogic_int(reb_reg(l), re_active) THEN
					data_outb_f(l*byte_width + byte_width - 1 DOWNTO l*byte_width) <= mem(addrb_int)(l*byte_width + byte_width - 1 DOWNTO l*byte_width);
				ELSE
					data_outb_f(l*byte_width + byte_width - 1 DOWNTO l*byte_width) <= (OTHERS => 'X');
				END IF;
			END LOOP;
        ELSE
			data_outb_f <= (OTHERS => 'X');
        END IF;
    END PROCESS;


    -- REGISTER BANKS at the output
    N_OUTREG_GT_0: IF num_output_registers > 0 GENERATE
     SIGNAL data_outa_outreg: d_array(num_output_registers-1 DOWNTO 0);
     SIGNAL data_outb_outreg: d_array(num_output_registers-1 DOWNTO 0);
 
     CONSTANT PWR: integer RANGE 0 TO 1 := 1;
     CONSTANT GND: integer RANGE 0 TO 1 := 0;
     CONSTANT GND_sig: std_logic := '0';
    BEGIN
      N_OUTREG_SHIFT: FOR i_out IN num_output_registers - 2 DOWNTO 0 GENERATE
      BEGIN
        i_data_outa_outreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (data_outa_outreg(i_out), clk, en, a_rst, s_rst, data_outa_outreg(i_out+1));
        i_data_outb_outreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (data_outb_outreg(i_out), clk, en, a_rst, s_rst, data_outb_outreg(i_out+1));
      END GENERATE N_OUTREG_SHIFT;

      i_data_outa_outreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (data_outa_f, clk, en, a_rst, s_rst, data_outa_outreg(0));
      i_data_outb_outreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (data_outb_f, clk, en, a_rst, s_rst, data_outb_outreg(0));

      data_outa <= data_outa_outreg(num_output_registers-1);
      data_outb <= data_outb_outreg(num_output_registers-1);

    END GENERATE N_OUTREG_GT_0;

    N_OUTREG_EQ_0: IF num_output_registers = 0 GENERATE
      data_outa <= data_outa_f;
      data_outb <= data_outb_f;
    END GENERATE N_OUTREG_EQ_0;

    data_out <= data_outa & data_outb;

  END RTL ;

LIBRARY ieee;

use IEEE.std_logic_1164.all ;
use IEEE.std_logic_arith.all ;
use IEEE.std_logic_unsigned.all ;

USE work.dualport_ram_be_pkg.all;

  entity dualport_ram_be_port is
   generic (ram_id           : integer := 1;
            words            : integer := 256;
            width            : integer := 8;
            addr_width       : integer := 8;
            a_reset_active   : integer := 0;
            s_reset_active   : integer := 1;
            enable_active    : integer := 1;
            re_active        : integer := 1;
            we_active        : integer := 1;
            num_byte_enables : integer := 2;
            clock_edge       : integer := 1;
            num_input_registers          : integer := 1;
            num_output_registers         : integer := 0;
            no_of_dualport_readwrite_port  : integer := 2
     );
     port (
           data_in_d  : in  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 downto 0) ;
           addr_d     : in  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * addr_width) - 1 downto 0) ;
           re_d       : in  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 downto 0);
           we_d       : in  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 downto 0);
           data_out_d : out STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 downto 0);
           data_in    : out  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 downto 0) ;
           addr       : out  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * addr_width) - 1 downto 0) ;
           re         : out  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 downto 0);
           we         : out  STD_LOGIC_VECTOR((no_of_dualport_readwrite_port*num_byte_enables) - 1 downto 0);
           data_out   : in STD_LOGIC_VECTOR((no_of_dualport_readwrite_port * width) - 1 downto 0);
           clk        : in  std_logic;
           a_rst      : in std_logic;
           s_rst      : in  std_logic;
           en         : in std_logic
          );
  end dualport_ram_be_port ;

  architecture rtl of dualport_ram_be_port is
  begin
    data_in     <= data_in_d;
    addr        <= addr_d;
    re          <= re_d;
    we          <= we_d;
    data_out_d  <= data_out;
  end rtl;

--------> ./rtl.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    10.0a/269363 Production Release
--  HLS Date:       Wed Nov  9 17:38:00 PST 2016
-- 
--  Generated by:   xph3sei714@cimeld95
--  Generated date: Fri Feb  9 15:33:02 2018
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_10_576_15_10_0_1_0_0_0_1_1_1_0_576_15_2_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.dualport_ram_be_pkg.ALL;


ENTITY ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_10_576_15_10_0_1_0_0_0_1_1_1_0_576_15_2_gen
    IS
  PORT(
    en : OUT STD_LOGIC;
    data_out : IN STD_LOGIC_VECTOR (29 DOWNTO 0);
    we : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    addr : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
    data_in : OUT STD_LOGIC_VECTOR (29 DOWNTO 0);
    data_in_d : IN STD_LOGIC_VECTOR (29 DOWNTO 0);
    addr_d : IN STD_LOGIC_VECTOR (19 DOWNTO 0);
    re_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    we_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    data_out_d : OUT STD_LOGIC_VECTOR (29 DOWNTO 0);
    en_d : IN STD_LOGIC
  );
END ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_10_576_15_10_0_1_0_0_0_1_1_1_0_576_15_2_gen;

ARCHITECTURE v2 OF ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_10_576_15_10_0_1_0_0_0_1_1_1_0_576_15_2_gen
    IS
  -- Default Constants

BEGIN
  -- Default Constant Signal Assignments

  en <= en_d;
  data_out_d <= data_out;
  we <= we_d;
  re <= re_d;
  addr <= addr_d;
  data_in <= data_in_d;
END v2;

-- ------------------------------------------------------------------
--  Design Unit:    ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_6_676_8_10_0_1_0_0_0_1_1_1_0_676_8_2_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.dualport_ram_be_pkg.ALL;


ENTITY ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_6_676_8_10_0_1_0_0_0_1_1_1_0_676_8_2_gen
    IS
  PORT(
    en : OUT STD_LOGIC;
    data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    we : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    addr : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
    data_in : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    data_in_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    addr_d : IN STD_LOGIC_VECTOR (19 DOWNTO 0);
    re_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    we_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    data_out_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    en_d : IN STD_LOGIC
  );
END ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_6_676_8_10_0_1_0_0_0_1_1_1_0_676_8_2_gen;

ARCHITECTURE v2 OF ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_6_676_8_10_0_1_0_0_0_1_1_1_0_676_8_2_gen
    IS
  -- Default Constants

BEGIN
  -- Default Constant Signal Assignments

  en <= en_d;
  data_out_d <= data_out;
  we <= we_d;
  re <= re_d;
  addr <= addr_d;
  data_in <= data_in_d;
END v2;

-- ------------------------------------------------------------------
--  Design Unit:    ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_4_64_8_6_0_1_0_0_0_1_1_1_0_64_8_2_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.dualport_ram_be_pkg.ALL;


ENTITY ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_4_64_8_6_0_1_0_0_0_1_1_1_0_64_8_2_gen
    IS
  PORT(
    data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    addr : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    addr_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    re_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    data_out_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
  );
END ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_4_64_8_6_0_1_0_0_0_1_1_1_0_64_8_2_gen;

ARCHITECTURE v2 OF ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_4_64_8_6_0_1_0_0_0_1_1_1_0_64_8_2_gen
    IS
  -- Default Constants

BEGIN
  -- Default Constant Signal Assignments

  data_out_d <= data_out;
  re <= re_d;
  addr <= addr_d;
END v2;

-- ------------------------------------------------------------------
--  Design Unit:    ram_Xilinx_ARTIX_7_1_RAMDB_dualport_wport_3_36864_12_16_0_1_0_0_0_1_1_1_0_36864_12_2_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.dualport_ram_be_pkg.ALL;


ENTITY ram_Xilinx_ARTIX_7_1_RAMDB_dualport_wport_3_36864_12_16_0_1_0_0_0_1_1_1_0_36864_12_2_gen
    IS
  PORT(
    we : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    addr : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    data_in : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
    data_in_d : IN STD_LOGIC_VECTOR (23 DOWNTO 0);
    addr_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    we_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0)
  );
END ram_Xilinx_ARTIX_7_1_RAMDB_dualport_wport_3_36864_12_16_0_1_0_0_0_1_1_1_0_36864_12_2_gen;

ARCHITECTURE v2 OF ram_Xilinx_ARTIX_7_1_RAMDB_dualport_wport_3_36864_12_16_0_1_0_0_0_1_1_1_0_36864_12_2_gen
    IS
  -- Default Constants

BEGIN
  -- Default Constant Signal Assignments

  we <= we_d;
  addr <= addr_d;
  data_in <= data_in_d;
END v2;

-- ------------------------------------------------------------------
--  Design Unit:    ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_2_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.dualport_ram_be_pkg.ALL;


ENTITY ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_2_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen
    IS
  PORT(
    data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    addr : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
    addr_d : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
    re_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    data_out_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
  );
END ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_2_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen;

ARCHITECTURE v2 OF ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_2_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen
    IS
  -- Default Constants

BEGIN
  -- Default Constant Signal Assignments

  data_out_d <= data_out;
  re <= re_d;
  addr <= addr_d;
END v2;

-- ------------------------------------------------------------------
--  Design Unit:    ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_1_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.dualport_ram_be_pkg.ALL;


ENTITY ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_1_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen
    IS
  PORT(
    data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    addr : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
    addr_d : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
    re_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    data_out_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
  );
END ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_1_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen;

ARCHITECTURE v2 OF ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_1_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen
    IS
  -- Default Constants

BEGIN
  -- Default Constant Signal Assignments

  data_out_d <= data_out;
  re <= re_d;
  addr <= addr_d;
END v2;

-- ------------------------------------------------------------------
--  Design Unit:    convolution3D_HW_core_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.dualport_ram_be_pkg.ALL;


ENTITY convolution3D_HW_core_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    imgPadded_vinit_C_1_tr0 : IN STD_LOGIC;
    FILL_PADDED_IMG_MAIN_LOOP_C_0_tr0 : IN STD_LOGIC;
    CONV2D_COLUMN_LOOP_C_1_tr0 : IN STD_LOGIC;
    CONV2D_MAIN_LOOP_C_4_tr0 : IN STD_LOGIC;
    CONV3D_CHANNEL_IN_LOOP_C_1_tr0 : IN STD_LOGIC;
    CONV3D_MAIN_LOOP_C_0_tr0 : IN STD_LOGIC
  );
END convolution3D_HW_core_core_fsm;

ARCHITECTURE v2 OF convolution3D_HW_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for convolution3D_HW_core_core_fsm_1
  TYPE convolution3D_HW_core_core_fsm_1_ST IS (core_rlp_C_0, imgPadded_vinit_C_0,
      imgPadded_vinit_C_1, main_C_0, FILL_PADDED_IMG_MAIN_LOOP_C_0, CONV3D_CHANNEL_IN_LOOP_C_0,
      CONV2D_MAIN_LOOP_C_0, CONV2D_MAIN_LOOP_C_1, CONV2D_MAIN_LOOP_C_2, CONV2D_MAIN_LOOP_C_3,
      CONV2D_COLUMN_LOOP_C_0, CONV2D_COLUMN_LOOP_C_1, CONV2D_MAIN_LOOP_C_4, CONV3D_CHANNEL_IN_LOOP_C_1,
      CONV3D_MAIN_LOOP_C_0, main_C_1);

  SIGNAL state_var : convolution3D_HW_core_core_fsm_1_ST;
  SIGNAL state_var_NS : convolution3D_HW_core_core_fsm_1_ST;

BEGIN
  -- Default Constant Signal Assignments

  convolution3D_HW_core_core_fsm_1 : PROCESS (imgPadded_vinit_C_1_tr0, FILL_PADDED_IMG_MAIN_LOOP_C_0_tr0,
      CONV2D_COLUMN_LOOP_C_1_tr0, CONV2D_MAIN_LOOP_C_4_tr0, CONV3D_CHANNEL_IN_LOOP_C_1_tr0,
      CONV3D_MAIN_LOOP_C_0_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN imgPadded_vinit_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000010");
        state_var_NS <= imgPadded_vinit_C_1;
      WHEN imgPadded_vinit_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000100");
        IF ( imgPadded_vinit_C_1_tr0 = '1' ) THEN
          state_var_NS <= imgPadded_vinit_C_0;
        ELSE
          state_var_NS <= main_C_0;
        END IF;
      WHEN main_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000001000");
        state_var_NS <= FILL_PADDED_IMG_MAIN_LOOP_C_0;
      WHEN FILL_PADDED_IMG_MAIN_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000010000");
        IF ( FILL_PADDED_IMG_MAIN_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= CONV3D_CHANNEL_IN_LOOP_C_0;
        ELSE
          state_var_NS <= FILL_PADDED_IMG_MAIN_LOOP_C_0;
        END IF;
      WHEN CONV3D_CHANNEL_IN_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000100000");
        state_var_NS <= CONV2D_MAIN_LOOP_C_0;
      WHEN CONV2D_MAIN_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000001000000");
        state_var_NS <= CONV2D_MAIN_LOOP_C_1;
      WHEN CONV2D_MAIN_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000010000000");
        state_var_NS <= CONV2D_MAIN_LOOP_C_2;
      WHEN CONV2D_MAIN_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000100000000");
        state_var_NS <= CONV2D_MAIN_LOOP_C_3;
      WHEN CONV2D_MAIN_LOOP_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001000000000");
        state_var_NS <= CONV2D_COLUMN_LOOP_C_0;
      WHEN CONV2D_COLUMN_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010000000000");
        state_var_NS <= CONV2D_COLUMN_LOOP_C_1;
      WHEN CONV2D_COLUMN_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100000000000");
        IF ( CONV2D_COLUMN_LOOP_C_1_tr0 = '1' ) THEN
          state_var_NS <= CONV2D_MAIN_LOOP_C_4;
        ELSE
          state_var_NS <= CONV2D_COLUMN_LOOP_C_0;
        END IF;
      WHEN CONV2D_MAIN_LOOP_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000000000000");
        IF ( CONV2D_MAIN_LOOP_C_4_tr0 = '1' ) THEN
          state_var_NS <= CONV3D_CHANNEL_IN_LOOP_C_1;
        ELSE
          state_var_NS <= CONV2D_MAIN_LOOP_C_0;
        END IF;
      WHEN CONV3D_CHANNEL_IN_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000000000000");
        IF ( CONV3D_CHANNEL_IN_LOOP_C_1_tr0 = '1' ) THEN
          state_var_NS <= CONV3D_MAIN_LOOP_C_0;
        ELSE
          state_var_NS <= FILL_PADDED_IMG_MAIN_LOOP_C_0;
        END IF;
      WHEN CONV3D_MAIN_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000000000000");
        IF ( CONV3D_MAIN_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= FILL_PADDED_IMG_MAIN_LOOP_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000000000000");
        state_var_NS <= main_C_0;
      -- core_rlp_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000001");
        state_var_NS <= imgPadded_vinit_C_0;
    END CASE;
  END PROCESS convolution3D_HW_core_core_fsm_1;

  convolution3D_HW_core_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= core_rlp_C_0;
      ELSE
        state_var <= state_var_NS;
      END IF;
    END IF;
  END PROCESS convolution3D_HW_core_core_fsm_1_REG;

END v2;

-- ------------------------------------------------------------------
--  Design Unit:    convolution3D_HW_core
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.dualport_ram_be_pkg.ALL;


ENTITY convolution3D_HW_core IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    kernel_rsc_triosy_lz : OUT STD_LOGIC;
    imgIn_rsc_triosy_lz : OUT STD_LOGIC;
    imgOut_rsc_triosy_lz : OUT STD_LOGIC;
    bias_rsc_triosy_lz : OUT STD_LOGIC;
    kernel_rsci_addr_d : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
    kernel_rsci_re_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    kernel_rsci_data_out_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    imgIn_rsci_addr_d : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
    imgIn_rsci_re_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    imgIn_rsci_data_out_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    imgOut_rsci_data_in_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    imgOut_rsci_addr_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    imgOut_rsci_we_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    bias_rsci_addr_d : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
    bias_rsci_re_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    bias_rsci_data_out_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    imgPadded_rsci_data_in_d : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    imgPadded_rsci_addr_d : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
    imgPadded_rsci_re_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    imgPadded_rsci_we_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    imgPadded_rsci_data_out_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d : OUT STD_LOGIC_VECTOR (14
        DOWNTO 0);
    convolution2D_HW_simple_imgConv2DOut_rsci_addr_d : OUT STD_LOGIC_VECTOR (9 DOWNTO
        0);
    convolution2D_HW_simple_imgConv2DOut_rsci_re_d : OUT STD_LOGIC_VECTOR (1 DOWNTO
        0);
    convolution2D_HW_simple_imgConv2DOut_rsci_we_d : OUT STD_LOGIC_VECTOR (1 DOWNTO
        0);
    convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d : IN STD_LOGIC_VECTOR (29
        DOWNTO 0)
  );
END convolution3D_HW_core;

ARCHITECTURE v2 OF convolution3D_HW_core IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL fsm_output : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL or_dcpl_22 : STD_LOGIC;
  SIGNAL or_dcpl_23 : STD_LOGIC;
  SIGNAL and_dcpl_32 : STD_LOGIC;
  SIGNAL or_tmp_24 : STD_LOGIC;
  SIGNAL and_dcpl_54 : STD_LOGIC;
  SIGNAL or_tmp_77 : STD_LOGIC;
  SIGNAL or_tmp_94 : STD_LOGIC;
  SIGNAL imgPadded_vinit_ndx_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line1Reg_2_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line2Reg_2_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line3Reg_2_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva : STD_LOGIC_VECTOR (9
      DOWNTO 0);
  SIGNAL exit_convolution2D_HW_simple_imgConv2DOut_vinit_sva : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva_3 : STD_LOGIC_VECTOR
      (9 DOWNTO 0);
  SIGNAL exit_convolution2D_HW_simple_imgConv2DOut_vinit_sva_dfm_1 : STD_LOGIC;
  SIGNAL CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4 : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_line1Reg_2_lpi_4 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line2Reg_2_lpi_4 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line3Reg_2_lpi_4 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4 : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL FILL_KERNEL_LOOP_i_3_0_sva_4 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL exit_FILL_KERNEL_LOOP_sva_2 : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4 : STD_LOGIC_VECTOR (4 DOWNTO
      0);
  SIGNAL CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva : STD_LOGIC;
  SIGNAL lastChannel_lpi_3_dfm : STD_LOGIC;
  SIGNAL CONV3D_CHANNEL_IN_LOOP_acc_4_psp_sva_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL CONV2D_MAIN_LOOP_row_4_0_sva_3 : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_mul_cse_1_sva : STD_LOGIC_VECTOR (8 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_line1Reg_1_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line1Reg_0_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line1Reg_2_sva_1 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line2Reg_1_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line2Reg_0_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line2Reg_2_sva_1 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line3Reg_1_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line3Reg_0_sva : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line3Reg_2_sva_1 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_column_4_0_sva : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_2 : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_line1Reg_2_sva_1_dfm : STD_LOGIC_VECTOR (7 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_line2Reg_2_sva_1_dfm : STD_LOGIC_VECTOR (7 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_line3Reg_2_sva_1_dfm : STD_LOGIC_VECTOR (7 DOWNTO
      0);
  SIGNAL exit_CONV2D_COLUMN_LOOP_2 : STD_LOGIC;
  SIGNAL imgPadded_imgPadded_nor_itm_1 : STD_LOGIC;
  SIGNAL imgPadded_acc_itm_2 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_stage_0 : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_else_if_acc_itm_3 : STD_LOGIC_VECTOR (6 DOWNTO
      0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_else_if_slc_FILL_PADDED_IMG_MAIN_LOOP_for_if_mul_ncse_1_0_itm_3
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL FILL_KERNEL_LOOP_asn_3_itm_3 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_if_FILL_PADDED_IMG_MAIN_LOOP_for_if_nand_itm_3
      : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_else_if_FILL_PADDED_IMG_MAIN_LOOP_for_else_if_nand_itm_3
      : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_slc_FILL_PADDED_IMG_MAIN_LOOP_for_acc_4_svs_st_2
      : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_asn_1_itm_2 : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_stage_0_2 : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_stage_0 : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_3 : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_3_slc_pixelCalcHW_simple_for_acc_4_sdt_14_2_itm_2
      : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_9_itm_2 : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_10_itm_2 : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_if_CONV2D_COLUMN_LOOP_if_and_itm_2 : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_and_itm_2 : STD_LOGIC;
  SIGNAL SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_itm_2 : STD_LOGIC_VECTOR
      (9 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_asn_5_itm_2 : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_stage_0_1 : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_stage_0_2 : STD_LOGIC;
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_acc_15_itm : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_acc_itm_1 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_15_8_1_itm
      : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_acc_16_itm_1 : STD_LOGIC_VECTOR (7 DOWNTO
      0);
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_7_0_1_itm :
      STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_7_0_2_itm :
      STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_15_8_2_itm
      : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_0_1 : STD_LOGIC_VECTOR (5 DOWNTO
      0);
  SIGNAL CONV2D_COLUMN_LOOP_if_acc_ncse_2 : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_if_acc_8_itm_12_3_2 : STD_LOGIC_VECTOR (9 DOWNTO
      0);
  SIGNAL pixelCalcHW_simple_for_slc_15_2_sat_2_sva_7_13 : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_if_acc_1_psp_2_0 : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_5_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_5_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_7_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_7_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_9_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_9_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_4_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_4_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_6_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_6_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_8_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_8_sva : STD_LOGIC;
  SIGNAL CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva_mx0w0 : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_newPixelVal_0_sva : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_line1Reg_2_sva_1_mx1 : STD_LOGIC_VECTOR (7 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_biasSum_13_1_lpi_5_dfm : STD_LOGIC_VECTOR (12 DOWNTO
      0);
  SIGNAL pixelCalcHW_simple_for_acc_10_sdt : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_acc_12_sdt : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_1 : STD_LOGIC_VECTOR (4 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_newPixelVal_11_1_sva : STD_LOGIC_VECTOR (10 DOWNTO
      0);
  SIGNAL CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_slc_15_2_sat_sva : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_else_acc_sat_sva : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_slc_15_2_sat_2_sva : STD_LOGIC_VECTOR (13 DOWNTO
      0);
  SIGNAL SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_1_sdt : STD_LOGIC_VECTOR
      (9 DOWNTO 0);
  SIGNAL SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_2_sdt : STD_LOGIC_VECTOR
      (9 DOWNTO 0);
  SIGNAL reg_bias_rsc_triosy_obj_ld_cse : STD_LOGIC;
  SIGNAL reg_convolution2D_HW_simple_convolution2D_HW_simple_line3Reg_or_cse : STD_LOGIC;
  SIGNAL reg_FILL_PADDED_IMG_MAIN_LOOP_for_column_slc_FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_0_cse
      : STD_LOGIC;
  SIGNAL reg_FILL_PADDED_IMG_MAIN_LOOP_for_if_acc_cse : STD_LOGIC_VECTOR (8 DOWNTO
      0);
  SIGNAL reg_CONV2D_COLUMN_LOOP_column_slc_CONV2D_COLUMN_LOOP_column_4_0_2_0_cse
      : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL or_21_cse : STD_LOGIC;
  SIGNAL reg_CONV3D_CHANNEL_IN_LOOP_channelInPos_1_CONV3D_CHANNEL_IN_LOOP_channelInPos_or_cse
      : STD_LOGIC;
  SIGNAL reg_CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_CONV3D_MAIN_LOOP_channelOutPos_or_cse
      : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_or_cse : STD_LOGIC;
  SIGNAL CONV3D_CHANNEL_IN_LOOP_channelInPos_or_seb : STD_LOGIC;
  SIGNAL FILL_KERNEL_LOOP_acc_5_psp : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_11_sdt : STD_LOGIC_VECTOR (6
      DOWNTO 0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_4_sdt_4_0_sva : STD_LOGIC_VECTOR
      (4 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_if_nor_ovfl_1_sva : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_else_else_nor_ovfl_sva : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_else_else_and_unfl_sva : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_if_acc_1_psp : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL FILL_KERNEL_LOOP_and_stg_1_0 : STD_LOGIC;
  SIGNAL FILL_KERNEL_LOOP_and_stg_2_0 : STD_LOGIC;
  SIGNAL FILL_KERNEL_LOOP_and_stg_1_3 : STD_LOGIC;
  SIGNAL FILL_KERNEL_LOOP_and_stg_1_2 : STD_LOGIC;
  SIGNAL FILL_KERNEL_LOOP_and_stg_1_1 : STD_LOGIC;
  SIGNAL z_out : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL z_out_1 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL z_out_2 : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL z_out_3 : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL z_out_4 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL z_out_6 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_9_sdt : STD_LOGIC_VECTOR (4
      DOWNTO 0);
  SIGNAL FILL_KERNEL_LOOP_i_3_0_sva_1 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_11_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_11_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_1_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_1_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_2_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_2_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_acc_16_sdt : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_nor_ovfl_3_sva : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_and_unfl_3_sva : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_acc_itm_4 : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_acc_itm_4 : STD_LOGIC;
  SIGNAL FILL_KERNEL_LOOP_acc_itm_3 : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_3_mul_1_itm_15_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_mul_2_itm_15_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_mul_itm_15_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_mul_1_itm_15_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_mul_2_itm_15_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_mul_itm_15_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_mul_1_itm_15_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_mul_2_itm_15_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_if_acc_7_itm_15_1 : STD_LOGIC_VECTOR (14 DOWNTO
      0);
  SIGNAL kernel2D_nor_ssc : STD_LOGIC;
  SIGNAL reg_kernel2D_tmp : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL reg_kernel2D_tmp_1 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL reg_kernel2D_tmp_2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL reg_kernel2D_tmp_3 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL reg_kernel2D_tmp_4 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL reg_kernel2D_tmp_5 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL reg_kernel2D_tmp_6 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL reg_kernel2D_tmp_7 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL reg_kernel2D_tmp_8 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_line1Reg_and_3_tmp : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_line3Reg_and_rgt : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_line3Reg_or_rgt : STD_LOGIC;
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_or_4_rgt : STD_LOGIC;
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_and_9_rgt : STD_LOGIC;
  SIGNAL CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_1_1 : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_row_and_1_cse : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_line3Reg_and_1_cse : STD_LOGIC;
  SIGNAL and_69_tmp : STD_LOGIC;
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_SHIFT_REG_NEW_LINE_MAIN_for_if_nor_2_cse
      : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_line3Reg_and_2_cse : STD_LOGIC;
  SIGNAL z_out_5_2 : STD_LOGIC;

  SIGNAL CONV3D_MAIN_LOOP_channelOutPos_not_nl : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_row_mux_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL CONV3D_CHANNEL_IN_LOOP_channelInPos_not_5_nl : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_FILL_PADDED_IMG_MAIN_LOOP_for_or_1_nl : STD_LOGIC;
  SIGNAL FILL_KERNEL_LOOP_i_mux_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL CONV3D_CHANNEL_IN_LOOP_channelInPos_not_2_nl : STD_LOGIC;
  SIGNAL CONV3D_CHANNEL_IN_LOOP_else_CONV3D_CHANNEL_IN_LOOP_else_if_CONV3D_CHANNEL_IN_LOOP_else_if_nor_nl
      : STD_LOGIC;
  SIGNAL or_146_nl : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_row_mux_1_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_row_and_nl : STD_LOGIC;
  SIGNAL or_192_nl : STD_LOGIC;
  SIGNAL and_90_nl : STD_LOGIC;
  SIGNAL SHIFT_REG_NEW_PIXEL_MAIN_if_acc_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_nor_16_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_acc_4_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_nl : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_nor_7_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_1_nl : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_acc_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_acc_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL FILL_KERNEL_LOOP_acc_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_acc_4_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_acc_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_acc_30_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_prod1_pixelCalcHW_simple_for_or_nl
      : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_prod2_pixelCalcHW_simple_for_or_nl
      : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_prod3_pixelCalcHW_simple_for_or_nl
      : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_nl : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_nor_7_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_1_nl : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_1_acc_4_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_acc_25_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_acc_31_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_pixelCalcHW_simple_prod1_pixelCalcHW_simple_for_or_nl
      : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_1_pixelCalcHW_simple_prod2_pixelCalcHW_simple_for_or_nl
      : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_1_pixelCalcHW_simple_prod3_pixelCalcHW_simple_for_or_nl
      : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_nl : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_nor_7_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_1_nl : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_3_mul_1_nl : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_mul_2_nl : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_3_nl : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_nor_10_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_4_nl : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_6_nl : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_nor_13_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_7_nl : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_2_mul_nl : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_mul_1_nl : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_mul_2_nl : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_3_nl : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_nor_10_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_4_nl : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_6_nl : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_nor_13_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_7_nl : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_1_mul_nl : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_mul_1_nl : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_mul_2_nl : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_3_nl : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_nor_10_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_4_nl : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_6_nl : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_nor_13_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_7_nl : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_3_nor_16_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_if_nor_nl : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_if_acc_7_nl : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_if_acc_19_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_if_acc_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL mux_6_nl : STD_LOGIC;
  SIGNAL nand_1_nl : STD_LOGIC;
  SIGNAL or_190_nl : STD_LOGIC;
  SIGNAL SHIFT_REG_NEW_PIXEL_MAIN_if_acc_11_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL SHIFT_REG_NEW_PIXEL_MAIN_if_acc_12_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_nand_4_nl : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_nand_3_nl : STD_LOGIC;
  SIGNAL mux_8_nl : STD_LOGIC;
  SIGNAL mux_7_nl : STD_LOGIC;
  SIGNAL and_327_nl : STD_LOGIC;
  SIGNAL and_328_nl : STD_LOGIC;
  SIGNAL or_46_nl : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_nand_2_nl : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_nand_1_nl : STD_LOGIC;
  SIGNAL imgPadded_mux1h_5_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_acc_18_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL imgPadded_imgPadded_or_1_nl : STD_LOGIC;
  SIGNAL imgPadded_mux1h_15_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL SHIFT_REG_NEW_LINE_MAIN_for_if_acc_14_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL imgPadded_and_2_nl : STD_LOGIC;
  SIGNAL imgPadded_and_3_nl : STD_LOGIC;
  SIGNAL imgPadded_or_nl : STD_LOGIC;
  SIGNAL imgPadded_mux1h_16_nl : STD_LOGIC;
  SIGNAL CONV3D_CHANNEL_IN_LOOP_channelInPos_CONV3D_CHANNEL_IN_LOOP_channelInPos_CONV3D_CHANNEL_IN_LOOP_channelInPos_nor_nl
      : STD_LOGIC;
  SIGNAL imgPadded_imgPadded_or_2_nl : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_nand_nl : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_nor_nl : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_13_nl : STD_LOGIC_VECTOR (4
      DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_or_nl
      : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_or_1_nl
      : STD_LOGIC;
  SIGNAL nor_8_nl : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_mux_14_nl : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_mux_15_nl : STD_LOGIC_VECTOR (12 DOWNTO
      0);
  SIGNAL CONV2D_COLUMN_LOOP_else_else_CONV2D_COLUMN_LOOP_else_else_nor_1_nl : STD_LOGIC_VECTOR
      (12 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_else_else_nor_2_nl : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_mux_16_nl : STD_LOGIC;
  SIGNAL CONV2D_COLUMN_LOOP_else_else_CONV2D_COLUMN_LOOP_else_else_nor_2_nl : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_mux1h_6_nl : STD_LOGIC_VECTOR (5 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_mux1h_7_nl : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_mux1h_8_nl : STD_LOGIC_VECTOR (2 DOWNTO
      0);
  SIGNAL CONV3D_CHANNEL_IN_LOOP_mux_4_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL CONV3D_CHANNEL_IN_LOOP_mux_5_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_mux_4_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_acc_33_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_3_pixelCalcHW_simple_prod1_pixelCalcHW_simple_for_or_1_nl
      : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_3_pixelCalcHW_simple_prod2_pixelCalcHW_simple_for_or_1_nl
      : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_3_pixelCalcHW_simple_prod3_pixelCalcHW_simple_for_or_1_nl
      : STD_LOGIC;
  SIGNAL pixelCalcHW_simple_for_mux_5_nl : STD_LOGIC;
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_else_else_mux_2_nl : STD_LOGIC_VECTOR (4 DOWNTO
      0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_else_else_mux_3_nl : STD_LOGIC_VECTOR (3 DOWNTO
      0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_mux1h_9_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL FILL_PADDED_IMG_MAIN_LOOP_for_if_mux_1_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL CONV2D_COLUMN_LOOP_acc_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_mux_6_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL pixelCalcHW_simple_for_mux_7_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  COMPONENT convolution3D_HW_core_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
      imgPadded_vinit_C_1_tr0 : IN STD_LOGIC;
      FILL_PADDED_IMG_MAIN_LOOP_C_0_tr0 : IN STD_LOGIC;
      CONV2D_COLUMN_LOOP_C_1_tr0 : IN STD_LOGIC;
      CONV2D_MAIN_LOOP_C_4_tr0 : IN STD_LOGIC;
      CONV3D_CHANNEL_IN_LOOP_C_1_tr0 : IN STD_LOGIC;
      CONV3D_MAIN_LOOP_C_0_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL convolution3D_HW_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (15 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_core_fsm_inst_imgPadded_vinit_C_1_tr0 : STD_LOGIC;
  SIGNAL convolution3D_HW_core_core_fsm_inst_FILL_PADDED_IMG_MAIN_LOOP_C_0_tr0 :
      STD_LOGIC;
  SIGNAL convolution3D_HW_core_core_fsm_inst_CONV2D_COLUMN_LOOP_C_1_tr0 : STD_LOGIC;
  SIGNAL convolution3D_HW_core_core_fsm_inst_CONV2D_MAIN_LOOP_C_4_tr0 : STD_LOGIC;
  SIGNAL convolution3D_HW_core_core_fsm_inst_CONV3D_CHANNEL_IN_LOOP_C_1_tr0 : STD_LOGIC;
  SIGNAL convolution3D_HW_core_core_fsm_inst_CONV3D_MAIN_LOOP_C_0_tr0 : STD_LOGIC;

  FUNCTION MUX1HOT_s_1_3_2(input_2 : STD_LOGIC;
  input_1 : STD_LOGIC;
  input_0 : STD_LOGIC;
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      tmp := sel(0);
      result := input_0 and tmp;
      tmp := sel(1);
      result := result or ( input_1 and tmp);
      tmp := sel(2);
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_s_1_4_2(input_3 : STD_LOGIC;
  input_2 : STD_LOGIC;
  input_1 : STD_LOGIC;
  input_0 : STD_LOGIC;
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      tmp := sel(0);
      result := input_0 and tmp;
      tmp := sel(1);
      result := result or ( input_1 and tmp);
      tmp := sel(2);
      result := result or ( input_2 and tmp);
      tmp := sel(3);
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_3_3_2(input_2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(2 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(2 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_5_3_2(input_2 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(4 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(4 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_6_3_2(input_2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(5 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(5 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_9_4_2(input_3 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(8 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(8 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_9_8_2(input_7 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(7 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(8 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(8 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
      tmp := (OTHERS=>sel( 4));
      result := result or ( input_4 and tmp);
      tmp := (OTHERS=>sel( 5));
      result := result or ( input_5 and tmp);
      tmp := (OTHERS=>sel( 6));
      result := result or ( input_6 and tmp);
      tmp := (OTHERS=>sel( 7));
      result := result or ( input_7 and tmp);
    RETURN result;
  END;

  FUNCTION MUX_s_1_2_2(input_0 : STD_LOGIC;
  input_1 : STD_LOGIC;
  sel : STD_LOGIC)
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_10_2_2(input_0 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(9 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(9 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_11_2_2(input_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(10 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(10 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_13_2_2(input_0 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(12 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(12 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_15_2_2(input_0 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(14 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(14 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_2_2_2(input_0 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(1 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(1 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_4_2_2(input_0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(3 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(3 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_5_2_2(input_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(4 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(4 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_6_2_2(input_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(5 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(5 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_8_2_2(input_0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(7 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_9_2_2(input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(8 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(8 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  -- Default Constant Signal Assignments

  kernel_rsc_triosy_obj : work.mgc_ioport_comps_v11.mgc_io_sync_v1
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_bias_rsc_triosy_obj_ld_cse,
      lz => kernel_rsc_triosy_lz
    );
  imgIn_rsc_triosy_obj : work.mgc_ioport_comps_v11.mgc_io_sync_v1
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_bias_rsc_triosy_obj_ld_cse,
      lz => imgIn_rsc_triosy_lz
    );
  imgOut_rsc_triosy_obj : work.mgc_ioport_comps_v11.mgc_io_sync_v1
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_bias_rsc_triosy_obj_ld_cse,
      lz => imgOut_rsc_triosy_lz
    );
  bias_rsc_triosy_obj : work.mgc_ioport_comps_v11.mgc_io_sync_v1
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_bias_rsc_triosy_obj_ld_cse,
      lz => bias_rsc_triosy_lz
    );
  convolution3D_HW_core_core_fsm_inst : convolution3D_HW_core_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      fsm_output => convolution3D_HW_core_core_fsm_inst_fsm_output,
      imgPadded_vinit_C_1_tr0 => convolution3D_HW_core_core_fsm_inst_imgPadded_vinit_C_1_tr0,
      FILL_PADDED_IMG_MAIN_LOOP_C_0_tr0 => convolution3D_HW_core_core_fsm_inst_FILL_PADDED_IMG_MAIN_LOOP_C_0_tr0,
      CONV2D_COLUMN_LOOP_C_1_tr0 => convolution3D_HW_core_core_fsm_inst_CONV2D_COLUMN_LOOP_C_1_tr0,
      CONV2D_MAIN_LOOP_C_4_tr0 => convolution3D_HW_core_core_fsm_inst_CONV2D_MAIN_LOOP_C_4_tr0,
      CONV3D_CHANNEL_IN_LOOP_C_1_tr0 => convolution3D_HW_core_core_fsm_inst_CONV3D_CHANNEL_IN_LOOP_C_1_tr0,
      CONV3D_MAIN_LOOP_C_0_tr0 => convolution3D_HW_core_core_fsm_inst_CONV3D_MAIN_LOOP_C_0_tr0
    );
  fsm_output <= convolution3D_HW_core_core_fsm_inst_fsm_output;
  convolution3D_HW_core_core_fsm_inst_imgPadded_vinit_C_1_tr0 <= NOT(exit_convolution2D_HW_simple_imgConv2DOut_vinit_sva_dfm_1
      AND imgPadded_imgPadded_nor_itm_1);
  convolution3D_HW_core_core_fsm_inst_FILL_PADDED_IMG_MAIN_LOOP_C_0_tr0 <= NOT(FILL_PADDED_IMG_MAIN_LOOP_stage_0
      OR FILL_PADDED_IMG_MAIN_LOOP_stage_0_2);
  convolution3D_HW_core_core_fsm_inst_CONV2D_COLUMN_LOOP_C_1_tr0 <= NOT(CONV2D_COLUMN_LOOP_stage_0_1
      OR CONV2D_COLUMN_LOOP_stage_0);
  convolution3D_HW_core_core_fsm_inst_CONV2D_MAIN_LOOP_C_4_tr0 <= NOT z_out_5_2;
  convolution3D_HW_core_core_fsm_inst_CONV3D_CHANNEL_IN_LOOP_C_1_tr0 <= (CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4(0))
      XOR CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_1_1;
  convolution3D_HW_core_core_fsm_inst_CONV3D_MAIN_LOOP_C_0_tr0 <= CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_1(6);

  CONV3D_CHANNEL_IN_LOOP_channelInPos_or_seb <= or_dcpl_23 OR (fsm_output(7)) OR
      (CONV2D_COLUMN_LOOP_stage_0_1 AND (z_out(5)) AND (fsm_output(10)));
  kernel2D_nor_ssc <= NOT((NOT (fsm_output(4))) OR (NOT FILL_PADDED_IMG_MAIN_LOOP_stage_0_2)
      OR FILL_PADDED_IMG_MAIN_LOOP_asn_1_itm_2 OR FILL_PADDED_IMG_MAIN_LOOP_for_slc_FILL_PADDED_IMG_MAIN_LOOP_for_acc_4_svs_st_2);
  reg_CONV3D_CHANNEL_IN_LOOP_channelInPos_1_CONV3D_CHANNEL_IN_LOOP_channelInPos_or_cse
      <= (fsm_output(13)) OR reg_CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_CONV3D_MAIN_LOOP_channelOutPos_or_cse;
  reg_CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_CONV3D_MAIN_LOOP_channelOutPos_or_cse
      <= (fsm_output(3)) OR (fsm_output(14));
  reg_convolution2D_HW_simple_convolution2D_HW_simple_line3Reg_or_cse <= (fsm_output(3))
      OR or_tmp_77;
  FILL_PADDED_IMG_MAIN_LOOP_row_and_1_cse <= FILL_PADDED_IMG_MAIN_LOOP_for_acc_itm_4
      AND (NOT reg_CONV3D_CHANNEL_IN_LOOP_channelInPos_1_CONV3D_CHANNEL_IN_LOOP_channelInPos_or_cse);
  convolution2D_HW_simple_line3Reg_and_rgt <= (NOT or_dcpl_22) AND (fsm_output(10));
  convolution2D_HW_simple_line3Reg_and_1_cse <= or_dcpl_22 AND (fsm_output(10));
  convolution2D_HW_simple_line3Reg_or_rgt <= convolution2D_HW_simple_line3Reg_and_1_cse
      OR CONV2D_COLUMN_LOOP_or_cse;
  CONV2D_COLUMN_LOOP_or_cse <= (fsm_output(9)) OR (fsm_output(11));
  or_21_cse <= exit_CONV2D_COLUMN_LOOP_2 OR (NOT(CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_2
      AND CONV2D_COLUMN_LOOP_stage_0_1));
  convolution2D_HW_simple_line1Reg_and_3_tmp <= CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_3
      AND (NOT((NOT CONV2D_COLUMN_LOOP_stage_0_2) OR CONV2D_COLUMN_LOOP_asn_5_itm_2));
  SHIFT_REG_NEW_LINE_MAIN_for_if_or_4_rgt <= (fsm_output(10)) OR (or_21_cse AND (fsm_output(11)));
  SHIFT_REG_NEW_LINE_MAIN_for_if_and_9_rgt <= (NOT or_21_cse) AND (fsm_output(11));
  SHIFT_REG_NEW_LINE_MAIN_for_if_SHIFT_REG_NEW_LINE_MAIN_for_if_nor_2_cse <= NOT(convolution2D_HW_simple_line3Reg_and_1_cse
      OR (fsm_output(11)));
  convolution2D_HW_simple_line3Reg_and_2_cse <= (fsm_output(11)) AND (and_dcpl_32
      OR and_dcpl_54);
  FILL_PADDED_IMG_MAIN_LOOP_for_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_1(4
      DOWNTO 1)), 4), 5) + SIGNED'( "10011"), 5));
  FILL_PADDED_IMG_MAIN_LOOP_for_acc_itm_4 <= readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_acc_nl),
      5)), 4);
  CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_1_1 <= (CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4(0))
      XOR (CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4(1));
  FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_11_sdt <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(z_out_2
      & (FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_9_sdt(0))) + SIGNED(STD_LOGIC_VECTOR'(
      "10") & FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4), 7));
  FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_4_sdt_4_0_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4)
      + UNSIGNED'( "11111"), 5));
  FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_9_sdt <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4
      & STD_LOGIC_VECTOR'( "101")) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_4_sdt_4_0_sva(4
      DOWNTO 3)), 2), 5), 5));
  FILL_PADDED_IMG_MAIN_LOOP_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(z_out_3(4
      DOWNTO 1)), 4), 5) + SIGNED'( "10011"), 5));
  FILL_PADDED_IMG_MAIN_LOOP_acc_itm_4 <= readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(FILL_PADDED_IMG_MAIN_LOOP_acc_nl),
      5)), 4);
  FILL_KERNEL_LOOP_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(FILL_KERNEL_LOOP_i_3_0_sva_1)
      + SIGNED'( "0111"), 4));
  FILL_KERNEL_LOOP_acc_itm_3 <= readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(FILL_KERNEL_LOOP_acc_nl),
      4)), 3);
  FILL_KERNEL_LOOP_i_3_0_sva_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(FILL_KERNEL_LOOP_i_3_0_sva_4)
      + UNSIGNED'( "0001"), 4));
  FILL_KERNEL_LOOP_acc_5_psp <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(FILL_KERNEL_LOOP_i_3_0_sva_4)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4),
      2), 4), 4));
  FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4)
      + UNSIGNED'( "00001"), 5));
  CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva_mx0w0 <= NOT(TO_STDLOGIC(CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4/=STD_LOGIC_VECTOR'("00")));
  convolution2D_HW_simple_line1Reg_2_sva_1_mx1 <= MUX_v_8_2_2(convolution2D_HW_simple_line1Reg_2_sva_1,
      (imgPadded_rsci_data_out_d(7 DOWNTO 0)), convolution2D_HW_simple_line1Reg_and_3_tmp);
  CONV2D_COLUMN_LOOP_if_acc_1_psp <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(CONV2D_MAIN_LOOP_row_4_0_sva_3)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(CONV2D_COLUMN_LOOP_column_4_0_sva(4
      DOWNTO 3)), 2), 5), 5));
  pixelCalcHW_simple_for_2_pixelCalcHW_simple_prod1_pixelCalcHW_simple_for_or_nl
      <= (NOT((pixelCalcHW_simple_for_2_mul_itm_15_1(12)) OR pixelCalcHW_simple_for_and_unfl_5_sva))
      OR pixelCalcHW_simple_for_nor_ovfl_5_sva;
  pixelCalcHW_simple_for_2_pixelCalcHW_simple_prod2_pixelCalcHW_simple_for_or_nl
      <= (NOT((pixelCalcHW_simple_for_2_mul_1_itm_15_1(12)) OR pixelCalcHW_simple_for_and_unfl_7_sva))
      OR pixelCalcHW_simple_for_nor_ovfl_7_sva;
  pixelCalcHW_simple_for_2_pixelCalcHW_simple_prod3_pixelCalcHW_simple_for_or_nl
      <= (NOT((pixelCalcHW_simple_for_2_mul_2_itm_15_1(12)) OR pixelCalcHW_simple_for_and_unfl_9_sva))
      OR pixelCalcHW_simple_for_nor_ovfl_9_sva;
  pixelCalcHW_simple_for_acc_30_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_2_pixelCalcHW_simple_prod1_pixelCalcHW_simple_for_or_nl,
      1), 2) + CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_2_pixelCalcHW_simple_prod2_pixelCalcHW_simple_for_or_nl,
      1), 2) + CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_2_pixelCalcHW_simple_prod3_pixelCalcHW_simple_for_or_nl,
      1), 2), 2));
  pixelCalcHW_simple_for_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_acc_30_nl),
      3) + CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_acc_10_sdt(12),
      1), 1), 3), 3));
  pixelCalcHW_simple_for_2_nor_7_nl <= NOT(MUX_v_11_2_2((pixelCalcHW_simple_for_2_mul_itm_15_1(11
      DOWNTO 1)), STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_nor_ovfl_5_sva));
  pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_nl <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_2_nor_7_nl,
      STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_5_sva));
  pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_1_nl <= NOT((NOT((pixelCalcHW_simple_for_2_mul_itm_15_1(0))
      OR pixelCalcHW_simple_for_nor_ovfl_5_sva)) OR pixelCalcHW_simple_for_and_unfl_5_sva);
  pixelCalcHW_simple_for_2_acc_4_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_acc_nl),
      3)) & (pixelCalcHW_simple_for_acc_10_sdt(11 DOWNTO 0))) + SIGNED(STD_LOGIC_VECTOR'(
      "101") & pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_nl & pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_1_nl),
      15));
  pixelCalcHW_simple_for_1_pixelCalcHW_simple_prod1_pixelCalcHW_simple_for_or_nl
      <= (NOT((pixelCalcHW_simple_for_1_mul_itm_15_1(12)) OR pixelCalcHW_simple_for_and_unfl_4_sva))
      OR pixelCalcHW_simple_for_nor_ovfl_4_sva;
  pixelCalcHW_simple_for_1_pixelCalcHW_simple_prod2_pixelCalcHW_simple_for_or_nl
      <= (NOT((pixelCalcHW_simple_for_1_mul_1_itm_15_1(12)) OR pixelCalcHW_simple_for_and_unfl_6_sva))
      OR pixelCalcHW_simple_for_nor_ovfl_6_sva;
  pixelCalcHW_simple_for_1_pixelCalcHW_simple_prod3_pixelCalcHW_simple_for_or_nl
      <= (NOT((pixelCalcHW_simple_for_1_mul_2_itm_15_1(12)) OR pixelCalcHW_simple_for_and_unfl_8_sva))
      OR pixelCalcHW_simple_for_nor_ovfl_8_sva;
  pixelCalcHW_simple_for_acc_31_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_1_pixelCalcHW_simple_prod1_pixelCalcHW_simple_for_or_nl,
      1), 2) + CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_1_pixelCalcHW_simple_prod2_pixelCalcHW_simple_for_or_nl,
      1), 2) + CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_1_pixelCalcHW_simple_prod3_pixelCalcHW_simple_for_or_nl,
      1), 2), 2));
  pixelCalcHW_simple_for_acc_25_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_acc_31_nl),
      3) + CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_acc_12_sdt(12),
      1), 1), 3), 3));
  pixelCalcHW_simple_for_1_nor_7_nl <= NOT(MUX_v_11_2_2((pixelCalcHW_simple_for_1_mul_itm_15_1(11
      DOWNTO 1)), STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_nor_ovfl_4_sva));
  pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_nl <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_1_nor_7_nl,
      STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_4_sva));
  pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_1_nl <= NOT((NOT((pixelCalcHW_simple_for_1_mul_itm_15_1(0))
      OR pixelCalcHW_simple_for_nor_ovfl_4_sva)) OR pixelCalcHW_simple_for_and_unfl_4_sva);
  pixelCalcHW_simple_for_1_acc_4_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_acc_25_nl),
      3)) & (pixelCalcHW_simple_for_acc_12_sdt(11 DOWNTO 0))) + SIGNED(STD_LOGIC_VECTOR'(
      "101") & pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_nl & pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_1_nl),
      15));
  pixelCalcHW_simple_for_slc_15_2_sat_2_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_SIGNED(SIGNED(readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_2_acc_4_nl),
      15)), 2, 13)), 13), 14) + CONV_UNSIGNED(CONV_SIGNED(SIGNED(readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_1_acc_4_nl),
      15)), 2, 13)), 13), 14), 14));
  pixelCalcHW_simple_for_nor_ovfl_11_sva <= NOT(TO_STDLOGIC(pixelCalcHW_simple_for_slc_15_2_sat_2_sva(13
      DOWNTO 12)/=STD_LOGIC_VECTOR'("01")));
  pixelCalcHW_simple_for_and_unfl_11_sva <= TO_STDLOGIC(pixelCalcHW_simple_for_slc_15_2_sat_2_sva(13
      DOWNTO 12)=STD_LOGIC_VECTOR'("10"));
  pixelCalcHW_simple_for_and_unfl_sva <= (z_out_6(15)) AND (NOT(TO_STDLOGIC(z_out_6(14
      DOWNTO 13)=STD_LOGIC_VECTOR'("11"))));
  pixelCalcHW_simple_for_nor_ovfl_sva <= NOT((z_out_6(15)) OR (NOT(TO_STDLOGIC(z_out_6(14
      DOWNTO 13)/=STD_LOGIC_VECTOR'("00")))));
  pixelCalcHW_simple_for_3_mul_1_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED(reg_kernel2D_tmp_3)
      * SIGNED(convolution2D_HW_simple_line2Reg_2_sva_1)), 16));
  pixelCalcHW_simple_for_3_mul_1_itm_15_1 <= readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_3_mul_1_nl),
      16)), 1, 15);
  pixelCalcHW_simple_for_and_unfl_1_sva <= (pixelCalcHW_simple_for_3_mul_1_itm_15_1(14))
      AND (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_3_mul_1_itm_15_1(13 DOWNTO 12)=STD_LOGIC_VECTOR'("11"))));
  pixelCalcHW_simple_for_nor_ovfl_1_sva <= NOT((pixelCalcHW_simple_for_3_mul_1_itm_15_1(14))
      OR (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_3_mul_1_itm_15_1(13 DOWNTO 12)/=STD_LOGIC_VECTOR'("00")))));
  pixelCalcHW_simple_for_3_mul_2_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED(reg_kernel2D_tmp)
      * SIGNED(convolution2D_HW_simple_line3Reg_2_sva_1)), 16));
  pixelCalcHW_simple_for_3_mul_2_itm_15_1 <= readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_3_mul_2_nl),
      16)), 1, 15);
  pixelCalcHW_simple_for_and_unfl_2_sva <= (pixelCalcHW_simple_for_3_mul_2_itm_15_1(14))
      AND (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_3_mul_2_itm_15_1(13 DOWNTO 12)=STD_LOGIC_VECTOR'("11"))));
  pixelCalcHW_simple_for_nor_ovfl_2_sva <= NOT((pixelCalcHW_simple_for_3_mul_2_itm_15_1(14))
      OR (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_3_mul_2_itm_15_1(13 DOWNTO 12)/=STD_LOGIC_VECTOR'("00")))));
  pixelCalcHW_simple_for_3_nor_10_nl <= NOT(MUX_v_11_2_2((pixelCalcHW_simple_for_3_mul_1_itm_15_1(11
      DOWNTO 1)), STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_nor_ovfl_1_sva));
  pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_3_nl <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_3_nor_10_nl,
      STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_1_sva));
  pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_4_nl <= NOT((NOT((pixelCalcHW_simple_for_3_mul_1_itm_15_1(0))
      OR pixelCalcHW_simple_for_nor_ovfl_1_sva)) OR pixelCalcHW_simple_for_and_unfl_1_sva);
  pixelCalcHW_simple_for_3_nor_13_nl <= NOT(MUX_v_11_2_2((pixelCalcHW_simple_for_3_mul_2_itm_15_1(11
      DOWNTO 1)), STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_nor_ovfl_2_sva));
  pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_6_nl <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_3_nor_13_nl,
      STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_2_sva));
  pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_7_nl <= NOT((NOT((pixelCalcHW_simple_for_3_mul_2_itm_15_1(0))
      OR pixelCalcHW_simple_for_nor_ovfl_2_sva)) OR pixelCalcHW_simple_for_and_unfl_2_sva);
  pixelCalcHW_simple_for_acc_16_sdt <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_3_nl
      & pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_4_nl), 12), 13) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_6_nl
      & pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_7_nl), 12), 13), 13));
  pixelCalcHW_simple_for_2_mul_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED(reg_kernel2D_tmp_7)
      * SIGNED(convolution2D_HW_simple_line1Reg_1_sva)), 16));
  pixelCalcHW_simple_for_2_mul_itm_15_1 <= readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_2_mul_nl),
      16)), 1, 15);
  pixelCalcHW_simple_for_and_unfl_5_sva <= (pixelCalcHW_simple_for_2_mul_itm_15_1(14))
      AND (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_2_mul_itm_15_1(13 DOWNTO 12)=STD_LOGIC_VECTOR'("11"))));
  pixelCalcHW_simple_for_nor_ovfl_5_sva <= NOT((pixelCalcHW_simple_for_2_mul_itm_15_1(14))
      OR (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_2_mul_itm_15_1(13 DOWNTO 12)/=STD_LOGIC_VECTOR'("00")))));
  pixelCalcHW_simple_for_2_mul_1_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED(reg_kernel2D_tmp_4)
      * SIGNED(convolution2D_HW_simple_line2Reg_1_sva)), 16));
  pixelCalcHW_simple_for_2_mul_1_itm_15_1 <= readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_2_mul_1_nl),
      16)), 1, 15);
  pixelCalcHW_simple_for_and_unfl_7_sva <= (pixelCalcHW_simple_for_2_mul_1_itm_15_1(14))
      AND (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_2_mul_1_itm_15_1(13 DOWNTO 12)=STD_LOGIC_VECTOR'("11"))));
  pixelCalcHW_simple_for_nor_ovfl_7_sva <= NOT((pixelCalcHW_simple_for_2_mul_1_itm_15_1(14))
      OR (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_2_mul_1_itm_15_1(13 DOWNTO 12)/=STD_LOGIC_VECTOR'("00")))));
  pixelCalcHW_simple_for_2_mul_2_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED(reg_kernel2D_tmp_1)
      * SIGNED(convolution2D_HW_simple_line3Reg_1_sva)), 16));
  pixelCalcHW_simple_for_2_mul_2_itm_15_1 <= readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_2_mul_2_nl),
      16)), 1, 15);
  pixelCalcHW_simple_for_and_unfl_9_sva <= (pixelCalcHW_simple_for_2_mul_2_itm_15_1(14))
      AND (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_2_mul_2_itm_15_1(13 DOWNTO 12)=STD_LOGIC_VECTOR'("11"))));
  pixelCalcHW_simple_for_nor_ovfl_9_sva <= NOT((pixelCalcHW_simple_for_2_mul_2_itm_15_1(14))
      OR (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_2_mul_2_itm_15_1(13 DOWNTO 12)/=STD_LOGIC_VECTOR'("00")))));
  pixelCalcHW_simple_for_2_nor_10_nl <= NOT(MUX_v_11_2_2((pixelCalcHW_simple_for_2_mul_1_itm_15_1(11
      DOWNTO 1)), STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_nor_ovfl_7_sva));
  pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_3_nl <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_2_nor_10_nl,
      STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_7_sva));
  pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_4_nl <= NOT((NOT((pixelCalcHW_simple_for_2_mul_1_itm_15_1(0))
      OR pixelCalcHW_simple_for_nor_ovfl_7_sva)) OR pixelCalcHW_simple_for_and_unfl_7_sva);
  pixelCalcHW_simple_for_2_nor_13_nl <= NOT(MUX_v_11_2_2((pixelCalcHW_simple_for_2_mul_2_itm_15_1(11
      DOWNTO 1)), STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_nor_ovfl_9_sva));
  pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_6_nl <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_2_nor_13_nl,
      STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_9_sva));
  pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_7_nl <= NOT((NOT((pixelCalcHW_simple_for_2_mul_2_itm_15_1(0))
      OR pixelCalcHW_simple_for_nor_ovfl_9_sva)) OR pixelCalcHW_simple_for_and_unfl_9_sva);
  pixelCalcHW_simple_for_acc_10_sdt <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_3_nl
      & pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_4_nl), 12), 13) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_6_nl
      & pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_7_nl), 12), 13), 13));
  pixelCalcHW_simple_for_1_mul_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED(reg_kernel2D_tmp_8)
      * SIGNED(convolution2D_HW_simple_line1Reg_0_sva)), 16));
  pixelCalcHW_simple_for_1_mul_itm_15_1 <= readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_1_mul_nl),
      16)), 1, 15);
  pixelCalcHW_simple_for_and_unfl_4_sva <= (pixelCalcHW_simple_for_1_mul_itm_15_1(14))
      AND (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_1_mul_itm_15_1(13 DOWNTO 12)=STD_LOGIC_VECTOR'("11"))));
  pixelCalcHW_simple_for_nor_ovfl_4_sva <= NOT((pixelCalcHW_simple_for_1_mul_itm_15_1(14))
      OR (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_1_mul_itm_15_1(13 DOWNTO 12)/=STD_LOGIC_VECTOR'("00")))));
  pixelCalcHW_simple_for_1_mul_1_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED(reg_kernel2D_tmp_5)
      * SIGNED(convolution2D_HW_simple_line2Reg_0_sva)), 16));
  pixelCalcHW_simple_for_1_mul_1_itm_15_1 <= readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_1_mul_1_nl),
      16)), 1, 15);
  pixelCalcHW_simple_for_and_unfl_6_sva <= (pixelCalcHW_simple_for_1_mul_1_itm_15_1(14))
      AND (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_1_mul_1_itm_15_1(13 DOWNTO 12)=STD_LOGIC_VECTOR'("11"))));
  pixelCalcHW_simple_for_nor_ovfl_6_sva <= NOT((pixelCalcHW_simple_for_1_mul_1_itm_15_1(14))
      OR (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_1_mul_1_itm_15_1(13 DOWNTO 12)/=STD_LOGIC_VECTOR'("00")))));
  pixelCalcHW_simple_for_1_mul_2_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED(reg_kernel2D_tmp_2)
      * SIGNED(convolution2D_HW_simple_line3Reg_0_sva)), 16));
  pixelCalcHW_simple_for_1_mul_2_itm_15_1 <= readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_1_mul_2_nl),
      16)), 1, 15);
  pixelCalcHW_simple_for_and_unfl_8_sva <= (pixelCalcHW_simple_for_1_mul_2_itm_15_1(14))
      AND (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_1_mul_2_itm_15_1(13 DOWNTO 12)=STD_LOGIC_VECTOR'("11"))));
  pixelCalcHW_simple_for_nor_ovfl_8_sva <= NOT((pixelCalcHW_simple_for_1_mul_2_itm_15_1(14))
      OR (NOT(TO_STDLOGIC(pixelCalcHW_simple_for_1_mul_2_itm_15_1(13 DOWNTO 12)/=STD_LOGIC_VECTOR'("00")))));
  pixelCalcHW_simple_for_1_nor_10_nl <= NOT(MUX_v_11_2_2((pixelCalcHW_simple_for_1_mul_1_itm_15_1(11
      DOWNTO 1)), STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_nor_ovfl_6_sva));
  pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_3_nl <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_1_nor_10_nl,
      STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_6_sva));
  pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_4_nl <= NOT((NOT((pixelCalcHW_simple_for_1_mul_1_itm_15_1(0))
      OR pixelCalcHW_simple_for_nor_ovfl_6_sva)) OR pixelCalcHW_simple_for_and_unfl_6_sva);
  pixelCalcHW_simple_for_1_nor_13_nl <= NOT(MUX_v_11_2_2((pixelCalcHW_simple_for_1_mul_2_itm_15_1(11
      DOWNTO 1)), STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_nor_ovfl_8_sva));
  pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_6_nl <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_1_nor_13_nl,
      STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_8_sva));
  pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_7_nl <= NOT((NOT((pixelCalcHW_simple_for_1_mul_2_itm_15_1(0))
      OR pixelCalcHW_simple_for_nor_ovfl_8_sva)) OR pixelCalcHW_simple_for_and_unfl_8_sva);
  pixelCalcHW_simple_for_acc_12_sdt <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_3_nl
      & pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_4_nl), 12), 13) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_6_nl
      & pixelCalcHW_simple_for_1_pixelCalcHW_simple_for_nor_7_nl), 12), 13), 13));
  pixelCalcHW_simple_for_slc_15_2_sat_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_3_slc_pixelCalcHW_simple_for_acc_4_sdt_14_2_itm_2),
      13), 14) + CONV_UNSIGNED(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_slc_15_2_sat_2_sva_7_13
      & pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_9_itm_2 & pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_10_itm_2),
      13), 14), 14));
  pixelCalcHW_simple_for_3_nor_16_nl <= NOT(MUX_v_11_2_2((pixelCalcHW_simple_for_slc_15_2_sat_sva(11
      DOWNTO 1)), STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_nor_ovfl_3_sva));
  convolution2D_HW_simple_newPixelVal_11_1_sva <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_3_nor_16_nl,
      STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_3_sva));
  convolution2D_HW_simple_newPixelVal_0_sva <= NOT((NOT((pixelCalcHW_simple_for_slc_15_2_sat_sva(0))
      OR pixelCalcHW_simple_for_nor_ovfl_3_sva)) OR pixelCalcHW_simple_for_and_unfl_3_sva);
  CONV2D_COLUMN_LOOP_else_if_nor_nl <= NOT(MUX_v_13_2_2((CONV2D_COLUMN_LOOP_else_if_acc_7_itm_15_1(12
      DOWNTO 0)), STD_LOGIC_VECTOR'("1111111111111"), (CONV2D_COLUMN_LOOP_else_if_acc_7_itm_15_1(13))));
  convolution2D_HW_simple_biasSum_13_1_lpi_5_dfm <= NOT(MUX_v_13_2_2(CONV2D_COLUMN_LOOP_else_if_nor_nl,
      STD_LOGIC_VECTOR'("1111111111111"), (CONV2D_COLUMN_LOOP_else_if_acc_7_itm_15_1(14))));
  CONV2D_COLUMN_LOOP_else_if_nor_ovfl_1_sva <= TO_STDLOGIC(convolution2D_HW_simple_biasSum_13_1_lpi_5_dfm(12
      DOWNTO 11)/=STD_LOGIC_VECTOR'("00"));
  CONV2D_COLUMN_LOOP_else_if_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_UNSIGNED(CONV_UNSIGNED(NOT
      (pixelCalcHW_simple_for_slc_15_2_sat_sva(13)), 1), 1), 2) + CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(bias_rsci_data_out_d(7),
      1), 1), 2), 2));
  CONV2D_COLUMN_LOOP_else_if_acc_19_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(CONV2D_COLUMN_LOOP_else_if_acc_nl),
      2)) & (bias_rsci_data_out_d(7)) & (bias_rsci_data_out_d(7)) & (bias_rsci_data_out_d(7
      DOWNTO 0))) + CONV_SIGNED(CONV_SIGNED(SIGNED('1' & (convolution2D_HW_simple_newPixelVal_11_1_sva(10
      DOWNTO 1))), 11), 12), 12));
  CONV2D_COLUMN_LOOP_else_if_acc_7_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(CONV2D_COLUMN_LOOP_else_if_acc_19_nl),
      12)) & (convolution2D_HW_simple_newPixelVal_11_1_sva(0)) & convolution2D_HW_simple_newPixelVal_0_sva),
      14), 16) + CONV_SIGNED(CONV_SIGNED(SIGNED(convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d(14
      DOWNTO 0)), 15), 16), 16));
  CONV2D_COLUMN_LOOP_else_if_acc_7_itm_15_1 <= readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(CONV2D_COLUMN_LOOP_else_if_acc_7_nl),
      16)), 1, 15);
  CONV2D_COLUMN_LOOP_else_else_acc_sat_sva <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED(convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d(14
      DOWNTO 0)), 15), 16) + CONV_SIGNED(CONV_SIGNED(SIGNED((pixelCalcHW_simple_for_slc_15_2_sat_sva(13))
      & convolution2D_HW_simple_newPixelVal_11_1_sva & convolution2D_HW_simple_newPixelVal_0_sva),
      13), 16), 16));
  CONV2D_COLUMN_LOOP_else_else_nor_ovfl_sva <= NOT(TO_STDLOGIC(CONV2D_COLUMN_LOOP_else_else_acc_sat_sva(15
      DOWNTO 14)/=STD_LOGIC_VECTOR'("01")));
  CONV2D_COLUMN_LOOP_else_else_and_unfl_sva <= TO_STDLOGIC(CONV2D_COLUMN_LOOP_else_else_acc_sat_sva(15
      DOWNTO 14)=STD_LOGIC_VECTOR'("10"));
  pixelCalcHW_simple_for_nor_ovfl_3_sva <= NOT(TO_STDLOGIC(pixelCalcHW_simple_for_slc_15_2_sat_sva(13
      DOWNTO 12)/=STD_LOGIC_VECTOR'("01")));
  pixelCalcHW_simple_for_and_unfl_3_sva <= TO_STDLOGIC(pixelCalcHW_simple_for_slc_15_2_sat_sva(13
      DOWNTO 12)=STD_LOGIC_VECTOR'("10"));
  CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_0_1),
      6), 7) + UNSIGNED'( "0000001"), 7));
  or_dcpl_22 <= NOT(CONV2D_COLUMN_LOOP_stage_0_1 AND (z_out(5)));
  or_dcpl_23 <= (fsm_output(8)) OR (fsm_output(6));
  and_dcpl_32 <= CONV2D_COLUMN_LOOP_stage_0_1 AND CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_2;
  nand_1_nl <= NOT((FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4(3)) AND (FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4(0)));
  or_190_nl <= (FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4(3)) OR (FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4(0));
  mux_6_nl <= MUX_s_1_2_2(or_190_nl, nand_1_nl, FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4(4));
  or_tmp_24 <= TO_STDLOGIC(FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"))
      OR mux_6_nl;
  and_dcpl_54 <= CONV2D_COLUMN_LOOP_stage_0_1 AND (NOT CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_2);
  or_tmp_77 <= TO_STDLOGIC(fsm_output(14 DOWNTO 12)/=STD_LOGIC_VECTOR'("000"));
  or_tmp_94 <= or_dcpl_23 OR (fsm_output(7)) OR (fsm_output(9)) OR (fsm_output(10))
      OR (fsm_output(12)) OR (fsm_output(11));
  SHIFT_REG_NEW_PIXEL_MAIN_if_acc_11_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(CONV2D_COLUMN_LOOP_column_4_0_sva(4
      DOWNTO 2)), 3), 4) + UNSIGNED'( "0111"), 4));
  SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_1_sdt <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(SHIFT_REG_NEW_PIXEL_MAIN_if_acc_11_nl),
      4)) & (CONV2D_COLUMN_LOOP_column_4_0_sva(1 DOWNTO 0))), 6), 10) + UNSIGNED(SHIFT_REG_NEW_LINE_MAIN_for_if_mul_cse_1_sva
      & '1'), 10));
  SHIFT_REG_NEW_PIXEL_MAIN_if_acc_12_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(CONV2D_COLUMN_LOOP_column_4_0_sva(4
      DOWNTO 1)), 4), 6) + UNSIGNED'( "011011"), 6));
  SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_2_sdt <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(SHIFT_REG_NEW_PIXEL_MAIN_if_acc_12_nl),
      6)) & (CONV2D_COLUMN_LOOP_column_4_0_sva(0))), 7), 10) + UNSIGNED(SHIFT_REG_NEW_LINE_MAIN_for_if_mul_cse_1_sva
      & '1'), 10));
  convolution2D_HW_simple_imgConv2DOut_nand_4_nl <= NOT((NOT(FILL_PADDED_IMG_MAIN_LOOP_for_acc_itm_4
      OR exit_FILL_KERNEL_LOOP_sva_2)) AND FILL_PADDED_IMG_MAIN_LOOP_stage_0 AND
      (fsm_output(4)));
  kernel_rsci_re_d <= STD_LOGIC_VECTOR'( '1' & convolution2D_HW_simple_imgConv2DOut_nand_4_nl);
  and_327_nl <= (NOT((FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4(3)) AND (FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4(0))))
      AND or_tmp_24;
  and_328_nl <= ((FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4(3)) OR (FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4(0)))
      AND or_tmp_24;
  mux_7_nl <= MUX_s_1_2_2(and_328_nl, and_327_nl, FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4(4));
  or_46_nl <= TO_STDLOGIC(FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4(2 DOWNTO
      1)/=STD_LOGIC_VECTOR'("00"));
  mux_8_nl <= MUX_s_1_2_2(mux_7_nl, or_tmp_24, or_46_nl);
  convolution2D_HW_simple_imgConv2DOut_nand_3_nl <= NOT(mux_8_nl AND FILL_PADDED_IMG_MAIN_LOOP_stage_0
      AND (fsm_output(4)));
  imgIn_rsci_re_d <= STD_LOGIC_VECTOR'( '1' & convolution2D_HW_simple_imgConv2DOut_nand_3_nl);
  convolution2D_HW_simple_imgConv2DOut_nand_2_nl <= NOT((NOT CONV2D_COLUMN_LOOP_if_CONV2D_COLUMN_LOOP_if_and_itm_2)
      AND CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_and_itm_2 AND CONV2D_COLUMN_LOOP_stage_0_1
      AND (fsm_output(11)));
  imgOut_rsci_we_d <= STD_LOGIC_VECTOR'( '1' & convolution2D_HW_simple_imgConv2DOut_nand_2_nl);
  convolution2D_HW_simple_imgConv2DOut_nand_1_nl <= NOT(CONV2D_COLUMN_LOOP_stage_0_1
      AND lastChannel_lpi_3_dfm AND (NOT CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva)
      AND (fsm_output(10)));
  bias_rsci_re_d <= STD_LOGIC_VECTOR'( '1' & convolution2D_HW_simple_imgConv2DOut_nand_1_nl);
  and_69_tmp <= (NOT FILL_PADDED_IMG_MAIN_LOOP_for_if_FILL_PADDED_IMG_MAIN_LOOP_for_if_nand_itm_3)
      AND FILL_PADDED_IMG_MAIN_LOOP_for_else_if_FILL_PADDED_IMG_MAIN_LOOP_for_else_if_nand_itm_3;
  SHIFT_REG_NEW_LINE_MAIN_for_if_acc_18_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_4)
      + UNSIGNED'( "000011011"), 9));
  imgPadded_mux1h_5_nl <= MUX1HOT_v_9_4_2(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(SHIFT_REG_NEW_LINE_MAIN_for_if_acc_18_nl),
      9)), SHIFT_REG_NEW_LINE_MAIN_for_if_acc_itm_1, SHIFT_REG_NEW_LINE_MAIN_for_if_mul_cse_1_sva,
      (SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_1_sdt(9 DOWNTO
      1)), STD_LOGIC_VECTOR'( (fsm_output(6)) & (fsm_output(7)) & (fsm_output(8))
      & (fsm_output(10))));
  imgPadded_imgPadded_or_1_nl <= ((SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_1_sdt(0))
      AND (NOT (fsm_output(6)))) OR TO_STDLOGIC(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("00"));
  SHIFT_REG_NEW_LINE_MAIN_for_if_acc_14_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_4(8
      DOWNTO 1)) + UNSIGNED'( "00001101"), 8));
  imgPadded_and_2_nl <= (NOT and_69_tmp) AND (fsm_output(4));
  imgPadded_and_3_nl <= and_69_tmp AND (fsm_output(4));
  imgPadded_mux1h_15_nl <= MUX1HOT_v_9_8_2((imgPadded_vinit_ndx_sva(9 DOWNTO 1)),
      reg_FILL_PADDED_IMG_MAIN_LOOP_for_if_acc_cse, (FILL_PADDED_IMG_MAIN_LOOP_for_else_if_acc_itm_3
      & FILL_PADDED_IMG_MAIN_LOOP_for_else_if_slc_FILL_PADDED_IMG_MAIN_LOOP_for_if_mul_ncse_1_0_itm_3),
      (STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(SHIFT_REG_NEW_LINE_MAIN_for_if_acc_14_nl),
      8)) & (z_out_4(0))), (SHIFT_REG_NEW_LINE_MAIN_for_if_acc_16_itm_1 & (SHIFT_REG_NEW_LINE_MAIN_for_if_mul_cse_1_sva(0))),
      SHIFT_REG_NEW_LINE_MAIN_for_if_acc_15_itm, (SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_2_sdt(9
      DOWNTO 1)), (SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_itm_2(9
      DOWNTO 1)), STD_LOGIC_VECTOR'( (fsm_output(1)) & imgPadded_and_2_nl & imgPadded_and_3_nl
      & (fsm_output(6)) & (fsm_output(7)) & (fsm_output(8)) & (fsm_output(10)) &
      (fsm_output(11))));
  imgPadded_mux1h_16_nl <= MUX1HOT_s_1_4_2((imgPadded_vinit_ndx_sva(0)), reg_FILL_PADDED_IMG_MAIN_LOOP_for_column_slc_FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_0_cse,
      (SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_2_sdt(0)), (SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_itm_2(0)),
      STD_LOGIC_VECTOR'( (fsm_output(1)) & (fsm_output(4)) & (fsm_output(10)) & (fsm_output(11))));
  imgPadded_or_nl <= (imgPadded_mux1h_16_nl AND TO_STDLOGIC(fsm_output(8 DOWNTO 7)=STD_LOGIC_VECTOR'("00")))
      OR (fsm_output(6));
  imgPadded_rsci_addr_d <= imgPadded_mux1h_5_nl & imgPadded_imgPadded_or_1_nl & imgPadded_mux1h_15_nl
      & imgPadded_or_nl;
  CONV3D_CHANNEL_IN_LOOP_channelInPos_CONV3D_CHANNEL_IN_LOOP_channelInPos_CONV3D_CHANNEL_IN_LOOP_channelInPos_nor_nl
      <= NOT((and_dcpl_32 AND (fsm_output(11))) OR CONV3D_CHANNEL_IN_LOOP_channelInPos_or_seb);
  imgPadded_rsci_re_d <= STD_LOGIC_VECTOR'( (NOT CONV3D_CHANNEL_IN_LOOP_channelInPos_or_seb)
      & CONV3D_CHANNEL_IN_LOOP_channelInPos_CONV3D_CHANNEL_IN_LOOP_channelInPos_CONV3D_CHANNEL_IN_LOOP_channelInPos_nor_nl);
  imgPadded_imgPadded_or_2_nl <= (NOT((fsm_output(4)) OR (fsm_output(1)))) OR ((NOT
      FILL_PADDED_IMG_MAIN_LOOP_stage_0_2) AND (fsm_output(4)));
  imgPadded_rsci_we_d <= STD_LOGIC_VECTOR'( '1' & imgPadded_imgPadded_or_2_nl);
  convolution2D_HW_simple_imgConv2DOut_nand_nl <= NOT((lastChannel_lpi_3_dfm OR (NOT
      CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva)) AND CONV2D_COLUMN_LOOP_stage_0_1
      AND (fsm_output(10)));
  convolution2D_HW_simple_imgConv2DOut_rsci_re_d <= STD_LOGIC_VECTOR'( '1' & convolution2D_HW_simple_imgConv2DOut_nand_nl);
  convolution2D_HW_simple_imgConv2DOut_nor_nl <= NOT(((CONV2D_COLUMN_LOOP_if_CONV2D_COLUMN_LOOP_if_and_itm_2
      OR (NOT CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_and_itm_2)) AND
      CONV2D_COLUMN_LOOP_stage_0_1 AND (fsm_output(11))) OR ((NOT exit_convolution2D_HW_simple_imgConv2DOut_vinit_sva)
      AND (fsm_output(1))));
  convolution2D_HW_simple_imgConv2DOut_rsci_we_d <= STD_LOGIC_VECTOR'( '1' & convolution2D_HW_simple_imgConv2DOut_nor_nl);
  kernel_rsci_addr_d <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(z_out_1
      & (FILL_KERNEL_LOOP_acc_5_psp(2 DOWNTO 0))), 6), 11) + UNSIGNED(z_out_6(10
      DOWNTO 0)), 11));
  FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_13_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_SIGNED(SIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_11_sdt(6
      DOWNTO 3)), 4), 5) + UNSIGNED(CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4
      & STD_LOGIC_VECTOR'( "111")), 5));
  imgIn_rsci_addr_d <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_13_nl),
      5)) & (FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_11_sdt(2 DOWNTO 0)) & (FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_4_sdt_4_0_sva(2
      DOWNTO 0));
  CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_or_nl
      <= MUX_v_10_2_2((convolution2D_HW_simple_biasSum_13_1_lpi_5_dfm(10 DOWNTO 1)),
      STD_LOGIC_VECTOR'("1111111111"), CONV2D_COLUMN_LOOP_else_if_nor_ovfl_1_sva);
  CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_or_1_nl
      <= (convolution2D_HW_simple_biasSum_13_1_lpi_5_dfm(0)) OR CONV2D_COLUMN_LOOP_else_if_nor_ovfl_1_sva;
  imgOut_rsci_data_in_d <= '0' & CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_or_nl
      & CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_or_1_nl;
  imgOut_rsci_addr_d <= CONV2D_COLUMN_LOOP_else_if_acc_8_itm_12_3_2 & (CONV2D_COLUMN_LOOP_if_acc_ncse_2(1
      DOWNTO 0)) & CONV2D_COLUMN_LOOP_if_acc_1_psp_2_0 & reg_CONV2D_COLUMN_LOOP_column_slc_CONV2D_COLUMN_LOOP_column_4_0_2_0_cse;
  bias_rsci_addr_d <= CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_0_1;
  nor_8_nl <= NOT(FILL_PADDED_IMG_MAIN_LOOP_for_if_FILL_PADDED_IMG_MAIN_LOOP_for_if_nand_itm_3
      OR FILL_PADDED_IMG_MAIN_LOOP_for_else_if_FILL_PADDED_IMG_MAIN_LOOP_for_else_if_nand_itm_3);
  imgPadded_rsci_data_in_d <= (imgIn_rsci_data_out_d(7 DOWNTO 0)) AND STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(nor_8_nl,
      1),8)) AND STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(NOT (fsm_output(1)), 1),8));
  convolution2D_HW_simple_imgConv2DOut_mux_14_nl <= MUX_s_1_2_2((CONV2D_COLUMN_LOOP_else_else_acc_sat_sva(15)),
      (pixelCalcHW_simple_for_slc_15_2_sat_sva(13)), CONV2D_COLUMN_LOOP_if_CONV2D_COLUMN_LOOP_if_and_itm_2);
  CONV2D_COLUMN_LOOP_else_else_nor_2_nl <= NOT(MUX_v_13_2_2((CONV2D_COLUMN_LOOP_else_else_acc_sat_sva(13
      DOWNTO 1)), STD_LOGIC_VECTOR'("1111111111111"), CONV2D_COLUMN_LOOP_else_else_nor_ovfl_sva));
  CONV2D_COLUMN_LOOP_else_else_CONV2D_COLUMN_LOOP_else_else_nor_1_nl <= NOT(MUX_v_13_2_2(CONV2D_COLUMN_LOOP_else_else_nor_2_nl,
      STD_LOGIC_VECTOR'("1111111111111"), CONV2D_COLUMN_LOOP_else_else_and_unfl_sva));
  convolution2D_HW_simple_imgConv2DOut_mux_15_nl <= MUX_v_13_2_2(CONV2D_COLUMN_LOOP_else_else_CONV2D_COLUMN_LOOP_else_else_nor_1_nl,
      STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED((pixelCalcHW_simple_for_slc_15_2_sat_sva(13))
      & convolution2D_HW_simple_newPixelVal_11_1_sva),13)), CONV2D_COLUMN_LOOP_if_CONV2D_COLUMN_LOOP_if_and_itm_2);
  CONV2D_COLUMN_LOOP_else_else_CONV2D_COLUMN_LOOP_else_else_nor_2_nl <= NOT((NOT((CONV2D_COLUMN_LOOP_else_else_acc_sat_sva(0))
      OR CONV2D_COLUMN_LOOP_else_else_nor_ovfl_sva)) OR CONV2D_COLUMN_LOOP_else_else_and_unfl_sva);
  convolution2D_HW_simple_imgConv2DOut_mux_16_nl <= MUX_s_1_2_2(CONV2D_COLUMN_LOOP_else_else_CONV2D_COLUMN_LOOP_else_else_nor_2_nl,
      convolution2D_HW_simple_newPixelVal_0_sva, CONV2D_COLUMN_LOOP_if_CONV2D_COLUMN_LOOP_if_and_itm_2);
  convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
      (convolution2D_HW_simple_imgConv2DOut_mux_14_nl & convolution2D_HW_simple_imgConv2DOut_mux_15_nl
      & convolution2D_HW_simple_imgConv2DOut_mux_16_nl), (fsm_output(11)));
  convolution2D_HW_simple_imgConv2DOut_mux1h_6_nl <= MUX1HOT_v_6_3_2((convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva(9
      DOWNTO 4)), z_out_2, CONV2D_COLUMN_LOOP_if_acc_ncse_2, STD_LOGIC_VECTOR'( (fsm_output(1))
      & (fsm_output(10)) & (fsm_output(11))));
  convolution2D_HW_simple_imgConv2DOut_mux1h_7_nl <= MUX1HOT_s_1_3_2((convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva(3)),
      (CONV2D_COLUMN_LOOP_if_acc_1_psp(0)), CONV2D_COLUMN_LOOP_if_acc_1_psp_2_0,
      STD_LOGIC_VECTOR'( (fsm_output(1)) & (fsm_output(10)) & (fsm_output(11))));
  convolution2D_HW_simple_imgConv2DOut_mux1h_8_nl <= MUX1HOT_v_3_3_2((convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva(2
      DOWNTO 0)), (CONV2D_COLUMN_LOOP_column_4_0_sva(2 DOWNTO 0)), reg_CONV2D_COLUMN_LOOP_column_slc_CONV2D_COLUMN_LOOP_column_4_0_2_0_cse,
      STD_LOGIC_VECTOR'( (fsm_output(1)) & (fsm_output(10)) & (fsm_output(11))));
  convolution2D_HW_simple_imgConv2DOut_rsci_addr_d <= convolution2D_HW_simple_imgConv2DOut_mux1h_6_nl
      & convolution2D_HW_simple_imgConv2DOut_mux1h_7_nl & convolution2D_HW_simple_imgConv2DOut_mux1h_8_nl;
  FILL_KERNEL_LOOP_and_stg_1_0 <= NOT(TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(1
      DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  FILL_KERNEL_LOOP_and_stg_2_0 <= FILL_KERNEL_LOOP_and_stg_1_0 AND (NOT (FILL_KERNEL_LOOP_asn_3_itm_3(2)));
  FILL_KERNEL_LOOP_and_stg_1_3 <= TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(1 DOWNTO
      0)=STD_LOGIC_VECTOR'("11"));
  FILL_KERNEL_LOOP_and_stg_1_2 <= TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(1 DOWNTO
      0)=STD_LOGIC_VECTOR'("10"));
  FILL_KERNEL_LOOP_and_stg_1_1 <= TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(1 DOWNTO
      0)=STD_LOGIC_VECTOR'("01"));
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_bias_rsc_triosy_obj_ld_cse <= '0';
        imgPadded_imgPadded_nor_itm_1 <= '0';
        exit_convolution2D_HW_simple_imgConv2DOut_vinit_sva_dfm_1 <= '0';
        convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva_3 <= STD_LOGIC_VECTOR'(
            "0000000000");
        imgPadded_acc_itm_2 <= STD_LOGIC_VECTOR'( "0000000000");
        FILL_PADDED_IMG_MAIN_LOOP_for_else_if_FILL_PADDED_IMG_MAIN_LOOP_for_else_if_nand_itm_3
            <= '0';
        FILL_PADDED_IMG_MAIN_LOOP_asn_1_itm_2 <= '0';
        FILL_PADDED_IMG_MAIN_LOOP_for_slc_FILL_PADDED_IMG_MAIN_LOOP_for_acc_4_svs_st_2
            <= '0';
        FILL_PADDED_IMG_MAIN_LOOP_for_if_FILL_PADDED_IMG_MAIN_LOOP_for_if_nand_itm_3
            <= '0';
        FILL_PADDED_IMG_MAIN_LOOP_stage_0 <= '0';
        FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4 <= STD_LOGIC_VECTOR'( "00000");
        FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4 <= STD_LOGIC_VECTOR'( "00000");
        FILL_KERNEL_LOOP_i_3_0_sva_4 <= STD_LOGIC_VECTOR'( "0000");
        exit_FILL_KERNEL_LOOP_sva_2 <= '0';
        FILL_PADDED_IMG_MAIN_LOOP_stage_0_2 <= '0';
        reg_FILL_PADDED_IMG_MAIN_LOOP_for_if_acc_cse <= STD_LOGIC_VECTOR'( "000000000");
        reg_FILL_PADDED_IMG_MAIN_LOOP_for_column_slc_FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_0_cse
            <= '0';
        FILL_PADDED_IMG_MAIN_LOOP_for_else_if_acc_itm_3 <= STD_LOGIC_VECTOR'( "0000000");
        FILL_PADDED_IMG_MAIN_LOOP_for_else_if_slc_FILL_PADDED_IMG_MAIN_LOOP_for_if_mul_ncse_1_0_itm_3
            <= STD_LOGIC_VECTOR'( "00");
        FILL_KERNEL_LOOP_asn_3_itm_3 <= STD_LOGIC_VECTOR'( "0000");
        CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva <= '0';
        lastChannel_lpi_3_dfm <= '0';
        SHIFT_REG_NEW_LINE_MAIN_for_if_mul_cse_1_sva <= STD_LOGIC_VECTOR'( "000000000");
        SHIFT_REG_NEW_LINE_MAIN_for_if_acc_itm_1 <= STD_LOGIC_VECTOR'( "000000000");
        SHIFT_REG_NEW_LINE_MAIN_for_if_acc_16_itm_1 <= STD_LOGIC_VECTOR'( "00000000");
        SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_7_0_1_itm <=
            STD_LOGIC_VECTOR'( "00000000");
        SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_15_8_1_itm <=
            STD_LOGIC_VECTOR'( "00000000");
        CONV2D_COLUMN_LOOP_asn_5_itm_2 <= '0';
        CONV2D_COLUMN_LOOP_stage_0 <= '0';
        CONV2D_COLUMN_LOOP_column_4_0_sva <= STD_LOGIC_VECTOR'( "00000");
        CONV2D_COLUMN_LOOP_stage_0_2 <= '0';
        CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_3 <= '0';
        CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_and_itm_2 <= '0';
        exit_CONV2D_COLUMN_LOOP_2 <= '0';
        CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_2 <= '0';
        CONV2D_COLUMN_LOOP_if_CONV2D_COLUMN_LOOP_if_and_itm_2 <= '0';
        CONV2D_COLUMN_LOOP_if_acc_ncse_2 <= STD_LOGIC_VECTOR'( "000000");
        CONV2D_COLUMN_LOOP_if_acc_1_psp_2_0 <= '0';
        reg_CONV2D_COLUMN_LOOP_column_slc_CONV2D_COLUMN_LOOP_column_4_0_2_0_cse <=
            STD_LOGIC_VECTOR'( "000");
        CONV2D_COLUMN_LOOP_else_if_acc_8_itm_12_3_2 <= STD_LOGIC_VECTOR'( "0000000000");
        SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_itm_2 <= STD_LOGIC_VECTOR'(
            "0000000000");
        pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_10_itm_2 <= '0';
        pixelCalcHW_simple_for_slc_15_2_sat_2_sva_7_13 <= '0';
        pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_9_itm_2 <= STD_LOGIC_VECTOR'(
            "00000000000");
        pixelCalcHW_simple_for_3_slc_pixelCalcHW_simple_for_acc_4_sdt_14_2_itm_2
            <= STD_LOGIC_VECTOR'( "0000000000000");
      ELSE
        reg_bias_rsc_triosy_obj_ld_cse <= (CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_1(6))
            AND (fsm_output(14));
        imgPadded_imgPadded_nor_itm_1 <= NOT(TO_STDLOGIC(imgPadded_vinit_ndx_sva/=STD_LOGIC_VECTOR'("0000000000")));
        exit_convolution2D_HW_simple_imgConv2DOut_vinit_sva_dfm_1 <= (NOT(TO_STDLOGIC(convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva/=STD_LOGIC_VECTOR'("0000000000"))))
            OR exit_convolution2D_HW_simple_imgConv2DOut_vinit_sva;
        convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva_3 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva)
            + UNSIGNED'( "1111111111"), 10));
        imgPadded_acc_itm_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(imgPadded_vinit_ndx_sva)
            + UNSIGNED'( "1111111111"), 10));
        FILL_PADDED_IMG_MAIN_LOOP_for_else_if_FILL_PADDED_IMG_MAIN_LOOP_for_else_if_nand_itm_3
            <= NOT((NOT(TO_STDLOGIC(FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4=STD_LOGIC_VECTOR'("11001"))))
            AND (TO_STDLOGIC(FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4/=STD_LOGIC_VECTOR'("00000"))));
        FILL_PADDED_IMG_MAIN_LOOP_asn_1_itm_2 <= exit_FILL_KERNEL_LOOP_sva_2;
        FILL_PADDED_IMG_MAIN_LOOP_for_slc_FILL_PADDED_IMG_MAIN_LOOP_for_acc_4_svs_st_2
            <= FILL_PADDED_IMG_MAIN_LOOP_for_acc_itm_4;
        FILL_PADDED_IMG_MAIN_LOOP_for_if_FILL_PADDED_IMG_MAIN_LOOP_for_if_nand_itm_3
            <= NOT((NOT(TO_STDLOGIC(FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4=STD_LOGIC_VECTOR'("11001"))))
            AND (TO_STDLOGIC(FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4/=STD_LOGIC_VECTOR'("00000"))));
        FILL_PADDED_IMG_MAIN_LOOP_stage_0 <= (FILL_PADDED_IMG_MAIN_LOOP_stage_0 AND
            ((FILL_KERNEL_LOOP_acc_itm_3 AND (NOT exit_FILL_KERNEL_LOOP_sva_2)) OR
            FILL_PADDED_IMG_MAIN_LOOP_for_acc_itm_4 OR FILL_PADDED_IMG_MAIN_LOOP_acc_itm_4))
            OR reg_CONV3D_CHANNEL_IN_LOOP_channelInPos_1_CONV3D_CHANNEL_IN_LOOP_channelInPos_or_cse;
        FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4 <= MUX_v_5_2_2(STD_LOGIC_VECTOR'("00000"),
            FILL_PADDED_IMG_MAIN_LOOP_row_mux_nl, CONV3D_CHANNEL_IN_LOOP_channelInPos_not_5_nl);
        FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4 <= FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_1
            AND STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_FILL_PADDED_IMG_MAIN_LOOP_for_or_1_nl,
            1),5)) AND STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(NOT reg_CONV3D_CHANNEL_IN_LOOP_channelInPos_1_CONV3D_CHANNEL_IN_LOOP_channelInPos_or_cse,
            1),5));
        FILL_KERNEL_LOOP_i_3_0_sva_4 <= MUX_v_4_2_2(STD_LOGIC_VECTOR'("0000"), FILL_KERNEL_LOOP_i_mux_nl,
            CONV3D_CHANNEL_IN_LOOP_channelInPos_not_2_nl);
        exit_FILL_KERNEL_LOOP_sva_2 <= NOT((NOT(exit_FILL_KERNEL_LOOP_sva_2 OR (NOT(FILL_KERNEL_LOOP_acc_itm_3
            OR FILL_PADDED_IMG_MAIN_LOOP_for_acc_itm_4)))) OR reg_CONV3D_CHANNEL_IN_LOOP_channelInPos_1_CONV3D_CHANNEL_IN_LOOP_channelInPos_or_cse);
        FILL_PADDED_IMG_MAIN_LOOP_stage_0_2 <= FILL_PADDED_IMG_MAIN_LOOP_stage_0
            AND (NOT reg_CONV3D_CHANNEL_IN_LOOP_channelInPos_1_CONV3D_CHANNEL_IN_LOOP_channelInPos_or_cse);
        reg_FILL_PADDED_IMG_MAIN_LOOP_for_if_acc_cse <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_4)
            + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4(4
            DOWNTO 1)), 4), 9), 9));
        reg_FILL_PADDED_IMG_MAIN_LOOP_for_column_slc_FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_0_cse
            <= FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4(0);
        FILL_PADDED_IMG_MAIN_LOOP_for_else_if_acc_itm_3 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_4(8
            DOWNTO 2)) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(CONV_SIGNED(CONV_SIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_column_4_0_sva_4(3),
            1),2)), 2), 7), 7));
        FILL_PADDED_IMG_MAIN_LOOP_for_else_if_slc_FILL_PADDED_IMG_MAIN_LOOP_for_if_mul_ncse_1_0_itm_3
            <= z_out_4(1 DOWNTO 0);
        FILL_KERNEL_LOOP_asn_3_itm_3 <= FILL_KERNEL_LOOP_i_3_0_sva_4;
        CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva <= MUX_s_1_2_2(CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva_mx0w0,
            CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva, or_tmp_94);
        lastChannel_lpi_3_dfm <= MUX_s_1_2_2(CONV3D_CHANNEL_IN_LOOP_else_CONV3D_CHANNEL_IN_LOOP_else_if_CONV3D_CHANNEL_IN_LOOP_else_if_nor_nl,
            lastChannel_lpi_3_dfm, or_tmp_94);
        SHIFT_REG_NEW_LINE_MAIN_for_if_mul_cse_1_sva <= MUX_v_9_2_2(z_out_4, SHIFT_REG_NEW_LINE_MAIN_for_if_mul_cse_1_sva,
            or_146_nl);
        SHIFT_REG_NEW_LINE_MAIN_for_if_acc_itm_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_4)
            + UNSIGNED'( "000001101"), 9));
        SHIFT_REG_NEW_LINE_MAIN_for_if_acc_16_itm_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_4(8
            DOWNTO 1)) + UNSIGNED'( "00000111"), 8));
        SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_7_0_1_itm <=
            imgPadded_rsci_data_out_d(7 DOWNTO 0);
        SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_15_8_1_itm <=
            imgPadded_rsci_data_out_d(15 DOWNTO 8);
        CONV2D_COLUMN_LOOP_asn_5_itm_2 <= exit_CONV2D_COLUMN_LOOP_2;
        CONV2D_COLUMN_LOOP_stage_0 <= (CONV2D_COLUMN_LOOP_stage_0 AND (NOT((NOT(TO_STDLOGIC(fsm_output(11
            DOWNTO 10)/=STD_LOGIC_VECTOR'("00")))) OR (CONV2D_COLUMN_LOOP_stage_0_1
            AND (NOT z_out_5_2) AND (fsm_output(10)))))) OR (fsm_output(9));
        CONV2D_COLUMN_LOOP_column_4_0_sva <= MUX_v_5_2_2(STD_LOGIC_VECTOR'("00000"),
            FILL_PADDED_IMG_MAIN_LOOP_row_mux_1_nl, or_192_nl);
        CONV2D_COLUMN_LOOP_stage_0_2 <= CONV2D_COLUMN_LOOP_stage_0_1 AND (fsm_output(11));
        CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_3 <= CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_2;
        CONV2D_COLUMN_LOOP_else_if_CONV2D_COLUMN_LOOP_else_if_and_itm_2 <= lastChannel_lpi_3_dfm
            AND (NOT CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva);
        exit_CONV2D_COLUMN_LOOP_2 <= NOT z_out_5_2;
        CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_2 <= z_out(5);
        CONV2D_COLUMN_LOOP_if_CONV2D_COLUMN_LOOP_if_and_itm_2 <= (NOT lastChannel_lpi_3_dfm)
            AND CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva;
        CONV2D_COLUMN_LOOP_if_acc_ncse_2 <= z_out_2;
        CONV2D_COLUMN_LOOP_if_acc_1_psp_2_0 <= CONV2D_COLUMN_LOOP_if_acc_1_psp(0);
        reg_CONV2D_COLUMN_LOOP_column_slc_CONV2D_COLUMN_LOOP_column_4_0_2_0_cse <=
            CONV2D_COLUMN_LOOP_column_4_0_sva(2 DOWNTO 0);
        CONV2D_COLUMN_LOOP_else_if_acc_8_itm_12_3_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(z_out_2(5
            DOWNTO 2)), 4), 10) + UNSIGNED(CONV3D_CHANNEL_IN_LOOP_acc_4_psp_sva_1
            & (CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_0_1(2 DOWNTO 0))), 10));
        SHIFT_REG_NEW_PIXEL_MAIN_3_if_SHIFT_REG_NEW_PIXEL_MAIN_if_acc_itm_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(SHIFT_REG_NEW_PIXEL_MAIN_if_acc_nl),
            5)) & (CONV2D_COLUMN_LOOP_column_4_0_sva(0))), 6), 10) + UNSIGNED(SHIFT_REG_NEW_LINE_MAIN_for_if_mul_cse_1_sva
            & '1'), 10));
        pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_10_itm_2 <= NOT((NOT((pixelCalcHW_simple_for_slc_15_2_sat_2_sva(0))
            OR pixelCalcHW_simple_for_nor_ovfl_11_sva)) OR pixelCalcHW_simple_for_and_unfl_11_sva);
        pixelCalcHW_simple_for_slc_15_2_sat_2_sva_7_13 <= pixelCalcHW_simple_for_slc_15_2_sat_2_sva(13);
        pixelCalcHW_simple_for_2_pixelCalcHW_simple_for_nor_9_itm_2 <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_2_nor_16_nl,
            STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_11_sva));
        pixelCalcHW_simple_for_3_slc_pixelCalcHW_simple_for_acc_4_sdt_14_2_itm_2
            <= readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(pixelCalcHW_simple_for_3_acc_4_nl),
            15)), 2, 13);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva <= STD_LOGIC_VECTOR'(
            "1000111111");
      ELSIF ( (fsm_output(2)) = '1' ) THEN
        convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva <= convolution2D_HW_simple_imgConv2DOut_vinit_ndx_sva_3;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        imgPadded_vinit_ndx_sva <= STD_LOGIC_VECTOR'( "1010100011");
      ELSIF ( (fsm_output(2)) = '1' ) THEN
        imgPadded_vinit_ndx_sva <= imgPadded_acc_itm_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        exit_convolution2D_HW_simple_imgConv2DOut_vinit_sva <= '0';
      ELSIF ( (fsm_output(2)) = '1' ) THEN
        exit_convolution2D_HW_simple_imgConv2DOut_vinit_sva <= exit_convolution2D_HW_simple_imgConv2DOut_vinit_sva_dfm_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line1Reg_2_sva <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (fsm_output(14)) = '1' ) THEN
        convolution2D_HW_simple_line1Reg_2_sva <= convolution2D_HW_simple_line1Reg_2_sva_1_dfm;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line2Reg_2_sva <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (fsm_output(14)) = '1' ) THEN
        convolution2D_HW_simple_line2Reg_2_sva <= convolution2D_HW_simple_line2Reg_2_sva_1_dfm;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line3Reg_2_sva <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (fsm_output(14)) = '1' ) THEN
        convolution2D_HW_simple_line3Reg_2_sva <= convolution2D_HW_simple_line3Reg_2_sva_1_dfm;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4 <= STD_LOGIC_VECTOR'( "00");
      ELSIF ( reg_CONV3D_CHANNEL_IN_LOOP_channelInPos_1_CONV3D_CHANNEL_IN_LOOP_channelInPos_or_cse
          = '1' ) THEN
        CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4 <= MUX_v_2_2_2(STD_LOGIC_VECTOR'("00"),
            STD_LOGIC_VECTOR'( CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_1_1 &
            (NOT (CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4(0)))), CONV3D_MAIN_LOOP_channelOutPos_not_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_0_1 <= STD_LOGIC_VECTOR'( "000000");
      ELSIF ( reg_CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_CONV3D_MAIN_LOOP_channelOutPos_or_cse
          = '1' ) THEN
        CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_0_1 <= MUX_v_6_2_2(STD_LOGIC_VECTOR'("000000"),
            (CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_1(5 DOWNTO 0)), (fsm_output(14)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line3Reg_2_lpi_4 <= STD_LOGIC_VECTOR'( "00000000");
        convolution2D_HW_simple_line2Reg_2_lpi_4 <= STD_LOGIC_VECTOR'( "00000000");
        convolution2D_HW_simple_line1Reg_2_lpi_4 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( reg_convolution2D_HW_simple_convolution2D_HW_simple_line3Reg_or_cse
          = '1' ) THEN
        convolution2D_HW_simple_line3Reg_2_lpi_4 <= MUX_v_8_2_2(convolution2D_HW_simple_line3Reg_2_sva,
            convolution2D_HW_simple_line3Reg_2_sva_1_dfm, or_tmp_77);
        convolution2D_HW_simple_line2Reg_2_lpi_4 <= MUX_v_8_2_2(convolution2D_HW_simple_line2Reg_2_sva,
            convolution2D_HW_simple_line2Reg_2_sva_1_dfm, or_tmp_77);
        convolution2D_HW_simple_line1Reg_2_lpi_4 <= MUX_v_8_2_2(convolution2D_HW_simple_line1Reg_2_sva,
            convolution2D_HW_simple_line1Reg_2_sva_1_dfm, or_tmp_77);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        CONV2D_MAIN_LOOP_row_4_0_sva_3 <= STD_LOGIC_VECTOR'( "00000");
      ELSIF ( ((fsm_output(5)) OR (fsm_output(12))) = '1' ) THEN
        CONV2D_MAIN_LOOP_row_4_0_sva_3 <= MUX_v_5_2_2(STD_LOGIC_VECTOR'("00000"),
            z_out_3, (fsm_output(12)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        CONV3D_CHANNEL_IN_LOOP_acc_4_psp_sva_1 <= STD_LOGIC_VECTOR'( "0000000");
      ELSIF ( or_tmp_94 = '0' ) THEN
        CONV3D_CHANNEL_IN_LOOP_acc_4_psp_sva_1 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        SHIFT_REG_NEW_LINE_MAIN_for_if_acc_15_itm <= STD_LOGIC_VECTOR'( "000000000");
      ELSIF ( (fsm_output(6)) = '1' ) THEN
        SHIFT_REG_NEW_LINE_MAIN_for_if_acc_15_itm <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_4)
            + UNSIGNED'( "000000001"), 9));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_15_8_2_itm <=
            STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (fsm_output(7)) = '1' ) THEN
        SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_15_8_2_itm <=
            imgPadded_rsci_data_out_d(15 DOWNTO 8);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_7_0_2_itm <=
            STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (fsm_output(7)) = '1' ) THEN
        SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_7_0_2_itm <=
            imgPadded_rsci_data_out_d(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line3Reg_0_sva <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( convolution2D_HW_simple_line3Reg_or_rgt = '0' ) THEN
        convolution2D_HW_simple_line3Reg_0_sva <= MUX_v_8_2_2(convolution2D_HW_simple_line3Reg_2_lpi_4,
            convolution2D_HW_simple_line3Reg_1_sva, convolution2D_HW_simple_line3Reg_and_rgt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line2Reg_0_sva <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( convolution2D_HW_simple_line3Reg_or_rgt = '0' ) THEN
        convolution2D_HW_simple_line2Reg_0_sva <= MUX_v_8_2_2(convolution2D_HW_simple_line2Reg_2_lpi_4,
            convolution2D_HW_simple_line2Reg_1_sva, convolution2D_HW_simple_line3Reg_and_rgt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line1Reg_0_sva <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( convolution2D_HW_simple_line3Reg_or_rgt = '0' ) THEN
        convolution2D_HW_simple_line1Reg_0_sva <= MUX_v_8_2_2(convolution2D_HW_simple_line1Reg_2_lpi_4,
            convolution2D_HW_simple_line1Reg_1_sva, convolution2D_HW_simple_line3Reg_and_rgt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        CONV2D_COLUMN_LOOP_stage_0_1 <= '0';
      ELSIF ( CONV2D_COLUMN_LOOP_or_cse = '1' ) THEN
        CONV2D_COLUMN_LOOP_stage_0_1 <= CONV2D_COLUMN_LOOP_stage_0 OR (fsm_output(9));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line1Reg_2_sva_1 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (NOT(((NOT convolution2D_HW_simple_line1Reg_and_3_tmp) AND (fsm_output(10)))
          OR (fsm_output(11)))) = '1' ) THEN
        convolution2D_HW_simple_line1Reg_2_sva_1 <= imgPadded_rsci_data_out_d(7 DOWNTO
            0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line3Reg_2_sva_1 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( SHIFT_REG_NEW_LINE_MAIN_for_if_or_4_rgt = '0' ) THEN
        convolution2D_HW_simple_line3Reg_2_sva_1 <= MUX_v_8_2_2(SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_15_8_2_itm,
            (imgPadded_rsci_data_out_d(7 DOWNTO 0)), SHIFT_REG_NEW_LINE_MAIN_for_if_and_9_rgt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line2Reg_2_sva_1 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( SHIFT_REG_NEW_LINE_MAIN_for_if_or_4_rgt = '0' ) THEN
        convolution2D_HW_simple_line2Reg_2_sva_1 <= MUX_v_8_2_2(SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_7_0_1_itm,
            (imgPadded_rsci_data_out_d(15 DOWNTO 8)), SHIFT_REG_NEW_LINE_MAIN_for_if_and_9_rgt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line3Reg_1_sva <= STD_LOGIC_VECTOR'( "00000000");
        convolution2D_HW_simple_line2Reg_1_sva <= STD_LOGIC_VECTOR'( "00000000");
        convolution2D_HW_simple_line1Reg_1_sva <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( SHIFT_REG_NEW_LINE_MAIN_for_if_SHIFT_REG_NEW_LINE_MAIN_for_if_nor_2_cse
          = '1' ) THEN
        convolution2D_HW_simple_line3Reg_1_sva <= MUX_v_8_2_2(SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_7_0_2_itm,
            convolution2D_HW_simple_line3Reg_2_sva_1, convolution2D_HW_simple_line3Reg_and_rgt);
        convolution2D_HW_simple_line2Reg_1_sva <= MUX_v_8_2_2(SHIFT_REG_NEW_LINE_MAIN_for_if_slc_imgPadded_rsci_data_out_d_15_8_1_itm,
            convolution2D_HW_simple_line2Reg_2_sva_1, convolution2D_HW_simple_line3Reg_and_rgt);
        convolution2D_HW_simple_line1Reg_1_sva <= MUX_v_8_2_2((imgPadded_rsci_data_out_d(15
            DOWNTO 8)), convolution2D_HW_simple_line1Reg_2_sva_1_mx1, convolution2D_HW_simple_line3Reg_and_rgt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line1Reg_2_sva_1_dfm <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (TO_STDLOGIC(fsm_output(13 DOWNTO 11)=STD_LOGIC_VECTOR'("000")) AND
          CONV2D_COLUMN_LOOP_stage_0_2) = '1' ) THEN
        convolution2D_HW_simple_line1Reg_2_sva_1_dfm <= MUX_v_8_2_2((imgPadded_rsci_data_out_d(7
            DOWNTO 0)), convolution2D_HW_simple_line1Reg_2_sva_1, and_90_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        convolution2D_HW_simple_line3Reg_2_sva_1_dfm <= STD_LOGIC_VECTOR'( "00000000");
        convolution2D_HW_simple_line2Reg_2_sva_1_dfm <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( convolution2D_HW_simple_line3Reg_and_2_cse = '1' ) THEN
        convolution2D_HW_simple_line3Reg_2_sva_1_dfm <= MUX_v_8_2_2((imgPadded_rsci_data_out_d(7
            DOWNTO 0)), convolution2D_HW_simple_line3Reg_2_sva_1, and_dcpl_54);
        convolution2D_HW_simple_line2Reg_2_sva_1_dfm <= MUX_v_8_2_2((imgPadded_rsci_data_out_d(15
            DOWNTO 8)), convolution2D_HW_simple_line2Reg_2_sva_1, and_dcpl_54);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_kernel2D_tmp <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (kernel2D_nor_ssc AND FILL_KERNEL_LOOP_and_stg_2_0 AND (FILL_KERNEL_LOOP_asn_3_itm_3(3)))
          = '1' ) THEN
        reg_kernel2D_tmp <= kernel_rsci_data_out_d(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_kernel2D_tmp_1 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (kernel2D_nor_ssc AND FILL_KERNEL_LOOP_and_stg_1_3 AND TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(3
          DOWNTO 2)=STD_LOGIC_VECTOR'("01"))) = '1' ) THEN
        reg_kernel2D_tmp_1 <= kernel_rsci_data_out_d(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_kernel2D_tmp_2 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (kernel2D_nor_ssc AND FILL_KERNEL_LOOP_and_stg_1_2 AND TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(3
          DOWNTO 2)=STD_LOGIC_VECTOR'("01"))) = '1' ) THEN
        reg_kernel2D_tmp_2 <= kernel_rsci_data_out_d(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_kernel2D_tmp_3 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (kernel2D_nor_ssc AND FILL_KERNEL_LOOP_and_stg_1_1 AND TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(3
          DOWNTO 2)=STD_LOGIC_VECTOR'("01"))) = '1' ) THEN
        reg_kernel2D_tmp_3 <= kernel_rsci_data_out_d(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_kernel2D_tmp_4 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (kernel2D_nor_ssc AND FILL_KERNEL_LOOP_and_stg_1_0 AND TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(3
          DOWNTO 2)=STD_LOGIC_VECTOR'("01"))) = '1' ) THEN
        reg_kernel2D_tmp_4 <= kernel_rsci_data_out_d(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_kernel2D_tmp_5 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (kernel2D_nor_ssc AND FILL_KERNEL_LOOP_and_stg_1_3 AND TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(3
          DOWNTO 2)=STD_LOGIC_VECTOR'("00"))) = '1' ) THEN
        reg_kernel2D_tmp_5 <= kernel_rsci_data_out_d(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_kernel2D_tmp_6 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (kernel2D_nor_ssc AND FILL_KERNEL_LOOP_and_stg_1_2 AND TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(3
          DOWNTO 2)=STD_LOGIC_VECTOR'("00"))) = '1' ) THEN
        reg_kernel2D_tmp_6 <= kernel_rsci_data_out_d(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_kernel2D_tmp_7 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (kernel2D_nor_ssc AND FILL_KERNEL_LOOP_and_stg_1_1 AND TO_STDLOGIC(FILL_KERNEL_LOOP_asn_3_itm_3(3
          DOWNTO 2)=STD_LOGIC_VECTOR'("00"))) = '1' ) THEN
        reg_kernel2D_tmp_7 <= kernel_rsci_data_out_d(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_kernel2D_tmp_8 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( (kernel2D_nor_ssc AND FILL_KERNEL_LOOP_and_stg_2_0 AND (NOT (FILL_KERNEL_LOOP_asn_3_itm_3(3))))
          = '1' ) THEN
        reg_kernel2D_tmp_8 <= kernel_rsci_data_out_d(7 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  FILL_PADDED_IMG_MAIN_LOOP_row_mux_nl <= MUX_v_5_2_2(z_out_3, FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4,
      FILL_PADDED_IMG_MAIN_LOOP_row_and_1_cse);
  CONV3D_CHANNEL_IN_LOOP_channelInPos_not_5_nl <= NOT reg_CONV3D_CHANNEL_IN_LOOP_channelInPos_1_CONV3D_CHANNEL_IN_LOOP_channelInPos_or_cse;
  FILL_PADDED_IMG_MAIN_LOOP_for_FILL_PADDED_IMG_MAIN_LOOP_for_or_1_nl <= (NOT(FILL_PADDED_IMG_MAIN_LOOP_acc_itm_4
      OR (NOT((NOT FILL_KERNEL_LOOP_acc_itm_3) OR exit_FILL_KERNEL_LOOP_sva_2))))
      OR FILL_PADDED_IMG_MAIN_LOOP_for_acc_itm_4;
  FILL_KERNEL_LOOP_i_mux_nl <= MUX_v_4_2_2(FILL_KERNEL_LOOP_i_3_0_sva_1, FILL_KERNEL_LOOP_i_3_0_sva_4,
      FILL_PADDED_IMG_MAIN_LOOP_row_and_1_cse);
  CONV3D_CHANNEL_IN_LOOP_channelInPos_not_2_nl <= NOT reg_CONV3D_CHANNEL_IN_LOOP_channelInPos_1_CONV3D_CHANNEL_IN_LOOP_channelInPos_or_cse;
  CONV3D_CHANNEL_IN_LOOP_else_CONV3D_CHANNEL_IN_LOOP_else_if_CONV3D_CHANNEL_IN_LOOP_else_if_nor_nl
      <= NOT((CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4(0)) OR CONV3D_CHANNEL_IN_LOOP_CONV3D_CHANNEL_IN_LOOP_if_nor_mdf_sva_mx0w0);
  or_146_nl <= TO_STDLOGIC(fsm_output(11 DOWNTO 7)/=STD_LOGIC_VECTOR'("00000"));
  FILL_PADDED_IMG_MAIN_LOOP_row_and_nl <= CONV2D_COLUMN_LOOP_stage_0_1 AND (NOT (fsm_output(11)));
  FILL_PADDED_IMG_MAIN_LOOP_row_mux_1_nl <= MUX_v_5_2_2(CONV2D_COLUMN_LOOP_column_4_0_sva,
      z_out_3, FILL_PADDED_IMG_MAIN_LOOP_row_and_nl);
  or_192_nl <= TO_STDLOGIC(fsm_output(11 DOWNTO 10)/=STD_LOGIC_VECTOR'("00"));
  SHIFT_REG_NEW_PIXEL_MAIN_if_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(CONV2D_COLUMN_LOOP_column_4_0_sva(4
      DOWNTO 1)), 4), 5) + UNSIGNED'( "00001"), 5));
  pixelCalcHW_simple_for_2_nor_16_nl <= NOT(MUX_v_11_2_2((pixelCalcHW_simple_for_slc_15_2_sat_2_sva(11
      DOWNTO 1)), STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_nor_ovfl_11_sva));
  pixelCalcHW_simple_for_3_nor_7_nl <= NOT(MUX_v_11_2_2((z_out_6(12 DOWNTO 2)), STD_LOGIC_VECTOR'("11111111111"),
      pixelCalcHW_simple_for_nor_ovfl_sva));
  pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_nl <= NOT(MUX_v_11_2_2(pixelCalcHW_simple_for_3_nor_7_nl,
      STD_LOGIC_VECTOR'("11111111111"), pixelCalcHW_simple_for_and_unfl_sva));
  pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_1_nl <= NOT((NOT((z_out_6(1))
      OR pixelCalcHW_simple_for_nor_ovfl_sva)) OR pixelCalcHW_simple_for_and_unfl_sva);
  pixelCalcHW_simple_for_3_acc_4_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(z_out_1
      & (pixelCalcHW_simple_for_acc_16_sdt(11 DOWNTO 0))) + SIGNED(STD_LOGIC_VECTOR'(
      "101") & pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_nl & pixelCalcHW_simple_for_3_pixelCalcHW_simple_for_nor_1_nl),
      15));
  CONV3D_MAIN_LOOP_channelOutPos_not_nl <= NOT reg_CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_CONV3D_MAIN_LOOP_channelOutPos_or_cse;
  and_90_nl <= (NOT CONV2D_COLUMN_LOOP_if_1_slc_CONV2D_COLUMN_LOOP_acc_1_5_svs_3)
      AND CONV2D_COLUMN_LOOP_stage_0_2;
  CONV3D_CHANNEL_IN_LOOP_mux_4_nl <= MUX_v_6_2_2(CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_0_1,
      STD_LOGIC_VECTOR'( "101001"), fsm_output(10));
  CONV3D_CHANNEL_IN_LOOP_mux_5_nl <= MUX_v_5_2_2((STD_LOGIC_VECTOR'( "00") & (CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_0_1(5
      DOWNTO 3))), CONV2D_COLUMN_LOOP_column_4_0_sva, fsm_output(10));
  z_out <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(CONV3D_CHANNEL_IN_LOOP_mux_4_nl),
      7) + CONV_UNSIGNED(UNSIGNED(CONV3D_CHANNEL_IN_LOOP_mux_5_nl), 7), 7));
  pixelCalcHW_simple_for_3_pixelCalcHW_simple_prod1_pixelCalcHW_simple_for_or_1_nl
      <= (NOT((z_out_6(13)) OR pixelCalcHW_simple_for_and_unfl_sva)) OR pixelCalcHW_simple_for_nor_ovfl_sva;
  pixelCalcHW_simple_for_3_pixelCalcHW_simple_prod2_pixelCalcHW_simple_for_or_1_nl
      <= (NOT((pixelCalcHW_simple_for_3_mul_1_itm_15_1(12)) OR pixelCalcHW_simple_for_and_unfl_1_sva))
      OR pixelCalcHW_simple_for_nor_ovfl_1_sva;
  pixelCalcHW_simple_for_3_pixelCalcHW_simple_prod3_pixelCalcHW_simple_for_or_1_nl
      <= (NOT((pixelCalcHW_simple_for_3_mul_2_itm_15_1(12)) OR pixelCalcHW_simple_for_and_unfl_2_sva))
      OR pixelCalcHW_simple_for_nor_ovfl_2_sva;
  pixelCalcHW_simple_for_acc_33_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_3_pixelCalcHW_simple_prod1_pixelCalcHW_simple_for_or_1_nl,
      1), 2) + CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_3_pixelCalcHW_simple_prod2_pixelCalcHW_simple_for_or_1_nl,
      1), 2) + CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_3_pixelCalcHW_simple_prod3_pixelCalcHW_simple_for_or_1_nl,
      1), 2), 2));
  pixelCalcHW_simple_for_mux_4_nl <= MUX_v_2_2_2(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_acc_33_nl),
      2)), CONV3D_CHANNEL_IN_LOOP_channelInPos_1_0_sva_4, fsm_output(4));
  pixelCalcHW_simple_for_mux_5_nl <= MUX_s_1_2_2((pixelCalcHW_simple_for_acc_16_sdt(12)),
      (FILL_KERNEL_LOOP_acc_5_psp(3)), fsm_output(4));
  z_out_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(pixelCalcHW_simple_for_mux_4_nl),
      3) + CONV_UNSIGNED(CONV_UNSIGNED(pixelCalcHW_simple_for_mux_5_nl, 1), 3), 3));
  FILL_PADDED_IMG_MAIN_LOOP_for_else_else_mux_2_nl <= MUX_v_5_2_2(FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4,
      CONV2D_MAIN_LOOP_row_4_0_sva_3, fsm_output(10));
  FILL_PADDED_IMG_MAIN_LOOP_for_else_else_mux_3_nl <= MUX_v_4_2_2(((FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_9_sdt(4
      DOWNTO 3)) & '1' & (FILL_PADDED_IMG_MAIN_LOOP_for_else_else_acc_9_sdt(1))),
      (CONV2D_COLUMN_LOOP_if_acc_1_psp(4 DOWNTO 1)), fsm_output(10));
  z_out_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_else_else_mux_2_nl),
      6) + CONV_UNSIGNED(UNSIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_else_else_mux_3_nl),
      6), 6));
  FILL_PADDED_IMG_MAIN_LOOP_mux1h_9_nl <= MUX1HOT_v_5_3_2(FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4,
      CONV2D_MAIN_LOOP_row_4_0_sva_3, CONV2D_COLUMN_LOOP_column_4_0_sva, STD_LOGIC_VECTOR'(
      (fsm_output(4)) & (fsm_output(12)) & (fsm_output(10))));
  z_out_3 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(FILL_PADDED_IMG_MAIN_LOOP_mux1h_9_nl)
      + UNSIGNED'( "00001"), 5));
  FILL_PADDED_IMG_MAIN_LOOP_for_if_mux_1_nl <= MUX_v_5_2_2(FILL_PADDED_IMG_MAIN_LOOP_row_4_0_sva_4,
      CONV2D_MAIN_LOOP_row_4_0_sva_3, fsm_output(6));
  z_out_4 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED'( "1101") * UNSIGNED(FILL_PADDED_IMG_MAIN_LOOP_for_if_mux_1_nl)),
      9));
  CONV2D_COLUMN_LOOP_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1' & (z_out_3(4
      DOWNTO 3))) + UNSIGNED'( "001"), 3));
  z_out_5_2 <= readindex(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(CONV2D_COLUMN_LOOP_acc_nl),
      3)), 2);
  pixelCalcHW_simple_for_mux_6_nl <= MUX_v_8_2_2(reg_kernel2D_tmp_6, (STD_LOGIC_VECTOR'(
      "00") & CONV3D_MAIN_LOOP_channelOutPos_6_0_sva_5_0_1), fsm_output(4));
  pixelCalcHW_simple_for_mux_7_nl <= MUX_v_8_2_2(convolution2D_HW_simple_line1Reg_2_sva_1_mx1,
      STD_LOGIC_VECTOR'( "00011011"), fsm_output(4));
  z_out_6 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(SIGNED'( SIGNED(pixelCalcHW_simple_for_mux_6_nl)
      * SIGNED(pixelCalcHW_simple_for_mux_7_nl)), 16));
END v2;

-- ------------------------------------------------------------------
--  Design Unit:    convolution3D_HW
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.dualport_ram_be_pkg.ALL;


ENTITY convolution3D_HW IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    kernel_rsc_addr : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
    kernel_rsc_re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    kernel_rsc_data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    kernel_rsc_triosy_lz : OUT STD_LOGIC;
    imgIn_rsc_addr : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
    imgIn_rsc_re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    imgIn_rsc_data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    imgIn_rsc_triosy_lz : OUT STD_LOGIC;
    imgOut_rsc_data_in : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
    imgOut_rsc_addr : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    imgOut_rsc_we : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    imgOut_rsc_triosy_lz : OUT STD_LOGIC;
    bias_rsc_addr : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    bias_rsc_re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    bias_rsc_data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    bias_rsc_triosy_lz : OUT STD_LOGIC
  );
END convolution3D_HW;

ARCHITECTURE v2 OF convolution3D_HW IS
  -- Default Constants
  SIGNAL PWR : STD_LOGIC;
  SIGNAL GND : STD_LOGIC;

  -- Interconnect Declarations
  SIGNAL kernel_rsci_addr_d : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL kernel_rsci_re_d : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL kernel_rsci_data_out_d : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL imgIn_rsci_addr_d : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL imgIn_rsci_re_d : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgIn_rsci_data_out_d : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL imgOut_rsci_data_in_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL imgOut_rsci_addr_d : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL imgOut_rsci_we_d : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL bias_rsci_addr_d : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL bias_rsci_re_d : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL bias_rsci_data_out_d : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL imgPadded_rsci_data_in_d : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL imgPadded_rsci_addr_d : STD_LOGIC_VECTOR (19 DOWNTO 0);
  SIGNAL imgPadded_rsci_re_d : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgPadded_rsci_we_d : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgPadded_rsci_data_out_d : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d : STD_LOGIC_VECTOR (14
      DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_addr_d : STD_LOGIC_VECTOR (9 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_re_d : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_we_d : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d : STD_LOGIC_VECTOR
      (29 DOWNTO 0);
  SIGNAL imgPadded_rsc_en : STD_LOGIC;
  SIGNAL imgPadded_rsc_data_out : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL imgPadded_rsc_we : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgPadded_rsc_re : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgPadded_rsc_addr : STD_LOGIC_VECTOR (19 DOWNTO 0);
  SIGNAL imgPadded_rsc_data_in : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_en : STD_LOGIC;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_data_out : STD_LOGIC_VECTOR (29
      DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_we : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_re : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_addr : STD_LOGIC_VECTOR (19 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_data_in : STD_LOGIC_VECTOR (29
      DOWNTO 0);

  SIGNAL imgPadded_rsc_comp_data_in : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL imgPadded_rsc_comp_addr : STD_LOGIC_VECTOR (19 DOWNTO 0);
  SIGNAL imgPadded_rsc_comp_re : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgPadded_rsc_comp_we : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgPadded_rsc_comp_data_out : STD_LOGIC_VECTOR (15 DOWNTO 0);

  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_comp_data_in : STD_LOGIC_VECTOR
      (29 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_comp_addr : STD_LOGIC_VECTOR (19
      DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_comp_re : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_comp_we : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsc_comp_data_out : STD_LOGIC_VECTOR
      (29 DOWNTO 0);

  COMPONENT ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_1_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen
    PORT(
      data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      addr : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
      addr_d : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
      re_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      data_out_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL kernel_rsci_data_out : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL kernel_rsci_re : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL kernel_rsci_addr : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL kernel_rsci_addr_d_1 : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL kernel_rsci_re_d_1 : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL kernel_rsci_data_out_d_1 : STD_LOGIC_VECTOR (15 DOWNTO 0);

  COMPONENT ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_2_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen
    PORT(
      data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      addr : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
      addr_d : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
      re_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      data_out_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL imgIn_rsci_data_out : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL imgIn_rsci_re : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgIn_rsci_addr : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL imgIn_rsci_addr_d_1 : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL imgIn_rsci_re_d_1 : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgIn_rsci_data_out_d_1 : STD_LOGIC_VECTOR (15 DOWNTO 0);

  COMPONENT ram_Xilinx_ARTIX_7_1_RAMDB_dualport_wport_3_36864_12_16_0_1_0_0_0_1_1_1_0_36864_12_2_gen
    PORT(
      we : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      addr : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
      data_in : OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
      data_in_d : IN STD_LOGIC_VECTOR (23 DOWNTO 0);
      addr_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      we_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL imgOut_rsci_we : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgOut_rsci_addr : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL imgOut_rsci_data_in : STD_LOGIC_VECTOR (23 DOWNTO 0);
  SIGNAL imgOut_rsci_data_in_d_1 : STD_LOGIC_VECTOR (23 DOWNTO 0);
  SIGNAL imgOut_rsci_addr_d_1 : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL imgOut_rsci_we_d_1 : STD_LOGIC_VECTOR (1 DOWNTO 0);

  COMPONENT ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_4_64_8_6_0_1_0_0_0_1_1_1_0_64_8_2_gen
    PORT(
      data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      addr : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      addr_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      re_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      data_out_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL bias_rsci_data_out : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL bias_rsci_re : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL bias_rsci_addr : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL bias_rsci_addr_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL bias_rsci_re_d_1 : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL bias_rsci_data_out_d_1 : STD_LOGIC_VECTOR (15 DOWNTO 0);

  COMPONENT ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_6_676_8_10_0_1_0_0_0_1_1_1_0_676_8_2_gen
    PORT(
      en : OUT STD_LOGIC;
      data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      we : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      addr : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
      data_in : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
      data_in_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      addr_d : IN STD_LOGIC_VECTOR (19 DOWNTO 0);
      re_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      we_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      data_out_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
      en_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL imgPadded_rsci_data_out : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL imgPadded_rsci_we : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgPadded_rsci_re : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgPadded_rsci_addr : STD_LOGIC_VECTOR (19 DOWNTO 0);
  SIGNAL imgPadded_rsci_data_in : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL imgPadded_rsci_data_in_d_1 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL imgPadded_rsci_addr_d_1 : STD_LOGIC_VECTOR (19 DOWNTO 0);
  SIGNAL imgPadded_rsci_re_d_1 : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgPadded_rsci_we_d_1 : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL imgPadded_rsci_data_out_d_1 : STD_LOGIC_VECTOR (15 DOWNTO 0);

  COMPONENT ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_10_576_15_10_0_1_0_0_0_1_1_1_0_576_15_2_gen
    PORT(
      en : OUT STD_LOGIC;
      data_out : IN STD_LOGIC_VECTOR (29 DOWNTO 0);
      we : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      re : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      addr : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
      data_in : OUT STD_LOGIC_VECTOR (29 DOWNTO 0);
      data_in_d : IN STD_LOGIC_VECTOR (29 DOWNTO 0);
      addr_d : IN STD_LOGIC_VECTOR (19 DOWNTO 0);
      re_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      we_d : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      data_out_d : OUT STD_LOGIC_VECTOR (29 DOWNTO 0);
      en_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_data_out : STD_LOGIC_VECTOR (29
      DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_we : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_re : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_addr : STD_LOGIC_VECTOR (19 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_data_in : STD_LOGIC_VECTOR (29
      DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d_1 : STD_LOGIC_VECTOR
      (29 DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_addr_d_1 : STD_LOGIC_VECTOR (19
      DOWNTO 0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_re_d_1 : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_we_d_1 : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d_1 : STD_LOGIC_VECTOR
      (29 DOWNTO 0);

  COMPONENT convolution3D_HW_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      kernel_rsc_triosy_lz : OUT STD_LOGIC;
      imgIn_rsc_triosy_lz : OUT STD_LOGIC;
      imgOut_rsc_triosy_lz : OUT STD_LOGIC;
      bias_rsc_triosy_lz : OUT STD_LOGIC;
      kernel_rsci_addr_d : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      kernel_rsci_re_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      kernel_rsci_data_out_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      imgIn_rsci_addr_d : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      imgIn_rsci_re_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      imgIn_rsci_data_out_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      imgOut_rsci_data_in_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      imgOut_rsci_addr_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
      imgOut_rsci_we_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      bias_rsci_addr_d : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
      bias_rsci_re_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      bias_rsci_data_out_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      imgPadded_rsci_data_in_d : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      imgPadded_rsci_addr_d : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
      imgPadded_rsci_re_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      imgPadded_rsci_we_d : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      imgPadded_rsci_data_out_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d : OUT STD_LOGIC_VECTOR
          (14 DOWNTO 0);
      convolution2D_HW_simple_imgConv2DOut_rsci_addr_d : OUT STD_LOGIC_VECTOR (9
          DOWNTO 0);
      convolution2D_HW_simple_imgConv2DOut_rsci_re_d : OUT STD_LOGIC_VECTOR (1 DOWNTO
          0);
      convolution2D_HW_simple_imgConv2DOut_rsci_we_d : OUT STD_LOGIC_VECTOR (1 DOWNTO
          0);
      convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d : IN STD_LOGIC_VECTOR
          (29 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL convolution3D_HW_core_inst_kernel_rsci_addr_d : STD_LOGIC_VECTOR (10 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_inst_kernel_rsci_re_d : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_inst_kernel_rsci_data_out_d : STD_LOGIC_VECTOR (15
      DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_imgIn_rsci_addr_d : STD_LOGIC_VECTOR (10 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_inst_imgIn_rsci_re_d : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_inst_imgIn_rsci_data_out_d : STD_LOGIC_VECTOR (15
      DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_imgOut_rsci_data_in_d : STD_LOGIC_VECTOR (11
      DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_imgOut_rsci_addr_d : STD_LOGIC_VECTOR (15 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_inst_imgOut_rsci_we_d : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_inst_bias_rsci_addr_d : STD_LOGIC_VECTOR (5 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_inst_bias_rsci_re_d : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_bias_rsci_data_out_d : STD_LOGIC_VECTOR (15 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_inst_imgPadded_rsci_data_in_d : STD_LOGIC_VECTOR (7
      DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_imgPadded_rsci_addr_d : STD_LOGIC_VECTOR (19
      DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_imgPadded_rsci_re_d : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_inst_imgPadded_rsci_we_d : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL convolution3D_HW_core_inst_imgPadded_rsci_data_out_d : STD_LOGIC_VECTOR
      (15 DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d
      : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_addr_d
      : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_re_d
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_we_d
      : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d
      : STD_LOGIC_VECTOR (29 DOWNTO 0);

BEGIN
  -- Default Constant Signal Assignments
  PWR <= '1';
  GND <= '0';

  imgPadded_rsc_comp : work.dualport_ram_be_pkg.dualport_ram_be
    GENERIC MAP(
      ram_id => 6,
      words => 676,
      width => 8,
      addr_width => 10,
      a_reset_active => 0,
      s_reset_active => 1,
      enable_active => 0,
      re_active => 0,
      we_active => 0,
      num_byte_enables => 1,
      clock_edge => 1,
      num_input_registers => 1,
      num_output_registers => 0,
      no_of_dualport_readwrite_port => 2
      )
    PORT MAP(
      data_in => imgPadded_rsc_comp_data_in,
      addr => imgPadded_rsc_comp_addr,
      re => imgPadded_rsc_comp_re,
      we => imgPadded_rsc_comp_we,
      data_out => imgPadded_rsc_comp_data_out,
      clk => clk,
      s_rst => rst,
      a_rst => PWR,
      en => imgPadded_rsc_en
    );
  imgPadded_rsc_comp_data_in <= imgPadded_rsc_data_in;
  imgPadded_rsc_comp_addr <= imgPadded_rsc_addr;
  imgPadded_rsc_comp_re <= imgPadded_rsc_re;
  imgPadded_rsc_comp_we <= imgPadded_rsc_we;
  imgPadded_rsc_data_out <= imgPadded_rsc_comp_data_out;

  convolution2D_HW_simple_imgConv2DOut_rsc_comp : work.dualport_ram_be_pkg.dualport_ram_be
    GENERIC MAP(
      ram_id => 10,
      words => 576,
      width => 15,
      addr_width => 10,
      a_reset_active => 0,
      s_reset_active => 1,
      enable_active => 0,
      re_active => 0,
      we_active => 0,
      num_byte_enables => 1,
      clock_edge => 1,
      num_input_registers => 1,
      num_output_registers => 0,
      no_of_dualport_readwrite_port => 2
      )
    PORT MAP(
      data_in => convolution2D_HW_simple_imgConv2DOut_rsc_comp_data_in,
      addr => convolution2D_HW_simple_imgConv2DOut_rsc_comp_addr,
      re => convolution2D_HW_simple_imgConv2DOut_rsc_comp_re,
      we => convolution2D_HW_simple_imgConv2DOut_rsc_comp_we,
      data_out => convolution2D_HW_simple_imgConv2DOut_rsc_comp_data_out,
      clk => clk,
      s_rst => rst,
      a_rst => PWR,
      en => convolution2D_HW_simple_imgConv2DOut_rsc_en
    );
  convolution2D_HW_simple_imgConv2DOut_rsc_comp_data_in <= convolution2D_HW_simple_imgConv2DOut_rsc_data_in;
  convolution2D_HW_simple_imgConv2DOut_rsc_comp_addr <= convolution2D_HW_simple_imgConv2DOut_rsc_addr;
  convolution2D_HW_simple_imgConv2DOut_rsc_comp_re <= convolution2D_HW_simple_imgConv2DOut_rsc_re;
  convolution2D_HW_simple_imgConv2DOut_rsc_comp_we <= convolution2D_HW_simple_imgConv2DOut_rsc_we;
  convolution2D_HW_simple_imgConv2DOut_rsc_data_out <= convolution2D_HW_simple_imgConv2DOut_rsc_comp_data_out;

  kernel_rsci : ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_1_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen
    PORT MAP(
      data_out => kernel_rsci_data_out,
      re => kernel_rsci_re,
      addr => kernel_rsci_addr,
      addr_d => kernel_rsci_addr_d_1,
      re_d => kernel_rsci_re_d_1,
      data_out_d => kernel_rsci_data_out_d_1
    );
  kernel_rsci_data_out <= kernel_rsc_data_out;
  kernel_rsc_re <= kernel_rsci_re;
  kernel_rsc_addr <= kernel_rsci_addr;
  kernel_rsci_addr_d_1 <= STD_LOGIC_VECTOR'( "00000000000") & kernel_rsci_addr_d;
  kernel_rsci_re_d_1 <= kernel_rsci_re_d;
  kernel_rsci_data_out_d <= kernel_rsci_data_out_d_1;

  imgIn_rsci : ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_2_1728_8_11_0_1_0_0_0_1_1_1_0_1728_8_2_gen
    PORT MAP(
      data_out => imgIn_rsci_data_out,
      re => imgIn_rsci_re,
      addr => imgIn_rsci_addr,
      addr_d => imgIn_rsci_addr_d_1,
      re_d => imgIn_rsci_re_d_1,
      data_out_d => imgIn_rsci_data_out_d_1
    );
  imgIn_rsci_data_out <= imgIn_rsc_data_out;
  imgIn_rsc_re <= imgIn_rsci_re;
  imgIn_rsc_addr <= imgIn_rsci_addr;
  imgIn_rsci_addr_d_1 <= STD_LOGIC_VECTOR'( "00000000000") & imgIn_rsci_addr_d;
  imgIn_rsci_re_d_1 <= imgIn_rsci_re_d;
  imgIn_rsci_data_out_d <= imgIn_rsci_data_out_d_1;

  imgOut_rsci : ram_Xilinx_ARTIX_7_1_RAMDB_dualport_wport_3_36864_12_16_0_1_0_0_0_1_1_1_0_36864_12_2_gen
    PORT MAP(
      we => imgOut_rsci_we,
      addr => imgOut_rsci_addr,
      data_in => imgOut_rsci_data_in,
      data_in_d => imgOut_rsci_data_in_d_1,
      addr_d => imgOut_rsci_addr_d_1,
      we_d => imgOut_rsci_we_d_1
    );
  imgOut_rsc_we <= imgOut_rsci_we;
  imgOut_rsc_addr <= imgOut_rsci_addr;
  imgOut_rsc_data_in <= imgOut_rsci_data_in;
  imgOut_rsci_data_in_d_1 <= STD_LOGIC_VECTOR'( "000000000000") & imgOut_rsci_data_in_d;
  imgOut_rsci_addr_d_1 <= STD_LOGIC_VECTOR'( "0000000000000000") & imgOut_rsci_addr_d;
  imgOut_rsci_we_d_1 <= imgOut_rsci_we_d;

  bias_rsci : ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rport_4_64_8_6_0_1_0_0_0_1_1_1_0_64_8_2_gen
    PORT MAP(
      data_out => bias_rsci_data_out,
      re => bias_rsci_re,
      addr => bias_rsci_addr,
      addr_d => bias_rsci_addr_d_1,
      re_d => bias_rsci_re_d_1,
      data_out_d => bias_rsci_data_out_d_1
    );
  bias_rsci_data_out <= bias_rsc_data_out;
  bias_rsc_re <= bias_rsci_re;
  bias_rsc_addr <= bias_rsci_addr;
  bias_rsci_addr_d_1 <= STD_LOGIC_VECTOR'( "000000") & bias_rsci_addr_d;
  bias_rsci_re_d_1 <= bias_rsci_re_d;
  bias_rsci_data_out_d <= bias_rsci_data_out_d_1;

  imgPadded_rsci : ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_6_676_8_10_0_1_0_0_0_1_1_1_0_676_8_2_gen
    PORT MAP(
      en => imgPadded_rsc_en,
      data_out => imgPadded_rsci_data_out,
      we => imgPadded_rsci_we,
      re => imgPadded_rsci_re,
      addr => imgPadded_rsci_addr,
      data_in => imgPadded_rsci_data_in,
      data_in_d => imgPadded_rsci_data_in_d_1,
      addr_d => imgPadded_rsci_addr_d_1,
      re_d => imgPadded_rsci_re_d_1,
      we_d => imgPadded_rsci_we_d_1,
      data_out_d => imgPadded_rsci_data_out_d_1,
      en_d => GND
    );
  imgPadded_rsci_data_out <= imgPadded_rsc_data_out;
  imgPadded_rsc_we <= imgPadded_rsci_we;
  imgPadded_rsc_re <= imgPadded_rsci_re;
  imgPadded_rsc_addr <= imgPadded_rsci_addr;
  imgPadded_rsc_data_in <= imgPadded_rsci_data_in;
  imgPadded_rsci_data_in_d_1 <= STD_LOGIC_VECTOR'( "00000000") & imgPadded_rsci_data_in_d;
  imgPadded_rsci_addr_d_1 <= imgPadded_rsci_addr_d;
  imgPadded_rsci_re_d_1 <= imgPadded_rsci_re_d;
  imgPadded_rsci_we_d_1 <= imgPadded_rsci_we_d;
  imgPadded_rsci_data_out_d <= imgPadded_rsci_data_out_d_1;

  convolution2D_HW_simple_imgConv2DOut_rsci : ram_Xilinx_ARTIX_7_1_RAMDB_dualport_rwport_en_10_576_15_10_0_1_0_0_0_1_1_1_0_576_15_2_gen
    PORT MAP(
      en => convolution2D_HW_simple_imgConv2DOut_rsc_en,
      data_out => convolution2D_HW_simple_imgConv2DOut_rsci_data_out,
      we => convolution2D_HW_simple_imgConv2DOut_rsci_we,
      re => convolution2D_HW_simple_imgConv2DOut_rsci_re,
      addr => convolution2D_HW_simple_imgConv2DOut_rsci_addr,
      data_in => convolution2D_HW_simple_imgConv2DOut_rsci_data_in,
      data_in_d => convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d_1,
      addr_d => convolution2D_HW_simple_imgConv2DOut_rsci_addr_d_1,
      re_d => convolution2D_HW_simple_imgConv2DOut_rsci_re_d_1,
      we_d => convolution2D_HW_simple_imgConv2DOut_rsci_we_d_1,
      data_out_d => convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d_1,
      en_d => GND
    );
  convolution2D_HW_simple_imgConv2DOut_rsci_data_out <= convolution2D_HW_simple_imgConv2DOut_rsc_data_out;
  convolution2D_HW_simple_imgConv2DOut_rsc_we <= convolution2D_HW_simple_imgConv2DOut_rsci_we;
  convolution2D_HW_simple_imgConv2DOut_rsc_re <= convolution2D_HW_simple_imgConv2DOut_rsci_re;
  convolution2D_HW_simple_imgConv2DOut_rsc_addr <= convolution2D_HW_simple_imgConv2DOut_rsci_addr;
  convolution2D_HW_simple_imgConv2DOut_rsc_data_in <= convolution2D_HW_simple_imgConv2DOut_rsci_data_in;
  convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d_1 <= STD_LOGIC_VECTOR'( "000000000000000")
      & convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d;
  convolution2D_HW_simple_imgConv2DOut_rsci_addr_d_1 <= STD_LOGIC_VECTOR'( "0000000000")
      & convolution2D_HW_simple_imgConv2DOut_rsci_addr_d;
  convolution2D_HW_simple_imgConv2DOut_rsci_re_d_1 <= convolution2D_HW_simple_imgConv2DOut_rsci_re_d;
  convolution2D_HW_simple_imgConv2DOut_rsci_we_d_1 <= convolution2D_HW_simple_imgConv2DOut_rsci_we_d;
  convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d <= convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d_1;

  convolution3D_HW_core_inst : convolution3D_HW_core
    PORT MAP(
      clk => clk,
      rst => rst,
      kernel_rsc_triosy_lz => kernel_rsc_triosy_lz,
      imgIn_rsc_triosy_lz => imgIn_rsc_triosy_lz,
      imgOut_rsc_triosy_lz => imgOut_rsc_triosy_lz,
      bias_rsc_triosy_lz => bias_rsc_triosy_lz,
      kernel_rsci_addr_d => convolution3D_HW_core_inst_kernel_rsci_addr_d,
      kernel_rsci_re_d => convolution3D_HW_core_inst_kernel_rsci_re_d,
      kernel_rsci_data_out_d => convolution3D_HW_core_inst_kernel_rsci_data_out_d,
      imgIn_rsci_addr_d => convolution3D_HW_core_inst_imgIn_rsci_addr_d,
      imgIn_rsci_re_d => convolution3D_HW_core_inst_imgIn_rsci_re_d,
      imgIn_rsci_data_out_d => convolution3D_HW_core_inst_imgIn_rsci_data_out_d,
      imgOut_rsci_data_in_d => convolution3D_HW_core_inst_imgOut_rsci_data_in_d,
      imgOut_rsci_addr_d => convolution3D_HW_core_inst_imgOut_rsci_addr_d,
      imgOut_rsci_we_d => convolution3D_HW_core_inst_imgOut_rsci_we_d,
      bias_rsci_addr_d => convolution3D_HW_core_inst_bias_rsci_addr_d,
      bias_rsci_re_d => convolution3D_HW_core_inst_bias_rsci_re_d,
      bias_rsci_data_out_d => convolution3D_HW_core_inst_bias_rsci_data_out_d,
      imgPadded_rsci_data_in_d => convolution3D_HW_core_inst_imgPadded_rsci_data_in_d,
      imgPadded_rsci_addr_d => convolution3D_HW_core_inst_imgPadded_rsci_addr_d,
      imgPadded_rsci_re_d => convolution3D_HW_core_inst_imgPadded_rsci_re_d,
      imgPadded_rsci_we_d => convolution3D_HW_core_inst_imgPadded_rsci_we_d,
      imgPadded_rsci_data_out_d => convolution3D_HW_core_inst_imgPadded_rsci_data_out_d,
      convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d => convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d,
      convolution2D_HW_simple_imgConv2DOut_rsci_addr_d => convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_addr_d,
      convolution2D_HW_simple_imgConv2DOut_rsci_re_d => convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_re_d,
      convolution2D_HW_simple_imgConv2DOut_rsci_we_d => convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_we_d,
      convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d => convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d
    );
  kernel_rsci_addr_d <= convolution3D_HW_core_inst_kernel_rsci_addr_d;
  kernel_rsci_re_d <= convolution3D_HW_core_inst_kernel_rsci_re_d;
  convolution3D_HW_core_inst_kernel_rsci_data_out_d <= kernel_rsci_data_out_d;
  imgIn_rsci_addr_d <= convolution3D_HW_core_inst_imgIn_rsci_addr_d;
  imgIn_rsci_re_d <= convolution3D_HW_core_inst_imgIn_rsci_re_d;
  convolution3D_HW_core_inst_imgIn_rsci_data_out_d <= imgIn_rsci_data_out_d;
  imgOut_rsci_data_in_d <= convolution3D_HW_core_inst_imgOut_rsci_data_in_d;
  imgOut_rsci_addr_d <= convolution3D_HW_core_inst_imgOut_rsci_addr_d;
  imgOut_rsci_we_d <= convolution3D_HW_core_inst_imgOut_rsci_we_d;
  bias_rsci_addr_d <= convolution3D_HW_core_inst_bias_rsci_addr_d;
  bias_rsci_re_d <= convolution3D_HW_core_inst_bias_rsci_re_d;
  convolution3D_HW_core_inst_bias_rsci_data_out_d <= bias_rsci_data_out_d;
  imgPadded_rsci_data_in_d <= convolution3D_HW_core_inst_imgPadded_rsci_data_in_d;
  imgPadded_rsci_addr_d <= convolution3D_HW_core_inst_imgPadded_rsci_addr_d;
  imgPadded_rsci_re_d <= convolution3D_HW_core_inst_imgPadded_rsci_re_d;
  imgPadded_rsci_we_d <= convolution3D_HW_core_inst_imgPadded_rsci_we_d;
  convolution3D_HW_core_inst_imgPadded_rsci_data_out_d <= imgPadded_rsci_data_out_d;
  convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d <= convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_data_in_d;
  convolution2D_HW_simple_imgConv2DOut_rsci_addr_d <= convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_addr_d;
  convolution2D_HW_simple_imgConv2DOut_rsci_re_d <= convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_re_d;
  convolution2D_HW_simple_imgConv2DOut_rsci_we_d <= convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_we_d;
  convolution3D_HW_core_inst_convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d
      <= convolution2D_HW_simple_imgConv2DOut_rsci_data_out_d;

END v2;


