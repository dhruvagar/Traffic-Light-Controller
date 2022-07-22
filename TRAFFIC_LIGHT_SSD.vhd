----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:21:03 06/05/2021 
-- Design Name: 
-- Module Name:    TRAFFIC_LIGHT_SSD - Behavioral 
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

entity TRAFFIC_LIGHT_SSD is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  NR : out  STD_LOGIC;
           NY : out  STD_LOGIC;
           NG : out  STD_LOGIC;
           ER : out  STD_LOGIC;
           EY : out  STD_LOGIC;
           EG : out  STD_LOGIC;
           SR : out  STD_LOGIC;
           SY : out  STD_LOGIC;
           SG : out  STD_LOGIC;
           WR : out  STD_LOGIC;
           WY : out  STD_LOGIC;
           WG : out  STD_LOGIC;
           SSD : out  STD_LOGIC_VECTOR (7 downto 0);
           en : out  STD_LOGIC_VECTOR (7 downto 0));
end TRAFFIC_LIGHT_SSD;

architecture Behavioral of TRAFFIC_LIGHT_SSD is

component TRAFFIC_LIGHT 
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
end component;

component Clk_1Hz 
    Port ( clk : in  STD_LOGIC;
           q : out  STD_LOGIC);
end component;

component SevenSegmentDecoder 
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           X : out  STD_LOGIC_VECTOR (6 downto 0));
end component;

signal clk1Hz : STD_LOGIC;
signal S0,S1,S2,S3,S4,S5,S6,S7 :  STD_LOGIC_VECTOR (3 downto 0);
signal counter :  STD_LOGIC_VECTOR (15 downto 0):= (others=>'0');
signal SSD0,SSD1,SSD2,SSD3,SSD4,SSD5,SSD6,SSD7 :  STD_LOGIC_VECTOR (6 downto 0);

begin

X0:TRAFFIC_LIGHT port map (clk1Hz,rst,S6,S7,NR,NY,NG,S4,S5,ER,EY,EG,S2,S3,SR,SY,SG,S0,S1,WR,WY,WG);
X1: SevenSegmentDecoder port map (S0,SSD0);
X2: SevenSegmentDecoder port map (S1,SSD1);
X3: SevenSegmentDecoder port map (S2,SSD2);
X4: SevenSegmentDecoder port map (S3,SSD3);
X5: SevenSegmentDecoder port map (S4,SSD4);
X6: SevenSegmentDecoder port map (S5,SSD5);
X7: SevenSegmentDecoder port map (S6,SSD6);
X8: SevenSegmentDecoder port map (S7,SSD7);
X9: Clk_1Hz port map (clk,clk1Hz);

--enable shifitng 
process(clk,rst,counter)
begin
if (rising_edge(clk)) then
counter <= counter+1;

end if;

case counter(15 downto 13) is 
when "000" => en <= "11111110"; SSD<= SSD0 & '1';
when "001" => en <= "11111101"; SSD<= SSD1 & '1';
when "010" => en <= "11111011"; SSD<= SSD2 & '0';
when "011" => en <= "11110111"; SSD<= SSD3 & '1';
when "100" => en <= "11101111"; SSD<= SSD4 & '0';
when "101" => en <= "11011111"; SSD<= SSD5 & '1';
when "110" => en <= "10111111"; SSD<= SSD6 & '0';
when "111" => en <= "01111111"; SSD<= SSD7 & '1';
when others => en <= "11111111";
end case;

end process;

end Behavioral;

