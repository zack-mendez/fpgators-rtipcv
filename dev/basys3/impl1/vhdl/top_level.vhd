library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
  port (
    clk100 : in std_logic;
    rst    : in std_logic;
    btnc   : in std_logic;
    btnl   : in std_logic;
    sw     : in std_logic_vector(15 downto 0);

    -- vga port signals
    h_sync : out std_logic;
    v_sync : out std_logic;
    red    : out std_logic_vector(3 downto 0);
    green  : out std_logic_vector(3 downto 0);
    blue   : out std_logic_vector(3 downto 0);

    -- camera signals
    ov7670_pclk  : in std_logic;
    ov7670_xclk  : out std_logic;
    ov7670_vsync : in std_logic;
    ov7670_href  : in std_logic;
    ov7670_data  : in std_logic_vector(7 downto 0);
    ov7670_sioc  : out std_logic;
    ov7670_siod  : inout std_logic;
    ov7670_pwdn  : out std_logic;
    ov7670_reset : out std_logic;

    config_done : out std_logic
  );

end top_level;

architecture BHV of top_level is

  component ov7670_controller
    port (
      clk           : in std_logic;
      rst           : in std_logic;
      config        : in std_logic;
      user_settings : in std_logic_vector(15 downto 0);
      done          : out std_logic;

      sioc     : out std_logic;
      siod     : inout std_logic;
      cam_rst  : out std_logic;
      cam_pwdn : out std_logic
    );
  end component;

  component frame_buffer_1
    port (
      clka  : in std_logic;
      wea   : in std_logic_vector(0 downto 0);
      addra : in std_logic_vector(18 downto 0);
      dina  : in std_logic_vector(3 downto 0);
      clkb  : in std_logic;
      addrb : in std_logic_vector(18 downto 0);
      doutb : out std_logic_vector(3 downto 0)
    );
  end component;

  component clk_wiz_0
    port (
      clk_out1 : out std_logic;
      clk_out2 : out std_logic;
      clk_in1  : in std_logic
    );
  end component;

  component debouncer
    generic (
      DEBNC_CLOCKS : integer range 2 to (integer'high) := 2 ** 16;
      PORT_WIDTH   : integer range 1 to (integer'high) := 5);
    port (
      SIGNAL_I : in std_logic_vector ((PORT_WIDTH - 1) downto 0);
      CLK_I    : in std_logic;
      SIGNAL_O : out std_logic_vector ((PORT_WIDTH - 1) downto 0)
    );
  end component;

  component rgb_to_gray
    port (
      data_in  : in std_logic_vector(11 downto 0);
      data_out : out std_logic_vector(3 downto 0)
    );
  end component;

  signal clk50      : std_logic;
  signal clk25      : std_logic;
  signal wren       : std_logic_vector(0 downto 0);
  signal v_sync_net : std_logic;

  signal buf_wr_addr : std_logic_vector(18 downto 0);
  signal buf_in      : std_logic_vector(3 downto 0);

  signal buf_rd_addr    : std_logic_vector(18 downto 0);
  signal buf_out        : std_logic_vector(3 downto 0);
  signal rgb_to_gray_in : std_logic_vector(11 downto 0);

  signal draw_en : std_logic;

  signal btn_in_bus  : std_logic_vector(2 downto 0);
  signal btn_out_bus : std_logic_vector(2 downto 0);

  signal rst_btn    : std_logic;
  signal config_btn : std_logic;
  signal user_btn   : std_logic;

begin

  ov7670_xclk <= clk25;

  v_sync <= v_sync_net;

  btn_in_bus <= btnl & btnc & rst;

  rst_btn    <= btn_out_bus(0);
  config_btn <= btn_out_bus(1);
  user_btn   <= btn_out_bus(2);

  U_RGB2GRAY : rgb_to_gray
  port map
  (
    data_in  => rgb_to_gray_in,
    data_out => buf_in
  );

  U_DEBOUNCER : debouncer
  generic map(
    DEBNC_CLOCKS => 2 ** 16,
    PORT_WIDTH   => 3
  )
  port map
  (
    SIGNAL_I => btn_in_bus,
    CLK_I    => clk50,
    SIGNAL_O => btn_out_bus
  );

  U_PLL : clk_wiz_0
  port map
  (
    clk_out1 => clk50,
    clk_out2 => clk25,
    clk_in1  => clk100
  );

  U_VGA : entity work.VGA
  port map
  (
    clk     => clk25,
    rst     => rst_btn,
    h_sync  => h_sync,
    v_sync  => v_sync_net,
    draw_en => draw_en
  );

  U_CAM_CTRL : ov7670_controller
  port map
  (
    clk           => clk50,
    rst           => config_btn,
    config        => user_btn,
    user_settings => sw,
    done          => config_done,
    sioc          => ov7670_sioc,
    siod          => ov7670_siod,
    cam_rst       => ov7670_reset,
    cam_pwdn      => ov7670_pwdn
  );

  U_FRAME_BUFFER_1 : frame_buffer_1
  port map
  (
    addrb => buf_rd_addr,
    clkb  => clk25,
    doutb => buf_out,

    clka  => ov7670_pclk,
    addra => buf_wr_addr,
    dina  => buf_in,
    wea   => wren
  );

  U_CAM_CAPTURE : entity work.ov7670_pixel_capture
  port map
  (
    clk    => ov7670_pclk,
    rst     => rst_btn,
    v_sync  => ov7670_vsync,
    href    => ov7670_href,
    data_in => ov7670_data,
    addr    => buf_wr_addr,
    dout    => rgb_to_gray_in,
    we      => wren(0)
  );

  U_GRAY_TO_RGB : entity work.gray_to_RGB
    port map
    (
      data    => buf_out,
      draw_en => draw_en,
      R       => red,
      G       => green,
      B       => blue
    );

  U_ADDR_GEN : entity work.addr_gen
  port map
  (
    clk     => clk25,
    rst     => rst_btn,
    enable  => draw_en,
    v_sync  => v_sync_net,
    address => buf_rd_addr
  );

end BHV;
