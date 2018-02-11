
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

--------> /softl3/catapultc10_0a/64bit/Mgc_home/pkgs/siflibs/mgc_out_stdreg_v1.vhd 
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

ENTITY mgc_out_stdreg_v1 IS
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    d        : IN  std_logic_vector(width-1 DOWNTO 0);
    z        : OUT std_logic_vector(width-1 DOWNTO 0)
  );
END mgc_out_stdreg_v1;

ARCHITECTURE beh OF mgc_out_stdreg_v1 IS
BEGIN

  z <= d;

End beh;



--------> /softl3/catapultc10_0a/64bit/Mgc_home/pkgs/siflibs/mgc_in_wire_v1.vhd 
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

ENTITY mgc_in_wire_v1 IS
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    d        : OUT std_logic_vector(width-1 DOWNTO 0);
    z        : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END mgc_in_wire_v1;

ARCHITECTURE beh OF mgc_in_wire_v1 IS
BEGIN

  d <= z;

END beh;



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

--------> /softl3/catapultc10_0a/64bit/Mgc_home/pkgs/siflibs/ram_singleport_be_fpga.vhd 
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

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL ;

PACKAGE singleport_ram_be_pkg IS

  COMPONENT singleport_ram_be
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
            no_of_singleport_readwrite_port  : integer
           );
     PORT (
           data_in    : IN  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 DOWNTO 0) ;
           addr       : IN  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * addr_width) - 1 DOWNTO 0) ;
           re         : IN  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 DOWNTO 0);
           we         : IN  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 DOWNTO 0);
           data_out   : OUT STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 DOWNTO 0);
           clk        : IN  std_logic;
           a_rst      : IN std_logic;
           s_rst      : IN std_logic;
           en         : IN std_logic
          );

  END COMPONENT;

  component singleport_ram_be_port
   generic (ram_id           : integer;
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
            no_of_singleport_readwrite_port  : integer
           );
     port (
           data_in_d  : in  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 downto 0) ;
           addr_d     : in  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * addr_width) - 1 downto 0) ;
           re_d       : in  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 downto 0);
           we_d       : in  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 downto 0);
           data_out_d : out STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 downto 0);
           data_in    : out STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 downto 0) ;
           addr       : out  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * addr_width) - 1 downto 0) ;
           re         : out  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 downto 0);
           we         : out  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 downto 0);
           data_out   : in STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 downto 0);
           clk        : in  std_logic;
           a_rst      : in std_logic;
           s_rst      : in std_logic;
           en         : in std_logic
          );
  end component;

END singleport_ram_be_pkg;

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

USE work.singleport_ram_be_pkg.ALL;

  ENTITY singleport_ram_be IS
   GENERIC (ram_id           : integer := 1;
            words            : integer := 256;
            width            : integer := 8;
            addr_width       : integer := 8;
            a_reset_active   : integer := 0;
            s_reset_active   : integer := 1;
            enable_active    : integer := 1;
            re_active        : integer := 1;
            we_active        : integer := 1;
            num_byte_enables : integer := 1;
            clock_edge       : integer := 1;
            num_input_registers          : integer := 1;
            num_output_registers         : integer := 0;
            no_of_singleport_readwrite_port  : integer := 1
     );
     PORT (
           data_in    : IN  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 DOWNTO 0) ;
           addr       : IN  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * addr_width) - 1 DOWNTO 0) ;
           re         : IN  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 DOWNTO 0);
           we         : IN  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 DOWNTO 0);
           data_out   : OUT STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 DOWNTO 0);
           clk        : IN  std_logic;
           a_rst      : IN std_logic;
           s_rst      : IN  std_logic;
           en         : IN std_logic
          );
  END singleport_ram_be ;

  ARCHITECTURE rtl OF singleport_ram_be IS
    TYPE mem_type IS ARRAY ((words)-1 DOWNTO 0) OF
                        STD_LOGIC_VECTOR(width - 1 DOWNTO 0) ;
    SIGNAL mem : mem_type ;

    TYPE d_array IS ARRAY (integer RANGE <>) OF STD_LOGIC_VECTOR(width-1 DOWNTO 0);
    TYPE addr_array IS ARRAY (integer RANGE <>) OF STD_LOGIC_VECTOR(addr_width-1 DOWNTO 0);
    TYPE en_array IS ARRAY (integer RANGE <>) OF STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);

    SIGNAL data_out_f : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
    SIGNAL data_in_f  : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
    SIGNAL addr_f     : STD_LOGIC_VECTOR(addr_width-1 DOWNTO 0);
    SIGNAL re_f       : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);
    SIGNAL we_f       : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);

    SIGNAL addr_reg   : STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);
    SIGNAL re_reg     : STD_LOGIC_VECTOR(num_byte_enables - 1 DOWNTO 0);

    CONSTANT byte_width : integer := width / num_byte_enables;
    CONSTANT clock_edge_stdlogic : STD_LOGIC := conv_std_logic_vector(clock_edge,1)(0);

    FUNCTION cmp_ulogic_int(arg1 : STD_ULOGIC; arg2 : INTEGER) RETURN BOOLEAN IS
    BEGIN
      CASE arg2 IS
        WHEN 1 => RETURN arg1 = '1' OR arg1 = 'H';
        WHEN 0 => RETURN arg1 = '0' OR arg1 = 'L';
        WHEN OTHERS => ASSERT false
                       REPORT "Invalid integer value for phase - valid range is from 0 to 1"
                       SEVERITY FAILURE;
                       RETURN false;
      END CASE;
    END cmp_ulogic_int;
BEGIN

    N_INREG_GT_1 : IF (num_input_registers > 1) GENERATE
     SIGNAL data_in_inreg: d_array(num_input_registers-2 DOWNTO 0);
     SIGNAL addr_inreg: addr_array(num_input_registers-2 DOWNTO 0);
     SIGNAL re_inreg : en_array(num_input_registers-2 DOWNTO 0);
     SIGNAL we_inreg : en_array(num_input_registers-2 DOWNTO 0);

     CONSTANT PWR: integer RANGE 0 TO 1 := 1;
     CONSTANT GND: integer RANGE 0 TO 1 := 0;
     CONSTANT GND_sig: std_logic := '0';
    BEGIN
      pipe: FOR i_in IN num_input_registers - 3 DOWNTO 0 GENERATE
        i_data_in_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (data_in_inreg(i_in), clk, en, a_rst, s_rst, data_in_inreg(i_in+1));
        i_addr_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (addr_width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (addr_inreg(i_in), clk, en, a_rst, s_rst, addr_inreg(i_in+1));
        i_re_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (re_inreg(i_in), clk, en, a_rst, s_rst, re_inreg(i_in+1));
        i_we_inreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (we_inreg(i_in), clk, en, a_rst, s_rst, we_inreg(i_in+1));
      END GENERATE pipe;

      i_data_in_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (data_in, clk, en, a_rst, s_rst, data_in_inreg(0));
      i_addr_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (addr_width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (addr, clk, en, a_rst, s_rst, addr_inreg(0));
      i_re_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (re, clk, en, a_rst, s_rst, re_inreg(0));
      i_we_inreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (num_byte_enables, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (we, clk, en, a_rst, s_rst, we_inreg(0));


      data_in_f <= data_in_inreg(num_input_registers-2);
      addr_f <= addr_inreg(num_input_registers-2);
      re_f <= re_inreg(num_input_registers-2);
      we_f <= we_inreg(num_input_registers-2);

    END GENERATE N_INREG_GT_1;

    INREG_EQ_1: IF num_input_registers = 1 GENERATE
      data_in_f <= data_in;
      addr_f <= addr;
      re_f <= re;
      we_f <= we;

    END GENERATE INREG_EQ_1;
    	--pragma translate_off
    	CHECK_ADDR_DONTCARE: PROCESS(clk)
    	BEGIN
     	IF ( clk'event AND clk = clock_edge_stdlogic ) THEN
        IF (conv_integer(en) = enable_active) THEN
        		FOR i IN 0 TO addr_width-1 LOOP    
          		IF (addr_f(i) = 'X' OR addr_f(i) = 'Z') THEN    	
          		  FOR j IN 0 TO num_byte_enables - 1 LOOP
            			ASSERT cmp_ulogic_int(we_f(j), we_active) = false
            			  REPORT "Error: Dont-care address for pipelined singleport memory-write"
            			  SEVERITY FAILURE;
            			ASSERT cmp_ulogic_int(re_f(j), re_active) = false
            			  REPORT "Error: Dont-care or High-Impedance address for pipelined singleport memory-read"
            			  SEVERITY FAILURE;
          		  END LOOP;
          		END IF;
        		END LOOP;
        END IF;
      END IF;
    	END PROCESS;

    	--pragma translate_on
    MW : PROCESS (clk)
           VARIABLE addr_int : integer;
    BEGIN
      IF ( clk'event AND clk = clock_edge_stdlogic ) THEN
        IF (conv_integer(en) = enable_active) THEN
          addr_reg <= addr_f;
  	       re_reg   <= re_f;
          addr_int := conv_integer(addr_f);
          IF (addr_int < words AND addr_int >= 0) THEN
            FOR i IN 0 TO num_byte_enables - 1 LOOP
              IF cmp_ulogic_int(we_f(i), we_active) THEN
                mem(addr_int)(i*byte_width + byte_width - 1 DOWNTO i*byte_width) <= data_in_f(i*byte_width + byte_width - 1 DOWNTO i*byte_width);
              END IF;
            END LOOP;
          ELSE
            FOR i IN 0 TO num_byte_enables - 1 LOOP
              ASSERT cmp_ulogic_int(we_f(i), we_active) = false
                REPORT "Error: Out-of-bound pipelined singleport memory-write"
                SEVERITY FAILURE;
            END LOOP;
          END IF;
        END IF;
      END IF;
    END PROCESS;

    MR: PROCESS(mem, addr_reg, re_reg)
        VARIABLE addr_int: integer;
    BEGIN
        addr_int := conv_integer(addr_reg);
        IF (addr_int < words AND addr_int >= 0) THEN
          -- data_out_f <= mem(addr_int);
          FOR k IN 0 TO num_byte_enables - 1 LOOP
            IF cmp_ulogic_int(re_reg(k), re_active) THEN
              data_out_f(k*byte_width + byte_width - 1 DOWNTO k*byte_width) <= mem(addr_int)(k*byte_width + byte_width - 1 DOWNTO k*byte_width);
            ELSE
              data_out_f(k*byte_width + byte_width - 1 DOWNTO k*byte_width) <= (OTHERS => 'X');
            END IF;
          END LOOP;
        ELSE
          data_out_f <= (OTHERS => 'X');
        END IF;
    END PROCESS;

    -- REGISTER BANKS at the output
    N_OUTREG_GT_0: IF num_output_registers > 0 GENERATE
     SIGNAL data_out_outreg: d_array(num_output_registers-1 DOWNTO 0);

     CONSTANT PWR: integer RANGE 0 TO 1 := 1;
     CONSTANT GND: integer RANGE 0 TO 1 := 0;
     CONSTANT GND_sig: std_logic := '0';
    BEGIN
      N_OUTREG_SHIFT: FOR i_out IN num_output_registers - 2 DOWNTO 0 GENERATE
      BEGIN
        i_data_out_outreg : work.mgc_comps.mgc_generic_reg
                      GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                      PORT MAP (data_out_outreg(i_out), clk, en, a_rst, s_rst, data_out_outreg(i_out+1));
      END GENERATE N_OUTREG_SHIFT;

      i_data_out_outreg_i : work.mgc_comps.mgc_generic_reg
                    GENERIC MAP (width, clock_edge, enable_active, a_reset_active, s_reset_active, GND, GND, PWR)
                    PORT MAP (data_out_f, clk, en, a_rst, s_rst, data_out_outreg(0));
      data_out <= data_out_outreg(num_output_registers-1);
    END GENERATE N_OUTREG_GT_0;

    N_OUTREG_EQ_0: IF num_output_registers = 0 GENERATE
      data_out <= data_out_f;
    END GENERATE N_OUTREG_EQ_0;
  END RTL ;

LIBRARY ieee;

use IEEE.std_logic_1164.all ;
use IEEE.std_logic_arith.all ;
use IEEE.std_logic_unsigned.all ;

USE work.singleport_ram_be_pkg.all;

  entity singleport_ram_be_port is
   generic (ram_id           : integer;
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
            no_of_singleport_readwrite_port  : integer
           );
     port (
           data_in_d  : in  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 downto 0) ;
           addr_d     : in  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * addr_width) - 1 downto 0) ;
           re_d       : in  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 downto 0);
           we_d       : in  STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 downto 0);
           data_out_d : out STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 downto 0);
           data_in    : out STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 downto 0) ;
           addr       : out STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * addr_width) - 1 downto 0) ;
           re         : out STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 downto 0);
           we         : out STD_LOGIC_VECTOR((no_of_singleport_readwrite_port*num_byte_enables) - 1 downto 0);
           data_out   : in STD_LOGIC_VECTOR((no_of_singleport_readwrite_port * width) - 1 downto 0);
           clk        : in std_logic;
           a_rst      : in std_logic;
           s_rst      : in std_logic;
           en         : in std_logic
          );
  end singleport_ram_be_port;

  architecture rtl of singleport_ram_be_port is
  begin
    data_in     <= data_in_d;
    addr        <= addr_d;
    re          <= re_d;
    we          <= we_d;
    data_out_d  <= data_out;
  end rtl;

--------> ./rtl_topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    10.0a/269363 Production Release
--  HLS Date:       Wed Nov  9 17:38:00 PST 2016
-- 
--  Generated by:   xph3sei714@cimeld95
--  Generated date: Mon Feb  5 10:04:15 2018
-- ----------------------------------------------------------------------

-- 
LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;

PACKAGE topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1_pkg IS 
  COMPONENT topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1
    GENERIC (
      rom_id : INTEGER;
      size : INTEGER;
      width : INTEGER;
      ph_clk : INTEGER;
      ph_en : INTEGER;
      ph_a_rst : INTEGER;
      ph_s_rst : INTEGER;
      num_input_registers : INTEGER;
      num_output_registers : INTEGER;
      a_rst_used : INTEGER;
      s_rst_used : INTEGER;
      en_used : INTEGER;
      no_of_ports : INTEGER
    );
    PORT(
      addr : IN STD_LOGIC_VECTOR(no_of_ports * bits(size) - 1 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(no_of_ports * width - 1 DOWNTO 0);
      clk : IN STD_LOGIC;
      s_rst : IN STD_LOGIC;
      a_rst : IN STD_LOGIC;
      en : IN STD_LOGIC
    );
  END COMPONENT;
END topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1_pkg;

PACKAGE BODY topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1_pkg IS
END topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1_pkg;
LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;

USE work.topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1_pkg.all;
LIBRARY std;

use std.textio.all;
use ieee.std_logic_textio.all;
ENTITY topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1 IS
    GENERIC (
      rom_id : INTEGER;
      size : INTEGER;
      width : INTEGER;
      ph_clk : INTEGER;
      ph_en : INTEGER;
      ph_a_rst : INTEGER;
      ph_s_rst : INTEGER;
      num_input_registers : INTEGER;
      num_output_registers : INTEGER;
      a_rst_used : INTEGER;
      s_rst_used : INTEGER;
      en_used : INTEGER;
      no_of_ports : INTEGER
    );
    PORT(
      addr : IN STD_LOGIC_VECTOR(no_of_ports * bits(size) - 1 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(no_of_ports * width - 1 DOWNTO 0);
      clk : IN STD_LOGIC;
      s_rst : IN STD_LOGIC;
      a_rst : IN STD_LOGIC;
      en : IN STD_LOGIC
    );
END topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1;
ARCHITECTURE v1 OF topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1 IS
    subtype WORD is std_logic_vector(6-1 downto 0);
    type TABLE is array (0 to 180-1) of WORD;

    constant mem : TABLE := TABLE'(
    WORD'("000000")
    , WORD'("111001")
    , WORD'("001111")
    , WORD'("000000")
    , WORD'("011001")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("011010")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("100110")
    , WORD'("000000")
    , WORD'("000011")
    , WORD'("000000")
    , WORD'("100001")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("010100")
    , WORD'("010100")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000010")
    , WORD'("011111")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("011001")
    , WORD'("000000")
    , WORD'("110000")
    , WORD'("000000")
    , WORD'("010100")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("010001")
    , WORD'("000000")
    , WORD'("000010")
    , WORD'("001100")
    , WORD'("101001")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("001011")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("011111")
    , WORD'("000000")
    , WORD'("100011")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("100011")
    , WORD'("000000")
    , WORD'("010100")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("011000")
    , WORD'("000011")
    , WORD'("000010")
    , WORD'("000101")
    , WORD'("000000")
    , WORD'("001111")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000110")
    , WORD'("001001")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("011101")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000111")
    , WORD'("000000")
    , WORD'("001111")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("011111")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("011101")
    , WORD'("000000")
    , WORD'("010110")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000110")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("011000")
    , WORD'("001011")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("011111")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000001")
    , WORD'("000000")
    , WORD'("011110")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("100010")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("100100")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("010110")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000100")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("001010")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("010011")
    , WORD'("001111")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("010110")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000100")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000001")
    , WORD'("000000")
    , WORD'("000110")
    , WORD'("000110")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000000")
    , WORD'("000101")
    );
    type data_out_2D is array (natural range <>) of std_logic_vector(5 downto 0);
    type addr_2D is array(natural range <>) of std_logic_vector(7 downto 0);
    signal addr_reg     : addr_2D(num_input_registers downto 0);
    signal addr_f : std_logic_vector(7 downto 0);
    signal data_out_reg : data_out_2D(num_output_registers downto 0);
    signal data_out_t : std_logic_vector(5 downto 0);
    signal REG_PWR : std_logic;
    constant REG_GND : std_logic := '0';
BEGIN
  REG_PWR <= '1';

  -- Input register stages
  n_inreg_blk: for i in num_input_registers - 1 downto 1 generate
    i_addr_reg : work.mgc_comps.mgc_generic_reg
      GENERIC MAP (8, ph_clk, ph_en, 0, 0,a_rst_used,s_rst_used, en_used)
      PORT MAP (addr_reg(i-1), clk, en, REG_PWR, REG_PWR, addr_reg(i));
  end generate n_inreg_blk;
  n_inreg_gt_0_blk: if num_input_registers > 0 generate
  i_addr_reg_init : work.mgc_comps.mgc_generic_reg
    GENERIC MAP (8, ph_clk, ph_en, 0, 0, a_rst_used, s_rst_used, en_used)
    PORT MAP (addr, clk, en, REG_PWR, REG_PWR, addr_reg(0));
    addr_f <= addr_reg(num_input_registers-1);
  end generate n_inreg_gt_0_blk;
  n_inreg_eq_0_blk: if num_input_registers = 0 generate
    addr_f <= addr;
  end generate n_inreg_eq_0_blk;


  -- Reading ROM
  PROCESS(addr_f)
    VARIABLE idx : INTEGER;
    VARIABLE addr_f_mx : std_logic_vector(addr_f'range);
  BEGIN
    idx := conv_integer(unsigned(addr_f));
    IF idx >= 0 AND idx < 180 THEN
      addr_f_mx := addr_f;
    ELSE
      addr_f_mx := STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(addr_f(6 downto 0)), 8));
    END IF;
    data_out_t<= mem(conv_integer(unsigned(addr_f_mx)));
  END PROCESS;

