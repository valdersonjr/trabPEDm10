library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( entradaA : in STD_LOGIC_VECTOR(3 downto 0);
           entradaB : in STD_LOGIC_VECTOR(3 downto 0);
           an: out STD_LOGIC_VECTOR(3 downto 0);
           saidaA: out STD_LOGIC_VECTOR(6 downto 0);
           clk: in STD_LOGIC );
--           saidaB: out STD_LOGIC_VECTOR(6 downto 0));
end main;

architecture Behavioral of main is

signal entradaSelecionada: STD_LOGIC_VECTOR(3 downto 0);
signal saidaDecodificada : STD_LOGIC_VECTOR(6 downto 0);
signal saidaSelecionada : STD_LOGIC_VECTOR(6 downto 0);
signal an1 : STD_LOGIC_VECTOR(3 downto 0);


signal unidadeDisplay: STD_LOGIC;
signal dezenaDisplay: STD_LOGIC;

signal clk_dividido: STD_LOGIC :='0';
signal counter: integer range 1 to 100_000 := 1;
signal seletor_display: integer range 0 to 1 := 0;

component mux 
    Port ( entA : in STD_LOGIC_VECTOR(3 downto 0);
           entB : in STD_LOGIC_VECTOR(3 downto 0);
           sel : in STD_LOGIC_VECTOR(3 downto 0);
           saida : inout STD_LOGIC_VECTOR(3 downto 0));
end component;

component decodBCD7
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
end component;

begin
    
    divisor_clk: process(clk)
    begin
        if rising_edge(clk) then
            if counter =100_000 then
                counter <=1;
                clk_dividido <= not clk_dividido;
            else
                counter <= counter+1;
            end if;
        end if;
    end process;
    
    multiplexacao: process(clk_dividido)
    begin
        if rising_edge(clk_dividido) then
            case seletor_display is
            when 0 => an1 <= "1110";
            when 1 => an1 <= "1101";
            end case;
            
            if seletor_display=1 then
                seletor_display <= 0;
            else
                seletor_display <= seletor_display +1;
            end if;
            
        end if;
    end process;
    

    u1: mux port map(
        entA => entradaA, 
        entB => entradaB, 
        sel => an1, 
        saida => entradaSelecionada);
        
    ux: decodBCD7 port map (
        Ai => entradaSelecionada(3), 
        Bi => entradaSelecionada(2), 
        Ci => entradaSelecionada(1), 
        Di => entradaSelecionada(0),
        ao => saidaDecodificada(6),
        bo => saidaDecodificada(5),
        co => saidaDecodificada(4),
        do => saidaDecodificada(3),
        eo => saidaDecodificada(2),
        fo => saidaDecodificada(1),
        go => saidaDecodificada(0));
        
                     
        an <= an1;
        saidaA <= saidaDecodificada;
        
end Behavioral;
