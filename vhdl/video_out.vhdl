library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity video is
    Port (
        net_in : in std_ulogic;
        hvid_n : in std_ulogic;
        vvid_n : in std_ulogic;
        pad1 : in std_ulogic;
        pad2 : in std_ulogic;
        video : out std_ulogic
    );
end video;

architecture video_processing of video is

    signal hvid_and_vvid : std_ulogic;

begin

    hvid_and_vvid <= not hvid_n and not vvid_n;
    video <= net_in or hvid_and_vvid or pad1 or pad2;

end video_processing;