-- Output register stages
n_outreg_eq_0: if num_output_registers = 0 generate
  data_out<= data_out_t;
end generate n_outreg_eq_0;
n_outreg_gt_0: if num_output_registers > 0 generate
  i_data_out_reg_init : work.mgc_comps.mgc_generic_reg
    GENERIC MAP (6, ph_clk, ph_en, 0, 0, a_rst_used, s_rst_used, en_used)
    PORT MAP (data_out_t, clk, en, REG_PWR, REG_PWR, data_out_reg(0));
  n_outreg_blk: for i in num_output_registers - 1 downto 1 generate
    i_data_out_reg : work.mgc_comps.mgc_generic_reg
      GENERIC MAP (6, ph_clk, ph_en, 0, 0,a_rst_used,s_rst_used, en_used)
      PORT MAP (data_out_reg(i-1), clk, en, REG_PWR, REG_PWR, data_out_reg(i));
  end generate n_outreg_blk;
  data_out <= data_out_reg(num_output_registers-1);
end generate n_outreg_gt_0;
END v1;



--------> ./rtl_topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    10.0a/269363 Production Release
--  HLS Date:       Wed Nov  9 17:38:00 PST 2016
-- 
--  Generated by:   xph3sei714@cimeld95
--  Generated date: Mon Feb  5 10:04:15 2018
-- ----------------------------------------------------------------------

-- 
LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;

