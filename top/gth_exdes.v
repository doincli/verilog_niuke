`timescale 1ns / 1ps
`define DLY #1

(* DowngradeIPIdentifiedWarnings="yes" *)
//***********************************Entity Declaration************************
(* CORE_GENERATION_INFO = "GTH,gtwizard_v3_6_8,{protocol_file=aurora_8b10b_single_lane_2byte}" *)
module GTH_exdes #
(
    parameter EXAMPLE_CONFIG_INDEPENDENT_LANES     =   1,//configuration for frame gen and check
    parameter EXAMPLE_LANE_WITH_START_CHAR         =   0,         // specifies lane with unique start frame char
    // parameter EXAMPLE_WORDS_IN_BRAM                =   512,       // specifies amount of data in BRAM
     parameter EXAMPLE_WORDS_IN_BRAM                =   640,       // specifies amount of data in BRAM
    parameter EXAMPLE_SIM_GTRESET_SPEEDUP          =   "FALSE",    // simulation setting for GT SecureIP model
    parameter EXAMPLE_USE_CHIPSCOPE                =   0,         // Set to 1 to use Chipscope to drive resets
    parameter STABLE_CLOCK_PERIOD                  = 10

)
(
    input wire  Q5_CLK0_GTREFCLK_PAD_N_IN,
    input wire  Q5_CLK0_GTREFCLK_PAD_P_IN,
    input wire  DRP_CLK_IN_P,
    input wire  DRP_CLK_IN_N,
    output wire TRACK_DATA_OUT,
    input  wire [1:0]   RXN_IN,
    input  wire [1:0]   RXP_IN,
    output wire [1:0]   TXN_OUT,
    output wire [1:0]   TXP_OUT,
    input  wire         rst_n       //  �����rst_n �����е㲻һ������Ϊ������GT TX/RX RESET ���룻
);


    wire soft_reset_i;
    wire soft_reset_vio_i;

//************************** Register Declarations ****************************
    wire            gt_txfsmresetdone_i;
    wire            gt_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt_txfsmresetdone_r2;
    wire            gt0_txfsmresetdone_i;
    wire            gt0_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt0_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_txfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt0_rxresetdone_r3;

    wire            gt1_txfsmresetdone_i;
    wire            gt1_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt1_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt1_txfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt1_rxfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt1_rxfsmresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt1_rxresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt1_rxresetdone_r2;
    (* ASYNC_REG = "TRUE" *)reg             gt1_rxresetdone_r3;


