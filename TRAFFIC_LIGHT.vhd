----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:53:51 05/17/2021 
-- Design Name: 
-- Module Name:    TRAFFIC_LIGHT - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TRAFFIC_LIGHT is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           NTIMER0 : out  STD_LOGIC_VECTOR (3 downto 0);
			  NTIMER1 : out  STD_LOGIC_VECTOR (3 downto 0);
           NR : out  STD_LOGIC;
           NY : out  STD_LOGIC;
           NG : out  STD_LOGIC;
			  ETIMER0 : out  STD_LOGIC_VECTOR (3 downto 0);
			  ETIMER1 : out  STD_LOGIC_VECTOR (3 downto 0);
           ER : out  STD_LOGIC;
           EY : out  STD_LOGIC;
           EG : out  STD_LOGIC;
			  STIMER0 : out  STD_LOGIC_VECTOR (3 downto 0);
			  STIMER1 : out  STD_LOGIC_VECTOR (3 downto 0);
           SR : out  STD_LOGIC;
           SY : out  STD_LOGIC;
           SG : out  STD_LOGIC;
			  WTIMER0 : out  STD_LOGIC_VECTOR (3 downto 0);
			  WTIMER1 : out  STD_LOGIC_VECTOR (3 downto 0);
           WR : out  STD_LOGIC;
           WY : out  STD_LOGIC;
           WG : out  STD_LOGIC);
end TRAFFIC_LIGHT;

architecture Behavioral of TRAFFIC_LIGHT is

signal MASTER : STD_LOGIC_VECTOR (6 downto 0):="1111000";--120
signal Ncounter0 : STD_LOGIC_VECTOR (3 downto 0):="0000";--30
signal Ncounter1 : STD_LOGIC_VECTOR (3 downto 0):="0011";--30
signal Wcounter0 : STD_LOGIC_VECTOR (3 downto 0):="0000";--30
signal Wcounter1 : STD_LOGIC_VECTOR (3 downto 0):="0011";--30
signal Scounter0 : STD_LOGIC_VECTOR (3 downto 0):="0000";--60
signal Scounter1 : STD_LOGIC_VECTOR (3 downto 0):="0110";--60
signal Ecounter0 : STD_LOGIC_VECTOR (3 downto 0):="0000";--90
signal Ecounter1 : STD_LOGIC_VECTOR (3 downto 0):="1001";--90

begin

--MASTER
process(clk,rst)
begin

if rst='1' then
MASTER <= "1111000"; --120

elsif (rising_edge(clk) and rst='0') then
MASTER <= MASTER-1;

if MASTER = "00000001" then
MASTER <= "1111000"; --120

end if;
end if;
end process;


--North
process(clk,MASTER,rst)
begin

if rst='1' then
NR<= '0';
NY<= '0';
NG<= '0';

elsif (rising_edge(clk) and rst='0') then

if MASTER = "1111000" then --120
NR<= '0';
NY<= '0';
NG<= '1';

elsif MASTER = "1011111" then --95
NR<= '0';
NY<= '1';
NG<= '0';

elsif MASTER = "1011010" then --90
NR<= '1';
NY<= '0';
NG<= '0';


end if;
end if;
end process;

process(clk,MASTER,rst,Ncounter0)
begin

if rst='1' then
Ncounter0 <= "0000"; --30
Ncounter1 <= "0011";
 
elsif(MASTER = "1111000") then --120
Ncounter0 <= "0000"; --30
Ncounter1 <= "0011";
 
elsif(MASTER = "1011010") then --90
Ncounter0 <= "0000"; --90
Ncounter1 <= "1001";

end if;

if (rising_edge(clk) and rst='0') then
Ncounter0 <= Ncounter0 - 1;
if (Ncounter0 = "0000") then
Ncounter1 <= Ncounter1 - 1;
end if;
end if;

if ( rising_edge(clk) and Ncounter0 = "1111" and rst='0') then
Ncounter0 <= "1001";
end if;

end process;
NTIMER0 <= Ncounter0;
NTIMER1 <= Ncounter1;

--West
process(clk,MASTER,rst)
begin

if rst='1' then
WR<= '0';
WY<= '0';
WG<= '0';

elsif (rising_edge(clk) and rst='0') then

if MASTER = "1111000" then --120
WR<= '1';
WY<= '0';
WG<= '0';