PACKAGE topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1_pkg IS 
  COMPONENT topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1
    GENERIC (
      rom_id : INTEGER;
      size : INTEGER;
      width : INTEGER;
      ph_clk : INTEGER;
      ph_en : INTEGER;
      ph_a_rst : INTEGER;
      ph_s_rst : INTEGER;
      num_input_registers : INTEGER;
      num_output_registers : INTEGER;
      a_rst_used : INTEGER;
      s_rst_used : INTEGER;
      en_used : INTEGER;
      no_of_ports : INTEGER
    );
    PORT(
      addr : IN STD_LOGIC_VECTOR(no_of_ports * bits(size) - 1 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(no_of_ports * width - 1 DOWNTO 0);
      clk : IN STD_LOGIC;
      s_rst : IN STD_LOGIC;
      a_rst : IN STD_LOGIC;
      en : IN STD_LOGIC
    );
  END COMPONENT;
END topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1_pkg;

PACKAGE BODY topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1_pkg IS
END topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1_pkg;
LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;

USE work.topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1_pkg.all;
LIBRARY std;

use std.textio.all;
use ieee.std_logic_textio.all;
ENTITY topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1 IS
    GENERIC (
      rom_id : INTEGER;
      size : INTEGER;
      width : INTEGER;
      ph_clk : INTEGER;
      ph_en : INTEGER;
      ph_a_rst : INTEGER;
      ph_s_rst : INTEGER;
      num_input_registers : INTEGER;
      num_output_registers : INTEGER;
      a_rst_used : INTEGER;
      s_rst_used : INTEGER;
      en_used : INTEGER;
      no_of_ports : INTEGER
    );
    PORT(
      addr : IN STD_LOGIC_VECTOR(no_of_ports * bits(size) - 1 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(no_of_ports * width - 1 DOWNTO 0);
      clk : IN STD_LOGIC;
      s_rst : IN STD_LOGIC;
      a_rst : IN STD_LOGIC;
      en : IN STD_LOGIC
    );
END topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1;
ARCHITECTURE v1 OF topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1 IS
    subtype WORD is std_logic_vector(7-1 downto 0);
    type TABLE is array (0 to 1800-1) of WORD;

    constant mem : TABLE := TABLE'(
    WORD'("1110001")
    , WORD'("1111110")
    , WORD'("0001111")
    , WORD'("0000100")
    , WORD'("0010100")
    , WORD'("0000100")
    , WORD'("0000001")
    , WORD'("0000100")
    , WORD'("1111100")
    , WORD'("1111110")
    , WORD'("0000011")
    , WORD'("0000110")
    , WORD'("0010111")
    , WORD'("0000111")
    , WORD'("1111100")
    , WORD'("0000100")
    , WORD'("0001000")
    , WORD'("1110001")
    , WORD'("1111001")
    , WORD'("1111101")
    , WORD'("0000100")
    , WORD'("1111101")
    , WORD'("1111011")
    , WORD'("0000000")
    , WORD'("0100001")
    , WORD'("1111101")
    , WORD'("0000000")
    , WORD'("1111010")
    , WORD'("0000101")
    , WORD'("1111010")
    , WORD'("0000010")
    , WORD'("0000100")
    , WORD'("1111000")
    , WORD'("0011001")
    , WORD'("0000001")
    , WORD'("0001001")
    , WORD'("0000001")
    , WORD'("0000101")
    , WORD'("1111000")
    , WORD'("0000000")
    , WORD'("0001100")
    , WORD'("1111100")
    , WORD'("0000111")
    , WORD'("0000001")
    , WORD'("0000000")
    , WORD'("1111111")
    , WORD'("0000001")
    , WORD'("0000100")
    , WORD'("1111001")
    , WORD'("1111101")
    , WORD'("1110110")
    , WORD'("1111111")
    , WORD'("0000110")
    , WORD'("0010000")
    , WORD'("1111110")
    , WORD'("0000101")
    , WORD'("0000010")
    , WORD'("0001000")
    , WORD'("0000000")
    , WORD'("1111000")
    , WORD'("0000101")
    , WORD'("0010100")
    , WORD'("1111010")
    , WORD'("1111010")
    , WORD'("1111100")
    , WORD'("1111110")
    , WORD'("0000001")
    , WORD'("0000001")
    , WORD'("0000011")
    , WORD'("1111100")
    , WORD'("1111110")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("1111001")
    , WORD'("1111101")
    , WORD'("1111001")
    , WORD'("0001111")
    , WORD'("0000111")
    , WORD'("1111110")
    , WORD'("0001011")
    , WORD'("0000101")
    , WORD'("0001011")
    , WORD'("1111011")
    , WORD'("1111010")
    , WORD'("1111001")
    , WORD'("1110011")
    , WORD'("0001011")
    , WORD'("1111010")
    , WORD'("0010111")
    , WORD'("0000010")
    , WORD'("0000101")
    , WORD'("0001000")
    , WORD'("1111100")
    , WORD'("0000001")
    , WORD'("1111000")
    , WORD'("1111100")
    , WORD'("1111011")
    , WORD'("0001010")
    , WORD'("1111100")
    , WORD'("0001000")
    , WORD'("0000100")
    , WORD'("1111111")
    , WORD'("0000101")
    , WORD'("0000001")
    , WORD'("0000001")
    , WORD'("1111111")
    , WORD'("0100000")
    , WORD'("1111001")
    , WORD'("1111101")
    , WORD'("1111011")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("1110110")
    , WORD'("0001001")
    , WORD'("1111011")
    , WORD'("1111001")
    , WORD'("1110101")
    , WORD'("0000010")
    , WORD'("0001000")
    , WORD'("0010111")
    , WORD'("1110110")
    , WORD'("0001001")
    , WORD'("1111011")
    , WORD'("0000100")
    , WORD'("0001011")
    , WORD'("0001001")
    , WORD'("0000101")
    , WORD'("0000110")
    , WORD'("1111010")
    , WORD'("1111101")
    , WORD'("0011001")
    , WORD'("0000000")
    , WORD'("0000000")
    , WORD'("1111101")
    , WORD'("1111101")
    , WORD'("1111011")
    , WORD'("1110110")
    , WORD'("0000001")
    , WORD'("0001000")
    , WORD'("0000000")
    , WORD'("1111101")
    , WORD'("1111100")
    , WORD'("0010000")
    , WORD'("1110111")
    , WORD'("1110100")
    , WORD'("0000000")
    , WORD'("0000011")
    , WORD'("0001001")
    , WORD'("0001011")
    , WORD'("0000110")
    , WORD'("1111101")
    , WORD'("1111010")
    , WORD'("0010100")
    , WORD'("0000101")
    , WORD'("1111111")
    , WORD'("0001101")
    , WORD'("0000010")
    , WORD'("0010011")
    , WORD'("1110001")
    , WORD'("1111011")
    , WORD'("0010110")
    , WORD'("1111000")
    , WORD'("0000011")
    , WORD'("1111010")
    , WORD'("0000011")
    , WORD'("1111010")
    , WORD'("1110110")
    , WORD'("0000111")
    , WORD'("0010101")
    , WORD'("0001011")
    , WORD'("1110011")
    , WORD'("1111111")
    , WORD'("0000010")
    , WORD'("0001001")
    , WORD'("0000100")
    , WORD'("0011001")
    , WORD'("1111110")
    , WORD'("0000001")
    , WORD'("1111111")
    , WORD'("1111000")
    , WORD'("1111100")
    , WORD'("1110111")
    , WORD'("1111011")
    , WORD'("0000101")
    , WORD'("0001000")
    , WORD'("0000101")
    , WORD'("1111111")
    , WORD'("0011101")
    , WORD'("1111001")
    , WORD'("0000000")
    , WORD'("1111001")
    , WORD'("0001000")
    , WORD'("0001101")
    , WORD'("0000100")
    , WORD'("0001101")
    , WORD'("0001000")
    , WORD'("1111011")
    , WORD'("1110010")
    , WORD'("1111011")
    , WORD'("0000000")
    , WORD'("1111010")
    , WORD'("0001000")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("0001000")
    , WORD'("0000010")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("1111100")
    , WORD'("0000111")
    , WORD'("0000111")
    , WORD'("1111011")
    , WORD'("0001100")
    , WORD'("1111110")
    , WORD'("1111111")
    , WORD'("1111011")
    , WORD'("1111101")
    , WORD'("0000011")
    , WORD'("0000110")
    , WORD'("1111111")
    , WORD'("0001001")
    , WORD'("1110111")
    , WORD'("0000001")
    , WORD'("0000110")
    , WORD'("0010100")
    , WORD'("1111100")
    , WORD'("1111100")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("1111101")
    , WORD'("0000110")
    , WORD'("0000010")
    , WORD'("1111011")
    , WORD'("0010001")
    , WORD'("1111110")
    , WORD'("0000111")
    , WORD'("1111011")
    , WORD'("0001101")
    , WORD'("1111101")
    , WORD'("1110111")
    , WORD'("0000110")
    , WORD'("1111010")
    , WORD'("0001000")
    , WORD'("1111110")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("1111110")
    , WORD'("0001000")
    , WORD'("1111100")
    , WORD'("1111110")
    , WORD'("1110110")
    , WORD'("1111100")
    , WORD'("0000001")
    , WORD'("0010001")
    , WORD'("0000001")
    , WORD'("0001000")
    , WORD'("0000111")
    , WORD'("0000000")
    , WORD'("0000000")
    , WORD'("1110101")
    , WORD'("0000011")
    , WORD'("0010110")
    , WORD'("1111011")
    , WORD'("1111010")
    , WORD'("1111110")
    , WORD'("1111100")
    , WORD'("1111111")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("0000101")
    , WORD'("0001001")
    , WORD'("0001011")
    , WORD'("1111100")
    , WORD'("1110110")
    , WORD'("1111100")
    , WORD'("1110011")
    , WORD'("0010000")
    , WORD'("1111101")
    , WORD'("0000111")
    , WORD'("0000001")
    , WORD'("0000000")
    , WORD'("0000110")
    , WORD'("0000000")
    , WORD'("1110111")
    , WORD'("1110101")
    , WORD'("1111010")
    , WORD'("0000100")
    , WORD'("1111101")
    , WORD'("0010110")
    , WORD'("0001001")
    , WORD'("1111110")
    , WORD'("0010010")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("1110111")
    , WORD'("0000000")
    , WORD'("0000010")
    , WORD'("1110110")
    , WORD'("0000011")
    , WORD'("0001001")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("0000001")
    , WORD'("0000101")
    , WORD'("0000001")
    , WORD'("1111000")
    , WORD'("0011110")
    , WORD'("1111011")
    , WORD'("1111101")
    , WORD'("1111100")
    , WORD'("0000001")
    , WORD'("1111110")
    , WORD'("0000000")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("1111010")
    , WORD'("1110111")
    , WORD'("1111101")
    , WORD'("0001010")
    , WORD'("0010000")
    , WORD'("1111000")
    , WORD'("1111111")
    , WORD'("1111111")
    , WORD'("1111101")
    , WORD'("0010111")
    , WORD'("0000101")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("0010111")
    , WORD'("1111100")
    , WORD'("1111100")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("0000010")
    , WORD'("1111010")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("1111101")
    , WORD'("0000011")
    , WORD'("1111100")
    , WORD'("1111110")
    , WORD'("0000001")
    , WORD'("1111000")
    , WORD'("0001010")
    , WORD'("0000100")
    , WORD'("0000111")
    , WORD'("0000011")
    , WORD'("1111100")
    , WORD'("1111001")
    , WORD'("1111001")
    , WORD'("0010010")
    , WORD'("0000000")
    , WORD'("0000100")
    , WORD'("0000000")
    , WORD'("0000011")
    , WORD'("0000001")
    , WORD'("1111110")
    , WORD'("1111110")
    , WORD'("1111010")
    , WORD'("1111111")
    , WORD'("1111110")
    , WORD'("1110110")
    , WORD'("1110010")
    , WORD'("0000000")
    , WORD'("1111100")
    , WORD'("0100000")
    , WORD'("0010000")
    , WORD'("1111101")
    , WORD'("1111111")
    , WORD'("1111010")
    , WORD'("0000001")
    , WORD'("1111110")
    , WORD'("1111101")
    , WORD'("0010000")
    , WORD'("0000010")
    , WORD'("0000110")
    , WORD'("1111111")
    , WORD'("1111010")
    , WORD'("1111011")
    , WORD'("1111001")
    , WORD'("1111001")
    , WORD'("0000011")
    , WORD'("0000111")
    , WORD'("0001010")
    , WORD'("0000001")
    , WORD'("0010111")
    , WORD'("1111101")
    , WORD'("1111101")
    , WORD'("1111000")
    , WORD'("0010000")
    , WORD'("0000111")
    , WORD'("1111111")
    , WORD'("0001011")
    , WORD'("0001011")
    , WORD'("0000111")
    , WORD'("1101000")
    , WORD'("1111001")
    , WORD'("0000011")
    , WORD'("1110111")
    , WORD'("0000001")
    , WORD'("0000100")
    , WORD'("1111011")
    , WORD'("0000111")
    , WORD'("1111100")
    , WORD'("1111111")
    , WORD'("0001000")
    , WORD'("1111101")
    , WORD'("0000110")
    , WORD'("0000001")
    , WORD'("1111111")
    , WORD'("0010011")
    , WORD'("0001001")
    , WORD'("1111101")
    , WORD'("0000110")
    , WORD'("0001100")
    , WORD'("1110110")
    , WORD'("1111100")
    , WORD'("1110110")
    , WORD'("0000000")
    , WORD'("1111010")
    , WORD'("0000000")
    , WORD'("0000000")
    , WORD'("0010001")
    , WORD'("0000100")
    , WORD'("0000000")
    , WORD'("1111001")
    , WORD'("0000100")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("0001111")
    , WORD'("1111110")
    , WORD'("0001110")
    , WORD'("0000100")
    , WORD'("0001010")
    , WORD'("1110011")
    , WORD'("1111111")
    , WORD'("1111101")
    , WORD'("0001111")
    , WORD'("1111101")
    , WORD'("1111101")
    , WORD'("1111101")
    , WORD'("1111000")
    , WORD'("0000101")
    , WORD'("0001000")
    , WORD'("1111110")
    , WORD'("0000000")
    , WORD'("1111000")
    , WORD'("1111011")
    , WORD'("0000001")
    , WORD'("0000100")
    , WORD'("0000011")
    , WORD'("1111110")
    , WORD'("1111101")
    , WORD'("0001101")
    , WORD'("1111100")
    , WORD'("0010000")
    , WORD'("0000000")
    , WORD'("0001100")
    , WORD'("1111001")
    , WORD'("1111100")
    , WORD'("1111101")
    , WORD'("1111000")
    , WORD'("0000100")
    , WORD'("0000111")
    , WORD'("1111101")
    , WORD'("0000111")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("0001001")
    , WORD'("0001110")
    , WORD'("0010001")
    , WORD'("1111000")
    , WORD'("1111110")
    , WORD'("1110111")
    , WORD'("0001110")
    , WORD'("1110110")
    , WORD'("1111011")
    , WORD'("0001100")
    , WORD'("0000001")
    , WORD'("0000010")
    , WORD'("1110111")
    , WORD'("1111000")
    , WORD'("1111101")
    , WORD'("0000111")
    , WORD'("0000111")
    , WORD'("0001000")
    , WORD'("0001101")
    , WORD'("0000001")
    , WORD'("0000001")
    , WORD'("1110011")
    , WORD'("0000111")
    , WORD'("1111101")
    , WORD'("1110111")
    , WORD'("1111101")
    , WORD'("0010001")
    , WORD'("0000000")
    , WORD'("1101011")
    , WORD'("0000001")
    , WORD'("0001101")
    , WORD'("0000110")
    , WORD'("0000110")
    , WORD'("0010111")
    , WORD'("0000110")
    , WORD'("0010000")
    , WORD'("1110111")
    , WORD'("1110111")
    , WORD'("0000001")
    , WORD'("0000001")
    , WORD'("1111000")
    , WORD'("0000100")
    , WORD'("0000001")
    , WORD'("1111110")
    , WORD'("1111000")
    , WORD'("1111110")
    , WORD'("0000101")
    , WORD'("0010001")
    , WORD'("1111000")
    , WORD'("0000001")
    , WORD'("1111110")
    , WORD'("0000010")
    , WORD'("0001011")
    , WORD'("0000001")
    , WORD'("0010011")
    , WORD'("0000000")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("0001110")
    , WORD'("0000110")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("1110110")
    , WORD'("1111101")
    , WORD'("1111000")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("0001001")
    , WORD'("0001001")
    , WORD'("0000010")
    , WORD'("0001000")
    , WORD'("1111001")
    , WORD'("1111100")
    , WORD'("1110001")
    , WORD'("1111110")
    , WORD'("0000011")
    , WORD'("0010001")
    , WORD'("0000101")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("0010101")
    , WORD'("0000110")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("0000010")
    , WORD'("1111010")
    , WORD'("1111100")
    , WORD'("1111000")
    , WORD'("1111011")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("1111010")
    , WORD'("1111100")
    , WORD'("0000001")
    , WORD'("0000111")
    , WORD'("0011010")
    , WORD'("0000101")
    , WORD'("0000011")
    , WORD'("0000111")
    , WORD'("1111111")
    , WORD'("0000011")
    , WORD'("1111111")
    , WORD'("0001100")
    , WORD'("1111110")
    , WORD'("0000010")
    , WORD'("1110110")
    , WORD'("1111011")
    , WORD'("1111111")
    , WORD'("0000011")
    , WORD'("1111100")
    , WORD'("0000011")
    , WORD'("0000110")
    , WORD'("0000001")
    , WORD'("1111011")
    , WORD'("0001101")
    , WORD'("1111100")
    , WORD'("1111100")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("0000111")
    , WORD'("1111011")
    , WORD'("0001001")
    , WORD'("0000011")
    , WORD'("1110111")
    , WORD'("0001011")
    , WORD'("1111101")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("0001000")
    , WORD'("0000000")
    , WORD'("0010000")
    , WORD'("0000010")
    , WORD'("0000110")
    , WORD'("0000110")
    , WORD'("1111111")
    , WORD'("1111000")
    , WORD'("1111111")
    , WORD'("1111111")
    , WORD'("0001100")
    , WORD'("0000011")
    , WORD'("0000010")
    , WORD'("1111011")
    , WORD'("0000110")
    , WORD'("1111110")
    , WORD'("1111100")
    , WORD'("0000000")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("1111011")
    , WORD'("1111111")
    , WORD'("0000111")
    , WORD'("1111111")
    , WORD'("0000001")
    , WORD'("1111101")
    , WORD'("0001011")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("0010111")
    , WORD'("1111010")
    , WORD'("1110101")
    , WORD'("1111001")
    , WORD'("1111110")
    , WORD'("0000010")
    , WORD'("1111100")
    , WORD'("0000000")
    , WORD'("0010010")
    , WORD'("0010000")
    , WORD'("1111000")
    , WORD'("0011010")
    , WORD'("1111011")
    , WORD'("0000111")
    , WORD'("1111011")
    , WORD'("0000001")
    , WORD'("1111111")
    , WORD'("1111001")
    , WORD'("1110110")
    , WORD'("1111000")
    , WORD'("1111000")
    , WORD'("1111111")
    , WORD'("0011000")
    , WORD'("0000001")
    , WORD'("0001001")
    , WORD'("0001001")
    , WORD'("1111110")
    , WORD'("1111111")
    , WORD'("1111010")
    , WORD'("0000010")
    , WORD'("0010111")
    , WORD'("1111011")
    , WORD'("1111010")
    , WORD'("1111100")
    , WORD'("1111001")
    , WORD'("0000001")
    , WORD'("1111100")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("0000101")
    , WORD'("0000010")
    , WORD'("0001001")
    , WORD'("1110010")
    , WORD'("1110110")
    , WORD'("1111001")
    , WORD'("0000101")
    , WORD'("1111011")
    , WORD'("0001101")
    , WORD'("0001011")
    , WORD'("0000011")
    , WORD'("0000100")
    , WORD'("1111011")
    , WORD'("0000011")
    , WORD'("1111101")
    , WORD'("1110110")
    , WORD'("0000110")
    , WORD'("1111000")
    , WORD'("0010110")
    , WORD'("1111011")
    , WORD'("1111111")
    , WORD'("0010101")
    , WORD'("1111011")
    , WORD'("1111011")
    , WORD'("1111001")
    , WORD'("1111111")
    , WORD'("0000001")
    , WORD'("1111111")
    , WORD'("1111100")
    , WORD'("0001001")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("0000101")
    , WORD'("0001001")
    , WORD'("0000010")
    , WORD'("0000010")
    , WORD'("0011000")
    , WORD'("1111000")
    , WORD'("1110111")
    , WORD'("1110110")
    , WORD'("0000010")
    , WORD'("0000010")
    , WORD'("1110111")
    , WORD'("0000000")
    , WORD'("1111010")
    , WORD'("1111001")
    , WORD'("1111000")
    , WORD'("1111101")
    , WORD'("0001110")
    , WORD'("0011011")
    , WORD'("1111110")
    , WORD'("1110101")
    , WORD'("1111100")
    , WORD'("0001000")
    , WORD'("0001010")
    , WORD'("0001001")
    , WORD'("0000100")
    , WORD'("0000100")
    , WORD'("1110101")
    , WORD'("0001101")
    , WORD'("0000111")
    , WORD'("0000001")
    , WORD'("1111100")
    , WORD'("1111110")
    , WORD'("0000000")
    , WORD'("1111111")
    , WORD'("1111101")
    , WORD'("1111001")
    , WORD'("0001000")
    , WORD'("0000010")
    , WORD'("0001011")
    , WORD'("0001100")
    , WORD'("1111110")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("1110110")
    , WORD'("1111001")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("0001111")
    , WORD'("0000001")
    , WORD'("1111011")
    , WORD'("0001000")
    , WORD'("0000101")
    , WORD'("0000001")
    , WORD'("0001010")
    , WORD'("0000001")
    , WORD'("0010011")
    , WORD'("1111010")
    , WORD'("1111110")
    , WORD'("0001110")
    , WORD'("1111011")
    , WORD'("0001000")
    , WORD'("1111110")
    , WORD'("0000101")
    , WORD'("1111000")
    , WORD'("0000011")
    , WORD'("1110010")
    , WORD'("0001110")
    , WORD'("1111100")
    , WORD'("1111010")
    , WORD'("1111100")
    , WORD'("1111001")
    , WORD'("0000111")
    , WORD'("0000010")
    , WORD'("0010110")
    , WORD'("0000000")
    , WORD'("1111111")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("1111111")
    , WORD'("1111100")
    , WORD'("0000001")
    , WORD'("0000010")
    , WORD'("0001010")
    , WORD'("0000100")
    , WORD'("0000011")
    , WORD'("0010000")
    , WORD'("1110111")
    , WORD'("1111101")
    , WORD'("0000001")
    , WORD'("0000011")
    , WORD'("0000101")
    , WORD'("1110111")
    , WORD'("0000011")
    , WORD'("1110111")
    , WORD'("1111101")
    , WORD'("0010000")
    , WORD'("1111111")
    , WORD'("0000001")
    , WORD'("1111010")
    , WORD'("0000001")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("0001100")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("0000111")
    , WORD'("0000001")
    , WORD'("1111010")
    , WORD'("0001001")
    , WORD'("1111010")
    , WORD'("0001000")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("1110111")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("0000000")
    , WORD'("0000110")
    , WORD'("1111111")
    , WORD'("1111110")
    , WORD'("1111100")
    , WORD'("0000010")
    , WORD'("0001110")
    , WORD'("0000001")
    , WORD'("0000001")
    , WORD'("0000000")
    , WORD'("1111110")
    , WORD'("1111010")
    , WORD'("1111010")
    , WORD'("0000100")
    , WORD'("1111101")
    , WORD'("1111101")
    , WORD'("0000001")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("0000000")
    , WORD'("0000010")
    , WORD'("0001000")
    , WORD'("0001001")
    , WORD'("1111001")
    , WORD'("0010110")
    , WORD'("1111011")
    , WORD'("0001001")
    , WORD'("1111110")
    , WORD'("0000000")
    , WORD'("1111100")
    , WORD'("1111110")
    , WORD'("1110100")
    , WORD'("1111001")
    , WORD'("1111101")
    , WORD'("0000001")
    , WORD'("0010110")
    , WORD'("1111110")
    , WORD'("0000111")
    , WORD'("0000010")
    , WORD'("1111010")
    , WORD'("0000000")
    , WORD'("1111000")
    , WORD'("0000010")
    , WORD'("0010101")
    , WORD'("0000000")
    , WORD'("1111010")
    , WORD'("1111001")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("1111010")
    , WORD'("1111110")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("0001100")
    , WORD'("0000001")
    , WORD'("1111101")
    , WORD'("1111010")
    , WORD'("1111011")
    , WORD'("1111111")
    , WORD'("1111100")
    , WORD'("0001111")
    , WORD'("1111110")
    , WORD'("1111101")
    , WORD'("0000100")
    , WORD'("1111111")
    , WORD'("1111011")
    , WORD'("1111010")
    , WORD'("1111100")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("0010011")
    , WORD'("1111100")
    , WORD'("1111110")
    , WORD'("0010111")
    , WORD'("1110110")
    , WORD'("1111011")
    , WORD'("1111010")
    , WORD'("0000000")
    , WORD'("0001000")
    , WORD'("1111010")
    , WORD'("0000001")
    , WORD'("0000001")
    , WORD'("1111111")
    , WORD'("0000100")
    , WORD'("0000101")
    , WORD'("0000010")
    , WORD'("1111100")
    , WORD'("0000000")
    , WORD'("0010100")
    , WORD'("1111110")
    , WORD'("1110110")
    , WORD'("1111100")
    , WORD'("0001010")
    , WORD'("0000000")
    , WORD'("1111011")
    , WORD'("1110010")
    , WORD'("1111001")
    , WORD'("1111011")
    , WORD'("1110110")
    , WORD'("1111011")
    , WORD'("0010001")
    , WORD'("0011001")
    , WORD'("1111110")
    , WORD'("1110110")
    , WORD'("1111010")
    , WORD'("0000101")
    , WORD'("0001110")
    , WORD'("0000010")
    , WORD'("0001001")
    , WORD'("1111010")
    , WORD'("1111001")
    , WORD'("0001100")
    , WORD'("0001010")
    , WORD'("0000011")
    , WORD'("1111111")
    , WORD'("0000100")
    , WORD'("1111111")
    , WORD'("1111011")
    , WORD'("0000000")
    , WORD'("1111011")
    , WORD'("0000110")
    , WORD'("1111001")
    , WORD'("0000110")
    , WORD'("0001101")
    , WORD'("1110000")
    , WORD'("0001000")
    , WORD'("1111100")
    , WORD'("1111011")
    , WORD'("0000001")
    , WORD'("1111010")
    , WORD'("1111100")
    , WORD'("0001100")
    , WORD'("1111000")
    , WORD'("0000011")
    , WORD'("0001001")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("0000101")
    , WORD'("0000110")
    , WORD'("1111011")
    , WORD'("0000001")
    , WORD'("1111001")
    , WORD'("1111100")
    , WORD'("0000100")
    , WORD'("1111110")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("1111011")
    , WORD'("0000001")
    , WORD'("1111101")
    , WORD'("0001100")
    , WORD'("0000110")
    , WORD'("1111010")
    , WORD'("1111100")
    , WORD'("1111001")
    , WORD'("0000101")
    , WORD'("0000011")
    , WORD'("0010100")
    , WORD'("1111011")
    , WORD'("1111101")
    , WORD'("0000101")
    , WORD'("1111111")
    , WORD'("1111011")
    , WORD'("1111100")
    , WORD'("1110111")
    , WORD'("0000001")
    , WORD'("0001100")
    , WORD'("0001001")
    , WORD'("0000000")
    , WORD'("0011101")
    , WORD'("1110100")
    , WORD'("1111000")
    , WORD'("1111101")
    , WORD'("0001000")
    , WORD'("0000010")
    , WORD'("1111000")
    , WORD'("0000101")
    , WORD'("1111110")
    , WORD'("1111010")
    , WORD'("0001010")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("1111110")
    , WORD'("0000001")
    , WORD'("1111110")
    , WORD'("1111100")
    , WORD'("0001011")
    , WORD'("1111110")
    , WORD'("1111100")
    , WORD'("0001001")
    , WORD'("0000010")
    , WORD'("1111110")
    , WORD'("1111101")
    , WORD'("1111110")
    , WORD'("0000111")
    , WORD'("0000101")
    , WORD'("0000000")
    , WORD'("0000011")
    , WORD'("1111101")
    , WORD'("0001000")
    , WORD'("1111010")
    , WORD'("0000000")
    , WORD'("0000010")
    , WORD'("1111011")
    , WORD'("0000011")
    , WORD'("1111110")
    , WORD'("0000111")
    , WORD'("1111110")
    , WORD'("1111010")
    , WORD'("1111110")
    , WORD'("0000111")
    , WORD'("0000011")
    , WORD'("1111101")
    , WORD'("1111000")
    , WORD'("1111110")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("0001000")
    , WORD'("0000011")
    , WORD'("0001000")
    , WORD'("1111110")
    , WORD'("0000001")
    , WORD'("0000000")
    , WORD'("0000101")
    , WORD'("0001001")
    , WORD'("1111110")
    , WORD'("0000001")
    , WORD'("1111101")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("0000010")
    , WORD'("1111000")
    , WORD'("1111101")
    , WORD'("1111110")
    , WORD'("1111110")
    , WORD'("0001000")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("0000100")
    , WORD'("1111011")
    , WORD'("0000101")
    , WORD'("1111110")
    , WORD'("1111101")
    , WORD'("0001100")
    , WORD'("1111101")
    , WORD'("1111011")
    , WORD'("1111100")
    , WORD'("1111010")
    , WORD'("0000100")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("0000111")
    , WORD'("1111100")
    , WORD'("0000011")
    , WORD'("0000101")
    , WORD'("1111111")
    , WORD'("1111111")
    , WORD'("1111101")
    , WORD'("0000101")
    , WORD'("1110101")
    , WORD'("0010110")
    , WORD'("1111011")
    , WORD'("0001001")
    , WORD'("0000100")
    , WORD'("1111111")
    , WORD'("1111001")
    , WORD'("1111011")
    , WORD'("1111100")
    , WORD'("1111011")
    , WORD'("0000000")
    , WORD'("0001101")
    , WORD'("0000000")
    , WORD'("0000100")
    , WORD'("0001001")
    , WORD'("0000101")
    , WORD'("1111111")
    , WORD'("0000101")
    , WORD'("1110110")
    , WORD'("1110111")
    , WORD'("1111011")
    , WORD'("0001000")
    , WORD'("0000000")
    , WORD'("1110011")
    , WORD'("0000001")
    , WORD'("0000111")
    , WORD'("0000101")
    , WORD'("1111111")
    , WORD'("0001001")
    , WORD'("0000101")
    , WORD'("0001110")
    , WORD'("1111000")
    , WORD'("0000000")
    , WORD'("0000000")
    , WORD'("0000011")
    , WORD'("1111000")
    , WORD'("0000010")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("1110110")
    , WORD'("0000001")
    , WORD'("0000011")
    , WORD'("0010001")
    , WORD'("1111010")
    , WORD'("0000000")
    , WORD'("0000000")
    , WORD'("1111101")
    , WORD'("1111110")
    , WORD'("1110110")
    , WORD'("0010000")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("0001111")
    , WORD'("0000000")
    , WORD'("0000011")
    , WORD'("1110111")
    , WORD'("0001100")
    , WORD'("1111010")
    , WORD'("0001001")
    , WORD'("1110110")
    , WORD'("1110111")
    , WORD'("0000101")
    , WORD'("0001010")
    , WORD'("0000010")
    , WORD'("0001101")
    , WORD'("0000001")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("1111000")
    , WORD'("1111001")
    , WORD'("0010011")
    , WORD'("1111000")
    , WORD'("0000111")
    , WORD'("0001000")
    , WORD'("1111111")
    , WORD'("1111110")
    , WORD'("0000000")
    , WORD'("0000011")
    , WORD'("1111001")
    , WORD'("1111110")
    , WORD'("0000110")
    , WORD'("1111010")
    , WORD'("0000100")
    , WORD'("1111110")
    , WORD'("0000010")
    , WORD'("1111000")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("0000000")
    , WORD'("0001100")
    , WORD'("0000000")
    , WORD'("0000110")
    , WORD'("1111011")
    , WORD'("1111011")
    , WORD'("0000100")
    , WORD'("1111000")
    , WORD'("0001111")
    , WORD'("0000010")
    , WORD'("1111100")
    , WORD'("1111111")
    , WORD'("0000011")
    , WORD'("0000001")
    , WORD'("0000010")
    , WORD'("0000000")
    , WORD'("0000000")
    , WORD'("0001010")
    , WORD'("1111101")
    , WORD'("0000000")
    , WORD'("0000100")
    , WORD'("1111001")
    , WORD'("1111111")
    , WORD'("0000101")
    , WORD'("1111011")
    , WORD'("0000110")
    , WORD'("1111010")
    , WORD'("0000110")
    , WORD'("1111100")
    , WORD'("1110111")
    , WORD'("0001111")
    , WORD'("1111111")
    , WORD'("1111110")
    , WORD'("1111110")
    , WORD'("1111000")
    , WORD'("0000011")
    , WORD'("0000011")
    , WORD'("0010001")
    , WORD'("0000010")
    , WORD'("0000110")
    , WORD'("0001101")
    , WORD'("1111000")
    , WORD'("1111110")
    , WORD'("0000100")
    , WORD'("1111011")
    , WORD'("0001111")
    , WORD'("1111101")
    , WORD'("0000001")
    , WORD'("1111100")
    , WORD'("0000010")
    , WORD'("0000001")
    , WORD'("0000000")
    , WORD'("1111010")
    , WORD'("1111101")
    , WORD'("1111011")
    , WORD'("0000100")
    , WORD'("0000001")
    , WORD'("1111111")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("0000111")
    , WORD'("0000011")
    , WORD'("1111101")
    , WORD'("1111100")
    , WORD'("0011010")
    , WORD'("1110011")
    , WORD'("1111100")
    , WORD'("1110001")
    , WORD'("1111001")
    , WORD'("0000000")
    , WORD'("1111101")
    , WORD'("0000011")
    , WORD'("0011000")
    , WORD'("0000111")
    , WORD'("1111011")
    , WORD'("0001011")
    , WORD'("0000000")
    , WORD'("0000110")
    , WORD'("1111011")
    , WORD'("0001001")
    , WORD'("1111101")
    , WORD'("1111100")
    , WORD'("1111001")
    , WORD'("1111010")
    , WORD'("1110111")
    , WORD'("0001001")
    , WORD'("0001000")
    , WORD'("0001010")
    , WORD'("0001001")
    , WORD'("0001011")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("0000000")
    , WORD'("0001101")
    , WORD'("1111011")
    , WORD'("0000000")
    , WORD'("1111000")
    , WORD'("1111110")
    , WORD'("1111110")
    , WORD'("1111100")
    , WORD'("0000000")
    , WORD'("0000110")
    , WORD'("0011010")
    , WORD'("1111001")
    , WORD'("1111111")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("0000000")
    , WORD'("1110010")
    , WORD'("1111001")
    , WORD'("0001101")
    , WORD'("0000111")
    , WORD'("1111011")
    , WORD'("1111101")
    , WORD'("0000100")
    , WORD'("1111110")
    , WORD'("0000110")
    , WORD'("1110110")
    , WORD'("1111000")
    , WORD'("0000010")
    , WORD'("0001110")
    , WORD'("0000011")
    , WORD'("0000010")
    , WORD'("0010110")
    , WORD'("1111110")
    , WORD'("1111100")
    , WORD'("1111110")
    , WORD'("1110110")
    , WORD'("1110100")
    , WORD'("0000001")
    , WORD'("1110101")
    , WORD'("0011001")
    , WORD'("1111111")
    , WORD'("0000110")
    , WORD'("0001011")
    , WORD'("1111111")
    , WORD'("0000011")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("1111010")
    , WORD'("1111100")
    , WORD'("0000000")
    , WORD'("1111011")
    , WORD'("0000011")
    , WORD'("0000110")
    , WORD'("1111110")
    , WORD'("0000100")
    , WORD'("1111100")
    , WORD'("1110111")
    , WORD'("0000101")
    , WORD'("0000011")
    , WORD'("0001010")
    , WORD'("1111111")
    , WORD'("1111000")
    , WORD'("0001001")
    , WORD'("0001000")
    , WORD'("0000110")
    , WORD'("1111111")
    , WORD'("0001110")
    , WORD'("1111111")
    , WORD'("1101011")
    , WORD'("0001101")
    , WORD'("0000110")
    , WORD'("0000010")
    , WORD'("0001001")
    , WORD'("0000000")
    , WORD'("0000100")
    , WORD'("1111010")
    , WORD'("1110101")
    , WORD'("0000000")
    , WORD'("0001001")
    , WORD'("0000010")
    , WORD'("0001110")
    , WORD'("0001100")
    , WORD'("1110101")
    , WORD'("0000001")
    , WORD'("1110110")
    , WORD'("1110011")
    , WORD'("1111101")
    , WORD'("1111110")
    , WORD'("0000001")
    , WORD'("0010101")
    , WORD'("0000011")
    , WORD'("1111111")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("0001010")
    , WORD'("0000101")
    , WORD'("1111011")
    , WORD'("0001101")
    , WORD'("1110100")
    , WORD'("0000111")
    , WORD'("0000001")
    , WORD'("0001001")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("1110110")
    , WORD'("1111101")
    , WORD'("0010001")
    , WORD'("1110000")
    , WORD'("0011000")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("1111110")
    , WORD'("1111001")
    , WORD'("0000001")
    , WORD'("0001000")
    , WORD'("0001100")
    , WORD'("1111100")
    , WORD'("0000011")
    , WORD'("1111111")
    , WORD'("1111101")
    , WORD'("0000000")
    , WORD'("0000000")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("0000100")
    , WORD'("1111101")
    , WORD'("0000010")
    , WORD'("0001000")
    , WORD'("1111001")
    , WORD'("1111110")
    , WORD'("0001100")
    , WORD'("1111111")
    , WORD'("1111111")
    , WORD'("1111001")
    , WORD'("0000100")
    , WORD'("1111110")
    , WORD'("1111000")
    , WORD'("0011010")
    , WORD'("1111000")
    , WORD'("0000011")
    , WORD'("1111001")
    , WORD'("1110010")
    , WORD'("0000001")
    , WORD'("0000010")
    , WORD'("0011011")
    , WORD'("0001111")
    , WORD'("1111101")
    , WORD'("0001101")
    , WORD'("1111101")
    , WORD'("1111000")
    , WORD'("0001000")
    , WORD'("1111000")
    , WORD'("0010001")
    , WORD'("1111001")
    , WORD'("1111110")
    , WORD'("1111101")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("0000000")
    , WORD'("0000011")
    , WORD'("1111011")
    , WORD'("0000101")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("1111111")
    , WORD'("0001110")
    , WORD'("1111111")
    , WORD'("1111001")
    , WORD'("0000001")
    , WORD'("0001010")
    , WORD'("1111010")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("1111111")
    , WORD'("1111000")
    , WORD'("0000011")
    , WORD'("1111010")
    , WORD'("0010011")
    , WORD'("0000011")
    , WORD'("1111111")
    , WORD'("0000101")
    , WORD'("1111111")
    , WORD'("0000011")
    , WORD'("1111011")
    , WORD'("0000100")
    , WORD'("1111101")
    , WORD'("0000001")
    , WORD'("1111101")
    , WORD'("0000001")
    , WORD'("1111100")
    , WORD'("0000001")
    , WORD'("0001101")
    , WORD'("0001000")
    , WORD'("0000000")
    , WORD'("0000101")
    , WORD'("0000010")
    , WORD'("1111011")
    , WORD'("1111000")
    , WORD'("0000001")
    , WORD'("0001010")
    , WORD'("1111110")
    , WORD'("1111111")
    , WORD'("1111010")
    , WORD'("1111110")
    , WORD'("1111111")
    , WORD'("1111111")
    , WORD'("1111111")
    , WORD'("0000100")
    , WORD'("1111011")
    , WORD'("0001011")
    , WORD'("1111110")
    , WORD'("1111111")
    , WORD'("1110111")
    , WORD'("0000100")
    , WORD'("0000000")
    , WORD'("1111011")
    , WORD'("0010011")
    , WORD'("1111101")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("0000111")
    , WORD'("1111011")
    , WORD'("0000101")
    , WORD'("1111010")
    , WORD'("1111011")
    , WORD'("0000010")
    , WORD'("0001001")
    , WORD'("0000100")
    , WORD'("0000001")
    , WORD'("0011001")
    , WORD'("1111001")
    , WORD'("1111000")
    , WORD'("1111001")
    , WORD'("1111000")
    , WORD'("1111100")
    , WORD'("0000010")
    , WORD'("1111010")
    , WORD'("0010000")
    , WORD'("0000111")
    , WORD'("0000101")
    , WORD'("0000010")
    , WORD'("0000000")
    , WORD'("0000010")
    , WORD'("1111011")
    , WORD'("0000010")
    , WORD'("1111101")
    , WORD'("1111100")
    , WORD'("1111101")
    , WORD'("1111111")
    , WORD'("1111110")
    , WORD'("0000101")
    , WORD'("0000010")
    , WORD'("0000010")
    , WORD'("1111101")
    , WORD'("1111010")
    , WORD'("1111111")
    , WORD'("0000010")
    , WORD'("0001010")
    , WORD'("1111010")
    , WORD'("1110111")
    , WORD'("0000111")
    , WORD'("0000011")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("0001100")
    , WORD'("1110111")
    , WORD'("0000001")
    , WORD'("0000111")
    , WORD'("0001100")
    , WORD'("1111100")
    , WORD'("0010100")
    , WORD'("0000000")
    , WORD'("0000010")
    , WORD'("1111110")
    , WORD'("1110111")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("1110111")
    , WORD'("0001110")
    , WORD'("0001010")
    , WORD'("1111011")
    , WORD'("0000100")
    , WORD'("1111000")
    , WORD'("1111001")
    , WORD'("1111010")
    , WORD'("1111101")
    , WORD'("0000101")
    , WORD'("0000100")
    , WORD'("1111100")
    , WORD'("0000111")
    , WORD'("1111010")
    , WORD'("0000001")
    , WORD'("0001010")
    , WORD'("1110011")
    , WORD'("1111100")
    , WORD'("0000001")
    , WORD'("0000101")
    , WORD'("0000111")
    , WORD'("0001100")
    , WORD'("0000101")
    , WORD'("1111101")
    , WORD'("1110111")
    , WORD'("0000000")
    , WORD'("1111110")
    , WORD'("1111101")
    , WORD'("1111101")
    , WORD'("0000110")
    , WORD'("0000100")
    , WORD'("0000101")
    , WORD'("1111100")
    , WORD'("1110101")
    , WORD'("0000100")
    , WORD'("0000011")
    , WORD'("0001010")
    , WORD'("1111000")
    , WORD'("0000100")
    , WORD'("1111110")
    , WORD'("0000011")
    , WORD'("1111100")
    , WORD'("1111100")
    , WORD'("0000001")
    , WORD'("0000001")
    , WORD'("0000110")
    , WORD'("0000001")
    , WORD'("0000010")
    , WORD'("0001001")
    , WORD'("1111001")
    , WORD'("1111110")
    , WORD'("0000110")
    , WORD'("1111111")
    , WORD'("0000011")
    , WORD'("0000001")
    , WORD'("1111111")
    , WORD'("1111111")
    , WORD'("1110111")
    , WORD'("0010110")
    , WORD'("1111001")
    , WORD'("0000000")
    , WORD'("1111111")
    , WORD'("1110101")
    , WORD'("1111101")
    , WORD'("0000011")
    , WORD'("0010011")
    , WORD'("1111110")
    , WORD'("0000010")
    , WORD'("0001001")
    , WORD'("0000100")
    , WORD'("0000000")
    , WORD'("0000101")
    , WORD'("1111100")
    , WORD'("0001011")
    , WORD'("0000000")
    , WORD'("0000000")
    , WORD'("1111011")
    , WORD'("0000101")
    , WORD'("0000010")
    , WORD'("1111101")
    , WORD'("1111010")
    , WORD'("1111111")
    , WORD'("0000001")
    , WORD'("0000111")
    , WORD'("1111111")
    , WORD'("1111010")
    , WORD'("0000000")
    , WORD'("0000010")
    , WORD'("1111011")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("0001000")
    , WORD'("1111110")
    , WORD'("0000100")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("0000010")
    , WORD'("1111001")
    , WORD'("0000100")
    , WORD'("1111010")
    , WORD'("0000100")
    , WORD'("1111101")
    , WORD'("0000100")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("1111110")
    , WORD'("1111110")
    , WORD'("0000001")
    , WORD'("1111111")
    , WORD'("1111111")
    , WORD'("0000011")
    , WORD'("1110111")
    , WORD'("1111010")
    , WORD'("0000110")
    , WORD'("0000000")
    , WORD'("0000110")
    , WORD'("0001000")
    , WORD'("0001011")
    , WORD'("1111101")
    , WORD'("1111111")
    , WORD'("0000001")
    , WORD'("1111111")
    , WORD'("0000101")
    , WORD'("0000001")
    , WORD'("0000000")
    , WORD'("0000000")
    , WORD'("1111111")
    , WORD'("1111111")
    , WORD'("1111110")
    , WORD'("1111011")
    , WORD'("0000100")
    , WORD'("1111000")
    , WORD'("0001010")
    , WORD'("0000000")
    , WORD'("0001000")
    , WORD'("1111011")
    , WORD'("1111110")
    , WORD'("0000001")
    , WORD'("1111000")
    , WORD'("0001101")
    , WORD'("0000010")
    , WORD'("0000110")
    , WORD'("1111101")
    , WORD'("0000110")
    , WORD'("1111011")
    , WORD'("1111011")
    , WORD'("1111101")
    , WORD'("1111110")
    , WORD'("0000000")
    , WORD'("0000101")
    , WORD'("0000100")
    , WORD'("0000101")
    , WORD'("0001111")
    , WORD'("1111111")
    , WORD'("0000000")
    , WORD'("1111101")
    , WORD'("1110101")
    , WORD'("1110001")
    , WORD'("1111011")
    , WORD'("0001100")
    , WORD'("0001010")
    , WORD'("1111001")
    , WORD'("0000000")
    , WORD'("0001100")
    , WORD'("1111111")
    , WORD'("0001001")
    , WORD'("0001100")
    , WORD'("1111100")
    , WORD'("0000001")
    , WORD'("1110110")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("0000101")
    , WORD'("0000010")
    , WORD'("0000101")
    , WORD'("0000001")
    , WORD'("1111110")
    , WORD'("1111010")
    , WORD'("1111111")
    , WORD'("0000010")
    , WORD'("0000011")
    , WORD'("1111100")
    , WORD'("0000010")
    , WORD'("0000111")
    , WORD'("0000000")
    , WORD'("0000100")
    , WORD'("1110111")
    , WORD'("0001010")
    , WORD'("1111001")
    , WORD'("0000001")
    , WORD'("0000111")
    , WORD'("1111110")
    , WORD'("0000101")
    , WORD'("0000000")
    , WORD'("0001100")
    , WORD'("1111110")
    , WORD'("0000101")
    , WORD'("1110000")
    , WORD'("0000101")
    , WORD'("0010011")
    , WORD'("1111010")
    , WORD'("0001011")
    , WORD'("0010001")
    , WORD'("1110011")
    , WORD'("1111110")
    , WORD'("1110111")
    , WORD'("1111000")
    , WORD'("1111011")
    , WORD'("1111010")
    , WORD'("1111011")
    , WORD'("0011110")
    , WORD'("1111100")
    , WORD'("0001001")
    , WORD'("1111101")
    , WORD'("1111100")
    , WORD'("1111111")
    , WORD'("1111101")
    , WORD'("0000011")
    , WORD'("1111101")
    , WORD'("0000011")
    , WORD'("0000111")
    , WORD'("0010000")
    , WORD'("1111000")
    , WORD'("0001111")
    , WORD'("1111111")
    , WORD'("1111100")
    , WORD'("0000100")
    , WORD'("1111110")
    , WORD'("0000011")
    , WORD'("0000000")
    , WORD'("1111100")
    , WORD'("0000001")
    , WORD'("0000110")
    , WORD'("1111011")
    , WORD'("0000100")
    , WORD'("1111111")
    , WORD'("0000100")
    , WORD'("1111101")
    , WORD'("0000000")
    , WORD'("0000001")
    , WORD'("0000000")
    , WORD'("0000010")
    , WORD'("1111111")
    , WORD'("1111100")
    , WORD'("0000111")
    , WORD'("0000010")
    , WORD'("1111010")
    , WORD'("0000011")
    , WORD'("0000100")
    , WORD'("1111101")
    , WORD'("1111110")
    , WORD'("0000100")
    , WORD'("1111110")
    , WORD'("0001000")
    , WORD'("1111011")
    , WORD'("0001000")
    , WORD'("0000001")
    , WORD'("1111100")
    , WORD'("0001011")
    , WORD'("1110110")
    , WORD'("0000011")
    );
    type data_out_2D is array (natural range <>) of std_logic_vector(6 downto 0);
    type addr_2D is array(natural range <>) of std_logic_vector(10 downto 0);
    signal addr_reg     : addr_2D(num_input_registers downto 0);
    signal addr_f : std_logic_vector(10 downto 0);
    signal data_out_reg : data_out_2D(num_output_registers downto 0);
    signal data_out_t : std_logic_vector(6 downto 0);
    signal REG_PWR : std_logic;
    constant REG_GND : std_logic := '0';
BEGIN
  REG_PWR <= '1';

  -- Input register stages
  n_inreg_blk: for i in num_input_registers - 1 downto 1 generate
    i_addr_reg : work.mgc_comps.mgc_generic_reg
      GENERIC MAP (11, ph_clk, ph_en, 0, 0,a_rst_used,s_rst_used, en_used)
      PORT MAP (addr_reg(i-1), clk, en, REG_PWR, REG_PWR, addr_reg(i));
  end generate n_inreg_blk;
  n_inreg_gt_0_blk: if num_input_registers > 0 generate
  i_addr_reg_init : work.mgc_comps.mgc_generic_reg
    GENERIC MAP (11, ph_clk, ph_en, 0, 0, a_rst_used, s_rst_used, en_used)
    PORT MAP (addr, clk, en, REG_PWR, REG_PWR, addr_reg(0));
    addr_f <= addr_reg(num_input_registers-1);
  end generate n_inreg_gt_0_blk;
  n_inreg_eq_0_blk: if num_input_registers = 0 generate
    addr_f <= addr;
  end generate n_inreg_eq_0_blk;


  -- Reading ROM
  PROCESS(addr_f)
    VARIABLE idx : INTEGER;
    VARIABLE addr_f_mx : std_logic_vector(addr_f'range);
  BEGIN
    idx := conv_integer(unsigned(addr_f));
    IF idx >= 0 AND idx < 1800 THEN
      addr_f_mx := addr_f;
    ELSE
      addr_f_mx := STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(addr_f(9 downto 0)), 11));
    END IF;
    data_out_t<= mem(conv_integer(unsigned(addr_f_mx)));
  END PROCESS;