//**************************** Wire Declarations ******************************//
    //------------------------ GT Wrapper Wires ------------------------------
    //________________________________________________________________________
    //________________________________________________________________________
    //GT0  (X1Y20)
    //------------------------------- CPLL Ports -------------------------------
    wire            gt0_cpllfbclklost_i;
    wire            gt0_cplllock_i;
    wire            gt0_cpllrefclklost_i;
    wire            gt0_cpllreset_i;
    //-------------------------- Channel - DRP Ports  --------------------------
    wire    [8:0]   gt0_drpaddr_i;
    wire    [15:0]  gt0_drpdi_i;
    wire    [15:0]  gt0_drpdo_i;
    wire            gt0_drpen_i;
    wire            gt0_drprdy_i;
    wire            gt0_drpwe_i;
    //----------------------------- Loopback Ports -----------------------------
    wire    [2:0]   gt0_loopback_i;
    //---------------------------- Power-Down Ports ----------------------------
    wire    [1:0]   gt0_rxpd_i;
    wire    [1:0]   gt0_txpd_i;
    //------------------- RX Initialization and Reset Ports --------------------
    wire            gt0_eyescanreset_i;
    wire            gt0_rxuserrdy_i;
    //------------------------ RX Margin Analysis Ports ------------------------
    wire            gt0_eyescandataerror_i;
    wire            gt0_eyescantrigger_i;
    //----------------------- Receive Ports - CDR Ports ------------------------
    wire            gt0_rxcdrhold_i;
    wire            gt0_rxcdrovrden_i;
    //----------------- Receive Ports - Clock Correction Ports -----------------
    wire    [1:0]   gt0_rxclkcorcnt_i;
    //----------------- Receive Ports - Digital Monitor Ports ------------------
    wire    [14:0]  gt0_dmonitorout_i;
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    wire    [15:0]  gt0_rxdata_i;
    //----------------- Receive Ports - Pattern Checker Ports ------------------
    wire            gt0_rxprbserr_i;
    wire    [2:0]   gt0_rxprbssel_i;
    //----------------- Receive Ports - Pattern Checker ports ------------------
    wire            gt0_rxprbscntreset_i;
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    wire    [1:0]   gt0_rxdisperr_i;
    wire    [1:0]   gt0_rxnotintable_i;
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    wire            gt0_gthrxn_i;
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    wire            gt0_rxbufreset_i;
    wire    [2:0]   gt0_rxbufstatus_i;
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    wire            gt0_rxbyteisaligned_i;
    wire            gt0_rxbyterealign_i;
    wire            gt0_rxcommadet_i;
    wire            gt0_rxmcommaalignen_i;
    wire            gt0_rxpcommaalignen_i;
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    wire            gt0_rxdfelpmreset_i;
    wire    [6:0]   gt0_rxmonitorout_i;
    wire    [1:0]   gt0_rxmonitorsel_i;
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    wire            gt0_rxoutclk_i;
    wire            gt0_rxoutclkfabric_i;
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    wire            gt0_gtrxreset_i;
    wire            gt0_rxpcsreset_i;
    wire            gt0_rxpmareset_i;
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    wire            gt0_rxlpmen_i;
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    wire            gt0_rxpolarity_i;
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    wire    [1:0]   gt0_rxchariscomma_i;
    wire    [1:0]   gt0_rxcharisk_i;
    //---------------------- Receive Ports -RX AFE Ports -----------------------
    wire            gt0_gthrxp_i;
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    wire            gt0_rxresetdone_i;
    //---------------------- TX Configurable Driver Ports ----------------------
    wire    [4:0]   gt0_txpostcursor_i;
    wire    [4:0]   gt0_txprecursor_i;
    //------------------- TX Initialization and Reset Ports --------------------
    wire            gt0_gttxreset_i;
    wire            gt0_txuserrdy_i;
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    wire    [1:0]   gt0_txchardispmode_i;
    wire    [1:0]   gt0_txchardispval_i;
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
    wire            gt0_txprbsforceerr_i;
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    wire    [1:0]   gt0_txbufstatus_i;
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    wire    [3:0]   gt0_txdiffctrl_i;
    wire    [6:0]   gt0_txmaincursor_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [15:0]  gt0_txdata_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire            gt0_gthtxn_i;
    wire            gt0_gthtxp_i;
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    wire            gt0_txoutclk_i;
    wire            gt0_txoutclkfabric_i;
    wire            gt0_txoutclkpcs_i;
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    wire            gt0_txpcsreset_i;
    wire            gt0_txpmareset_i;
    wire            gt0_txresetdone_i;
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    wire            gt0_txpolarity_i;
    //---------------- Transmit Ports - pattern Generator Ports ----------------
    wire    [2:0]   gt0_txprbssel_i;
    //--------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    wire    [1:0]   gt0_txcharisk_i;

    //________________________________________________________________________
    //________________________________________________________________________
    //GT1  (X1Y21)
    //------------------------------- CPLL Ports -------------------------------
    wire            gt1_cpllfbclklost_i;
    wire            gt1_cplllock_i;
    wire            gt1_cpllrefclklost_i;
    wire            gt1_cpllreset_i;
    //-------------------------- Channel - DRP Ports  --------------------------
    wire    [8:0]   gt1_drpaddr_i;
    wire    [15:0]  gt1_drpdi_i;
    wire    [15:0]  gt1_drpdo_i;
    wire            gt1_drpen_i;
    wire            gt1_drprdy_i;
    wire            gt1_drpwe_i;
    //----------------------------- Loopback Ports -----------------------------
    wire    [2:0]   gt1_loopback_i;
    //---------------------------- Power-Down Ports ----------------------------
    wire    [1:0]   gt1_rxpd_i;
    wire    [1:0]   gt1_txpd_i;
    //------------------- RX Initialization and Reset Ports --------------------
    wire            gt1_eyescanreset_i;
    wire            gt1_rxuserrdy_i;
    //------------------------ RX Margin Analysis Ports ------------------------
    wire            gt1_eyescandataerror_i;
    wire            gt1_eyescantrigger_i;
    //----------------------- Receive Ports - CDR Ports ------------------------
    wire            gt1_rxcdrhold_i;
    wire            gt1_rxcdrovrden_i;
    //----------------- Receive Ports - Clock Correction Ports -----------------
    wire    [1:0]   gt1_rxclkcorcnt_i;
    //----------------- Receive Ports - Digital Monitor Ports ------------------
    wire    [14:0]  gt1_dmonitorout_i;
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    wire    [15:0]  gt1_rxdata_i;
    //----------------- Receive Ports - Pattern Checker Ports ------------------
    wire            gt1_rxprbserr_i;
    wire    [2:0]   gt1_rxprbssel_i;
    //----------------- Receive Ports - Pattern Checker ports ------------------
    wire            gt1_rxprbscntreset_i;
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    wire    [1:0]   gt1_rxdisperr_i;
    wire    [1:0]   gt1_rxnotintable_i;
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    wire            gt1_gthrxn_i;
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    wire            gt1_rxbufreset_i;
    wire    [2:0]   gt1_rxbufstatus_i;
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    wire            gt1_rxbyteisaligned_i;
    wire            gt1_rxbyterealign_i;
    wire            gt1_rxcommadet_i;
    wire            gt1_rxmcommaalignen_i;
    wire            gt1_rxpcommaalignen_i;
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    wire            gt1_rxdfelpmreset_i;
    wire    [6:0]   gt1_rxmonitorout_i;
    wire    [1:0]   gt1_rxmonitorsel_i;
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    wire            gt1_rxoutclk_i;
    wire            gt1_rxoutclkfabric_i;
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    wire            gt1_gtrxreset_i;
    wire            gt1_rxpcsreset_i;
    wire            gt1_rxpmareset_i;
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
    wire            gt1_rxlpmen_i;
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
    wire            gt1_rxpolarity_i;
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    wire    [1:0]   gt1_rxchariscomma_i;
    wire    [1:0]   gt1_rxcharisk_i;
    //---------------------- Receive Ports -RX AFE Ports -----------------------
    wire            gt1_gthrxp_i;
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    wire            gt1_rxresetdone_i;
    //---------------------- TX Configurable Driver Ports ----------------------
    wire    [4:0]   gt1_txpostcursor_i;
    wire    [4:0]   gt1_txprecursor_i;
    //------------------- TX Initialization and Reset Ports --------------------
    wire            gt1_gttxreset_i;
    wire            gt1_txuserrdy_i;
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    wire    [1:0]   gt1_txchardispmode_i;
    wire    [1:0]   gt1_txchardispval_i;
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
    wire            gt1_txprbsforceerr_i;
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
    wire    [1:0]   gt1_txbufstatus_i;
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    wire    [3:0]   gt1_txdiffctrl_i;
    wire    [6:0]   gt1_txmaincursor_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [15:0]  gt1_txdata_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire            gt1_gthtxn_i;
    wire            gt1_gthtxp_i;
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    wire            gt1_txoutclk_i;
    wire            gt1_txoutclkfabric_i;
    wire            gt1_txoutclkpcs_i;
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    wire            gt1_txpcsreset_i;
    wire            gt1_txpmareset_i;
    wire            gt1_txresetdone_i;
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
    wire            gt1_txpolarity_i;
    //---------------- Transmit Ports - pattern Generator Ports ----------------
    wire    [2:0]   gt1_txprbssel_i;
    //--------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    wire    [1:0]   gt1_txcharisk_i;

    //____________________________COMMON PORTS________________________________
    //-------------------- Common Block  - Ref Clock Ports ---------------------
    wire            gt0_gtrefclk1_common_i;
    //----------------------- Common Block - QPLL Ports ------------------------
    wire            gt0_qplllock_i;
    wire            gt0_qpllrefclklost_i;
    wire            gt0_qpllreset_i;


    //----------------------------- Global Signals -----------------------------

    wire            drpclk_in_i;
    wire            DRPCLK_IN;
    wire            gt0_tx_system_reset_c;
    wire            gt0_rx_system_reset_c;
    wire            gt1_tx_system_reset_c;
    wire            gt1_rx_system_reset_c;
    wire            tied_to_ground_i;
    wire    [63:0]  tied_to_ground_vec_i;
    wire            tied_to_vcc_i;
    wire    [7:0]   tied_to_vcc_vec_i;
    wire            GTTXRESET_IN;
    wire            GTRXRESET_IN;
    wire            CPLLRESET_IN;
    wire            QPLLRESET_IN;

     //--------------------------- User Clocks ---------------------------------
     wire            gt0_txusrclk_i; 
     wire            gt0_txusrclk2_i; 
     wire            gt0_rxusrclk_i; 
     wire            gt0_rxusrclk2_i; 
     wire            gt1_txusrclk_i; 
     wire            gt1_txusrclk2_i; 
     wire            gt1_rxusrclk_i; 
     wire            gt1_rxusrclk2_i; 
 
    //--------------------------- Reference Clocks ----------------------------
    wire            q5_clk0_refclk_i;

    //--------------------- Frame check/gen Module Signals --------------------
    wire            gt0_matchn_i;
    wire    [5:0]   gt0_txcharisk_float_i;
    wire    [15:0]  gt0_txdata_float16_i;
    wire    [47:0]  gt0_txdata_float_i;
    wire            gt0_block_sync_i;
    wire            gt0_track_data_i;
    wire    [7:0]   gt0_error_count_i;
    wire            gt0_frame_check_reset_i;
    wire            gt0_inc_in_i;
    wire            gt0_inc_out_i;
    wire    [15:0]  gt0_unscrambled_data_i;

    wire            gt1_matchn_i;
    wire    [5:0]   gt1_txcharisk_float_i;
    wire    [15:0]  gt1_txdata_float16_i;
    wire    [47:0]  gt1_txdata_float_i;
    wire            gt1_block_sync_i;
    wire            gt1_track_data_i;
    wire    [7:0]   gt1_error_count_i;
    wire            gt1_frame_check_reset_i;
    wire            gt1_inc_in_i;
    wire            gt1_inc_out_i;
    wire    [15:0]  gt1_unscrambled_data_i;

    wire            reset_on_data_error_i;
    wire            track_data_out_i;

    //--------------------- Chipscope Signals ---------------------------------

    wire    [35:0]  tx_data_vio_control_i;
    wire    [35:0]  rx_data_vio_control_i;
    wire    [35:0]  shared_vio_control_i;
    wire    [35:0]  ila_control_i;
    wire    [35:0]  channel_drp_vio_control_i;
    wire    [35:0]  common_drp_vio_control_i;
    wire    [31:0]  tx_data_vio_async_in_i;
    wire    [31:0]  tx_data_vio_sync_in_i;
    wire    [31:0]  tx_data_vio_async_out_i;
    wire    [31:0]  tx_data_vio_sync_out_i;
    wire    [31:0]  rx_data_vio_async_in_i;
    wire    [31:0]  rx_data_vio_sync_in_i;
    wire    [31:0]  rx_data_vio_async_out_i;
    wire    [31:0]  rx_data_vio_sync_out_i;
    wire    [31:0]  shared_vio_in_i;
    wire    [31:0]  shared_vio_out_i;
    wire    [163:0] ila_in_i;
    wire    [31:0]  channel_drp_vio_async_in_i;
    wire    [31:0]  channel_drp_vio_sync_in_i;
    wire    [31:0]  channel_drp_vio_async_out_i;
    wire    [31:0]  channel_drp_vio_sync_out_i;
    wire    [31:0]  common_drp_vio_async_in_i;
    wire    [31:0]  common_drp_vio_sync_in_i;
    wire    [31:0]  common_drp_vio_async_out_i;
    wire    [31:0]  common_drp_vio_sync_out_i;

    wire    [31:0]  gt0_tx_data_vio_async_in_i;
    wire    [31:0]  gt0_tx_data_vio_sync_in_i;
    wire    [31:0]  gt0_tx_data_vio_async_out_i;
    wire    [31:0]  gt0_tx_data_vio_sync_out_i;
    wire    [31:0]  gt0_rx_data_vio_async_in_i;
    wire    [31:0]  gt0_rx_data_vio_sync_in_i;
    wire    [31:0]  gt0_rx_data_vio_async_out_i;
    wire    [31:0]  gt0_rx_data_vio_sync_out_i;
    wire    [163:0] gt0_ila_in_i;
    wire    [31:0]  gt0_channel_drp_vio_async_in_i;
    wire    [31:0]  gt0_channel_drp_vio_sync_in_i;
    wire    [31:0]  gt0_channel_drp_vio_async_out_i;
    wire    [31:0]  gt0_channel_drp_vio_sync_out_i;
    wire    [31:0]  gt0_common_drp_vio_async_in_i;
    wire    [31:0]  gt0_common_drp_vio_sync_in_i;
    wire    [31:0]  gt0_common_drp_vio_async_out_i;
    wire    [31:0]  gt0_common_drp_vio_sync_out_i;

    wire    [31:0]  gt1_tx_data_vio_async_in_i;
    wire    [31:0]  gt1_tx_data_vio_sync_in_i;
    wire    [31:0]  gt1_tx_data_vio_async_out_i;
    wire    [31:0]  gt1_tx_data_vio_sync_out_i;
    wire    [31:0]  gt1_rx_data_vio_async_in_i;
    wire    [31:0]  gt1_rx_data_vio_sync_in_i;
    wire    [31:0]  gt1_rx_data_vio_async_out_i;
    wire    [31:0]  gt1_rx_data_vio_sync_out_i;
    wire    [163:0] gt1_ila_in_i;
    wire    [31:0]  gt1_channel_drp_vio_async_in_i;
    wire    [31:0]  gt1_channel_drp_vio_sync_in_i;
    wire    [31:0]  gt1_channel_drp_vio_async_out_i;
    wire    [31:0]  gt1_channel_drp_vio_sync_out_i;
    wire    [31:0]  gt1_common_drp_vio_async_in_i;
    wire    [31:0]  gt1_common_drp_vio_sync_in_i;
    wire    [31:0]  gt1_common_drp_vio_async_out_i;
    wire    [31:0]  gt1_common_drp_vio_sync_out_i;


    wire            gttxreset_i;
    wire            gtrxreset_i;
    wire            mux_sel_i;

    wire            user_tx_reset_i;
    wire            user_rx_reset_i;
    wire            tx_vio_clk_i;
    wire            tx_vio_clk_mux_out_i;    
    wire            rx_vio_ila_clk_i;
    wire            rx_vio_ila_clk_mux_out_i;

    wire            cpllreset_i;


  wire [(80 -16) -1:0] zero_vector_rx_80 ;
  wire [(8 -2) -1:0] zero_vector_rx_8 ;
  wire [79:0] gt0_rxdata_ila ;
  wire [1:0]  gt0_rxdatavalid_ila; 
  wire [7:0]  gt0_rxcharisk_ila ;
  wire gt0_txmmcm_lock_ila ;
  wire gt0_rxmmcm_lock_ila ;
  wire gt0_rxresetdone_ila ;
  wire gt0_txresetdone_ila ;
  wire [79:0] gt1_rxdata_ila ;
  wire [1:0]  gt1_rxdatavalid_ila; 
  wire [7:0]  gt1_rxcharisk_ila ;
  wire gt1_txmmcm_lock_ila ;
  wire gt1_rxmmcm_lock_ila ;
  wire gt1_rxresetdone_ila ;
  wire gt1_txresetdone_ila ;

