library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity topo is port (
	SW: in std_logic_vector(9 downto 0);
	KEY: in std_logic_vector(3 downto 0);
	HEX0: out std_logic_vector(6 downto 0);
	HEX1: out std_logic_vector(6 downto 0);
	LEDR: out std_logic_vector(7 downto 0);
	CLOCK_50: in std_logic);
end topo;

architecture topoarch of topo is

component ButtonSync is
	port
	(
		KEY0, KEY1, KEY2, KEY3, CLK: in std_logic;
		BTN0, BTN1, BTN2, BTN3: out std_logic
	);
end component;

component Datapath is port (
	currint, lastint: in std_logic_vector(7 downto 0);
	intout: out std_logic_vector(7 downto 0);
	selector: in std_logic_vector(1 downto 0);
	reset, clock, enable: in std_logic);
end component;

component decod7seg is
port (C: in std_logic_vector(3 downto 0);
		F: out std_logic_vector(6 downto 0)
);
end component;


signal holder: std_logic_vector(7 downto 0);
signal BT1, BT2, BT3, BT0: std_logic;

begin
	BTS: ButtonSync port map(KEY(0), KEY(1), KEY(2), KEY(3), CLOCK_50, BT0, BT1, BT2, BT3);
	data: Datapath port map(SW(7 downto 0), holder, holder, SW(9 downto 8), BT0, CLOCK_50, BT1);
	DEC1: decod7seg port map(holder(7 downto 4), HEX1);
	DEC2: decod7seg port map(holder(3 downto 0), HEX0);
	
	LEDR <= holder;
	

end topoarch;