-- Output register stages
n_outreg_eq_0: if num_output_registers = 0 generate
  data_out<= data_out_t;
end generate n_outreg_eq_0;
n_outreg_gt_0: if num_output_registers > 0 generate
  i_data_out_reg_init : work.mgc_comps.mgc_generic_reg
    GENERIC MAP (7, ph_clk, ph_en, 0, 0, a_rst_used, s_rst_used, en_used)
    PORT MAP (data_out_t, clk, en, REG_PWR, REG_PWR, data_out_reg(0));
  n_outreg_blk: for i in num_output_registers - 1 downto 1 generate
    i_data_out_reg : work.mgc_comps.mgc_generic_reg
      GENERIC MAP (7, ph_clk, ph_en, 0, 0,a_rst_used,s_rst_used, en_used)
      PORT MAP (data_out_reg(i-1), clk, en, REG_PWR, REG_PWR, data_out_reg(i));
  end generate n_outreg_blk;
  data_out <= data_out_reg(num_output_registers-1);
end generate n_outreg_gt_0;
END v1;



--------> ./rtl.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    10.0a/269363 Production Release
--  HLS Date:       Wed Nov  9 17:38:00 PST 2016
-- 
--  Generated by:   xph3sei714@cimeld95
--  Generated date: Mon Feb  5 10:04:15 2018
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    ram_Xilinx_ARTIX_7_1_RAMSB_singleport_rwport_en_3_10_16_4_0_1_0_0_0_1_1_1_0_10_16_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.singleport_ram_be_pkg.ALL;