//**************************** Main Body of Code *******************************

    //  Static signal Assigments    
    assign tied_to_ground_i      = 1'b0;
    assign tied_to_ground_vec_i  = 64'h0000000000000000;
    assign tied_to_vcc_i         = 1'b1;
    assign tied_to_vcc_vec_i     = 8'hff;

    assign zero_vector_rx_80 = 0;
    assign zero_vector_rx_8 = 0;

    
assign  q5_clk0_refclk_i                     =  1'b0;

    //***********************************************************************//
    //                                                                       //
    //--------------------------- The GT Wrapper ----------------------------//
    //                                                                       //
    //***********************************************************************//
    
    // Use the instantiation template in the example directory to add the GT wrapper to your design.
    // In this example, the wrapper is wired up for basic operation with a frame generator and frame 
    // checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is 
    // enabled, bonding should occur after alignment.
    // While connecting the GT TX/RX Reset ports below, please add a delay of
    // minimum 500ns as mentioned in AR 43482.

    
    GTH_support #
    (
        .EXAMPLE_SIM_GTRESET_SPEEDUP    (EXAMPLE_SIM_GTRESET_SPEEDUP),
        .STABLE_CLOCK_PERIOD            (STABLE_CLOCK_PERIOD)
    )
    GTH_support_i
    (
        .soft_reset_tx_in               (soft_reset_i),
        .soft_reset_rx_in               (soft_reset_i),
        .dont_reset_on_data_error_in    (tied_to_ground_i),
    .q5_clk0_gtrefclk_pad_n_in  (Q5_CLK0_GTREFCLK_PAD_N_IN),
    .q5_clk0_gtrefclk_pad_p_in  (Q5_CLK0_GTREFCLK_PAD_P_IN),
        .gt0_tx_fsm_reset_done_out      (gt0_txfsmresetdone_i),
        .gt0_rx_fsm_reset_done_out      (gt0_rxfsmresetdone_i),
        .gt0_data_valid_in              (gt0_track_data_i),
        .gt1_tx_fsm_reset_done_out      (gt1_txfsmresetdone_i),
        .gt1_rx_fsm_reset_done_out      (gt1_rxfsmresetdone_i),
        .gt1_data_valid_in              (gt1_track_data_i),
 
    .gt0_txusrclk_out(gt0_txusrclk_i),
    .gt0_txusrclk2_out(gt0_txusrclk2_i),
    .gt0_rxusrclk_out(gt0_rxusrclk_i),
    .gt0_rxusrclk2_out(gt0_rxusrclk2_i),
 
    .gt1_txusrclk_out(gt1_txusrclk_i),
    .gt1_txusrclk2_out(gt1_txusrclk2_i),
    .gt1_rxusrclk_out(gt1_rxusrclk_i),
    .gt1_rxusrclk2_out(gt1_rxusrclk2_i),


        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT0  (X1Y20)

        //------------------------------- CPLL Ports -------------------------------
        .gt0_cpllfbclklost_out          (gt0_cpllfbclklost_i),
        .gt0_cplllock_out               (gt0_cplllock_i),
        .gt0_cpllreset_in               (tied_to_ground_i),
        //-------------------------- Channel - DRP Ports  --------------------------
        .gt0_drpaddr_in                 (gt0_drpaddr_i),
        .gt0_drpdi_in                   (gt0_drpdi_i),
        .gt0_drpdo_out                  (gt0_drpdo_i),
        .gt0_drpen_in                   (gt0_drpen_i),
        .gt0_drprdy_out                 (gt0_drprdy_i),
        .gt0_drpwe_in                   (gt0_drpwe_i),
        //----------------------------- Loopback Ports -----------------------------
        .gt0_loopback_in                (gt0_loopback_i),
        //---------------------------- Power-Down Ports ----------------------------
        .gt0_rxpd_in                    (gt0_rxpd_i),
        .gt0_txpd_in                    (gt0_txpd_i),
        //------------------- RX Initialization and Reset Ports --------------------
        .gt0_eyescanreset_in            (tied_to_ground_i),
        .gt0_rxuserrdy_in               (tied_to_vcc_i),
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt0_eyescandataerror_out       (gt0_eyescandataerror_i),
        .gt0_eyescantrigger_in          (tied_to_ground_i),
        //----------------------- Receive Ports - CDR Ports ------------------------
        .gt0_rxcdrhold_in               (gt0_rxcdrhold_i),
        .gt0_rxcdrovrden_in             (tied_to_ground_i),
        //----------------- Receive Ports - Clock Correction Ports -----------------
        .gt0_rxclkcorcnt_out            (gt0_rxclkcorcnt_i),
        //----------------- Receive Ports - Digital Monitor Ports ------------------
        .gt0_dmonitorout_out            (gt0_dmonitorout_i),
        //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt0_rxdata_out                 (gt0_rxdata_i),
        //----------------- Receive Ports - Pattern Checker Ports ------------------
        .gt0_rxprbserr_out              (gt0_rxprbserr_i),
        .gt0_rxprbssel_in               (gt0_rxprbssel_i),
        //----------------- Receive Ports - Pattern Checker ports ------------------
        .gt0_rxprbscntreset_in          (gt0_rxprbscntreset_i),
        //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
        .gt0_rxdisperr_out              (gt0_rxdisperr_i),
        .gt0_rxnotintable_out           (gt0_rxnotintable_i),
        //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt0_gthrxn_in                  (RXN_IN[0]),
        //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
        .gt0_rxbufreset_in              (gt0_rxbufreset_i),
        .gt0_rxbufstatus_out            (gt0_rxbufstatus_i),
        //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
        .gt0_rxbyteisaligned_out        (gt0_rxbyteisaligned_i),
        .gt0_rxbyterealign_out          (gt0_rxbyterealign_i),
        .gt0_rxcommadet_out             (gt0_rxcommadet_i),
        .gt0_rxmcommaalignen_in         (gt0_rxmcommaalignen_i),
        .gt0_rxpcommaalignen_in         (gt0_rxpcommaalignen_i),
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt0_rxdfelpmreset_in           (tied_to_ground_i),
        .gt0_rxmonitorout_out           (gt0_rxmonitorout_i),
        .gt0_rxmonitorsel_in            (2'b00),
        //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt0_rxoutclkfabric_out         (gt0_rxoutclkfabric_i),
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt0_gtrxreset_in               (tied_to_ground_i),
        .gt0_rxpcsreset_in              (tied_to_ground_i),
        .gt0_rxpmareset_in              (gt0_rxpmareset_i),
        //---------------- Receive Ports - RX Margin Analysis ports ----------------
        .gt0_rxlpmen_in                 (gt0_rxlpmen_i),
        //--------------- Receive Ports - RX Polarity Control Ports ----------------
        .gt0_rxpolarity_in              (gt0_rxpolarity_i),
        //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        .gt0_rxchariscomma_out          (gt0_rxchariscomma_i),
        .gt0_rxcharisk_out              (gt0_rxcharisk_i),
        //---------------------- Receive Ports -RX AFE Ports -----------------------
        .gt0_gthrxp_in                  (RXP_IN[0]),
        //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt0_rxresetdone_out            (gt0_rxresetdone_i),
        //---------------------- TX Configurable Driver Ports ----------------------
        .gt0_txpostcursor_in            (gt0_txpostcursor_i),
        .gt0_txprecursor_in             (gt0_txprecursor_i),
        //------------------- TX Initialization and Reset Ports --------------------
        .gt0_gttxreset_in               (tied_to_ground_i),
        .gt0_txuserrdy_in               (tied_to_vcc_i),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .gt0_txchardispmode_in          (gt0_txchardispmode_i),
        .gt0_txchardispval_in           (gt0_txchardispval_i),
        //---------------- Transmit Ports - Pattern Generator Ports ----------------
        .gt0_txprbsforceerr_in          (gt0_txprbsforceerr_i),
        //-------------------- Transmit Ports - TX Buffer Ports --------------------
        .gt0_txbufstatus_out            (gt0_txbufstatus_i),
        //------------- Transmit Ports - TX Configurable Driver Ports --------------
        .gt0_txdiffctrl_in              (gt0_txdiffctrl_i),
        .gt0_txmaincursor_in            (7'b0000000),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt0_txdata_in                  (gt0_txdata_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt0_gthtxn_out                 (TXN_OUT[0]),
        .gt0_gthtxp_out                 (TXP_OUT[0]),
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt0_txoutclkfabric_out         (gt0_txoutclkfabric_i),
        .gt0_txoutclkpcs_out            (gt0_txoutclkpcs_i),
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt0_txpcsreset_in              (tied_to_ground_i),
        .gt0_txpmareset_in              (tied_to_ground_i),
        .gt0_txresetdone_out            (gt0_txresetdone_i),
        //--------------- Transmit Ports - TX Polarity Control Ports ---------------
        .gt0_txpolarity_in              (gt0_txpolarity_i),
        //---------------- Transmit Ports - pattern Generator Ports ----------------
        .gt0_txprbssel_in               (gt0_txprbssel_i),
        //--------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        .gt0_txcharisk_in               (gt0_txcharisk_i),


        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT1  (X1Y21)

        //------------------------------- CPLL Ports -------------------------------
        .gt1_cpllfbclklost_out          (gt1_cpllfbclklost_i),
        .gt1_cplllock_out               (gt1_cplllock_i),
        .gt1_cpllreset_in               (tied_to_ground_i),
        //-------------------------- Channel - DRP Ports  --------------------------
        .gt1_drpaddr_in                 (gt1_drpaddr_i),
        .gt1_drpdi_in                   (gt1_drpdi_i),
        .gt1_drpdo_out                  (gt1_drpdo_i),
        .gt1_drpen_in                   (gt1_drpen_i),
        .gt1_drprdy_out                 (gt1_drprdy_i),
        .gt1_drpwe_in                   (gt1_drpwe_i),
        //----------------------------- Loopback Ports -----------------------------
        .gt1_loopback_in                (gt1_loopback_i),
        //---------------------------- Power-Down Ports ----------------------------
        .gt1_rxpd_in                    (gt1_rxpd_i),
        .gt1_txpd_in                    (gt1_txpd_i),
        //------------------- RX Initialization and Reset Ports --------------------
        .gt1_eyescanreset_in            (tied_to_ground_i),
        .gt1_rxuserrdy_in               (tied_to_vcc_i),
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt1_eyescandataerror_out       (gt1_eyescandataerror_i),
        .gt1_eyescantrigger_in          (tied_to_ground_i),
        //----------------------- Receive Ports - CDR Ports ------------------------
        .gt1_rxcdrhold_in               (gt1_rxcdrhold_i),
        .gt1_rxcdrovrden_in             (tied_to_ground_i),
        //----------------- Receive Ports - Clock Correction Ports -----------------
        .gt1_rxclkcorcnt_out            (gt1_rxclkcorcnt_i),
        //----------------- Receive Ports - Digital Monitor Ports ------------------
        .gt1_dmonitorout_out            (gt1_dmonitorout_i),
        //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt1_rxdata_out                 (gt1_rxdata_i),
        //----------------- Receive Ports - Pattern Checker Ports ------------------
        .gt1_rxprbserr_out              (gt1_rxprbserr_i),
        .gt1_rxprbssel_in               (gt1_rxprbssel_i),
        //----------------- Receive Ports - Pattern Checker ports ------------------
        .gt1_rxprbscntreset_in          (gt1_rxprbscntreset_i),
        //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
        .gt1_rxdisperr_out              (gt1_rxdisperr_i),
        .gt1_rxnotintable_out           (gt1_rxnotintable_i),
        //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt1_gthrxn_in                  (RXN_IN[1]),
        //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
        .gt1_rxbufreset_in              (gt1_rxbufreset_i),
        .gt1_rxbufstatus_out            (gt1_rxbufstatus_i),
        //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
        .gt1_rxbyteisaligned_out        (gt1_rxbyteisaligned_i),
        .gt1_rxbyterealign_out          (gt1_rxbyterealign_i),
        .gt1_rxcommadet_out             (gt1_rxcommadet_i),
        .gt1_rxmcommaalignen_in         (gt1_rxmcommaalignen_i),
        .gt1_rxpcommaalignen_in         (gt1_rxpcommaalignen_i),
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt1_rxdfelpmreset_in           (tied_to_ground_i),
        .gt1_rxmonitorout_out           (gt1_rxmonitorout_i),
        .gt1_rxmonitorsel_in            (2'b00),
        //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt1_rxoutclkfabric_out         (gt1_rxoutclkfabric_i),
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt1_gtrxreset_in               (tied_to_ground_i),
        .gt1_rxpcsreset_in              (tied_to_ground_i),
        .gt1_rxpmareset_in              (gt1_rxpmareset_i),
        //---------------- Receive Ports - RX Margin Analysis ports ----------------
        .gt1_rxlpmen_in                 (gt1_rxlpmen_i),
        //--------------- Receive Ports - RX Polarity Control Ports ----------------
        .gt1_rxpolarity_in              (gt1_rxpolarity_i),
        //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        .gt1_rxchariscomma_out          (gt1_rxchariscomma_i),
        .gt1_rxcharisk_out              (gt1_rxcharisk_i),
        //---------------------- Receive Ports -RX AFE Ports -----------------------
        .gt1_gthrxp_in                  (RXP_IN[1]),
        //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt1_rxresetdone_out            (gt1_rxresetdone_i),
        //---------------------- TX Configurable Driver Ports ----------------------
        .gt1_txpostcursor_in            (gt1_txpostcursor_i),
        .gt1_txprecursor_in             (gt1_txprecursor_i),
        //------------------- TX Initialization and Reset Ports --------------------
        .gt1_gttxreset_in               (tied_to_ground_i),
        .gt1_txuserrdy_in               (tied_to_vcc_i),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .gt1_txchardispmode_in          (gt1_txchardispmode_i),
        .gt1_txchardispval_in           (gt1_txchardispval_i),
        //---------------- Transmit Ports - Pattern Generator Ports ----------------
        .gt1_txprbsforceerr_in          (gt1_txprbsforceerr_i),
        //-------------------- Transmit Ports - TX Buffer Ports --------------------
        .gt1_txbufstatus_out            (gt1_txbufstatus_i),
        //------------- Transmit Ports - TX Configurable Driver Ports --------------
        .gt1_txdiffctrl_in              (gt1_txdiffctrl_i),
        .gt1_txmaincursor_in            (7'b0000000),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt1_txdata_in                  (gt1_txdata_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt1_gthtxn_out                 (TXN_OUT[1]),
        .gt1_gthtxp_out                 (TXP_OUT[1]),
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt1_txoutclkfabric_out         (gt1_txoutclkfabric_i),
        .gt1_txoutclkpcs_out            (gt1_txoutclkpcs_i),
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt1_txpcsreset_in              (tied_to_ground_i),
        .gt1_txpmareset_in              (tied_to_ground_i),
        .gt1_txresetdone_out            (gt1_txresetdone_i),
        //--------------- Transmit Ports - TX Polarity Control Ports ---------------
        .gt1_txpolarity_in              (gt1_txpolarity_i),
        //---------------- Transmit Ports - pattern Generator Ports ----------------
        .gt1_txprbssel_in               (gt1_txprbssel_i),
        //--------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        .gt1_txcharisk_in               (gt1_txcharisk_i),


    //____________________________COMMON PORTS________________________________
    .gt0_qplloutclk_out(),
    .gt0_qplloutrefclk_out(),
    .sysclk_in(drpclk_in_i)
    );


    IBUFDS IBUFDS_DRP_CLK
     (
        .I  (DRP_CLK_IN_P),
        .IB (DRP_CLK_IN_N),
        .O  (DRPCLK_IN)
     );

    BUFG DRP_CLK_BUFG
    (
        .I                              (DRPCLK_IN),
        .O                              (drpclk_in_i) 
    );

    //***********************************************************************//
    //                                                                       //
    //--------------------------- User Module Resets-------------------------//
    //                                                                       //
    //***********************************************************************//
    // All the User Modules i.e. FRAME_GEN, FRAME_CHECK and the sync modules
    // are held in reset till the RESETDONE goes high. 
    // The RESETDONE is registered a couple of times on *USRCLK2 and connected 
    // to the reset of the modules
    
always @(posedge gt0_rxusrclk2_i or negedge gt0_rxresetdone_i)

    begin
        if (!gt0_rxresetdone_i)
        begin
            gt0_rxresetdone_r    <=   `DLY 1'b0;
            gt0_rxresetdone_r2   <=   `DLY 1'b0;
            gt0_rxresetdone_r3   <=   `DLY 1'b0;
        end
        else
        begin
            gt0_rxresetdone_r    <=   `DLY gt0_rxresetdone_i;
            gt0_rxresetdone_r2   <=   `DLY gt0_rxresetdone_r;
            gt0_rxresetdone_r3   <=   `DLY gt0_rxresetdone_r2;
        end
    end

always @(posedge  gt0_txusrclk2_i or negedge gt0_txfsmresetdone_i)
    begin
        if (!gt0_txfsmresetdone_i)
        begin
            gt0_txfsmresetdone_r    <=   `DLY 1'b0;
            gt0_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt0_txfsmresetdone_r    <=   `DLY gt0_txfsmresetdone_i;
            gt0_txfsmresetdone_r2   <=   `DLY gt0_txfsmresetdone_r;
        end
    end

always @(posedge gt1_rxusrclk2_i or negedge gt1_rxresetdone_i)

    begin
        if (!gt1_rxresetdone_i)
        begin
            gt1_rxresetdone_r    <=   `DLY 1'b0;
            gt1_rxresetdone_r2   <=   `DLY 1'b0;
            gt1_rxresetdone_r3   <=   `DLY 1'b0;
        end
        else
        begin
            gt1_rxresetdone_r    <=   `DLY gt1_rxresetdone_i;
            gt1_rxresetdone_r2   <=   `DLY gt1_rxresetdone_r;
            gt1_rxresetdone_r3   <=   `DLY gt1_rxresetdone_r2;
        end
    end

always @(posedge  gt1_txusrclk2_i or negedge gt1_txfsmresetdone_i)
    begin
        if (!gt1_txfsmresetdone_i)
        begin
            gt1_txfsmresetdone_r    <=   `DLY 1'b0;
            gt1_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt1_txfsmresetdone_r    <=   `DLY gt1_txfsmresetdone_i;
            gt1_txfsmresetdone_r2   <=   `DLY gt1_txfsmresetdone_r;
        end
    end



    assign TRACK_DATA_OUT = track_data_out_i;

    assign track_data_out_i = 
                                gt0_track_data_i &
                                gt1_track_data_i ;

//*** ʹ��GTH���ղ�����ֲ�����0�������


assign gt0_rxmcommaalignen_i = 1'b1;
assign gt0_rxpcommaalignen_i = 1'b1;
assign gt0_track_data_i = 1'b1 ;
assign gt1_rxmcommaalignen_i = 1'b1;
assign gt1_rxpcommaalignen_i = 1'b1;
assign gt1_track_data_i = 1'b1 ;










//-------------------------------------------------------------------------------------
//-------------------------Debug Signals assignment--------------------

//------------ optional Ports assignments --------------
assign  gt0_rxprbscntreset_i                 =  tied_to_ground_i;
assign  gt0_rxprbssel_i                      =  0;
assign  gt0_loopback_i                       =  0;

 
assign  gt0_txdiffctrl_i                     =  0;
assign  gt0_rxbufreset_i                     =  tied_to_ground_i;
assign  gt0_rxcdrhold_i                      =  tied_to_ground_i;
 //------GTH/GTP
assign  gt0_rxdfelpmreset_i                  =  tied_to_ground_i;
assign  gt0_rxpmareset_i                     =  tied_to_ground_i;
assign  gt0_rxpolarity_i                     =  tied_to_ground_i;
assign  gt0_rxpd_i                           =  0;
assign  gt0_txprecursor_i                    =  0;
assign  gt0_txpostcursor_i                   =  0;
assign  gt0_txmaincursor_i                   =  0;
assign  gt0_txchardispmode_i                 =  0;
assign  gt0_txchardispval_i                  =  0;
assign  gt0_txpolarity_i                     =  tied_to_ground_i;
assign  gt0_txpd_i                           =  0;
assign  gt0_txprbsforceerr_i                 =  tied_to_ground_i;
assign  gt0_txprbssel_i                      =  0;
assign  gt1_rxprbscntreset_i                 =  tied_to_ground_i;
assign  gt1_rxprbssel_i                      =  0;
assign  gt1_loopback_i                       =  0;

 
assign  gt1_txdiffctrl_i                     =  0;
assign  gt1_rxbufreset_i                     =  tied_to_ground_i;
assign  gt1_rxcdrhold_i                      =  tied_to_ground_i;
 //------GTH/GTP
assign  gt1_rxdfelpmreset_i                  =  tied_to_ground_i;
assign  gt1_rxpmareset_i                     =  tied_to_ground_i;
assign  gt1_rxpolarity_i                     =  tied_to_ground_i;
assign  gt1_rxpd_i                           =  0;
assign  gt1_txprecursor_i                    =  0;
assign  gt1_txpostcursor_i                   =  0;
assign  gt1_txmaincursor_i                   =  0;
assign  gt1_txchardispmode_i                 =  0;
assign  gt1_txchardispval_i                  =  0;
assign  gt1_txpolarity_i                     =  tied_to_ground_i;
assign  gt1_txpd_i                           =  0;
assign  gt1_txprbsforceerr_i                 =  tied_to_ground_i;
assign  gt1_txprbssel_i                      =  0;
//------------------------------------------------------

    assign  gt0_rxlpmen_i                        =  tied_to_vcc_i;
    assign  gt1_rxlpmen_i                        =  tied_to_vcc_i;


    // assign resets for frame_gen modules
    assign  gt0_tx_system_reset_c = !gt0_txfsmresetdone_r2;
    assign  gt1_tx_system_reset_c = !gt1_txfsmresetdone_r2;

    // assign resets for frame_check modules
    assign  gt0_rx_system_reset_c = !gt0_rxresetdone_r3;
    assign  gt1_rx_system_reset_c = !gt1_rxresetdone_r3;

//-------------------------------------------------------------

assign gt0_drpaddr_i = 9'd0;
assign gt0_drpdi_i = 16'd0;
assign gt0_drpen_i = 1'b0;
assign gt0_drpwe_i = 1'b0;
assign gt1_drpaddr_i = 9'd0;
assign gt1_drpdi_i = 16'd0;
assign gt1_drpen_i = 1'b0;
assign gt1_drpwe_i = 1'b0;

assign soft_reset_i = tied_to_ground_i;

/**************�ṩ���������źŸ� TX0��TX1 �����****************/
    cos_S1    S1
(
    // User Interface
    .TX_DATA_OUT                    ({gt0_txdata_float_i,gt0_txdata_i,gt0_txdata_float16_i}),
    .TXCTRL_OUT                     (gt0_txcharisk_i),

    // System Interface
    .USER_CLK                        (gt0_txusrclk2_i),
    .SYSTEM_RESET                   (rst_n)
);


    cos_S2    S2
    (
        // User Interface
        .TX_DATA_OUT                    ({gt1_txdata_float_i,gt1_txdata_i,gt1_txdata_float16_i}),
        .TXCTRL_OUT                     (gt1_txcharisk_i),

        // System Interface
        .USER_CLK                        (gt1_txusrclk2_i),
        .SYSTEM_RESET                   (rst_n)
    );

/******wire ����******/
  wire [15:0] S1_data_in ;
  wire [15:0] S2_data_in ;
  wire data_tvaild;
  wire [15:0] data_out_S1; 
  wire [1:0] charisk_S1;
  wire clk_phase ;
  
  wire [15:0] S1_data_out ;
  wire [15:0] S2_data_out ;
  wire [8:0] Number      ;
  wire [18:0] phase ;
  
  wire [15:0] S1_data_out_gtx;
  wire [15:0] S2_data_out_gtx;
  wire [1:0] charisk_S1_out ;
  wire [1:0] charisk_S2_out ;


FIFO_ctrl  UU0_Sdata_in
(
.clk(gt0_rxusrclk2_i),
.rst_n(~rst_n),
.data_in_1(gt0_rxdata_i),
.charisk_in_1(gt0_rxcharisk_i),

.data_in_2(gt1_rxdata_i),
.charisk_in_2(gt1_rxcharisk_i),

.S1_data(S1_data_in),
.S2_data(S2_data_in),
.data_vaild(data_tvaild),
.clk_phase(clk_phase)
);

phase_top UU1
(
.clk(clk_phase),
.rst_n(~rst_n),
.S1_data_in(S1_data_in),
.S2_data_in(S2_data_in),
.S1_data_tvaild(data_tvaild),
.S2_data_tvaild(data_tvaild),
.S1_data_out(S1_data_out),
.S2_data_out(S2_data_out),
.Number_w(Number),
.phase(phase)
);

FIFO_ctrl2 UU2_Sdata_out
(
.clk_wr(clk_phase),
.clk_rd(gt0_rxusrclk2_i),
.rst_n(~rst_n),
.Number(Number),
.data_in_1(S1_data_out),
.data_in_2(S2_data_out),
.data_out_1(S1_data_out_gtx),
.charisk_out_1(charisk_S1_out),
.data_out_2(S2_data_out_gtx),
.charisk_out_2(charisk_S2_out)
);

ila_0 ILA0 (
	.clk(clk_phase), // input wire clk
	.probe0(S1_data_in), // input wire [8:0]  probe0  
	.probe1(S2_data_in), // input wire [8:0]  probe1 
	.probe2(S1_data_out), // input wire [8:0]  probe2 
	.probe3(S2_data_out), // input wire [8:0]  probe3 
	.probe4(Number), // input wire [8:0]  probe4
    .probe5(phase) // input wire [18:0]  probe5
);

ila_1 ILA1 (
	.clk(gt0_rxusrclk2_i), // input wire clk
	.probe0(gt0_rxdata_i), // input wire [15:0]  probe0  
	.probe1(gt0_rxcharisk_i), // input wire [1:0]  probe1 
	.probe2(gt1_rxdata_i), // input wire [15:0]  probe0  
    .probe3(gt1_rxcharisk_i) // input wire [1:0]  probe1 
);

ila_2 ILA2 (
	.clk(gt0_txusrclk2_i), // input wire clk
	.probe0(gt0_txdata_i), // input wire [15:0]  probe0  
	.probe1(gt0_txcharisk_i), // input wire [1:0]  probe1
	.probe2(gt1_txdata_i), // input wire [15:0]  probe0  
    .probe3(gt1_txcharisk_i) // input wire [1:0]  probe1 
);

endmodule