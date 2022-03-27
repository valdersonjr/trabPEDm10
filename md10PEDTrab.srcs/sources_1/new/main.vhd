library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( entradaA : in STD_LOGIC_VECTOR(3 downto 0);
           entradaB : in STD_LOGIC_VECTOR(3 downto 0);
           seletor: in STD_LOGIC;
           an: out STD_LOGIC_VECTOR(3 downto 0);
           saidaA: out STD_LOGIC_VECTOR(6 downto 0));
--           saidaB: out STD_LOGIC_VECTOR(6 downto 0));
end main;

architecture Behavioral of main is

signal entradaSelecionada: STD_LOGIC_VECTOR(3 downto 0);
signal saidaDecodificada : STD_LOGIC_VECTOR(6 downto 0);
signal saidaSelecionada : STD_LOGIC_VECTOR(6 downto 0);
signal an1 : STD_LOGIC_VECTOR(3 downto 0);


signal unidadeDisplay: STD_LOGIC;
signal dezenaDisplay: STD_LOGIC;

component mux 
    Port ( entA : in STD_LOGIC_VECTOR(3 downto 0);
           entB : in STD_LOGIC_VECTOR(3 downto 0);
           sel : in STD_LOGIC;
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

    u1: mux port map(
        entA => entradaA, 
        entB => entradaB, 
        sel => seletor, 
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


        
        with seletor select
        an1 <=  "1110" when '0',
                "1101" when others;
                               
        an <= an1;
        saidaA <= saidaDecodificada;
        
end Behavioral;