ENTITY ram_Xilinx_ARTIX_7_1_RAMSB_singleport_rwport_en_3_10_16_4_0_1_0_0_0_1_1_1_0_10_16_1_gen
    IS
  PORT(
    en : OUT STD_LOGIC;
    data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    we : OUT STD_LOGIC;
    re : OUT STD_LOGIC;
    addr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    data_in : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    data_in_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    addr_d : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    re_d : IN STD_LOGIC;
    we_d : IN STD_LOGIC;
    data_out_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    en_d : IN STD_LOGIC
  );
END ram_Xilinx_ARTIX_7_1_RAMSB_singleport_rwport_en_3_10_16_4_0_1_0_0_0_1_1_1_0_10_16_1_gen;

ARCHITECTURE v1 OF ram_Xilinx_ARTIX_7_1_RAMSB_singleport_rwport_en_3_10_16_4_0_1_0_0_0_1_1_1_0_10_16_1_gen
    IS
  -- Default Constants

BEGIN
  -- Default Constant Signal Assignments

  en <= (en_d);
  data_out_d <= data_out;
  we <= (we_d);
  re <= (re_d);
  addr <= (addr_d);
  data_in <= (data_in_d);
END v1;

-- ------------------------------------------------------------------
--  Design Unit:    top_core_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.singleport_ram_be_pkg.ALL;


ENTITY top_core_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
    perceptronOut_vinit_C_1_tr0 : IN STD_LOGIC;
    PROD_ACC_C_1_tr0 : IN STD_LOGIC;
    MAIN_LOOP_C_0_tr0 : IN STD_LOGIC;
    BIAS_ADD_C_4_tr0 : IN STD_LOGIC
  );
END top_core_core_fsm;

ARCHITECTURE v1 OF top_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for top_core_core_fsm_1
  TYPE top_core_core_fsm_1_ST IS (core_rlp_C_0, perceptronOut_vinit_C_0, perceptronOut_vinit_C_1,
      main_C_0, PROD_ACC_C_0, PROD_ACC_C_1, MAIN_LOOP_C_0, BIAS_ADD_C_0, BIAS_ADD_C_1,
      BIAS_ADD_C_2, BIAS_ADD_C_3, BIAS_ADD_C_4, main_C_1);

  SIGNAL state_var : top_core_core_fsm_1_ST;
  SIGNAL state_var_NS : top_core_core_fsm_1_ST;

