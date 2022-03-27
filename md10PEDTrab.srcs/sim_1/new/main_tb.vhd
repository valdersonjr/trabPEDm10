library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity main_tb is
--  Port ( );
end main_tb;

architecture Behavioral of main_tb is

    component main
    Port ( entradaA : in STD_LOGIC_VECTOR(3 downto 0);
           entradaB : in STD_LOGIC_VECTOR(3 downto 0);
           seletor: in STD_LOGIC;
           saidaA: out STD_LOGIC_VECTOR(6 downto 0));
--           saidaB: out STD_LOGIC_VECTOR(6 downto 0));
    end component;

    signal entradaAS, entradaBS: STD_LOGIC_VECTOR(3 downto 0);
    signal seletorS: STD_LOGIC;
    signal saidaAS: STD_LOGIC_VECTOR (6 downto 0);
--    signal saidaBS: STD_LOGIC_VECTOR (6 downto 0);

begin
    
    uut: main port map(
        entradaA => entradaAS,
        entradaB => entradaBS,
        seletor => seletorS,
        saidaA => saidaAS
--        saidaB => saidaBS
    );
    
    stimulus: process
    begin
        entradaAS <= "0010"; entradaBS <= "0011"; seletorS <= '1';  wait for 10ns; --(2)3
        entradaAS <= "0010"; entradaBS <= "0011"; seletorS <= '0';  wait for 10ns; --2(3)
        entradaAS <= "0100"; entradaBS <= "0010"; seletorS <= '1';  wait for 10ns; --(4)2
        entradaAS <= "0100"; entradaBS <= "0010"; seletorS <= '0';  wait for 10ns; --4(2)
        entradaAS <= "0111"; entradaBS <= "1111"; seletorS <= '1';  wait for 10ns; --(7)f
        entradaAS <= "0111"; entradaBS <= "1111"; seletorS <= '0';  wait for 10ns; --7(f)
    end process;

end Behavioral;