elsif MASTER = "1011010" then --90
WR<= '0';
WY<= '0';
WG<= '1';

elsif MASTER = "1000001" then --65
WR<= '0';
WY<= '1';
WG<= '0';

elsif MASTER = "0111100" then --60
WR<= '1';
WY<= '0';
WG<= '0';

end if;
end if;
end process;

process(clk,MASTER,rst,Wcounter0)
begin

if rst='1' then
Wcounter0 <= "0000"; --30
Wcounter1 <= "0011";
 
elsif(MASTER = "1111000") then --120
Wcounter0 <= "0000"; --30
Wcounter1 <= "0011";

elsif(MASTER = "1011010") then --90
Wcounter0 <= "0000"; --30
Wcounter1 <= "0011";

elsif(MASTER = "0111100") then --60
Wcounter0 <= "0000"; --90
Wcounter1 <= "1001";

end if;

if (rising_edge(clk) and rst='0') then
Wcounter0 <= Wcounter0 - 1;
if Wcounter0 = "0000" then
Wcounter1 <= Wcounter1 - 1;
end if;
end if;

if (rising_edge(clk) and Wcounter0 = "1111" and rst='0') then
Wcounter0 <= "1001";
end if;

end process;
WTIMER0 <= Wcounter0;
WTIMER1 <= Wcounter1;

--South
process(clk,MASTER,rst)
begin

if rst='1' then
SR<= '0';
SY<= '0';
SG<= '0';

elsif (rising_edge(clk) and rst='0') then

if MASTER = "1111000" then --120
SR<= '1';
SY<= '0';
SG<= '0';

elsif MASTER = "0111100" then --60
SR<= '0';
SY<= '0';
SG<= '1';

elsif MASTER = "0100011" then --35
SR<= '0';
SY<= '1';
SG<= '0';

elsif MASTER = "0011110" then --30
SR<= '1';
SY<= '0';
SG<= '0';

end if;
end if;
end process;

process(clk,MASTER,rst,Scounter0)
begin

if rst='1' then
Scounter0 <= "0000"; --60
Scounter1 <= "0110";
 
elsif(MASTER = "1111000") then --120
Scounter0 <= "0000"; --60
Scounter1 <= "0110";

elsif(MASTER = "0111100") then --60
Scounter0 <= "0000"; --30
Scounter1 <= "0011";

elsif(MASTER = "0011110") then --30
Scounter0 <= "0000"; --90
Scounter1 <= "1001";

end if;
if (rising_edge(clk) and rst='0') then
Scounter0 <= Scounter0 - 1;
if Scounter0 = "0000" then
Scounter1 <= Scounter1 - 1;
end if;
end if;

if ( rising_edge(clk) and Scounter0 = "1111" and rst='0') then
Scounter0 <= "1001";
end if;

end process;
STIMER0 <= Scounter0;
STIMER1 <= Scounter1;

--East
process(clk,MASTER,rst)
begin

if rst='1' then
ER<= '0';
EY<= '0';
EG<= '0';

elsif (rising_edge(clk) and rst='0') then

if MASTER = "1111000" then --120
ER<= '1';
EY<= '0';
EG<= '0';

elsif MASTER = "0011110" then --30
ER<= '0';
EY<= '0';
EG<= '1';

elsif MASTER = "00000101" then --5
ER<= '0';
EY<= '1';
EG<= '0';


end if;
end if;
end process;

process(clk,MASTER,rst,Ecounter0)
begin

if rst='1' then
Ecounter0 <= "0000"; --90
Ecounter1 <= "1001";
 
elsif(MASTER = "1111000") then --120
Ecounter0 <= "0000"; --90
Ecounter1 <= "1001";
 
elsif(MASTER = "0011110") then --30
Ecounter0 <= "0000"; --30
Ecounter1 <= "0011";
 
end if;
if (rising_edge(clk) and rst='0') then
Ecounter0 <= Ecounter0 - 1;
if Ecounter0 = "0000" then
Ecounter1 <= Ecounter1 - 1;
end if;
end if;

if ( rising_edge(clk) and Ecounter0 = "1111" and rst='0') then
Ecounter0 <= "1001";
end if;

end process;
ETIMER0 <= Ecounter0;
ETIMER1 <= Ecounter1;

end Behavioral;