library verilog;
use verilog.vl_types.all;
entity uart_tx_fsm is
    generic(
        IDLE            : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi0);
        start           : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi1);
        data            : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi1);
        parity          : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi0);
        stop            : vl_logic_vector(2 downto 0) := (Hi1, Hi1, Hi0)
    );
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        Data_Valid      : in     vl_logic;
        ser_done        : in     vl_logic;
        parity_enable   : in     vl_logic;
        Ser_enable      : out    vl_logic;
        mux_sel         : out    vl_logic_vector(1 downto 0);
        busy            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 2;
    attribute mti_svvh_generic_type of start : constant is 2;
    attribute mti_svvh_generic_type of data : constant is 2;
    attribute mti_svvh_generic_type of parity : constant is 2;
    attribute mti_svvh_generic_type of stop : constant is 2;
end uart_tx_fsm;
