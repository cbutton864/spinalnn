// Generator : SpinalHDL v1.14.0    git head : 95a5e6c65c54acfc4707c8fe6ef8b5d297cfcbde
// Component : SpinalNNTop
// Git hash  : 278c7f017903fe904da32d48f269d8647158584b

`timescale 1ns/1ps

module SpinalNNTop (
  input  wire          activation_in_valid,
  output reg           activation_in_ready,
  input  wire [7:0]    activation_in_data,
  output wire          activation_out_valid,
  input  wire          activation_out_ready,
  output wire [7:0]    activation_out_data,
  input  wire          clk,
  input  wire          reset
);

  reg        [7:0]    conv1_inputBuf_0_spinal_port0;
  reg        [7:0]    conv1_inputBuf_1_spinal_port0;
  reg        [7:0]    conv1_inputBuf_2_spinal_port0;
  reg        [7:0]    conv1_inputBuf_3_spinal_port0;
  reg        [7:0]    conv1_inputBuf_4_spinal_port0;
  reg        [3:0]    conv1_weightRom_spinal_port0;
  reg        [31:0]   conv1_biasRom_spinal_port0;
  reg        [7:0]    pool1_rowBuf_0_spinal_port0;
  reg        [7:0]    pool1_rowBuf_1_spinal_port0;
  reg        [63:0]   conv2_inputBuf_0_spinal_port0;
  reg        [63:0]   conv2_inputBuf_1_spinal_port0;
  reg        [63:0]   conv2_inputBuf_2_spinal_port0;
  reg        [63:0]   conv2_inputBuf_3_spinal_port0;
  reg        [63:0]   conv2_inputBuf_4_spinal_port0;
  reg        [31:0]   conv2_weightRom_spinal_port0;
  reg        [31:0]   conv2_biasRom_spinal_port0;
  reg        [7:0]    pool2_rowBuf_0_spinal_port0;
  reg        [7:0]    pool2_rowBuf_1_spinal_port0;
  reg        [7:0]    pool2_rowBuf_2_spinal_port0;
  reg        [7:0]    linear1_inputBuf_spinal_port0;
  reg        [7:0]    linear1_weightRom_spinal_port0;
  reg        [31:0]   linear1_biasRom_spinal_port0;
  wire       [5:0]    _zz_conv1_rxAddr;
  wire       [4:0]    _zz_conv1_inputBuf_0_port;
  wire                _zz_conv1_inputBuf_0_port_1;
  wire       [4:0]    _zz_conv1_rowWideReads_0_1;
  wire                _zz_conv1_rowWideReads_0_2;
  wire       [4:0]    _zz_conv1_inputBuf_1_port;
  wire                _zz_conv1_inputBuf_1_port_1;
  wire       [4:0]    _zz_conv1_rowWideReads_1_1;
  wire                _zz_conv1_rowWideReads_1_2;
  wire       [4:0]    _zz_conv1_inputBuf_2_port;
  wire                _zz_conv1_inputBuf_2_port_1;
  wire       [4:0]    _zz_conv1_rowWideReads_2_1;
  wire                _zz_conv1_rowWideReads_2_2;
  wire       [4:0]    _zz_conv1_inputBuf_3_port;
  wire                _zz_conv1_inputBuf_3_port_1;
  wire       [4:0]    _zz_conv1_rowWideReads_3_1;
  wire                _zz_conv1_rowWideReads_3_2;
  wire       [4:0]    _zz_conv1_inputBuf_4_port;
  wire                _zz_conv1_inputBuf_4_port_1;
  wire       [4:0]    _zz_conv1_rowWideReads_4_1;
  wire                _zz_conv1_rowWideReads_4_2;
  wire                _zz_conv1_weightRom_port;
  wire                _zz_conv1_wDataRaw_1;
  wire       [2:0]    _zz_conv1_biasRom_port;
  wire                _zz_conv1_biasRom_port_1;
  wire       [2:0]    _zz_conv1_biasVal_1;
  wire                _zz_conv1_biasVal_2;
  wire       [4:0]    _zz_conv1_inputBuf_0_port_2;
  wire       [5:0]    _zz_conv1_inputBuf_0_port_3;
  wire       [7:0]    _zz_conv1_inputBuf_0_port_4;
  wire                _zz_conv1_inputBuf_0_port_5;
  wire       [4:0]    _zz_conv1_inputBuf_1_port_2;
  wire       [5:0]    _zz_conv1_inputBuf_1_port_3;
  wire       [7:0]    _zz_conv1_inputBuf_1_port_4;
  wire                _zz_conv1_inputBuf_1_port_5;
  wire       [4:0]    _zz_conv1_inputBuf_2_port_2;
  wire       [5:0]    _zz_conv1_inputBuf_2_port_3;
  wire       [7:0]    _zz_conv1_inputBuf_2_port_4;
  wire                _zz_conv1_inputBuf_2_port_5;
  wire       [4:0]    _zz_conv1_inputBuf_3_port_2;
  wire       [5:0]    _zz_conv1_inputBuf_3_port_3;
  wire       [7:0]    _zz_conv1_inputBuf_3_port_4;
  wire                _zz_conv1_inputBuf_3_port_5;
  wire       [4:0]    _zz_conv1_inputBuf_4_port_2;
  wire       [5:0]    _zz_conv1_inputBuf_4_port_3;
  wire       [7:0]    _zz_conv1_inputBuf_4_port_4;
  wire                _zz_conv1_inputBuf_4_port_5;
  wire       [0:0]    _zz_conv1_rxBankReg;
  wire       [2:0]    _zz_conv1_rowWrPtrReg;
  wire       [8:0]    _zz_conv1_wAddrReg;
  wire       [3:0]    _zz__zz_conv1_curSlotReg;
  wire       [3:0]    _zz__zz_conv1_curSlotReg_1;
  wire       [2:0]    _zz_conv1_curSlotReg_1;
  wire       [3:0]    _zz_conv1_curSlotReg_2;
  wire       [2:0]    _zz_conv1_curSlotReg_3;
  reg        [7:0]    _zz_conv1_inValReg_0;
  wire       [8:0]    _zz__zz_conv1_lutProdReg_0_1;
  wire       [8:0]    _zz__zz_conv1_lutProdReg_0_1_1;
  wire       [31:0]   _zz_conv1_lutProdReg_0_2;
  wire       [31:0]   _zz_conv1_lutProdReg_0_3;
  wire       [31:0]   _zz_conv1_lutProdReg_0_4;
  wire       [31:0]   _zz_conv1_lutProdReg_0_5;
  wire       [31:0]   _zz_conv1_lutProdReg_0_6;
  wire       [32:0]   _zz_conv1_lutProdReg_0_7;
  wire       [31:0]   _zz_conv1_lutProdReg_0_8;
  wire       [31:0]   _zz_conv1_lutProdReg_0_9;
  wire       [33:0]   _zz_conv1_lutProdReg_0_10;
  wire       [31:0]   _zz_conv1_lutProdReg_0_11;
  wire       [31:0]   _zz_conv1_lutProdReg_0_12;
  wire       [34:0]   _zz_conv1_lutProdReg_0_13;
  wire       [34:0]   _zz_conv1_lutProdReg_0_14;
  wire       [31:0]   _zz_conv1_rqReg_6;
  wire       [31:0]   _zz_conv1_rqReg_6_1;
  wire       [32:0]   _zz_conv1_rqReg_11;
  wire       [32:0]   _zz_conv1_rqReg_11_1;
  wire       [63:0]   _zz_conv1_rqReg_14;
  wire       [63:0]   _zz_conv1_rqReg_14_1;
  wire       [79:0]   _zz_conv1_rqReg_14_2;
  wire       [63:0]   _zz_conv1_rqReg_14_3;
  wire       [95:0]   _zz_conv1_rqReg_15;
  wire       [63:0]   _zz_conv1_rqReg_15_1;
  wire       [63:0]   _zz_conv1_rqReg_4_1;
  wire       [63:0]   _zz_conv1_rqReg_4_2;
  wire       [63:0]   _zz_conv1_rqReg_4_3;
  wire       [31:0]   _zz__zz_conv1_rqReg_2;
  wire       [28:0]   _zz__zz_conv1_rqReg_2_1;
  wire       [7:0]    _zz_conv1_rqReg_2_1;
  wire       [7:0]    _zz_conv1_rqReg_2_2;
  wire       [3:0]    _zz_conv1_outChReg;
  wire       [4:0]    _zz_conv1_outColReg;
  wire       [4:0]    _zz_conv1_outRowReg;
  wire       [7:0]    _zz_relu1_activationOut_payload_value;
  wire                _zz_pool1_rowBuf_0_port;
  wire                _zz_pool1_rowReads_0_1;
  wire                _zz_pool1_rowBuf_1_port;
  wire                _zz_pool1_rowReads_1_1;
  reg        [7:0]    _zz_pool1_readData;
  wire       [7:0]    _zz_pool1_rowBuf_0_port_1;
  wire                _zz_pool1_rowBuf_0_port_2;
  wire       [7:0]    _zz_pool1_rowBuf_1_port_1;
  wire                _zz_pool1_rowBuf_1_port_2;
  wire       [7:0]    _zz_pool1_rxStepReg;
  wire       [0:0]    _zz_pool1_rowWrPtrReg;
  wire       [9:0]    _zz_pool1_rowAddrComb;
  wire       [9:0]    _zz_pool1_rowAddrComb_1;
  wire       [5:0]    _zz_pool1_rowAddrComb_2;
  wire       [5:0]    _zz_pool1_rowAddrComb_3;
  wire       [5:0]    _zz_pool1_rowAddrComb_4;
  wire       [3:0]    _zz_pool1_rowAddrComb_5;
  wire       [9:0]    _zz_pool1_rowAddrComb_6;
  wire       [7:0]    _zz_pool1_rowAddrComb_7;
  wire       [2:0]    _zz__zz_pool1_curSlotReg;
  wire       [2:0]    _zz__zz_pool1_curSlotReg_1;
  wire       [0:0]    _zz__zz_pool1_curSlotReg_2;
  wire       [0:0]    _zz_pool1_curSlotReg_1;
  wire       [2:0]    _zz_pool1_curSlotReg_2;
  wire       [0:0]    _zz_pool1_curSlotReg_3;
  wire       [1:0]    _zz_pool1_kcReg;
  wire       [3:0]    _zz_pool1_outChReg;
  wire       [3:0]    _zz_pool1_outColReg;
  wire       [3:0]    _zz_pool1_outRowReg;
  wire       [4:0]    _zz_conv2_rxAddr;
  wire                _zz_conv2_inputBuf_0_port;
  wire                _zz_conv2_rowWideReads_0_1;
  wire                _zz_conv2_inputBuf_1_port;
  wire                _zz_conv2_rowWideReads_1_1;
  wire                _zz_conv2_inputBuf_2_port;
  wire                _zz_conv2_rowWideReads_2_1;
  wire                _zz_conv2_inputBuf_3_port;
  wire                _zz_conv2_rowWideReads_3_1;
  wire                _zz_conv2_inputBuf_4_port;
  wire                _zz_conv2_rowWideReads_4_1;
  wire                _zz_conv2_weightRom_port;
  wire                _zz_conv2_wDataRaw_1;
  wire       [3:0]    _zz_conv2_biasRom_port;
  wire                _zz_conv2_biasRom_port_1;
  wire       [3:0]    _zz_conv2_biasVal_1;
  wire                _zz_conv2_biasVal_2;
  wire       [4:0]    _zz_conv2_inputBuf_0_port_1;
  wire       [63:0]   _zz_conv2_inputBuf_0_port_2;
  wire                _zz_conv2_inputBuf_0_port_3;
  wire       [4:0]    _zz_conv2_inputBuf_1_port_1;
  wire       [63:0]   _zz_conv2_inputBuf_1_port_2;
  wire                _zz_conv2_inputBuf_1_port_3;
  wire       [4:0]    _zz_conv2_inputBuf_2_port_1;
  wire       [63:0]   _zz_conv2_inputBuf_2_port_2;
  wire                _zz_conv2_inputBuf_2_port_3;
  wire       [4:0]    _zz_conv2_inputBuf_3_port_1;
  wire       [63:0]   _zz_conv2_inputBuf_3_port_2;
  wire                _zz_conv2_inputBuf_3_port_3;
  wire       [4:0]    _zz_conv2_inputBuf_4_port_1;
  wire       [63:0]   _zz_conv2_inputBuf_4_port_2;
  wire                _zz_conv2_inputBuf_4_port_3;
  wire       [3:0]    _zz_conv2_rxBankReg;
  wire       [2:0]    _zz_conv2_rowWrPtrReg;
  wire       [9:0]    _zz_conv2_wAddrReg;
  wire       [3:0]    _zz__zz_conv2_curSlotReg;
  wire       [3:0]    _zz__zz_conv2_curSlotReg_1;
  wire       [2:0]    _zz_conv2_curSlotReg_1;
  wire       [3:0]    _zz_conv2_curSlotReg_2;
  wire       [2:0]    _zz_conv2_curSlotReg_3;
  reg        [7:0]    _zz_conv2_inValReg_0;
  reg        [7:0]    _zz_conv2_inValReg_1;
  reg        [7:0]    _zz_conv2_inValReg_2;
  reg        [7:0]    _zz_conv2_inValReg_3;
  reg        [7:0]    _zz_conv2_inValReg_4;
  reg        [7:0]    _zz_conv2_inValReg_5;
  reg        [7:0]    _zz_conv2_inValReg_6;
  reg        [7:0]    _zz_conv2_inValReg_7;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_0_2;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_0_2_1;
  wire       [31:0]   _zz_conv2_lutProdReg_0_3;
  wire       [31:0]   _zz_conv2_lutProdReg_0_4;
  wire       [31:0]   _zz_conv2_lutProdReg_0_5;
  wire       [31:0]   _zz_conv2_lutProdReg_0_6;
  wire       [31:0]   _zz_conv2_lutProdReg_0_7;
  wire       [32:0]   _zz_conv2_lutProdReg_0_8;
  wire       [31:0]   _zz_conv2_lutProdReg_0_9;
  wire       [31:0]   _zz_conv2_lutProdReg_0_10;
  wire       [33:0]   _zz_conv2_lutProdReg_0_11;
  wire       [31:0]   _zz_conv2_lutProdReg_0_12;
  wire       [31:0]   _zz_conv2_lutProdReg_0_13;
  wire       [34:0]   _zz_conv2_lutProdReg_0_14;
  wire       [34:0]   _zz_conv2_lutProdReg_0_15;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_1_1;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_1_1_1;
  wire       [31:0]   _zz_conv2_lutProdReg_1_2;
  wire       [31:0]   _zz_conv2_lutProdReg_1_3;
  wire       [31:0]   _zz_conv2_lutProdReg_1_4;
  wire       [31:0]   _zz_conv2_lutProdReg_1_5;
  wire       [31:0]   _zz_conv2_lutProdReg_1_6;
  wire       [32:0]   _zz_conv2_lutProdReg_1_7;
  wire       [31:0]   _zz_conv2_lutProdReg_1_8;
  wire       [31:0]   _zz_conv2_lutProdReg_1_9;
  wire       [33:0]   _zz_conv2_lutProdReg_1_10;
  wire       [31:0]   _zz_conv2_lutProdReg_1_11;
  wire       [31:0]   _zz_conv2_lutProdReg_1_12;
  wire       [34:0]   _zz_conv2_lutProdReg_1_13;
  wire       [34:0]   _zz_conv2_lutProdReg_1_14;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_2_1;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_2_1_1;
  wire       [31:0]   _zz_conv2_lutProdReg_2_2;
  wire       [31:0]   _zz_conv2_lutProdReg_2_3;
  wire       [31:0]   _zz_conv2_lutProdReg_2_4;
  wire       [31:0]   _zz_conv2_lutProdReg_2_5;
  wire       [31:0]   _zz_conv2_lutProdReg_2_6;
  wire       [32:0]   _zz_conv2_lutProdReg_2_7;
  wire       [31:0]   _zz_conv2_lutProdReg_2_8;
  wire       [31:0]   _zz_conv2_lutProdReg_2_9;
  wire       [33:0]   _zz_conv2_lutProdReg_2_10;
  wire       [31:0]   _zz_conv2_lutProdReg_2_11;
  wire       [31:0]   _zz_conv2_lutProdReg_2_12;
  wire       [34:0]   _zz_conv2_lutProdReg_2_13;
  wire       [34:0]   _zz_conv2_lutProdReg_2_14;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_3_1;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_3_1_1;
  wire       [31:0]   _zz_conv2_lutProdReg_3_2;
  wire       [31:0]   _zz_conv2_lutProdReg_3_3;
  wire       [31:0]   _zz_conv2_lutProdReg_3_4;
  wire       [31:0]   _zz_conv2_lutProdReg_3_5;
  wire       [31:0]   _zz_conv2_lutProdReg_3_6;
  wire       [32:0]   _zz_conv2_lutProdReg_3_7;
  wire       [31:0]   _zz_conv2_lutProdReg_3_8;
  wire       [31:0]   _zz_conv2_lutProdReg_3_9;
  wire       [33:0]   _zz_conv2_lutProdReg_3_10;
  wire       [31:0]   _zz_conv2_lutProdReg_3_11;
  wire       [31:0]   _zz_conv2_lutProdReg_3_12;
  wire       [34:0]   _zz_conv2_lutProdReg_3_13;
  wire       [34:0]   _zz_conv2_lutProdReg_3_14;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_4_1;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_4_1_1;
  wire       [31:0]   _zz_conv2_lutProdReg_4_2;
  wire       [31:0]   _zz_conv2_lutProdReg_4_3;
  wire       [31:0]   _zz_conv2_lutProdReg_4_4;
  wire       [31:0]   _zz_conv2_lutProdReg_4_5;
  wire       [31:0]   _zz_conv2_lutProdReg_4_6;
  wire       [32:0]   _zz_conv2_lutProdReg_4_7;
  wire       [31:0]   _zz_conv2_lutProdReg_4_8;
  wire       [31:0]   _zz_conv2_lutProdReg_4_9;
  wire       [33:0]   _zz_conv2_lutProdReg_4_10;
  wire       [31:0]   _zz_conv2_lutProdReg_4_11;
  wire       [31:0]   _zz_conv2_lutProdReg_4_12;
  wire       [34:0]   _zz_conv2_lutProdReg_4_13;
  wire       [34:0]   _zz_conv2_lutProdReg_4_14;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_5_1;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_5_1_1;
  wire       [31:0]   _zz_conv2_lutProdReg_5_2;
  wire       [31:0]   _zz_conv2_lutProdReg_5_3;
  wire       [31:0]   _zz_conv2_lutProdReg_5_4;
  wire       [31:0]   _zz_conv2_lutProdReg_5_5;
  wire       [31:0]   _zz_conv2_lutProdReg_5_6;
  wire       [32:0]   _zz_conv2_lutProdReg_5_7;
  wire       [31:0]   _zz_conv2_lutProdReg_5_8;
  wire       [31:0]   _zz_conv2_lutProdReg_5_9;
  wire       [33:0]   _zz_conv2_lutProdReg_5_10;
  wire       [31:0]   _zz_conv2_lutProdReg_5_11;
  wire       [31:0]   _zz_conv2_lutProdReg_5_12;
  wire       [34:0]   _zz_conv2_lutProdReg_5_13;
  wire       [34:0]   _zz_conv2_lutProdReg_5_14;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_6_1;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_6_1_1;
  wire       [31:0]   _zz_conv2_lutProdReg_6_2;
  wire       [31:0]   _zz_conv2_lutProdReg_6_3;
  wire       [31:0]   _zz_conv2_lutProdReg_6_4;
  wire       [31:0]   _zz_conv2_lutProdReg_6_5;
  wire       [31:0]   _zz_conv2_lutProdReg_6_6;
  wire       [32:0]   _zz_conv2_lutProdReg_6_7;
  wire       [31:0]   _zz_conv2_lutProdReg_6_8;
  wire       [31:0]   _zz_conv2_lutProdReg_6_9;
  wire       [33:0]   _zz_conv2_lutProdReg_6_10;
  wire       [31:0]   _zz_conv2_lutProdReg_6_11;
  wire       [31:0]   _zz_conv2_lutProdReg_6_12;
  wire       [34:0]   _zz_conv2_lutProdReg_6_13;
  wire       [34:0]   _zz_conv2_lutProdReg_6_14;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_7_1;
  wire       [8:0]    _zz__zz_conv2_lutProdReg_7_1_1;
  wire       [31:0]   _zz_conv2_lutProdReg_7_2;
  wire       [31:0]   _zz_conv2_lutProdReg_7_3;
  wire       [31:0]   _zz_conv2_lutProdReg_7_4;
  wire       [31:0]   _zz_conv2_lutProdReg_7_5;
  wire       [31:0]   _zz_conv2_lutProdReg_7_6;
  wire       [32:0]   _zz_conv2_lutProdReg_7_7;
  wire       [31:0]   _zz_conv2_lutProdReg_7_8;
  wire       [31:0]   _zz_conv2_lutProdReg_7_9;
  wire       [33:0]   _zz_conv2_lutProdReg_7_10;
  wire       [31:0]   _zz_conv2_lutProdReg_7_11;
  wire       [31:0]   _zz_conv2_lutProdReg_7_12;
  wire       [34:0]   _zz_conv2_lutProdReg_7_13;
  wire       [34:0]   _zz_conv2_lutProdReg_7_14;
  wire       [31:0]   _zz_conv2_rqReg_1;
  wire       [31:0]   _zz_conv2_rqReg_1_1;
  wire       [31:0]   _zz_conv2_rqReg_1_2;
  wire       [31:0]   _zz_conv2_rqReg_1_3;
  wire       [31:0]   _zz_conv2_rqReg_1_4;
  wire       [31:0]   _zz_conv2_rqReg_1_5;
  wire       [31:0]   _zz_conv2_rqReg_6;
  wire       [31:0]   _zz_conv2_rqReg_6_1;
  wire       [32:0]   _zz_conv2_rqReg_11;
  wire       [32:0]   _zz_conv2_rqReg_11_1;
  wire       [63:0]   _zz_conv2_rqReg_14;
  wire       [63:0]   _zz_conv2_rqReg_14_1;
  wire       [79:0]   _zz_conv2_rqReg_14_2;
  wire       [63:0]   _zz_conv2_rqReg_14_3;
  wire       [95:0]   _zz_conv2_rqReg_15;
  wire       [63:0]   _zz_conv2_rqReg_15_1;
  wire       [63:0]   _zz_conv2_rqReg_4_1;
  wire       [63:0]   _zz_conv2_rqReg_4_2;
  wire       [63:0]   _zz_conv2_rqReg_4_3;
  wire       [31:0]   _zz__zz_conv2_rqReg_2;
  wire       [28:0]   _zz__zz_conv2_rqReg_2_1;
  wire       [7:0]    _zz_conv2_rqReg_2_1;
  wire       [7:0]    _zz_conv2_rqReg_2_2;
  wire       [4:0]    _zz_conv2_outChReg;
  wire       [3:0]    _zz_conv2_outColReg;
  wire       [3:0]    _zz_conv2_outRowReg;
  wire       [7:0]    _zz_relu2_activationOut_payload_value;
  wire                _zz_pool2_rowBuf_0_port;
  wire                _zz_pool2_rowReads_0_1;
  wire                _zz_pool2_rowBuf_1_port;
  wire                _zz_pool2_rowReads_1_1;
  wire                _zz_pool2_rowBuf_2_port;
  wire                _zz_pool2_rowReads_2_1;
  reg        [7:0]    _zz_pool2_readData;
  wire       [7:0]    _zz_pool2_rowBuf_0_port_1;
  wire                _zz_pool2_rowBuf_0_port_2;
  wire       [7:0]    _zz_pool2_rowBuf_1_port_1;
  wire                _zz_pool2_rowBuf_1_port_2;
  wire       [7:0]    _zz_pool2_rowBuf_2_port_1;
  wire                _zz_pool2_rowBuf_2_port_2;
  wire       [7:0]    _zz_pool2_rxStepReg;
  wire       [1:0]    _zz_pool2_rowWrPtrReg;
  wire       [9:0]    _zz_pool2_rowAddrComb;
  wire       [9:0]    _zz_pool2_rowAddrComb_1;
  wire       [4:0]    _zz_pool2_rowAddrComb_2;
  wire       [4:0]    _zz_pool2_rowAddrComb_3;
  wire       [4:0]    _zz_pool2_rowAddrComb_4;
  wire       [2:0]    _zz_pool2_rowAddrComb_5;
  wire       [9:0]    _zz_pool2_rowAddrComb_6;
  wire       [7:0]    _zz_pool2_rowAddrComb_7;
  wire       [2:0]    _zz__zz_pool2_curSlotReg;
  wire       [2:0]    _zz__zz_pool2_curSlotReg_1;
  wire       [1:0]    _zz_pool2_curSlotReg_1;
  wire       [2:0]    _zz_pool2_curSlotReg_2;
  wire       [1:0]    _zz_pool2_curSlotReg_3;
  wire       [1:0]    _zz_pool2_kcReg;
  wire       [4:0]    _zz_pool2_outChReg;
  wire       [2:0]    _zz_pool2_outColReg;
  wire       [2:0]    _zz_pool2_outRowReg;
  wire                _zz_linear1_inputBuf_port;
  wire                _zz_linear1_inValR;
  wire                _zz_linear1_weightRom_port;
  wire                _zz_linear1_wValR;
  wire                _zz_linear1_biasRom_port;
  wire                _zz_linear1_biasVal_1;
  wire       [7:0]    _zz_linear1_inputBuf_port_1;
  wire       [7:0]    _zz_linear1_inputBuf_port_2;
  wire       [12:0]   _zz_linear1_wAddrComb;
  wire       [12:0]   _zz_linear1_wAddrComb_1;
  wire       [12:0]   _zz_linear1_wAddrComb_2;
  wire       [17:0]   _zz_linear1_prodReg;
  wire       [8:0]    _zz_linear1_prodReg_1;
  wire       [8:0]    _zz_linear1_prodReg_2;
  wire       [8:0]    _zz_linear1_prodReg_3;
  wire       [8:0]    _zz_linear1_prodReg_4;
  wire       [31:0]   _zz_linear1_absAReg;
  wire       [31:0]   _zz_linear1_absAReg_1;
  wire       [32:0]   _zz_linear1_pSumReg;
  wire       [32:0]   _zz_linear1_pSumReg_1;
  wire       [63:0]   _zz_linear1_part1Reg;
  wire       [63:0]   _zz_linear1_part1Reg_1;
  wire       [79:0]   _zz_linear1_part1Reg_2;
  wire       [63:0]   _zz_linear1_part1Reg_3;
  wire       [95:0]   _zz_linear1_part2Reg;
  wire       [63:0]   _zz_linear1_part2Reg_1;
  wire       [63:0]   _zz_linear1_reqProdReg2_1;
  wire       [63:0]   _zz_linear1_reqProdReg2_2;
  wire       [63:0]   _zz_linear1_reqProdReg2_3;
  wire       [31:0]   _zz__zz_linear1_resultReg;
  wire       [25:0]   _zz__zz_linear1_resultReg_1;
  wire       [7:0]    _zz_linear1_resultReg_1;
  wire       [7:0]    _zz_linear1_resultReg_2;
  wire       [3:0]    _zz_linear1_outNeurReg;
  wire       [7:0]    _zz_softmax_activationOut_payload_value;
  wire       [7:0]    _zz_softmax_activationOut_payload_value_1;
  reg                 _zz_1;
  wire                QLinearConvLineCorePlugin_logic_outStream_valid;
  wire                QLinearConvLineCorePlugin_logic_outStream_ready;
  wire       [7:0]    QLinearConvLineCorePlugin_logic_outStream_payload_value;
  wire       [7:0]    conv1_zpWideBits;
  reg                 conv1_activationOut_valid;
  wire                conv1_activationOut_ready;
  reg        [7:0]    conv1_activationOut_payload_value;
  wire       [3:0]    conv1_sReceiveRow;
  wire       [3:0]    conv1_sLoadBias;
  wire       [3:0]    conv1_sWaitBias;
  wire       [3:0]    conv1_sCompute;
  wire       [3:0]    conv1_sRequant;
  wire       [3:0]    conv1_sRequantMul;
  wire       [3:0]    conv1_sRequantWait;
  wire       [3:0]    conv1_sRequantWait2;
  wire       [3:0]    conv1_sRequantWait3;
  wire       [3:0]    conv1_sRequantShift;
  wire       [3:0]    conv1_sEmit;
  wire       [3:0]    conv1_sInit;
  wire       [3:0]    conv1_sLoadWeights;
  reg        [3:0]    conv1_stateReg;
  reg        [2:0]    conv1_rowWrPtrReg;
  reg        [2:0]    conv1_rowsUntilComputeReg;
  reg        [4:0]    conv1_realRowsRecvReg;
  reg        [0:0]    conv1_rxBankReg;
  reg        [4:0]    conv1_rxWordReg;
  reg        [2:0]    conv1_initSlotReg;
  reg        [5:0]    conv1_initAddrReg;
  reg        [4:0]    conv1_outRowReg;
  reg        [4:0]    conv1_outColReg;
  reg        [3:0]    conv1_outChReg;
  reg        [2:0]    conv1_khCntReg;
  reg        [2:0]    conv1_rowStepReg;
  reg        [4:0]    conv1_compCycleReg;
  reg        [5:0]    conv1_rowAddrBaseReg;
  reg        [5:0]    conv1_rowAddrReg;
  reg        [7:0]    conv1_wAddrReg;
  wire       [5:0]    conv1_rowAddrComb;
  wire       [7:0]    conv1_wAddrComb;
  wire       [5:0]    conv1_rxAddr;
  wire       [5:0]    _zz_conv1_rowWideReads_0;
  wire       [7:0]    conv1_rowWideReads_0;
  wire       [5:0]    _zz_conv1_rowWideReads_1;
  wire       [7:0]    conv1_rowWideReads_1;
  wire       [5:0]    _zz_conv1_rowWideReads_2;
  wire       [7:0]    conv1_rowWideReads_2;
  wire       [5:0]    _zz_conv1_rowWideReads_3;
  wire       [7:0]    conv1_rowWideReads_3;
  wire       [5:0]    _zz_conv1_rowWideReads_4;
  wire       [7:0]    conv1_rowWideReads_4;
  wire       [7:0]    conv1_rowReads2D_0_0;
  wire       [7:0]    conv1_rowReads2D_1_0;
  wire       [7:0]    conv1_rowReads2D_2_0;
  wire       [7:0]    conv1_rowReads2D_3_0;
  wire       [7:0]    conv1_rowReads2D_4_0;
  wire       [7:0]    _zz_conv1_wDataRaw;
  wire       [3:0]    conv1_wDataRaw;
  wire       [3:0]    conv1_wValsRaw_0;
  wire       [3:0]    _zz_conv1_biasVal;
  wire       [31:0]   conv1_biasVal;
  reg        [2:0]    conv1_curSlotReg;
  reg        [7:0]    conv1_inValReg_0;
  reg        [3:0]    conv1_wValReg_0;
  reg        [31:0]   conv1_lutProdReg_0;
  reg        [31:0]   conv1_rqReg_0;
  reg        [31:0]   conv1_rqReg_1;
  reg        [7:0]    conv1_rqReg_2;
  reg        [31:0]   conv1_rqReg_3;
  reg        [63:0]   conv1_rqReg_4;
  reg                 conv1_rqReg_5;
  reg        [31:0]   conv1_rqReg_6;
  reg        [31:0]   conv1_rqReg_7;
  reg        [31:0]   conv1_rqReg_8;
  reg        [31:0]   conv1_rqReg_9;
  reg        [31:0]   conv1_rqReg_10;
  reg        [32:0]   conv1_rqReg_11;
  reg        [31:0]   conv1_rqReg_12;
  reg        [31:0]   conv1_rqReg_13;
  reg        [63:0]   conv1_rqReg_14;
  reg        [63:0]   conv1_rqReg_15;
  wire                conv1_isReal;
  reg        [7:0]    conv1_rxByteRegs_0;
  wire                io_activationIn_fire;
  wire                when_QLinearConvLineCore_l371;
  wire       [7:0]    conv1_recvDataSeq_0;
  wire       [7:0]    conv1_recvData;
  wire                _zz_9;
  wire                _zz_10;
  wire                _zz_11;
  wire                _zz_12;
  wire                _zz_14;
  wire                _zz_15;
  wire                _zz_16;
  wire                _zz_17;
  wire                _zz_19;
  wire                _zz_20;
  wire                _zz_21;
  wire                _zz_22;
  wire                _zz_24;
  wire                _zz_25;
  wire                _zz_26;
  wire                _zz_27;
  wire                _zz_29;
  wire                _zz_30;
  wire                _zz_31;
  wire                _zz_32;
  wire                when_QLinearConvLineCore_l407;
  wire                when_QLinearConvLineCore_l409;
  wire                when_QLinearConvLineCore_l412;
  wire                when_QLinearConvLineCore_l431;
  wire                when_QLinearConvLineCore_l435;
  wire                when_QLinearConvLineCore_l438;
  wire                when_QLinearConvLineCore_l443;
  wire                when_QLinearConvLineCore_l449;
  wire                when_QLinearConvLineCore_l492;
  wire       [5:0]    _zz_conv1_rowAddrBaseReg;
  wire                when_QLinearConvLineCore_l505;
  wire                when_QLinearConvLineCore_l532;
  wire                when_QLinearConvLineCore_l536;
  wire       [3:0]    _zz_conv1_curSlotReg;
  wire                when_QLinearConvLineCore_l540;
  wire                when_QLinearConvLineCore_l551;
  wire                when_QLinearConvLineCore_l564;
  wire       [3:0]    _zz_conv1_lutProdReg_0;
  wire       [31:0]   _zz_conv1_lutProdReg_0_1;
  wire                when_QLinearConvLineCore_l579;
  wire                when_QLinearConvLineCore_l584;
  wire       [31:0]   _zz_conv1_rqReg_0;
  wire                when_QLinearConvLineCore_l587;
  wire                when_QLinearConvLineCore_l621;
  wire                when_QLinearConvLineCore_l627;
  wire       [31:0]   _zz_conv1_rqReg_7;
  wire       [15:0]   _zz_conv1_rqReg_9;
  wire       [15:0]   _zz_conv1_rqReg_7_1;
  wire       [15:0]   _zz_conv1_rqReg_8;
  wire       [15:0]   _zz_conv1_rqReg_7_2;
  wire                when_QLinearConvLineCore_l639;
  wire                when_QLinearConvLineCore_l646;
  wire                when_QLinearConvLineCore_l652;
  wire       [63:0]   _zz_conv1_rqReg_4;
  wire                when_QLinearConvLineCore_l659;
  wire       [31:0]   _zz_conv1_rqReg_2;
  wire                when_QLinearConvLineCore_l672;
  wire                conv1_activationOut_fire;
  wire                when_QLinearConvLineCore_l684;
  wire                when_QLinearConvLineCore_l688;
  wire                when_QLinearConvLineCore_l692;
  wire                ReLUPlugin_logic_outStream_valid;
  reg                 ReLUPlugin_logic_outStream_ready;
  wire       [7:0]    ReLUPlugin_logic_outStream_payload_value;
  wire                relu1_activationOut_valid;
  wire                relu1_activationOut_ready;
  wire       [7:0]    relu1_activationOut_payload_value;
  wire                MaxPoolLinePlugin_logic_outStream_valid;
  reg                 MaxPoolLinePlugin_logic_outStream_ready;
  wire       [7:0]    MaxPoolLinePlugin_logic_outStream_payload_value;
  reg                 pool1_activationOut_valid;
  wire                pool1_activationOut_ready;
  reg        [7:0]    pool1_activationOut_payload_value;
  wire       [1:0]    pool1_sReceiveRow;
  wire       [1:0]    pool1_sPool;
  wire       [1:0]    pool1_sEmit;
  reg        [1:0]    pool1_stateReg;
  reg        [0:0]    pool1_rowWrPtrReg;
  reg        [1:0]    pool1_rowsUntilComputeReg;
  reg        [4:0]    pool1_realRowsRecvReg;
  reg        [7:0]    pool1_rxStepReg;
  reg        [3:0]    pool1_outRowReg;
  reg        [3:0]    pool1_outColReg;
  reg        [3:0]    pool1_outChReg;
  reg        [2:0]    pool1_phaseReg;
  reg        [1:0]    pool1_krReg;
  reg        [1:0]    pool1_kcReg;
  reg        [7:0]    pool1_maxReg;
  reg        [0:0]    pool1_curSlotReg;
  reg        [7:0]    pool1_rowAddrComb;
  wire       [7:0]    _zz_pool1_rowReads_0;
  wire       [7:0]    pool1_rowReads_0;
  wire       [7:0]    _zz_pool1_rowReads_1;
  wire       [7:0]    pool1_rowReads_1;
  wire       [7:0]    pool1_readData;
  reg        [7:0]    pool1_readDataReg;
  wire                ReLUPlugin_logic_outStream_fire;
  wire                when_MaxPoolLineCore_l180;
  wire                when_MaxPoolLineCore_l188;
  wire                when_MaxPoolLineCore_l218;
  wire                when_MaxPoolLineCore_l237;
  wire                when_MaxPoolLineCore_l241;
  wire       [2:0]    _zz_pool1_curSlotReg;
  wire                when_MaxPoolLineCore_l249;
  wire                when_MaxPoolLineCore_l253;
  wire                when_MaxPoolLineCore_l255;
  wire                when_MaxPoolLineCore_l260;
  wire                when_MaxPoolLineCore_l273;
  wire                pool1_activationOut_fire;
  wire                when_MaxPoolLineCore_l284;
  wire                when_MaxPoolLineCore_l287;
  wire                when_MaxPoolLineCore_l291;
  wire                QLinearConvLineCorePlugin_logic_outStream_valid_1;
  wire                QLinearConvLineCorePlugin_logic_outStream_ready_1;
  wire       [7:0]    QLinearConvLineCorePlugin_logic_outStream_payload_value_1;
  wire       [63:0]   conv2_zpWideBits;
  reg                 conv2_activationOut_valid;
  wire                conv2_activationOut_ready;
  reg        [7:0]    conv2_activationOut_payload_value;
  wire       [3:0]    conv2_sReceiveRow;
  wire       [3:0]    conv2_sLoadBias;
  wire       [3:0]    conv2_sWaitBias;
  wire       [3:0]    conv2_sCompute;
  wire       [3:0]    conv2_sRequant;
  wire       [3:0]    conv2_sRequantMul;
  wire       [3:0]    conv2_sRequantWait;
  wire       [3:0]    conv2_sRequantWait2;
  wire       [3:0]    conv2_sRequantWait3;
  wire       [3:0]    conv2_sRequantShift;
  wire       [3:0]    conv2_sEmit;
  wire       [3:0]    conv2_sInit;
  wire       [3:0]    conv2_sLoadWeights;
  reg        [3:0]    conv2_stateReg;
  reg        [2:0]    conv2_rowWrPtrReg;
  reg        [2:0]    conv2_rowsUntilComputeReg;
  reg        [3:0]    conv2_realRowsRecvReg;
  reg        [3:0]    conv2_rxBankReg;
  reg        [3:0]    conv2_rxWordReg;
  reg        [2:0]    conv2_initSlotReg;
  reg        [4:0]    conv2_initAddrReg;
  reg        [3:0]    conv2_outRowReg;
  reg        [3:0]    conv2_outColReg;
  reg        [4:0]    conv2_outChReg;
  reg        [2:0]    conv2_khCntReg;
  reg        [2:0]    conv2_rowStepReg;
  reg        [4:0]    conv2_compCycleReg;
  reg        [4:0]    conv2_rowAddrBaseReg;
  reg        [4:0]    conv2_rowAddrReg;
  reg        [8:0]    conv2_wAddrReg;
  wire       [4:0]    conv2_rowAddrComb;
  wire       [8:0]    conv2_wAddrComb;
  wire       [4:0]    conv2_rxAddr;
  wire       [4:0]    _zz_conv2_rowWideReads_0;
  wire       [63:0]   conv2_rowWideReads_0;
  wire       [4:0]    _zz_conv2_rowWideReads_1;
  wire       [63:0]   conv2_rowWideReads_1;
  wire       [4:0]    _zz_conv2_rowWideReads_2;
  wire       [63:0]   conv2_rowWideReads_2;
  wire       [4:0]    _zz_conv2_rowWideReads_3;
  wire       [63:0]   conv2_rowWideReads_3;
  wire       [4:0]    _zz_conv2_rowWideReads_4;
  wire       [63:0]   conv2_rowWideReads_4;
  wire       [7:0]    conv2_rowReads2D_0_0;
  wire       [7:0]    conv2_rowReads2D_0_1;
  wire       [7:0]    conv2_rowReads2D_0_2;
  wire       [7:0]    conv2_rowReads2D_0_3;
  wire       [7:0]    conv2_rowReads2D_0_4;
  wire       [7:0]    conv2_rowReads2D_0_5;
  wire       [7:0]    conv2_rowReads2D_0_6;
  wire       [7:0]    conv2_rowReads2D_0_7;
  wire       [7:0]    conv2_rowReads2D_1_0;
  wire       [7:0]    conv2_rowReads2D_1_1;
  wire       [7:0]    conv2_rowReads2D_1_2;
  wire       [7:0]    conv2_rowReads2D_1_3;
  wire       [7:0]    conv2_rowReads2D_1_4;
  wire       [7:0]    conv2_rowReads2D_1_5;
  wire       [7:0]    conv2_rowReads2D_1_6;
  wire       [7:0]    conv2_rowReads2D_1_7;
  wire       [7:0]    conv2_rowReads2D_2_0;
  wire       [7:0]    conv2_rowReads2D_2_1;
  wire       [7:0]    conv2_rowReads2D_2_2;
  wire       [7:0]    conv2_rowReads2D_2_3;
  wire       [7:0]    conv2_rowReads2D_2_4;
  wire       [7:0]    conv2_rowReads2D_2_5;
  wire       [7:0]    conv2_rowReads2D_2_6;
  wire       [7:0]    conv2_rowReads2D_2_7;
  wire       [7:0]    conv2_rowReads2D_3_0;
  wire       [7:0]    conv2_rowReads2D_3_1;
  wire       [7:0]    conv2_rowReads2D_3_2;
  wire       [7:0]    conv2_rowReads2D_3_3;
  wire       [7:0]    conv2_rowReads2D_3_4;
  wire       [7:0]    conv2_rowReads2D_3_5;
  wire       [7:0]    conv2_rowReads2D_3_6;
  wire       [7:0]    conv2_rowReads2D_3_7;
  wire       [7:0]    conv2_rowReads2D_4_0;
  wire       [7:0]    conv2_rowReads2D_4_1;
  wire       [7:0]    conv2_rowReads2D_4_2;
  wire       [7:0]    conv2_rowReads2D_4_3;
  wire       [7:0]    conv2_rowReads2D_4_4;
  wire       [7:0]    conv2_rowReads2D_4_5;
  wire       [7:0]    conv2_rowReads2D_4_6;
  wire       [7:0]    conv2_rowReads2D_4_7;
  wire       [8:0]    _zz_conv2_wDataRaw;
  wire       [31:0]   conv2_wDataRaw;
  wire       [3:0]    conv2_wValsRaw_0;
  wire       [3:0]    conv2_wValsRaw_1;
  wire       [3:0]    conv2_wValsRaw_2;
  wire       [3:0]    conv2_wValsRaw_3;
  wire       [3:0]    conv2_wValsRaw_4;
  wire       [3:0]    conv2_wValsRaw_5;
  wire       [3:0]    conv2_wValsRaw_6;
  wire       [3:0]    conv2_wValsRaw_7;
  wire       [4:0]    _zz_conv2_biasVal;
  wire       [31:0]   conv2_biasVal;
  reg        [2:0]    conv2_curSlotReg;
  reg        [7:0]    conv2_inValReg_0;
  reg        [7:0]    conv2_inValReg_1;
  reg        [7:0]    conv2_inValReg_2;
  reg        [7:0]    conv2_inValReg_3;
  reg        [7:0]    conv2_inValReg_4;
  reg        [7:0]    conv2_inValReg_5;
  reg        [7:0]    conv2_inValReg_6;
  reg        [7:0]    conv2_inValReg_7;
  reg        [3:0]    conv2_wValReg_0;
  reg        [3:0]    conv2_wValReg_1;
  reg        [3:0]    conv2_wValReg_2;
  reg        [3:0]    conv2_wValReg_3;
  reg        [3:0]    conv2_wValReg_4;
  reg        [3:0]    conv2_wValReg_5;
  reg        [3:0]    conv2_wValReg_6;
  reg        [3:0]    conv2_wValReg_7;
  reg        [31:0]   conv2_lutProdReg_0;
  reg        [31:0]   conv2_lutProdReg_1;
  reg        [31:0]   conv2_lutProdReg_2;
  reg        [31:0]   conv2_lutProdReg_3;
  reg        [31:0]   conv2_lutProdReg_4;
  reg        [31:0]   conv2_lutProdReg_5;
  reg        [31:0]   conv2_lutProdReg_6;
  reg        [31:0]   conv2_lutProdReg_7;
  reg        [31:0]   conv2_rqReg_0;
  reg        [31:0]   conv2_rqReg_1;
  reg        [7:0]    conv2_rqReg_2;
  reg        [31:0]   conv2_rqReg_3;
  reg        [63:0]   conv2_rqReg_4;
  reg                 conv2_rqReg_5;
  reg        [31:0]   conv2_rqReg_6;
  reg        [31:0]   conv2_rqReg_7;
  reg        [31:0]   conv2_rqReg_8;
  reg        [31:0]   conv2_rqReg_9;
  reg        [31:0]   conv2_rqReg_10;
  reg        [32:0]   conv2_rqReg_11;
  reg        [31:0]   conv2_rqReg_12;
  reg        [31:0]   conv2_rqReg_13;
  reg        [63:0]   conv2_rqReg_14;
  reg        [63:0]   conv2_rqReg_15;
  wire                conv2_isReal;
  reg        [7:0]    conv2_rxByteRegs_0;
  reg        [7:0]    conv2_rxByteRegs_1;
  reg        [7:0]    conv2_rxByteRegs_2;
  reg        [7:0]    conv2_rxByteRegs_3;
  reg        [7:0]    conv2_rxByteRegs_4;
  reg        [7:0]    conv2_rxByteRegs_5;
  reg        [7:0]    conv2_rxByteRegs_6;
  reg        [7:0]    conv2_rxByteRegs_7;
  wire                MaxPoolLinePlugin_logic_outStream_fire;
  wire                when_QLinearConvLineCore_l371_1;
  wire                when_QLinearConvLineCore_l371_2;
  wire                when_QLinearConvLineCore_l371_3;
  wire                when_QLinearConvLineCore_l371_4;
  wire                when_QLinearConvLineCore_l371_5;
  wire                when_QLinearConvLineCore_l371_6;
  wire                when_QLinearConvLineCore_l371_7;
  wire                when_QLinearConvLineCore_l371_8;
  wire       [7:0]    conv2_recvDataSeq_7;
  wire       [63:0]   conv2_recvData;
  wire                _zz_45;
  wire                _zz_46;
  wire                _zz_47;
  wire                _zz_48;
  wire                _zz_50;
  wire                _zz_51;
  wire                _zz_52;
  wire                _zz_53;
  wire                _zz_55;
  wire                _zz_56;
  wire                _zz_57;
  wire                _zz_58;
  wire                _zz_60;
  wire                _zz_61;
  wire                _zz_62;
  wire                _zz_63;
  wire                _zz_65;
  wire                _zz_66;
  wire                _zz_67;
  wire                _zz_68;
  wire                when_QLinearConvLineCore_l407_1;
  wire                when_QLinearConvLineCore_l409_1;
  wire                when_QLinearConvLineCore_l412_1;
  wire                when_QLinearConvLineCore_l431_1;
  wire                when_QLinearConvLineCore_l435_1;
  wire                when_QLinearConvLineCore_l438_1;
  wire                when_QLinearConvLineCore_l443_1;
  wire                when_QLinearConvLineCore_l449_1;
  wire                when_QLinearConvLineCore_l492_1;
  wire       [4:0]    _zz_conv2_rowAddrBaseReg;
  wire                when_QLinearConvLineCore_l505_1;
  wire                when_QLinearConvLineCore_l532_1;
  wire                when_QLinearConvLineCore_l536_1;
  wire       [3:0]    _zz_conv2_curSlotReg;
  wire                when_QLinearConvLineCore_l540_1;
  wire                when_QLinearConvLineCore_l551_1;
  wire                when_QLinearConvLineCore_l564_1;
  wire       [8:0]    _zz_conv2_lutProdReg_0;
  wire       [3:0]    _zz_conv2_lutProdReg_0_1;
  wire       [31:0]   _zz_conv2_lutProdReg_0_2;
  wire       [3:0]    _zz_conv2_lutProdReg_1;
  wire       [31:0]   _zz_conv2_lutProdReg_1_1;
  wire       [3:0]    _zz_conv2_lutProdReg_2;
  wire       [31:0]   _zz_conv2_lutProdReg_2_1;
  wire       [3:0]    _zz_conv2_lutProdReg_3;
  wire       [31:0]   _zz_conv2_lutProdReg_3_1;
  wire       [3:0]    _zz_conv2_lutProdReg_4;
  wire       [31:0]   _zz_conv2_lutProdReg_4_1;
  wire       [3:0]    _zz_conv2_lutProdReg_5;
  wire       [31:0]   _zz_conv2_lutProdReg_5_1;
  wire       [3:0]    _zz_conv2_lutProdReg_6;
  wire       [31:0]   _zz_conv2_lutProdReg_6_1;
  wire       [3:0]    _zz_conv2_lutProdReg_7;
  wire       [31:0]   _zz_conv2_lutProdReg_7_1;
  wire                when_QLinearConvLineCore_l579_1;
  wire                when_QLinearConvLineCore_l584_1;
  wire       [31:0]   _zz_conv2_rqReg_0;
  wire                when_QLinearConvLineCore_l587_1;
  wire                when_QLinearConvLineCore_l621_1;
  wire                when_QLinearConvLineCore_l627_1;
  wire       [31:0]   _zz_conv2_rqReg_7;
  wire       [15:0]   _zz_conv2_rqReg_9;
  wire       [15:0]   _zz_conv2_rqReg_7_1;
  wire       [15:0]   _zz_conv2_rqReg_8;
  wire       [15:0]   _zz_conv2_rqReg_7_2;
  wire                when_QLinearConvLineCore_l639_1;
  wire                when_QLinearConvLineCore_l646_1;
  wire                when_QLinearConvLineCore_l652_1;
  wire       [63:0]   _zz_conv2_rqReg_4;
  wire                when_QLinearConvLineCore_l659_1;
  wire       [31:0]   _zz_conv2_rqReg_2;
  wire                when_QLinearConvLineCore_l672_1;
  wire                conv2_activationOut_fire;
  wire                when_QLinearConvLineCore_l684_1;
  wire                when_QLinearConvLineCore_l688_1;
  wire                when_QLinearConvLineCore_l692_1;
  wire                ReLUPlugin_logic_outStream_valid_1;
  reg                 ReLUPlugin_logic_outStream_ready_1;
  wire       [7:0]    ReLUPlugin_logic_outStream_payload_value_1;
  wire                relu2_activationOut_valid;
  wire                relu2_activationOut_ready;
  wire       [7:0]    relu2_activationOut_payload_value;
  wire                MaxPoolLinePlugin_logic_outStream_valid_1;
  reg                 MaxPoolLinePlugin_logic_outStream_ready_1;
  wire       [7:0]    MaxPoolLinePlugin_logic_outStream_payload_value_1;
  reg                 pool2_activationOut_valid;
  wire                pool2_activationOut_ready;
  reg        [7:0]    pool2_activationOut_payload_value;
  wire       [1:0]    pool2_sReceiveRow;
  wire       [1:0]    pool2_sPool;
  wire       [1:0]    pool2_sEmit;
  reg        [1:0]    pool2_stateReg;
  reg        [1:0]    pool2_rowWrPtrReg;
  reg        [1:0]    pool2_rowsUntilComputeReg;
  reg        [3:0]    pool2_realRowsRecvReg;
  reg        [7:0]    pool2_rxStepReg;
  reg        [2:0]    pool2_outRowReg;
  reg        [2:0]    pool2_outColReg;
  reg        [4:0]    pool2_outChReg;
  reg        [3:0]    pool2_phaseReg;
  reg        [1:0]    pool2_krReg;
  reg        [1:0]    pool2_kcReg;
  reg        [7:0]    pool2_maxReg;
  reg        [1:0]    pool2_curSlotReg;
  reg        [7:0]    pool2_rowAddrComb;
  wire       [7:0]    _zz_pool2_rowReads_0;
  wire       [7:0]    pool2_rowReads_0;
  wire       [7:0]    _zz_pool2_rowReads_1;
  wire       [7:0]    pool2_rowReads_1;
  wire       [7:0]    _zz_pool2_rowReads_2;
  wire       [7:0]    pool2_rowReads_2;
  wire       [7:0]    pool2_readData;
  reg        [7:0]    pool2_readDataReg;
  wire                ReLUPlugin_logic_outStream_fire_1;
  wire                when_MaxPoolLineCore_l180_1;
  wire                when_MaxPoolLineCore_l188_1;
  wire                when_MaxPoolLineCore_l194;
  wire                when_MaxPoolLineCore_l195;
  wire                when_MaxPoolLineCore_l205;
  wire                when_MaxPoolLineCore_l237_1;
  wire                when_MaxPoolLineCore_l241_1;
  wire       [2:0]    _zz_pool2_curSlotReg;
  wire                when_MaxPoolLineCore_l249_1;
  wire                when_MaxPoolLineCore_l253_1;
  wire                when_MaxPoolLineCore_l255_1;
  wire                when_MaxPoolLineCore_l260_1;
  wire                when_MaxPoolLineCore_l273_1;
  wire                pool2_activationOut_fire;
  wire                when_MaxPoolLineCore_l284_1;
  wire                when_MaxPoolLineCore_l287_1;
  wire                when_MaxPoolLineCore_l291_1;
  wire                QLinearLinearPlugin_logic_outStream_valid;
  reg                 QLinearLinearPlugin_logic_outStream_ready;
  wire       [7:0]    QLinearLinearPlugin_logic_outStream_payload_value;
  reg                 linear1_activationOut_valid;
  wire                linear1_activationOut_ready;
  reg        [7:0]    linear1_activationOut_payload_value;
  wire       [3:0]    linear1_sReceive;
  wire       [3:0]    linear1_sLoadBias;
  wire       [3:0]    linear1_sCompute;
  wire       [3:0]    linear1_sRequant;
  wire       [3:0]    linear1_sRequantMul;
  wire       [3:0]    linear1_sRequantWait;
  wire       [3:0]    linear1_sRequantWait2;
  wire       [3:0]    linear1_sRequantWait3;
  wire       [3:0]    linear1_sRequantShift;
  wire       [3:0]    linear1_sEmit;
  wire       [3:0]    linear1_sWaitBias;
  wire       [3:0]    linear1_sLoadWeights;
  reg        [3:0]    linear1_stateReg;
  reg        [8:0]    linear1_recvCntReg;
  reg        [3:0]    linear1_outNeurReg;
  reg        [8:0]    linear1_compCycleReg;
  reg        [31:0]   linear1_accumReg;
  reg        [31:0]   linear1_prodReg;
  reg        [7:0]    linear1_resultReg;
  wire       [63:0]   linear1_reqProdReg1;
  reg        [63:0]   linear1_reqProdReg2;
  reg        [31:0]   linear1_accumRequantReg;
  reg                 linear1_signAReg;
  reg        [31:0]   linear1_absAReg;
  reg        [31:0]   linear1_pLL_Reg;
  reg        [31:0]   linear1_pLH_Reg;
  reg        [31:0]   linear1_pHL_Reg;
  reg        [31:0]   linear1_pHH_Reg;
  reg        [32:0]   linear1_pSumReg;
  reg        [31:0]   linear1_pLL_Reg2;
  reg        [31:0]   linear1_pHH_Reg2;
  reg        [63:0]   linear1_part1Reg;
  reg        [63:0]   linear1_part2Reg;
  reg        [7:0]    linear1_inValReg;
  reg        [7:0]    linear1_wValReg;
  reg        [7:0]    linear1_inAddrComb;
  reg        [11:0]   linear1_wAddrComb;
  wire       [7:0]    linear1_inValR;
  wire       [7:0]    linear1_wValR;
  wire       [3:0]    _zz_linear1_biasVal;
  wire       [31:0]   linear1_biasVal;
  wire                when_QLinearLinearCore_l174;
  wire                MaxPoolLinePlugin_logic_outStream_fire_1;
  wire                when_QLinearLinearCore_l179;
  wire                when_QLinearLinearCore_l219;
  wire                when_QLinearLinearCore_l225;
  wire                when_QLinearLinearCore_l231;
  wire                when_QLinearLinearCore_l235;
  wire                when_QLinearLinearCore_l242;
  wire                when_QLinearLinearCore_l248;
  wire                when_QLinearLinearCore_l255;
  wire       [31:0]   _zz_linear1_accumReg;
  wire                when_QLinearLinearCore_l259;
  wire                when_QLinearLinearCore_l268;
  wire                when_QLinearLinearCore_l275;
  wire       [31:0]   _zz_linear1_pLL_Reg;
  wire       [15:0]   _zz_linear1_pHL_Reg;
  wire       [15:0]   _zz_linear1_pLL_Reg_1;
  wire       [15:0]   _zz_linear1_pLH_Reg;
  wire       [15:0]   _zz_linear1_pLL_Reg_2;
  wire                when_QLinearLinearCore_l291;
  wire                when_QLinearLinearCore_l299;
  wire                when_QLinearLinearCore_l306;
  wire       [63:0]   _zz_linear1_reqProdReg2;
  wire                when_QLinearLinearCore_l314;
  wire       [31:0]   _zz_linear1_resultReg;
  wire                when_QLinearLinearCore_l325;
  wire                linear1_activationOut_fire;
  wire                _zz_linear1_stateReg;
  wire                SoftmaxPlugin_logic_outStream_valid;
  wire                SoftmaxPlugin_logic_outStream_ready;
  wire       [7:0]    SoftmaxPlugin_logic_outStream_payload_value;
  reg                 softmax_activationOut_valid;
  wire                softmax_activationOut_ready;
  reg        [7:0]    softmax_activationOut_payload_value;
  reg                 softmax_emitReg;
  reg        [3:0]    softmax_recvCntReg;
  reg        [7:0]    softmax_maxValReg;
  reg        [3:0]    softmax_maxIdxReg;
  wire                when_SoftmaxCore_l55;
  wire                QLinearLinearPlugin_logic_outStream_fire;
  wire                when_SoftmaxCore_l60;
  wire                when_SoftmaxCore_l65;
  wire                softmax_activationOut_fire;
  reg [7:0] conv1_inputBuf_0 [0:31];
  reg [7:0] conv1_inputBuf_1 [0:31];
  reg [7:0] conv1_inputBuf_2 [0:31];
  reg [7:0] conv1_inputBuf_3 [0:31];
  reg [7:0] conv1_inputBuf_4 [0:31];
  reg [3:0] conv1_weightRom [0:199];
  reg [31:0] conv1_biasRom [0:7];
  reg [7:0] pool1_rowBuf_0 [0:223];
  reg [7:0] pool1_rowBuf_1 [0:223];
  reg [63:0] conv2_inputBuf_0 [0:17];
  reg [63:0] conv2_inputBuf_1 [0:17];
  reg [63:0] conv2_inputBuf_2 [0:17];
  reg [63:0] conv2_inputBuf_3 [0:17];
  reg [63:0] conv2_inputBuf_4 [0:17];
  reg [31:0] conv2_weightRom [0:399];
  reg [31:0] conv2_biasRom [0:15];
  reg [7:0] pool2_rowBuf_0 [0:223];
  reg [7:0] pool2_rowBuf_1 [0:223];
  reg [7:0] pool2_rowBuf_2 [0:223];
  reg [7:0] linear1_inputBuf [0:255];
  reg [7:0] linear1_weightRom [0:2559];
  reg [31:0] linear1_biasRom [0:9];

  assign _zz_conv1_rxAddr = {1'd0, conv1_rxWordReg};
  assign _zz_conv1_rowWideReads_0_1 = _zz_conv1_rowWideReads_0[4:0];
  assign _zz_conv1_rowWideReads_1_1 = _zz_conv1_rowWideReads_1[4:0];
  assign _zz_conv1_rowWideReads_2_1 = _zz_conv1_rowWideReads_2[4:0];
  assign _zz_conv1_rowWideReads_3_1 = _zz_conv1_rowWideReads_3[4:0];
  assign _zz_conv1_rowWideReads_4_1 = _zz_conv1_rowWideReads_4[4:0];
  assign _zz_conv1_biasVal_1 = _zz_conv1_biasVal[2:0];
  assign _zz_conv1_inputBuf_0_port_3 = (_zz_11 ? conv1_initAddrReg : conv1_rxAddr);
  assign _zz_conv1_inputBuf_0_port_2 = _zz_conv1_inputBuf_0_port_3[4:0];
  assign _zz_conv1_inputBuf_1_port_3 = (_zz_16 ? conv1_initAddrReg : conv1_rxAddr);
  assign _zz_conv1_inputBuf_1_port_2 = _zz_conv1_inputBuf_1_port_3[4:0];
  assign _zz_conv1_inputBuf_2_port_3 = (_zz_21 ? conv1_initAddrReg : conv1_rxAddr);
  assign _zz_conv1_inputBuf_2_port_2 = _zz_conv1_inputBuf_2_port_3[4:0];
  assign _zz_conv1_inputBuf_3_port_3 = (_zz_26 ? conv1_initAddrReg : conv1_rxAddr);
  assign _zz_conv1_inputBuf_3_port_2 = _zz_conv1_inputBuf_3_port_3[4:0];
  assign _zz_conv1_inputBuf_4_port_3 = (_zz_31 ? conv1_initAddrReg : conv1_rxAddr);
  assign _zz_conv1_inputBuf_4_port_2 = _zz_conv1_inputBuf_4_port_3[4:0];
  assign _zz_conv1_rxBankReg = (conv1_rxBankReg + 1'b1);
  assign _zz_conv1_rowWrPtrReg = (conv1_rowWrPtrReg + 3'b001);
  assign _zz_conv1_wAddrReg = (conv1_outChReg * 5'h19);
  assign _zz__zz_conv1_curSlotReg = {1'd0, conv1_rowWrPtrReg};
  assign _zz__zz_conv1_curSlotReg_1 = {1'd0, conv1_khCntReg};
  assign _zz_conv1_curSlotReg_2 = (_zz_conv1_curSlotReg - 4'b0101);
  assign _zz_conv1_curSlotReg_1 = _zz_conv1_curSlotReg_2[2:0];
  assign _zz_conv1_curSlotReg_3 = _zz_conv1_curSlotReg[2:0];
  assign _zz__zz_conv1_lutProdReg_0_1 = ($signed(_zz__zz_conv1_lutProdReg_0_1_1) - $signed(9'h0));
  assign _zz__zz_conv1_lutProdReg_0_1_1 = {{1{conv1_inValReg_0[7]}}, conv1_inValReg_0};
  assign _zz_conv1_lutProdReg_0_2 = ($signed(_zz_conv1_lutProdReg_0_3) + $signed(_zz_conv1_lutProdReg_0_8));
  assign _zz_conv1_lutProdReg_0_3 = ($signed(_zz_conv1_lutProdReg_0_4) + $signed(_zz_conv1_lutProdReg_0_5));
  assign _zz_conv1_lutProdReg_0_4 = (_zz_conv1_lutProdReg_0[0] ? _zz_conv1_lutProdReg_0_1 : 32'h0);
  assign _zz_conv1_lutProdReg_0_5 = (_zz_conv1_lutProdReg_0[1] ? _zz_conv1_lutProdReg_0_6 : 32'h0);
  assign _zz_conv1_lutProdReg_0_7 = ({1'd0,_zz_conv1_lutProdReg_0_1} <<< 1'd1);
  assign _zz_conv1_lutProdReg_0_6 = _zz_conv1_lutProdReg_0_7[31:0];
  assign _zz_conv1_lutProdReg_0_8 = (_zz_conv1_lutProdReg_0[2] ? _zz_conv1_lutProdReg_0_9 : 32'h0);
  assign _zz_conv1_lutProdReg_0_10 = ({2'd0,_zz_conv1_lutProdReg_0_1} <<< 2'd2);
  assign _zz_conv1_lutProdReg_0_9 = _zz_conv1_lutProdReg_0_10[31:0];
  assign _zz_conv1_lutProdReg_0_11 = (_zz_conv1_lutProdReg_0[3] ? _zz_conv1_lutProdReg_0_12 : 32'h0);
  assign _zz_conv1_lutProdReg_0_13 = (- _zz_conv1_lutProdReg_0_14);
  assign _zz_conv1_lutProdReg_0_12 = _zz_conv1_lutProdReg_0_13[31:0];
  assign _zz_conv1_lutProdReg_0_14 = ({3'd0,_zz_conv1_lutProdReg_0_1} <<< 2'd3);
  assign _zz_conv1_rqReg_6 = (($signed(conv1_rqReg_3) < $signed(32'h0)) ? _zz_conv1_rqReg_6_1 : conv1_rqReg_3);
  assign _zz_conv1_rqReg_6_1 = (- conv1_rqReg_3);
  assign _zz_conv1_rqReg_11 = {1'd0, conv1_rqReg_8};
  assign _zz_conv1_rqReg_11_1 = {1'd0, conv1_rqReg_9};
  assign _zz_conv1_rqReg_14 = {32'd0, conv1_rqReg_12};
  assign _zz_conv1_rqReg_14_2 = ({16'd0,_zz_conv1_rqReg_14_3} <<< 5'd16);
  assign _zz_conv1_rqReg_14_1 = _zz_conv1_rqReg_14_2[63:0];
  assign _zz_conv1_rqReg_14_3 = {31'd0, conv1_rqReg_11};
  assign _zz_conv1_rqReg_15 = ({32'd0,_zz_conv1_rqReg_15_1} <<< 6'd32);
  assign _zz_conv1_rqReg_15_1 = {32'd0, conv1_rqReg_13};
  assign _zz_conv1_rqReg_4_1 = (- _zz_conv1_rqReg_4_2);
  assign _zz_conv1_rqReg_4_2 = _zz_conv1_rqReg_4;
  assign _zz_conv1_rqReg_4_3 = _zz_conv1_rqReg_4;
  assign _zz__zz_conv1_rqReg_2_1 = (conv1_rqReg_4 >>> 6'd35);
  assign _zz__zz_conv1_rqReg_2 = {{3{_zz__zz_conv1_rqReg_2_1[28]}}, _zz__zz_conv1_rqReg_2_1};
  assign _zz_conv1_rqReg_2_1 = (($signed(_zz_conv1_rqReg_2) < $signed(32'hffffff80)) ? 8'h80 : _zz_conv1_rqReg_2_2);
  assign _zz_conv1_rqReg_2_2 = _zz_conv1_rqReg_2[7:0];
  assign _zz_conv1_outChReg = (conv1_outChReg + 4'b0001);
  assign _zz_conv1_outColReg = (conv1_outColReg + 5'h01);
  assign _zz_conv1_outRowReg = (conv1_outRowReg + 5'h01);
  assign _zz_relu1_activationOut_payload_value = (($signed(8'h7f) < $signed(QLinearConvLineCorePlugin_logic_outStream_payload_value)) ? 8'h7f : QLinearConvLineCorePlugin_logic_outStream_payload_value);
  assign _zz_pool1_rxStepReg = (pool1_rxStepReg + 8'h01);
  assign _zz_pool1_rowWrPtrReg = (pool1_rowWrPtrReg + 1'b1);
  assign _zz_pool1_rowAddrComb = (_zz_pool1_rowAddrComb_1 + _zz_pool1_rowAddrComb_6);
  assign _zz_pool1_rowAddrComb_1 = (_zz_pool1_rowAddrComb_2 * 4'b1000);
  assign _zz_pool1_rowAddrComb_2 = (_zz_pool1_rowAddrComb_3 + _zz_pool1_rowAddrComb_4);
  assign _zz_pool1_rowAddrComb_3 = (pool1_outColReg * 2'b10);
  assign _zz_pool1_rowAddrComb_5 = {2'd0, pool1_kcReg};
  assign _zz_pool1_rowAddrComb_4 = {2'd0, _zz_pool1_rowAddrComb_5};
  assign _zz_pool1_rowAddrComb_7 = {4'd0, pool1_outChReg};
  assign _zz_pool1_rowAddrComb_6 = {2'd0, _zz_pool1_rowAddrComb_7};
  assign _zz__zz_pool1_curSlotReg = {2'd0, pool1_rowWrPtrReg};
  assign _zz__zz_pool1_curSlotReg_2 = pool1_krReg[0:0];
  assign _zz__zz_pool1_curSlotReg_1 = {2'd0, _zz__zz_pool1_curSlotReg_2};
  assign _zz_pool1_curSlotReg_2 = (_zz_pool1_curSlotReg - 3'b010);
  assign _zz_pool1_curSlotReg_1 = _zz_pool1_curSlotReg_2[0:0];
  assign _zz_pool1_curSlotReg_3 = _zz_pool1_curSlotReg[0:0];
  assign _zz_pool1_kcReg = (pool1_kcReg + 2'b01);
  assign _zz_pool1_outChReg = (pool1_outChReg + 4'b0001);
  assign _zz_pool1_outColReg = (pool1_outColReg + 4'b0001);
  assign _zz_pool1_outRowReg = (pool1_outRowReg + 4'b0001);
  assign _zz_conv2_rxAddr = {1'd0, conv2_rxWordReg};
  assign _zz_conv2_biasVal_1 = _zz_conv2_biasVal[3:0];
  assign _zz_conv2_rxBankReg = (conv2_rxBankReg + 4'b0001);
  assign _zz_conv2_rowWrPtrReg = (conv2_rowWrPtrReg + 3'b001);
  assign _zz_conv2_wAddrReg = (conv2_outChReg * 5'h19);
  assign _zz__zz_conv2_curSlotReg = {1'd0, conv2_rowWrPtrReg};
  assign _zz__zz_conv2_curSlotReg_1 = {1'd0, conv2_khCntReg};
  assign _zz_conv2_curSlotReg_2 = (_zz_conv2_curSlotReg - 4'b0101);
  assign _zz_conv2_curSlotReg_1 = _zz_conv2_curSlotReg_2[2:0];
  assign _zz_conv2_curSlotReg_3 = _zz_conv2_curSlotReg[2:0];
  assign _zz__zz_conv2_lutProdReg_0_2 = ($signed(_zz__zz_conv2_lutProdReg_0_2_1) - $signed(_zz_conv2_lutProdReg_0));
  assign _zz__zz_conv2_lutProdReg_0_2_1 = {{1{conv2_inValReg_0[7]}}, conv2_inValReg_0};
  assign _zz_conv2_lutProdReg_0_3 = ($signed(_zz_conv2_lutProdReg_0_4) + $signed(_zz_conv2_lutProdReg_0_9));
  assign _zz_conv2_lutProdReg_0_4 = ($signed(_zz_conv2_lutProdReg_0_5) + $signed(_zz_conv2_lutProdReg_0_6));
  assign _zz_conv2_lutProdReg_0_5 = (_zz_conv2_lutProdReg_0_1[0] ? _zz_conv2_lutProdReg_0_2 : 32'h0);
  assign _zz_conv2_lutProdReg_0_6 = (_zz_conv2_lutProdReg_0_1[1] ? _zz_conv2_lutProdReg_0_7 : 32'h0);
  assign _zz_conv2_lutProdReg_0_8 = ({1'd0,_zz_conv2_lutProdReg_0_2} <<< 1'd1);
  assign _zz_conv2_lutProdReg_0_7 = _zz_conv2_lutProdReg_0_8[31:0];
  assign _zz_conv2_lutProdReg_0_9 = (_zz_conv2_lutProdReg_0_1[2] ? _zz_conv2_lutProdReg_0_10 : 32'h0);
  assign _zz_conv2_lutProdReg_0_11 = ({2'd0,_zz_conv2_lutProdReg_0_2} <<< 2'd2);
  assign _zz_conv2_lutProdReg_0_10 = _zz_conv2_lutProdReg_0_11[31:0];
  assign _zz_conv2_lutProdReg_0_12 = (_zz_conv2_lutProdReg_0_1[3] ? _zz_conv2_lutProdReg_0_13 : 32'h0);
  assign _zz_conv2_lutProdReg_0_14 = (- _zz_conv2_lutProdReg_0_15);
  assign _zz_conv2_lutProdReg_0_13 = _zz_conv2_lutProdReg_0_14[31:0];
  assign _zz_conv2_lutProdReg_0_15 = ({3'd0,_zz_conv2_lutProdReg_0_2} <<< 2'd3);
  assign _zz__zz_conv2_lutProdReg_1_1 = ($signed(_zz__zz_conv2_lutProdReg_1_1_1) - $signed(_zz_conv2_lutProdReg_0));
  assign _zz__zz_conv2_lutProdReg_1_1_1 = {{1{conv2_inValReg_1[7]}}, conv2_inValReg_1};
  assign _zz_conv2_lutProdReg_1_2 = ($signed(_zz_conv2_lutProdReg_1_3) + $signed(_zz_conv2_lutProdReg_1_8));
  assign _zz_conv2_lutProdReg_1_3 = ($signed(_zz_conv2_lutProdReg_1_4) + $signed(_zz_conv2_lutProdReg_1_5));
  assign _zz_conv2_lutProdReg_1_4 = (_zz_conv2_lutProdReg_1[0] ? _zz_conv2_lutProdReg_1_1 : 32'h0);
  assign _zz_conv2_lutProdReg_1_5 = (_zz_conv2_lutProdReg_1[1] ? _zz_conv2_lutProdReg_1_6 : 32'h0);
  assign _zz_conv2_lutProdReg_1_7 = ({1'd0,_zz_conv2_lutProdReg_1_1} <<< 1'd1);
  assign _zz_conv2_lutProdReg_1_6 = _zz_conv2_lutProdReg_1_7[31:0];
  assign _zz_conv2_lutProdReg_1_8 = (_zz_conv2_lutProdReg_1[2] ? _zz_conv2_lutProdReg_1_9 : 32'h0);
  assign _zz_conv2_lutProdReg_1_10 = ({2'd0,_zz_conv2_lutProdReg_1_1} <<< 2'd2);
  assign _zz_conv2_lutProdReg_1_9 = _zz_conv2_lutProdReg_1_10[31:0];
  assign _zz_conv2_lutProdReg_1_11 = (_zz_conv2_lutProdReg_1[3] ? _zz_conv2_lutProdReg_1_12 : 32'h0);
  assign _zz_conv2_lutProdReg_1_13 = (- _zz_conv2_lutProdReg_1_14);
  assign _zz_conv2_lutProdReg_1_12 = _zz_conv2_lutProdReg_1_13[31:0];
  assign _zz_conv2_lutProdReg_1_14 = ({3'd0,_zz_conv2_lutProdReg_1_1} <<< 2'd3);
  assign _zz__zz_conv2_lutProdReg_2_1 = ($signed(_zz__zz_conv2_lutProdReg_2_1_1) - $signed(_zz_conv2_lutProdReg_0));
  assign _zz__zz_conv2_lutProdReg_2_1_1 = {{1{conv2_inValReg_2[7]}}, conv2_inValReg_2};
  assign _zz_conv2_lutProdReg_2_2 = ($signed(_zz_conv2_lutProdReg_2_3) + $signed(_zz_conv2_lutProdReg_2_8));
  assign _zz_conv2_lutProdReg_2_3 = ($signed(_zz_conv2_lutProdReg_2_4) + $signed(_zz_conv2_lutProdReg_2_5));
  assign _zz_conv2_lutProdReg_2_4 = (_zz_conv2_lutProdReg_2[0] ? _zz_conv2_lutProdReg_2_1 : 32'h0);
  assign _zz_conv2_lutProdReg_2_5 = (_zz_conv2_lutProdReg_2[1] ? _zz_conv2_lutProdReg_2_6 : 32'h0);
  assign _zz_conv2_lutProdReg_2_7 = ({1'd0,_zz_conv2_lutProdReg_2_1} <<< 1'd1);
  assign _zz_conv2_lutProdReg_2_6 = _zz_conv2_lutProdReg_2_7[31:0];
  assign _zz_conv2_lutProdReg_2_8 = (_zz_conv2_lutProdReg_2[2] ? _zz_conv2_lutProdReg_2_9 : 32'h0);
  assign _zz_conv2_lutProdReg_2_10 = ({2'd0,_zz_conv2_lutProdReg_2_1} <<< 2'd2);
  assign _zz_conv2_lutProdReg_2_9 = _zz_conv2_lutProdReg_2_10[31:0];
  assign _zz_conv2_lutProdReg_2_11 = (_zz_conv2_lutProdReg_2[3] ? _zz_conv2_lutProdReg_2_12 : 32'h0);
  assign _zz_conv2_lutProdReg_2_13 = (- _zz_conv2_lutProdReg_2_14);
  assign _zz_conv2_lutProdReg_2_12 = _zz_conv2_lutProdReg_2_13[31:0];
  assign _zz_conv2_lutProdReg_2_14 = ({3'd0,_zz_conv2_lutProdReg_2_1} <<< 2'd3);
  assign _zz__zz_conv2_lutProdReg_3_1 = ($signed(_zz__zz_conv2_lutProdReg_3_1_1) - $signed(_zz_conv2_lutProdReg_0));
  assign _zz__zz_conv2_lutProdReg_3_1_1 = {{1{conv2_inValReg_3[7]}}, conv2_inValReg_3};
  assign _zz_conv2_lutProdReg_3_2 = ($signed(_zz_conv2_lutProdReg_3_3) + $signed(_zz_conv2_lutProdReg_3_8));
  assign _zz_conv2_lutProdReg_3_3 = ($signed(_zz_conv2_lutProdReg_3_4) + $signed(_zz_conv2_lutProdReg_3_5));
  assign _zz_conv2_lutProdReg_3_4 = (_zz_conv2_lutProdReg_3[0] ? _zz_conv2_lutProdReg_3_1 : 32'h0);
  assign _zz_conv2_lutProdReg_3_5 = (_zz_conv2_lutProdReg_3[1] ? _zz_conv2_lutProdReg_3_6 : 32'h0);
  assign _zz_conv2_lutProdReg_3_7 = ({1'd0,_zz_conv2_lutProdReg_3_1} <<< 1'd1);
  assign _zz_conv2_lutProdReg_3_6 = _zz_conv2_lutProdReg_3_7[31:0];
  assign _zz_conv2_lutProdReg_3_8 = (_zz_conv2_lutProdReg_3[2] ? _zz_conv2_lutProdReg_3_9 : 32'h0);
  assign _zz_conv2_lutProdReg_3_10 = ({2'd0,_zz_conv2_lutProdReg_3_1} <<< 2'd2);
  assign _zz_conv2_lutProdReg_3_9 = _zz_conv2_lutProdReg_3_10[31:0];
  assign _zz_conv2_lutProdReg_3_11 = (_zz_conv2_lutProdReg_3[3] ? _zz_conv2_lutProdReg_3_12 : 32'h0);
  assign _zz_conv2_lutProdReg_3_13 = (- _zz_conv2_lutProdReg_3_14);
  assign _zz_conv2_lutProdReg_3_12 = _zz_conv2_lutProdReg_3_13[31:0];
  assign _zz_conv2_lutProdReg_3_14 = ({3'd0,_zz_conv2_lutProdReg_3_1} <<< 2'd3);
  assign _zz__zz_conv2_lutProdReg_4_1 = ($signed(_zz__zz_conv2_lutProdReg_4_1_1) - $signed(_zz_conv2_lutProdReg_0));
  assign _zz__zz_conv2_lutProdReg_4_1_1 = {{1{conv2_inValReg_4[7]}}, conv2_inValReg_4};
  assign _zz_conv2_lutProdReg_4_2 = ($signed(_zz_conv2_lutProdReg_4_3) + $signed(_zz_conv2_lutProdReg_4_8));
  assign _zz_conv2_lutProdReg_4_3 = ($signed(_zz_conv2_lutProdReg_4_4) + $signed(_zz_conv2_lutProdReg_4_5));
  assign _zz_conv2_lutProdReg_4_4 = (_zz_conv2_lutProdReg_4[0] ? _zz_conv2_lutProdReg_4_1 : 32'h0);
  assign _zz_conv2_lutProdReg_4_5 = (_zz_conv2_lutProdReg_4[1] ? _zz_conv2_lutProdReg_4_6 : 32'h0);
  assign _zz_conv2_lutProdReg_4_7 = ({1'd0,_zz_conv2_lutProdReg_4_1} <<< 1'd1);
  assign _zz_conv2_lutProdReg_4_6 = _zz_conv2_lutProdReg_4_7[31:0];
  assign _zz_conv2_lutProdReg_4_8 = (_zz_conv2_lutProdReg_4[2] ? _zz_conv2_lutProdReg_4_9 : 32'h0);
  assign _zz_conv2_lutProdReg_4_10 = ({2'd0,_zz_conv2_lutProdReg_4_1} <<< 2'd2);
  assign _zz_conv2_lutProdReg_4_9 = _zz_conv2_lutProdReg_4_10[31:0];
  assign _zz_conv2_lutProdReg_4_11 = (_zz_conv2_lutProdReg_4[3] ? _zz_conv2_lutProdReg_4_12 : 32'h0);
  assign _zz_conv2_lutProdReg_4_13 = (- _zz_conv2_lutProdReg_4_14);
  assign _zz_conv2_lutProdReg_4_12 = _zz_conv2_lutProdReg_4_13[31:0];
  assign _zz_conv2_lutProdReg_4_14 = ({3'd0,_zz_conv2_lutProdReg_4_1} <<< 2'd3);
  assign _zz__zz_conv2_lutProdReg_5_1 = ($signed(_zz__zz_conv2_lutProdReg_5_1_1) - $signed(_zz_conv2_lutProdReg_0));
  assign _zz__zz_conv2_lutProdReg_5_1_1 = {{1{conv2_inValReg_5[7]}}, conv2_inValReg_5};
  assign _zz_conv2_lutProdReg_5_2 = ($signed(_zz_conv2_lutProdReg_5_3) + $signed(_zz_conv2_lutProdReg_5_8));
  assign _zz_conv2_lutProdReg_5_3 = ($signed(_zz_conv2_lutProdReg_5_4) + $signed(_zz_conv2_lutProdReg_5_5));
  assign _zz_conv2_lutProdReg_5_4 = (_zz_conv2_lutProdReg_5[0] ? _zz_conv2_lutProdReg_5_1 : 32'h0);
  assign _zz_conv2_lutProdReg_5_5 = (_zz_conv2_lutProdReg_5[1] ? _zz_conv2_lutProdReg_5_6 : 32'h0);
  assign _zz_conv2_lutProdReg_5_7 = ({1'd0,_zz_conv2_lutProdReg_5_1} <<< 1'd1);
  assign _zz_conv2_lutProdReg_5_6 = _zz_conv2_lutProdReg_5_7[31:0];
  assign _zz_conv2_lutProdReg_5_8 = (_zz_conv2_lutProdReg_5[2] ? _zz_conv2_lutProdReg_5_9 : 32'h0);
  assign _zz_conv2_lutProdReg_5_10 = ({2'd0,_zz_conv2_lutProdReg_5_1} <<< 2'd2);
  assign _zz_conv2_lutProdReg_5_9 = _zz_conv2_lutProdReg_5_10[31:0];
  assign _zz_conv2_lutProdReg_5_11 = (_zz_conv2_lutProdReg_5[3] ? _zz_conv2_lutProdReg_5_12 : 32'h0);
  assign _zz_conv2_lutProdReg_5_13 = (- _zz_conv2_lutProdReg_5_14);
  assign _zz_conv2_lutProdReg_5_12 = _zz_conv2_lutProdReg_5_13[31:0];
  assign _zz_conv2_lutProdReg_5_14 = ({3'd0,_zz_conv2_lutProdReg_5_1} <<< 2'd3);
  assign _zz__zz_conv2_lutProdReg_6_1 = ($signed(_zz__zz_conv2_lutProdReg_6_1_1) - $signed(_zz_conv2_lutProdReg_0));
  assign _zz__zz_conv2_lutProdReg_6_1_1 = {{1{conv2_inValReg_6[7]}}, conv2_inValReg_6};
  assign _zz_conv2_lutProdReg_6_2 = ($signed(_zz_conv2_lutProdReg_6_3) + $signed(_zz_conv2_lutProdReg_6_8));
  assign _zz_conv2_lutProdReg_6_3 = ($signed(_zz_conv2_lutProdReg_6_4) + $signed(_zz_conv2_lutProdReg_6_5));
  assign _zz_conv2_lutProdReg_6_4 = (_zz_conv2_lutProdReg_6[0] ? _zz_conv2_lutProdReg_6_1 : 32'h0);
  assign _zz_conv2_lutProdReg_6_5 = (_zz_conv2_lutProdReg_6[1] ? _zz_conv2_lutProdReg_6_6 : 32'h0);
  assign _zz_conv2_lutProdReg_6_7 = ({1'd0,_zz_conv2_lutProdReg_6_1} <<< 1'd1);
  assign _zz_conv2_lutProdReg_6_6 = _zz_conv2_lutProdReg_6_7[31:0];
  assign _zz_conv2_lutProdReg_6_8 = (_zz_conv2_lutProdReg_6[2] ? _zz_conv2_lutProdReg_6_9 : 32'h0);
  assign _zz_conv2_lutProdReg_6_10 = ({2'd0,_zz_conv2_lutProdReg_6_1} <<< 2'd2);
  assign _zz_conv2_lutProdReg_6_9 = _zz_conv2_lutProdReg_6_10[31:0];
  assign _zz_conv2_lutProdReg_6_11 = (_zz_conv2_lutProdReg_6[3] ? _zz_conv2_lutProdReg_6_12 : 32'h0);
  assign _zz_conv2_lutProdReg_6_13 = (- _zz_conv2_lutProdReg_6_14);
  assign _zz_conv2_lutProdReg_6_12 = _zz_conv2_lutProdReg_6_13[31:0];
  assign _zz_conv2_lutProdReg_6_14 = ({3'd0,_zz_conv2_lutProdReg_6_1} <<< 2'd3);
  assign _zz__zz_conv2_lutProdReg_7_1 = ($signed(_zz__zz_conv2_lutProdReg_7_1_1) - $signed(_zz_conv2_lutProdReg_0));
  assign _zz__zz_conv2_lutProdReg_7_1_1 = {{1{conv2_inValReg_7[7]}}, conv2_inValReg_7};
  assign _zz_conv2_lutProdReg_7_2 = ($signed(_zz_conv2_lutProdReg_7_3) + $signed(_zz_conv2_lutProdReg_7_8));
  assign _zz_conv2_lutProdReg_7_3 = ($signed(_zz_conv2_lutProdReg_7_4) + $signed(_zz_conv2_lutProdReg_7_5));
  assign _zz_conv2_lutProdReg_7_4 = (_zz_conv2_lutProdReg_7[0] ? _zz_conv2_lutProdReg_7_1 : 32'h0);
  assign _zz_conv2_lutProdReg_7_5 = (_zz_conv2_lutProdReg_7[1] ? _zz_conv2_lutProdReg_7_6 : 32'h0);
  assign _zz_conv2_lutProdReg_7_7 = ({1'd0,_zz_conv2_lutProdReg_7_1} <<< 1'd1);
  assign _zz_conv2_lutProdReg_7_6 = _zz_conv2_lutProdReg_7_7[31:0];
  assign _zz_conv2_lutProdReg_7_8 = (_zz_conv2_lutProdReg_7[2] ? _zz_conv2_lutProdReg_7_9 : 32'h0);
  assign _zz_conv2_lutProdReg_7_10 = ({2'd0,_zz_conv2_lutProdReg_7_1} <<< 2'd2);
  assign _zz_conv2_lutProdReg_7_9 = _zz_conv2_lutProdReg_7_10[31:0];
  assign _zz_conv2_lutProdReg_7_11 = (_zz_conv2_lutProdReg_7[3] ? _zz_conv2_lutProdReg_7_12 : 32'h0);
  assign _zz_conv2_lutProdReg_7_13 = (- _zz_conv2_lutProdReg_7_14);
  assign _zz_conv2_lutProdReg_7_12 = _zz_conv2_lutProdReg_7_13[31:0];
  assign _zz_conv2_lutProdReg_7_14 = ({3'd0,_zz_conv2_lutProdReg_7_1} <<< 2'd3);
  assign _zz_conv2_rqReg_1 = ($signed(_zz_conv2_rqReg_1_1) + $signed(_zz_conv2_rqReg_1_2));
  assign _zz_conv2_rqReg_1_1 = ($signed(conv2_lutProdReg_0) + $signed(conv2_lutProdReg_1));
  assign _zz_conv2_rqReg_1_2 = ($signed(conv2_lutProdReg_2) + $signed(conv2_lutProdReg_3));
  assign _zz_conv2_rqReg_1_3 = ($signed(_zz_conv2_rqReg_1_4) + $signed(_zz_conv2_rqReg_1_5));
  assign _zz_conv2_rqReg_1_4 = ($signed(conv2_lutProdReg_4) + $signed(conv2_lutProdReg_5));
  assign _zz_conv2_rqReg_1_5 = ($signed(conv2_lutProdReg_6) + $signed(conv2_lutProdReg_7));
  assign _zz_conv2_rqReg_6 = (($signed(conv2_rqReg_3) < $signed(32'h0)) ? _zz_conv2_rqReg_6_1 : conv2_rqReg_3);
  assign _zz_conv2_rqReg_6_1 = (- conv2_rqReg_3);
  assign _zz_conv2_rqReg_11 = {1'd0, conv2_rqReg_8};
  assign _zz_conv2_rqReg_11_1 = {1'd0, conv2_rqReg_9};
  assign _zz_conv2_rqReg_14 = {32'd0, conv2_rqReg_12};
  assign _zz_conv2_rqReg_14_2 = ({16'd0,_zz_conv2_rqReg_14_3} <<< 5'd16);
  assign _zz_conv2_rqReg_14_1 = _zz_conv2_rqReg_14_2[63:0];
  assign _zz_conv2_rqReg_14_3 = {31'd0, conv2_rqReg_11};
  assign _zz_conv2_rqReg_15 = ({32'd0,_zz_conv2_rqReg_15_1} <<< 6'd32);
  assign _zz_conv2_rqReg_15_1 = {32'd0, conv2_rqReg_13};
  assign _zz_conv2_rqReg_4_1 = (- _zz_conv2_rqReg_4_2);
  assign _zz_conv2_rqReg_4_2 = _zz_conv2_rqReg_4;
  assign _zz_conv2_rqReg_4_3 = _zz_conv2_rqReg_4;
  assign _zz__zz_conv2_rqReg_2_1 = (conv2_rqReg_4 >>> 6'd35);
  assign _zz__zz_conv2_rqReg_2 = {{3{_zz__zz_conv2_rqReg_2_1[28]}}, _zz__zz_conv2_rqReg_2_1};
  assign _zz_conv2_rqReg_2_1 = (($signed(_zz_conv2_rqReg_2) < $signed(32'hffffff80)) ? 8'h80 : _zz_conv2_rqReg_2_2);
  assign _zz_conv2_rqReg_2_2 = _zz_conv2_rqReg_2[7:0];
  assign _zz_conv2_outChReg = (conv2_outChReg + 5'h01);
  assign _zz_conv2_outColReg = (conv2_outColReg + 4'b0001);
  assign _zz_conv2_outRowReg = (conv2_outRowReg + 4'b0001);
  assign _zz_relu2_activationOut_payload_value = (($signed(8'h7f) < $signed(QLinearConvLineCorePlugin_logic_outStream_payload_value_1)) ? 8'h7f : QLinearConvLineCorePlugin_logic_outStream_payload_value_1);
  assign _zz_pool2_rxStepReg = (pool2_rxStepReg + 8'h01);
  assign _zz_pool2_rowWrPtrReg = (pool2_rowWrPtrReg + 2'b01);
  assign _zz_pool2_rowAddrComb = (_zz_pool2_rowAddrComb_1 + _zz_pool2_rowAddrComb_6);
  assign _zz_pool2_rowAddrComb_1 = (_zz_pool2_rowAddrComb_2 * 5'h10);
  assign _zz_pool2_rowAddrComb_2 = (_zz_pool2_rowAddrComb_3 + _zz_pool2_rowAddrComb_4);
  assign _zz_pool2_rowAddrComb_3 = (pool2_outColReg * 2'b11);
  assign _zz_pool2_rowAddrComb_5 = {1'd0, pool2_kcReg};
  assign _zz_pool2_rowAddrComb_4 = {2'd0, _zz_pool2_rowAddrComb_5};
  assign _zz_pool2_rowAddrComb_7 = {3'd0, pool2_outChReg};
  assign _zz_pool2_rowAddrComb_6 = {2'd0, _zz_pool2_rowAddrComb_7};
  assign _zz__zz_pool2_curSlotReg = {1'd0, pool2_rowWrPtrReg};
  assign _zz__zz_pool2_curSlotReg_1 = {1'd0, pool2_krReg};
  assign _zz_pool2_curSlotReg_2 = (_zz_pool2_curSlotReg - 3'b011);
  assign _zz_pool2_curSlotReg_1 = _zz_pool2_curSlotReg_2[1:0];
  assign _zz_pool2_curSlotReg_3 = _zz_pool2_curSlotReg[1:0];
  assign _zz_pool2_kcReg = (pool2_kcReg + 2'b01);
  assign _zz_pool2_outChReg = (pool2_outChReg + 5'h01);
  assign _zz_pool2_outColReg = (pool2_outColReg + 3'b001);
  assign _zz_pool2_outRowReg = (pool2_outRowReg + 3'b001);
  assign _zz_linear1_inputBuf_port_1 = linear1_recvCntReg[7:0];
  assign _zz_linear1_wAddrComb = (_zz_linear1_wAddrComb_1 + _zz_linear1_wAddrComb_2);
  assign _zz_linear1_wAddrComb_1 = (linear1_outNeurReg * 9'h100);
  assign _zz_linear1_wAddrComb_2 = {4'd0, linear1_compCycleReg};
  assign _zz_linear1_prodReg = ($signed(_zz_linear1_prodReg_1) * $signed(_zz_linear1_prodReg_3));
  assign _zz_linear1_prodReg_1 = ($signed(_zz_linear1_prodReg_2) - $signed(9'h0));
  assign _zz_linear1_prodReg_2 = {{1{linear1_inValReg[7]}}, linear1_inValReg};
  assign _zz_linear1_prodReg_3 = ($signed(_zz_linear1_prodReg_4) - $signed(9'h0));
  assign _zz_linear1_prodReg_4 = {{1{linear1_wValReg[7]}}, linear1_wValReg};
  assign _zz_linear1_absAReg = (($signed(linear1_accumRequantReg) < $signed(32'h0)) ? _zz_linear1_absAReg_1 : linear1_accumRequantReg);
  assign _zz_linear1_absAReg_1 = (- linear1_accumRequantReg);
  assign _zz_linear1_pSumReg = {1'd0, linear1_pLH_Reg};
  assign _zz_linear1_pSumReg_1 = {1'd0, linear1_pHL_Reg};
  assign _zz_linear1_part1Reg = {32'd0, linear1_pLL_Reg2};
  assign _zz_linear1_part1Reg_2 = ({16'd0,_zz_linear1_part1Reg_3} <<< 5'd16);
  assign _zz_linear1_part1Reg_1 = _zz_linear1_part1Reg_2[63:0];
  assign _zz_linear1_part1Reg_3 = {31'd0, linear1_pSumReg};
  assign _zz_linear1_part2Reg = ({32'd0,_zz_linear1_part2Reg_1} <<< 6'd32);
  assign _zz_linear1_part2Reg_1 = {32'd0, linear1_pHH_Reg2};
  assign _zz_linear1_reqProdReg2_1 = (- _zz_linear1_reqProdReg2_2);
  assign _zz_linear1_reqProdReg2_2 = _zz_linear1_reqProdReg2;
  assign _zz_linear1_reqProdReg2_3 = _zz_linear1_reqProdReg2;
  assign _zz__zz_linear1_resultReg_1 = (linear1_reqProdReg2 >>> 6'd38);
  assign _zz__zz_linear1_resultReg = {{6{_zz__zz_linear1_resultReg_1[25]}}, _zz__zz_linear1_resultReg_1};
  assign _zz_linear1_resultReg_1 = (($signed(_zz_linear1_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz_linear1_resultReg_2);
  assign _zz_linear1_resultReg_2 = _zz_linear1_resultReg[7:0];
  assign _zz_linear1_outNeurReg = (linear1_outNeurReg + 4'b0001);
  assign _zz_softmax_activationOut_payload_value = {4'd0, softmax_maxIdxReg};
  assign _zz_softmax_activationOut_payload_value_1 = {4'd0, softmax_maxIdxReg};
  assign _zz_conv1_rowWideReads_0_2 = 1'b1;
  assign _zz_conv1_inputBuf_0_port_4 = (_zz_12 ? conv1_recvData : conv1_zpWideBits);
  assign _zz_conv1_inputBuf_0_port_5 = ((_zz_11 || _zz_12) || ((((conv1_stateReg == conv1_sReceiveRow) && _zz_9) && (! conv1_isReal)) && _zz_10));
  assign _zz_conv1_rowWideReads_1_2 = 1'b1;
  assign _zz_conv1_inputBuf_1_port_4 = (_zz_17 ? conv1_recvData : conv1_zpWideBits);
  assign _zz_conv1_inputBuf_1_port_5 = ((_zz_16 || _zz_17) || ((((conv1_stateReg == conv1_sReceiveRow) && _zz_14) && (! conv1_isReal)) && _zz_15));
  assign _zz_conv1_rowWideReads_2_2 = 1'b1;
  assign _zz_conv1_inputBuf_2_port_4 = (_zz_22 ? conv1_recvData : conv1_zpWideBits);
  assign _zz_conv1_inputBuf_2_port_5 = ((_zz_21 || _zz_22) || ((((conv1_stateReg == conv1_sReceiveRow) && _zz_19) && (! conv1_isReal)) && _zz_20));
  assign _zz_conv1_rowWideReads_3_2 = 1'b1;
  assign _zz_conv1_inputBuf_3_port_4 = (_zz_27 ? conv1_recvData : conv1_zpWideBits);
  assign _zz_conv1_inputBuf_3_port_5 = ((_zz_26 || _zz_27) || ((((conv1_stateReg == conv1_sReceiveRow) && _zz_24) && (! conv1_isReal)) && _zz_25));
  assign _zz_conv1_rowWideReads_4_2 = 1'b1;
  assign _zz_conv1_inputBuf_4_port_4 = (_zz_32 ? conv1_recvData : conv1_zpWideBits);
  assign _zz_conv1_inputBuf_4_port_5 = ((_zz_31 || _zz_32) || ((((conv1_stateReg == conv1_sReceiveRow) && _zz_29) && (! conv1_isReal)) && _zz_30));
  assign _zz_conv1_wDataRaw_1 = 1'b1;
  assign _zz_conv1_biasVal_2 = 1'b1;
  assign _zz_pool1_rowReads_0_1 = 1'b1;
  assign _zz_pool1_rowBuf_0_port_1 = ReLUPlugin_logic_outStream_payload_value;
  assign _zz_pool1_rowBuf_0_port_2 = ((((pool1_stateReg == pool1_sReceiveRow) && (pool1_rowWrPtrReg == 1'b0)) && ReLUPlugin_logic_outStream_fire) && (! 1'b0));
  assign _zz_pool1_rowReads_1_1 = 1'b1;
  assign _zz_pool1_rowBuf_1_port_1 = ReLUPlugin_logic_outStream_payload_value;
  assign _zz_pool1_rowBuf_1_port_2 = ((((pool1_stateReg == pool1_sReceiveRow) && (pool1_rowWrPtrReg == 1'b1)) && ReLUPlugin_logic_outStream_fire) && (! 1'b0));
  assign _zz_conv2_rowWideReads_0_1 = 1'b1;
  assign _zz_conv2_inputBuf_0_port_1 = (_zz_47 ? conv2_initAddrReg : conv2_rxAddr);
  assign _zz_conv2_inputBuf_0_port_2 = (_zz_48 ? conv2_recvData : conv2_zpWideBits);
  assign _zz_conv2_inputBuf_0_port_3 = ((_zz_47 || _zz_48) || ((((conv2_stateReg == conv2_sReceiveRow) && _zz_45) && (! conv2_isReal)) && _zz_46));
  assign _zz_conv2_rowWideReads_1_1 = 1'b1;
  assign _zz_conv2_inputBuf_1_port_1 = (_zz_52 ? conv2_initAddrReg : conv2_rxAddr);
  assign _zz_conv2_inputBuf_1_port_2 = (_zz_53 ? conv2_recvData : conv2_zpWideBits);
  assign _zz_conv2_inputBuf_1_port_3 = ((_zz_52 || _zz_53) || ((((conv2_stateReg == conv2_sReceiveRow) && _zz_50) && (! conv2_isReal)) && _zz_51));
  assign _zz_conv2_rowWideReads_2_1 = 1'b1;
  assign _zz_conv2_inputBuf_2_port_1 = (_zz_57 ? conv2_initAddrReg : conv2_rxAddr);
  assign _zz_conv2_inputBuf_2_port_2 = (_zz_58 ? conv2_recvData : conv2_zpWideBits);
  assign _zz_conv2_inputBuf_2_port_3 = ((_zz_57 || _zz_58) || ((((conv2_stateReg == conv2_sReceiveRow) && _zz_55) && (! conv2_isReal)) && _zz_56));
  assign _zz_conv2_rowWideReads_3_1 = 1'b1;
  assign _zz_conv2_inputBuf_3_port_1 = (_zz_62 ? conv2_initAddrReg : conv2_rxAddr);
  assign _zz_conv2_inputBuf_3_port_2 = (_zz_63 ? conv2_recvData : conv2_zpWideBits);
  assign _zz_conv2_inputBuf_3_port_3 = ((_zz_62 || _zz_63) || ((((conv2_stateReg == conv2_sReceiveRow) && _zz_60) && (! conv2_isReal)) && _zz_61));
  assign _zz_conv2_rowWideReads_4_1 = 1'b1;
  assign _zz_conv2_inputBuf_4_port_1 = (_zz_67 ? conv2_initAddrReg : conv2_rxAddr);
  assign _zz_conv2_inputBuf_4_port_2 = (_zz_68 ? conv2_recvData : conv2_zpWideBits);
  assign _zz_conv2_inputBuf_4_port_3 = ((_zz_67 || _zz_68) || ((((conv2_stateReg == conv2_sReceiveRow) && _zz_65) && (! conv2_isReal)) && _zz_66));
  assign _zz_conv2_wDataRaw_1 = 1'b1;
  assign _zz_conv2_biasVal_2 = 1'b1;
  assign _zz_pool2_rowReads_0_1 = 1'b1;
  assign _zz_pool2_rowBuf_0_port_1 = ReLUPlugin_logic_outStream_payload_value_1;
  assign _zz_pool2_rowBuf_0_port_2 = ((((pool2_stateReg == pool2_sReceiveRow) && (pool2_rowWrPtrReg == 2'b00)) && ReLUPlugin_logic_outStream_fire_1) && (! (4'b1100 <= pool2_realRowsRecvReg)));
  assign _zz_pool2_rowReads_1_1 = 1'b1;
  assign _zz_pool2_rowBuf_1_port_1 = ReLUPlugin_logic_outStream_payload_value_1;
  assign _zz_pool2_rowBuf_1_port_2 = ((((pool2_stateReg == pool2_sReceiveRow) && (pool2_rowWrPtrReg == 2'b01)) && ReLUPlugin_logic_outStream_fire_1) && (! (4'b1100 <= pool2_realRowsRecvReg)));
  assign _zz_pool2_rowReads_2_1 = 1'b1;
  assign _zz_pool2_rowBuf_2_port_1 = ReLUPlugin_logic_outStream_payload_value_1;
  assign _zz_pool2_rowBuf_2_port_2 = ((((pool2_stateReg == pool2_sReceiveRow) && (pool2_rowWrPtrReg == 2'b10)) && ReLUPlugin_logic_outStream_fire_1) && (! (4'b1100 <= pool2_realRowsRecvReg)));
  assign _zz_linear1_inValR = 1'b1;
  assign _zz_linear1_inputBuf_port_2 = MaxPoolLinePlugin_logic_outStream_payload_value_1;
  assign _zz_linear1_wValR = 1'b1;
  assign _zz_linear1_biasVal_1 = 1'b1;
  always @(posedge clk) begin
    if(_zz_conv1_rowWideReads_0_2) begin
      conv1_inputBuf_0_spinal_port0 <= conv1_inputBuf_0[_zz_conv1_rowWideReads_0_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv1_inputBuf_0_port_5) begin
      conv1_inputBuf_0[_zz_conv1_inputBuf_0_port_2] <= _zz_conv1_inputBuf_0_port_4;
    end
  end

  always @(posedge clk) begin
    if(_zz_conv1_rowWideReads_1_2) begin
      conv1_inputBuf_1_spinal_port0 <= conv1_inputBuf_1[_zz_conv1_rowWideReads_1_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv1_inputBuf_1_port_5) begin
      conv1_inputBuf_1[_zz_conv1_inputBuf_1_port_2] <= _zz_conv1_inputBuf_1_port_4;
    end
  end

  always @(posedge clk) begin
    if(_zz_conv1_rowWideReads_2_2) begin
      conv1_inputBuf_2_spinal_port0 <= conv1_inputBuf_2[_zz_conv1_rowWideReads_2_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv1_inputBuf_2_port_5) begin
      conv1_inputBuf_2[_zz_conv1_inputBuf_2_port_2] <= _zz_conv1_inputBuf_2_port_4;
    end
  end

  always @(posedge clk) begin
    if(_zz_conv1_rowWideReads_3_2) begin
      conv1_inputBuf_3_spinal_port0 <= conv1_inputBuf_3[_zz_conv1_rowWideReads_3_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv1_inputBuf_3_port_5) begin
      conv1_inputBuf_3[_zz_conv1_inputBuf_3_port_2] <= _zz_conv1_inputBuf_3_port_4;
    end
  end

  always @(posedge clk) begin
    if(_zz_conv1_rowWideReads_4_2) begin
      conv1_inputBuf_4_spinal_port0 <= conv1_inputBuf_4[_zz_conv1_rowWideReads_4_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv1_inputBuf_4_port_5) begin
      conv1_inputBuf_4[_zz_conv1_inputBuf_4_port_2] <= _zz_conv1_inputBuf_4_port_4;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv1_weightRom.bin",conv1_weightRom);
  end
  always @(posedge clk) begin
    if(_zz_conv1_wDataRaw_1) begin
      conv1_weightRom_spinal_port0 <= conv1_weightRom[_zz_conv1_wDataRaw];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv1_biasRom.bin",conv1_biasRom);
  end
  always @(posedge clk) begin
    if(_zz_conv1_biasVal_2) begin
      conv1_biasRom_spinal_port0 <= conv1_biasRom[_zz_conv1_biasVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_pool1_rowReads_0_1) begin
      pool1_rowBuf_0_spinal_port0 <= pool1_rowBuf_0[_zz_pool1_rowReads_0];
    end
  end

  always @(posedge clk) begin
    if(_zz_pool1_rowBuf_0_port_2) begin
      pool1_rowBuf_0[pool1_rxStepReg] <= _zz_pool1_rowBuf_0_port_1;
    end
  end

  always @(posedge clk) begin
    if(_zz_pool1_rowReads_1_1) begin
      pool1_rowBuf_1_spinal_port0 <= pool1_rowBuf_1[_zz_pool1_rowReads_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_pool1_rowBuf_1_port_2) begin
      pool1_rowBuf_1[pool1_rxStepReg] <= _zz_pool1_rowBuf_1_port_1;
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_rowWideReads_0_1) begin
      conv2_inputBuf_0_spinal_port0 <= conv2_inputBuf_0[_zz_conv2_rowWideReads_0];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_inputBuf_0_port_3) begin
      conv2_inputBuf_0[_zz_conv2_inputBuf_0_port_1] <= _zz_conv2_inputBuf_0_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_rowWideReads_1_1) begin
      conv2_inputBuf_1_spinal_port0 <= conv2_inputBuf_1[_zz_conv2_rowWideReads_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_inputBuf_1_port_3) begin
      conv2_inputBuf_1[_zz_conv2_inputBuf_1_port_1] <= _zz_conv2_inputBuf_1_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_rowWideReads_2_1) begin
      conv2_inputBuf_2_spinal_port0 <= conv2_inputBuf_2[_zz_conv2_rowWideReads_2];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_inputBuf_2_port_3) begin
      conv2_inputBuf_2[_zz_conv2_inputBuf_2_port_1] <= _zz_conv2_inputBuf_2_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_rowWideReads_3_1) begin
      conv2_inputBuf_3_spinal_port0 <= conv2_inputBuf_3[_zz_conv2_rowWideReads_3];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_inputBuf_3_port_3) begin
      conv2_inputBuf_3[_zz_conv2_inputBuf_3_port_1] <= _zz_conv2_inputBuf_3_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_rowWideReads_4_1) begin
      conv2_inputBuf_4_spinal_port0 <= conv2_inputBuf_4[_zz_conv2_rowWideReads_4];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_inputBuf_4_port_3) begin
      conv2_inputBuf_4[_zz_conv2_inputBuf_4_port_1] <= _zz_conv2_inputBuf_4_port_2;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv2_weightRom.bin",conv2_weightRom);
  end
  always @(posedge clk) begin
    if(_zz_conv2_wDataRaw_1) begin
      conv2_weightRom_spinal_port0 <= conv2_weightRom[_zz_conv2_wDataRaw];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv2_biasRom.bin",conv2_biasRom);
  end
  always @(posedge clk) begin
    if(_zz_conv2_biasVal_2) begin
      conv2_biasRom_spinal_port0 <= conv2_biasRom[_zz_conv2_biasVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_pool2_rowReads_0_1) begin
      pool2_rowBuf_0_spinal_port0 <= pool2_rowBuf_0[_zz_pool2_rowReads_0];
    end
  end

  always @(posedge clk) begin
    if(_zz_pool2_rowBuf_0_port_2) begin
      pool2_rowBuf_0[pool2_rxStepReg] <= _zz_pool2_rowBuf_0_port_1;
    end
  end

  always @(posedge clk) begin
    if(_zz_pool2_rowReads_1_1) begin
      pool2_rowBuf_1_spinal_port0 <= pool2_rowBuf_1[_zz_pool2_rowReads_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_pool2_rowBuf_1_port_2) begin
      pool2_rowBuf_1[pool2_rxStepReg] <= _zz_pool2_rowBuf_1_port_1;
    end
  end

  always @(posedge clk) begin
    if(_zz_pool2_rowReads_2_1) begin
      pool2_rowBuf_2_spinal_port0 <= pool2_rowBuf_2[_zz_pool2_rowReads_2];
    end
  end

  always @(posedge clk) begin
    if(_zz_pool2_rowBuf_2_port_2) begin
      pool2_rowBuf_2[pool2_rxStepReg] <= _zz_pool2_rowBuf_2_port_1;
    end
  end

  always @(posedge clk) begin
    if(_zz_linear1_inValR) begin
      linear1_inputBuf_spinal_port0 <= linear1_inputBuf[linear1_inAddrComb];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      linear1_inputBuf[_zz_linear1_inputBuf_port_1] <= _zz_linear1_inputBuf_port_2;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_linear1_weightRom.bin",linear1_weightRom);
  end
  always @(posedge clk) begin
    if(_zz_linear1_wValR) begin
      linear1_weightRom_spinal_port0 <= linear1_weightRom[linear1_wAddrComb];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_linear1_biasRom.bin",linear1_biasRom);
  end
  always @(posedge clk) begin
    if(_zz_linear1_biasVal_1) begin
      linear1_biasRom_spinal_port0 <= linear1_biasRom[_zz_linear1_biasVal];
    end
  end

  always @(*) begin
    case(conv1_curSlotReg)
      3'b000 : _zz_conv1_inValReg_0 = conv1_rowReads2D_0_0;
      3'b001 : _zz_conv1_inValReg_0 = conv1_rowReads2D_1_0;
      3'b010 : _zz_conv1_inValReg_0 = conv1_rowReads2D_2_0;
      3'b011 : _zz_conv1_inValReg_0 = conv1_rowReads2D_3_0;
      default : _zz_conv1_inValReg_0 = conv1_rowReads2D_4_0;
    endcase
  end

  always @(*) begin
    case(pool1_curSlotReg)
      1'b0 : _zz_pool1_readData = pool1_rowReads_0;
      default : _zz_pool1_readData = pool1_rowReads_1;
    endcase
  end

  always @(*) begin
    case(conv2_curSlotReg)
      3'b000 : begin
        _zz_conv2_inValReg_0 = conv2_rowReads2D_0_0;
        _zz_conv2_inValReg_1 = conv2_rowReads2D_0_1;
        _zz_conv2_inValReg_2 = conv2_rowReads2D_0_2;
        _zz_conv2_inValReg_3 = conv2_rowReads2D_0_3;
        _zz_conv2_inValReg_4 = conv2_rowReads2D_0_4;
        _zz_conv2_inValReg_5 = conv2_rowReads2D_0_5;
        _zz_conv2_inValReg_6 = conv2_rowReads2D_0_6;
        _zz_conv2_inValReg_7 = conv2_rowReads2D_0_7;
      end
      3'b001 : begin
        _zz_conv2_inValReg_0 = conv2_rowReads2D_1_0;
        _zz_conv2_inValReg_1 = conv2_rowReads2D_1_1;
        _zz_conv2_inValReg_2 = conv2_rowReads2D_1_2;
        _zz_conv2_inValReg_3 = conv2_rowReads2D_1_3;
        _zz_conv2_inValReg_4 = conv2_rowReads2D_1_4;
        _zz_conv2_inValReg_5 = conv2_rowReads2D_1_5;
        _zz_conv2_inValReg_6 = conv2_rowReads2D_1_6;
        _zz_conv2_inValReg_7 = conv2_rowReads2D_1_7;
      end
      3'b010 : begin
        _zz_conv2_inValReg_0 = conv2_rowReads2D_2_0;
        _zz_conv2_inValReg_1 = conv2_rowReads2D_2_1;
        _zz_conv2_inValReg_2 = conv2_rowReads2D_2_2;
        _zz_conv2_inValReg_3 = conv2_rowReads2D_2_3;
        _zz_conv2_inValReg_4 = conv2_rowReads2D_2_4;
        _zz_conv2_inValReg_5 = conv2_rowReads2D_2_5;
        _zz_conv2_inValReg_6 = conv2_rowReads2D_2_6;
        _zz_conv2_inValReg_7 = conv2_rowReads2D_2_7;
      end
      3'b011 : begin
        _zz_conv2_inValReg_0 = conv2_rowReads2D_3_0;
        _zz_conv2_inValReg_1 = conv2_rowReads2D_3_1;
        _zz_conv2_inValReg_2 = conv2_rowReads2D_3_2;
        _zz_conv2_inValReg_3 = conv2_rowReads2D_3_3;
        _zz_conv2_inValReg_4 = conv2_rowReads2D_3_4;
        _zz_conv2_inValReg_5 = conv2_rowReads2D_3_5;
        _zz_conv2_inValReg_6 = conv2_rowReads2D_3_6;
        _zz_conv2_inValReg_7 = conv2_rowReads2D_3_7;
      end
      default : begin
        _zz_conv2_inValReg_0 = conv2_rowReads2D_4_0;
        _zz_conv2_inValReg_1 = conv2_rowReads2D_4_1;
        _zz_conv2_inValReg_2 = conv2_rowReads2D_4_2;
        _zz_conv2_inValReg_3 = conv2_rowReads2D_4_3;
        _zz_conv2_inValReg_4 = conv2_rowReads2D_4_4;
        _zz_conv2_inValReg_5 = conv2_rowReads2D_4_5;
        _zz_conv2_inValReg_6 = conv2_rowReads2D_4_6;
        _zz_conv2_inValReg_7 = conv2_rowReads2D_4_7;
      end
    endcase
  end

  always @(*) begin
    case(pool2_curSlotReg)
      2'b00 : _zz_pool2_readData = pool2_rowReads_0;
      2'b01 : _zz_pool2_readData = pool2_rowReads_1;
      default : _zz_pool2_readData = pool2_rowReads_2;
    endcase
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(when_QLinearLinearCore_l174) begin
      if(MaxPoolLinePlugin_logic_outStream_fire_1) begin
        _zz_1 = 1'b1;
      end
    end
  end

  assign conv1_zpWideBits = 8'h0;
  assign conv1_sReceiveRow = 4'b0000;
  assign conv1_sLoadBias = 4'b0001;
  assign conv1_sWaitBias = 4'b0010;
  assign conv1_sCompute = 4'b0011;
  assign conv1_sRequant = 4'b0100;
  assign conv1_sRequantMul = 4'b0101;
  assign conv1_sRequantWait = 4'b0110;
  assign conv1_sRequantWait2 = 4'b0111;
  assign conv1_sRequantWait3 = 4'b1000;
  assign conv1_sRequantShift = 4'b1001;
  assign conv1_sEmit = 4'b1010;
  assign conv1_sInit = 4'b1011;
  assign conv1_sLoadWeights = 4'b1100;
  assign conv1_rowAddrComb = conv1_rowAddrReg;
  assign conv1_wAddrComb = conv1_wAddrReg;
  assign conv1_rxAddr = (6'h02 + _zz_conv1_rxAddr);
  assign _zz_conv1_rowWideReads_0 = conv1_rowAddrComb;
  assign conv1_rowWideReads_0 = conv1_inputBuf_0_spinal_port0;
  assign _zz_conv1_rowWideReads_1 = conv1_rowAddrComb;
  assign conv1_rowWideReads_1 = conv1_inputBuf_1_spinal_port0;
  assign _zz_conv1_rowWideReads_2 = conv1_rowAddrComb;
  assign conv1_rowWideReads_2 = conv1_inputBuf_2_spinal_port0;
  assign _zz_conv1_rowWideReads_3 = conv1_rowAddrComb;
  assign conv1_rowWideReads_3 = conv1_inputBuf_3_spinal_port0;
  assign _zz_conv1_rowWideReads_4 = conv1_rowAddrComb;
  assign conv1_rowWideReads_4 = conv1_inputBuf_4_spinal_port0;
  assign conv1_rowReads2D_0_0 = conv1_rowWideReads_0[7 : 0];
  assign conv1_rowReads2D_1_0 = conv1_rowWideReads_1[7 : 0];
  assign conv1_rowReads2D_2_0 = conv1_rowWideReads_2[7 : 0];
  assign conv1_rowReads2D_3_0 = conv1_rowWideReads_3[7 : 0];
  assign conv1_rowReads2D_4_0 = conv1_rowWideReads_4[7 : 0];
  assign _zz_conv1_wDataRaw = conv1_wAddrComb;
  assign conv1_wDataRaw = conv1_weightRom_spinal_port0;
  assign conv1_wValsRaw_0 = conv1_wDataRaw[3 : 0];
  assign _zz_conv1_biasVal = conv1_outChReg;
  assign conv1_biasVal = conv1_biasRom_spinal_port0;
  assign conv1_isReal = (conv1_realRowsRecvReg < 5'h1c);
  assign io_activationIn_fire = (activation_in_valid && activation_in_ready);
  assign when_QLinearConvLineCore_l371 = ((((conv1_stateReg == conv1_sReceiveRow) && conv1_isReal) && io_activationIn_fire) && (conv1_rxBankReg == 1'b0));
  assign conv1_recvDataSeq_0 = activation_in_data;
  assign conv1_recvData = conv1_recvDataSeq_0;
  assign _zz_9 = (conv1_rowWrPtrReg == 3'b000);
  assign _zz_10 = (conv1_rxBankReg == 1'b0);
  assign _zz_11 = ((conv1_stateReg == conv1_sInit) && (conv1_initSlotReg == 3'b000));
  assign _zz_12 = (((((conv1_stateReg == conv1_sReceiveRow) && _zz_9) && conv1_isReal) && io_activationIn_fire) && _zz_10);
  assign _zz_14 = (conv1_rowWrPtrReg == 3'b001);
  assign _zz_15 = (conv1_rxBankReg == 1'b0);
  assign _zz_16 = ((conv1_stateReg == conv1_sInit) && (conv1_initSlotReg == 3'b001));
  assign _zz_17 = (((((conv1_stateReg == conv1_sReceiveRow) && _zz_14) && conv1_isReal) && io_activationIn_fire) && _zz_15);
  assign _zz_19 = (conv1_rowWrPtrReg == 3'b010);
  assign _zz_20 = (conv1_rxBankReg == 1'b0);
  assign _zz_21 = ((conv1_stateReg == conv1_sInit) && (conv1_initSlotReg == 3'b010));
  assign _zz_22 = (((((conv1_stateReg == conv1_sReceiveRow) && _zz_19) && conv1_isReal) && io_activationIn_fire) && _zz_20);
  assign _zz_24 = (conv1_rowWrPtrReg == 3'b011);
  assign _zz_25 = (conv1_rxBankReg == 1'b0);
  assign _zz_26 = ((conv1_stateReg == conv1_sInit) && (conv1_initSlotReg == 3'b011));
  assign _zz_27 = (((((conv1_stateReg == conv1_sReceiveRow) && _zz_24) && conv1_isReal) && io_activationIn_fire) && _zz_25);
  assign _zz_29 = (conv1_rowWrPtrReg == 3'b100);
  assign _zz_30 = (conv1_rxBankReg == 1'b0);
  assign _zz_31 = ((conv1_stateReg == conv1_sInit) && (conv1_initSlotReg == 3'b100));
  assign _zz_32 = (((((conv1_stateReg == conv1_sReceiveRow) && _zz_29) && conv1_isReal) && io_activationIn_fire) && _zz_30);
  always @(*) begin
    activation_in_ready = 1'b0;
    if(when_QLinearConvLineCore_l431) begin
      activation_in_ready = conv1_isReal;
    end
  end

  always @(*) begin
    conv1_activationOut_valid = 1'b0;
    if(when_QLinearConvLineCore_l672) begin
      conv1_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    conv1_activationOut_payload_value = conv1_rqReg_2;
    if(when_QLinearConvLineCore_l672) begin
      conv1_activationOut_payload_value = conv1_rqReg_2;
    end
  end

  assign when_QLinearConvLineCore_l407 = (conv1_stateReg == conv1_sInit);
  assign when_QLinearConvLineCore_l409 = (conv1_initAddrReg == 6'h1f);
  assign when_QLinearConvLineCore_l412 = (conv1_initSlotReg == 3'b100);
  assign when_QLinearConvLineCore_l431 = (conv1_stateReg == conv1_sReceiveRow);
  assign when_QLinearConvLineCore_l435 = ((conv1_isReal && io_activationIn_fire) || (! conv1_isReal));
  assign when_QLinearConvLineCore_l438 = (conv1_rxBankReg == 1'b0);
  assign when_QLinearConvLineCore_l443 = (when_QLinearConvLineCore_l438 && (conv1_rxWordReg == 5'h1b));
  assign when_QLinearConvLineCore_l449 = (conv1_rowsUntilComputeReg <= 3'b001);
  assign when_QLinearConvLineCore_l492 = (conv1_stateReg == conv1_sLoadBias);
  assign _zz_conv1_rowAddrBaseReg = (conv1_outColReg * 1'b1);
  assign when_QLinearConvLineCore_l505 = (conv1_stateReg == conv1_sWaitBias);
  assign when_QLinearConvLineCore_l532 = (conv1_stateReg == conv1_sCompute);
  assign when_QLinearConvLineCore_l536 = (conv1_compCycleReg < 5'h19);
  assign _zz_conv1_curSlotReg = (_zz__zz_conv1_curSlotReg + _zz__zz_conv1_curSlotReg_1);
  assign when_QLinearConvLineCore_l540 = (conv1_rowStepReg == 3'b100);
  assign when_QLinearConvLineCore_l551 = ((5'h01 <= conv1_compCycleReg) && (conv1_compCycleReg <= 5'h19));
  assign when_QLinearConvLineCore_l564 = ((5'h02 <= conv1_compCycleReg) && (conv1_compCycleReg <= 5'h1a));
  assign _zz_conv1_lutProdReg_0 = conv1_wValReg_0;
  assign _zz_conv1_lutProdReg_0_1 = {{23{_zz__zz_conv1_lutProdReg_0_1[8]}}, _zz__zz_conv1_lutProdReg_0_1};
  assign when_QLinearConvLineCore_l579 = ((5'h03 <= conv1_compCycleReg) && (conv1_compCycleReg <= 5'h1b));
  assign when_QLinearConvLineCore_l584 = ((5'h04 <= conv1_compCycleReg) && (conv1_compCycleReg <= 5'h1c));
  assign _zz_conv1_rqReg_0 = ($signed(conv1_rqReg_0) + $signed(conv1_rqReg_1));
  assign when_QLinearConvLineCore_l587 = (conv1_compCycleReg == 5'h1c);
  assign when_QLinearConvLineCore_l621 = (conv1_stateReg == conv1_sRequant);
  assign when_QLinearConvLineCore_l627 = (conv1_stateReg == conv1_sRequantMul);
  assign _zz_conv1_rqReg_7 = 32'h4a87ac80;
  assign _zz_conv1_rqReg_9 = conv1_rqReg_6[31 : 16];
  assign _zz_conv1_rqReg_7_1 = conv1_rqReg_6[15 : 0];
  assign _zz_conv1_rqReg_8 = _zz_conv1_rqReg_7[31 : 16];
  assign _zz_conv1_rqReg_7_2 = _zz_conv1_rqReg_7[15 : 0];
  assign when_QLinearConvLineCore_l639 = (conv1_stateReg == conv1_sRequantWait);
  assign when_QLinearConvLineCore_l646 = (conv1_stateReg == conv1_sRequantWait2);
  assign when_QLinearConvLineCore_l652 = (conv1_stateReg == conv1_sRequantWait3);
  assign _zz_conv1_rqReg_4 = (conv1_rqReg_14 + conv1_rqReg_15);
  assign when_QLinearConvLineCore_l659 = (conv1_stateReg == conv1_sRequantShift);
  assign _zz_conv1_rqReg_2 = ($signed(_zz__zz_conv1_rqReg_2) + $signed(32'h0));
  assign when_QLinearConvLineCore_l672 = (conv1_stateReg == conv1_sEmit);
  assign conv1_activationOut_fire = (conv1_activationOut_valid && conv1_activationOut_ready);
  assign when_QLinearConvLineCore_l684 = (conv1_outChReg == 4'b0111);
  assign when_QLinearConvLineCore_l688 = (conv1_outColReg == 5'h1b);
  assign when_QLinearConvLineCore_l692 = (conv1_outRowReg == 5'h1b);
  assign QLinearConvLineCorePlugin_logic_outStream_valid = conv1_activationOut_valid;
  assign conv1_activationOut_ready = QLinearConvLineCorePlugin_logic_outStream_ready;
  assign QLinearConvLineCorePlugin_logic_outStream_payload_value = conv1_activationOut_payload_value;
  assign relu1_activationOut_valid = QLinearConvLineCorePlugin_logic_outStream_valid;
  assign QLinearConvLineCorePlugin_logic_outStream_ready = relu1_activationOut_ready;
  assign relu1_activationOut_payload_value = (($signed(QLinearConvLineCorePlugin_logic_outStream_payload_value) < $signed(8'h0)) ? 8'h0 : _zz_relu1_activationOut_payload_value);
  assign ReLUPlugin_logic_outStream_valid = relu1_activationOut_valid;
  assign relu1_activationOut_ready = ReLUPlugin_logic_outStream_ready;
  assign ReLUPlugin_logic_outStream_payload_value = relu1_activationOut_payload_value;
  assign pool1_sReceiveRow = 2'b00;
  assign pool1_sPool = 2'b01;
  assign pool1_sEmit = 2'b10;
  always @(*) begin
    pool1_rowAddrComb = 8'h0;
    if(when_MaxPoolLineCore_l237) begin
      if(when_MaxPoolLineCore_l241) begin
        pool1_rowAddrComb = _zz_pool1_rowAddrComb[7:0];
      end
    end
  end

  assign _zz_pool1_rowReads_0 = pool1_rowAddrComb;
  assign pool1_rowReads_0 = pool1_rowBuf_0_spinal_port0;
  assign _zz_pool1_rowReads_1 = pool1_rowAddrComb;
  assign pool1_rowReads_1 = pool1_rowBuf_1_spinal_port0;
  assign pool1_readData = _zz_pool1_readData;
  assign ReLUPlugin_logic_outStream_fire = (ReLUPlugin_logic_outStream_valid && ReLUPlugin_logic_outStream_ready);
  always @(*) begin
    ReLUPlugin_logic_outStream_ready = 1'b0;
    if(when_MaxPoolLineCore_l180) begin
      ReLUPlugin_logic_outStream_ready = 1'b1;
    end
  end

  always @(*) begin
    pool1_activationOut_valid = 1'b0;
    if(when_MaxPoolLineCore_l273) begin
      pool1_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    pool1_activationOut_payload_value = pool1_maxReg;
    if(when_MaxPoolLineCore_l273) begin
      pool1_activationOut_payload_value = pool1_maxReg;
    end
  end

  assign when_MaxPoolLineCore_l180 = (pool1_stateReg == pool1_sReceiveRow);
  assign when_MaxPoolLineCore_l188 = (pool1_rxStepReg == 8'hdf);
  assign when_MaxPoolLineCore_l218 = (pool1_rowsUntilComputeReg <= 2'b01);
  assign when_MaxPoolLineCore_l237 = (pool1_stateReg == pool1_sPool);
  assign when_MaxPoolLineCore_l241 = (pool1_phaseReg < 3'b100);
  assign _zz_pool1_curSlotReg = (_zz__zz_pool1_curSlotReg + _zz__zz_pool1_curSlotReg_1);
  assign when_MaxPoolLineCore_l249 = (pool1_kcReg == 2'b01);
  assign when_MaxPoolLineCore_l253 = (pool1_phaseReg == 3'b010);
  assign when_MaxPoolLineCore_l255 = ((3'b010 < pool1_phaseReg) && (pool1_phaseReg <= 3'b101));
  assign when_MaxPoolLineCore_l260 = (pool1_phaseReg < 3'b110);
  assign when_MaxPoolLineCore_l273 = (pool1_stateReg == pool1_sEmit);
  assign pool1_activationOut_fire = (pool1_activationOut_valid && pool1_activationOut_ready);
  assign when_MaxPoolLineCore_l284 = (pool1_outChReg == 4'b0111);
  assign when_MaxPoolLineCore_l287 = (pool1_outColReg == 4'b1101);
  assign when_MaxPoolLineCore_l291 = (pool1_outRowReg == 4'b1101);
  assign MaxPoolLinePlugin_logic_outStream_valid = pool1_activationOut_valid;
  assign pool1_activationOut_ready = MaxPoolLinePlugin_logic_outStream_ready;
  assign MaxPoolLinePlugin_logic_outStream_payload_value = pool1_activationOut_payload_value;
  assign conv2_zpWideBits = {8'h0,{8'h0,{8'h0,{8'h0,{8'h0,{8'h0,{8'h0,8'h0}}}}}}};
  assign conv2_sReceiveRow = 4'b0000;
  assign conv2_sLoadBias = 4'b0001;
  assign conv2_sWaitBias = 4'b0010;
  assign conv2_sCompute = 4'b0011;
  assign conv2_sRequant = 4'b0100;
  assign conv2_sRequantMul = 4'b0101;
  assign conv2_sRequantWait = 4'b0110;
  assign conv2_sRequantWait2 = 4'b0111;
  assign conv2_sRequantWait3 = 4'b1000;
  assign conv2_sRequantShift = 4'b1001;
  assign conv2_sEmit = 4'b1010;
  assign conv2_sInit = 4'b1011;
  assign conv2_sLoadWeights = 4'b1100;
  assign conv2_rowAddrComb = conv2_rowAddrReg;
  assign conv2_wAddrComb = conv2_wAddrReg;
  assign conv2_rxAddr = (5'h02 + _zz_conv2_rxAddr);
  assign _zz_conv2_rowWideReads_0 = conv2_rowAddrComb;
  assign conv2_rowWideReads_0 = conv2_inputBuf_0_spinal_port0;
  assign _zz_conv2_rowWideReads_1 = conv2_rowAddrComb;
  assign conv2_rowWideReads_1 = conv2_inputBuf_1_spinal_port0;
  assign _zz_conv2_rowWideReads_2 = conv2_rowAddrComb;
  assign conv2_rowWideReads_2 = conv2_inputBuf_2_spinal_port0;
  assign _zz_conv2_rowWideReads_3 = conv2_rowAddrComb;
  assign conv2_rowWideReads_3 = conv2_inputBuf_3_spinal_port0;
  assign _zz_conv2_rowWideReads_4 = conv2_rowAddrComb;
  assign conv2_rowWideReads_4 = conv2_inputBuf_4_spinal_port0;
  assign conv2_rowReads2D_0_0 = conv2_rowWideReads_0[7 : 0];
  assign conv2_rowReads2D_0_1 = conv2_rowWideReads_0[15 : 8];
  assign conv2_rowReads2D_0_2 = conv2_rowWideReads_0[23 : 16];
  assign conv2_rowReads2D_0_3 = conv2_rowWideReads_0[31 : 24];
  assign conv2_rowReads2D_0_4 = conv2_rowWideReads_0[39 : 32];
  assign conv2_rowReads2D_0_5 = conv2_rowWideReads_0[47 : 40];
  assign conv2_rowReads2D_0_6 = conv2_rowWideReads_0[55 : 48];
  assign conv2_rowReads2D_0_7 = conv2_rowWideReads_0[63 : 56];
  assign conv2_rowReads2D_1_0 = conv2_rowWideReads_1[7 : 0];
  assign conv2_rowReads2D_1_1 = conv2_rowWideReads_1[15 : 8];
  assign conv2_rowReads2D_1_2 = conv2_rowWideReads_1[23 : 16];
  assign conv2_rowReads2D_1_3 = conv2_rowWideReads_1[31 : 24];
  assign conv2_rowReads2D_1_4 = conv2_rowWideReads_1[39 : 32];
  assign conv2_rowReads2D_1_5 = conv2_rowWideReads_1[47 : 40];
  assign conv2_rowReads2D_1_6 = conv2_rowWideReads_1[55 : 48];
  assign conv2_rowReads2D_1_7 = conv2_rowWideReads_1[63 : 56];
  assign conv2_rowReads2D_2_0 = conv2_rowWideReads_2[7 : 0];
  assign conv2_rowReads2D_2_1 = conv2_rowWideReads_2[15 : 8];
  assign conv2_rowReads2D_2_2 = conv2_rowWideReads_2[23 : 16];
  assign conv2_rowReads2D_2_3 = conv2_rowWideReads_2[31 : 24];
  assign conv2_rowReads2D_2_4 = conv2_rowWideReads_2[39 : 32];
  assign conv2_rowReads2D_2_5 = conv2_rowWideReads_2[47 : 40];
  assign conv2_rowReads2D_2_6 = conv2_rowWideReads_2[55 : 48];
  assign conv2_rowReads2D_2_7 = conv2_rowWideReads_2[63 : 56];
  assign conv2_rowReads2D_3_0 = conv2_rowWideReads_3[7 : 0];
  assign conv2_rowReads2D_3_1 = conv2_rowWideReads_3[15 : 8];
  assign conv2_rowReads2D_3_2 = conv2_rowWideReads_3[23 : 16];
  assign conv2_rowReads2D_3_3 = conv2_rowWideReads_3[31 : 24];
  assign conv2_rowReads2D_3_4 = conv2_rowWideReads_3[39 : 32];
  assign conv2_rowReads2D_3_5 = conv2_rowWideReads_3[47 : 40];
  assign conv2_rowReads2D_3_6 = conv2_rowWideReads_3[55 : 48];
  assign conv2_rowReads2D_3_7 = conv2_rowWideReads_3[63 : 56];
  assign conv2_rowReads2D_4_0 = conv2_rowWideReads_4[7 : 0];
  assign conv2_rowReads2D_4_1 = conv2_rowWideReads_4[15 : 8];
  assign conv2_rowReads2D_4_2 = conv2_rowWideReads_4[23 : 16];
  assign conv2_rowReads2D_4_3 = conv2_rowWideReads_4[31 : 24];
  assign conv2_rowReads2D_4_4 = conv2_rowWideReads_4[39 : 32];
  assign conv2_rowReads2D_4_5 = conv2_rowWideReads_4[47 : 40];
  assign conv2_rowReads2D_4_6 = conv2_rowWideReads_4[55 : 48];
  assign conv2_rowReads2D_4_7 = conv2_rowWideReads_4[63 : 56];
  assign _zz_conv2_wDataRaw = conv2_wAddrComb;
  assign conv2_wDataRaw = conv2_weightRom_spinal_port0;
  assign conv2_wValsRaw_0 = conv2_wDataRaw[3 : 0];
  assign conv2_wValsRaw_1 = conv2_wDataRaw[7 : 4];
  assign conv2_wValsRaw_2 = conv2_wDataRaw[11 : 8];
  assign conv2_wValsRaw_3 = conv2_wDataRaw[15 : 12];
  assign conv2_wValsRaw_4 = conv2_wDataRaw[19 : 16];
  assign conv2_wValsRaw_5 = conv2_wDataRaw[23 : 20];
  assign conv2_wValsRaw_6 = conv2_wDataRaw[27 : 24];
  assign conv2_wValsRaw_7 = conv2_wDataRaw[31 : 28];
  assign _zz_conv2_biasVal = conv2_outChReg;
  assign conv2_biasVal = conv2_biasRom_spinal_port0;
  assign conv2_isReal = (conv2_realRowsRecvReg < 4'b1110);
  assign MaxPoolLinePlugin_logic_outStream_fire = (MaxPoolLinePlugin_logic_outStream_valid && MaxPoolLinePlugin_logic_outStream_ready);
  assign when_QLinearConvLineCore_l371_1 = ((((conv2_stateReg == conv2_sReceiveRow) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && (conv2_rxBankReg == 4'b0000));
  assign when_QLinearConvLineCore_l371_2 = ((((conv2_stateReg == conv2_sReceiveRow) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && (conv2_rxBankReg == 4'b0001));
  assign when_QLinearConvLineCore_l371_3 = ((((conv2_stateReg == conv2_sReceiveRow) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && (conv2_rxBankReg == 4'b0010));
  assign when_QLinearConvLineCore_l371_4 = ((((conv2_stateReg == conv2_sReceiveRow) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && (conv2_rxBankReg == 4'b0011));
  assign when_QLinearConvLineCore_l371_5 = ((((conv2_stateReg == conv2_sReceiveRow) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && (conv2_rxBankReg == 4'b0100));
  assign when_QLinearConvLineCore_l371_6 = ((((conv2_stateReg == conv2_sReceiveRow) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && (conv2_rxBankReg == 4'b0101));
  assign when_QLinearConvLineCore_l371_7 = ((((conv2_stateReg == conv2_sReceiveRow) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && (conv2_rxBankReg == 4'b0110));
  assign when_QLinearConvLineCore_l371_8 = ((((conv2_stateReg == conv2_sReceiveRow) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && (conv2_rxBankReg == 4'b0111));
  assign conv2_recvDataSeq_7 = MaxPoolLinePlugin_logic_outStream_payload_value;
  assign conv2_recvData = {conv2_recvDataSeq_7,{conv2_rxByteRegs_6,{conv2_rxByteRegs_5,{conv2_rxByteRegs_4,{conv2_rxByteRegs_3,{conv2_rxByteRegs_2,{conv2_rxByteRegs_1,conv2_rxByteRegs_0}}}}}}};
  assign _zz_45 = (conv2_rowWrPtrReg == 3'b000);
  assign _zz_46 = (conv2_rxBankReg == 4'b0111);
  assign _zz_47 = ((conv2_stateReg == conv2_sInit) && (conv2_initSlotReg == 3'b000));
  assign _zz_48 = (((((conv2_stateReg == conv2_sReceiveRow) && _zz_45) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && _zz_46);
  assign _zz_50 = (conv2_rowWrPtrReg == 3'b001);
  assign _zz_51 = (conv2_rxBankReg == 4'b0111);
  assign _zz_52 = ((conv2_stateReg == conv2_sInit) && (conv2_initSlotReg == 3'b001));
  assign _zz_53 = (((((conv2_stateReg == conv2_sReceiveRow) && _zz_50) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && _zz_51);
  assign _zz_55 = (conv2_rowWrPtrReg == 3'b010);
  assign _zz_56 = (conv2_rxBankReg == 4'b0111);
  assign _zz_57 = ((conv2_stateReg == conv2_sInit) && (conv2_initSlotReg == 3'b010));
  assign _zz_58 = (((((conv2_stateReg == conv2_sReceiveRow) && _zz_55) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && _zz_56);
  assign _zz_60 = (conv2_rowWrPtrReg == 3'b011);
  assign _zz_61 = (conv2_rxBankReg == 4'b0111);
  assign _zz_62 = ((conv2_stateReg == conv2_sInit) && (conv2_initSlotReg == 3'b011));
  assign _zz_63 = (((((conv2_stateReg == conv2_sReceiveRow) && _zz_60) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && _zz_61);
  assign _zz_65 = (conv2_rowWrPtrReg == 3'b100);
  assign _zz_66 = (conv2_rxBankReg == 4'b0111);
  assign _zz_67 = ((conv2_stateReg == conv2_sInit) && (conv2_initSlotReg == 3'b100));
  assign _zz_68 = (((((conv2_stateReg == conv2_sReceiveRow) && _zz_65) && conv2_isReal) && MaxPoolLinePlugin_logic_outStream_fire) && _zz_66);
  always @(*) begin
    MaxPoolLinePlugin_logic_outStream_ready = 1'b0;
    if(when_QLinearConvLineCore_l431_1) begin
      MaxPoolLinePlugin_logic_outStream_ready = conv2_isReal;
    end
  end

  always @(*) begin
    conv2_activationOut_valid = 1'b0;
    if(when_QLinearConvLineCore_l672_1) begin
      conv2_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    conv2_activationOut_payload_value = conv2_rqReg_2;
    if(when_QLinearConvLineCore_l672_1) begin
      conv2_activationOut_payload_value = conv2_rqReg_2;
    end
  end

  assign when_QLinearConvLineCore_l407_1 = (conv2_stateReg == conv2_sInit);
  assign when_QLinearConvLineCore_l409_1 = (conv2_initAddrReg == 5'h11);
  assign when_QLinearConvLineCore_l412_1 = (conv2_initSlotReg == 3'b100);
  assign when_QLinearConvLineCore_l431_1 = (conv2_stateReg == conv2_sReceiveRow);
  assign when_QLinearConvLineCore_l435_1 = ((conv2_isReal && MaxPoolLinePlugin_logic_outStream_fire) || (! conv2_isReal));
  assign when_QLinearConvLineCore_l438_1 = (conv2_rxBankReg == 4'b0111);
  assign when_QLinearConvLineCore_l443_1 = (when_QLinearConvLineCore_l438_1 && (conv2_rxWordReg == 4'b1101));
  assign when_QLinearConvLineCore_l449_1 = (conv2_rowsUntilComputeReg <= 3'b001);
  assign when_QLinearConvLineCore_l492_1 = (conv2_stateReg == conv2_sLoadBias);
  assign _zz_conv2_rowAddrBaseReg = (conv2_outColReg * 1'b1);
  assign when_QLinearConvLineCore_l505_1 = (conv2_stateReg == conv2_sWaitBias);
  assign when_QLinearConvLineCore_l532_1 = (conv2_stateReg == conv2_sCompute);
  assign when_QLinearConvLineCore_l536_1 = (conv2_compCycleReg < 5'h19);
  assign _zz_conv2_curSlotReg = (_zz__zz_conv2_curSlotReg + _zz__zz_conv2_curSlotReg_1);
  assign when_QLinearConvLineCore_l540_1 = (conv2_rowStepReg == 3'b100);
  assign when_QLinearConvLineCore_l551_1 = ((5'h01 <= conv2_compCycleReg) && (conv2_compCycleReg <= 5'h19));
  assign when_QLinearConvLineCore_l564_1 = ((5'h02 <= conv2_compCycleReg) && (conv2_compCycleReg <= 5'h1a));
  assign _zz_conv2_lutProdReg_0 = 9'h0;
  assign _zz_conv2_lutProdReg_0_1 = conv2_wValReg_0;
  assign _zz_conv2_lutProdReg_0_2 = {{23{_zz__zz_conv2_lutProdReg_0_2[8]}}, _zz__zz_conv2_lutProdReg_0_2};
  assign _zz_conv2_lutProdReg_1 = conv2_wValReg_1;
  assign _zz_conv2_lutProdReg_1_1 = {{23{_zz__zz_conv2_lutProdReg_1_1[8]}}, _zz__zz_conv2_lutProdReg_1_1};
  assign _zz_conv2_lutProdReg_2 = conv2_wValReg_2;
  assign _zz_conv2_lutProdReg_2_1 = {{23{_zz__zz_conv2_lutProdReg_2_1[8]}}, _zz__zz_conv2_lutProdReg_2_1};
  assign _zz_conv2_lutProdReg_3 = conv2_wValReg_3;
  assign _zz_conv2_lutProdReg_3_1 = {{23{_zz__zz_conv2_lutProdReg_3_1[8]}}, _zz__zz_conv2_lutProdReg_3_1};
  assign _zz_conv2_lutProdReg_4 = conv2_wValReg_4;
  assign _zz_conv2_lutProdReg_4_1 = {{23{_zz__zz_conv2_lutProdReg_4_1[8]}}, _zz__zz_conv2_lutProdReg_4_1};
  assign _zz_conv2_lutProdReg_5 = conv2_wValReg_5;
  assign _zz_conv2_lutProdReg_5_1 = {{23{_zz__zz_conv2_lutProdReg_5_1[8]}}, _zz__zz_conv2_lutProdReg_5_1};
  assign _zz_conv2_lutProdReg_6 = conv2_wValReg_6;
  assign _zz_conv2_lutProdReg_6_1 = {{23{_zz__zz_conv2_lutProdReg_6_1[8]}}, _zz__zz_conv2_lutProdReg_6_1};
  assign _zz_conv2_lutProdReg_7 = conv2_wValReg_7;
  assign _zz_conv2_lutProdReg_7_1 = {{23{_zz__zz_conv2_lutProdReg_7_1[8]}}, _zz__zz_conv2_lutProdReg_7_1};
  assign when_QLinearConvLineCore_l579_1 = ((5'h03 <= conv2_compCycleReg) && (conv2_compCycleReg <= 5'h1b));
  assign when_QLinearConvLineCore_l584_1 = ((5'h04 <= conv2_compCycleReg) && (conv2_compCycleReg <= 5'h1c));
  assign _zz_conv2_rqReg_0 = ($signed(conv2_rqReg_0) + $signed(conv2_rqReg_1));
  assign when_QLinearConvLineCore_l587_1 = (conv2_compCycleReg == 5'h1c);
  assign when_QLinearConvLineCore_l621_1 = (conv2_stateReg == conv2_sRequant);
  assign when_QLinearConvLineCore_l627_1 = (conv2_stateReg == conv2_sRequantMul);
  assign _zz_conv2_rqReg_7 = 32'h529c5300;
  assign _zz_conv2_rqReg_9 = conv2_rqReg_6[31 : 16];
  assign _zz_conv2_rqReg_7_1 = conv2_rqReg_6[15 : 0];
  assign _zz_conv2_rqReg_8 = _zz_conv2_rqReg_7[31 : 16];
  assign _zz_conv2_rqReg_7_2 = _zz_conv2_rqReg_7[15 : 0];
  assign when_QLinearConvLineCore_l639_1 = (conv2_stateReg == conv2_sRequantWait);
  assign when_QLinearConvLineCore_l646_1 = (conv2_stateReg == conv2_sRequantWait2);
  assign when_QLinearConvLineCore_l652_1 = (conv2_stateReg == conv2_sRequantWait3);
  assign _zz_conv2_rqReg_4 = (conv2_rqReg_14 + conv2_rqReg_15);
  assign when_QLinearConvLineCore_l659_1 = (conv2_stateReg == conv2_sRequantShift);
  assign _zz_conv2_rqReg_2 = ($signed(_zz__zz_conv2_rqReg_2) + $signed(32'h0));
  assign when_QLinearConvLineCore_l672_1 = (conv2_stateReg == conv2_sEmit);
  assign conv2_activationOut_fire = (conv2_activationOut_valid && conv2_activationOut_ready);
  assign when_QLinearConvLineCore_l684_1 = (conv2_outChReg == 5'h0f);
  assign when_QLinearConvLineCore_l688_1 = (conv2_outColReg == 4'b1101);
  assign when_QLinearConvLineCore_l692_1 = (conv2_outRowReg == 4'b1101);
  assign QLinearConvLineCorePlugin_logic_outStream_valid_1 = conv2_activationOut_valid;
  assign conv2_activationOut_ready = QLinearConvLineCorePlugin_logic_outStream_ready_1;
  assign QLinearConvLineCorePlugin_logic_outStream_payload_value_1 = conv2_activationOut_payload_value;
  assign relu2_activationOut_valid = QLinearConvLineCorePlugin_logic_outStream_valid_1;
  assign QLinearConvLineCorePlugin_logic_outStream_ready_1 = relu2_activationOut_ready;
  assign relu2_activationOut_payload_value = (($signed(QLinearConvLineCorePlugin_logic_outStream_payload_value_1) < $signed(8'h0)) ? 8'h0 : _zz_relu2_activationOut_payload_value);
  assign ReLUPlugin_logic_outStream_valid_1 = relu2_activationOut_valid;
  assign relu2_activationOut_ready = ReLUPlugin_logic_outStream_ready_1;
  assign ReLUPlugin_logic_outStream_payload_value_1 = relu2_activationOut_payload_value;
  assign pool2_sReceiveRow = 2'b00;
  assign pool2_sPool = 2'b01;
  assign pool2_sEmit = 2'b10;
  always @(*) begin
    pool2_rowAddrComb = 8'h0;
    if(when_MaxPoolLineCore_l237_1) begin
      if(when_MaxPoolLineCore_l241_1) begin
        pool2_rowAddrComb = _zz_pool2_rowAddrComb[7:0];
      end
    end
  end

  assign _zz_pool2_rowReads_0 = pool2_rowAddrComb;
  assign pool2_rowReads_0 = pool2_rowBuf_0_spinal_port0;
  assign _zz_pool2_rowReads_1 = pool2_rowAddrComb;
  assign pool2_rowReads_1 = pool2_rowBuf_1_spinal_port0;
  assign _zz_pool2_rowReads_2 = pool2_rowAddrComb;
  assign pool2_rowReads_2 = pool2_rowBuf_2_spinal_port0;
  assign pool2_readData = _zz_pool2_readData;
  assign ReLUPlugin_logic_outStream_fire_1 = (ReLUPlugin_logic_outStream_valid_1 && ReLUPlugin_logic_outStream_ready_1);
  always @(*) begin
    ReLUPlugin_logic_outStream_ready_1 = 1'b0;
    if(when_MaxPoolLineCore_l180_1) begin
      ReLUPlugin_logic_outStream_ready_1 = 1'b1;
    end
  end

  always @(*) begin
    pool2_activationOut_valid = 1'b0;
    if(when_MaxPoolLineCore_l273_1) begin
      pool2_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    pool2_activationOut_payload_value = pool2_maxReg;
    if(when_MaxPoolLineCore_l273_1) begin
      pool2_activationOut_payload_value = pool2_maxReg;
    end
  end

  assign when_MaxPoolLineCore_l180_1 = (pool2_stateReg == pool2_sReceiveRow);
  assign when_MaxPoolLineCore_l188_1 = (pool2_rxStepReg == 8'hdf);
  assign when_MaxPoolLineCore_l194 = (4'b1100 <= pool2_realRowsRecvReg);
  assign when_MaxPoolLineCore_l195 = (pool2_realRowsRecvReg == 4'b1101);
  assign when_MaxPoolLineCore_l205 = (pool2_rowsUntilComputeReg <= 2'b01);
  assign when_MaxPoolLineCore_l237_1 = (pool2_stateReg == pool2_sPool);
  assign when_MaxPoolLineCore_l241_1 = (pool2_phaseReg < 4'b1001);
  assign _zz_pool2_curSlotReg = (_zz__zz_pool2_curSlotReg + _zz__zz_pool2_curSlotReg_1);
  assign when_MaxPoolLineCore_l249_1 = (pool2_kcReg == 2'b10);
  assign when_MaxPoolLineCore_l253_1 = (pool2_phaseReg == 4'b0010);
  assign when_MaxPoolLineCore_l255_1 = ((4'b0010 < pool2_phaseReg) && (pool2_phaseReg <= 4'b1010));
  assign when_MaxPoolLineCore_l260_1 = (pool2_phaseReg < 4'b1011);
  assign when_MaxPoolLineCore_l273_1 = (pool2_stateReg == pool2_sEmit);
  assign pool2_activationOut_fire = (pool2_activationOut_valid && pool2_activationOut_ready);
  assign when_MaxPoolLineCore_l284_1 = (pool2_outChReg == 5'h0f);
  assign when_MaxPoolLineCore_l287_1 = (pool2_outColReg == 3'b011);
  assign when_MaxPoolLineCore_l291_1 = (pool2_outRowReg == 3'b011);
  assign MaxPoolLinePlugin_logic_outStream_valid_1 = pool2_activationOut_valid;
  assign pool2_activationOut_ready = MaxPoolLinePlugin_logic_outStream_ready_1;
  assign MaxPoolLinePlugin_logic_outStream_payload_value_1 = pool2_activationOut_payload_value;
  assign linear1_sReceive = 4'b0000;
  assign linear1_sLoadBias = 4'b0001;
  assign linear1_sCompute = 4'b0010;
  assign linear1_sRequant = 4'b0011;
  assign linear1_sRequantMul = 4'b0100;
  assign linear1_sRequantWait = 4'b0101;
  assign linear1_sRequantWait2 = 4'b0110;
  assign linear1_sRequantWait3 = 4'b0111;
  assign linear1_sRequantShift = 4'b1000;
  assign linear1_sEmit = 4'b1001;
  assign linear1_sWaitBias = 4'b1010;
  assign linear1_sLoadWeights = 4'b1011;
  assign linear1_reqProdReg1 = 64'h0;
  always @(*) begin
    linear1_inAddrComb = 8'h0;
    if(when_QLinearLinearCore_l231) begin
      if(when_QLinearLinearCore_l235) begin
        linear1_inAddrComb = linear1_compCycleReg[7:0];
      end
    end
  end

  always @(*) begin
    linear1_wAddrComb = 12'h0;
    if(when_QLinearLinearCore_l231) begin
      if(when_QLinearLinearCore_l235) begin
        linear1_wAddrComb = _zz_linear1_wAddrComb[11:0];
      end
    end
  end

  assign linear1_inValR = linear1_inputBuf_spinal_port0;
  assign linear1_wValR = linear1_weightRom_spinal_port0;
  assign _zz_linear1_biasVal = linear1_outNeurReg;
  assign linear1_biasVal = linear1_biasRom_spinal_port0;
  always @(*) begin
    MaxPoolLinePlugin_logic_outStream_ready_1 = 1'b0;
    if(when_QLinearLinearCore_l174) begin
      MaxPoolLinePlugin_logic_outStream_ready_1 = 1'b1;
    end
  end

  always @(*) begin
    linear1_activationOut_valid = 1'b0;
    if(when_QLinearLinearCore_l325) begin
      linear1_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    linear1_activationOut_payload_value = linear1_resultReg;
    if(when_QLinearLinearCore_l325) begin
      linear1_activationOut_payload_value = linear1_resultReg;
    end
  end

  assign when_QLinearLinearCore_l174 = (linear1_stateReg == linear1_sReceive);
  assign MaxPoolLinePlugin_logic_outStream_fire_1 = (MaxPoolLinePlugin_logic_outStream_valid_1 && MaxPoolLinePlugin_logic_outStream_ready_1);
  assign when_QLinearLinearCore_l179 = (linear1_recvCntReg == 9'h0ff);
  assign when_QLinearLinearCore_l219 = (linear1_stateReg == linear1_sLoadBias);
  assign when_QLinearLinearCore_l225 = (linear1_stateReg == linear1_sWaitBias);
  assign when_QLinearLinearCore_l231 = (linear1_stateReg == linear1_sCompute);
  assign when_QLinearLinearCore_l235 = (linear1_compCycleReg < 9'h100);
  assign when_QLinearLinearCore_l242 = ((9'h001 <= linear1_compCycleReg) && (linear1_compCycleReg <= 9'h100));
  assign when_QLinearLinearCore_l248 = ((9'h002 <= linear1_compCycleReg) && (linear1_compCycleReg <= 9'h101));
  assign when_QLinearLinearCore_l255 = ((9'h003 <= linear1_compCycleReg) && (linear1_compCycleReg <= 9'h102));
  assign _zz_linear1_accumReg = ($signed(linear1_accumReg) + $signed(linear1_prodReg));
  assign when_QLinearLinearCore_l259 = (linear1_compCycleReg == 9'h102);
  assign when_QLinearLinearCore_l268 = (linear1_stateReg == linear1_sRequant);
  assign when_QLinearLinearCore_l275 = (linear1_stateReg == linear1_sRequantMul);
  assign _zz_linear1_pLL_Reg = 32'h4c829700;
  assign _zz_linear1_pHL_Reg = linear1_absAReg[31 : 16];
  assign _zz_linear1_pLL_Reg_1 = linear1_absAReg[15 : 0];
  assign _zz_linear1_pLH_Reg = _zz_linear1_pLL_Reg[31 : 16];
  assign _zz_linear1_pLL_Reg_2 = _zz_linear1_pLL_Reg[15 : 0];
  assign when_QLinearLinearCore_l291 = (linear1_stateReg == linear1_sRequantWait);
  assign when_QLinearLinearCore_l299 = (linear1_stateReg == linear1_sRequantWait2);
  assign when_QLinearLinearCore_l306 = (linear1_stateReg == linear1_sRequantWait3);
  assign _zz_linear1_reqProdReg2 = (linear1_part1Reg + linear1_part2Reg);
  assign when_QLinearLinearCore_l314 = (linear1_stateReg == linear1_sRequantShift);
  assign _zz_linear1_resultReg = ($signed(_zz__zz_linear1_resultReg) + $signed(32'h0));
  assign when_QLinearLinearCore_l325 = (linear1_stateReg == linear1_sEmit);
  assign linear1_activationOut_fire = (linear1_activationOut_valid && linear1_activationOut_ready);
  assign _zz_linear1_stateReg = (linear1_outNeurReg == 4'b1001);
  assign QLinearLinearPlugin_logic_outStream_valid = linear1_activationOut_valid;
  assign linear1_activationOut_ready = QLinearLinearPlugin_logic_outStream_ready;
  assign QLinearLinearPlugin_logic_outStream_payload_value = linear1_activationOut_payload_value;
  always @(*) begin
    QLinearLinearPlugin_logic_outStream_ready = 1'b0;
    if(when_SoftmaxCore_l55) begin
      QLinearLinearPlugin_logic_outStream_ready = 1'b1;
    end
  end

  always @(*) begin
    softmax_activationOut_valid = 1'b0;
    if(softmax_emitReg) begin
      softmax_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    softmax_activationOut_payload_value = _zz_softmax_activationOut_payload_value;
    if(softmax_emitReg) begin
      softmax_activationOut_payload_value = _zz_softmax_activationOut_payload_value_1;
    end
  end

  assign when_SoftmaxCore_l55 = (! softmax_emitReg);
  assign QLinearLinearPlugin_logic_outStream_fire = (QLinearLinearPlugin_logic_outStream_valid && QLinearLinearPlugin_logic_outStream_ready);
  assign when_SoftmaxCore_l60 = ((softmax_recvCntReg == 4'b0000) || ($signed(softmax_maxValReg) < $signed(QLinearLinearPlugin_logic_outStream_payload_value)));
  assign when_SoftmaxCore_l65 = (softmax_recvCntReg == 4'b1001);
  assign softmax_activationOut_fire = (softmax_activationOut_valid && softmax_activationOut_ready);
  assign SoftmaxPlugin_logic_outStream_valid = softmax_activationOut_valid;
  assign softmax_activationOut_ready = SoftmaxPlugin_logic_outStream_ready;
  assign SoftmaxPlugin_logic_outStream_payload_value = softmax_activationOut_payload_value;
  assign activation_out_valid = SoftmaxPlugin_logic_outStream_valid;
  assign SoftmaxPlugin_logic_outStream_ready = activation_out_ready;
  assign activation_out_data = SoftmaxPlugin_logic_outStream_payload_value;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      conv1_stateReg <= 4'b1011;
      conv1_rowWrPtrReg <= 3'b010;
      conv1_rowsUntilComputeReg <= 3'b011;
      conv1_realRowsRecvReg <= 5'h0;
      conv1_rxBankReg <= 1'b0;
      conv1_rxWordReg <= 5'h0;
      conv1_initSlotReg <= 3'b000;
      conv1_initAddrReg <= 6'h0;
      conv1_outRowReg <= 5'h0;
      conv1_outColReg <= 5'h0;
      conv1_outChReg <= 4'b0000;
      conv1_khCntReg <= 3'b000;
      conv1_rowStepReg <= 3'b000;
      conv1_compCycleReg <= 5'h0;
      conv1_rowAddrBaseReg <= 6'h0;
      conv1_rowAddrReg <= 6'h0;
      conv1_wAddrReg <= 8'h0;
      conv1_curSlotReg <= 3'b000;
      conv1_inValReg_0 <= 8'h0;
      conv1_wValReg_0 <= 4'b0000;
      conv1_lutProdReg_0 <= 32'h0;
      conv1_rqReg_0 <= 32'h0;
      conv1_rqReg_1 <= 32'h0;
      conv1_rqReg_2 <= 8'h0;
      conv1_rqReg_3 <= 32'h0;
      conv1_rqReg_4 <= 64'h0;
      conv1_rqReg_5 <= 1'b0;
      conv1_rqReg_6 <= 32'h0;
      conv1_rqReg_7 <= 32'h0;
      conv1_rqReg_8 <= 32'h0;
      conv1_rqReg_9 <= 32'h0;
      conv1_rqReg_10 <= 32'h0;
      conv1_rqReg_11 <= 33'h0;
      conv1_rqReg_12 <= 32'h0;
      conv1_rqReg_13 <= 32'h0;
      conv1_rqReg_14 <= 64'h0;
      conv1_rqReg_15 <= 64'h0;
      conv1_rxByteRegs_0 <= 8'h0;
      pool1_stateReg <= 2'b00;
      pool1_rowWrPtrReg <= 1'b0;
      pool1_rowsUntilComputeReg <= 2'b10;
      pool1_realRowsRecvReg <= 5'h0;
      pool1_rxStepReg <= 8'h0;
      pool1_outRowReg <= 4'b0000;
      pool1_outColReg <= 4'b0000;
      pool1_outChReg <= 4'b0000;
      pool1_phaseReg <= 3'b000;
      pool1_krReg <= 2'b00;
      pool1_kcReg <= 2'b00;
      pool1_maxReg <= 8'h0;
      pool1_curSlotReg <= 1'b0;
      pool1_readDataReg <= 8'h0;
      conv2_stateReg <= 4'b1011;
      conv2_rowWrPtrReg <= 3'b010;
      conv2_rowsUntilComputeReg <= 3'b011;
      conv2_realRowsRecvReg <= 4'b0000;
      conv2_rxBankReg <= 4'b0000;
      conv2_rxWordReg <= 4'b0000;
      conv2_initSlotReg <= 3'b000;
      conv2_initAddrReg <= 5'h0;
      conv2_outRowReg <= 4'b0000;
      conv2_outColReg <= 4'b0000;
      conv2_outChReg <= 5'h0;
      conv2_khCntReg <= 3'b000;
      conv2_rowStepReg <= 3'b000;
      conv2_compCycleReg <= 5'h0;
      conv2_rowAddrBaseReg <= 5'h0;
      conv2_rowAddrReg <= 5'h0;
      conv2_wAddrReg <= 9'h0;
      conv2_curSlotReg <= 3'b000;
      conv2_inValReg_0 <= 8'h0;
      conv2_inValReg_1 <= 8'h0;
      conv2_inValReg_2 <= 8'h0;
      conv2_inValReg_3 <= 8'h0;
      conv2_inValReg_4 <= 8'h0;
      conv2_inValReg_5 <= 8'h0;
      conv2_inValReg_6 <= 8'h0;
      conv2_inValReg_7 <= 8'h0;
      conv2_wValReg_0 <= 4'b0000;
      conv2_wValReg_1 <= 4'b0000;
      conv2_wValReg_2 <= 4'b0000;
      conv2_wValReg_3 <= 4'b0000;
      conv2_wValReg_4 <= 4'b0000;
      conv2_wValReg_5 <= 4'b0000;
      conv2_wValReg_6 <= 4'b0000;
      conv2_wValReg_7 <= 4'b0000;
      conv2_lutProdReg_0 <= 32'h0;
      conv2_lutProdReg_1 <= 32'h0;
      conv2_lutProdReg_2 <= 32'h0;
      conv2_lutProdReg_3 <= 32'h0;
      conv2_lutProdReg_4 <= 32'h0;
      conv2_lutProdReg_5 <= 32'h0;
      conv2_lutProdReg_6 <= 32'h0;
      conv2_lutProdReg_7 <= 32'h0;
      conv2_rqReg_0 <= 32'h0;
      conv2_rqReg_1 <= 32'h0;
      conv2_rqReg_2 <= 8'h0;
      conv2_rqReg_3 <= 32'h0;
      conv2_rqReg_4 <= 64'h0;
      conv2_rqReg_5 <= 1'b0;
      conv2_rqReg_6 <= 32'h0;
      conv2_rqReg_7 <= 32'h0;
      conv2_rqReg_8 <= 32'h0;
      conv2_rqReg_9 <= 32'h0;
      conv2_rqReg_10 <= 32'h0;
      conv2_rqReg_11 <= 33'h0;
      conv2_rqReg_12 <= 32'h0;
      conv2_rqReg_13 <= 32'h0;
      conv2_rqReg_14 <= 64'h0;
      conv2_rqReg_15 <= 64'h0;
      conv2_rxByteRegs_0 <= 8'h0;
      conv2_rxByteRegs_1 <= 8'h0;
      conv2_rxByteRegs_2 <= 8'h0;
      conv2_rxByteRegs_3 <= 8'h0;
      conv2_rxByteRegs_4 <= 8'h0;
      conv2_rxByteRegs_5 <= 8'h0;
      conv2_rxByteRegs_6 <= 8'h0;
      conv2_rxByteRegs_7 <= 8'h0;
      pool2_stateReg <= 2'b00;
      pool2_rowWrPtrReg <= 2'b00;
      pool2_rowsUntilComputeReg <= 2'b11;
      pool2_realRowsRecvReg <= 4'b0000;
      pool2_rxStepReg <= 8'h0;
      pool2_outRowReg <= 3'b000;
      pool2_outColReg <= 3'b000;
      pool2_outChReg <= 5'h0;
      pool2_phaseReg <= 4'b0000;
      pool2_krReg <= 2'b00;
      pool2_kcReg <= 2'b00;
      pool2_maxReg <= 8'h0;
      pool2_curSlotReg <= 2'b00;
      pool2_readDataReg <= 8'h0;
      linear1_stateReg <= 4'b0000;
      linear1_recvCntReg <= 9'h0;
      linear1_outNeurReg <= 4'b0000;
      linear1_compCycleReg <= 9'h0;
      linear1_accumReg <= 32'h0;
      linear1_prodReg <= 32'h0;
      linear1_resultReg <= 8'h0;
      linear1_reqProdReg2 <= 64'h0;
      linear1_accumRequantReg <= 32'h0;
      linear1_signAReg <= 1'b0;
      linear1_absAReg <= 32'h0;
      linear1_pLL_Reg <= 32'h0;
      linear1_pLH_Reg <= 32'h0;
      linear1_pHL_Reg <= 32'h0;
      linear1_pHH_Reg <= 32'h0;
      linear1_pSumReg <= 33'h0;
      linear1_pLL_Reg2 <= 32'h0;
      linear1_pHH_Reg2 <= 32'h0;
      linear1_part1Reg <= 64'h0;
      linear1_part2Reg <= 64'h0;
      linear1_inValReg <= 8'h0;
      linear1_wValReg <= 8'h0;
      softmax_emitReg <= 1'b0;
      softmax_recvCntReg <= 4'b0000;
      softmax_maxValReg <= 8'h80;
      softmax_maxIdxReg <= 4'b0000;
    end else begin
      if(when_QLinearConvLineCore_l371) begin
        conv1_rxByteRegs_0 <= activation_in_data;
      end
      if(when_QLinearConvLineCore_l407) begin
        conv1_initAddrReg <= (conv1_initAddrReg + 6'h01);
        if(when_QLinearConvLineCore_l409) begin
          conv1_initAddrReg <= 6'h0;
          conv1_initSlotReg <= (conv1_initSlotReg + 3'b001);
          if(when_QLinearConvLineCore_l412) begin
            conv1_initSlotReg <= 3'b000;
            conv1_rowWrPtrReg <= 3'b010;
            conv1_rowsUntilComputeReg <= 3'b011;
            conv1_realRowsRecvReg <= 5'h0;
            conv1_rxBankReg <= 1'b0;
            conv1_rxWordReg <= 5'h0;
            conv1_outRowReg <= 5'h0;
            conv1_outColReg <= 5'h0;
            conv1_outChReg <= 4'b0000;
            conv1_stateReg <= conv1_sReceiveRow;
          end
        end
      end
      if(when_QLinearConvLineCore_l431) begin
        if(when_QLinearConvLineCore_l435) begin
          conv1_rxBankReg <= (when_QLinearConvLineCore_l438 ? 1'b0 : _zz_conv1_rxBankReg);
          if(when_QLinearConvLineCore_l438) begin
            conv1_rxWordReg <= (conv1_rxWordReg + 5'h01);
          end
          if(when_QLinearConvLineCore_l443) begin
            conv1_rxBankReg <= 1'b0;
            conv1_rxWordReg <= 5'h0;
            conv1_rowWrPtrReg <= ((conv1_rowWrPtrReg == 3'b100) ? 3'b000 : _zz_conv1_rowWrPtrReg);
            if(conv1_isReal) begin
              conv1_realRowsRecvReg <= (conv1_realRowsRecvReg + 5'h01);
            end
            if(when_QLinearConvLineCore_l449) begin
              conv1_rowsUntilComputeReg <= 3'b001;
              conv1_stateReg <= conv1_sLoadBias;
            end else begin
              conv1_rowsUntilComputeReg <= (conv1_rowsUntilComputeReg - 3'b001);
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l492) begin
        conv1_rowAddrBaseReg <= _zz_conv1_rowAddrBaseReg;
        conv1_rowAddrReg <= _zz_conv1_rowAddrBaseReg;
        conv1_wAddrReg <= _zz_conv1_wAddrReg[7:0];
        conv1_khCntReg <= 3'b000;
        conv1_rowStepReg <= 3'b000;
        conv1_compCycleReg <= 5'h0;
        conv1_stateReg <= conv1_sWaitBias;
      end
      if(when_QLinearConvLineCore_l505) begin
        conv1_rqReg_0 <= conv1_biasVal;
        conv1_stateReg <= conv1_sCompute;
      end
      if(when_QLinearConvLineCore_l532) begin
        conv1_compCycleReg <= (conv1_compCycleReg + 5'h01);
        if(when_QLinearConvLineCore_l536) begin
          conv1_curSlotReg <= ((4'b0101 <= _zz_conv1_curSlotReg) ? _zz_conv1_curSlotReg_1 : _zz_conv1_curSlotReg_3);
          conv1_wAddrReg <= (conv1_wAddrReg + 8'h01);
          if(when_QLinearConvLineCore_l540) begin
            conv1_rowStepReg <= 3'b000;
            conv1_khCntReg <= (conv1_khCntReg + 3'b001);
            conv1_rowAddrReg <= conv1_rowAddrBaseReg;
          end else begin
            conv1_rowStepReg <= (conv1_rowStepReg + 3'b001);
            conv1_rowAddrReg <= (conv1_rowAddrReg + 6'h01);
          end
        end
        if(when_QLinearConvLineCore_l551) begin
          conv1_inValReg_0 <= _zz_conv1_inValReg_0;
          conv1_wValReg_0 <= conv1_wValsRaw_0;
        end
        if(when_QLinearConvLineCore_l564) begin
          conv1_lutProdReg_0 <= ($signed(_zz_conv1_lutProdReg_0_2) + $signed(_zz_conv1_lutProdReg_0_11));
        end
        if(when_QLinearConvLineCore_l579) begin
          conv1_rqReg_1 <= conv1_lutProdReg_0;
        end
        if(when_QLinearConvLineCore_l584) begin
          conv1_rqReg_0 <= _zz_conv1_rqReg_0;
          if(when_QLinearConvLineCore_l587) begin
            conv1_rqReg_3 <= _zz_conv1_rqReg_0;
            conv1_compCycleReg <= 5'h0;
            conv1_stateReg <= conv1_sRequant;
          end
        end
      end
      if(when_QLinearConvLineCore_l621) begin
        conv1_rqReg_6 <= _zz_conv1_rqReg_6;
        conv1_rqReg_5 <= ($signed(conv1_rqReg_3) < $signed(32'h0));
        conv1_stateReg <= conv1_sRequantMul;
      end
      if(when_QLinearConvLineCore_l627) begin
        conv1_rqReg_7 <= (_zz_conv1_rqReg_7_1 * _zz_conv1_rqReg_7_2);
        conv1_rqReg_8 <= (_zz_conv1_rqReg_7_1 * _zz_conv1_rqReg_8);
        conv1_rqReg_9 <= (_zz_conv1_rqReg_9 * _zz_conv1_rqReg_7_2);
        conv1_rqReg_10 <= (_zz_conv1_rqReg_9 * _zz_conv1_rqReg_8);
        conv1_stateReg <= conv1_sRequantWait;
      end
      if(when_QLinearConvLineCore_l639) begin
        conv1_rqReg_11 <= (_zz_conv1_rqReg_11 + _zz_conv1_rqReg_11_1);
        conv1_rqReg_12 <= conv1_rqReg_7;
        conv1_rqReg_13 <= conv1_rqReg_10;
        conv1_stateReg <= conv1_sRequantWait2;
      end
      if(when_QLinearConvLineCore_l646) begin
        conv1_rqReg_14 <= (_zz_conv1_rqReg_14 + _zz_conv1_rqReg_14_1);
        conv1_rqReg_15 <= _zz_conv1_rqReg_15[63:0];
        conv1_stateReg <= conv1_sRequantWait3;
      end
      if(when_QLinearConvLineCore_l652) begin
        conv1_rqReg_4 <= (conv1_rqReg_5 ? _zz_conv1_rqReg_4_1 : _zz_conv1_rqReg_4_3);
        conv1_stateReg <= conv1_sRequantShift;
      end
      if(when_QLinearConvLineCore_l659) begin
        conv1_rqReg_2 <= (($signed(32'h0000007f) < $signed(_zz_conv1_rqReg_2)) ? 8'h7f : _zz_conv1_rqReg_2_1);
        conv1_stateReg <= conv1_sEmit;
      end
      if(when_QLinearConvLineCore_l672) begin
        if(conv1_activationOut_fire) begin
          conv1_outChReg <= (when_QLinearConvLineCore_l684 ? 4'b0000 : _zz_conv1_outChReg);
          if(when_QLinearConvLineCore_l684) begin
            conv1_outColReg <= (when_QLinearConvLineCore_l688 ? 5'h0 : _zz_conv1_outColReg);
            if(when_QLinearConvLineCore_l688) begin
              conv1_outRowReg <= (when_QLinearConvLineCore_l692 ? 5'h0 : _zz_conv1_outRowReg);
              if(when_QLinearConvLineCore_l692) begin
                conv1_realRowsRecvReg <= 5'h0;
                conv1_rxBankReg <= 1'b0;
                conv1_rxWordReg <= 5'h0;
                conv1_rowsUntilComputeReg <= 3'b011;
                conv1_rowWrPtrReg <= 3'b010;
                conv1_initSlotReg <= 3'b000;
                conv1_initAddrReg <= 6'h0;
                conv1_stateReg <= conv1_sInit;
              end else begin
                conv1_stateReg <= conv1_sReceiveRow;
              end
            end else begin
              conv1_stateReg <= conv1_sLoadBias;
            end
          end else begin
            conv1_stateReg <= conv1_sLoadBias;
          end
        end
      end
      if(when_MaxPoolLineCore_l180) begin
        if(ReLUPlugin_logic_outStream_fire) begin
          pool1_rxStepReg <= (when_MaxPoolLineCore_l188 ? 8'h0 : _zz_pool1_rxStepReg);
          if(when_MaxPoolLineCore_l188) begin
            pool1_rowWrPtrReg <= ((pool1_rowWrPtrReg == 1'b1) ? 1'b0 : _zz_pool1_rowWrPtrReg);
            pool1_realRowsRecvReg <= (pool1_realRowsRecvReg + 5'h01);
            if(when_MaxPoolLineCore_l218) begin
              pool1_rowsUntilComputeReg <= 2'b10;
              pool1_krReg <= 2'b00;
              pool1_kcReg <= 2'b00;
              pool1_phaseReg <= 3'b000;
              pool1_stateReg <= pool1_sPool;
            end else begin
              pool1_rowsUntilComputeReg <= (pool1_rowsUntilComputeReg - 2'b01);
            end
          end
        end
      end
      if(when_MaxPoolLineCore_l237) begin
        pool1_readDataReg <= pool1_readData;
        if(when_MaxPoolLineCore_l241) begin
          pool1_curSlotReg <= ((3'b010 <= _zz_pool1_curSlotReg) ? _zz_pool1_curSlotReg_1 : _zz_pool1_curSlotReg_3);
          pool1_kcReg <= (when_MaxPoolLineCore_l249 ? 2'b00 : _zz_pool1_kcReg);
          if(when_MaxPoolLineCore_l249) begin
            pool1_krReg <= (pool1_krReg + 2'b01);
          end
        end
        if(when_MaxPoolLineCore_l253) begin
          pool1_maxReg <= pool1_readDataReg;
        end else begin
          if(when_MaxPoolLineCore_l255) begin
            pool1_maxReg <= (($signed(pool1_maxReg) < $signed(pool1_readDataReg)) ? pool1_readDataReg : pool1_maxReg);
          end
        end
        if(when_MaxPoolLineCore_l260) begin
          pool1_phaseReg <= (pool1_phaseReg + 3'b001);
        end else begin
          pool1_phaseReg <= 3'b000;
          pool1_krReg <= 2'b00;
          pool1_kcReg <= 2'b00;
          pool1_stateReg <= pool1_sEmit;
        end
      end
      if(when_MaxPoolLineCore_l273) begin
        if(pool1_activationOut_fire) begin
          pool1_outChReg <= (when_MaxPoolLineCore_l284 ? 4'b0000 : _zz_pool1_outChReg);
          if(when_MaxPoolLineCore_l284) begin
            pool1_outColReg <= (when_MaxPoolLineCore_l287 ? 4'b0000 : _zz_pool1_outColReg);
            if(when_MaxPoolLineCore_l287) begin
              pool1_outRowReg <= (when_MaxPoolLineCore_l291 ? 4'b0000 : _zz_pool1_outRowReg);
              if(when_MaxPoolLineCore_l291) begin
                pool1_rxStepReg <= 8'h0;
                pool1_rowsUntilComputeReg <= 2'b10;
                pool1_rowWrPtrReg <= 1'b0;
                pool1_realRowsRecvReg <= 5'h0;
                pool1_stateReg <= pool1_sReceiveRow;
              end else begin
                pool1_stateReg <= pool1_sReceiveRow;
              end
            end else begin
              pool1_phaseReg <= 3'b000;
              pool1_krReg <= 2'b00;
              pool1_kcReg <= 2'b00;
              pool1_stateReg <= pool1_sPool;
            end
          end else begin
            pool1_phaseReg <= 3'b000;
            pool1_krReg <= 2'b00;
            pool1_kcReg <= 2'b00;
            pool1_stateReg <= pool1_sPool;
          end
        end
      end
      if(when_QLinearConvLineCore_l371_1) begin
        conv2_rxByteRegs_0 <= MaxPoolLinePlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l371_2) begin
        conv2_rxByteRegs_1 <= MaxPoolLinePlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l371_3) begin
        conv2_rxByteRegs_2 <= MaxPoolLinePlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l371_4) begin
        conv2_rxByteRegs_3 <= MaxPoolLinePlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l371_5) begin
        conv2_rxByteRegs_4 <= MaxPoolLinePlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l371_6) begin
        conv2_rxByteRegs_5 <= MaxPoolLinePlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l371_7) begin
        conv2_rxByteRegs_6 <= MaxPoolLinePlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l371_8) begin
        conv2_rxByteRegs_7 <= MaxPoolLinePlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l407_1) begin
        conv2_initAddrReg <= (conv2_initAddrReg + 5'h01);
        if(when_QLinearConvLineCore_l409_1) begin
          conv2_initAddrReg <= 5'h0;
          conv2_initSlotReg <= (conv2_initSlotReg + 3'b001);
          if(when_QLinearConvLineCore_l412_1) begin
            conv2_initSlotReg <= 3'b000;
            conv2_rowWrPtrReg <= 3'b010;
            conv2_rowsUntilComputeReg <= 3'b011;
            conv2_realRowsRecvReg <= 4'b0000;
            conv2_rxBankReg <= 4'b0000;
            conv2_rxWordReg <= 4'b0000;
            conv2_outRowReg <= 4'b0000;
            conv2_outColReg <= 4'b0000;
            conv2_outChReg <= 5'h0;
            conv2_stateReg <= conv2_sReceiveRow;
          end
        end
      end
      if(when_QLinearConvLineCore_l431_1) begin
        if(when_QLinearConvLineCore_l435_1) begin
          conv2_rxBankReg <= (when_QLinearConvLineCore_l438_1 ? 4'b0000 : _zz_conv2_rxBankReg);
          if(when_QLinearConvLineCore_l438_1) begin
            conv2_rxWordReg <= (conv2_rxWordReg + 4'b0001);
          end
          if(when_QLinearConvLineCore_l443_1) begin
            conv2_rxBankReg <= 4'b0000;
            conv2_rxWordReg <= 4'b0000;
            conv2_rowWrPtrReg <= ((conv2_rowWrPtrReg == 3'b100) ? 3'b000 : _zz_conv2_rowWrPtrReg);
            if(conv2_isReal) begin
              conv2_realRowsRecvReg <= (conv2_realRowsRecvReg + 4'b0001);
            end
            if(when_QLinearConvLineCore_l449_1) begin
              conv2_rowsUntilComputeReg <= 3'b001;
              conv2_stateReg <= conv2_sLoadBias;
            end else begin
              conv2_rowsUntilComputeReg <= (conv2_rowsUntilComputeReg - 3'b001);
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l492_1) begin
        conv2_rowAddrBaseReg <= _zz_conv2_rowAddrBaseReg;
        conv2_rowAddrReg <= _zz_conv2_rowAddrBaseReg;
        conv2_wAddrReg <= _zz_conv2_wAddrReg[8:0];
        conv2_khCntReg <= 3'b000;
        conv2_rowStepReg <= 3'b000;
        conv2_compCycleReg <= 5'h0;
        conv2_stateReg <= conv2_sWaitBias;
      end
      if(when_QLinearConvLineCore_l505_1) begin
        conv2_rqReg_0 <= conv2_biasVal;
        conv2_stateReg <= conv2_sCompute;
      end
      if(when_QLinearConvLineCore_l532_1) begin
        conv2_compCycleReg <= (conv2_compCycleReg + 5'h01);
        if(when_QLinearConvLineCore_l536_1) begin
          conv2_curSlotReg <= ((4'b0101 <= _zz_conv2_curSlotReg) ? _zz_conv2_curSlotReg_1 : _zz_conv2_curSlotReg_3);
          conv2_wAddrReg <= (conv2_wAddrReg + 9'h001);
          if(when_QLinearConvLineCore_l540_1) begin
            conv2_rowStepReg <= 3'b000;
            conv2_khCntReg <= (conv2_khCntReg + 3'b001);
            conv2_rowAddrReg <= conv2_rowAddrBaseReg;
          end else begin
            conv2_rowStepReg <= (conv2_rowStepReg + 3'b001);
            conv2_rowAddrReg <= (conv2_rowAddrReg + 5'h01);
          end
        end
        if(when_QLinearConvLineCore_l551_1) begin
          conv2_inValReg_0 <= _zz_conv2_inValReg_0;
          conv2_wValReg_0 <= conv2_wValsRaw_0;
          conv2_inValReg_1 <= _zz_conv2_inValReg_1;
          conv2_wValReg_1 <= conv2_wValsRaw_1;
          conv2_inValReg_2 <= _zz_conv2_inValReg_2;
          conv2_wValReg_2 <= conv2_wValsRaw_2;
          conv2_inValReg_3 <= _zz_conv2_inValReg_3;
          conv2_wValReg_3 <= conv2_wValsRaw_3;
          conv2_inValReg_4 <= _zz_conv2_inValReg_4;
          conv2_wValReg_4 <= conv2_wValsRaw_4;
          conv2_inValReg_5 <= _zz_conv2_inValReg_5;
          conv2_wValReg_5 <= conv2_wValsRaw_5;
          conv2_inValReg_6 <= _zz_conv2_inValReg_6;
          conv2_wValReg_6 <= conv2_wValsRaw_6;
          conv2_inValReg_7 <= _zz_conv2_inValReg_7;
          conv2_wValReg_7 <= conv2_wValsRaw_7;
        end
        if(when_QLinearConvLineCore_l564_1) begin
          conv2_lutProdReg_0 <= ($signed(_zz_conv2_lutProdReg_0_3) + $signed(_zz_conv2_lutProdReg_0_12));
          conv2_lutProdReg_1 <= ($signed(_zz_conv2_lutProdReg_1_2) + $signed(_zz_conv2_lutProdReg_1_11));
          conv2_lutProdReg_2 <= ($signed(_zz_conv2_lutProdReg_2_2) + $signed(_zz_conv2_lutProdReg_2_11));
          conv2_lutProdReg_3 <= ($signed(_zz_conv2_lutProdReg_3_2) + $signed(_zz_conv2_lutProdReg_3_11));
          conv2_lutProdReg_4 <= ($signed(_zz_conv2_lutProdReg_4_2) + $signed(_zz_conv2_lutProdReg_4_11));
          conv2_lutProdReg_5 <= ($signed(_zz_conv2_lutProdReg_5_2) + $signed(_zz_conv2_lutProdReg_5_11));
          conv2_lutProdReg_6 <= ($signed(_zz_conv2_lutProdReg_6_2) + $signed(_zz_conv2_lutProdReg_6_11));
          conv2_lutProdReg_7 <= ($signed(_zz_conv2_lutProdReg_7_2) + $signed(_zz_conv2_lutProdReg_7_11));
        end
        if(when_QLinearConvLineCore_l579_1) begin
          conv2_rqReg_1 <= ($signed(_zz_conv2_rqReg_1) + $signed(_zz_conv2_rqReg_1_3));
        end
        if(when_QLinearConvLineCore_l584_1) begin
          conv2_rqReg_0 <= _zz_conv2_rqReg_0;
          if(when_QLinearConvLineCore_l587_1) begin
            conv2_rqReg_3 <= _zz_conv2_rqReg_0;
            conv2_compCycleReg <= 5'h0;
            conv2_stateReg <= conv2_sRequant;
          end
        end
      end
      if(when_QLinearConvLineCore_l621_1) begin
        conv2_rqReg_6 <= _zz_conv2_rqReg_6;
        conv2_rqReg_5 <= ($signed(conv2_rqReg_3) < $signed(32'h0));
        conv2_stateReg <= conv2_sRequantMul;
      end
      if(when_QLinearConvLineCore_l627_1) begin
        conv2_rqReg_7 <= (_zz_conv2_rqReg_7_1 * _zz_conv2_rqReg_7_2);
        conv2_rqReg_8 <= (_zz_conv2_rqReg_7_1 * _zz_conv2_rqReg_8);
        conv2_rqReg_9 <= (_zz_conv2_rqReg_9 * _zz_conv2_rqReg_7_2);
        conv2_rqReg_10 <= (_zz_conv2_rqReg_9 * _zz_conv2_rqReg_8);
        conv2_stateReg <= conv2_sRequantWait;
      end
      if(when_QLinearConvLineCore_l639_1) begin
        conv2_rqReg_11 <= (_zz_conv2_rqReg_11 + _zz_conv2_rqReg_11_1);
        conv2_rqReg_12 <= conv2_rqReg_7;
        conv2_rqReg_13 <= conv2_rqReg_10;
        conv2_stateReg <= conv2_sRequantWait2;
      end
      if(when_QLinearConvLineCore_l646_1) begin
        conv2_rqReg_14 <= (_zz_conv2_rqReg_14 + _zz_conv2_rqReg_14_1);
        conv2_rqReg_15 <= _zz_conv2_rqReg_15[63:0];
        conv2_stateReg <= conv2_sRequantWait3;
      end
      if(when_QLinearConvLineCore_l652_1) begin
        conv2_rqReg_4 <= (conv2_rqReg_5 ? _zz_conv2_rqReg_4_1 : _zz_conv2_rqReg_4_3);
        conv2_stateReg <= conv2_sRequantShift;
      end
      if(when_QLinearConvLineCore_l659_1) begin
        conv2_rqReg_2 <= (($signed(32'h0000007f) < $signed(_zz_conv2_rqReg_2)) ? 8'h7f : _zz_conv2_rqReg_2_1);
        conv2_stateReg <= conv2_sEmit;
      end
      if(when_QLinearConvLineCore_l672_1) begin
        if(conv2_activationOut_fire) begin
          conv2_outChReg <= (when_QLinearConvLineCore_l684_1 ? 5'h0 : _zz_conv2_outChReg);
          if(when_QLinearConvLineCore_l684_1) begin
            conv2_outColReg <= (when_QLinearConvLineCore_l688_1 ? 4'b0000 : _zz_conv2_outColReg);
            if(when_QLinearConvLineCore_l688_1) begin
              conv2_outRowReg <= (when_QLinearConvLineCore_l692_1 ? 4'b0000 : _zz_conv2_outRowReg);
              if(when_QLinearConvLineCore_l692_1) begin
                conv2_realRowsRecvReg <= 4'b0000;
                conv2_rxBankReg <= 4'b0000;
                conv2_rxWordReg <= 4'b0000;
                conv2_rowsUntilComputeReg <= 3'b011;
                conv2_rowWrPtrReg <= 3'b010;
                conv2_initSlotReg <= 3'b000;
                conv2_initAddrReg <= 5'h0;
                conv2_stateReg <= conv2_sInit;
              end else begin
                conv2_stateReg <= conv2_sReceiveRow;
              end
            end else begin
              conv2_stateReg <= conv2_sLoadBias;
            end
          end else begin
            conv2_stateReg <= conv2_sLoadBias;
          end
        end
      end
      if(when_MaxPoolLineCore_l180_1) begin
        if(ReLUPlugin_logic_outStream_fire_1) begin
          pool2_rxStepReg <= (when_MaxPoolLineCore_l188_1 ? 8'h0 : _zz_pool2_rxStepReg);
          if(when_MaxPoolLineCore_l188_1) begin
            if(when_MaxPoolLineCore_l194) begin
              if(when_MaxPoolLineCore_l195) begin
                pool2_realRowsRecvReg <= 4'b0000;
              end else begin
                pool2_realRowsRecvReg <= (pool2_realRowsRecvReg + 4'b0001);
              end
            end else begin
              pool2_rowWrPtrReg <= ((pool2_rowWrPtrReg == 2'b10) ? 2'b00 : _zz_pool2_rowWrPtrReg);
              pool2_realRowsRecvReg <= (pool2_realRowsRecvReg + 4'b0001);
              if(when_MaxPoolLineCore_l205) begin
                pool2_rowsUntilComputeReg <= 2'b11;
                pool2_krReg <= 2'b00;
                pool2_kcReg <= 2'b00;
                pool2_phaseReg <= 4'b0000;
                pool2_stateReg <= pool2_sPool;
              end else begin
                pool2_rowsUntilComputeReg <= (pool2_rowsUntilComputeReg - 2'b01);
              end
            end
          end
        end
      end
      if(when_MaxPoolLineCore_l237_1) begin
        pool2_readDataReg <= pool2_readData;
        if(when_MaxPoolLineCore_l241_1) begin
          pool2_curSlotReg <= ((3'b011 <= _zz_pool2_curSlotReg) ? _zz_pool2_curSlotReg_1 : _zz_pool2_curSlotReg_3);
          pool2_kcReg <= (when_MaxPoolLineCore_l249_1 ? 2'b00 : _zz_pool2_kcReg);
          if(when_MaxPoolLineCore_l249_1) begin
            pool2_krReg <= (pool2_krReg + 2'b01);
          end
        end
        if(when_MaxPoolLineCore_l253_1) begin
          pool2_maxReg <= pool2_readDataReg;
        end else begin
          if(when_MaxPoolLineCore_l255_1) begin
            pool2_maxReg <= (($signed(pool2_maxReg) < $signed(pool2_readDataReg)) ? pool2_readDataReg : pool2_maxReg);
          end
        end
        if(when_MaxPoolLineCore_l260_1) begin
          pool2_phaseReg <= (pool2_phaseReg + 4'b0001);
        end else begin
          pool2_phaseReg <= 4'b0000;
          pool2_krReg <= 2'b00;
          pool2_kcReg <= 2'b00;
          pool2_stateReg <= pool2_sEmit;
        end
      end
      if(when_MaxPoolLineCore_l273_1) begin
        if(pool2_activationOut_fire) begin
          pool2_outChReg <= (when_MaxPoolLineCore_l284_1 ? 5'h0 : _zz_pool2_outChReg);
          if(when_MaxPoolLineCore_l284_1) begin
            pool2_outColReg <= (when_MaxPoolLineCore_l287_1 ? 3'b000 : _zz_pool2_outColReg);
            if(when_MaxPoolLineCore_l287_1) begin
              pool2_outRowReg <= (when_MaxPoolLineCore_l291_1 ? 3'b000 : _zz_pool2_outRowReg);
              if(when_MaxPoolLineCore_l291_1) begin
                pool2_rxStepReg <= 8'h0;
                pool2_rowsUntilComputeReg <= 2'b11;
                pool2_rowWrPtrReg <= 2'b00;
                pool2_stateReg <= pool2_sReceiveRow;
              end else begin
                pool2_stateReg <= pool2_sReceiveRow;
              end
            end else begin
              pool2_phaseReg <= 4'b0000;
              pool2_krReg <= 2'b00;
              pool2_kcReg <= 2'b00;
              pool2_stateReg <= pool2_sPool;
            end
          end else begin
            pool2_phaseReg <= 4'b0000;
            pool2_krReg <= 2'b00;
            pool2_kcReg <= 2'b00;
            pool2_stateReg <= pool2_sPool;
          end
        end
      end
      if(when_QLinearLinearCore_l174) begin
        if(MaxPoolLinePlugin_logic_outStream_fire_1) begin
          linear1_recvCntReg <= (linear1_recvCntReg + 9'h001);
          if(when_QLinearLinearCore_l179) begin
            linear1_recvCntReg <= 9'h0;
            linear1_outNeurReg <= 4'b0000;
            linear1_stateReg <= linear1_sLoadBias;
          end
        end
      end
      if(when_QLinearLinearCore_l219) begin
        linear1_compCycleReg <= 9'h0;
        linear1_stateReg <= linear1_sWaitBias;
      end
      if(when_QLinearLinearCore_l225) begin
        linear1_accumReg <= linear1_biasVal;
        linear1_stateReg <= linear1_sCompute;
      end
      if(when_QLinearLinearCore_l231) begin
        linear1_compCycleReg <= (linear1_compCycleReg + 9'h001);
        if(when_QLinearLinearCore_l242) begin
          linear1_inValReg <= linear1_inValR;
          linear1_wValReg <= linear1_wValR;
        end
        if(when_QLinearLinearCore_l248) begin
          linear1_prodReg <= {{14{_zz_linear1_prodReg[17]}}, _zz_linear1_prodReg};
        end
        if(when_QLinearLinearCore_l255) begin
          linear1_accumReg <= _zz_linear1_accumReg;
          if(when_QLinearLinearCore_l259) begin
            linear1_accumRequantReg <= _zz_linear1_accumReg;
            linear1_stateReg <= linear1_sRequant;
            linear1_compCycleReg <= 9'h0;
          end
        end
      end
      if(when_QLinearLinearCore_l268) begin
        linear1_absAReg <= _zz_linear1_absAReg;
        linear1_signAReg <= ($signed(linear1_accumRequantReg) < $signed(32'h0));
        linear1_stateReg <= linear1_sRequantMul;
      end
      if(when_QLinearLinearCore_l275) begin
        linear1_pLL_Reg <= (_zz_linear1_pLL_Reg_1 * _zz_linear1_pLL_Reg_2);
        linear1_pLH_Reg <= (_zz_linear1_pLL_Reg_1 * _zz_linear1_pLH_Reg);
        linear1_pHL_Reg <= (_zz_linear1_pHL_Reg * _zz_linear1_pLL_Reg_2);
        linear1_pHH_Reg <= (_zz_linear1_pHL_Reg * _zz_linear1_pLH_Reg);
        linear1_stateReg <= linear1_sRequantWait;
      end
      if(when_QLinearLinearCore_l291) begin
        linear1_pSumReg <= (_zz_linear1_pSumReg + _zz_linear1_pSumReg_1);
        linear1_pLL_Reg2 <= linear1_pLL_Reg;
        linear1_pHH_Reg2 <= linear1_pHH_Reg;
        linear1_stateReg <= linear1_sRequantWait2;
      end
      if(when_QLinearLinearCore_l299) begin
        linear1_part1Reg <= (_zz_linear1_part1Reg + _zz_linear1_part1Reg_1);
        linear1_part2Reg <= _zz_linear1_part2Reg[63:0];
        linear1_stateReg <= linear1_sRequantWait3;
      end
      if(when_QLinearLinearCore_l306) begin
        linear1_reqProdReg2 <= (linear1_signAReg ? _zz_linear1_reqProdReg2_1 : _zz_linear1_reqProdReg2_3);
        linear1_stateReg <= linear1_sRequantShift;
      end
      if(when_QLinearLinearCore_l314) begin
        linear1_resultReg <= (($signed(32'h0000007f) < $signed(_zz_linear1_resultReg)) ? 8'h7f : _zz_linear1_resultReg_1);
        linear1_stateReg <= linear1_sEmit;
      end
      if(when_QLinearLinearCore_l325) begin
        if(linear1_activationOut_fire) begin
          linear1_outNeurReg <= (_zz_linear1_stateReg ? 4'b0000 : _zz_linear1_outNeurReg);
          linear1_stateReg <= (_zz_linear1_stateReg ? linear1_sReceive : linear1_sLoadBias);
        end
      end
      if(when_SoftmaxCore_l55) begin
        if(QLinearLinearPlugin_logic_outStream_fire) begin
          if(when_SoftmaxCore_l60) begin
            softmax_maxValReg <= QLinearLinearPlugin_logic_outStream_payload_value;
            softmax_maxIdxReg <= softmax_recvCntReg;
          end
          softmax_recvCntReg <= (softmax_recvCntReg + 4'b0001);
          if(when_SoftmaxCore_l65) begin
            softmax_recvCntReg <= 4'b0000;
            softmax_emitReg <= 1'b1;
          end
        end
      end
      if(softmax_emitReg) begin
        if(softmax_activationOut_fire) begin
          softmax_maxValReg <= 8'h80;
          softmax_maxIdxReg <= 4'b0000;
          softmax_emitReg <= 1'b0;
        end
      end
    end
  end


endmodule
