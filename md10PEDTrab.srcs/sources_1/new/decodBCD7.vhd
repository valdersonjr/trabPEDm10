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
        selO<=  "1111110" when "0000",
                "1110000" when "0001",
                "1101101" when "0010",
                "1111001" when "0011",
                "0110011" when "0100",
                "1011011" when "0101",
                "1011111" when "0110",
                "1110000" when "0111",
                "1111111" when "1000",
                "1110011" when "1001",
                "1110111" when "1010",
                "0011111" when "1011",
                "0001101" when "1100",
                "0111101" when "1101",
                "1001111" when "1110",
                "1000111" when "1111",
                "0000000" when others;

       ao<=selO(6);bo<=selO(5);co<=selO(4);do<=selO(3);
       eo<=selO(2);fo<=selO(1);go<=selO(0);

end Behavioral;