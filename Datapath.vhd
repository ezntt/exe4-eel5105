library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Datapath is port (
	currint, lastint: in std_logic_vector(7 downto 0);
	intout: out std_logic_vector(7 downto 0);
	selector: in std_logic_vector(1 downto 0);
	reset, clock, enable: in std_logic);
end Datapath;

architecture arqdtp of Datapath is
	begin
	process(clock, enable, selector)
		begin
			if (clock'event AND clock = '1') then
				if (reset = '0') then
					intout <= "00000000";
				elsif (enable = '0') then
					if selector = "00" then
						intout <= currint + lastint;
					end if;
					if selector = "01" then
						intout <= currint;
					end if;
					if selector = "10" then
						intout <= '0' & lastint(7 downto 1);
					end if;
					if selector = "11" then
						intout <= lastint(6 downto 0) & '0';
					end if;
				end if;
			end if;
	end process;
end arqdtp;