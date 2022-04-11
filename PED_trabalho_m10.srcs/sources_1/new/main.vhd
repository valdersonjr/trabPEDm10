library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( entradaA : in STD_LOGIC_VECTOR(3 downto 0);
           entradaB : in STD_LOGIC_VECTOR(3 downto 0);
           clk: in STD_LOGIC;
           saida7Seg: out STD_LOGIC_VECTOR(6 downto 0);
           an: out STD_LOGIC_VECTOR(3 downto 0));
--           dp: out STD_LOGIC);
end main;

architecture Behavioral of main is

signal clk_dividido: STD_LOGIC:='0';
signal counter: integer range 1 to 100_000 :=1;
signal sel_display: integer range 0 to 1 :=0;
signal s_an, entradaSelecionada: STD_LOGIC_VECTOR(3 downto 0);

component decodBCD7
    Port ( bcd_in: in STD_LOGIC_VECTOR(3 downto 0);
           saidaDecodificada: out STD_LOGIC_VECTOR(6 downto 0));
end component;

begin

    -----------------
    ---Divisor clk---
    -----------------
    
    divisor_clk: process(clk)
    begin
    
        if rising_edge(clk) then
            if counter = 100_000 then
                counter <= 1;
                clk_dividido <= not clk_dividido;
            else
                counter <= counter + 1;
            end if;
        end if;
        
    end process;
        
    mux_select_and_entradas: process(clk_dividido)
    begin
    
        if rising_edge(clk_dividido) then
            case sel_display is
                when 0 => s_an <= "1110"; entradaSelecionada <= entradaB;
                when 1 => s_an <= "1101"; entradaSelecionada <= entradaA;
                when others => null;
            end case;            
            sel_display <= sel_display + 1;
        end if;
    
    end process;
    
--    muxEntradas: process(s_an)
--    begin
--        if(s_an = "1110") then
--            entradaSelecionada <= entradaB;
--        else
--            entradaSelecionada <= entradaA;
--        end if;
--    end process;
    
    ux: decodBCD7 port map(
        bcd_in(3) => entradaSelecionada(3),
        bcd_in(2) => entradaSelecionada(2),
        bcd_in(1) => entradaSelecionada(1),
        bcd_in(0) => entradaSelecionada(0),
        saidaDecodificada(6) => saida7Seg(0),
        saidaDecodificada(5) => saida7Seg(1),
        saidaDecodificada(4) => saida7Seg(2),
        saidaDecodificada(3) => saida7Seg(3),
        saidaDecodificada(2) => saida7Seg(4),
        saidaDecodificada(1) => saida7Seg(5),
        saidaDecodificada(0) => saida7Seg(6));
        
        an <= s_an;
--        dp <= '1';
end Behavioral;