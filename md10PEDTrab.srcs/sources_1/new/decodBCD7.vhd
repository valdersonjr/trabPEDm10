library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodBCD7 is
    Port ( Ai : in STD_LOGIC;
           Bi : in STD_LOGIC;
           Ci : in STD_LOGIC;
           Di : in STD_LOGIC;
           ao : out STD_LOGIC;
           bo : out STD_LOGIC;
           co : out STD_LOGIC;
           do : out STD_LOGIC;
           eo : out STD_LOGIC;
           fo : out STD_LOGIC;
           go : out STD_LOGIC);
end decodBCD7;

architecture Behavioral of decodBCD7 is
    signal selI : std_logic_vector(3 downto 0);
    signal selO : std_logic_vector(6 downto 0);
begin
    selI<= Ai & Bi & Ci & Di;
    with selI select
        selO <= "0000001" when "0000", --0
                "1001111" when "0001", --1
                "0010010" when "0010", --2
                "0000110" when "0011", --3
                "1001100" when "0100", --4
                "0100100" when "0101", --5
                "0100000" when "0110", --6
                "0001111" when "0111", --7
                "0000000" when "1000", --8
                "0000100" when "1001", --9
                "0001000" when "1010", --A
                "1100000" when "1011", --B
                "1110010" when "1100", --C
                "1000010" when "1101", --D 
                "0110000" when "1110", --E
                "0111000" when "1111", --F
                "1111111" when others; --NULL

       ao<=selO(6);bo<=selO(5);co<=selO(4);do<=selO(3);
       eo<=selO(2);fo<=selO(1);go<=selO(0);

end Behavioral;