BEGIN
  -- Default Constant Signal Assignments

  top_core_core_fsm_1 : PROCESS (perceptronOut_vinit_C_1_tr0, PROD_ACC_C_1_tr0, MAIN_LOOP_C_0_tr0,
      BIAS_ADD_C_4_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN perceptronOut_vinit_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000010");
        state_var_NS <= perceptronOut_vinit_C_1;
      WHEN perceptronOut_vinit_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000100");
        IF ( perceptronOut_vinit_C_1_tr0 = '1' ) THEN
          state_var_NS <= perceptronOut_vinit_C_0;
        ELSE
          state_var_NS <= main_C_0;
        END IF;
      WHEN main_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000001000");
        state_var_NS <= PROD_ACC_C_0;
      WHEN PROD_ACC_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000010000");
        state_var_NS <= PROD_ACC_C_1;
      WHEN PROD_ACC_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000100000");
        IF ( PROD_ACC_C_1_tr0 = '1' ) THEN
          state_var_NS <= MAIN_LOOP_C_0;
        ELSE
          state_var_NS <= PROD_ACC_C_0;
        END IF;
      WHEN MAIN_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001000000");
        IF ( MAIN_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= BIAS_ADD_C_0;
        ELSE
          state_var_NS <= PROD_ACC_C_0;
        END IF;
      WHEN BIAS_ADD_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010000000");
        state_var_NS <= BIAS_ADD_C_1;
      WHEN BIAS_ADD_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100000000");
        state_var_NS <= BIAS_ADD_C_2;
      WHEN BIAS_ADD_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000000000");
        state_var_NS <= BIAS_ADD_C_3;
      WHEN BIAS_ADD_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000000000");
        state_var_NS <= BIAS_ADD_C_4;
      WHEN BIAS_ADD_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000000000");
        IF ( BIAS_ADD_C_4_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= BIAS_ADD_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000000000");
        state_var_NS <= main_C_0;
      -- core_rlp_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000001");
        state_var_NS <= perceptronOut_vinit_C_0;
    END CASE;
  END PROCESS top_core_core_fsm_1;

  top_core_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= core_rlp_C_0;
      ELSE
        state_var <= state_var_NS;
      END IF;
    END IF;
  END PROCESS top_core_core_fsm_1_REG;

END v1;

-- ------------------------------------------------------------------
--  Design Unit:    top_core
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.singleport_ram_be_pkg.ALL;


ENTITY top_core IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    testOut_rsc_z : OUT STD_LOGIC;
    testOut_rsc_triosy_lz : OUT STD_LOGIC;
    errorInject_rsc_z : IN STD_LOGIC;
    errorInject_rsc_triosy_lz : OUT STD_LOGIC;
    perceptronOut_rsci_data_in_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    perceptronOut_rsci_addr_d : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    perceptronOut_rsci_re_d : OUT STD_LOGIC;
    perceptronOut_rsci_we_d : OUT STD_LOGIC;
    perceptronOut_rsci_data_out_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0)
  );
END top_core;

ARCHITECTURE v1 OF top_core IS
  -- Default Constants
  SIGNAL PWR : STD_LOGIC;
  SIGNAL GND : STD_LOGIC;

  -- Interconnect Declarations
  SIGNAL testOut_rsci_d : STD_LOGIC;
  SIGNAL errorInject_rsci_d : STD_LOGIC;
  SIGNAL PROD_ACC_read_rom_reshapeOutTest_rom_map_1_cmp_data_out : STD_LOGIC_VECTOR
      (5 DOWNTO 0);
  SIGNAL PROD_ACC_read_rom_perceptronFixedWeight_rom_map_1_cmp_data_out : STD_LOGIC_VECTOR
      (6 DOWNTO 0);
  SIGNAL fsm_output : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL and_dcpl_7 : STD_LOGIC;
  SIGNAL or_tmp_39 : STD_LOGIC;
  SIGNAL perceptronOut_vinit_ndx_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL MAIN_LOOP_pxNum_7_0_sva_4 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL PROD_ACC_i_3_0_sva_4 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL PROD_ACC_i_3_0_sva_5 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL BIAS_ADD_i_3_0_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL exit_BIAS_ADD_sva : STD_LOGIC;
  SIGNAL BIAS_ADD_dfr_sva : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL test_loop_i_3_0_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL exit_BIAS_ADD_sva_dfm : STD_LOGIC;
  SIGNAL exit_test_loop_sva_dfm : STD_LOGIC;
  SIGNAL perceptronOut_perceptronOut_nor_itm_1 : STD_LOGIC;
  SIGNAL perceptronOut_acc_itm_2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL PROD_ACC_mux_itm_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL PROD_ACC_asn_itm : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL PROD_ACC_slc_PROD_ACC_acc_3_itm_1 : STD_LOGIC;
  SIGNAL asn_itm_1 : STD_LOGIC;
  SIGNAL test_loop_if_mux_itm_1 : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL BIAS_ADD_mux_3_itm_1 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL BIAS_ADD_mux_8_itm_1 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL BIAS_ADD_acc_4_itm_1 : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL BIAS_ADD_and_seb : STD_LOGIC;
  SIGNAL and_46_cse : STD_LOGIC;
  SIGNAL BIAS_ADD_acc_3_psp_sva : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL PROD_ACC_slc_19_4_sat_sva : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL or_25_ssc : STD_LOGIC;
  SIGNAL test_loop_if_acc_psp_sva : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL reg_errorInject_rsc_triosy_obj_ld_cse : STD_LOGIC;
  SIGNAL or_34_cse : STD_LOGIC;
  SIGNAL BIAS_ADD_BIAS_ADD_and_rmff : STD_LOGIC;
  SIGNAL PROD_ACC_acc_7_psp : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL BIAS_ADD_nor_ovfl_sva_2 : STD_LOGIC;
  SIGNAL PROD_ACC_and_stg_1_1 : STD_LOGIC;
  SIGNAL PROD_ACC_and_stg_2_1 : STD_LOGIC;
  SIGNAL PROD_ACC_and_stg_1_0 : STD_LOGIC;
  SIGNAL PROD_ACC_and_stg_2_0 : STD_LOGIC;
  SIGNAL PROD_ACC_and_stg_1_3 : STD_LOGIC;
  SIGNAL PROD_ACC_and_stg_1_2 : STD_LOGIC;
  SIGNAL BIAS_ADD_and_stg_1_1 : STD_LOGIC;
  SIGNAL BIAS_ADD_and_stg_2_1 : STD_LOGIC;
  SIGNAL BIAS_ADD_and_stg_1_0 : STD_LOGIC;
  SIGNAL BIAS_ADD_and_stg_2_0 : STD_LOGIC;
  SIGNAL BIAS_ADD_and_stg_1_3 : STD_LOGIC;
  SIGNAL BIAS_ADD_and_stg_1_2 : STD_LOGIC;
  SIGNAL z_out_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL z_out_2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL testOut_rsci_d_mx0c1 : STD_LOGIC;
  SIGNAL PROD_ACC_nor_ovfl_sva : STD_LOGIC;
  SIGNAL PROD_ACC_and_unfl_sva : STD_LOGIC;
  SIGNAL MAIN_LOOP_pxNum_7_0_sva_1 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL test_loop_i_3_0_sva_1 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL PROD_ACC_mux_11_cse : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL reg_perceptron_v2_HW_perceptron_v2_HW_accReg_or_ssc : STD_LOGIC;
  SIGNAL reg_perceptron_v2_HW_accReg_tmp : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL reg_perceptron_v2_HW_accReg_tmp_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL reg_perceptron_v2_HW_accReg_tmp_2 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL reg_perceptron_v2_HW_accReg_tmp_3 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL reg_perceptron_v2_HW_accReg_tmp_4 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL reg_perceptron_v2_HW_accReg_tmp_5 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL reg_perceptron_v2_HW_accReg_tmp_6 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL reg_perceptron_v2_HW_accReg_tmp_7 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL reg_perceptron_v2_HW_accReg_tmp_8 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL reg_perceptron_v2_HW_accReg_tmp_9 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_46_rgt : STD_LOGIC;
  SIGNAL and_dcpl_27 : STD_LOGIC;
  SIGNAL or_dcpl_13 : STD_LOGIC;
  SIGNAL and_dcpl_33 : STD_LOGIC;
  SIGNAL or_dcpl_22 : STD_LOGIC;
  SIGNAL perceptron_v2_HW_accReg_and_mox_14 : STD_LOGIC;
  SIGNAL perceptron_v2_HW_accReg_and_mox_13_1 : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL perceptron_v2_HW_accReg_and_mox_0 : STD_LOGIC;
  SIGNAL z_out_3 : STD_LOGIC;

  SIGNAL not_nl : STD_LOGIC;
  SIGNAL test_loop_if_mux_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL BIAS_ADD_acc_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL BIAS_ADD_not_15_nl : STD_LOGIC;
  SIGNAL PROD_ACC_mul_1_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL BIAS_ADD_mux_10_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL test_loop_if_acc_1_nl : STD_LOGIC_VECTOR (16 DOWNTO 0);
  SIGNAL test_loop_oelse_acc_nl : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL BIAS_ADD_BIAS_ADD_and_2_nl : STD_LOGIC;
  SIGNAL BIAS_ADD_BIAS_ADD_BIAS_ADD_nor_1_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL BIAS_ADD_mux_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL BIAS_ADD_or_1_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL BIAS_ADD_nor_4_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL BIAS_ADD_BIAS_ADD_and_3_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL BIAS_ADD_BIAS_ADD_nor_2_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL BIAS_ADD_nor_5_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL BIAS_ADD_nor_6_nl : STD_LOGIC;
  SIGNAL nor_5_nl : STD_LOGIC;
  SIGNAL mux_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_73_nl : STD_LOGIC;
  SIGNAL nor_36_nl : STD_LOGIC;
  SIGNAL mux_3_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_75_nl : STD_LOGIC;
  SIGNAL nor_35_nl : STD_LOGIC;
  SIGNAL mux_4_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_77_nl : STD_LOGIC;
  SIGNAL nor_34_nl : STD_LOGIC;
  SIGNAL mux_5_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_79_nl : STD_LOGIC;
  SIGNAL nor_33_nl : STD_LOGIC;
  SIGNAL mux_6_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_81_nl : STD_LOGIC;
  SIGNAL nor_32_nl : STD_LOGIC;
  SIGNAL mux_7_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_83_nl : STD_LOGIC;
  SIGNAL nor_31_nl : STD_LOGIC;
  SIGNAL mux_8_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_85_nl : STD_LOGIC;
  SIGNAL nor_30_nl : STD_LOGIC;
  SIGNAL mux_9_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_87_nl : STD_LOGIC;
  SIGNAL nor_29_nl : STD_LOGIC;
  SIGNAL mux_10_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_89_nl : STD_LOGIC;
  SIGNAL nor_28_nl : STD_LOGIC;
  SIGNAL mux_11_nl : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL or_91_nl : STD_LOGIC;
  SIGNAL nor_27_nl : STD_LOGIC;
  SIGNAL PROD_ACC_PROD_ACC_nor_1_nl : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL PROD_ACC_nor_2_nl : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL PROD_ACC_acc_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL PROD_ACC_mux_24_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL testOut_rsci_d_1 : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL testOut_rsci_z : STD_LOGIC_VECTOR (0 DOWNTO 0);

  SIGNAL errorInject_rsci_d_1 : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL errorInject_rsci_z : STD_LOGIC_VECTOR (0 DOWNTO 0);

  COMPONENT mgc_rom_sync_regin
    GENERIC (
      rom_id : INTEGER;
      size : INTEGER;
      width : INTEGER;
      ph_clk : INTEGER;
      ph_en : INTEGER;
      ph_a_rst : INTEGER;
      ph_s_rst : INTEGER;
      num_input_registers : INTEGER;
      num_output_registers : INTEGER;
      a_rst_used : INTEGER;
      s_rst_used : INTEGER;
      en_used : INTEGER;
      no_of_ports : INTEGER
    );
    PORT(
      addr : IN STD_LOGIC_VECTOR(no_of_ports * bits(size) - 1 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(no_of_ports * width - 1 DOWNTO 0);
      clk : IN STD_LOGIC;
      s_rst : IN STD_LOGIC;
      a_rst : IN STD_LOGIC;
      en : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL PROD_ACC_read_rom_reshapeOutTest_rom_map_1_cmp_addr : STD_LOGIC_VECTOR (7
      DOWNTO 0);
  SIGNAL PROD_ACC_read_rom_reshapeOutTest_rom_map_1_cmp_data_out_1 : STD_LOGIC_VECTOR
      (5 DOWNTO 0);

  SIGNAL PROD_ACC_read_rom_perceptronFixedWeight_rom_map_1_cmp_addr : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL PROD_ACC_read_rom_perceptronFixedWeight_rom_map_1_cmp_data_out_1 : STD_LOGIC_VECTOR
      (6 DOWNTO 0);

  COMPONENT top_core_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
      perceptronOut_vinit_C_1_tr0 : IN STD_LOGIC;
      PROD_ACC_C_1_tr0 : IN STD_LOGIC;
      MAIN_LOOP_C_0_tr0 : IN STD_LOGIC;
      BIAS_ADD_C_4_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL top_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL top_core_core_fsm_inst_perceptronOut_vinit_C_1_tr0 : STD_LOGIC;
  SIGNAL top_core_core_fsm_inst_PROD_ACC_C_1_tr0 : STD_LOGIC;
  SIGNAL top_core_core_fsm_inst_MAIN_LOOP_C_0_tr0 : STD_LOGIC;

  FUNCTION MUX1HOT_v_4_4_2(input_3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(3 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(3 DOWNTO 0);

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

  FUNCTION MUX_v_11_10_2(input_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_7 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_8 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_9 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(10 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(10 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN "0000" =>
          result := input_0;
        WHEN "0001" =>
          result := input_1;
        WHEN "0010" =>
          result := input_2;
        WHEN "0011" =>
          result := input_3;
        WHEN "0100" =>
          result := input_4;
        WHEN "0101" =>
          result := input_5;
        WHEN "0110" =>
          result := input_6;
        WHEN "0111" =>
          result := input_7;
        WHEN "1000" =>
          result := input_8;
        WHEN others =>
          result := input_9;
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

  FUNCTION MUX_v_15_10_2(input_0 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_7 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_8 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  input_9 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(14 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(14 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN "0000" =>
          result := input_0;
        WHEN "0001" =>
          result := input_1;
        WHEN "0010" =>
          result := input_2;
        WHEN "0011" =>
          result := input_3;
        WHEN "0100" =>
          result := input_4;
        WHEN "0101" =>
          result := input_5;
        WHEN "0110" =>
          result := input_6;
        WHEN "0111" =>
          result := input_7;
        WHEN "1000" =>
          result := input_8;
        WHEN others =>
          result := input_9;
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

  FUNCTION MUX_v_3_2_2(input_0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(2 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(2 DOWNTO 0);

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

  FUNCTION MUX_v_8_10_2(input_0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_7 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_8 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_9 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(7 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN "0000" =>
          result := input_0;
        WHEN "0001" =>
          result := input_1;
        WHEN "0010" =>
          result := input_2;
        WHEN "0011" =>
          result := input_3;
        WHEN "0100" =>
          result := input_4;
        WHEN "0101" =>
          result := input_5;
        WHEN "0110" =>
          result := input_6;
        WHEN "0111" =>
          result := input_7;
        WHEN "1000" =>
          result := input_8;
        WHEN others =>
          result := input_9;
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

BEGIN
  -- Default Constant Signal Assignments
  PWR <= '1';
  GND <= '0';

  testOut_rsci : work.mgc_ioport_comps_v11.mgc_out_stdreg_v1
    GENERIC MAP(
      rscid => 1,
      width => 1
      )
    PORT MAP(
      d => testOut_rsci_d_1,
      z => testOut_rsci_z
    );
  testOut_rsci_d_1(0) <= testOut_rsci_d;
  testOut_rsc_z <= testOut_rsci_z(0);

  errorInject_rsci : work.mgc_ioport_comps_v11.mgc_in_wire_v1
    GENERIC MAP(
      rscid => 2,
      width => 1
      )
    PORT MAP(
      d => errorInject_rsci_d_1,
      z => errorInject_rsci_z
    );
  errorInject_rsci_d <= errorInject_rsci_d_1(0);
  errorInject_rsci_z(0) <= errorInject_rsc_z;

  testOut_rsc_triosy_obj : work.mgc_ioport_comps_v11.mgc_io_sync_v1
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_errorInject_rsc_triosy_obj_ld_cse,
      lz => testOut_rsc_triosy_lz
    );
  errorInject_rsc_triosy_obj : work.mgc_ioport_comps_v11.mgc_io_sync_v1
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_errorInject_rsc_triosy_obj_ld_cse,
      lz => errorInject_rsc_triosy_lz
    );
  PROD_ACC_read_rom_reshapeOutTest_rom_map_1_cmp : work.topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1_pkg.topmgc_rom_sync_regin_6_180_6_1_0_0_1_1_0_0_0_0_1
    GENERIC MAP(
      rom_id => 6,
      size => 180,
      width => 6,
      ph_clk => 1,
      ph_en => 0,
      ph_a_rst => 0,
      ph_s_rst => 1,
      num_input_registers => 1,
      num_output_registers => 0,
      a_rst_used => 0,
      s_rst_used => 0,
      en_used => 0,
      no_of_ports => 1
      )
    PORT MAP(
      addr => PROD_ACC_read_rom_reshapeOutTest_rom_map_1_cmp_addr,
      data_out => PROD_ACC_read_rom_reshapeOutTest_rom_map_1_cmp_data_out_1,
      clk => clk,
      s_rst => rst,
      a_rst => PWR,
      en => GND
    );
  PROD_ACC_read_rom_reshapeOutTest_rom_map_1_cmp_addr <= MUX_v_8_2_2(STD_LOGIC_VECTOR'("00000000"),
      (MUX_v_8_2_2(MAIN_LOOP_pxNum_7_0_sva_4, MAIN_LOOP_pxNum_7_0_sva_1, fsm_output(6))),
      (TO_STDLOGIC(fsm_output(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"))));
  PROD_ACC_read_rom_reshapeOutTest_rom_map_1_cmp_data_out <= PROD_ACC_read_rom_reshapeOutTest_rom_map_1_cmp_data_out_1;

  PROD_ACC_read_rom_perceptronFixedWeight_rom_map_1_cmp : work.topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1_pkg.topmgc_rom_sync_regin_7_1800_7_1_0_0_1_1_0_0_0_0_1
    GENERIC MAP(
      rom_id => 7,
      size => 1800,
      width => 7,
      ph_clk => 1,
      ph_en => 0,
      ph_a_rst => 0,
      ph_s_rst => 1,
      num_input_registers => 1,
      num_output_registers => 0,
      a_rst_used => 0,
      s_rst_used => 0,
      en_used => 0,
      no_of_ports => 1
      )
    PORT MAP(
      addr => PROD_ACC_read_rom_perceptronFixedWeight_rom_map_1_cmp_addr,
      data_out => PROD_ACC_read_rom_perceptronFixedWeight_rom_map_1_cmp_data_out_1,
      clk => clk,
      s_rst => rst,
      a_rst => PWR,
      en => GND
    );
  PROD_ACC_read_rom_perceptronFixedWeight_rom_map_1_cmp_addr <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(PROD_ACC_acc_7_psp(7
      DOWNTO 2)), 6), 8) + UNSIGNED(MAIN_LOOP_pxNum_7_0_sva_4), 8)) & (PROD_ACC_acc_7_psp(1
      DOWNTO 0)) & (PROD_ACC_i_3_0_sva_4(0));
  PROD_ACC_read_rom_perceptronFixedWeight_rom_map_1_cmp_data_out <= PROD_ACC_read_rom_perceptronFixedWeight_rom_map_1_cmp_data_out_1;

  top_core_core_fsm_inst : top_core_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      fsm_output => top_core_core_fsm_inst_fsm_output,
      perceptronOut_vinit_C_1_tr0 => top_core_core_fsm_inst_perceptronOut_vinit_C_1_tr0,
      PROD_ACC_C_1_tr0 => top_core_core_fsm_inst_PROD_ACC_C_1_tr0,
      MAIN_LOOP_C_0_tr0 => top_core_core_fsm_inst_MAIN_LOOP_C_0_tr0,
      BIAS_ADD_C_4_tr0 => and_dcpl_7
    );
  fsm_output <= top_core_core_fsm_inst_fsm_output;
  top_core_core_fsm_inst_perceptronOut_vinit_C_1_tr0 <= NOT perceptronOut_perceptronOut_nor_itm_1;
  top_core_core_fsm_inst_PROD_ACC_C_1_tr0 <= NOT PROD_ACC_slc_PROD_ACC_acc_3_itm_1;
  top_core_core_fsm_inst_MAIN_LOOP_C_0_tr0 <= NOT (readindex(STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(MAIN_LOOP_pxNum_7_0_sva_1(7
      DOWNTO 2)), 6), 7) + SIGNED'( "1010011"), 7)), 6));

  BIAS_ADD_BIAS_ADD_and_rmff <= BIAS_ADD_nor_ovfl_sva_2 AND (fsm_output(7));
  reg_perceptron_v2_HW_perceptron_v2_HW_accReg_or_ssc <= (fsm_output(2)) OR (fsm_output(5))
      OR and_46_cse;
  or_34_cse <= (fsm_output(3)) OR (fsm_output(6));
  or_46_rgt <= TO_STDLOGIC(fsm_output(9 DOWNTO 8)/=STD_LOGIC_VECTOR'("00"));
  BIAS_ADD_nor_ovfl_sva_2 <= NOT((BIAS_ADD_acc_3_psp_sva(13)) OR (NOT(TO_STDLOGIC(BIAS_ADD_acc_3_psp_sva(12
      DOWNTO 11)/=STD_LOGIC_VECTOR'("00")))));
  BIAS_ADD_and_seb <= (BIAS_ADD_acc_3_psp_sva(13)) AND (NOT(TO_STDLOGIC(BIAS_ADD_acc_3_psp_sva(12
      DOWNTO 11)=STD_LOGIC_VECTOR'("11"))));
  PROD_ACC_acc_7_psp <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(MAIN_LOOP_pxNum_7_0_sva_4)
      + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(PROD_ACC_i_3_0_sva_4(3 DOWNTO 1)), 3),
      8), 8));
  PROD_ACC_mul_1_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED(PROD_ACC_read_rom_perceptronFixedWeight_rom_map_1_cmp_data_out)
      * CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(PROD_ACC_asn_itm), 6), 7)), 12));
  PROD_ACC_slc_19_4_sat_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_SIGNED(SIGNED(PROD_ACC_mux_itm_1),
      15), 16) + CONV_UNSIGNED(CONV_SIGNED(SIGNED(readslice(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(PROD_ACC_mul_1_nl),
      12)), 4, 8)), 8), 16), 16));
  PROD_ACC_nor_ovfl_sva <= NOT(TO_STDLOGIC(PROD_ACC_slc_19_4_sat_sva(15 DOWNTO 14)/=STD_LOGIC_VECTOR'("01")));
  PROD_ACC_and_unfl_sva <= TO_STDLOGIC(PROD_ACC_slc_19_4_sat_sva(15 DOWNTO 14)=STD_LOGIC_VECTOR'("10"));
  MAIN_LOOP_pxNum_7_0_sva_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(MAIN_LOOP_pxNum_7_0_sva_4)
      + UNSIGNED'( "00000001"), 8));
  BIAS_ADD_mux_10_nl <= MUX_v_8_10_2(STD_LOGIC_VECTOR'( "00101011"), STD_LOGIC_VECTOR'(
      "11111110"), STD_LOGIC_VECTOR'( "00101010"), STD_LOGIC_VECTOR'( "01010001"),
      STD_LOGIC_VECTOR'( "00100000"), STD_LOGIC_VECTOR'( "01001001"), STD_LOGIC_VECTOR'(
      "00111000"), STD_LOGIC_VECTOR'( "00100001"), STD_LOGIC_VECTOR'( "00001111"),
      STD_LOGIC_VECTOR'( "00000101"), BIAS_ADD_i_3_0_sva);
  BIAS_ADD_acc_3_psp_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_SIGNED(SIGNED(z_out_1(14
      DOWNTO 2)), 13), 14) + CONV_UNSIGNED(SIGNED(BIAS_ADD_mux_10_nl), 14), 14));
  test_loop_i_3_0_sva_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(test_loop_i_3_0_sva)
      + UNSIGNED'( "0001"), 4));
  test_loop_if_acc_psp_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_SIGNED(SIGNED(perceptronOut_rsci_data_out_d(15
      DOWNTO 2)), 14), 15) - CONV_UNSIGNED(CONV_SIGNED(SIGNED(test_loop_if_mux_itm_1),
      11), 15), 15));
  and_dcpl_7 <= exit_BIAS_ADD_sva_dfm AND exit_test_loop_sva_dfm;
  and_46_cse <= (NOT exit_BIAS_ADD_sva) AND (fsm_output(7));
  or_tmp_39 <= TO_STDLOGIC(fsm_output(10 DOWNTO 8)/=STD_LOGIC_VECTOR'("000"));
  test_loop_if_acc_1_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(test_loop_if_acc_psp_sva
      & (perceptronOut_rsci_data_out_d(1 DOWNTO 0))) + SIGNED'( "00000000000011001"),
      17));
  test_loop_oelse_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED((NOT test_loop_if_acc_psp_sva)
      & (NOT (perceptronOut_rsci_data_out_d(1)))) + SIGNED'( "0000000000001101"),
      16));
  testOut_rsci_d_mx0c1 <= ((readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(test_loop_if_acc_1_nl),
      17)), 16)) OR (readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(test_loop_oelse_acc_nl),
      16)), 15))) AND (NOT (BIAS_ADD_dfr_sva(4))) AND (fsm_output(10));
  or_25_ssc <= NOT(TO_STDLOGIC(fsm_output(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("00")));
  BIAS_ADD_BIAS_ADD_and_2_nl <= (BIAS_ADD_acc_3_psp_sva(13)) AND (fsm_output(7));
  BIAS_ADD_nor_4_nl <= NOT(MUX_v_11_2_2((BIAS_ADD_acc_3_psp_sva(10 DOWNTO 0)), STD_LOGIC_VECTOR'("11111111111"),
      BIAS_ADD_nor_ovfl_sva_2));
  BIAS_ADD_or_1_nl <= MUX_v_11_2_2(BIAS_ADD_nor_4_nl, STD_LOGIC_VECTOR'("11111111111"),
      BIAS_ADD_and_seb);
  BIAS_ADD_mux_nl <= MUX_v_11_2_2(BIAS_ADD_or_1_nl, STD_LOGIC_VECTOR'( "11111011111"),
      fsm_output(8));
  BIAS_ADD_BIAS_ADD_BIAS_ADD_nor_1_nl <= NOT(MUX_v_11_2_2(BIAS_ADD_mux_nl, STD_LOGIC_VECTOR'("11111111111"),
      or_25_ssc));
  BIAS_ADD_nor_5_nl <= NOT(MUX_v_2_2_2((z_out_1(1 DOWNTO 0)), STD_LOGIC_VECTOR'("11"),
      BIAS_ADD_nor_ovfl_sva_2));
  BIAS_ADD_BIAS_ADD_nor_2_nl <= NOT(MUX_v_2_2_2(BIAS_ADD_nor_5_nl, STD_LOGIC_VECTOR'("11"),
      BIAS_ADD_and_seb));
  BIAS_ADD_nor_6_nl <= NOT(or_25_ssc OR (fsm_output(8)));
  BIAS_ADD_BIAS_ADD_and_3_nl <= MUX_v_2_2_2(STD_LOGIC_VECTOR'("00"), BIAS_ADD_BIAS_ADD_nor_2_nl,
      BIAS_ADD_nor_6_nl);
  perceptronOut_rsci_data_in_d <= BIAS_ADD_BIAS_ADD_and_2_nl & BIAS_ADD_BIAS_ADD_BIAS_ADD_nor_1_nl
      & BIAS_ADD_BIAS_ADD_and_3_nl & BIAS_ADD_BIAS_ADD_and_rmff & BIAS_ADD_BIAS_ADD_and_rmff;
  nor_5_nl <= NOT((fsm_output(1)) OR (fsm_output(7)) OR (fsm_output(9)));
  perceptronOut_rsci_addr_d <= MUX1HOT_v_4_4_2(perceptronOut_vinit_ndx_sva, BIAS_ADD_i_3_0_sva,
      STD_LOGIC_VECTOR'( "0011"), test_loop_i_3_0_sva, STD_LOGIC_VECTOR'( (fsm_output(1))
      & (fsm_output(7)) & nor_5_nl & (fsm_output(9))));
  perceptronOut_rsci_re_d <= NOT((NOT (BIAS_ADD_dfr_sva(4))) AND (fsm_output(9)));
  perceptronOut_rsci_we_d <= NOT(and_46_cse OR (fsm_output(1)) OR (TO_STDLOGIC(BIAS_ADD_dfr_sva=STD_LOGIC_VECTOR'("00000"))
      AND asn_itm_1 AND (fsm_output(8))));
  PROD_ACC_and_stg_1_1 <= TO_STDLOGIC(PROD_ACC_i_3_0_sva_4(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01"));
  PROD_ACC_and_stg_2_1 <= PROD_ACC_and_stg_1_1 AND (NOT (PROD_ACC_i_3_0_sva_4(2)));
  PROD_ACC_and_stg_1_0 <= NOT(TO_STDLOGIC(PROD_ACC_i_3_0_sva_4(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  PROD_ACC_and_stg_2_0 <= PROD_ACC_and_stg_1_0 AND (NOT (PROD_ACC_i_3_0_sva_4(2)));
  PROD_ACC_and_stg_1_3 <= TO_STDLOGIC(PROD_ACC_i_3_0_sva_4(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  PROD_ACC_and_stg_1_2 <= TO_STDLOGIC(PROD_ACC_i_3_0_sva_4(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"));
  BIAS_ADD_and_stg_1_1 <= TO_STDLOGIC(BIAS_ADD_i_3_0_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01"));
  BIAS_ADD_and_stg_2_1 <= BIAS_ADD_and_stg_1_1 AND (NOT (BIAS_ADD_i_3_0_sva(2)));
  BIAS_ADD_and_stg_1_0 <= NOT(TO_STDLOGIC(BIAS_ADD_i_3_0_sva(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  BIAS_ADD_and_stg_2_0 <= BIAS_ADD_and_stg_1_0 AND (NOT (BIAS_ADD_i_3_0_sva(2)));
  BIAS_ADD_and_stg_1_3 <= TO_STDLOGIC(BIAS_ADD_i_3_0_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"));
  BIAS_ADD_and_stg_1_2 <= TO_STDLOGIC(BIAS_ADD_i_3_0_sva(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"));
  PROD_ACC_mux_11_cse <= MUX_v_4_2_2(PROD_ACC_i_3_0_sva_4, BIAS_ADD_i_3_0_sva, fsm_output(7));
  and_dcpl_27 <= and_46_cse AND (BIAS_ADD_i_3_0_sva(3));
  or_dcpl_13 <= TO_STDLOGIC(BIAS_ADD_i_3_0_sva(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("01"));
  and_dcpl_33 <= and_46_cse AND (NOT (BIAS_ADD_i_3_0_sva(3)));
  or_dcpl_22 <= TO_STDLOGIC(BIAS_ADD_i_3_0_sva(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00"));
  perceptron_v2_HW_accReg_and_mox_14 <= (PROD_ACC_slc_19_4_sat_sva(15)) OR and_46_cse;
  PROD_ACC_nor_2_nl <= NOT(MUX_v_13_2_2((PROD_ACC_slc_19_4_sat_sva(13 DOWNTO 1)),
      STD_LOGIC_VECTOR'("1111111111111"), PROD_ACC_nor_ovfl_sva));
  PROD_ACC_PROD_ACC_nor_1_nl <= NOT(MUX_v_13_2_2(PROD_ACC_nor_2_nl, STD_LOGIC_VECTOR'("1111111111111"),
      PROD_ACC_and_unfl_sva));
  perceptron_v2_HW_accReg_and_mox_13_1 <= MUX_v_13_2_2(PROD_ACC_PROD_ACC_nor_1_nl,
      STD_LOGIC_VECTOR'("1111111111111"), and_46_cse);
  perceptron_v2_HW_accReg_and_mox_0 <= (NOT((NOT((PROD_ACC_slc_19_4_sat_sva(0)) OR
      PROD_ACC_nor_ovfl_sva)) OR PROD_ACC_and_unfl_sva)) OR and_46_cse;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_errorInject_rsc_triosy_obj_ld_cse <= '0';
        perceptronOut_perceptronOut_nor_itm_1 <= '0';
        perceptronOut_acc_itm_2 <= STD_LOGIC_VECTOR'( "0000");
        PROD_ACC_slc_PROD_ACC_acc_3_itm_1 <= '0';
        PROD_ACC_mux_itm_1 <= STD_LOGIC_VECTOR'( "000000000000000");
        PROD_ACC_asn_itm <= STD_LOGIC_VECTOR'( "000000");
        PROD_ACC_i_3_0_sva_5 <= STD_LOGIC_VECTOR'( "0000");
        BIAS_ADD_i_3_0_sva <= STD_LOGIC_VECTOR'( "0000");
        test_loop_i_3_0_sva <= STD_LOGIC_VECTOR'( "0000");
        exit_BIAS_ADD_sva <= '0';
        asn_itm_1 <= '0';
      ELSE
        reg_errorInject_rsc_triosy_obj_ld_cse <= and_dcpl_7 AND (fsm_output(11));
        perceptronOut_perceptronOut_nor_itm_1 <= NOT(TO_STDLOGIC(perceptronOut_vinit_ndx_sva/=STD_LOGIC_VECTOR'("0000")));
        perceptronOut_acc_itm_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(perceptronOut_vinit_ndx_sva)
            + UNSIGNED'( "1111"), 4));
        PROD_ACC_slc_PROD_ACC_acc_3_itm_1 <= z_out_3;
        PROD_ACC_mux_itm_1 <= z_out_1;
        PROD_ACC_asn_itm <= PROD_ACC_read_rom_reshapeOutTest_rom_map_1_cmp_data_out;
        PROD_ACC_i_3_0_sva_5 <= z_out_2;
        BIAS_ADD_i_3_0_sva <= MUX_v_4_2_2(STD_LOGIC_VECTOR'("0000"), BIAS_ADD_mux_3_itm_1,
            (fsm_output(11)));
        test_loop_i_3_0_sva <= MUX_v_4_2_2(test_loop_i_3_0_sva, BIAS_ADD_mux_8_itm_1,
            fsm_output(11));
        exit_BIAS_ADD_sva <= exit_BIAS_ADD_sva_dfm AND (fsm_output(11));
        asn_itm_1 <= errorInject_rsci_d;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        testOut_rsci_d <= '0';
      ELSIF ( ((perceptronOut_perceptronOut_nor_itm_1 AND (fsm_output(2))) OR (fsm_output(12))
          OR testOut_rsci_d_mx0c1) = '1' ) THEN
        testOut_rsci_d <= NOT testOut_rsci_d_mx0c1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        perceptronOut_vinit_ndx_sva <= STD_LOGIC_VECTOR'( "1001");
      ELSIF ( (fsm_output(2)) = '1' ) THEN
        perceptronOut_vinit_ndx_sva <= perceptronOut_acc_itm_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        MAIN_LOOP_pxNum_7_0_sva_4 <= STD_LOGIC_VECTOR'( "00000000");
      ELSIF ( or_34_cse = '1' ) THEN
        MAIN_LOOP_pxNum_7_0_sva_4 <= MUX_v_8_2_2(STD_LOGIC_VECTOR'("00000000"), MAIN_LOOP_pxNum_7_0_sva_1,
            (fsm_output(6)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        PROD_ACC_i_3_0_sva_4 <= STD_LOGIC_VECTOR'( "0000");
      ELSIF ( ((fsm_output(5)) OR or_34_cse) = '1' ) THEN
        PROD_ACC_i_3_0_sva_4 <= MUX_v_4_2_2(STD_LOGIC_VECTOR'("0000"), PROD_ACC_i_3_0_sva_5,
            not_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        BIAS_ADD_dfr_sva <= STD_LOGIC_VECTOR'( "00000");
      ELSIF ( ((fsm_output(6)) OR (fsm_output(11))) = '1' ) THEN
        BIAS_ADD_dfr_sva <= MUX_v_5_2_2(STD_LOGIC_VECTOR'( "11101"), BIAS_ADD_acc_4_itm_1,
            fsm_output(11));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        test_loop_if_mux_itm_1 <= STD_LOGIC_VECTOR'( "00000000000");
      ELSIF ( or_46_rgt = '0' ) THEN
        test_loop_if_mux_itm_1 <= test_loop_if_mux_nl;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        exit_BIAS_ADD_sva_dfm <= '0';
      ELSIF ( (fsm_output(7)) = '1' ) THEN
        exit_BIAS_ADD_sva_dfm <= (NOT (readindex(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(BIAS_ADD_acc_nl),
            4)), 3))) OR exit_BIAS_ADD_sva;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        exit_test_loop_sva_dfm <= '0';
      ELSIF ( (fsm_output(7)) = '1' ) THEN
        exit_test_loop_sva_dfm <= NOT(z_out_3 OR (BIAS_ADD_dfr_sva(4)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        BIAS_ADD_acc_4_itm_1 <= STD_LOGIC_VECTOR'( "00000");
      ELSIF ( or_tmp_39 = '0' ) THEN
        BIAS_ADD_acc_4_itm_1 <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(BIAS_ADD_dfr_sva)
            + SIGNED'( "00001"), 5));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        BIAS_ADD_mux_8_itm_1 <= STD_LOGIC_VECTOR'( "0000");
      ELSIF ( or_tmp_39 = '0' ) THEN
        BIAS_ADD_mux_8_itm_1 <= MUX_v_4_2_2(STD_LOGIC_VECTOR'("0000"), test_loop_i_3_0_sva_1,
            BIAS_ADD_not_15_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        BIAS_ADD_mux_3_itm_1 <= STD_LOGIC_VECTOR'( "0000");
      ELSIF ( or_tmp_39 = '0' ) THEN
        BIAS_ADD_mux_3_itm_1 <= z_out_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_perceptron_v2_HW_accReg_tmp <= STD_LOGIC_VECTOR'( "000000000000000");
        reg_perceptron_v2_HW_accReg_tmp_1 <= STD_LOGIC_VECTOR'( "000000000000000");
        reg_perceptron_v2_HW_accReg_tmp_2 <= STD_LOGIC_VECTOR'( "000000000000000");
        reg_perceptron_v2_HW_accReg_tmp_3 <= STD_LOGIC_VECTOR'( "000000000000000");
        reg_perceptron_v2_HW_accReg_tmp_4 <= STD_LOGIC_VECTOR'( "000000000000000");
        reg_perceptron_v2_HW_accReg_tmp_5 <= STD_LOGIC_VECTOR'( "000000000000000");
        reg_perceptron_v2_HW_accReg_tmp_6 <= STD_LOGIC_VECTOR'( "000000000000000");
        reg_perceptron_v2_HW_accReg_tmp_7 <= STD_LOGIC_VECTOR'( "000000000000000");
        reg_perceptron_v2_HW_accReg_tmp_8 <= STD_LOGIC_VECTOR'( "000000000000000");
        reg_perceptron_v2_HW_accReg_tmp_9 <= STD_LOGIC_VECTOR'( "000000000000000");
      ELSIF ( reg_perceptron_v2_HW_perceptron_v2_HW_accReg_or_ssc = '1' ) THEN
        reg_perceptron_v2_HW_accReg_tmp <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
            mux_nl, nor_36_nl);
        reg_perceptron_v2_HW_accReg_tmp_1 <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
            mux_3_nl, nor_35_nl);
        reg_perceptron_v2_HW_accReg_tmp_2 <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
            mux_4_nl, nor_34_nl);
        reg_perceptron_v2_HW_accReg_tmp_3 <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
            mux_5_nl, nor_33_nl);
        reg_perceptron_v2_HW_accReg_tmp_4 <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
            mux_6_nl, nor_32_nl);
        reg_perceptron_v2_HW_accReg_tmp_5 <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
            mux_7_nl, nor_31_nl);
        reg_perceptron_v2_HW_accReg_tmp_6 <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
            mux_8_nl, nor_30_nl);
        reg_perceptron_v2_HW_accReg_tmp_7 <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
            mux_9_nl, nor_29_nl);
        reg_perceptron_v2_HW_accReg_tmp_8 <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
            mux_10_nl, nor_28_nl);
        reg_perceptron_v2_HW_accReg_tmp_9 <= MUX_v_15_2_2(STD_LOGIC_VECTOR'("000000000000000"),
            mux_11_nl, nor_27_nl);
      END IF;
    END IF;
  END PROCESS;
  not_nl <= NOT or_34_cse;
  test_loop_if_mux_nl <= MUX_v_11_10_2(STD_LOGIC_VECTOR'( "11111101110"), STD_LOGIC_VECTOR'(
      "11110110111"), STD_LOGIC_VECTOR'( "00111011001"), STD_LOGIC_VECTOR'( "01000001011"),
      STD_LOGIC_VECTOR'( "00110010100"), STD_LOGIC_VECTOR'( "00110000111"), STD_LOGIC_VECTOR'(
      "01010010000"), STD_LOGIC_VECTOR'( "00001110110"), STD_LOGIC_VECTOR'( "11110010000"),
      STD_LOGIC_VECTOR'( "11110111110"), test_loop_i_3_0_sva);
  BIAS_ADD_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(z_out_2(3
      DOWNTO 1)), 3), 4) + SIGNED'( "1011"), 4));
  BIAS_ADD_not_15_nl <= NOT (BIAS_ADD_dfr_sva(4));
  or_73_nl <= ((NOT((BIAS_ADD_i_3_0_sva(3)) AND BIAS_ADD_and_stg_2_1)) AND and_46_cse)
      OR ((NOT(PROD_ACC_and_stg_2_1 AND (PROD_ACC_i_3_0_sva_4(3)))) AND (fsm_output(5)));
  mux_nl <= MUX_v_15_2_2((perceptron_v2_HW_accReg_and_mox_14 & perceptron_v2_HW_accReg_and_mox_13_1
      & perceptron_v2_HW_accReg_and_mox_0), reg_perceptron_v2_HW_accReg_tmp, or_73_nl);
  nor_36_nl <= NOT((and_dcpl_27 AND BIAS_ADD_and_stg_2_1) OR (fsm_output(2)));
  or_75_nl <= ((NOT((BIAS_ADD_i_3_0_sva(3)) AND BIAS_ADD_and_stg_2_0)) AND and_46_cse)
      OR ((NOT(PROD_ACC_and_stg_2_0 AND (PROD_ACC_i_3_0_sva_4(3)))) AND (fsm_output(5)));
  mux_3_nl <= MUX_v_15_2_2((perceptron_v2_HW_accReg_and_mox_14 & perceptron_v2_HW_accReg_and_mox_13_1
      & perceptron_v2_HW_accReg_and_mox_0), reg_perceptron_v2_HW_accReg_tmp_1, or_75_nl);
  nor_35_nl <= NOT((and_dcpl_27 AND BIAS_ADD_and_stg_2_0) OR (fsm_output(2)));
  or_77_nl <= ((or_dcpl_13 OR (NOT BIAS_ADD_and_stg_1_3)) AND and_46_cse) OR ((NOT(PROD_ACC_and_stg_1_3
      AND TO_STDLOGIC(PROD_ACC_i_3_0_sva_4(3 DOWNTO 2)=STD_LOGIC_VECTOR'("01"))))
      AND (fsm_output(5)));
  mux_4_nl <= MUX_v_15_2_2((perceptron_v2_HW_accReg_and_mox_14 & perceptron_v2_HW_accReg_and_mox_13_1
      & perceptron_v2_HW_accReg_and_mox_0), reg_perceptron_v2_HW_accReg_tmp_2, or_77_nl);
  nor_34_nl <= NOT((and_dcpl_33 AND (BIAS_ADD_i_3_0_sva(2)) AND BIAS_ADD_and_stg_1_3)
      OR (fsm_output(2)));
  or_79_nl <= ((or_dcpl_13 OR (NOT BIAS_ADD_and_stg_1_2)) AND and_46_cse) OR ((NOT(PROD_ACC_and_stg_1_2
      AND TO_STDLOGIC(PROD_ACC_i_3_0_sva_4(3 DOWNTO 2)=STD_LOGIC_VECTOR'("01"))))
      AND (fsm_output(5)));
  mux_5_nl <= MUX_v_15_2_2((perceptron_v2_HW_accReg_and_mox_14 & perceptron_v2_HW_accReg_and_mox_13_1
      & perceptron_v2_HW_accReg_and_mox_0), reg_perceptron_v2_HW_accReg_tmp_3, or_79_nl);
  nor_33_nl <= NOT((and_dcpl_33 AND (BIAS_ADD_i_3_0_sva(2)) AND BIAS_ADD_and_stg_1_2)
      OR (fsm_output(2)));
  or_81_nl <= ((or_dcpl_13 OR (NOT BIAS_ADD_and_stg_1_1)) AND and_46_cse) OR ((NOT(PROD_ACC_and_stg_1_1
      AND TO_STDLOGIC(PROD_ACC_i_3_0_sva_4(3 DOWNTO 2)=STD_LOGIC_VECTOR'("01"))))
      AND (fsm_output(5)));
  mux_6_nl <= MUX_v_15_2_2((perceptron_v2_HW_accReg_and_mox_14 & perceptron_v2_HW_accReg_and_mox_13_1
      & perceptron_v2_HW_accReg_and_mox_0), reg_perceptron_v2_HW_accReg_tmp_4, or_81_nl);
  nor_32_nl <= NOT((and_dcpl_33 AND (BIAS_ADD_i_3_0_sva(2)) AND BIAS_ADD_and_stg_1_1)
      OR (fsm_output(2)));
  or_83_nl <= ((or_dcpl_13 OR (NOT BIAS_ADD_and_stg_1_0)) AND and_46_cse) OR ((NOT(PROD_ACC_and_stg_1_0
      AND TO_STDLOGIC(PROD_ACC_i_3_0_sva_4(3 DOWNTO 2)=STD_LOGIC_VECTOR'("01"))))
      AND (fsm_output(5)));
  mux_7_nl <= MUX_v_15_2_2((perceptron_v2_HW_accReg_and_mox_14 & perceptron_v2_HW_accReg_and_mox_13_1
      & perceptron_v2_HW_accReg_and_mox_0), reg_perceptron_v2_HW_accReg_tmp_5, or_83_nl);
  nor_31_nl <= NOT((and_dcpl_33 AND (BIAS_ADD_i_3_0_sva(2)) AND BIAS_ADD_and_stg_1_0)
      OR (fsm_output(2)));
  or_85_nl <= ((or_dcpl_22 OR (NOT BIAS_ADD_and_stg_1_3)) AND and_46_cse) OR ((NOT(PROD_ACC_and_stg_1_3
      AND TO_STDLOGIC(PROD_ACC_i_3_0_sva_4(3 DOWNTO 2)=STD_LOGIC_VECTOR'("00"))))
      AND (fsm_output(5)));
  mux_8_nl <= MUX_v_15_2_2((perceptron_v2_HW_accReg_and_mox_14 & perceptron_v2_HW_accReg_and_mox_13_1
      & perceptron_v2_HW_accReg_and_mox_0), reg_perceptron_v2_HW_accReg_tmp_6, or_85_nl);
  nor_30_nl <= NOT((and_dcpl_33 AND (NOT (BIAS_ADD_i_3_0_sva(2))) AND BIAS_ADD_and_stg_1_3)
      OR (fsm_output(2)));
  or_87_nl <= ((or_dcpl_22 OR (NOT BIAS_ADD_and_stg_1_2)) AND and_46_cse) OR ((NOT(PROD_ACC_and_stg_1_2
      AND TO_STDLOGIC(PROD_ACC_i_3_0_sva_4(3 DOWNTO 2)=STD_LOGIC_VECTOR'("00"))))
      AND (fsm_output(5)));
  mux_9_nl <= MUX_v_15_2_2((perceptron_v2_HW_accReg_and_mox_14 & perceptron_v2_HW_accReg_and_mox_13_1
      & perceptron_v2_HW_accReg_and_mox_0), reg_perceptron_v2_HW_accReg_tmp_7, or_87_nl);
  nor_29_nl <= NOT((and_dcpl_33 AND (NOT (BIAS_ADD_i_3_0_sva(2))) AND BIAS_ADD_and_stg_1_2)
      OR (fsm_output(2)));
  or_89_nl <= (((BIAS_ADD_i_3_0_sva(3)) OR (NOT BIAS_ADD_and_stg_2_1)) AND and_46_cse)
      OR ((NOT(PROD_ACC_and_stg_2_1 AND (NOT (PROD_ACC_i_3_0_sva_4(3))))) AND (fsm_output(5)));
  mux_10_nl <= MUX_v_15_2_2((perceptron_v2_HW_accReg_and_mox_14 & perceptron_v2_HW_accReg_and_mox_13_1
      & perceptron_v2_HW_accReg_and_mox_0), reg_perceptron_v2_HW_accReg_tmp_8, or_89_nl);
  nor_28_nl <= NOT((and_dcpl_33 AND BIAS_ADD_and_stg_2_1) OR (fsm_output(2)));
  or_91_nl <= (((BIAS_ADD_i_3_0_sva(3)) OR (NOT BIAS_ADD_and_stg_2_0)) AND and_46_cse)
      OR ((NOT(PROD_ACC_and_stg_2_0 AND (NOT (PROD_ACC_i_3_0_sva_4(3))))) AND (fsm_output(5)));
  mux_11_nl <= MUX_v_15_2_2((perceptron_v2_HW_accReg_and_mox_14 & perceptron_v2_HW_accReg_and_mox_13_1
      & perceptron_v2_HW_accReg_and_mox_0), reg_perceptron_v2_HW_accReg_tmp_9, or_91_nl);
  nor_27_nl <= NOT((and_dcpl_33 AND BIAS_ADD_and_stg_2_0) OR (fsm_output(2)));
  PROD_ACC_mux_24_nl <= MUX_v_3_2_2((z_out_2(3 DOWNTO 1)), (test_loop_i_3_0_sva_1(3
      DOWNTO 1)), fsm_output(7));
  PROD_ACC_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(PROD_ACC_mux_24_nl),
      4) + UNSIGNED'( "1011"), 4));
  z_out_3 <= readindex(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(PROD_ACC_acc_nl),
      4)), 3);
  z_out_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(PROD_ACC_mux_11_cse) + UNSIGNED'(
      "0001"), 4));
  z_out_1 <= MUX_v_15_10_2(reg_perceptron_v2_HW_accReg_tmp_9, reg_perceptron_v2_HW_accReg_tmp_8,
      reg_perceptron_v2_HW_accReg_tmp_7, reg_perceptron_v2_HW_accReg_tmp_6, reg_perceptron_v2_HW_accReg_tmp_5,
      reg_perceptron_v2_HW_accReg_tmp_4, reg_perceptron_v2_HW_accReg_tmp_3, reg_perceptron_v2_HW_accReg_tmp_2,
      reg_perceptron_v2_HW_accReg_tmp_1, reg_perceptron_v2_HW_accReg_tmp, PROD_ACC_mux_11_cse);
END v1;

-- ------------------------------------------------------------------
--  Design Unit:    top
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.funcs.ALL;
USE work.mgc_ioport_comps_v11.ALL;
USE work.singleport_ram_be_pkg.ALL;


ENTITY top IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    testOut_rsc_z : OUT STD_LOGIC;
    testOut_rsc_triosy_lz : OUT STD_LOGIC;
    errorInject_rsc_z : IN STD_LOGIC;
    errorInject_rsc_triosy_lz : OUT STD_LOGIC
  );
END top;

ARCHITECTURE v1 OF top IS
  -- Default Constants
  SIGNAL PWR : STD_LOGIC;
  SIGNAL GND : STD_LOGIC;

  -- Interconnect Declarations
  SIGNAL perceptronOut_rsci_data_in_d : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL perceptronOut_rsci_addr_d : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL perceptronOut_rsci_re_d : STD_LOGIC;
  SIGNAL perceptronOut_rsci_we_d : STD_LOGIC;
  SIGNAL perceptronOut_rsci_data_out_d : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL perceptronOut_rsc_en : STD_LOGIC;
  SIGNAL perceptronOut_rsc_data_out : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL perceptronOut_rsc_we : STD_LOGIC;
  SIGNAL perceptronOut_rsc_re : STD_LOGIC;
  SIGNAL perceptronOut_rsc_addr : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL perceptronOut_rsc_data_in : STD_LOGIC_VECTOR (15 DOWNTO 0);

  SIGNAL perceptronOut_rsc_comp_data_in : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL perceptronOut_rsc_comp_addr : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL perceptronOut_rsc_comp_re : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL perceptronOut_rsc_comp_we : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL perceptronOut_rsc_comp_data_out : STD_LOGIC_VECTOR (15 DOWNTO 0);

  COMPONENT ram_Xilinx_ARTIX_7_1_RAMSB_singleport_rwport_en_3_10_16_4_0_1_0_0_0_1_1_1_0_10_16_1_gen
    PORT(
      en : OUT STD_LOGIC;
      data_out : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      we : OUT STD_LOGIC;
      re : OUT STD_LOGIC;
      addr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      data_in : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
      data_in_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      addr_d : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      re_d : IN STD_LOGIC;
      we_d : IN STD_LOGIC;
      data_out_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
      en_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL perceptronOut_rsci_data_out : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL perceptronOut_rsci_addr : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL perceptronOut_rsci_data_in : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL perceptronOut_rsci_data_in_d_1 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL perceptronOut_rsci_addr_d_1 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL perceptronOut_rsci_data_out_d_1 : STD_LOGIC_VECTOR (15 DOWNTO 0);

  COMPONENT top_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      testOut_rsc_z : OUT STD_LOGIC;
      testOut_rsc_triosy_lz : OUT STD_LOGIC;
      errorInject_rsc_z : IN STD_LOGIC;
      errorInject_rsc_triosy_lz : OUT STD_LOGIC;
      perceptronOut_rsci_data_in_d : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
      perceptronOut_rsci_addr_d : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      perceptronOut_rsci_re_d : OUT STD_LOGIC;
      perceptronOut_rsci_we_d : OUT STD_LOGIC;
      perceptronOut_rsci_data_out_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL top_core_inst_perceptronOut_rsci_data_in_d : STD_LOGIC_VECTOR (15 DOWNTO
      0);
  SIGNAL top_core_inst_perceptronOut_rsci_addr_d : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL top_core_inst_perceptronOut_rsci_data_out_d : STD_LOGIC_VECTOR (15 DOWNTO
      0);

BEGIN
  -- Default Constant Signal Assignments
  PWR <= '1';
  GND <= '0';

  perceptronOut_rsc_comp : work.singleport_ram_be_pkg.singleport_ram_be
    GENERIC MAP(
      ram_id => 3,
      words => 10,
      width => 16,
      addr_width => 4,
      a_reset_active => 0,
      s_reset_active => 1,
      enable_active => 0,
      re_active => 0,
      we_active => 0,
      num_byte_enables => 1,
      clock_edge => 1,
      num_input_registers => 1,
      num_output_registers => 0,
      no_of_singleport_readwrite_port => 1
      )
    PORT MAP(
      data_in => perceptronOut_rsc_comp_data_in,
      addr => perceptronOut_rsc_comp_addr,
      re => perceptronOut_rsc_comp_re,
      we => perceptronOut_rsc_comp_we,
      data_out => perceptronOut_rsc_comp_data_out,
      clk => clk,
      a_rst => PWR,
      s_rst => rst,
      en => perceptronOut_rsc_en
    );
  perceptronOut_rsc_comp_data_in <= perceptronOut_rsc_data_in;
  perceptronOut_rsc_comp_addr <= perceptronOut_rsc_addr;
  perceptronOut_rsc_comp_re(0) <= perceptronOut_rsc_re;
  perceptronOut_rsc_comp_we(0) <= perceptronOut_rsc_we;
  perceptronOut_rsc_data_out <= perceptronOut_rsc_comp_data_out;

  perceptronOut_rsci : ram_Xilinx_ARTIX_7_1_RAMSB_singleport_rwport_en_3_10_16_4_0_1_0_0_0_1_1_1_0_10_16_1_gen
    PORT MAP(
      en => perceptronOut_rsc_en,
      data_out => perceptronOut_rsci_data_out,
      we => perceptronOut_rsc_we,
      re => perceptronOut_rsc_re,
      addr => perceptronOut_rsci_addr,
      data_in => perceptronOut_rsci_data_in,
      data_in_d => perceptronOut_rsci_data_in_d_1,
      addr_d => perceptronOut_rsci_addr_d_1,
      re_d => perceptronOut_rsci_re_d,
      we_d => perceptronOut_rsci_we_d,
      data_out_d => perceptronOut_rsci_data_out_d_1,
      en_d => GND
    );
  perceptronOut_rsci_data_out <= perceptronOut_rsc_data_out;
  perceptronOut_rsc_addr <= perceptronOut_rsci_addr;
  perceptronOut_rsc_data_in <= perceptronOut_rsci_data_in;
  perceptronOut_rsci_data_in_d_1 <= perceptronOut_rsci_data_in_d;
  perceptronOut_rsci_addr_d_1 <= perceptronOut_rsci_addr_d;
  perceptronOut_rsci_data_out_d <= perceptronOut_rsci_data_out_d_1;

  top_core_inst : top_core
    PORT MAP(
      clk => clk,
      rst => rst,
      testOut_rsc_z => testOut_rsc_z,
      testOut_rsc_triosy_lz => testOut_rsc_triosy_lz,
      errorInject_rsc_z => errorInject_rsc_z,
      errorInject_rsc_triosy_lz => errorInject_rsc_triosy_lz,
      perceptronOut_rsci_data_in_d => top_core_inst_perceptronOut_rsci_data_in_d,
      perceptronOut_rsci_addr_d => top_core_inst_perceptronOut_rsci_addr_d,
      perceptronOut_rsci_re_d => perceptronOut_rsci_re_d,
      perceptronOut_rsci_we_d => perceptronOut_rsci_we_d,
      perceptronOut_rsci_data_out_d => top_core_inst_perceptronOut_rsci_data_out_d
    );
  perceptronOut_rsci_data_in_d <= top_core_inst_perceptronOut_rsci_data_in_d;
  perceptronOut_rsci_addr_d <= top_core_inst_perceptronOut_rsci_addr_d;
  top_core_inst_perceptronOut_rsci_data_out_d <= perceptronOut_rsci_data_out_d;

END v1;



