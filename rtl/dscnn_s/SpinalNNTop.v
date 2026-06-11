// Generator : SpinalHDL v1.14.0    git head : 95a5e6c65c54acfc4707c8fe6ef8b5d297cfcbde
// Component : SpinalNNTop
// Git hash  : 9ed26a27b6ab793f0a36c184aed3717e4c52dbf3

`timescale 1ns/1ps

module SpinalNNTop (
  input  wire          activation_in_valid,
  output reg           activation_in_ready,
  input  wire [7:0]    activation_in_data,
  output wire          activation_out_valid,
  input  wire          activation_out_ready,
  output wire [7:0]    activation_out_data,
  output reg           weightDmaAxi_ar_valid,
  input  wire          weightDmaAxi_ar_ready,
  output reg  [32:0]   weightDmaAxi_ar_payload_addr,
  output reg  [5:0]    weightDmaAxi_ar_payload_id,
  output reg  [7:0]    weightDmaAxi_ar_payload_len,
  output reg  [2:0]    weightDmaAxi_ar_payload_size,
  output reg  [1:0]    weightDmaAxi_ar_payload_burst,
  input  wire          weightDmaAxi_r_valid,
  output reg           weightDmaAxi_r_ready,
  input  wire [511:0]  weightDmaAxi_r_payload_data,
  input  wire [5:0]    weightDmaAxi_r_payload_id,
  input  wire [1:0]    weightDmaAxi_r_payload_resp,
  input  wire          weightDmaAxi_r_payload_last,
  input  wire          clk,
  input  wire          reset
);

  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inputBuf_0_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inputBuf_1_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inputBuf_2_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inputBuf_3_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inputBuf_4_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inputBuf_5_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inputBuf_6_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inputBuf_7_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inputBuf_8_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inputBuf_9_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_weightBuf_spinal_port0;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_biasRom_spinal_port0;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_reqMultRom_spinal_port0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf_spinal_port0;
  reg        [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_weightRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_biasRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  reg        [63:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0;
  reg        [63:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_spinal_port0;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_biasRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf_spinal_port0;
  reg        [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_weightRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_biasRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  reg        [63:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0;
  reg        [63:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_spinal_port0;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_biasRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf_spinal_port0;
  reg        [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_weightRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_biasRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  reg        [63:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0;
  reg        [63:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_spinal_port0;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_biasRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf_spinal_port0;
  reg        [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_weightRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_biasRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  reg        [63:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0;
  reg        [63:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_spinal_port0;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_biasRom_spinal_port0;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_accumRam_spinal_port0;
  reg        [7:0]    output_quantized_inputBuf_spinal_port0;
  reg        [7:0]    output_quantized_weightBuf_spinal_port0;
  reg        [31:0]   output_quantized_biasRom_spinal_port0;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_0_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_rowWideReads_0_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_1_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_rowWideReads_1_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_2_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_rowWideReads_2_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_3_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_rowWideReads_3_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_4_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_rowWideReads_4_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_5_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_rowWideReads_5_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_6_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_rowWideReads_6_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_7_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_rowWideReads_7_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_8_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_rowWideReads_8_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_9_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_rowWideReads_9_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_weightBuf_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_wDataRaw_1;
  wire       [5:0]    _zz__stem_conv_Conv_output_0_quantized_biasRom_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_biasRom_port_1;
  wire       [5:0]    _zz__stem_conv_Conv_output_0_quantized_biasVal_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_biasVal_2;
  wire       [5:0]    _zz__stem_conv_Conv_output_0_quantized_reqMultRom_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_reqMultRom_port_1;
  wire       [5:0]    _zz__stem_conv_Conv_output_0_quantized_reqMultVal_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_reqMultVal_2;
  wire       [5:0]    _zz__stem_conv_Conv_output_0_quantized_reqShiftRom_port;
  wire                _zz__stem_conv_Conv_output_0_quantized_reqShiftRom_port_1;
  wire       [5:0]    _zz__stem_conv_Conv_output_0_quantized_reqShiftVal_1;
  wire                _zz__stem_conv_Conv_output_0_quantized_reqShiftVal_2;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_0_port_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_0_port_2;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_0_port_3;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_1_port_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_1_port_2;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_1_port_3;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_2_port_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_2_port_2;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_2_port_3;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_3_port_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_3_port_2;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_3_port_3;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_4_port_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_4_port_2;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_4_port_3;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_5_port_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_5_port_2;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_5_port_3;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_6_port_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_6_port_2;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_6_port_3;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_7_port_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_7_port_2;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_7_port_3;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_8_port_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_8_port_2;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_8_port_3;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_9_port_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_inputBuf_9_port_2;
  wire                _zz__stem_conv_Conv_output_0_quantized_inputBuf_9_port_3;
  wire       [0:0]    _zz__stem_conv_Conv_output_0_quantized_rxBankReg;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWrPtrReg;
  wire       [503:0]  _zz__stem_conv_Conv_output_0_quantized_wBeatBuf;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_weightBuf_port_1;
  wire       [4:0]    _zz__zz__stem_conv_Conv_output_0_quantized_curSlotReg;
  wire       [4:0]    _zz__zz__stem_conv_Conv_output_0_quantized_curSlotReg_1;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_curSlotReg_1;
  wire       [4:0]    _zz__stem_conv_Conv_output_0_quantized_curSlotReg_2;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_curSlotReg_3;
  reg        [7:0]    _zz__stem_conv_Conv_output_0_quantized_inValReg_0;
  wire       [17:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_1;
  wire       [8:0]    _zz__stem_conv_Conv_output_0_quantized_rqReg_1_1;
  wire       [8:0]    _zz__stem_conv_Conv_output_0_quantized_rqReg_1_2;
  wire       [8:0]    _zz__stem_conv_Conv_output_0_quantized_rqReg_1_3;
  wire       [8:0]    _zz__stem_conv_Conv_output_0_quantized_rqReg_1_4;
  wire       [31:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_6;
  wire       [31:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_6_1;
  wire       [32:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_11;
  wire       [32:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_11_1;
  wire       [63:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_14;
  wire       [63:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_14_1;
  wire       [79:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_14_2;
  wire       [63:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_14_3;
  wire       [95:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_15;
  wire       [63:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_15_1;
  wire       [63:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_4_1;
  wire       [63:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_4_2;
  wire       [63:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_4_3;
  wire       [31:0]   _zz__zz__stem_conv_Conv_output_0_quantized_rqReg_2;
  wire       [63:0]   _zz__zz__stem_conv_Conv_output_0_quantized_rqReg_2_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_rqReg_2_1;
  wire       [7:0]    _zz__stem_conv_Conv_output_0_quantized_rqReg_2_2;
  wire       [6:0]    _zz__stem_conv_Conv_output_0_quantized_outChReg;
  wire       [2:0]    _zz__stem_conv_Conv_output_0_quantized_outColReg;
  wire       [4:0]    _zz__stem_conv_Conv_output_0_quantized_outRowReg;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf_port;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inValR_1;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_weightRom_port;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_wValR_1;
  wire       [5:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasRom_port;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasVal_1;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasVal_2;
  wire       [5:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultRom_port;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal_1;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal_2;
  wire       [5:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftRom_port;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal_1;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal_2;
  wire       [7:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf_port_1;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf_port_2;
  wire       [8:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_rowElemReg;
  wire       [13:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_1;
  wire       [13:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_2;
  wire       [13:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_3;
  wire       [9:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_4;
  wire       [13:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_5;
  wire       [10:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_wAddrReg;
  wire       [1:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_rowStepReg;
  wire       [17:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg;
  wire       [8:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_1;
  wire       [8:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_2;
  wire       [8:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_3;
  wire       [8:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_4;
  wire       [31:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_absAReg;
  wire       [31:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_absAReg_1;
  wire       [32:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pSumReg;
  wire       [32:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pSumReg_1;
  wire       [63:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg;
  wire       [63:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg_1;
  wire       [79:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg_2;
  wire       [63:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg_3;
  wire       [95:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part2Reg;
  wire       [63:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part2Reg_1;
  wire       [63:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2_1;
  wire       [63:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2_2;
  wire       [63:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2_3;
  wire       [31:0]   _zz__zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg;
  wire       [63:0]   _zz__zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg_1;
  wire       [7:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg_1;
  wire       [7:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg_2;
  wire       [6:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_outChReg;
  wire       [2:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_outColReg;
  wire       [4:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_outRowReg;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_port;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0_1;
  wire       [2:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_port;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_port_1;
  wire       [2:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw_1;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw_2;
  wire       [5:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasRom_port;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasVal_1;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasVal_2;
  wire       [5:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultRom_port;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal_1;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal_2;
  wire       [5:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftRom_port;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal_1;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal_2;
  wire       [5:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_port_1;
  wire       [63:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_port_2;
  wire                _zz__blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_port_3;
  wire       [3:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg;
  wire       [0:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg;
  wire       [447:0]  _zz__blocks_blocks_0_pw_Conv_output_0_quantized_wBeatBuf;
  wire       [2:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_port_2;
  wire       [63:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_port_3;
  wire       [1:0]    _zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg;
  wire       [1:0]    _zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_1;
  wire       [0:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_1;
  wire       [1:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_2;
  wire       [0:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_3;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_2;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_3;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_4;
  wire       [17:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_5;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_6;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_7;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_8;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_9;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_10;
  wire       [17:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_11;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_12;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_13;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_14;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_15;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_16;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_17;
  wire       [17:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_18;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_19;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_20;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_21;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_22;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_23;
  wire       [17:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_24;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_25;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_26;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_27;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_28;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_29;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_30;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_31;
  wire       [17:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_32;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_33;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_34;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_35;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_36;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_37;
  wire       [17:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_38;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_39;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_40;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_41;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_42;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_43;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_44;
  wire       [17:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_45;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_46;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_47;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_48;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_49;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_50;
  wire       [17:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_51;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_52;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_53;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_54;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_55;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6_1;
  wire       [32:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_11;
  wire       [32:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_11_1;
  wire       [63:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14;
  wire       [63:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14_1;
  wire       [79:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14_2;
  wire       [63:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14_3;
  wire       [95:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_15;
  wire       [63:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_15_1;
  wire       [63:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4_1;
  wire       [63:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4_2;
  wire       [63:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4_3;
  wire       [31:0]   _zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2;
  wire       [63:0]   _zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2_1;
  wire       [7:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2_1;
  wire       [7:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2_2;
  wire       [6:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_outChReg;
  wire       [2:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_outColReg;
  wire       [4:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_outRowReg;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf_port;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inValR_1;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_weightRom_port;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_wValR_1;
  wire       [5:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasRom_port;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasVal_1;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasVal_2;
  wire       [5:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultRom_port;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal_1;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal_2;
  wire       [5:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftRom_port;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal_1;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal_2;
  wire       [7:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf_port_1;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf_port_2;
  wire       [8:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_rowElemReg;
  wire       [13:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_1;
  wire       [13:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_2;
  wire       [13:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_3;
  wire       [9:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_4;
  wire       [13:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_5;
  wire       [10:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_wAddrReg;
  wire       [1:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_rowStepReg;
  wire       [17:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg;
  wire       [8:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_1;
  wire       [8:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_2;
  wire       [8:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_3;
  wire       [8:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_4;
  wire       [31:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_absAReg;
  wire       [31:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_absAReg_1;
  wire       [32:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pSumReg;
  wire       [32:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pSumReg_1;
  wire       [63:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg;
  wire       [63:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg_1;
  wire       [79:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg_2;
  wire       [63:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg_3;
  wire       [95:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part2Reg;
  wire       [63:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part2Reg_1;
  wire       [63:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2_1;
  wire       [63:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2_2;
  wire       [63:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2_3;
  wire       [31:0]   _zz__zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg;
  wire       [63:0]   _zz__zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg_1;
  wire       [7:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg_1;
  wire       [7:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg_2;
  wire       [6:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_outChReg;
  wire       [2:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_outColReg;
  wire       [4:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_outRowReg;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_port;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0_1;
  wire       [2:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_port;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_port_1;
  wire       [2:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw_1;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw_2;
  wire       [5:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasRom_port;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasVal_1;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasVal_2;
  wire       [5:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultRom_port;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal_1;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal_2;
  wire       [5:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftRom_port;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal_1;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal_2;
  wire       [5:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_port_1;
  wire       [63:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_port_2;
  wire                _zz__blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_port_3;
  wire       [3:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg;
  wire       [0:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg;
  wire       [447:0]  _zz__blocks_blocks_1_pw_Conv_output_0_quantized_wBeatBuf;
  wire       [2:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_port_2;
  wire       [63:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_port_3;
  wire       [1:0]    _zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg;
  wire       [1:0]    _zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_1;
  wire       [0:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_1;
  wire       [1:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_2;
  wire       [0:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_3;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_2;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_3;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_4;
  wire       [17:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_5;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_6;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_7;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_8;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_9;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_10;
  wire       [17:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_11;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_12;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_13;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_14;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_15;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_16;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_17;
  wire       [17:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_18;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_19;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_20;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_21;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_22;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_23;
  wire       [17:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_24;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_25;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_26;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_27;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_28;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_29;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_30;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_31;
  wire       [17:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_32;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_33;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_34;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_35;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_36;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_37;
  wire       [17:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_38;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_39;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_40;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_41;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_42;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_43;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_44;
  wire       [17:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_45;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_46;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_47;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_48;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_49;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_50;
  wire       [17:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_51;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_52;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_53;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_54;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_55;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6_1;
  wire       [32:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_11;
  wire       [32:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_11_1;
  wire       [63:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14;
  wire       [63:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14_1;
  wire       [79:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14_2;
  wire       [63:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14_3;
  wire       [95:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_15;
  wire       [63:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_15_1;
  wire       [63:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4_1;
  wire       [63:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4_2;
  wire       [63:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4_3;
  wire       [31:0]   _zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2;
  wire       [63:0]   _zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2_1;
  wire       [7:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2_1;
  wire       [7:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2_2;
  wire       [6:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_outChReg;
  wire       [2:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_outColReg;
  wire       [4:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_outRowReg;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf_port;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inValR_1;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_weightRom_port;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_wValR_1;
  wire       [5:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasRom_port;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasVal_1;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasVal_2;
  wire       [5:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultRom_port;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal_1;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal_2;
  wire       [5:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftRom_port;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal_1;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal_2;
  wire       [7:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf_port_1;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf_port_2;
  wire       [8:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_rowElemReg;
  wire       [13:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_1;
  wire       [13:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_2;
  wire       [13:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_3;
  wire       [9:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_4;
  wire       [13:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_5;
  wire       [10:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_wAddrReg;
  wire       [1:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_rowStepReg;
  wire       [17:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg;
  wire       [8:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_1;
  wire       [8:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_2;
  wire       [8:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_3;
  wire       [8:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_4;
  wire       [31:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_absAReg;
  wire       [31:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_absAReg_1;
  wire       [32:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pSumReg;
  wire       [32:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pSumReg_1;
  wire       [63:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg;
  wire       [63:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg_1;
  wire       [79:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg_2;
  wire       [63:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg_3;
  wire       [95:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part2Reg;
  wire       [63:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part2Reg_1;
  wire       [63:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2_1;
  wire       [63:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2_2;
  wire       [63:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2_3;
  wire       [31:0]   _zz__zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg;
  wire       [63:0]   _zz__zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg_1;
  wire       [7:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg_1;
  wire       [7:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg_2;
  wire       [6:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_outChReg;
  wire       [2:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_outColReg;
  wire       [4:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_outRowReg;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_port;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0_1;
  wire       [2:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_port;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_port_1;
  wire       [2:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw_1;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw_2;
  wire       [5:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasRom_port;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasVal_1;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasVal_2;
  wire       [5:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultRom_port;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal_1;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal_2;
  wire       [5:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftRom_port;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal_1;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal_2;
  wire       [5:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_port_1;
  wire       [63:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_port_2;
  wire                _zz__blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_port_3;
  wire       [3:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg;
  wire       [0:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg;
  wire       [447:0]  _zz__blocks_blocks_2_pw_Conv_output_0_quantized_wBeatBuf;
  wire       [2:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_port_2;
  wire       [63:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_port_3;
  wire       [1:0]    _zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg;
  wire       [1:0]    _zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_1;
  wire       [0:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_1;
  wire       [1:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_2;
  wire       [0:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_3;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_2;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_3;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_4;
  wire       [17:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_5;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_6;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_7;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_8;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_9;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_10;
  wire       [17:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_11;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_12;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_13;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_14;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_15;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_16;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_17;
  wire       [17:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_18;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_19;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_20;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_21;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_22;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_23;
  wire       [17:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_24;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_25;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_26;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_27;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_28;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_29;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_30;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_31;
  wire       [17:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_32;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_33;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_34;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_35;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_36;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_37;
  wire       [17:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_38;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_39;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_40;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_41;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_42;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_43;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_44;
  wire       [17:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_45;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_46;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_47;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_48;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_49;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_50;
  wire       [17:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_51;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_52;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_53;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_54;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_55;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6_1;
  wire       [32:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_11;
  wire       [32:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_11_1;
  wire       [63:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14;
  wire       [63:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14_1;
  wire       [79:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14_2;
  wire       [63:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14_3;
  wire       [95:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_15;
  wire       [63:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_15_1;
  wire       [63:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4_1;
  wire       [63:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4_2;
  wire       [63:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4_3;
  wire       [31:0]   _zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2;
  wire       [63:0]   _zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2_1;
  wire       [7:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2_1;
  wire       [7:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2_2;
  wire       [6:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_outChReg;
  wire       [2:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_outColReg;
  wire       [4:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_outRowReg;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf_port;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inValR_1;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_weightRom_port;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_wValR_1;
  wire       [5:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasRom_port;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasVal_1;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasVal_2;
  wire       [5:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultRom_port;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal_1;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal_2;
  wire       [5:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftRom_port;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal_1;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal_2;
  wire       [7:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf_port_1;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf_port_2;
  wire       [8:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_rowElemReg;
  wire       [13:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_1;
  wire       [13:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_2;
  wire       [13:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_3;
  wire       [9:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_4;
  wire       [13:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_5;
  wire       [10:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_wAddrReg;
  wire       [1:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_rowStepReg;
  wire       [17:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg;
  wire       [8:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_1;
  wire       [8:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_2;
  wire       [8:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_3;
  wire       [8:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_4;
  wire       [31:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_absAReg;
  wire       [31:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_absAReg_1;
  wire       [32:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pSumReg;
  wire       [32:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pSumReg_1;
  wire       [63:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg;
  wire       [63:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg_1;
  wire       [79:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg_2;
  wire       [63:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg_3;
  wire       [95:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part2Reg;
  wire       [63:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part2Reg_1;
  wire       [63:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2_1;
  wire       [63:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2_2;
  wire       [63:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2_3;
  wire       [31:0]   _zz__zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg;
  wire       [63:0]   _zz__zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg_1;
  wire       [7:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg_1;
  wire       [7:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg_2;
  wire       [6:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_outChReg;
  wire       [2:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_outColReg;
  wire       [4:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_outRowReg;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_port;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0_1;
  wire       [2:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_port;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_port_1;
  wire       [2:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw_1;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw_2;
  wire       [5:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasRom_port;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasVal_1;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasVal_2;
  wire       [5:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultRom_port;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal_1;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal_2;
  wire       [5:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftRom_port;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftRom_port_1;
  wire       [5:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal_1;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal_2;
  wire       [5:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_port_1;
  wire       [63:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_port_2;
  wire                _zz__blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_port_3;
  wire       [3:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg;
  wire       [0:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg;
  wire       [447:0]  _zz__blocks_blocks_3_pw_Conv_output_0_quantized_wBeatBuf;
  wire       [2:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_port_2;
  wire       [63:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_port_3;
  wire       [1:0]    _zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg;
  wire       [1:0]    _zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_1;
  wire       [0:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_1;
  wire       [1:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_2;
  wire       [0:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_3;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_2;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_3;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_4;
  wire       [17:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_5;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_6;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_7;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_8;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_9;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_10;
  wire       [17:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_11;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_12;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_13;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_14;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_15;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_16;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_17;
  wire       [17:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_18;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_19;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_20;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_21;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_22;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_23;
  wire       [17:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_24;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_25;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_26;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_27;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_28;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_29;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_30;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_31;
  wire       [17:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_32;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_33;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_34;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_35;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_36;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_37;
  wire       [17:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_38;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_39;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_40;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_41;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_42;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_43;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_44;
  wire       [17:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_45;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_46;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_47;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_48;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_49;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_50;
  wire       [17:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_51;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_52;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_53;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_54;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_55;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6_1;
  wire       [32:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_11;
  wire       [32:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_11_1;
  wire       [63:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14;
  wire       [63:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14_1;
  wire       [79:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14_2;
  wire       [63:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14_3;
  wire       [95:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_15;
  wire       [63:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_15_1;
  wire       [63:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4_1;
  wire       [63:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4_2;
  wire       [63:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4_3;
  wire       [31:0]   _zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2;
  wire       [63:0]   _zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2_1;
  wire       [7:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2_1;
  wire       [7:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2_2;
  wire       [6:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_outChReg;
  wire       [2:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_outColReg;
  wire       [4:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_outRowReg;
  wire                _zz__gap_GlobalAveragePool_output_0_quantized_accumRam_port;
  wire                _zz__gap_GlobalAveragePool_output_0_quantized_readData;
  wire       [31:0]   _zz__gap_GlobalAveragePool_output_0_quantized_accumNew;
  wire       [5:0]    _zz__gap_GlobalAveragePool_output_0_quantized_accumRam_port_1;
  wire       [31:0]   _zz__gap_GlobalAveragePool_output_0_quantized_accumRam_port_2;
  wire       [6:0]    _zz__gap_GlobalAveragePool_output_0_quantized_chReg;
  wire       [2:0]    _zz__gap_GlobalAveragePool_output_0_quantized_colReg;
  wire       [4:0]    _zz__gap_GlobalAveragePool_output_0_quantized_rowReg;
  wire       [31:0]   _zz__gap_GlobalAveragePool_output_0_quantized_absAReg_1;
  wire       [31:0]   _zz__gap_GlobalAveragePool_output_0_quantized_absAReg_2;
  wire       [32:0]   _zz__gap_GlobalAveragePool_output_0_quantized_pSumReg;
  wire       [32:0]   _zz__gap_GlobalAveragePool_output_0_quantized_pSumReg_1;
  wire       [63:0]   _zz__gap_GlobalAveragePool_output_0_quantized_part1Reg;
  wire       [63:0]   _zz__gap_GlobalAveragePool_output_0_quantized_part1Reg_1;
  wire       [79:0]   _zz__gap_GlobalAveragePool_output_0_quantized_part1Reg_2;
  wire       [63:0]   _zz__gap_GlobalAveragePool_output_0_quantized_part1Reg_3;
  wire       [95:0]   _zz__gap_GlobalAveragePool_output_0_quantized_part2Reg;
  wire       [63:0]   _zz__gap_GlobalAveragePool_output_0_quantized_part2Reg_1;
  wire       [63:0]   _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2_1;
  wire       [63:0]   _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2_2;
  wire       [63:0]   _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2_3;
  wire       [31:0]   _zz__zz__gap_GlobalAveragePool_output_0_quantized_resultReg;
  wire       [27:0]   _zz__zz__gap_GlobalAveragePool_output_0_quantized_resultReg_1;
  wire       [7:0]    _zz__gap_GlobalAveragePool_output_0_quantized_resultReg_1;
  wire       [7:0]    _zz__gap_GlobalAveragePool_output_0_quantized_resultReg_2;
  wire                _zz_output_quantized_inputBuf_port;
  wire                _zz_output_quantized_inValR;
  wire                _zz_output_quantized_weightBuf_port;
  wire                _zz_output_quantized_wValR;
  wire                _zz_output_quantized_biasRom_port;
  wire                _zz_output_quantized_biasVal_1;
  wire       [5:0]    _zz_output_quantized_inputBuf_port_1;
  wire       [7:0]    _zz_output_quantized_inputBuf_port_2;
  wire       [503:0]  _zz_output_quantized_wBeatBuf;
  wire       [5:0]    _zz_output_quantized_weightBuf_port_1;
  wire       [7:0]    _zz_output_quantized_weightBuf_port_2;
  wire       [7:0]    _zz_output_quantized_weightBuf_port_3;
  wire       [17:0]   _zz_output_quantized_prodReg;
  wire       [8:0]    _zz_output_quantized_prodReg_1;
  wire       [8:0]    _zz_output_quantized_prodReg_2;
  wire       [8:0]    _zz_output_quantized_prodReg_3;
  wire       [8:0]    _zz_output_quantized_prodReg_4;
  wire       [31:0]   _zz_output_quantized_absAReg;
  wire       [31:0]   _zz_output_quantized_absAReg_1;
  wire       [32:0]   _zz_output_quantized_pSumReg;
  wire       [32:0]   _zz_output_quantized_pSumReg_1;
  wire       [63:0]   _zz_output_quantized_part1Reg;
  wire       [63:0]   _zz_output_quantized_part1Reg_1;
  wire       [79:0]   _zz_output_quantized_part1Reg_2;
  wire       [63:0]   _zz_output_quantized_part1Reg_3;
  wire       [95:0]   _zz_output_quantized_part2Reg;
  wire       [63:0]   _zz_output_quantized_part2Reg_1;
  wire       [63:0]   _zz_output_quantized_reqProdReg2_1;
  wire       [63:0]   _zz_output_quantized_reqProdReg2_2;
  wire       [63:0]   _zz_output_quantized_reqProdReg2_3;
  wire       [31:0]   _zz__zz_output_quantized_resultReg;
  wire       [15:0]   _zz__zz_output_quantized_resultReg_1;
  wire       [7:0]    _zz_output_quantized_resultReg_1;
  wire       [7:0]    _zz_output_quantized_resultReg_2;
  wire       [3:0]    _zz_output_quantized_outNeurReg;
  reg        [0:0]    _zz__zz_weightDmaAxi_ar_payload_len;
  reg        [32:0]   _zz_weightDmaAxi_ar_payload_addr_3;
  wire       [32:0]   _zz_weightDmaAxi_ar_payload_addr_4;
  wire       [13:0]   _zz_weightDmaAxi_ar_payload_addr_5;
  reg        [6:0]    _zz_weightDmaAxi_ar_payload_addr_6;
  wire       [0:0]    _zz_weightDmaAxi_ar_payload_len_1;
  wire       [0:0]    _zz_when_WeightDmaCore_l178_1;
  wire       [6:0]    _zz__zz_weightDmaAxi_ar_payload_addr_2;
  reg        [6:0]    _zz__zz_weightDmaAxi_ar_payload_addr_2_1;
  wire       [6:0]    _zz__zz_weightDmaAxi_ar_payload_addr_1;
  wire       [2:0]    _zz__zz_weightDmaAxi_ar_payload_addr;
  reg                 _zz_1;
  reg                 _zz_2;
  reg                 _zz_3;
  reg                 _zz_4;
  reg                 _zz_5;
  reg                 _zz_6;
  reg                 _zz_7;
  wire                QLinearConvLineCorePlugin_logic_outStream_valid;
  reg                 QLinearConvLineCorePlugin_logic_outStream_ready;
  wire       [7:0]    QLinearConvLineCorePlugin_logic_outStream_payload_value;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_zpWideBits;
  reg                 _stem_conv_Conv_output_0_quantized_weightIn_valid;
  reg                 _stem_conv_Conv_output_0_quantized_weightIn_ready;
  reg        [511:0]  _stem_conv_Conv_output_0_quantized_weightIn_payload;
  reg        [5:0]    _stem_conv_Conv_output_0_quantized_wStepReg;
  reg        [6:0]    _stem_conv_Conv_output_0_quantized_wBeatStepReg;
  reg        [511:0]  _stem_conv_Conv_output_0_quantized_wBeatBuf;
  reg                 _stem_conv_Conv_output_0_quantized_wBeatDraining;
  reg                 _stem_conv_Conv_output_0_quantized_activationOut_valid;
  wire                _stem_conv_Conv_output_0_quantized_activationOut_ready;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_activationOut_payload_value;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sReceiveRow;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sLoadBias;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sWaitBias;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sCompute;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sRequant;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sRequantMul;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sRequantWait;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sRequantWait2;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sRequantWait3;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sRequantShift;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sEmit;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sInit;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_sLoadWeights;
  reg        [3:0]    _stem_conv_Conv_output_0_quantized_stateReg;
  reg        [3:0]    _stem_conv_Conv_output_0_quantized_rowWrPtrReg;
  reg        [3:0]    _stem_conv_Conv_output_0_quantized_rowsUntilComputeReg;
  reg        [5:0]    _stem_conv_Conv_output_0_quantized_realRowsRecvReg;
  reg        [0:0]    _stem_conv_Conv_output_0_quantized_rxBankReg;
  reg        [3:0]    _stem_conv_Conv_output_0_quantized_rxWordReg;
  reg        [3:0]    _stem_conv_Conv_output_0_quantized_initSlotReg;
  reg        [3:0]    _stem_conv_Conv_output_0_quantized_initAddrReg;
  reg        [4:0]    _stem_conv_Conv_output_0_quantized_outRowReg;
  reg        [2:0]    _stem_conv_Conv_output_0_quantized_outColReg;
  reg        [6:0]    _stem_conv_Conv_output_0_quantized_outChReg;
  reg        [3:0]    _stem_conv_Conv_output_0_quantized_khCntReg;
  reg        [2:0]    _stem_conv_Conv_output_0_quantized_rowStepReg;
  reg        [5:0]    _stem_conv_Conv_output_0_quantized_compCycleReg;
  reg        [3:0]    _stem_conv_Conv_output_0_quantized_rowAddrBaseReg;
  reg        [3:0]    _stem_conv_Conv_output_0_quantized_rowAddrReg;
  reg        [5:0]    _stem_conv_Conv_output_0_quantized_wAddrReg;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_rowAddrComb;
  wire       [5:0]    _stem_conv_Conv_output_0_quantized_wAddrComb;
  wire       [3:0]    _stem_conv_Conv_output_0_quantized_rxAddr;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWideReads_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowWideReads_0;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWideReads_1;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowWideReads_1;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWideReads_2;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowWideReads_2;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWideReads_3;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowWideReads_3;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWideReads_4;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowWideReads_4;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWideReads_5;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowWideReads_5;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWideReads_6;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowWideReads_6;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWideReads_7;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowWideReads_7;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWideReads_8;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowWideReads_8;
  wire       [3:0]    _zz__stem_conv_Conv_output_0_quantized_rowWideReads_9;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowWideReads_9;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowReads2D_0_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowReads2D_1_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowReads2D_2_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowReads2D_3_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowReads2D_4_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowReads2D_5_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowReads2D_6_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowReads2D_7_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowReads2D_8_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_rowReads2D_9_0;
  wire       [5:0]    _zz__stem_conv_Conv_output_0_quantized_wDataRaw;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_wDataRaw;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_wValsRaw_0;
  wire       [6:0]    _zz__stem_conv_Conv_output_0_quantized_biasVal;
  wire       [31:0]   _stem_conv_Conv_output_0_quantized_biasVal;
  wire       [6:0]    _zz__stem_conv_Conv_output_0_quantized_reqMultVal;
  wire       [31:0]   _stem_conv_Conv_output_0_quantized_reqMultVal;
  wire       [6:0]    _zz__stem_conv_Conv_output_0_quantized_reqShiftVal;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_reqShiftVal;
  reg        [3:0]    _stem_conv_Conv_output_0_quantized_curSlotReg;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_inValReg_0;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_wValReg_0;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_rqReg_0;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_rqReg_1;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_rqReg_2;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_rqReg_3;
  reg        [63:0]   _stem_conv_Conv_output_0_quantized_rqReg_4;
  reg                 _stem_conv_Conv_output_0_quantized_rqReg_5;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_rqReg_6;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_rqReg_7;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_rqReg_8;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_rqReg_9;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_rqReg_10;
  reg        [32:0]   _stem_conv_Conv_output_0_quantized_rqReg_11;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_rqReg_12;
  reg        [31:0]   _stem_conv_Conv_output_0_quantized_rqReg_13;
  reg        [63:0]   _stem_conv_Conv_output_0_quantized_rqReg_14;
  reg        [63:0]   _stem_conv_Conv_output_0_quantized_rqReg_15;
  wire                _stem_conv_Conv_output_0_quantized_isReal;
  reg        [7:0]    _stem_conv_Conv_output_0_quantized_rxByteRegs_0;
  wire                io_activationIn_fire;
  wire                when_QLinearConvLineCore_l346;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_recvDataSeq_0;
  wire       [7:0]    _stem_conv_Conv_output_0_quantized_recvData;
  wire                _zz_22;
  wire                _zz_23;
  wire                _zz_24;
  wire                _zz_25;
  wire                _zz_27;
  wire                _zz_28;
  wire                _zz_29;
  wire                _zz_30;
  wire                _zz_32;
  wire                _zz_33;
  wire                _zz_34;
  wire                _zz_35;
  wire                _zz_37;
  wire                _zz_38;
  wire                _zz_39;
  wire                _zz_40;
  wire                _zz_42;
  wire                _zz_43;
  wire                _zz_44;
  wire                _zz_45;
  wire                _zz_47;
  wire                _zz_48;
  wire                _zz_49;
  wire                _zz_50;
  wire                _zz_52;
  wire                _zz_53;
  wire                _zz_54;
  wire                _zz_55;
  wire                _zz_57;
  wire                _zz_58;
  wire                _zz_59;
  wire                _zz_60;
  wire                _zz_62;
  wire                _zz_63;
  wire                _zz_64;
  wire                _zz_65;
  wire                _zz_67;
  wire                _zz_68;
  wire                _zz_69;
  wire                _zz_70;
  wire                when_QLinearConvLineCore_l382;
  wire                when_QLinearConvLineCore_l384;
  wire                when_QLinearConvLineCore_l387;
  wire                when_QLinearConvLineCore_l406;
  wire                when_QLinearConvLineCore_l410;
  wire                when_QLinearConvLineCore_l413;
  wire                when_QLinearConvLineCore_l418;
  wire                when_QLinearConvLineCore_l424;
  wire                when_QLinearConvLineCore_l438;
  wire                when_QLinearConvLineCore_l439;
  wire                _stem_conv_Conv_output_0_quantized_weightIn_fire;
  wire                when_QLinearConvLineCore_l448;
  wire                when_QLinearConvLineCore_l454;
  wire                when_QLinearConvLineCore_l456;
  wire                when_QLinearConvLineCore_l466;
  wire       [4:0]    _zz__stem_conv_Conv_output_0_quantized_rowAddrBaseReg;
  wire                when_QLinearConvLineCore_l479;
  wire                when_QLinearConvLineCore_l485;
  wire                when_QLinearConvLineCore_l489;
  wire       [4:0]    _zz__stem_conv_Conv_output_0_quantized_curSlotReg;
  wire                when_QLinearConvLineCore_l493;
  wire                when_QLinearConvLineCore_l505;
  wire                when_QLinearConvLineCore_l515;
  wire                when_QLinearConvLineCore_l532;
  wire       [31:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_0;
  wire                when_QLinearConvLineCore_l535;
  wire                when_QLinearConvLineCore_l545;
  wire                when_QLinearConvLineCore_l551;
  wire       [15:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_9;
  wire       [15:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_7;
  wire       [15:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_8;
  wire       [15:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_7_1;
  wire                when_QLinearConvLineCore_l563;
  wire                when_QLinearConvLineCore_l570;
  wire                when_QLinearConvLineCore_l576;
  wire       [63:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_4;
  wire                when_QLinearConvLineCore_l583;
  wire       [31:0]   _zz__stem_conv_Conv_output_0_quantized_rqReg_2;
  wire                when_QLinearConvLineCore_l596;
  wire                _stem_conv_Conv_output_0_quantized_activationOut_fire;
  wire                when_QLinearConvLineCore_l608;
  wire                when_QLinearConvLineCore_l612;
  wire                when_QLinearConvLineCore_l616;
  wire                DepthwiseConvPlugin_logic_outStream_valid;
  reg                 DepthwiseConvPlugin_logic_outStream_ready;
  wire       [7:0]    DepthwiseConvPlugin_logic_outStream_payload_value;
  reg                 _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_valid;
  wire                _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_ready;
  reg        [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_payload_value;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sReceive;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sLoadBias;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sCompute;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sRequant;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantMul;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait2;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait3;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantShift;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sEmit;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sInit;
  wire       [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_sWaitBias;
  reg        [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg;
  reg        [12:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_recvCntReg;
  reg        [13:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_padWriteAddrReg;
  reg        [8:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_rowElemReg;
  reg        [4:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_outRowReg;
  reg        [2:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_outColReg;
  reg        [6:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_outChReg;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_accumReg;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_prodReg;
  reg        [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_resultReg;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_accumRequantReg;
  reg        [63:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2;
  reg                 _blocks_blocks_0_dw_Conv_output_0_quantized_signAReg;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_absAReg;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_pLH_Reg;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_pHL_Reg;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_pHH_Reg;
  reg        [32:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_pSumReg;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg2;
  reg        [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_pHH_Reg2;
  reg        [63:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg;
  reg        [63:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_part2Reg;
  reg        [13:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_initAddrReg;
  reg        [13:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg;
  reg        [9:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_wAddrReg;
  reg        [3:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg;
  reg        [1:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_rowStepReg;
  wire       [13:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_inAddrComb;
  wire       [9:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_wAddrComb;
  wire       [13:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inValR;
  wire       [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_inValR;
  wire       [9:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_wValR;
  wire       [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_wValR;
  wire       [6:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasVal;
  wire       [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_biasVal;
  wire       [6:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal;
  wire       [31:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal;
  wire       [6:0]    _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal;
  wire       [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal;
  wire                _blocks_blocks_0_dw_Conv_output_0_quantized_doInit;
  wire                QLinearConvLineCorePlugin_logic_outStream_fire;
  wire                _blocks_blocks_0_dw_Conv_output_0_quantized_doRecv;
  wire       [13:0]   _blocks_blocks_0_dw_Conv_output_0_quantized_wrAddr;
  wire       [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_wrData;
  reg        [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_inValReg;
  reg        [7:0]    _blocks_blocks_0_dw_Conv_output_0_quantized_wValReg;
  wire                when_DepthwiseConvCore_l238;
  wire                when_DepthwiseConvCore_l240;
  wire                when_DepthwiseConvCore_l252;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_padWriteAddrReg;
  wire                when_DepthwiseConvCore_l264;
  wire                when_DepthwiseConvCore_l278;
  wire                when_DepthwiseConvCore_l289;
  wire                when_DepthwiseConvCore_l303;
  wire                when_DepthwiseConvCore_l307;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg;
  wire                when_DepthwiseConvCore_l319;
  wire                when_DepthwiseConvCore_l325;
  wire                when_DepthwiseConvCore_l334;
  wire       [31:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_accumReg;
  wire                when_DepthwiseConvCore_l337;
  wire                when_DepthwiseConvCore_l346;
  wire                when_DepthwiseConvCore_l352;
  wire       [15:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pHL_Reg;
  wire       [15:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg;
  wire       [15:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLH_Reg;
  wire       [15:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg_1;
  wire                when_DepthwiseConvCore_l362;
  wire                when_DepthwiseConvCore_l368;
  wire                when_DepthwiseConvCore_l374;
  wire       [63:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2;
  wire                when_DepthwiseConvCore_l381;
  wire       [31:0]   _zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg;
  wire                when_DepthwiseConvCore_l398;
  wire                _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_fire;
  wire                when_DepthwiseConvCore_l410;
  wire                when_DepthwiseConvCore_l414;
  wire                _zz__blocks_blocks_0_dw_Conv_output_0_quantized_stateReg;
  wire                QLinearConvLineCorePlugin_logic_outStream_valid_1;
  reg                 QLinearConvLineCorePlugin_logic_outStream_ready_1;
  wire       [7:0]    QLinearConvLineCorePlugin_logic_outStream_payload_value_1;
  wire       [63:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_zpWideBits;
  reg                 _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_valid;
  reg                 _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_ready;
  reg        [511:0]  _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_payload;
  reg        [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wStepReg;
  reg        [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatStepReg;
  reg        [511:0]  _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatBuf;
  reg                 _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatDraining;
  reg                 _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_valid;
  wire                _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_ready;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_payload_value;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sLoadBias;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sWaitBias;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sCompute;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sRequant;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantMul;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait2;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait3;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantShift;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sEmit;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sInit;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_sLoadWeights;
  reg        [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg;
  reg        [0:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg;
  reg        [0:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowsUntilComputeReg;
  reg        [4:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_realRowsRecvReg;
  reg        [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg;
  reg        [5:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxWordReg;
  reg        [0:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_initSlotReg;
  reg        [5:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_initAddrReg;
  reg        [4:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_outRowReg;
  reg        [2:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_outColReg;
  reg        [6:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_outChReg;
  reg        [0:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_khCntReg;
  reg        [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowStepReg;
  reg        [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg;
  reg        [5:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrBaseReg;
  reg        [5:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrReg;
  reg        [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wAddrReg;
  wire       [5:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrComb;
  wire       [3:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wAddrComb;
  wire       [5:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxAddr;
  wire       [5:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0;
  wire       [63:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_0;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_1;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_2;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_3;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_4;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_5;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_6;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_7;
  wire       [3:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw;
  wire       [63:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_0;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_1;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_2;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_3;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_4;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_5;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_6;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_7;
  wire       [6:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasVal;
  wire       [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_biasVal;
  wire       [6:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal;
  wire       [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal;
  wire       [6:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal;
  reg        [0:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_0;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_1;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_2;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_3;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_4;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_5;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_6;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_7;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_0;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_1;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_2;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_3;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_4;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_5;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_6;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_7;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_0;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_3;
  reg        [63:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4;
  reg                 _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_5;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_8;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_9;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_10;
  reg        [32:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_11;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_12;
  reg        [31:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_13;
  reg        [63:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14;
  reg        [63:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_15;
  wire                _blocks_blocks_0_pw_Conv_output_0_quantized_isReal;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_0;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_1;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_2;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_3;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_4;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_5;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_6;
  reg        [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_7;
  wire                DepthwiseConvPlugin_logic_outStream_fire;
  wire                when_QLinearConvLineCore_l346_1;
  wire                when_QLinearConvLineCore_l346_2;
  wire                when_QLinearConvLineCore_l346_3;
  wire                when_QLinearConvLineCore_l346_4;
  wire                when_QLinearConvLineCore_l346_5;
  wire                when_QLinearConvLineCore_l346_6;
  wire                when_QLinearConvLineCore_l346_7;
  wire                when_QLinearConvLineCore_l346_8;
  wire       [7:0]    _blocks_blocks_0_pw_Conv_output_0_quantized_recvDataSeq_7;
  wire       [63:0]   _blocks_blocks_0_pw_Conv_output_0_quantized_recvData;
  wire                _zz_84;
  wire                _zz_85;
  wire                _zz_86;
  wire                _zz_87;
  wire                when_QLinearConvLineCore_l406_1;
  wire                when_QLinearConvLineCore_l410_1;
  wire                when_QLinearConvLineCore_l413_1;
  wire                when_QLinearConvLineCore_l418_1;
  wire                when_QLinearConvLineCore_l424_1;
  wire                when_QLinearConvLineCore_l438_1;
  wire                when_QLinearConvLineCore_l439_1;
  wire                _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_fire;
  wire                when_QLinearConvLineCore_l448_1;
  wire                when_QLinearConvLineCore_l454_1;
  wire                when_QLinearConvLineCore_l456_1;
  wire                when_QLinearConvLineCore_l466_1;
  wire       [6:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrBaseReg;
  wire                when_QLinearConvLineCore_l479_1;
  wire                when_QLinearConvLineCore_l485_1;
  wire                when_QLinearConvLineCore_l489_1;
  wire       [1:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg;
  wire                when_QLinearConvLineCore_l493_1;
  wire                when_QLinearConvLineCore_l505_1;
  wire                when_QLinearConvLineCore_l515_1;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1;
  wire       [8:0]    _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_1;
  wire                when_QLinearConvLineCore_l532_1;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_0;
  wire                when_QLinearConvLineCore_l535_1;
  wire                when_QLinearConvLineCore_l545_1;
  wire                when_QLinearConvLineCore_l551_1;
  wire       [15:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_9;
  wire       [15:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7;
  wire       [15:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_8;
  wire       [15:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7_1;
  wire                when_QLinearConvLineCore_l563_1;
  wire                when_QLinearConvLineCore_l570_1;
  wire                when_QLinearConvLineCore_l576_1;
  wire       [63:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4;
  wire                when_QLinearConvLineCore_l583_1;
  wire       [31:0]   _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2;
  wire                when_QLinearConvLineCore_l596_1;
  wire                _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_fire;
  wire                when_QLinearConvLineCore_l608_1;
  wire                when_QLinearConvLineCore_l612_1;
  wire                when_QLinearConvLineCore_l616_1;
  wire                DepthwiseConvPlugin_logic_outStream_valid_1;
  reg                 DepthwiseConvPlugin_logic_outStream_ready_1;
  wire       [7:0]    DepthwiseConvPlugin_logic_outStream_payload_value_1;
  reg                 _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_valid;
  wire                _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_ready;
  reg        [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_payload_value;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sReceive;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sLoadBias;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sCompute;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sRequant;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantMul;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait2;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait3;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantShift;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sEmit;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sInit;
  wire       [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_sWaitBias;
  reg        [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg;
  reg        [12:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_recvCntReg;
  reg        [13:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_padWriteAddrReg;
  reg        [8:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_rowElemReg;
  reg        [4:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_outRowReg;
  reg        [2:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_outColReg;
  reg        [6:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_outChReg;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_accumReg;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_prodReg;
  reg        [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_resultReg;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_accumRequantReg;
  reg        [63:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2;
  reg                 _blocks_blocks_1_dw_Conv_output_0_quantized_signAReg;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_absAReg;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_pLH_Reg;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_pHL_Reg;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_pHH_Reg;
  reg        [32:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_pSumReg;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg2;
  reg        [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_pHH_Reg2;
  reg        [63:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg;
  reg        [63:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_part2Reg;
  reg        [13:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_initAddrReg;
  reg        [13:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg;
  reg        [9:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_wAddrReg;
  reg        [3:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg;
  reg        [1:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_rowStepReg;
  wire       [13:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_inAddrComb;
  wire       [9:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_wAddrComb;
  wire       [13:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inValR;
  wire       [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_inValR;
  wire       [9:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_wValR;
  wire       [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_wValR;
  wire       [6:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasVal;
  wire       [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_biasVal;
  wire       [6:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal;
  wire       [31:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal;
  wire       [6:0]    _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal;
  wire       [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal;
  wire                _blocks_blocks_1_dw_Conv_output_0_quantized_doInit;
  wire                QLinearConvLineCorePlugin_logic_outStream_fire_1;
  wire                _blocks_blocks_1_dw_Conv_output_0_quantized_doRecv;
  wire       [13:0]   _blocks_blocks_1_dw_Conv_output_0_quantized_wrAddr;
  wire       [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_wrData;
  reg        [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_inValReg;
  reg        [7:0]    _blocks_blocks_1_dw_Conv_output_0_quantized_wValReg;
  wire                when_DepthwiseConvCore_l238_1;
  wire                when_DepthwiseConvCore_l240_1;
  wire                when_DepthwiseConvCore_l252_1;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_padWriteAddrReg;
  wire                when_DepthwiseConvCore_l264_1;
  wire                when_DepthwiseConvCore_l278_1;
  wire                when_DepthwiseConvCore_l289_1;
  wire                when_DepthwiseConvCore_l303_1;
  wire                when_DepthwiseConvCore_l307_1;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg;
  wire                when_DepthwiseConvCore_l319_1;
  wire                when_DepthwiseConvCore_l325_1;
  wire                when_DepthwiseConvCore_l334_1;
  wire       [31:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_accumReg;
  wire                when_DepthwiseConvCore_l337_1;
  wire                when_DepthwiseConvCore_l346_1;
  wire                when_DepthwiseConvCore_l352_1;
  wire       [15:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pHL_Reg;
  wire       [15:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg;
  wire       [15:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLH_Reg;
  wire       [15:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg_1;
  wire                when_DepthwiseConvCore_l362_1;
  wire                when_DepthwiseConvCore_l368_1;
  wire                when_DepthwiseConvCore_l374_1;
  wire       [63:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2;
  wire                when_DepthwiseConvCore_l381_1;
  wire       [31:0]   _zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg;
  wire                when_DepthwiseConvCore_l398_1;
  wire                _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_fire;
  wire                when_DepthwiseConvCore_l410_1;
  wire                when_DepthwiseConvCore_l414_1;
  wire                _zz__blocks_blocks_1_dw_Conv_output_0_quantized_stateReg;
  wire                QLinearConvLineCorePlugin_logic_outStream_valid_2;
  reg                 QLinearConvLineCorePlugin_logic_outStream_ready_2;
  wire       [7:0]    QLinearConvLineCorePlugin_logic_outStream_payload_value_2;
  wire       [63:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_zpWideBits;
  reg                 _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_valid;
  reg                 _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_ready;
  reg        [511:0]  _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_payload;
  reg        [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wStepReg;
  reg        [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatStepReg;
  reg        [511:0]  _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatBuf;
  reg                 _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatDraining;
  reg                 _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_valid;
  wire                _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_ready;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_payload_value;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sLoadBias;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sWaitBias;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sCompute;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sRequant;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantMul;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait2;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait3;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantShift;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sEmit;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sInit;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_sLoadWeights;
  reg        [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg;
  reg        [0:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg;
  reg        [0:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowsUntilComputeReg;
  reg        [4:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_realRowsRecvReg;
  reg        [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg;
  reg        [5:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxWordReg;
  reg        [0:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_initSlotReg;
  reg        [5:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_initAddrReg;
  reg        [4:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_outRowReg;
  reg        [2:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_outColReg;
  reg        [6:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_outChReg;
  reg        [0:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_khCntReg;
  reg        [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowStepReg;
  reg        [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg;
  reg        [5:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrBaseReg;
  reg        [5:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrReg;
  reg        [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wAddrReg;
  wire       [5:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrComb;
  wire       [3:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wAddrComb;
  wire       [5:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxAddr;
  wire       [5:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0;
  wire       [63:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_0;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_1;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_2;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_3;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_4;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_5;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_6;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_7;
  wire       [3:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw;
  wire       [63:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_0;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_1;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_2;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_3;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_4;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_5;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_6;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_7;
  wire       [6:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasVal;
  wire       [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_biasVal;
  wire       [6:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal;
  wire       [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal;
  wire       [6:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal;
  reg        [0:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_0;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_1;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_2;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_3;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_4;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_5;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_6;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_7;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_0;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_1;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_2;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_3;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_4;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_5;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_6;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_7;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_0;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_3;
  reg        [63:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4;
  reg                 _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_5;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_8;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_9;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_10;
  reg        [32:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_11;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_12;
  reg        [31:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_13;
  reg        [63:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14;
  reg        [63:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_15;
  wire                _blocks_blocks_1_pw_Conv_output_0_quantized_isReal;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_0;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_1;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_2;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_3;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_4;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_5;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_6;
  reg        [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_7;
  wire                DepthwiseConvPlugin_logic_outStream_fire_1;
  wire                when_QLinearConvLineCore_l346_9;
  wire                when_QLinearConvLineCore_l346_10;
  wire                when_QLinearConvLineCore_l346_11;
  wire                when_QLinearConvLineCore_l346_12;
  wire                when_QLinearConvLineCore_l346_13;
  wire                when_QLinearConvLineCore_l346_14;
  wire                when_QLinearConvLineCore_l346_15;
  wire                when_QLinearConvLineCore_l346_16;
  wire       [7:0]    _blocks_blocks_1_pw_Conv_output_0_quantized_recvDataSeq_7;
  wire       [63:0]   _blocks_blocks_1_pw_Conv_output_0_quantized_recvData;
  wire                _zz_101;
  wire                _zz_102;
  wire                _zz_103;
  wire                _zz_104;
  wire                when_QLinearConvLineCore_l406_2;
  wire                when_QLinearConvLineCore_l410_2;
  wire                when_QLinearConvLineCore_l413_2;
  wire                when_QLinearConvLineCore_l418_2;
  wire                when_QLinearConvLineCore_l424_2;
  wire                when_QLinearConvLineCore_l438_2;
  wire                when_QLinearConvLineCore_l439_2;
  wire                _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_fire;
  wire                when_QLinearConvLineCore_l448_2;
  wire                when_QLinearConvLineCore_l454_2;
  wire                when_QLinearConvLineCore_l456_2;
  wire                when_QLinearConvLineCore_l466_2;
  wire       [6:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrBaseReg;
  wire                when_QLinearConvLineCore_l479_2;
  wire                when_QLinearConvLineCore_l485_2;
  wire                when_QLinearConvLineCore_l489_2;
  wire       [1:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg;
  wire                when_QLinearConvLineCore_l493_2;
  wire                when_QLinearConvLineCore_l505_2;
  wire                when_QLinearConvLineCore_l515_2;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1;
  wire       [8:0]    _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_1;
  wire                when_QLinearConvLineCore_l532_2;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_0;
  wire                when_QLinearConvLineCore_l535_2;
  wire                when_QLinearConvLineCore_l545_2;
  wire                when_QLinearConvLineCore_l551_2;
  wire       [15:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_9;
  wire       [15:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7;
  wire       [15:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_8;
  wire       [15:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7_1;
  wire                when_QLinearConvLineCore_l563_2;
  wire                when_QLinearConvLineCore_l570_2;
  wire                when_QLinearConvLineCore_l576_2;
  wire       [63:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4;
  wire                when_QLinearConvLineCore_l583_2;
  wire       [31:0]   _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2;
  wire                when_QLinearConvLineCore_l596_2;
  wire                _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_fire;
  wire                when_QLinearConvLineCore_l608_2;
  wire                when_QLinearConvLineCore_l612_2;
  wire                when_QLinearConvLineCore_l616_2;
  wire                DepthwiseConvPlugin_logic_outStream_valid_2;
  reg                 DepthwiseConvPlugin_logic_outStream_ready_2;
  wire       [7:0]    DepthwiseConvPlugin_logic_outStream_payload_value_2;
  reg                 _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_valid;
  wire                _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_ready;
  reg        [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_payload_value;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sReceive;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sLoadBias;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sCompute;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sRequant;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantMul;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait2;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait3;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantShift;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sEmit;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sInit;
  wire       [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_sWaitBias;
  reg        [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg;
  reg        [12:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_recvCntReg;
  reg        [13:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_padWriteAddrReg;
  reg        [8:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_rowElemReg;
  reg        [4:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_outRowReg;
  reg        [2:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_outColReg;
  reg        [6:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_outChReg;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_accumReg;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_prodReg;
  reg        [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_resultReg;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_accumRequantReg;
  reg        [63:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2;
  reg                 _blocks_blocks_2_dw_Conv_output_0_quantized_signAReg;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_absAReg;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_pLH_Reg;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_pHL_Reg;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_pHH_Reg;
  reg        [32:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_pSumReg;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg2;
  reg        [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_pHH_Reg2;
  reg        [63:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg;
  reg        [63:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_part2Reg;
  reg        [13:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_initAddrReg;
  reg        [13:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg;
  reg        [9:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_wAddrReg;
  reg        [3:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg;
  reg        [1:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_rowStepReg;
  wire       [13:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_inAddrComb;
  wire       [9:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_wAddrComb;
  wire       [13:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inValR;
  wire       [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_inValR;
  wire       [9:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_wValR;
  wire       [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_wValR;
  wire       [6:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasVal;
  wire       [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_biasVal;
  wire       [6:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal;
  wire       [31:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal;
  wire       [6:0]    _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal;
  wire       [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal;
  wire                _blocks_blocks_2_dw_Conv_output_0_quantized_doInit;
  wire                QLinearConvLineCorePlugin_logic_outStream_fire_2;
  wire                _blocks_blocks_2_dw_Conv_output_0_quantized_doRecv;
  wire       [13:0]   _blocks_blocks_2_dw_Conv_output_0_quantized_wrAddr;
  wire       [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_wrData;
  reg        [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_inValReg;
  reg        [7:0]    _blocks_blocks_2_dw_Conv_output_0_quantized_wValReg;
  wire                when_DepthwiseConvCore_l238_2;
  wire                when_DepthwiseConvCore_l240_2;
  wire                when_DepthwiseConvCore_l252_2;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_padWriteAddrReg;
  wire                when_DepthwiseConvCore_l264_2;
  wire                when_DepthwiseConvCore_l278_2;
  wire                when_DepthwiseConvCore_l289_2;
  wire                when_DepthwiseConvCore_l303_2;
  wire                when_DepthwiseConvCore_l307_2;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg;
  wire                when_DepthwiseConvCore_l319_2;
  wire                when_DepthwiseConvCore_l325_2;
  wire                when_DepthwiseConvCore_l334_2;
  wire       [31:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_accumReg;
  wire                when_DepthwiseConvCore_l337_2;
  wire                when_DepthwiseConvCore_l346_2;
  wire                when_DepthwiseConvCore_l352_2;
  wire       [15:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pHL_Reg;
  wire       [15:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg;
  wire       [15:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLH_Reg;
  wire       [15:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg_1;
  wire                when_DepthwiseConvCore_l362_2;
  wire                when_DepthwiseConvCore_l368_2;
  wire                when_DepthwiseConvCore_l374_2;
  wire       [63:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2;
  wire                when_DepthwiseConvCore_l381_2;
  wire       [31:0]   _zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg;
  wire                when_DepthwiseConvCore_l398_2;
  wire                _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_fire;
  wire                when_DepthwiseConvCore_l410_2;
  wire                when_DepthwiseConvCore_l414_2;
  wire                _zz__blocks_blocks_2_dw_Conv_output_0_quantized_stateReg;
  wire                QLinearConvLineCorePlugin_logic_outStream_valid_3;
  reg                 QLinearConvLineCorePlugin_logic_outStream_ready_3;
  wire       [7:0]    QLinearConvLineCorePlugin_logic_outStream_payload_value_3;
  wire       [63:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_zpWideBits;
  reg                 _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_valid;
  reg                 _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_ready;
  reg        [511:0]  _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_payload;
  reg        [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wStepReg;
  reg        [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatStepReg;
  reg        [511:0]  _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatBuf;
  reg                 _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatDraining;
  reg                 _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_valid;
  wire                _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_ready;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_payload_value;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sLoadBias;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sWaitBias;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sCompute;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sRequant;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantMul;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait2;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait3;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantShift;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sEmit;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sInit;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_sLoadWeights;
  reg        [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg;
  reg        [0:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg;
  reg        [0:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowsUntilComputeReg;
  reg        [4:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_realRowsRecvReg;
  reg        [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg;
  reg        [5:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxWordReg;
  reg        [0:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_initSlotReg;
  reg        [5:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_initAddrReg;
  reg        [4:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_outRowReg;
  reg        [2:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_outColReg;
  reg        [6:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_outChReg;
  reg        [0:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_khCntReg;
  reg        [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowStepReg;
  reg        [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg;
  reg        [5:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrBaseReg;
  reg        [5:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrReg;
  reg        [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wAddrReg;
  wire       [5:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrComb;
  wire       [3:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wAddrComb;
  wire       [5:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxAddr;
  wire       [5:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0;
  wire       [63:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_0;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_1;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_2;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_3;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_4;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_5;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_6;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_7;
  wire       [3:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw;
  wire       [63:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_0;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_1;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_2;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_3;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_4;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_5;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_6;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_7;
  wire       [6:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasVal;
  wire       [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_biasVal;
  wire       [6:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal;
  wire       [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal;
  wire       [6:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal;
  reg        [0:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_0;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_1;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_2;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_3;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_4;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_5;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_6;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_7;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_0;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_1;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_2;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_3;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_4;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_5;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_6;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_7;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_0;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_3;
  reg        [63:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4;
  reg                 _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_5;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_8;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_9;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_10;
  reg        [32:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_11;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_12;
  reg        [31:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_13;
  reg        [63:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14;
  reg        [63:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_15;
  wire                _blocks_blocks_2_pw_Conv_output_0_quantized_isReal;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_0;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_1;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_2;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_3;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_4;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_5;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_6;
  reg        [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_7;
  wire                DepthwiseConvPlugin_logic_outStream_fire_2;
  wire                when_QLinearConvLineCore_l346_17;
  wire                when_QLinearConvLineCore_l346_18;
  wire                when_QLinearConvLineCore_l346_19;
  wire                when_QLinearConvLineCore_l346_20;
  wire                when_QLinearConvLineCore_l346_21;
  wire                when_QLinearConvLineCore_l346_22;
  wire                when_QLinearConvLineCore_l346_23;
  wire                when_QLinearConvLineCore_l346_24;
  wire       [7:0]    _blocks_blocks_2_pw_Conv_output_0_quantized_recvDataSeq_7;
  wire       [63:0]   _blocks_blocks_2_pw_Conv_output_0_quantized_recvData;
  wire                _zz_118;
  wire                _zz_119;
  wire                _zz_120;
  wire                _zz_121;
  wire                when_QLinearConvLineCore_l406_3;
  wire                when_QLinearConvLineCore_l410_3;
  wire                when_QLinearConvLineCore_l413_3;
  wire                when_QLinearConvLineCore_l418_3;
  wire                when_QLinearConvLineCore_l424_3;
  wire                when_QLinearConvLineCore_l438_3;
  wire                when_QLinearConvLineCore_l439_3;
  wire                _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_fire;
  wire                when_QLinearConvLineCore_l448_3;
  wire                when_QLinearConvLineCore_l454_3;
  wire                when_QLinearConvLineCore_l456_3;
  wire                when_QLinearConvLineCore_l466_3;
  wire       [6:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrBaseReg;
  wire                when_QLinearConvLineCore_l479_3;
  wire                when_QLinearConvLineCore_l485_3;
  wire                when_QLinearConvLineCore_l489_3;
  wire       [1:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg;
  wire                when_QLinearConvLineCore_l493_3;
  wire                when_QLinearConvLineCore_l505_3;
  wire                when_QLinearConvLineCore_l515_3;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1;
  wire       [8:0]    _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_1;
  wire                when_QLinearConvLineCore_l532_3;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_0;
  wire                when_QLinearConvLineCore_l535_3;
  wire                when_QLinearConvLineCore_l545_3;
  wire                when_QLinearConvLineCore_l551_3;
  wire       [15:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_9;
  wire       [15:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7;
  wire       [15:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_8;
  wire       [15:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7_1;
  wire                when_QLinearConvLineCore_l563_3;
  wire                when_QLinearConvLineCore_l570_3;
  wire                when_QLinearConvLineCore_l576_3;
  wire       [63:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4;
  wire                when_QLinearConvLineCore_l583_3;
  wire       [31:0]   _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2;
  wire                when_QLinearConvLineCore_l596_3;
  wire                _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_fire;
  wire                when_QLinearConvLineCore_l608_3;
  wire                when_QLinearConvLineCore_l612_3;
  wire                when_QLinearConvLineCore_l616_3;
  wire                DepthwiseConvPlugin_logic_outStream_valid_3;
  reg                 DepthwiseConvPlugin_logic_outStream_ready_3;
  wire       [7:0]    DepthwiseConvPlugin_logic_outStream_payload_value_3;
  reg                 _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_valid;
  wire                _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_ready;
  reg        [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_payload_value;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sReceive;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sLoadBias;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sCompute;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sRequant;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantMul;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait2;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait3;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantShift;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sEmit;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sInit;
  wire       [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_sWaitBias;
  reg        [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg;
  reg        [12:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_recvCntReg;
  reg        [13:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_padWriteAddrReg;
  reg        [8:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_rowElemReg;
  reg        [4:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_outRowReg;
  reg        [2:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_outColReg;
  reg        [6:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_outChReg;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_accumReg;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_prodReg;
  reg        [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_resultReg;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_accumRequantReg;
  reg        [63:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2;
  reg                 _blocks_blocks_3_dw_Conv_output_0_quantized_signAReg;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_absAReg;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_pLH_Reg;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_pHL_Reg;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_pHH_Reg;
  reg        [32:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_pSumReg;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg2;
  reg        [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_pHH_Reg2;
  reg        [63:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg;
  reg        [63:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_part2Reg;
  reg        [13:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_initAddrReg;
  reg        [13:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg;
  reg        [9:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_wAddrReg;
  reg        [3:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg;
  reg        [1:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_rowStepReg;
  wire       [13:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_inAddrComb;
  wire       [9:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_wAddrComb;
  wire       [13:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inValR;
  wire       [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_inValR;
  wire       [9:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_wValR;
  wire       [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_wValR;
  wire       [6:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasVal;
  wire       [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_biasVal;
  wire       [6:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal;
  wire       [31:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal;
  wire       [6:0]    _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal;
  wire       [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal;
  wire                _blocks_blocks_3_dw_Conv_output_0_quantized_doInit;
  wire                QLinearConvLineCorePlugin_logic_outStream_fire_3;
  wire                _blocks_blocks_3_dw_Conv_output_0_quantized_doRecv;
  wire       [13:0]   _blocks_blocks_3_dw_Conv_output_0_quantized_wrAddr;
  wire       [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_wrData;
  reg        [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_inValReg;
  reg        [7:0]    _blocks_blocks_3_dw_Conv_output_0_quantized_wValReg;
  wire                when_DepthwiseConvCore_l238_3;
  wire                when_DepthwiseConvCore_l240_3;
  wire                when_DepthwiseConvCore_l252_3;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_padWriteAddrReg;
  wire                when_DepthwiseConvCore_l264_3;
  wire                when_DepthwiseConvCore_l278_3;
  wire                when_DepthwiseConvCore_l289_3;
  wire                when_DepthwiseConvCore_l303_3;
  wire                when_DepthwiseConvCore_l307_3;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg;
  wire                when_DepthwiseConvCore_l319_3;
  wire                when_DepthwiseConvCore_l325_3;
  wire                when_DepthwiseConvCore_l334_3;
  wire       [31:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_accumReg;
  wire                when_DepthwiseConvCore_l337_3;
  wire                when_DepthwiseConvCore_l346_3;
  wire                when_DepthwiseConvCore_l352_3;
  wire       [15:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pHL_Reg;
  wire       [15:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg;
  wire       [15:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLH_Reg;
  wire       [15:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg_1;
  wire                when_DepthwiseConvCore_l362_3;
  wire                when_DepthwiseConvCore_l368_3;
  wire                when_DepthwiseConvCore_l374_3;
  wire       [63:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2;
  wire                when_DepthwiseConvCore_l381_3;
  wire       [31:0]   _zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg;
  wire                when_DepthwiseConvCore_l398_3;
  wire                _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_fire;
  wire                when_DepthwiseConvCore_l410_3;
  wire                when_DepthwiseConvCore_l414_3;
  wire                _zz__blocks_blocks_3_dw_Conv_output_0_quantized_stateReg;
  wire                QLinearConvLineCorePlugin_logic_outStream_valid_4;
  reg                 QLinearConvLineCorePlugin_logic_outStream_ready_4;
  wire       [7:0]    QLinearConvLineCorePlugin_logic_outStream_payload_value_4;
  wire       [63:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_zpWideBits;
  reg                 _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_valid;
  reg                 _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_ready;
  reg        [511:0]  _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_payload;
  reg        [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wStepReg;
  reg        [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatStepReg;
  reg        [511:0]  _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatBuf;
  reg                 _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatDraining;
  reg                 _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_valid;
  wire                _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_ready;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_payload_value;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sLoadBias;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sWaitBias;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sCompute;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sRequant;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantMul;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait2;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait3;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantShift;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sEmit;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sInit;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_sLoadWeights;
  reg        [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg;
  reg        [0:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg;
  reg        [0:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowsUntilComputeReg;
  reg        [4:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_realRowsRecvReg;
  reg        [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg;
  reg        [5:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxWordReg;
  reg        [0:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_initSlotReg;
  reg        [5:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_initAddrReg;
  reg        [4:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_outRowReg;
  reg        [2:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_outColReg;
  reg        [6:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_outChReg;
  reg        [0:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_khCntReg;
  reg        [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowStepReg;
  reg        [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg;
  reg        [5:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrBaseReg;
  reg        [5:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrReg;
  reg        [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wAddrReg;
  wire       [5:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrComb;
  wire       [3:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wAddrComb;
  wire       [5:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxAddr;
  wire       [5:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0;
  wire       [63:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_0;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_1;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_2;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_3;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_4;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_5;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_6;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_7;
  wire       [3:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw;
  wire       [63:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_0;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_1;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_2;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_3;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_4;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_5;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_6;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_7;
  wire       [6:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasVal;
  wire       [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_biasVal;
  wire       [6:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal;
  wire       [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal;
  wire       [6:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal;
  reg        [0:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_0;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_1;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_2;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_3;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_4;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_5;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_6;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_7;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_0;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_1;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_2;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_3;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_4;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_5;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_6;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_7;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_0;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_3;
  reg        [63:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4;
  reg                 _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_5;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_8;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_9;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_10;
  reg        [32:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_11;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_12;
  reg        [31:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_13;
  reg        [63:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14;
  reg        [63:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_15;
  wire                _blocks_blocks_3_pw_Conv_output_0_quantized_isReal;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_0;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_1;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_2;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_3;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_4;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_5;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_6;
  reg        [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_7;
  wire                DepthwiseConvPlugin_logic_outStream_fire_3;
  wire                when_QLinearConvLineCore_l346_25;
  wire                when_QLinearConvLineCore_l346_26;
  wire                when_QLinearConvLineCore_l346_27;
  wire                when_QLinearConvLineCore_l346_28;
  wire                when_QLinearConvLineCore_l346_29;
  wire                when_QLinearConvLineCore_l346_30;
  wire                when_QLinearConvLineCore_l346_31;
  wire                when_QLinearConvLineCore_l346_32;
  wire       [7:0]    _blocks_blocks_3_pw_Conv_output_0_quantized_recvDataSeq_7;
  wire       [63:0]   _blocks_blocks_3_pw_Conv_output_0_quantized_recvData;
  wire                _zz_135;
  wire                _zz_136;
  wire                _zz_137;
  wire                _zz_138;
  wire                when_QLinearConvLineCore_l406_4;
  wire                when_QLinearConvLineCore_l410_4;
  wire                when_QLinearConvLineCore_l413_4;
  wire                when_QLinearConvLineCore_l418_4;
  wire                when_QLinearConvLineCore_l424_4;
  wire                when_QLinearConvLineCore_l438_4;
  wire                when_QLinearConvLineCore_l439_4;
  wire                _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_fire;
  wire                when_QLinearConvLineCore_l448_4;
  wire                when_QLinearConvLineCore_l454_4;
  wire                when_QLinearConvLineCore_l456_4;
  wire                when_QLinearConvLineCore_l466_4;
  wire       [6:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrBaseReg;
  wire                when_QLinearConvLineCore_l479_4;
  wire                when_QLinearConvLineCore_l485_4;
  wire                when_QLinearConvLineCore_l489_4;
  wire       [1:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg;
  wire                when_QLinearConvLineCore_l493_4;
  wire                when_QLinearConvLineCore_l505_4;
  wire                when_QLinearConvLineCore_l515_4;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1;
  wire       [8:0]    _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_1;
  wire                when_QLinearConvLineCore_l532_4;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_0;
  wire                when_QLinearConvLineCore_l535_4;
  wire                when_QLinearConvLineCore_l545_4;
  wire                when_QLinearConvLineCore_l551_4;
  wire       [15:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_9;
  wire       [15:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7;
  wire       [15:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_8;
  wire       [15:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7_1;
  wire                when_QLinearConvLineCore_l563_4;
  wire                when_QLinearConvLineCore_l570_4;
  wire                when_QLinearConvLineCore_l576_4;
  wire       [63:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4;
  wire                when_QLinearConvLineCore_l583_4;
  wire       [31:0]   _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2;
  wire                when_QLinearConvLineCore_l596_4;
  wire                _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_fire;
  wire                when_QLinearConvLineCore_l608_4;
  wire                when_QLinearConvLineCore_l612_4;
  wire                when_QLinearConvLineCore_l616_4;
  wire                GlobalAveragePoolPlugin_logic_outStream_valid;
  reg                 GlobalAveragePoolPlugin_logic_outStream_ready;
  wire       [7:0]    GlobalAveragePoolPlugin_logic_outStream_payload_value;
  reg                 _gap_GlobalAveragePool_output_0_quantized_activationOut_valid;
  wire                _gap_GlobalAveragePool_output_0_quantized_activationOut_ready;
  wire       [7:0]    _gap_GlobalAveragePool_output_0_quantized_activationOut_payload_value;
  wire       [3:0]    _gap_GlobalAveragePool_output_0_quantized_sReceive;
  wire       [3:0]    _gap_GlobalAveragePool_output_0_quantized_sSettle;
  wire       [3:0]    _gap_GlobalAveragePool_output_0_quantized_sReadAcc;
  wire       [3:0]    _gap_GlobalAveragePool_output_0_quantized_sRequant;
  wire       [3:0]    _gap_GlobalAveragePool_output_0_quantized_sRequantMul;
  wire       [3:0]    _gap_GlobalAveragePool_output_0_quantized_sRequantWait;
  wire       [3:0]    _gap_GlobalAveragePool_output_0_quantized_sRequantWait2;
  wire       [3:0]    _gap_GlobalAveragePool_output_0_quantized_sRequantWait3;
  wire       [3:0]    _gap_GlobalAveragePool_output_0_quantized_sRequantShift;
  wire       [3:0]    _gap_GlobalAveragePool_output_0_quantized_sEmit;
  reg        [3:0]    _gap_GlobalAveragePool_output_0_quantized_stateReg;
  reg        [6:0]    _gap_GlobalAveragePool_output_0_quantized_chReg;
  reg        [2:0]    _gap_GlobalAveragePool_output_0_quantized_colReg;
  reg        [4:0]    _gap_GlobalAveragePool_output_0_quantized_rowReg;
  reg                 _gap_GlobalAveragePool_output_0_quantized_pipelineValidReg;
  reg        [7:0]    _gap_GlobalAveragePool_output_0_quantized_inValReg;
  reg        [6:0]    _gap_GlobalAveragePool_output_0_quantized_chReg_d1;
  reg        [4:0]    _gap_GlobalAveragePool_output_0_quantized_rowReg_d1;
  reg        [2:0]    _gap_GlobalAveragePool_output_0_quantized_colReg_d1;
  reg        [5:0]    _gap_GlobalAveragePool_output_0_quantized_readAddr;
  wire       [31:0]   _gap_GlobalAveragePool_output_0_quantized_readData;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_accumOld;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_accumNew;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_accPrevReg;
  reg        [6:0]    _gap_GlobalAveragePool_output_0_quantized_prevChReg;
  reg                 _gap_GlobalAveragePool_output_0_quantized_prevValidReg;
  wire                when_GlobalAveragePoolCore_l124;
  wire                when_GlobalAveragePoolCore_l131;
  reg        [6:0]    _gap_GlobalAveragePool_output_0_quantized_emitChReg;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_absAReg;
  reg                 _gap_GlobalAveragePool_output_0_quantized_signAReg;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_pLL_Reg;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_pLH_Reg;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_pHL_Reg;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_pHH_Reg;
  reg        [32:0]   _gap_GlobalAveragePool_output_0_quantized_pSumReg;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_pLL_Reg2;
  reg        [31:0]   _gap_GlobalAveragePool_output_0_quantized_pHH_Reg2;
  reg        [63:0]   _gap_GlobalAveragePool_output_0_quantized_part1Reg;
  reg        [63:0]   _gap_GlobalAveragePool_output_0_quantized_part2Reg;
  reg        [63:0]   _gap_GlobalAveragePool_output_0_quantized_reqProdReg2;
  reg        [7:0]    _gap_GlobalAveragePool_output_0_quantized_resultReg;
  wire                QLinearConvLineCorePlugin_logic_outStream_fire_4;
  wire                when_GlobalAveragePoolCore_l204;
  wire                when_GlobalAveragePoolCore_l206;
  wire                when_GlobalAveragePoolCore_l208;
  wire       [31:0]   _zz__gap_GlobalAveragePool_output_0_quantized_absAReg;
  wire       [31:0]   _zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg;
  wire       [15:0]   _zz__gap_GlobalAveragePool_output_0_quantized_pHL_Reg;
  wire       [15:0]   _zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg_1;
  wire       [15:0]   _zz__gap_GlobalAveragePool_output_0_quantized_pLH_Reg;
  wire       [15:0]   _zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg_2;
  wire       [63:0]   _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2;
  wire       [31:0]   _zz__gap_GlobalAveragePool_output_0_quantized_resultReg;
  wire                _gap_GlobalAveragePool_output_0_quantized_activationOut_fire;
  wire                when_GlobalAveragePoolCore_l291;
  wire                QLinearLinearPlugin_logic_outStream_valid;
  wire                QLinearLinearPlugin_logic_outStream_ready;
  wire       [7:0]    QLinearLinearPlugin_logic_outStream_payload_value;
  reg                 output_quantized_weightIn_valid;
  reg                 output_quantized_weightIn_ready;
  reg        [511:0]  output_quantized_weightIn_payload;
  reg        [6:0]    output_quantized_wStepReg;
  reg        [5:0]    output_quantized_wBeatStepReg;
  reg        [511:0]  output_quantized_wBeatBuf;
  reg                 output_quantized_wBeatDraining;
  reg                 output_quantized_activationOut_valid;
  wire                output_quantized_activationOut_ready;
  reg        [7:0]    output_quantized_activationOut_payload_value;
  wire       [3:0]    output_quantized_sReceive;
  wire       [3:0]    output_quantized_sLoadBias;
  wire       [3:0]    output_quantized_sCompute;
  wire       [3:0]    output_quantized_sRequant;
  wire       [3:0]    output_quantized_sRequantMul;
  wire       [3:0]    output_quantized_sRequantWait;
  wire       [3:0]    output_quantized_sRequantWait2;
  wire       [3:0]    output_quantized_sRequantWait3;
  wire       [3:0]    output_quantized_sRequantShift;
  wire       [3:0]    output_quantized_sEmit;
  wire       [3:0]    output_quantized_sWaitBias;
  wire       [3:0]    output_quantized_sLoadWeights;
  reg        [3:0]    output_quantized_stateReg;
  reg        [6:0]    output_quantized_recvCntReg;
  reg        [3:0]    output_quantized_outNeurReg;
  reg        [6:0]    output_quantized_compCycleReg;
  reg        [31:0]   output_quantized_accumReg;
  reg        [31:0]   output_quantized_prodReg;
  reg        [7:0]    output_quantized_resultReg;
  wire       [63:0]   output_quantized_reqProdReg1;
  reg        [63:0]   output_quantized_reqProdReg2;
  reg        [31:0]   output_quantized_accumRequantReg;
  reg                 output_quantized_signAReg;
  reg        [31:0]   output_quantized_absAReg;
  reg        [31:0]   output_quantized_pLL_Reg;
  reg        [31:0]   output_quantized_pLH_Reg;
  reg        [31:0]   output_quantized_pHL_Reg;
  reg        [31:0]   output_quantized_pHH_Reg;
  reg        [32:0]   output_quantized_pSumReg;
  reg        [31:0]   output_quantized_pLL_Reg2;
  reg        [31:0]   output_quantized_pHH_Reg2;
  reg        [63:0]   output_quantized_part1Reg;
  reg        [63:0]   output_quantized_part2Reg;
  reg        [7:0]    output_quantized_inValReg;
  reg        [7:0]    output_quantized_wValReg;
  reg        [5:0]    output_quantized_inAddrComb;
  reg        [5:0]    output_quantized_wAddrComb;
  wire       [7:0]    output_quantized_inValR;
  wire       [7:0]    output_quantized_wValR;
  wire       [3:0]    _zz_output_quantized_biasVal;
  wire       [31:0]   output_quantized_biasVal;
  wire                when_QLinearLinearCore_l174;
  wire                GlobalAveragePoolPlugin_logic_outStream_fire;
  wire                when_QLinearLinearCore_l179;
  wire                when_QLinearLinearCore_l191;
  wire                when_QLinearLinearCore_l192;
  wire                output_quantized_weightIn_fire;
  wire                when_QLinearLinearCore_l201;
  wire                when_QLinearLinearCore_l207;
  wire                when_QLinearLinearCore_l209;
  wire                when_QLinearLinearCore_l219;
  wire                when_QLinearLinearCore_l225;
  wire                when_QLinearLinearCore_l231;
  wire                when_QLinearLinearCore_l235;
  wire                when_QLinearLinearCore_l242;
  wire                when_QLinearLinearCore_l248;
  wire                when_QLinearLinearCore_l255;
  wire       [31:0]   _zz_output_quantized_accumReg;
  wire                when_QLinearLinearCore_l259;
  wire                when_QLinearLinearCore_l268;
  wire                when_QLinearLinearCore_l275;
  wire       [31:0]   _zz_output_quantized_pLL_Reg;
  wire       [15:0]   _zz_output_quantized_pHL_Reg;
  wire       [15:0]   _zz_output_quantized_pLL_Reg_1;
  wire       [15:0]   _zz_output_quantized_pLH_Reg;
  wire       [15:0]   _zz_output_quantized_pLL_Reg_2;
  wire                when_QLinearLinearCore_l291;
  wire                when_QLinearLinearCore_l299;
  wire                when_QLinearLinearCore_l306;
  wire       [63:0]   _zz_output_quantized_reqProdReg2;
  wire                when_QLinearLinearCore_l314;
  wire       [31:0]   _zz_output_quantized_resultReg;
  wire                when_QLinearLinearCore_l325;
  wire                output_quantized_activationOut_fire;
  wire                _zz_output_quantized_stateReg;
  reg        [2:0]    _zz_when_WeightDmaCore_l137;
  reg        [2:0]    _zz_weightDmaAxi_ar_payload_addr;
  reg        [6:0]    _zz_weightDmaAxi_ar_payload_addr_1;
  reg        [0:0]    _zz_when_WeightDmaCore_l178;
  reg        [511:0]  _zz__stem_conv_Conv_output_0_quantized_weightIn_payload;
  wire       [0:0]    _zz_weightDmaAxi_ar_payload_len;
  wire                when_WeightDmaCore_l137;
  wire                weightDmaAxi_ar_fire;
  wire                when_WeightDmaCore_l155;
  wire                weightDmaAxi_r_fire;
  wire                when_WeightDmaCore_l164;
  wire                when_WeightDmaCore_l166;
  wire                when_WeightDmaCore_l166_1;
  wire                when_WeightDmaCore_l166_2;
  wire                when_WeightDmaCore_l166_3;
  wire                when_WeightDmaCore_l166_4;
  wire                when_WeightDmaCore_l166_5;
  wire                when_WeightDmaCore_l176;
  wire                when_WeightDmaCore_l178;
  wire                when_WeightDmaCore_l187;
  wire                _zz_weightDmaAxi_ar_payload_addr_2;
  reg [7:0] _stem_conv_Conv_output_0_quantized_inputBuf_0 [0:11];
  reg [7:0] _stem_conv_Conv_output_0_quantized_inputBuf_1 [0:11];
  reg [7:0] _stem_conv_Conv_output_0_quantized_inputBuf_2 [0:11];
  reg [7:0] _stem_conv_Conv_output_0_quantized_inputBuf_3 [0:11];
  reg [7:0] _stem_conv_Conv_output_0_quantized_inputBuf_4 [0:11];
  reg [7:0] _stem_conv_Conv_output_0_quantized_inputBuf_5 [0:11];
  reg [7:0] _stem_conv_Conv_output_0_quantized_inputBuf_6 [0:11];
  reg [7:0] _stem_conv_Conv_output_0_quantized_inputBuf_7 [0:11];
  reg [7:0] _stem_conv_Conv_output_0_quantized_inputBuf_8 [0:11];
  reg [7:0] _stem_conv_Conv_output_0_quantized_inputBuf_9 [0:11];
  reg [7:0] _stem_conv_Conv_output_0_quantized_weightBuf [0:39];
  reg [31:0] _stem_conv_Conv_output_0_quantized_biasRom [0:63];
  reg [31:0] _stem_conv_Conv_output_0_quantized_reqMultRom [0:63];
  reg [7:0] _stem_conv_Conv_output_0_quantized_reqShiftRom [0:63];
  reg [7:0] _blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf [0:11647];
  reg [7:0] _blocks_blocks_0_dw_Conv_output_0_quantized_weightRom [0:575];
  reg [31:0] _blocks_blocks_0_dw_Conv_output_0_quantized_biasRom [0:63];
  reg [31:0] _blocks_blocks_0_dw_Conv_output_0_quantized_reqMultRom [0:63];
  reg [7:0] _blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftRom [0:63];
  reg [63:0] _blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0 [0:39];
  reg [63:0] _blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf [0:7];
  reg [31:0] _blocks_blocks_0_pw_Conv_output_0_quantized_biasRom [0:63];
  reg [31:0] _blocks_blocks_0_pw_Conv_output_0_quantized_reqMultRom [0:63];
  reg [7:0] _blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftRom [0:63];
  reg [7:0] _blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf [0:11647];
  reg [7:0] _blocks_blocks_1_dw_Conv_output_0_quantized_weightRom [0:575];
  reg [31:0] _blocks_blocks_1_dw_Conv_output_0_quantized_biasRom [0:63];
  reg [31:0] _blocks_blocks_1_dw_Conv_output_0_quantized_reqMultRom [0:63];
  reg [7:0] _blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftRom [0:63];
  reg [63:0] _blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0 [0:39];
  reg [63:0] _blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf [0:7];
  reg [31:0] _blocks_blocks_1_pw_Conv_output_0_quantized_biasRom [0:63];
  reg [31:0] _blocks_blocks_1_pw_Conv_output_0_quantized_reqMultRom [0:63];
  reg [7:0] _blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftRom [0:63];
  reg [7:0] _blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf [0:11647];
  reg [7:0] _blocks_blocks_2_dw_Conv_output_0_quantized_weightRom [0:575];
  reg [31:0] _blocks_blocks_2_dw_Conv_output_0_quantized_biasRom [0:63];
  reg [31:0] _blocks_blocks_2_dw_Conv_output_0_quantized_reqMultRom [0:63];
  reg [7:0] _blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftRom [0:63];
  reg [63:0] _blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0 [0:39];
  reg [63:0] _blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf [0:7];
  reg [31:0] _blocks_blocks_2_pw_Conv_output_0_quantized_biasRom [0:63];
  reg [31:0] _blocks_blocks_2_pw_Conv_output_0_quantized_reqMultRom [0:63];
  reg [7:0] _blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftRom [0:63];
  reg [7:0] _blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf [0:11647];
  reg [7:0] _blocks_blocks_3_dw_Conv_output_0_quantized_weightRom [0:575];
  reg [31:0] _blocks_blocks_3_dw_Conv_output_0_quantized_biasRom [0:63];
  reg [31:0] _blocks_blocks_3_dw_Conv_output_0_quantized_reqMultRom [0:63];
  reg [7:0] _blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftRom [0:63];
  reg [63:0] _blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0 [0:39];
  reg [63:0] _blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf [0:7];
  reg [31:0] _blocks_blocks_3_pw_Conv_output_0_quantized_biasRom [0:63];
  reg [31:0] _blocks_blocks_3_pw_Conv_output_0_quantized_reqMultRom [0:63];
  reg [7:0] _blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftRom [0:63];
  reg [31:0] _gap_GlobalAveragePool_output_0_quantized_accumRam [0:63];
  reg [7:0] output_quantized_inputBuf [0:63];
  reg [7:0] output_quantized_weightBuf [0:63];
  reg [31:0] output_quantized_biasRom [0:11];

  assign _zz__stem_conv_Conv_output_0_quantized_biasVal_1 = _zz__stem_conv_Conv_output_0_quantized_biasVal[5:0];
  assign _zz__stem_conv_Conv_output_0_quantized_reqMultVal_1 = _zz__stem_conv_Conv_output_0_quantized_reqMultVal[5:0];
  assign _zz__stem_conv_Conv_output_0_quantized_reqShiftVal_1 = _zz__stem_conv_Conv_output_0_quantized_reqShiftVal[5:0];
  assign _zz__stem_conv_Conv_output_0_quantized_rxBankReg = (_stem_conv_Conv_output_0_quantized_rxBankReg + 1'b1);
  assign _zz__stem_conv_Conv_output_0_quantized_rowWrPtrReg = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg + 4'b0001);
  assign _zz__stem_conv_Conv_output_0_quantized_wBeatBuf = (_stem_conv_Conv_output_0_quantized_wBeatBuf >>> 4'd8);
  assign _zz__zz__stem_conv_Conv_output_0_quantized_curSlotReg = {1'd0, _stem_conv_Conv_output_0_quantized_rowWrPtrReg};
  assign _zz__zz__stem_conv_Conv_output_0_quantized_curSlotReg_1 = {1'd0, _stem_conv_Conv_output_0_quantized_khCntReg};
  assign _zz__stem_conv_Conv_output_0_quantized_curSlotReg_2 = (_zz__stem_conv_Conv_output_0_quantized_curSlotReg - 5'h0a);
  assign _zz__stem_conv_Conv_output_0_quantized_curSlotReg_1 = _zz__stem_conv_Conv_output_0_quantized_curSlotReg_2[3:0];
  assign _zz__stem_conv_Conv_output_0_quantized_curSlotReg_3 = _zz__stem_conv_Conv_output_0_quantized_curSlotReg[3:0];
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_1 = ($signed(_zz__stem_conv_Conv_output_0_quantized_rqReg_1_1) * $signed(_zz__stem_conv_Conv_output_0_quantized_rqReg_1_3));
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_1_1 = ($signed(_zz__stem_conv_Conv_output_0_quantized_rqReg_1_2) - $signed(9'h0));
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_1_2 = {{1{_stem_conv_Conv_output_0_quantized_inValReg_0[7]}}, _stem_conv_Conv_output_0_quantized_inValReg_0};
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_1_3 = ($signed(_zz__stem_conv_Conv_output_0_quantized_rqReg_1_4) - $signed(9'h0));
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_1_4 = {{1{_stem_conv_Conv_output_0_quantized_wValReg_0[7]}}, _stem_conv_Conv_output_0_quantized_wValReg_0};
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_6 = (($signed(_stem_conv_Conv_output_0_quantized_rqReg_3) < $signed(32'h0)) ? _zz__stem_conv_Conv_output_0_quantized_rqReg_6_1 : _stem_conv_Conv_output_0_quantized_rqReg_3);
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_6_1 = (- _stem_conv_Conv_output_0_quantized_rqReg_3);
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_11 = {1'd0, _stem_conv_Conv_output_0_quantized_rqReg_8};
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_11_1 = {1'd0, _stem_conv_Conv_output_0_quantized_rqReg_9};
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_14 = {32'd0, _stem_conv_Conv_output_0_quantized_rqReg_12};
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_14_2 = ({16'd0,_zz__stem_conv_Conv_output_0_quantized_rqReg_14_3} <<< 5'd16);
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_14_1 = _zz__stem_conv_Conv_output_0_quantized_rqReg_14_2[63:0];
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_14_3 = {31'd0, _stem_conv_Conv_output_0_quantized_rqReg_11};
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_15 = ({32'd0,_zz__stem_conv_Conv_output_0_quantized_rqReg_15_1} <<< 6'd32);
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_15_1 = {32'd0, _stem_conv_Conv_output_0_quantized_rqReg_13};
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_4_1 = (- _zz__stem_conv_Conv_output_0_quantized_rqReg_4_2);
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_4_2 = _zz__stem_conv_Conv_output_0_quantized_rqReg_4;
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_4_3 = _zz__stem_conv_Conv_output_0_quantized_rqReg_4;
  assign _zz__zz__stem_conv_Conv_output_0_quantized_rqReg_2_1 = ($signed(_stem_conv_Conv_output_0_quantized_rqReg_4) >>> _stem_conv_Conv_output_0_quantized_reqShiftVal);
  assign _zz__zz__stem_conv_Conv_output_0_quantized_rqReg_2 = _zz__zz__stem_conv_Conv_output_0_quantized_rqReg_2_1[31:0];
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_2_1 = (($signed(_zz__stem_conv_Conv_output_0_quantized_rqReg_2) < $signed(32'hffffff80)) ? 8'h80 : _zz__stem_conv_Conv_output_0_quantized_rqReg_2_2);
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_2_2 = _zz__stem_conv_Conv_output_0_quantized_rqReg_2[7:0];
  assign _zz__stem_conv_Conv_output_0_quantized_outChReg = (_stem_conv_Conv_output_0_quantized_outChReg + 7'h01);
  assign _zz__stem_conv_Conv_output_0_quantized_outColReg = (_stem_conv_Conv_output_0_quantized_outColReg + 3'b001);
  assign _zz__stem_conv_Conv_output_0_quantized_outRowReg = (_stem_conv_Conv_output_0_quantized_outRowReg + 5'h01);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasVal_1 = _zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasVal[5:0];
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal_1 = _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal[5:0];
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal_1 = _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal[5:0];
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_rowElemReg = (_blocks_blocks_0_dw_Conv_output_0_quantized_rowElemReg + 9'h001);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_1 = (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_2 + _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_3);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_2 = (_blocks_blocks_0_dw_Conv_output_0_quantized_outRowReg * 9'h1c0);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_4 = (_blocks_blocks_0_dw_Conv_output_0_quantized_outColReg * 7'h40);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_3 = {4'd0, _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_4};
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_5 = {7'd0, _blocks_blocks_0_dw_Conv_output_0_quantized_outChReg};
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_wAddrReg = (_blocks_blocks_0_dw_Conv_output_0_quantized_outChReg * 4'b1001);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_rowStepReg = (_blocks_blocks_0_dw_Conv_output_0_quantized_rowStepReg + 2'b01);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg = ($signed(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_1) * $signed(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_3));
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_1 = ($signed(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_2) - $signed(9'h180));
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_2 = {{1{_blocks_blocks_0_dw_Conv_output_0_quantized_inValReg[7]}}, _blocks_blocks_0_dw_Conv_output_0_quantized_inValReg};
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_3 = ($signed(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_4) - $signed(9'h0));
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg_4 = {{1{_blocks_blocks_0_dw_Conv_output_0_quantized_wValReg[7]}}, _blocks_blocks_0_dw_Conv_output_0_quantized_wValReg};
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_absAReg = (($signed(_blocks_blocks_0_dw_Conv_output_0_quantized_accumRequantReg) < $signed(32'h0)) ? _zz__blocks_blocks_0_dw_Conv_output_0_quantized_absAReg_1 : _blocks_blocks_0_dw_Conv_output_0_quantized_accumRequantReg);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_absAReg_1 = (- _blocks_blocks_0_dw_Conv_output_0_quantized_accumRequantReg);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pSumReg = {1'd0, _blocks_blocks_0_dw_Conv_output_0_quantized_pLH_Reg};
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pSumReg_1 = {1'd0, _blocks_blocks_0_dw_Conv_output_0_quantized_pHL_Reg};
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg = {32'd0, _blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg2};
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg_2 = ({16'd0,_zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg_3} <<< 5'd16);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg_1 = _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg_2[63:0];
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg_3 = {31'd0, _blocks_blocks_0_dw_Conv_output_0_quantized_pSumReg};
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part2Reg = ({32'd0,_zz__blocks_blocks_0_dw_Conv_output_0_quantized_part2Reg_1} <<< 6'd32);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part2Reg_1 = {32'd0, _blocks_blocks_0_dw_Conv_output_0_quantized_pHH_Reg2};
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2_1 = (- _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2_2);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2_2 = _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2_3 = _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2;
  assign _zz__zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg_1 = ($signed(_blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2) >>> _blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal);
  assign _zz__zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg = _zz__zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg_1[31:0];
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg_1 = (($signed(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg_2);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg_2 = _zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg[7:0];
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_outChReg = (_blocks_blocks_0_dw_Conv_output_0_quantized_outChReg + 7'h01);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_outColReg = (_blocks_blocks_0_dw_Conv_output_0_quantized_outColReg + 3'b001);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_outRowReg = (_blocks_blocks_0_dw_Conv_output_0_quantized_outRowReg + 5'h01);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw_1 = _zz__blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw[2:0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasVal_1 = _zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasVal[5:0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal_1 = _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal[5:0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal_1 = _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal[5:0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg = (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg + 4'b0001);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg = (_blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg + 1'b1);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_wBeatBuf = (_blocks_blocks_0_pw_Conv_output_0_quantized_wBeatBuf >>> 7'd64);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_port_2 = _blocks_blocks_0_pw_Conv_output_0_quantized_wStepReg[2:0];
  assign _zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg = {1'd0, _blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg};
  assign _zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_1 = {1'd0, _blocks_blocks_0_pw_Conv_output_0_quantized_khCntReg};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_2 = (_zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg - 2'b01);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_1 = _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_2[0:0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_3 = _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg[0:0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_2 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_3) + $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_16));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_3 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_4) + $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_10));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_5 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_6) * $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_8));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_4 = {{14{_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_5[17]}}, _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_5};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_6 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_7) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_7 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_0[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_0};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_8 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_9) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_9 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_0[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_0};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_11 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_12) * $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_14));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_10 = {{14{_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_11[17]}}, _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_11};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_12 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_13) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_13 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_1[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_1};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_14 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_15) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_15 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_1[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_1};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_16 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_17) + $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_23));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_18 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_19) * $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_21));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_17 = {{14{_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_18[17]}}, _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_18};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_19 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_20) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_20 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_2[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_2};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_21 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_22) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_22 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_2[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_2};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_24 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_25) * $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_27));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_23 = {{14{_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_24[17]}}, _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_24};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_25 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_26) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_26 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_3[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_3};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_27 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_28) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_28 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_3[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_3};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_29 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_30) + $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_43));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_30 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_31) + $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_37));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_32 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_33) * $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_35));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_31 = {{14{_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_32[17]}}, _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_32};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_33 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_34) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_34 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_4[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_4};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_35 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_36) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_36 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_4[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_4};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_38 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_39) * $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_41));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_37 = {{14{_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_38[17]}}, _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_38};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_39 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_40) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_40 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_5[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_5};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_41 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_42) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_42 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_5[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_5};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_43 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_44) + $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_50));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_45 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_46) * $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_48));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_44 = {{14{_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_45[17]}}, _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_45};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_46 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_47) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_47 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_6[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_6};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_48 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_49) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_49 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_6[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_6};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_51 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_52) * $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_54));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_50 = {{14{_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_51[17]}}, _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_51};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_52 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_53) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_53 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_7[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_7};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_54 = ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_55) - $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_55 = {{1{_blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_7[7]}}, _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_7};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6 = (($signed(_blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_3) < $signed(32'h0)) ? _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6_1 : _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_3);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6_1 = (- _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_3);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_11 = {1'd0, _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_8};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_11_1 = {1'd0, _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_9};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14 = {32'd0, _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_12};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14_2 = ({16'd0,_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14_3} <<< 5'd16);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14_1 = _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14_2[63:0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14_3 = {31'd0, _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_11};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_15 = ({32'd0,_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_15_1} <<< 6'd32);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_15_1 = {32'd0, _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_13};
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4_1 = (- _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4_2);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4_2 = _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4;
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4_3 = _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4;
  assign _zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2_1 = ($signed(_blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4) >>> _blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal);
  assign _zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2 = _zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2_1[31:0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2_1 = (($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2) < $signed(32'hffffff80)) ? 8'h80 : _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2_2);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2_2 = _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2[7:0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_outChReg = (_blocks_blocks_0_pw_Conv_output_0_quantized_outChReg + 7'h01);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_outColReg = (_blocks_blocks_0_pw_Conv_output_0_quantized_outColReg + 3'b001);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_outRowReg = (_blocks_blocks_0_pw_Conv_output_0_quantized_outRowReg + 5'h01);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasVal_1 = _zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasVal[5:0];
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal_1 = _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal[5:0];
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal_1 = _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal[5:0];
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_rowElemReg = (_blocks_blocks_1_dw_Conv_output_0_quantized_rowElemReg + 9'h001);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_1 = (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_2 + _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_3);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_2 = (_blocks_blocks_1_dw_Conv_output_0_quantized_outRowReg * 9'h1c0);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_4 = (_blocks_blocks_1_dw_Conv_output_0_quantized_outColReg * 7'h40);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_3 = {4'd0, _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_4};
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_5 = {7'd0, _blocks_blocks_1_dw_Conv_output_0_quantized_outChReg};
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_wAddrReg = (_blocks_blocks_1_dw_Conv_output_0_quantized_outChReg * 4'b1001);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_rowStepReg = (_blocks_blocks_1_dw_Conv_output_0_quantized_rowStepReg + 2'b01);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg = ($signed(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_1) * $signed(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_3));
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_1 = ($signed(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_2) - $signed(9'h180));
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_2 = {{1{_blocks_blocks_1_dw_Conv_output_0_quantized_inValReg[7]}}, _blocks_blocks_1_dw_Conv_output_0_quantized_inValReg};
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_3 = ($signed(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_4) - $signed(9'h0));
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg_4 = {{1{_blocks_blocks_1_dw_Conv_output_0_quantized_wValReg[7]}}, _blocks_blocks_1_dw_Conv_output_0_quantized_wValReg};
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_absAReg = (($signed(_blocks_blocks_1_dw_Conv_output_0_quantized_accumRequantReg) < $signed(32'h0)) ? _zz__blocks_blocks_1_dw_Conv_output_0_quantized_absAReg_1 : _blocks_blocks_1_dw_Conv_output_0_quantized_accumRequantReg);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_absAReg_1 = (- _blocks_blocks_1_dw_Conv_output_0_quantized_accumRequantReg);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pSumReg = {1'd0, _blocks_blocks_1_dw_Conv_output_0_quantized_pLH_Reg};
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pSumReg_1 = {1'd0, _blocks_blocks_1_dw_Conv_output_0_quantized_pHL_Reg};
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg = {32'd0, _blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg2};
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg_2 = ({16'd0,_zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg_3} <<< 5'd16);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg_1 = _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg_2[63:0];
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg_3 = {31'd0, _blocks_blocks_1_dw_Conv_output_0_quantized_pSumReg};
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part2Reg = ({32'd0,_zz__blocks_blocks_1_dw_Conv_output_0_quantized_part2Reg_1} <<< 6'd32);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part2Reg_1 = {32'd0, _blocks_blocks_1_dw_Conv_output_0_quantized_pHH_Reg2};
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2_1 = (- _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2_2);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2_2 = _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2_3 = _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2;
  assign _zz__zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg_1 = ($signed(_blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2) >>> _blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal);
  assign _zz__zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg = _zz__zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg_1[31:0];
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg_1 = (($signed(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg_2);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg_2 = _zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg[7:0];
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_outChReg = (_blocks_blocks_1_dw_Conv_output_0_quantized_outChReg + 7'h01);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_outColReg = (_blocks_blocks_1_dw_Conv_output_0_quantized_outColReg + 3'b001);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_outRowReg = (_blocks_blocks_1_dw_Conv_output_0_quantized_outRowReg + 5'h01);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw_1 = _zz__blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw[2:0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasVal_1 = _zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasVal[5:0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal_1 = _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal[5:0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal_1 = _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal[5:0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg = (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg + 4'b0001);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg = (_blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg + 1'b1);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_wBeatBuf = (_blocks_blocks_1_pw_Conv_output_0_quantized_wBeatBuf >>> 7'd64);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_port_2 = _blocks_blocks_1_pw_Conv_output_0_quantized_wStepReg[2:0];
  assign _zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg = {1'd0, _blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg};
  assign _zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_1 = {1'd0, _blocks_blocks_1_pw_Conv_output_0_quantized_khCntReg};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_2 = (_zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg - 2'b01);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_1 = _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_2[0:0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_3 = _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg[0:0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_2 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_3) + $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_16));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_3 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_4) + $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_10));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_5 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_6) * $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_8));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_4 = {{14{_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_5[17]}}, _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_5};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_6 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_7) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_7 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_0[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_0};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_8 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_9) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_9 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_0[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_0};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_11 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_12) * $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_14));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_10 = {{14{_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_11[17]}}, _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_11};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_12 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_13) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_13 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_1[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_1};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_14 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_15) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_15 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_1[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_1};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_16 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_17) + $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_23));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_18 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_19) * $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_21));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_17 = {{14{_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_18[17]}}, _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_18};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_19 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_20) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_20 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_2[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_2};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_21 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_22) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_22 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_2[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_2};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_24 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_25) * $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_27));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_23 = {{14{_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_24[17]}}, _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_24};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_25 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_26) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_26 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_3[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_3};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_27 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_28) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_28 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_3[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_3};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_29 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_30) + $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_43));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_30 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_31) + $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_37));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_32 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_33) * $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_35));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_31 = {{14{_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_32[17]}}, _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_32};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_33 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_34) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_34 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_4[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_4};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_35 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_36) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_36 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_4[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_4};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_38 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_39) * $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_41));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_37 = {{14{_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_38[17]}}, _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_38};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_39 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_40) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_40 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_5[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_5};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_41 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_42) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_42 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_5[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_5};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_43 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_44) + $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_50));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_45 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_46) * $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_48));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_44 = {{14{_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_45[17]}}, _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_45};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_46 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_47) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_47 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_6[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_6};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_48 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_49) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_49 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_6[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_6};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_51 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_52) * $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_54));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_50 = {{14{_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_51[17]}}, _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_51};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_52 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_53) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_53 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_7[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_7};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_54 = ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_55) - $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_55 = {{1{_blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_7[7]}}, _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_7};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6 = (($signed(_blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_3) < $signed(32'h0)) ? _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6_1 : _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_3);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6_1 = (- _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_3);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_11 = {1'd0, _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_8};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_11_1 = {1'd0, _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_9};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14 = {32'd0, _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_12};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14_2 = ({16'd0,_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14_3} <<< 5'd16);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14_1 = _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14_2[63:0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14_3 = {31'd0, _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_11};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_15 = ({32'd0,_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_15_1} <<< 6'd32);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_15_1 = {32'd0, _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_13};
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4_1 = (- _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4_2);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4_2 = _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4;
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4_3 = _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4;
  assign _zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2_1 = ($signed(_blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4) >>> _blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal);
  assign _zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2 = _zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2_1[31:0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2_1 = (($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2) < $signed(32'hffffff80)) ? 8'h80 : _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2_2);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2_2 = _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2[7:0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_outChReg = (_blocks_blocks_1_pw_Conv_output_0_quantized_outChReg + 7'h01);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_outColReg = (_blocks_blocks_1_pw_Conv_output_0_quantized_outColReg + 3'b001);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_outRowReg = (_blocks_blocks_1_pw_Conv_output_0_quantized_outRowReg + 5'h01);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasVal_1 = _zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasVal[5:0];
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal_1 = _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal[5:0];
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal_1 = _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal[5:0];
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_rowElemReg = (_blocks_blocks_2_dw_Conv_output_0_quantized_rowElemReg + 9'h001);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_1 = (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_2 + _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_3);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_outRowReg * 9'h1c0);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_4 = (_blocks_blocks_2_dw_Conv_output_0_quantized_outColReg * 7'h40);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_3 = {4'd0, _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_4};
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_5 = {7'd0, _blocks_blocks_2_dw_Conv_output_0_quantized_outChReg};
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_wAddrReg = (_blocks_blocks_2_dw_Conv_output_0_quantized_outChReg * 4'b1001);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_rowStepReg = (_blocks_blocks_2_dw_Conv_output_0_quantized_rowStepReg + 2'b01);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg = ($signed(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_1) * $signed(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_3));
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_1 = ($signed(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_2) - $signed(9'h180));
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_2 = {{1{_blocks_blocks_2_dw_Conv_output_0_quantized_inValReg[7]}}, _blocks_blocks_2_dw_Conv_output_0_quantized_inValReg};
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_3 = ($signed(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_4) - $signed(9'h0));
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg_4 = {{1{_blocks_blocks_2_dw_Conv_output_0_quantized_wValReg[7]}}, _blocks_blocks_2_dw_Conv_output_0_quantized_wValReg};
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_absAReg = (($signed(_blocks_blocks_2_dw_Conv_output_0_quantized_accumRequantReg) < $signed(32'h0)) ? _zz__blocks_blocks_2_dw_Conv_output_0_quantized_absAReg_1 : _blocks_blocks_2_dw_Conv_output_0_quantized_accumRequantReg);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_absAReg_1 = (- _blocks_blocks_2_dw_Conv_output_0_quantized_accumRequantReg);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pSumReg = {1'd0, _blocks_blocks_2_dw_Conv_output_0_quantized_pLH_Reg};
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pSumReg_1 = {1'd0, _blocks_blocks_2_dw_Conv_output_0_quantized_pHL_Reg};
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg = {32'd0, _blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg2};
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg_2 = ({16'd0,_zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg_3} <<< 5'd16);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg_1 = _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg_2[63:0];
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg_3 = {31'd0, _blocks_blocks_2_dw_Conv_output_0_quantized_pSumReg};
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part2Reg = ({32'd0,_zz__blocks_blocks_2_dw_Conv_output_0_quantized_part2Reg_1} <<< 6'd32);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part2Reg_1 = {32'd0, _blocks_blocks_2_dw_Conv_output_0_quantized_pHH_Reg2};
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2_1 = (- _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2_2);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2_2 = _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2_3 = _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2;
  assign _zz__zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg_1 = ($signed(_blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2) >>> _blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal);
  assign _zz__zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg = _zz__zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg_1[31:0];
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg_1 = (($signed(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg_2);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg_2 = _zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg[7:0];
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_outChReg = (_blocks_blocks_2_dw_Conv_output_0_quantized_outChReg + 7'h01);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_outColReg = (_blocks_blocks_2_dw_Conv_output_0_quantized_outColReg + 3'b001);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_outRowReg = (_blocks_blocks_2_dw_Conv_output_0_quantized_outRowReg + 5'h01);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw_1 = _zz__blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw[2:0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasVal_1 = _zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasVal[5:0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal_1 = _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal[5:0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal_1 = _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal[5:0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg = (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg + 4'b0001);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg = (_blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg + 1'b1);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_wBeatBuf = (_blocks_blocks_2_pw_Conv_output_0_quantized_wBeatBuf >>> 7'd64);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_port_2 = _blocks_blocks_2_pw_Conv_output_0_quantized_wStepReg[2:0];
  assign _zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg = {1'd0, _blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg};
  assign _zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_1 = {1'd0, _blocks_blocks_2_pw_Conv_output_0_quantized_khCntReg};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_2 = (_zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg - 2'b01);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_1 = _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_2[0:0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_3 = _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg[0:0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_2 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_3) + $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_16));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_3 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_4) + $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_10));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_5 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_6) * $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_8));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_4 = {{14{_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_5[17]}}, _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_5};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_6 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_7) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_7 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_0[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_0};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_8 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_9) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_9 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_0[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_0};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_11 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_12) * $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_14));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_10 = {{14{_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_11[17]}}, _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_11};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_12 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_13) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_13 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_1[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_1};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_14 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_15) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_15 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_1[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_1};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_16 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_17) + $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_23));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_18 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_19) * $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_21));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_17 = {{14{_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_18[17]}}, _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_18};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_19 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_20) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_20 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_2[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_2};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_21 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_22) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_22 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_2[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_2};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_24 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_25) * $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_27));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_23 = {{14{_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_24[17]}}, _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_24};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_25 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_26) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_26 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_3[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_3};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_27 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_28) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_28 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_3[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_3};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_29 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_30) + $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_43));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_30 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_31) + $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_37));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_32 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_33) * $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_35));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_31 = {{14{_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_32[17]}}, _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_32};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_33 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_34) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_34 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_4[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_4};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_35 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_36) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_36 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_4[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_4};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_38 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_39) * $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_41));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_37 = {{14{_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_38[17]}}, _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_38};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_39 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_40) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_40 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_5[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_5};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_41 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_42) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_42 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_5[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_5};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_43 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_44) + $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_50));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_45 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_46) * $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_48));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_44 = {{14{_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_45[17]}}, _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_45};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_46 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_47) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_47 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_6[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_6};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_48 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_49) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_49 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_6[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_6};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_51 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_52) * $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_54));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_50 = {{14{_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_51[17]}}, _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_51};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_52 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_53) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_53 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_7[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_7};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_54 = ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_55) - $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_55 = {{1{_blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_7[7]}}, _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_7};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6 = (($signed(_blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_3) < $signed(32'h0)) ? _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6_1 : _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_3);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6_1 = (- _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_3);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_11 = {1'd0, _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_8};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_11_1 = {1'd0, _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_9};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14 = {32'd0, _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_12};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14_2 = ({16'd0,_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14_3} <<< 5'd16);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14_1 = _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14_2[63:0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14_3 = {31'd0, _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_11};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_15 = ({32'd0,_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_15_1} <<< 6'd32);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_15_1 = {32'd0, _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_13};
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4_1 = (- _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4_2);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4_2 = _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4;
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4_3 = _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4;
  assign _zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2_1 = ($signed(_blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4) >>> _blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal);
  assign _zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2 = _zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2_1[31:0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2_1 = (($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2) < $signed(32'hffffff80)) ? 8'h80 : _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2_2);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2_2 = _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2[7:0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_outChReg = (_blocks_blocks_2_pw_Conv_output_0_quantized_outChReg + 7'h01);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_outColReg = (_blocks_blocks_2_pw_Conv_output_0_quantized_outColReg + 3'b001);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_outRowReg = (_blocks_blocks_2_pw_Conv_output_0_quantized_outRowReg + 5'h01);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasVal_1 = _zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasVal[5:0];
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal_1 = _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal[5:0];
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal_1 = _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal[5:0];
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_rowElemReg = (_blocks_blocks_3_dw_Conv_output_0_quantized_rowElemReg + 9'h001);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_1 = (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_2 + _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_3);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_2 = (_blocks_blocks_3_dw_Conv_output_0_quantized_outRowReg * 9'h1c0);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_4 = (_blocks_blocks_3_dw_Conv_output_0_quantized_outColReg * 7'h40);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_3 = {4'd0, _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_4};
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_5 = {7'd0, _blocks_blocks_3_dw_Conv_output_0_quantized_outChReg};
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_wAddrReg = (_blocks_blocks_3_dw_Conv_output_0_quantized_outChReg * 4'b1001);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_rowStepReg = (_blocks_blocks_3_dw_Conv_output_0_quantized_rowStepReg + 2'b01);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg = ($signed(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_1) * $signed(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_3));
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_1 = ($signed(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_2) - $signed(9'h180));
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_2 = {{1{_blocks_blocks_3_dw_Conv_output_0_quantized_inValReg[7]}}, _blocks_blocks_3_dw_Conv_output_0_quantized_inValReg};
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_3 = ($signed(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_4) - $signed(9'h0));
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg_4 = {{1{_blocks_blocks_3_dw_Conv_output_0_quantized_wValReg[7]}}, _blocks_blocks_3_dw_Conv_output_0_quantized_wValReg};
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_absAReg = (($signed(_blocks_blocks_3_dw_Conv_output_0_quantized_accumRequantReg) < $signed(32'h0)) ? _zz__blocks_blocks_3_dw_Conv_output_0_quantized_absAReg_1 : _blocks_blocks_3_dw_Conv_output_0_quantized_accumRequantReg);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_absAReg_1 = (- _blocks_blocks_3_dw_Conv_output_0_quantized_accumRequantReg);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pSumReg = {1'd0, _blocks_blocks_3_dw_Conv_output_0_quantized_pLH_Reg};
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pSumReg_1 = {1'd0, _blocks_blocks_3_dw_Conv_output_0_quantized_pHL_Reg};
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg = {32'd0, _blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg2};
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg_2 = ({16'd0,_zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg_3} <<< 5'd16);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg_1 = _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg_2[63:0];
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg_3 = {31'd0, _blocks_blocks_3_dw_Conv_output_0_quantized_pSumReg};
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part2Reg = ({32'd0,_zz__blocks_blocks_3_dw_Conv_output_0_quantized_part2Reg_1} <<< 6'd32);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part2Reg_1 = {32'd0, _blocks_blocks_3_dw_Conv_output_0_quantized_pHH_Reg2};
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2_1 = (- _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2_2);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2_2 = _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2_3 = _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2;
  assign _zz__zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg_1 = ($signed(_blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2) >>> _blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal);
  assign _zz__zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg = _zz__zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg_1[31:0];
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg_1 = (($signed(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg_2);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg_2 = _zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg[7:0];
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_outChReg = (_blocks_blocks_3_dw_Conv_output_0_quantized_outChReg + 7'h01);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_outColReg = (_blocks_blocks_3_dw_Conv_output_0_quantized_outColReg + 3'b001);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_outRowReg = (_blocks_blocks_3_dw_Conv_output_0_quantized_outRowReg + 5'h01);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw_1 = _zz__blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw[2:0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasVal_1 = _zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasVal[5:0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal_1 = _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal[5:0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal_1 = _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal[5:0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg = (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg + 4'b0001);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg = (_blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg + 1'b1);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_wBeatBuf = (_blocks_blocks_3_pw_Conv_output_0_quantized_wBeatBuf >>> 7'd64);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_port_2 = _blocks_blocks_3_pw_Conv_output_0_quantized_wStepReg[2:0];
  assign _zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg = {1'd0, _blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg};
  assign _zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_1 = {1'd0, _blocks_blocks_3_pw_Conv_output_0_quantized_khCntReg};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_2 = (_zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg - 2'b01);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_1 = _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_2[0:0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_3 = _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg[0:0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_2 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_3) + $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_16));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_3 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_4) + $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_10));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_5 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_6) * $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_8));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_4 = {{14{_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_5[17]}}, _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_5};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_6 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_7) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_7 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_0[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_0};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_8 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_9) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_9 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_0[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_0};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_11 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_12) * $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_14));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_10 = {{14{_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_11[17]}}, _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_11};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_12 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_13) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_13 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_1[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_1};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_14 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_15) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_15 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_1[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_1};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_16 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_17) + $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_23));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_18 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_19) * $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_21));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_17 = {{14{_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_18[17]}}, _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_18};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_19 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_20) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_20 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_2[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_2};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_21 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_22) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_22 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_2[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_2};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_24 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_25) * $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_27));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_23 = {{14{_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_24[17]}}, _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_24};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_25 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_26) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_26 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_3[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_3};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_27 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_28) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_28 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_3[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_3};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_29 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_30) + $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_43));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_30 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_31) + $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_37));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_32 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_33) * $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_35));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_31 = {{14{_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_32[17]}}, _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_32};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_33 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_34) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_34 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_4[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_4};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_35 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_36) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_36 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_4[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_4};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_38 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_39) * $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_41));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_37 = {{14{_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_38[17]}}, _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_38};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_39 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_40) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_40 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_5[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_5};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_41 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_42) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_42 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_5[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_5};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_43 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_44) + $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_50));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_45 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_46) * $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_48));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_44 = {{14{_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_45[17]}}, _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_45};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_46 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_47) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_47 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_6[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_6};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_48 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_49) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_49 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_6[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_6};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_51 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_52) * $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_54));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_50 = {{14{_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_51[17]}}, _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_51};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_52 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_53) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_53 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_7[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_7};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_54 = ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_55) - $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_1));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_55 = {{1{_blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_7[7]}}, _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_7};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6 = (($signed(_blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_3) < $signed(32'h0)) ? _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6_1 : _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_3);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6_1 = (- _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_3);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_11 = {1'd0, _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_8};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_11_1 = {1'd0, _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_9};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14 = {32'd0, _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_12};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14_2 = ({16'd0,_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14_3} <<< 5'd16);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14_1 = _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14_2[63:0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14_3 = {31'd0, _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_11};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_15 = ({32'd0,_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_15_1} <<< 6'd32);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_15_1 = {32'd0, _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_13};
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4_1 = (- _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4_2);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4_2 = _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4;
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4_3 = _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4;
  assign _zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2_1 = ($signed(_blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4) >>> _blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal);
  assign _zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2 = _zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2_1[31:0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2_1 = (($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2) < $signed(32'hffffff80)) ? 8'h80 : _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2_2);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2_2 = _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2[7:0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_outChReg = (_blocks_blocks_3_pw_Conv_output_0_quantized_outChReg + 7'h01);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_outColReg = (_blocks_blocks_3_pw_Conv_output_0_quantized_outColReg + 3'b001);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_outRowReg = (_blocks_blocks_3_pw_Conv_output_0_quantized_outRowReg + 5'h01);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_accumNew = {{24{_gap_GlobalAveragePool_output_0_quantized_inValReg[7]}}, _gap_GlobalAveragePool_output_0_quantized_inValReg};
  assign _zz__gap_GlobalAveragePool_output_0_quantized_accumRam_port_1 = _gap_GlobalAveragePool_output_0_quantized_chReg_d1[5:0];
  assign _zz__gap_GlobalAveragePool_output_0_quantized_chReg = (_gap_GlobalAveragePool_output_0_quantized_chReg + 7'h01);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_colReg = (_gap_GlobalAveragePool_output_0_quantized_colReg + 3'b001);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_rowReg = (_gap_GlobalAveragePool_output_0_quantized_rowReg + 5'h01);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_absAReg_1 = (($signed(_zz__gap_GlobalAveragePool_output_0_quantized_absAReg) < $signed(32'h0)) ? _zz__gap_GlobalAveragePool_output_0_quantized_absAReg_2 : _zz__gap_GlobalAveragePool_output_0_quantized_absAReg);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_absAReg_2 = (- _zz__gap_GlobalAveragePool_output_0_quantized_absAReg);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_pSumReg = {1'd0, _gap_GlobalAveragePool_output_0_quantized_pLH_Reg};
  assign _zz__gap_GlobalAveragePool_output_0_quantized_pSumReg_1 = {1'd0, _gap_GlobalAveragePool_output_0_quantized_pHL_Reg};
  assign _zz__gap_GlobalAveragePool_output_0_quantized_part1Reg = {32'd0, _gap_GlobalAveragePool_output_0_quantized_pLL_Reg2};
  assign _zz__gap_GlobalAveragePool_output_0_quantized_part1Reg_2 = ({16'd0,_zz__gap_GlobalAveragePool_output_0_quantized_part1Reg_3} <<< 5'd16);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_part1Reg_1 = _zz__gap_GlobalAveragePool_output_0_quantized_part1Reg_2[63:0];
  assign _zz__gap_GlobalAveragePool_output_0_quantized_part1Reg_3 = {31'd0, _gap_GlobalAveragePool_output_0_quantized_pSumReg};
  assign _zz__gap_GlobalAveragePool_output_0_quantized_part2Reg = ({32'd0,_zz__gap_GlobalAveragePool_output_0_quantized_part2Reg_1} <<< 6'd32);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_part2Reg_1 = {32'd0, _gap_GlobalAveragePool_output_0_quantized_pHH_Reg2};
  assign _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2_1 = (- _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2_2);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2_2 = _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2;
  assign _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2_3 = _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2;
  assign _zz__zz__gap_GlobalAveragePool_output_0_quantized_resultReg_1 = (_gap_GlobalAveragePool_output_0_quantized_reqProdReg2 >>> 6'd36);
  assign _zz__zz__gap_GlobalAveragePool_output_0_quantized_resultReg = {{4{_zz__zz__gap_GlobalAveragePool_output_0_quantized_resultReg_1[27]}}, _zz__zz__gap_GlobalAveragePool_output_0_quantized_resultReg_1};
  assign _zz__gap_GlobalAveragePool_output_0_quantized_resultReg_1 = (($signed(_zz__gap_GlobalAveragePool_output_0_quantized_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz__gap_GlobalAveragePool_output_0_quantized_resultReg_2);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_resultReg_2 = _zz__gap_GlobalAveragePool_output_0_quantized_resultReg[7:0];
  assign _zz_output_quantized_inputBuf_port_1 = output_quantized_recvCntReg[5:0];
  assign _zz_output_quantized_wBeatBuf = (output_quantized_wBeatBuf >>> 4'd8);
  assign _zz_output_quantized_weightBuf_port_1 = output_quantized_wStepReg[5:0];
  assign _zz_output_quantized_weightBuf_port_3 = output_quantized_wBeatBuf[7 : 0];
  assign _zz_output_quantized_prodReg = ($signed(_zz_output_quantized_prodReg_1) * $signed(_zz_output_quantized_prodReg_3));
  assign _zz_output_quantized_prodReg_1 = ($signed(_zz_output_quantized_prodReg_2) - $signed(9'h180));
  assign _zz_output_quantized_prodReg_2 = {{1{output_quantized_inValReg[7]}}, output_quantized_inValReg};
  assign _zz_output_quantized_prodReg_3 = ($signed(_zz_output_quantized_prodReg_4) - $signed(9'h0));
  assign _zz_output_quantized_prodReg_4 = {{1{output_quantized_wValReg[7]}}, output_quantized_wValReg};
  assign _zz_output_quantized_absAReg = (($signed(output_quantized_accumRequantReg) < $signed(32'h0)) ? _zz_output_quantized_absAReg_1 : output_quantized_accumRequantReg);
  assign _zz_output_quantized_absAReg_1 = (- output_quantized_accumRequantReg);
  assign _zz_output_quantized_pSumReg = {1'd0, output_quantized_pLH_Reg};
  assign _zz_output_quantized_pSumReg_1 = {1'd0, output_quantized_pHL_Reg};
  assign _zz_output_quantized_part1Reg = {32'd0, output_quantized_pLL_Reg2};
  assign _zz_output_quantized_part1Reg_2 = ({16'd0,_zz_output_quantized_part1Reg_3} <<< 5'd16);
  assign _zz_output_quantized_part1Reg_1 = _zz_output_quantized_part1Reg_2[63:0];
  assign _zz_output_quantized_part1Reg_3 = {31'd0, output_quantized_pSumReg};
  assign _zz_output_quantized_part2Reg = ({32'd0,_zz_output_quantized_part2Reg_1} <<< 6'd32);
  assign _zz_output_quantized_part2Reg_1 = {32'd0, output_quantized_pHH_Reg2};
  assign _zz_output_quantized_reqProdReg2_1 = (- _zz_output_quantized_reqProdReg2_2);
  assign _zz_output_quantized_reqProdReg2_2 = _zz_output_quantized_reqProdReg2;
  assign _zz_output_quantized_reqProdReg2_3 = _zz_output_quantized_reqProdReg2;
  assign _zz__zz_output_quantized_resultReg_1 = (output_quantized_reqProdReg2 >>> 6'd48);
  assign _zz__zz_output_quantized_resultReg = {{16{_zz__zz_output_quantized_resultReg_1[15]}}, _zz__zz_output_quantized_resultReg_1};
  assign _zz_output_quantized_resultReg_1 = (($signed(_zz_output_quantized_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz_output_quantized_resultReg_2);
  assign _zz_output_quantized_resultReg_2 = _zz_output_quantized_resultReg[7:0];
  assign _zz_output_quantized_outNeurReg = (output_quantized_outNeurReg + 4'b0001);
  assign _zz_weightDmaAxi_ar_payload_addr_5 = (_zz_weightDmaAxi_ar_payload_addr_1 * _zz_weightDmaAxi_ar_payload_addr_6);
  assign _zz_weightDmaAxi_ar_payload_addr_4 = {19'd0, _zz_weightDmaAxi_ar_payload_addr_5};
  assign _zz_weightDmaAxi_ar_payload_len_1 = (_zz_weightDmaAxi_ar_payload_len - 1'b1);
  assign _zz_when_WeightDmaCore_l178_1 = (_zz_weightDmaAxi_ar_payload_len - 1'b1);
  assign _zz__zz_weightDmaAxi_ar_payload_addr_2 = (_zz__zz_weightDmaAxi_ar_payload_addr_2_1 - 7'h01);
  assign _zz__zz_weightDmaAxi_ar_payload_addr_1 = (_zz_weightDmaAxi_ar_payload_addr_1 + 7'h01);
  assign _zz__zz_weightDmaAxi_ar_payload_addr = (_zz_weightDmaAxi_ar_payload_addr + 3'b001);
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_0_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_0_port_1 = (_zz_24 ? _stem_conv_Conv_output_0_quantized_initAddrReg : _stem_conv_Conv_output_0_quantized_rxAddr);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_0_port_2 = (_zz_25 ? _stem_conv_Conv_output_0_quantized_recvData : _stem_conv_Conv_output_0_quantized_zpWideBits);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_0_port_3 = ((_zz_24 || _zz_25) || ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_22) && (! _stem_conv_Conv_output_0_quantized_isReal)) && _zz_23));
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_1_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_1_port_1 = (_zz_29 ? _stem_conv_Conv_output_0_quantized_initAddrReg : _stem_conv_Conv_output_0_quantized_rxAddr);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_1_port_2 = (_zz_30 ? _stem_conv_Conv_output_0_quantized_recvData : _stem_conv_Conv_output_0_quantized_zpWideBits);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_1_port_3 = ((_zz_29 || _zz_30) || ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_27) && (! _stem_conv_Conv_output_0_quantized_isReal)) && _zz_28));
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_2_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_2_port_1 = (_zz_34 ? _stem_conv_Conv_output_0_quantized_initAddrReg : _stem_conv_Conv_output_0_quantized_rxAddr);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_2_port_2 = (_zz_35 ? _stem_conv_Conv_output_0_quantized_recvData : _stem_conv_Conv_output_0_quantized_zpWideBits);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_2_port_3 = ((_zz_34 || _zz_35) || ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_32) && (! _stem_conv_Conv_output_0_quantized_isReal)) && _zz_33));
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_3_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_3_port_1 = (_zz_39 ? _stem_conv_Conv_output_0_quantized_initAddrReg : _stem_conv_Conv_output_0_quantized_rxAddr);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_3_port_2 = (_zz_40 ? _stem_conv_Conv_output_0_quantized_recvData : _stem_conv_Conv_output_0_quantized_zpWideBits);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_3_port_3 = ((_zz_39 || _zz_40) || ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_37) && (! _stem_conv_Conv_output_0_quantized_isReal)) && _zz_38));
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_4_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_4_port_1 = (_zz_44 ? _stem_conv_Conv_output_0_quantized_initAddrReg : _stem_conv_Conv_output_0_quantized_rxAddr);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_4_port_2 = (_zz_45 ? _stem_conv_Conv_output_0_quantized_recvData : _stem_conv_Conv_output_0_quantized_zpWideBits);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_4_port_3 = ((_zz_44 || _zz_45) || ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_42) && (! _stem_conv_Conv_output_0_quantized_isReal)) && _zz_43));
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_5_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_5_port_1 = (_zz_49 ? _stem_conv_Conv_output_0_quantized_initAddrReg : _stem_conv_Conv_output_0_quantized_rxAddr);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_5_port_2 = (_zz_50 ? _stem_conv_Conv_output_0_quantized_recvData : _stem_conv_Conv_output_0_quantized_zpWideBits);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_5_port_3 = ((_zz_49 || _zz_50) || ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_47) && (! _stem_conv_Conv_output_0_quantized_isReal)) && _zz_48));
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_6_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_6_port_1 = (_zz_54 ? _stem_conv_Conv_output_0_quantized_initAddrReg : _stem_conv_Conv_output_0_quantized_rxAddr);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_6_port_2 = (_zz_55 ? _stem_conv_Conv_output_0_quantized_recvData : _stem_conv_Conv_output_0_quantized_zpWideBits);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_6_port_3 = ((_zz_54 || _zz_55) || ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_52) && (! _stem_conv_Conv_output_0_quantized_isReal)) && _zz_53));
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_7_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_7_port_1 = (_zz_59 ? _stem_conv_Conv_output_0_quantized_initAddrReg : _stem_conv_Conv_output_0_quantized_rxAddr);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_7_port_2 = (_zz_60 ? _stem_conv_Conv_output_0_quantized_recvData : _stem_conv_Conv_output_0_quantized_zpWideBits);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_7_port_3 = ((_zz_59 || _zz_60) || ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_57) && (! _stem_conv_Conv_output_0_quantized_isReal)) && _zz_58));
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_8_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_8_port_1 = (_zz_64 ? _stem_conv_Conv_output_0_quantized_initAddrReg : _stem_conv_Conv_output_0_quantized_rxAddr);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_8_port_2 = (_zz_65 ? _stem_conv_Conv_output_0_quantized_recvData : _stem_conv_Conv_output_0_quantized_zpWideBits);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_8_port_3 = ((_zz_64 || _zz_65) || ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_62) && (! _stem_conv_Conv_output_0_quantized_isReal)) && _zz_63));
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_9_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_9_port_1 = (_zz_69 ? _stem_conv_Conv_output_0_quantized_initAddrReg : _stem_conv_Conv_output_0_quantized_rxAddr);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_9_port_2 = (_zz_70 ? _stem_conv_Conv_output_0_quantized_recvData : _stem_conv_Conv_output_0_quantized_zpWideBits);
  assign _zz__stem_conv_Conv_output_0_quantized_inputBuf_9_port_3 = ((_zz_69 || _zz_70) || ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_67) && (! _stem_conv_Conv_output_0_quantized_isReal)) && _zz_68));
  assign _zz__stem_conv_Conv_output_0_quantized_wDataRaw_1 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_weightBuf_port_1 = _stem_conv_Conv_output_0_quantized_wBeatBuf[7 : 0];
  assign _zz__stem_conv_Conv_output_0_quantized_biasVal_2 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_reqMultVal_2 = 1'b1;
  assign _zz__stem_conv_Conv_output_0_quantized_reqShiftVal_2 = 1'b1;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inValR_1 = 1'b1;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf_port_1 = _blocks_blocks_0_dw_Conv_output_0_quantized_wrData;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf_port_2 = (_blocks_blocks_0_dw_Conv_output_0_quantized_doInit || _blocks_blocks_0_dw_Conv_output_0_quantized_doRecv);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_wValR_1 = 1'b1;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasVal_2 = 1'b1;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal_2 = 1'b1;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal_2 = 1'b1;
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0_1 = 1'b1;
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_port_1 = (_zz_86 ? _blocks_blocks_0_pw_Conv_output_0_quantized_initAddrReg : _blocks_blocks_0_pw_Conv_output_0_quantized_rxAddr);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_port_2 = (_zz_87 ? _blocks_blocks_0_pw_Conv_output_0_quantized_recvData : _blocks_blocks_0_pw_Conv_output_0_quantized_zpWideBits);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_port_3 = ((_zz_86 || _zz_87) || ((((_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow) && _zz_84) && (! _blocks_blocks_0_pw_Conv_output_0_quantized_isReal)) && _zz_85));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw_2 = 1'b1;
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_port_3 = _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatBuf[63 : 0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasVal_2 = 1'b1;
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal_2 = 1'b1;
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal_2 = 1'b1;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inValR_1 = 1'b1;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf_port_1 = _blocks_blocks_1_dw_Conv_output_0_quantized_wrData;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf_port_2 = (_blocks_blocks_1_dw_Conv_output_0_quantized_doInit || _blocks_blocks_1_dw_Conv_output_0_quantized_doRecv);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_wValR_1 = 1'b1;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasVal_2 = 1'b1;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal_2 = 1'b1;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal_2 = 1'b1;
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0_1 = 1'b1;
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_port_1 = (_zz_103 ? _blocks_blocks_1_pw_Conv_output_0_quantized_initAddrReg : _blocks_blocks_1_pw_Conv_output_0_quantized_rxAddr);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_port_2 = (_zz_104 ? _blocks_blocks_1_pw_Conv_output_0_quantized_recvData : _blocks_blocks_1_pw_Conv_output_0_quantized_zpWideBits);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_port_3 = ((_zz_103 || _zz_104) || ((((_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow) && _zz_101) && (! _blocks_blocks_1_pw_Conv_output_0_quantized_isReal)) && _zz_102));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw_2 = 1'b1;
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_port_3 = _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatBuf[63 : 0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasVal_2 = 1'b1;
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal_2 = 1'b1;
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal_2 = 1'b1;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inValR_1 = 1'b1;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf_port_1 = _blocks_blocks_2_dw_Conv_output_0_quantized_wrData;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf_port_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_doInit || _blocks_blocks_2_dw_Conv_output_0_quantized_doRecv);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_wValR_1 = 1'b1;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasVal_2 = 1'b1;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal_2 = 1'b1;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal_2 = 1'b1;
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0_1 = 1'b1;
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_port_1 = (_zz_120 ? _blocks_blocks_2_pw_Conv_output_0_quantized_initAddrReg : _blocks_blocks_2_pw_Conv_output_0_quantized_rxAddr);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_port_2 = (_zz_121 ? _blocks_blocks_2_pw_Conv_output_0_quantized_recvData : _blocks_blocks_2_pw_Conv_output_0_quantized_zpWideBits);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_port_3 = ((_zz_120 || _zz_121) || ((((_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow) && _zz_118) && (! _blocks_blocks_2_pw_Conv_output_0_quantized_isReal)) && _zz_119));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw_2 = 1'b1;
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_port_3 = _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatBuf[63 : 0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasVal_2 = 1'b1;
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal_2 = 1'b1;
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal_2 = 1'b1;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inValR_1 = 1'b1;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf_port_1 = _blocks_blocks_3_dw_Conv_output_0_quantized_wrData;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf_port_2 = (_blocks_blocks_3_dw_Conv_output_0_quantized_doInit || _blocks_blocks_3_dw_Conv_output_0_quantized_doRecv);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_wValR_1 = 1'b1;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasVal_2 = 1'b1;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal_2 = 1'b1;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal_2 = 1'b1;
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0_1 = 1'b1;
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_port_1 = (_zz_137 ? _blocks_blocks_3_pw_Conv_output_0_quantized_initAddrReg : _blocks_blocks_3_pw_Conv_output_0_quantized_rxAddr);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_port_2 = (_zz_138 ? _blocks_blocks_3_pw_Conv_output_0_quantized_recvData : _blocks_blocks_3_pw_Conv_output_0_quantized_zpWideBits);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_port_3 = ((_zz_137 || _zz_138) || ((((_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow) && _zz_135) && (! _blocks_blocks_3_pw_Conv_output_0_quantized_isReal)) && _zz_136));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw_2 = 1'b1;
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_port_3 = _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatBuf[63 : 0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasVal_2 = 1'b1;
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal_2 = 1'b1;
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal_2 = 1'b1;
  assign _zz__gap_GlobalAveragePool_output_0_quantized_readData = 1'b1;
  assign _zz__gap_GlobalAveragePool_output_0_quantized_accumRam_port_2 = _gap_GlobalAveragePool_output_0_quantized_accumNew;
  assign _zz_output_quantized_inValR = 1'b1;
  assign _zz_output_quantized_inputBuf_port_2 = GlobalAveragePoolPlugin_logic_outStream_payload_value;
  assign _zz_output_quantized_wValR = 1'b1;
  assign _zz_output_quantized_weightBuf_port_2 = _zz_output_quantized_weightBuf_port_3;
  assign _zz_output_quantized_biasVal_1 = 1'b1;
  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_rowWideReads_0_1) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_0_spinal_port0 <= _stem_conv_Conv_output_0_quantized_inputBuf_0[_zz__stem_conv_Conv_output_0_quantized_rowWideReads_0];
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_inputBuf_0_port_3) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_0[_zz__stem_conv_Conv_output_0_quantized_inputBuf_0_port_1] <= _zz__stem_conv_Conv_output_0_quantized_inputBuf_0_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_rowWideReads_1_1) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_1_spinal_port0 <= _stem_conv_Conv_output_0_quantized_inputBuf_1[_zz__stem_conv_Conv_output_0_quantized_rowWideReads_1];
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_inputBuf_1_port_3) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_1[_zz__stem_conv_Conv_output_0_quantized_inputBuf_1_port_1] <= _zz__stem_conv_Conv_output_0_quantized_inputBuf_1_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_rowWideReads_2_1) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_2_spinal_port0 <= _stem_conv_Conv_output_0_quantized_inputBuf_2[_zz__stem_conv_Conv_output_0_quantized_rowWideReads_2];
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_inputBuf_2_port_3) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_2[_zz__stem_conv_Conv_output_0_quantized_inputBuf_2_port_1] <= _zz__stem_conv_Conv_output_0_quantized_inputBuf_2_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_rowWideReads_3_1) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_3_spinal_port0 <= _stem_conv_Conv_output_0_quantized_inputBuf_3[_zz__stem_conv_Conv_output_0_quantized_rowWideReads_3];
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_inputBuf_3_port_3) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_3[_zz__stem_conv_Conv_output_0_quantized_inputBuf_3_port_1] <= _zz__stem_conv_Conv_output_0_quantized_inputBuf_3_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_rowWideReads_4_1) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_4_spinal_port0 <= _stem_conv_Conv_output_0_quantized_inputBuf_4[_zz__stem_conv_Conv_output_0_quantized_rowWideReads_4];
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_inputBuf_4_port_3) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_4[_zz__stem_conv_Conv_output_0_quantized_inputBuf_4_port_1] <= _zz__stem_conv_Conv_output_0_quantized_inputBuf_4_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_rowWideReads_5_1) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_5_spinal_port0 <= _stem_conv_Conv_output_0_quantized_inputBuf_5[_zz__stem_conv_Conv_output_0_quantized_rowWideReads_5];
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_inputBuf_5_port_3) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_5[_zz__stem_conv_Conv_output_0_quantized_inputBuf_5_port_1] <= _zz__stem_conv_Conv_output_0_quantized_inputBuf_5_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_rowWideReads_6_1) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_6_spinal_port0 <= _stem_conv_Conv_output_0_quantized_inputBuf_6[_zz__stem_conv_Conv_output_0_quantized_rowWideReads_6];
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_inputBuf_6_port_3) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_6[_zz__stem_conv_Conv_output_0_quantized_inputBuf_6_port_1] <= _zz__stem_conv_Conv_output_0_quantized_inputBuf_6_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_rowWideReads_7_1) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_7_spinal_port0 <= _stem_conv_Conv_output_0_quantized_inputBuf_7[_zz__stem_conv_Conv_output_0_quantized_rowWideReads_7];
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_inputBuf_7_port_3) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_7[_zz__stem_conv_Conv_output_0_quantized_inputBuf_7_port_1] <= _zz__stem_conv_Conv_output_0_quantized_inputBuf_7_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_rowWideReads_8_1) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_8_spinal_port0 <= _stem_conv_Conv_output_0_quantized_inputBuf_8[_zz__stem_conv_Conv_output_0_quantized_rowWideReads_8];
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_inputBuf_8_port_3) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_8[_zz__stem_conv_Conv_output_0_quantized_inputBuf_8_port_1] <= _zz__stem_conv_Conv_output_0_quantized_inputBuf_8_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_rowWideReads_9_1) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_9_spinal_port0 <= _stem_conv_Conv_output_0_quantized_inputBuf_9[_zz__stem_conv_Conv_output_0_quantized_rowWideReads_9];
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_inputBuf_9_port_3) begin
      _stem_conv_Conv_output_0_quantized_inputBuf_9[_zz__stem_conv_Conv_output_0_quantized_inputBuf_9_port_1] <= _zz__stem_conv_Conv_output_0_quantized_inputBuf_9_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_wDataRaw_1) begin
      _stem_conv_Conv_output_0_quantized_weightBuf_spinal_port0 <= _stem_conv_Conv_output_0_quantized_weightBuf[_zz__stem_conv_Conv_output_0_quantized_wDataRaw];
    end
  end

  always @(posedge clk) begin
    if(_zz_7) begin
      _stem_conv_Conv_output_0_quantized_weightBuf[_stem_conv_Conv_output_0_quantized_wStepReg] <= _zz__stem_conv_Conv_output_0_quantized_weightBuf_port_1;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__stem_conv_Conv_output_0_quantized_biasRom.bin",_stem_conv_Conv_output_0_quantized_biasRom);
  end
  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_biasVal_2) begin
      _stem_conv_Conv_output_0_quantized_biasRom_spinal_port0 <= _stem_conv_Conv_output_0_quantized_biasRom[_zz__stem_conv_Conv_output_0_quantized_biasVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__stem_conv_Conv_output_0_quantized_reqMultRom.bin",_stem_conv_Conv_output_0_quantized_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_reqMultVal_2) begin
      _stem_conv_Conv_output_0_quantized_reqMultRom_spinal_port0 <= _stem_conv_Conv_output_0_quantized_reqMultRom[_zz__stem_conv_Conv_output_0_quantized_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__stem_conv_Conv_output_0_quantized_reqShiftRom.bin",_stem_conv_Conv_output_0_quantized_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz__stem_conv_Conv_output_0_quantized_reqShiftVal_2) begin
      _stem_conv_Conv_output_0_quantized_reqShiftRom_spinal_port0 <= _stem_conv_Conv_output_0_quantized_reqShiftRom[_zz__stem_conv_Conv_output_0_quantized_reqShiftVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_inValR_1) begin
      _blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf_spinal_port0 <= _blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf[_zz__blocks_blocks_0_dw_Conv_output_0_quantized_inValR];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf_port_2) begin
      _blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf[_blocks_blocks_0_dw_Conv_output_0_quantized_wrAddr] <= _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf_port_1;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_0_dw_Conv_output_0_quantized_weightRom.bin",_blocks_blocks_0_dw_Conv_output_0_quantized_weightRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_wValR_1) begin
      _blocks_blocks_0_dw_Conv_output_0_quantized_weightRom_spinal_port0 <= _blocks_blocks_0_dw_Conv_output_0_quantized_weightRom[_zz__blocks_blocks_0_dw_Conv_output_0_quantized_wValR];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_0_dw_Conv_output_0_quantized_biasRom.bin",_blocks_blocks_0_dw_Conv_output_0_quantized_biasRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasVal_2) begin
      _blocks_blocks_0_dw_Conv_output_0_quantized_biasRom_spinal_port0 <= _blocks_blocks_0_dw_Conv_output_0_quantized_biasRom[_zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultRom.bin",_blocks_blocks_0_dw_Conv_output_0_quantized_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal_2) begin
      _blocks_blocks_0_dw_Conv_output_0_quantized_reqMultRom_spinal_port0 <= _blocks_blocks_0_dw_Conv_output_0_quantized_reqMultRom[_zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftRom.bin",_blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal_2) begin
      _blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0 <= _blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftRom[_zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0_1) begin
      _blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0 <= _blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0[_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_port_3) begin
      _blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0[_zz__blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_port_1] <= _zz__blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw_2) begin
      _blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_spinal_port0 <= _blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf[_zz__blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_6) begin
      _blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf[_zz__blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_port_2] <= _zz__blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_port_3;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_0_pw_Conv_output_0_quantized_biasRom.bin",_blocks_blocks_0_pw_Conv_output_0_quantized_biasRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasVal_2) begin
      _blocks_blocks_0_pw_Conv_output_0_quantized_biasRom_spinal_port0 <= _blocks_blocks_0_pw_Conv_output_0_quantized_biasRom[_zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultRom.bin",_blocks_blocks_0_pw_Conv_output_0_quantized_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal_2) begin
      _blocks_blocks_0_pw_Conv_output_0_quantized_reqMultRom_spinal_port0 <= _blocks_blocks_0_pw_Conv_output_0_quantized_reqMultRom[_zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftRom.bin",_blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal_2) begin
      _blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0 <= _blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftRom[_zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_inValR_1) begin
      _blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf_spinal_port0 <= _blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf[_zz__blocks_blocks_1_dw_Conv_output_0_quantized_inValR];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf_port_2) begin
      _blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf[_blocks_blocks_1_dw_Conv_output_0_quantized_wrAddr] <= _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf_port_1;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_1_dw_Conv_output_0_quantized_weightRom.bin",_blocks_blocks_1_dw_Conv_output_0_quantized_weightRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_wValR_1) begin
      _blocks_blocks_1_dw_Conv_output_0_quantized_weightRom_spinal_port0 <= _blocks_blocks_1_dw_Conv_output_0_quantized_weightRom[_zz__blocks_blocks_1_dw_Conv_output_0_quantized_wValR];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_1_dw_Conv_output_0_quantized_biasRom.bin",_blocks_blocks_1_dw_Conv_output_0_quantized_biasRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasVal_2) begin
      _blocks_blocks_1_dw_Conv_output_0_quantized_biasRom_spinal_port0 <= _blocks_blocks_1_dw_Conv_output_0_quantized_biasRom[_zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultRom.bin",_blocks_blocks_1_dw_Conv_output_0_quantized_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal_2) begin
      _blocks_blocks_1_dw_Conv_output_0_quantized_reqMultRom_spinal_port0 <= _blocks_blocks_1_dw_Conv_output_0_quantized_reqMultRom[_zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftRom.bin",_blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal_2) begin
      _blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0 <= _blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftRom[_zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0_1) begin
      _blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0 <= _blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0[_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_port_3) begin
      _blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0[_zz__blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_port_1] <= _zz__blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw_2) begin
      _blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_spinal_port0 <= _blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf[_zz__blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_5) begin
      _blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf[_zz__blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_port_2] <= _zz__blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_port_3;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_1_pw_Conv_output_0_quantized_biasRom.bin",_blocks_blocks_1_pw_Conv_output_0_quantized_biasRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasVal_2) begin
      _blocks_blocks_1_pw_Conv_output_0_quantized_biasRom_spinal_port0 <= _blocks_blocks_1_pw_Conv_output_0_quantized_biasRom[_zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultRom.bin",_blocks_blocks_1_pw_Conv_output_0_quantized_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal_2) begin
      _blocks_blocks_1_pw_Conv_output_0_quantized_reqMultRom_spinal_port0 <= _blocks_blocks_1_pw_Conv_output_0_quantized_reqMultRom[_zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftRom.bin",_blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal_2) begin
      _blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0 <= _blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftRom[_zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_inValR_1) begin
      _blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf_spinal_port0 <= _blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf[_zz__blocks_blocks_2_dw_Conv_output_0_quantized_inValR];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf_port_2) begin
      _blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf[_blocks_blocks_2_dw_Conv_output_0_quantized_wrAddr] <= _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf_port_1;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_2_dw_Conv_output_0_quantized_weightRom.bin",_blocks_blocks_2_dw_Conv_output_0_quantized_weightRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_wValR_1) begin
      _blocks_blocks_2_dw_Conv_output_0_quantized_weightRom_spinal_port0 <= _blocks_blocks_2_dw_Conv_output_0_quantized_weightRom[_zz__blocks_blocks_2_dw_Conv_output_0_quantized_wValR];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_2_dw_Conv_output_0_quantized_biasRom.bin",_blocks_blocks_2_dw_Conv_output_0_quantized_biasRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasVal_2) begin
      _blocks_blocks_2_dw_Conv_output_0_quantized_biasRom_spinal_port0 <= _blocks_blocks_2_dw_Conv_output_0_quantized_biasRom[_zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultRom.bin",_blocks_blocks_2_dw_Conv_output_0_quantized_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal_2) begin
      _blocks_blocks_2_dw_Conv_output_0_quantized_reqMultRom_spinal_port0 <= _blocks_blocks_2_dw_Conv_output_0_quantized_reqMultRom[_zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftRom.bin",_blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal_2) begin
      _blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0 <= _blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftRom[_zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0_1) begin
      _blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0 <= _blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0[_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_port_3) begin
      _blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0[_zz__blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_port_1] <= _zz__blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw_2) begin
      _blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_spinal_port0 <= _blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf[_zz__blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_4) begin
      _blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf[_zz__blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_port_2] <= _zz__blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_port_3;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_2_pw_Conv_output_0_quantized_biasRom.bin",_blocks_blocks_2_pw_Conv_output_0_quantized_biasRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasVal_2) begin
      _blocks_blocks_2_pw_Conv_output_0_quantized_biasRom_spinal_port0 <= _blocks_blocks_2_pw_Conv_output_0_quantized_biasRom[_zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultRom.bin",_blocks_blocks_2_pw_Conv_output_0_quantized_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal_2) begin
      _blocks_blocks_2_pw_Conv_output_0_quantized_reqMultRom_spinal_port0 <= _blocks_blocks_2_pw_Conv_output_0_quantized_reqMultRom[_zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftRom.bin",_blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal_2) begin
      _blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0 <= _blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftRom[_zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_inValR_1) begin
      _blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf_spinal_port0 <= _blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf[_zz__blocks_blocks_3_dw_Conv_output_0_quantized_inValR];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf_port_2) begin
      _blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf[_blocks_blocks_3_dw_Conv_output_0_quantized_wrAddr] <= _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf_port_1;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_3_dw_Conv_output_0_quantized_weightRom.bin",_blocks_blocks_3_dw_Conv_output_0_quantized_weightRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_wValR_1) begin
      _blocks_blocks_3_dw_Conv_output_0_quantized_weightRom_spinal_port0 <= _blocks_blocks_3_dw_Conv_output_0_quantized_weightRom[_zz__blocks_blocks_3_dw_Conv_output_0_quantized_wValR];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_3_dw_Conv_output_0_quantized_biasRom.bin",_blocks_blocks_3_dw_Conv_output_0_quantized_biasRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasVal_2) begin
      _blocks_blocks_3_dw_Conv_output_0_quantized_biasRom_spinal_port0 <= _blocks_blocks_3_dw_Conv_output_0_quantized_biasRom[_zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultRom.bin",_blocks_blocks_3_dw_Conv_output_0_quantized_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal_2) begin
      _blocks_blocks_3_dw_Conv_output_0_quantized_reqMultRom_spinal_port0 <= _blocks_blocks_3_dw_Conv_output_0_quantized_reqMultRom[_zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftRom.bin",_blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal_2) begin
      _blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0 <= _blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftRom[_zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0_1) begin
      _blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0 <= _blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0[_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0];
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_port_3) begin
      _blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0[_zz__blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_port_1] <= _zz__blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw_2) begin
      _blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_spinal_port0 <= _blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf[_zz__blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_3) begin
      _blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf[_zz__blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_port_2] <= _zz__blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_port_3;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_3_pw_Conv_output_0_quantized_biasRom.bin",_blocks_blocks_3_pw_Conv_output_0_quantized_biasRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasVal_2) begin
      _blocks_blocks_3_pw_Conv_output_0_quantized_biasRom_spinal_port0 <= _blocks_blocks_3_pw_Conv_output_0_quantized_biasRom[_zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultRom.bin",_blocks_blocks_3_pw_Conv_output_0_quantized_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal_2) begin
      _blocks_blocks_3_pw_Conv_output_0_quantized_reqMultRom_spinal_port0 <= _blocks_blocks_3_pw_Conv_output_0_quantized_reqMultRom[_zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftRom.bin",_blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal_2) begin
      _blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0 <= _blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftRom[_zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal_1];
    end
  end

  always @(posedge clk) begin
    if(_zz__gap_GlobalAveragePool_output_0_quantized_readData) begin
      _gap_GlobalAveragePool_output_0_quantized_accumRam_spinal_port0 <= _gap_GlobalAveragePool_output_0_quantized_accumRam[_gap_GlobalAveragePool_output_0_quantized_readAddr];
    end
  end

  always @(posedge clk) begin
    if(_gap_GlobalAveragePool_output_0_quantized_pipelineValidReg) begin
      _gap_GlobalAveragePool_output_0_quantized_accumRam[_zz__gap_GlobalAveragePool_output_0_quantized_accumRam_port_1] <= _zz__gap_GlobalAveragePool_output_0_quantized_accumRam_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz_output_quantized_inValR) begin
      output_quantized_inputBuf_spinal_port0 <= output_quantized_inputBuf[output_quantized_inAddrComb];
    end
  end

  always @(posedge clk) begin
    if(_zz_2) begin
      output_quantized_inputBuf[_zz_output_quantized_inputBuf_port_1] <= _zz_output_quantized_inputBuf_port_2;
    end
  end

  always @(posedge clk) begin
    if(_zz_output_quantized_wValR) begin
      output_quantized_weightBuf_spinal_port0 <= output_quantized_weightBuf[output_quantized_wAddrComb];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      output_quantized_weightBuf[_zz_output_quantized_weightBuf_port_1] <= _zz_output_quantized_weightBuf_port_2;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_output_quantized_biasRom.bin",output_quantized_biasRom);
  end
  always @(posedge clk) begin
    if(_zz_output_quantized_biasVal_1) begin
      output_quantized_biasRom_spinal_port0 <= output_quantized_biasRom[_zz_output_quantized_biasVal];
    end
  end

  always @(*) begin
    case(_stem_conv_Conv_output_0_quantized_curSlotReg)
      4'b0000 : _zz__stem_conv_Conv_output_0_quantized_inValReg_0 = _stem_conv_Conv_output_0_quantized_rowReads2D_0_0;
      4'b0001 : _zz__stem_conv_Conv_output_0_quantized_inValReg_0 = _stem_conv_Conv_output_0_quantized_rowReads2D_1_0;
      4'b0010 : _zz__stem_conv_Conv_output_0_quantized_inValReg_0 = _stem_conv_Conv_output_0_quantized_rowReads2D_2_0;
      4'b0011 : _zz__stem_conv_Conv_output_0_quantized_inValReg_0 = _stem_conv_Conv_output_0_quantized_rowReads2D_3_0;
      4'b0100 : _zz__stem_conv_Conv_output_0_quantized_inValReg_0 = _stem_conv_Conv_output_0_quantized_rowReads2D_4_0;
      4'b0101 : _zz__stem_conv_Conv_output_0_quantized_inValReg_0 = _stem_conv_Conv_output_0_quantized_rowReads2D_5_0;
      4'b0110 : _zz__stem_conv_Conv_output_0_quantized_inValReg_0 = _stem_conv_Conv_output_0_quantized_rowReads2D_6_0;
      4'b0111 : _zz__stem_conv_Conv_output_0_quantized_inValReg_0 = _stem_conv_Conv_output_0_quantized_rowReads2D_7_0;
      4'b1000 : _zz__stem_conv_Conv_output_0_quantized_inValReg_0 = _stem_conv_Conv_output_0_quantized_rowReads2D_8_0;
      default : _zz__stem_conv_Conv_output_0_quantized_inValReg_0 = _stem_conv_Conv_output_0_quantized_rowReads2D_9_0;
    endcase
  end

  always @(*) begin
    case(_zz_weightDmaAxi_ar_payload_addr)
      3'b000 : begin
        _zz__zz_weightDmaAxi_ar_payload_len = 1'b1;
        _zz_weightDmaAxi_ar_payload_addr_3 = 33'h0;
        _zz_weightDmaAxi_ar_payload_addr_6 = 7'h40;
        _zz__zz_weightDmaAxi_ar_payload_addr_2_1 = 7'h40;
      end
      3'b001 : begin
        _zz__zz_weightDmaAxi_ar_payload_len = 1'b1;
        _zz_weightDmaAxi_ar_payload_addr_3 = 33'h000001000;
        _zz_weightDmaAxi_ar_payload_addr_6 = 7'h40;
        _zz__zz_weightDmaAxi_ar_payload_addr_2_1 = 7'h40;
      end
      3'b010 : begin
        _zz__zz_weightDmaAxi_ar_payload_len = 1'b1;
        _zz_weightDmaAxi_ar_payload_addr_3 = 33'h000002000;
        _zz_weightDmaAxi_ar_payload_addr_6 = 7'h40;
        _zz__zz_weightDmaAxi_ar_payload_addr_2_1 = 7'h40;
      end
      3'b011 : begin
        _zz__zz_weightDmaAxi_ar_payload_len = 1'b1;
        _zz_weightDmaAxi_ar_payload_addr_3 = 33'h000003000;
        _zz_weightDmaAxi_ar_payload_addr_6 = 7'h40;
        _zz__zz_weightDmaAxi_ar_payload_addr_2_1 = 7'h40;
      end
      3'b100 : begin
        _zz__zz_weightDmaAxi_ar_payload_len = 1'b1;
        _zz_weightDmaAxi_ar_payload_addr_3 = 33'h000004000;
        _zz_weightDmaAxi_ar_payload_addr_6 = 7'h40;
        _zz__zz_weightDmaAxi_ar_payload_addr_2_1 = 7'h40;
      end
      default : begin
        _zz__zz_weightDmaAxi_ar_payload_len = 1'b1;
        _zz_weightDmaAxi_ar_payload_addr_3 = 33'h000005000;
        _zz_weightDmaAxi_ar_payload_addr_6 = 7'h40;
        _zz__zz_weightDmaAxi_ar_payload_addr_2_1 = 7'h0c;
      end
    endcase
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(when_QLinearLinearCore_l191) begin
      if(!when_QLinearLinearCore_l192) begin
        if(when_QLinearLinearCore_l201) begin
          _zz_1 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    _zz_2 = 1'b0;
    if(when_QLinearLinearCore_l174) begin
      if(GlobalAveragePoolPlugin_logic_outStream_fire) begin
        _zz_2 = 1'b1;
      end
    end
  end

  always @(*) begin
    _zz_3 = 1'b0;
    if(when_QLinearConvLineCore_l438_4) begin
      if(!when_QLinearConvLineCore_l439_4) begin
        if(when_QLinearConvLineCore_l448_4) begin
          _zz_3 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    _zz_4 = 1'b0;
    if(when_QLinearConvLineCore_l438_3) begin
      if(!when_QLinearConvLineCore_l439_3) begin
        if(when_QLinearConvLineCore_l448_3) begin
          _zz_4 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    _zz_5 = 1'b0;
    if(when_QLinearConvLineCore_l438_2) begin
      if(!when_QLinearConvLineCore_l439_2) begin
        if(when_QLinearConvLineCore_l448_2) begin
          _zz_5 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    _zz_6 = 1'b0;
    if(when_QLinearConvLineCore_l438_1) begin
      if(!when_QLinearConvLineCore_l439_1) begin
        if(when_QLinearConvLineCore_l448_1) begin
          _zz_6 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    _zz_7 = 1'b0;
    if(when_QLinearConvLineCore_l438) begin
      if(!when_QLinearConvLineCore_l439) begin
        if(when_QLinearConvLineCore_l448) begin
          _zz_7 = 1'b1;
        end
      end
    end
  end

  assign _stem_conv_Conv_output_0_quantized_zpWideBits = 8'h0;
  assign _stem_conv_Conv_output_0_quantized_sReceiveRow = 4'b0000;
  assign _stem_conv_Conv_output_0_quantized_sLoadBias = 4'b0001;
  assign _stem_conv_Conv_output_0_quantized_sWaitBias = 4'b0010;
  assign _stem_conv_Conv_output_0_quantized_sCompute = 4'b0011;
  assign _stem_conv_Conv_output_0_quantized_sRequant = 4'b0100;
  assign _stem_conv_Conv_output_0_quantized_sRequantMul = 4'b0101;
  assign _stem_conv_Conv_output_0_quantized_sRequantWait = 4'b0110;
  assign _stem_conv_Conv_output_0_quantized_sRequantWait2 = 4'b0111;
  assign _stem_conv_Conv_output_0_quantized_sRequantWait3 = 4'b1000;
  assign _stem_conv_Conv_output_0_quantized_sRequantShift = 4'b1001;
  assign _stem_conv_Conv_output_0_quantized_sEmit = 4'b1010;
  assign _stem_conv_Conv_output_0_quantized_sInit = 4'b1011;
  assign _stem_conv_Conv_output_0_quantized_sLoadWeights = 4'b1100;
  assign _stem_conv_Conv_output_0_quantized_rowAddrComb = _stem_conv_Conv_output_0_quantized_rowAddrReg;
  assign _stem_conv_Conv_output_0_quantized_wAddrComb = _stem_conv_Conv_output_0_quantized_wAddrReg;
  assign _stem_conv_Conv_output_0_quantized_rxAddr = (4'b0001 + _stem_conv_Conv_output_0_quantized_rxWordReg);
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_0 = _stem_conv_Conv_output_0_quantized_rowAddrComb;
  assign _stem_conv_Conv_output_0_quantized_rowWideReads_0 = _stem_conv_Conv_output_0_quantized_inputBuf_0_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_1 = _stem_conv_Conv_output_0_quantized_rowAddrComb;
  assign _stem_conv_Conv_output_0_quantized_rowWideReads_1 = _stem_conv_Conv_output_0_quantized_inputBuf_1_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_2 = _stem_conv_Conv_output_0_quantized_rowAddrComb;
  assign _stem_conv_Conv_output_0_quantized_rowWideReads_2 = _stem_conv_Conv_output_0_quantized_inputBuf_2_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_3 = _stem_conv_Conv_output_0_quantized_rowAddrComb;
  assign _stem_conv_Conv_output_0_quantized_rowWideReads_3 = _stem_conv_Conv_output_0_quantized_inputBuf_3_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_4 = _stem_conv_Conv_output_0_quantized_rowAddrComb;
  assign _stem_conv_Conv_output_0_quantized_rowWideReads_4 = _stem_conv_Conv_output_0_quantized_inputBuf_4_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_5 = _stem_conv_Conv_output_0_quantized_rowAddrComb;
  assign _stem_conv_Conv_output_0_quantized_rowWideReads_5 = _stem_conv_Conv_output_0_quantized_inputBuf_5_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_6 = _stem_conv_Conv_output_0_quantized_rowAddrComb;
  assign _stem_conv_Conv_output_0_quantized_rowWideReads_6 = _stem_conv_Conv_output_0_quantized_inputBuf_6_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_7 = _stem_conv_Conv_output_0_quantized_rowAddrComb;
  assign _stem_conv_Conv_output_0_quantized_rowWideReads_7 = _stem_conv_Conv_output_0_quantized_inputBuf_7_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_8 = _stem_conv_Conv_output_0_quantized_rowAddrComb;
  assign _stem_conv_Conv_output_0_quantized_rowWideReads_8 = _stem_conv_Conv_output_0_quantized_inputBuf_8_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_rowWideReads_9 = _stem_conv_Conv_output_0_quantized_rowAddrComb;
  assign _stem_conv_Conv_output_0_quantized_rowWideReads_9 = _stem_conv_Conv_output_0_quantized_inputBuf_9_spinal_port0;
  assign _stem_conv_Conv_output_0_quantized_rowReads2D_0_0 = _stem_conv_Conv_output_0_quantized_rowWideReads_0[7 : 0];
  assign _stem_conv_Conv_output_0_quantized_rowReads2D_1_0 = _stem_conv_Conv_output_0_quantized_rowWideReads_1[7 : 0];
  assign _stem_conv_Conv_output_0_quantized_rowReads2D_2_0 = _stem_conv_Conv_output_0_quantized_rowWideReads_2[7 : 0];
  assign _stem_conv_Conv_output_0_quantized_rowReads2D_3_0 = _stem_conv_Conv_output_0_quantized_rowWideReads_3[7 : 0];
  assign _stem_conv_Conv_output_0_quantized_rowReads2D_4_0 = _stem_conv_Conv_output_0_quantized_rowWideReads_4[7 : 0];
  assign _stem_conv_Conv_output_0_quantized_rowReads2D_5_0 = _stem_conv_Conv_output_0_quantized_rowWideReads_5[7 : 0];
  assign _stem_conv_Conv_output_0_quantized_rowReads2D_6_0 = _stem_conv_Conv_output_0_quantized_rowWideReads_6[7 : 0];
  assign _stem_conv_Conv_output_0_quantized_rowReads2D_7_0 = _stem_conv_Conv_output_0_quantized_rowWideReads_7[7 : 0];
  assign _stem_conv_Conv_output_0_quantized_rowReads2D_8_0 = _stem_conv_Conv_output_0_quantized_rowWideReads_8[7 : 0];
  assign _stem_conv_Conv_output_0_quantized_rowReads2D_9_0 = _stem_conv_Conv_output_0_quantized_rowWideReads_9[7 : 0];
  assign _zz__stem_conv_Conv_output_0_quantized_wDataRaw = _stem_conv_Conv_output_0_quantized_wAddrComb;
  assign _stem_conv_Conv_output_0_quantized_wDataRaw = _stem_conv_Conv_output_0_quantized_weightBuf_spinal_port0;
  assign _stem_conv_Conv_output_0_quantized_wValsRaw_0 = _stem_conv_Conv_output_0_quantized_wDataRaw[7 : 0];
  assign _zz__stem_conv_Conv_output_0_quantized_biasVal = _stem_conv_Conv_output_0_quantized_outChReg;
  assign _stem_conv_Conv_output_0_quantized_biasVal = _stem_conv_Conv_output_0_quantized_biasRom_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_reqMultVal = _stem_conv_Conv_output_0_quantized_outChReg;
  assign _stem_conv_Conv_output_0_quantized_reqMultVal = _stem_conv_Conv_output_0_quantized_reqMultRom_spinal_port0;
  assign _zz__stem_conv_Conv_output_0_quantized_reqShiftVal = _stem_conv_Conv_output_0_quantized_outChReg;
  assign _stem_conv_Conv_output_0_quantized_reqShiftVal = _stem_conv_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  assign _stem_conv_Conv_output_0_quantized_isReal = (_stem_conv_Conv_output_0_quantized_realRowsRecvReg < 6'h31);
  assign io_activationIn_fire = (activation_in_valid && activation_in_ready);
  assign when_QLinearConvLineCore_l346 = ((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0));
  assign _stem_conv_Conv_output_0_quantized_recvDataSeq_0 = activation_in_data;
  assign _stem_conv_Conv_output_0_quantized_recvData = _stem_conv_Conv_output_0_quantized_recvDataSeq_0;
  assign _zz_22 = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b0000);
  assign _zz_23 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign _zz_24 = ((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit) && (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b0000));
  assign _zz_25 = (((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_22) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && _zz_23);
  assign _zz_27 = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b0001);
  assign _zz_28 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign _zz_29 = ((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit) && (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b0001));
  assign _zz_30 = (((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_27) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && _zz_28);
  assign _zz_32 = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b0010);
  assign _zz_33 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign _zz_34 = ((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit) && (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b0010));
  assign _zz_35 = (((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_32) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && _zz_33);
  assign _zz_37 = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b0011);
  assign _zz_38 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign _zz_39 = ((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit) && (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b0011));
  assign _zz_40 = (((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_37) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && _zz_38);
  assign _zz_42 = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b0100);
  assign _zz_43 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign _zz_44 = ((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit) && (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b0100));
  assign _zz_45 = (((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_42) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && _zz_43);
  assign _zz_47 = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b0101);
  assign _zz_48 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign _zz_49 = ((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit) && (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b0101));
  assign _zz_50 = (((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_47) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && _zz_48);
  assign _zz_52 = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b0110);
  assign _zz_53 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign _zz_54 = ((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit) && (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b0110));
  assign _zz_55 = (((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_52) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && _zz_53);
  assign _zz_57 = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b0111);
  assign _zz_58 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign _zz_59 = ((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit) && (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b0111));
  assign _zz_60 = (((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_57) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && _zz_58);
  assign _zz_62 = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b1000);
  assign _zz_63 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign _zz_64 = ((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit) && (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b1000));
  assign _zz_65 = (((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_62) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && _zz_63);
  assign _zz_67 = (_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b1001);
  assign _zz_68 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign _zz_69 = ((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit) && (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b1001));
  assign _zz_70 = (((((_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow) && _zz_67) && _stem_conv_Conv_output_0_quantized_isReal) && io_activationIn_fire) && _zz_68);
  always @(*) begin
    activation_in_ready = 1'b0;
    if(when_QLinearConvLineCore_l406) begin
      activation_in_ready = _stem_conv_Conv_output_0_quantized_isReal;
    end
  end

  always @(*) begin
    _stem_conv_Conv_output_0_quantized_activationOut_valid = 1'b0;
    if(when_QLinearConvLineCore_l596) begin
      _stem_conv_Conv_output_0_quantized_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    _stem_conv_Conv_output_0_quantized_activationOut_payload_value = _stem_conv_Conv_output_0_quantized_rqReg_2;
    if(when_QLinearConvLineCore_l596) begin
      _stem_conv_Conv_output_0_quantized_activationOut_payload_value = _stem_conv_Conv_output_0_quantized_rqReg_2;
    end
  end

  always @(*) begin
    _stem_conv_Conv_output_0_quantized_weightIn_ready = 1'b0;
    if(when_QLinearConvLineCore_l438) begin
      if(when_QLinearConvLineCore_l439) begin
        _stem_conv_Conv_output_0_quantized_weightIn_ready = 1'b1;
      end
    end
  end

  assign when_QLinearConvLineCore_l382 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sInit);
  assign when_QLinearConvLineCore_l384 = (_stem_conv_Conv_output_0_quantized_initAddrReg == 4'b1011);
  assign when_QLinearConvLineCore_l387 = (_stem_conv_Conv_output_0_quantized_initSlotReg == 4'b1001);
  assign when_QLinearConvLineCore_l406 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sReceiveRow);
  assign when_QLinearConvLineCore_l410 = ((_stem_conv_Conv_output_0_quantized_isReal && io_activationIn_fire) || (! _stem_conv_Conv_output_0_quantized_isReal));
  assign when_QLinearConvLineCore_l413 = (_stem_conv_Conv_output_0_quantized_rxBankReg == 1'b0);
  assign when_QLinearConvLineCore_l418 = (when_QLinearConvLineCore_l413 && (_stem_conv_Conv_output_0_quantized_rxWordReg == 4'b1001));
  assign when_QLinearConvLineCore_l424 = (_stem_conv_Conv_output_0_quantized_rowsUntilComputeReg <= 4'b0001);
  assign when_QLinearConvLineCore_l438 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sLoadWeights);
  assign when_QLinearConvLineCore_l439 = (! _stem_conv_Conv_output_0_quantized_wBeatDraining);
  assign _stem_conv_Conv_output_0_quantized_weightIn_fire = (_stem_conv_Conv_output_0_quantized_weightIn_valid && _stem_conv_Conv_output_0_quantized_weightIn_ready);
  assign when_QLinearConvLineCore_l448 = (_stem_conv_Conv_output_0_quantized_wStepReg < 6'h28);
  assign when_QLinearConvLineCore_l454 = (_stem_conv_Conv_output_0_quantized_wBeatStepReg == 7'h3f);
  assign when_QLinearConvLineCore_l456 = (6'h28 <= _stem_conv_Conv_output_0_quantized_wStepReg);
  assign when_QLinearConvLineCore_l466 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sLoadBias);
  assign _zz__stem_conv_Conv_output_0_quantized_rowAddrBaseReg = (_stem_conv_Conv_output_0_quantized_outColReg * 2'b10);
  assign when_QLinearConvLineCore_l479 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sWaitBias);
  assign when_QLinearConvLineCore_l485 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sCompute);
  assign when_QLinearConvLineCore_l489 = (_stem_conv_Conv_output_0_quantized_compCycleReg < 6'h28);
  assign _zz__stem_conv_Conv_output_0_quantized_curSlotReg = (_zz__zz__stem_conv_Conv_output_0_quantized_curSlotReg + _zz__zz__stem_conv_Conv_output_0_quantized_curSlotReg_1);
  assign when_QLinearConvLineCore_l493 = (_stem_conv_Conv_output_0_quantized_rowStepReg == 3'b011);
  assign when_QLinearConvLineCore_l505 = ((6'h01 <= _stem_conv_Conv_output_0_quantized_compCycleReg) && (_stem_conv_Conv_output_0_quantized_compCycleReg <= 6'h28));
  assign when_QLinearConvLineCore_l515 = ((6'h02 <= _stem_conv_Conv_output_0_quantized_compCycleReg) && (_stem_conv_Conv_output_0_quantized_compCycleReg <= 6'h29));
  assign when_QLinearConvLineCore_l532 = ((6'h03 <= _stem_conv_Conv_output_0_quantized_compCycleReg) && (_stem_conv_Conv_output_0_quantized_compCycleReg <= 6'h2a));
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_0 = ($signed(_stem_conv_Conv_output_0_quantized_rqReg_0) + $signed(_stem_conv_Conv_output_0_quantized_rqReg_1));
  assign when_QLinearConvLineCore_l535 = (_stem_conv_Conv_output_0_quantized_compCycleReg == 6'h2a);
  assign when_QLinearConvLineCore_l545 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sRequant);
  assign when_QLinearConvLineCore_l551 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sRequantMul);
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_9 = _stem_conv_Conv_output_0_quantized_rqReg_6[31 : 16];
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_7 = _stem_conv_Conv_output_0_quantized_rqReg_6[15 : 0];
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_8 = _stem_conv_Conv_output_0_quantized_reqMultVal[31 : 16];
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_7_1 = _stem_conv_Conv_output_0_quantized_reqMultVal[15 : 0];
  assign when_QLinearConvLineCore_l563 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sRequantWait);
  assign when_QLinearConvLineCore_l570 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sRequantWait2);
  assign when_QLinearConvLineCore_l576 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sRequantWait3);
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_4 = (_stem_conv_Conv_output_0_quantized_rqReg_14 + _stem_conv_Conv_output_0_quantized_rqReg_15);
  assign when_QLinearConvLineCore_l583 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sRequantShift);
  assign _zz__stem_conv_Conv_output_0_quantized_rqReg_2 = ($signed(_zz__zz__stem_conv_Conv_output_0_quantized_rqReg_2) + $signed(32'hffffff80));
  assign when_QLinearConvLineCore_l596 = (_stem_conv_Conv_output_0_quantized_stateReg == _stem_conv_Conv_output_0_quantized_sEmit);
  assign _stem_conv_Conv_output_0_quantized_activationOut_fire = (_stem_conv_Conv_output_0_quantized_activationOut_valid && _stem_conv_Conv_output_0_quantized_activationOut_ready);
  assign when_QLinearConvLineCore_l608 = (_stem_conv_Conv_output_0_quantized_outChReg == 7'h3f);
  assign when_QLinearConvLineCore_l612 = (_stem_conv_Conv_output_0_quantized_outColReg == 3'b100);
  assign when_QLinearConvLineCore_l616 = (_stem_conv_Conv_output_0_quantized_outRowReg == 5'h17);
  assign QLinearConvLineCorePlugin_logic_outStream_valid = _stem_conv_Conv_output_0_quantized_activationOut_valid;
  assign _stem_conv_Conv_output_0_quantized_activationOut_ready = QLinearConvLineCorePlugin_logic_outStream_ready;
  assign QLinearConvLineCorePlugin_logic_outStream_payload_value = _stem_conv_Conv_output_0_quantized_activationOut_payload_value;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sReceive = 4'b0000;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sLoadBias = 4'b0001;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sCompute = 4'b0010;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sRequant = 4'b0011;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantMul = 4'b0100;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait = 4'b0101;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait2 = 4'b0110;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait3 = 4'b0111;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantShift = 4'b1000;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sEmit = 4'b1001;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sInit = 4'b1010;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_sWaitBias = 4'b1011;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_inAddrComb = _blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_wAddrComb = _blocks_blocks_0_dw_Conv_output_0_quantized_wAddrReg;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inValR = _blocks_blocks_0_dw_Conv_output_0_quantized_inAddrComb;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_inValR = _blocks_blocks_0_dw_Conv_output_0_quantized_inputBuf_spinal_port0;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_wValR = _blocks_blocks_0_dw_Conv_output_0_quantized_wAddrComb;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_wValR = _blocks_blocks_0_dw_Conv_output_0_quantized_weightRom_spinal_port0;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_biasVal = _blocks_blocks_0_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_biasVal = _blocks_blocks_0_dw_Conv_output_0_quantized_biasRom_spinal_port0;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_0_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_0_dw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_0_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_0_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_doInit = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sInit);
  assign QLinearConvLineCorePlugin_logic_outStream_fire = (QLinearConvLineCorePlugin_logic_outStream_valid && QLinearConvLineCorePlugin_logic_outStream_ready);
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_doRecv = ((_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sReceive) && QLinearConvLineCorePlugin_logic_outStream_fire);
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_wrAddr = (_blocks_blocks_0_dw_Conv_output_0_quantized_doInit ? _blocks_blocks_0_dw_Conv_output_0_quantized_initAddrReg : _blocks_blocks_0_dw_Conv_output_0_quantized_padWriteAddrReg);
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_wrData = (_blocks_blocks_0_dw_Conv_output_0_quantized_doInit ? 8'h80 : QLinearConvLineCorePlugin_logic_outStream_payload_value);
  always @(*) begin
    QLinearConvLineCorePlugin_logic_outStream_ready = 1'b0;
    if(when_DepthwiseConvCore_l252) begin
      QLinearConvLineCorePlugin_logic_outStream_ready = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_valid = 1'b0;
    if(when_DepthwiseConvCore_l398) begin
      _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_0_dw_Conv_output_0_quantized_resultReg;
    if(when_DepthwiseConvCore_l398) begin
      _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_0_dw_Conv_output_0_quantized_resultReg;
    end
  end

  assign when_DepthwiseConvCore_l238 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sInit);
  assign when_DepthwiseConvCore_l240 = (_blocks_blocks_0_dw_Conv_output_0_quantized_initAddrReg == 14'h2d7f);
  assign when_DepthwiseConvCore_l252 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sReceive);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_padWriteAddrReg = (_blocks_blocks_0_dw_Conv_output_0_quantized_rowElemReg == 9'h13f);
  assign when_DepthwiseConvCore_l264 = (_blocks_blocks_0_dw_Conv_output_0_quantized_recvCntReg == 13'h1dff);
  assign when_DepthwiseConvCore_l278 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sLoadBias);
  assign when_DepthwiseConvCore_l289 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sWaitBias);
  assign when_DepthwiseConvCore_l303 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sCompute);
  assign when_DepthwiseConvCore_l307 = (_blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg < 4'b1001);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg = (_blocks_blocks_0_dw_Conv_output_0_quantized_rowStepReg == 2'b10);
  assign when_DepthwiseConvCore_l319 = ((4'b0001 <= _blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg <= 4'b1001));
  assign when_DepthwiseConvCore_l325 = ((4'b0010 <= _blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg <= 4'b1010));
  assign when_DepthwiseConvCore_l334 = ((4'b0011 <= _blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg <= 4'b1011));
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_accumReg = ($signed(_blocks_blocks_0_dw_Conv_output_0_quantized_accumReg) + $signed(_blocks_blocks_0_dw_Conv_output_0_quantized_prodReg));
  assign when_DepthwiseConvCore_l337 = (_blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg == 4'b1011);
  assign when_DepthwiseConvCore_l346 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sRequant);
  assign when_DepthwiseConvCore_l352 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantMul);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pHL_Reg = _blocks_blocks_0_dw_Conv_output_0_quantized_absAReg[31 : 16];
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg = _blocks_blocks_0_dw_Conv_output_0_quantized_absAReg[15 : 0];
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLH_Reg = _blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal[31 : 16];
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg_1 = _blocks_blocks_0_dw_Conv_output_0_quantized_reqMultVal[15 : 0];
  assign when_DepthwiseConvCore_l362 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait);
  assign when_DepthwiseConvCore_l368 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait2);
  assign when_DepthwiseConvCore_l374 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait3);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2 = (_blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg + _blocks_blocks_0_dw_Conv_output_0_quantized_part2Reg);
  assign when_DepthwiseConvCore_l381 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantShift);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg = ($signed(_zz__zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg) + $signed(32'hffffff80));
  assign when_DepthwiseConvCore_l398 = (_blocks_blocks_0_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_dw_Conv_output_0_quantized_sEmit);
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_fire = (_blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_valid && _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_ready);
  assign when_DepthwiseConvCore_l410 = (_blocks_blocks_0_dw_Conv_output_0_quantized_outChReg == 7'h3f);
  assign when_DepthwiseConvCore_l414 = (_blocks_blocks_0_dw_Conv_output_0_quantized_outColReg == 3'b100);
  assign _zz__blocks_blocks_0_dw_Conv_output_0_quantized_stateReg = (_blocks_blocks_0_dw_Conv_output_0_quantized_outRowReg == 5'h17);
  assign DepthwiseConvPlugin_logic_outStream_valid = _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_valid;
  assign _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_ready = DepthwiseConvPlugin_logic_outStream_ready;
  assign DepthwiseConvPlugin_logic_outStream_payload_value = _blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_payload_value;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_zpWideBits = {8'h80,{8'h80,{8'h80,{8'h80,{8'h80,{8'h80,{8'h80,8'h80}}}}}}};
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow = 4'b0000;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sLoadBias = 4'b0001;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sWaitBias = 4'b0010;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sCompute = 4'b0011;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sRequant = 4'b0100;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantMul = 4'b0101;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait = 4'b0110;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait2 = 4'b0111;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait3 = 4'b1000;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantShift = 4'b1001;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sEmit = 4'b1010;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sInit = 4'b1011;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_sLoadWeights = 4'b1100;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrComb = _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrReg;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_wAddrComb = _blocks_blocks_0_pw_Conv_output_0_quantized_wAddrReg;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rxAddr = (6'h0 + _blocks_blocks_0_pw_Conv_output_0_quantized_rxWordReg);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0 = _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrComb;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0 = _blocks_blocks_0_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_0 = _blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0[7 : 0];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_1 = _blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0[15 : 8];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_2 = _blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0[23 : 16];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_3 = _blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0[31 : 24];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_4 = _blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0[39 : 32];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_5 = _blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0[47 : 40];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_6 = _blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0[55 : 48];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_7 = _blocks_blocks_0_pw_Conv_output_0_quantized_rowWideReads_0[63 : 56];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw = _blocks_blocks_0_pw_Conv_output_0_quantized_wAddrComb;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw = _blocks_blocks_0_pw_Conv_output_0_quantized_weightBuf_spinal_port0;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_0 = _blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw[7 : 0];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_1 = _blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw[15 : 8];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_2 = _blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw[23 : 16];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_3 = _blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw[31 : 24];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_4 = _blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw[39 : 32];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_5 = _blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw[47 : 40];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_6 = _blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw[55 : 48];
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_7 = _blocks_blocks_0_pw_Conv_output_0_quantized_wDataRaw[63 : 56];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_biasVal = _blocks_blocks_0_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_biasVal = _blocks_blocks_0_pw_Conv_output_0_quantized_biasRom_spinal_port0;
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_0_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_0_pw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_0_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_0_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_isReal = (_blocks_blocks_0_pw_Conv_output_0_quantized_realRowsRecvReg < 5'h18);
  assign DepthwiseConvPlugin_logic_outStream_fire = (DepthwiseConvPlugin_logic_outStream_valid && DepthwiseConvPlugin_logic_outStream_ready);
  assign when_QLinearConvLineCore_l346_1 = ((((_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_0_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire) && (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg == 4'b0000));
  assign when_QLinearConvLineCore_l346_2 = ((((_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_0_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire) && (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg == 4'b0001));
  assign when_QLinearConvLineCore_l346_3 = ((((_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_0_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire) && (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg == 4'b0010));
  assign when_QLinearConvLineCore_l346_4 = ((((_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_0_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire) && (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg == 4'b0011));
  assign when_QLinearConvLineCore_l346_5 = ((((_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_0_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire) && (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg == 4'b0100));
  assign when_QLinearConvLineCore_l346_6 = ((((_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_0_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire) && (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg == 4'b0101));
  assign when_QLinearConvLineCore_l346_7 = ((((_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_0_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire) && (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg == 4'b0110));
  assign when_QLinearConvLineCore_l346_8 = ((((_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_0_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire) && (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg == 4'b0111));
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_recvDataSeq_7 = DepthwiseConvPlugin_logic_outStream_payload_value;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_recvData = {_blocks_blocks_0_pw_Conv_output_0_quantized_recvDataSeq_7,{_blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_6,{_blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_5,{_blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_4,{_blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_3,{_blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_2,{_blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_1,_blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_0}}}}}}};
  assign _zz_84 = (_blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg == 1'b0);
  assign _zz_85 = (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg == 4'b0111);
  assign _zz_86 = 1'b0;
  assign _zz_87 = (((((_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow) && _zz_84) && _blocks_blocks_0_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire) && _zz_85);
  always @(*) begin
    DepthwiseConvPlugin_logic_outStream_ready = 1'b0;
    if(when_QLinearConvLineCore_l406_1) begin
      DepthwiseConvPlugin_logic_outStream_ready = _blocks_blocks_0_pw_Conv_output_0_quantized_isReal;
    end
  end

  always @(*) begin
    _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_valid = 1'b0;
    if(when_QLinearConvLineCore_l596_1) begin
      _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2;
    if(when_QLinearConvLineCore_l596_1) begin
      _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2;
    end
  end

  always @(*) begin
    _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_ready = 1'b0;
    if(when_QLinearConvLineCore_l438_1) begin
      if(when_QLinearConvLineCore_l439_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_ready = 1'b1;
      end
    end
  end

  assign when_QLinearConvLineCore_l406_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow);
  assign when_QLinearConvLineCore_l410_1 = ((_blocks_blocks_0_pw_Conv_output_0_quantized_isReal && DepthwiseConvPlugin_logic_outStream_fire) || (! _blocks_blocks_0_pw_Conv_output_0_quantized_isReal));
  assign when_QLinearConvLineCore_l413_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg == 4'b0111);
  assign when_QLinearConvLineCore_l418_1 = (when_QLinearConvLineCore_l413_1 && (_blocks_blocks_0_pw_Conv_output_0_quantized_rxWordReg == 6'h27));
  assign when_QLinearConvLineCore_l424_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1);
  assign when_QLinearConvLineCore_l438_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sLoadWeights);
  assign when_QLinearConvLineCore_l439_1 = (! _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatDraining);
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_fire = (_blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_valid && _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_ready);
  assign when_QLinearConvLineCore_l448_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_wStepReg < 4'b1000);
  assign when_QLinearConvLineCore_l454_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_wBeatStepReg == 4'b0111);
  assign when_QLinearConvLineCore_l456_1 = (4'b1000 <= _blocks_blocks_0_pw_Conv_output_0_quantized_wStepReg);
  assign when_QLinearConvLineCore_l466_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sLoadBias);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrBaseReg = (_blocks_blocks_0_pw_Conv_output_0_quantized_outColReg * 4'b1000);
  assign when_QLinearConvLineCore_l479_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sWaitBias);
  assign when_QLinearConvLineCore_l485_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sCompute);
  assign when_QLinearConvLineCore_l489_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg < 4'b1000);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg = (_zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg + _zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_1);
  assign when_QLinearConvLineCore_l493_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_rowStepReg == 4'b0111);
  assign when_QLinearConvLineCore_l505_1 = ((4'b0001 <= _blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg <= 4'b1000));
  assign when_QLinearConvLineCore_l515_1 = ((4'b0010 <= _blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg <= 4'b1001));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1 = 9'h180;
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_1 = 9'h0;
  assign when_QLinearConvLineCore_l532_1 = ((4'b0011 <= _blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg <= 4'b1010));
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_0 = ($signed(_blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_0) + $signed(_blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1));
  assign when_QLinearConvLineCore_l535_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg == 4'b1010);
  assign when_QLinearConvLineCore_l545_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sRequant);
  assign when_QLinearConvLineCore_l551_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantMul);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_9 = _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6[31 : 16];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7 = _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6[15 : 0];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_8 = _blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal[31 : 16];
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7_1 = _blocks_blocks_0_pw_Conv_output_0_quantized_reqMultVal[15 : 0];
  assign when_QLinearConvLineCore_l563_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait);
  assign when_QLinearConvLineCore_l570_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait2);
  assign when_QLinearConvLineCore_l576_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait3);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4 = (_blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14 + _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_15);
  assign when_QLinearConvLineCore_l583_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantShift);
  assign _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2 = ($signed(_zz__zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2) + $signed(32'hffffff80));
  assign when_QLinearConvLineCore_l596_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_0_pw_Conv_output_0_quantized_sEmit);
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_fire = (_blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_valid && _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_ready);
  assign when_QLinearConvLineCore_l608_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_outChReg == 7'h3f);
  assign when_QLinearConvLineCore_l612_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_outColReg == 3'b100);
  assign when_QLinearConvLineCore_l616_1 = (_blocks_blocks_0_pw_Conv_output_0_quantized_outRowReg == 5'h17);
  assign QLinearConvLineCorePlugin_logic_outStream_valid_1 = _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_valid;
  assign _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_ready = QLinearConvLineCorePlugin_logic_outStream_ready_1;
  assign QLinearConvLineCorePlugin_logic_outStream_payload_value_1 = _blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_payload_value;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sReceive = 4'b0000;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sLoadBias = 4'b0001;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sCompute = 4'b0010;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sRequant = 4'b0011;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantMul = 4'b0100;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait = 4'b0101;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait2 = 4'b0110;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait3 = 4'b0111;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantShift = 4'b1000;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sEmit = 4'b1001;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sInit = 4'b1010;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_sWaitBias = 4'b1011;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_inAddrComb = _blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_wAddrComb = _blocks_blocks_1_dw_Conv_output_0_quantized_wAddrReg;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inValR = _blocks_blocks_1_dw_Conv_output_0_quantized_inAddrComb;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_inValR = _blocks_blocks_1_dw_Conv_output_0_quantized_inputBuf_spinal_port0;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_wValR = _blocks_blocks_1_dw_Conv_output_0_quantized_wAddrComb;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_wValR = _blocks_blocks_1_dw_Conv_output_0_quantized_weightRom_spinal_port0;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_biasVal = _blocks_blocks_1_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_biasVal = _blocks_blocks_1_dw_Conv_output_0_quantized_biasRom_spinal_port0;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_1_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_1_dw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_1_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_1_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_doInit = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sInit);
  assign QLinearConvLineCorePlugin_logic_outStream_fire_1 = (QLinearConvLineCorePlugin_logic_outStream_valid_1 && QLinearConvLineCorePlugin_logic_outStream_ready_1);
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_doRecv = ((_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sReceive) && QLinearConvLineCorePlugin_logic_outStream_fire_1);
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_wrAddr = (_blocks_blocks_1_dw_Conv_output_0_quantized_doInit ? _blocks_blocks_1_dw_Conv_output_0_quantized_initAddrReg : _blocks_blocks_1_dw_Conv_output_0_quantized_padWriteAddrReg);
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_wrData = (_blocks_blocks_1_dw_Conv_output_0_quantized_doInit ? 8'h80 : QLinearConvLineCorePlugin_logic_outStream_payload_value_1);
  always @(*) begin
    QLinearConvLineCorePlugin_logic_outStream_ready_1 = 1'b0;
    if(when_DepthwiseConvCore_l252_1) begin
      QLinearConvLineCorePlugin_logic_outStream_ready_1 = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_valid = 1'b0;
    if(when_DepthwiseConvCore_l398_1) begin
      _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_1_dw_Conv_output_0_quantized_resultReg;
    if(when_DepthwiseConvCore_l398_1) begin
      _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_1_dw_Conv_output_0_quantized_resultReg;
    end
  end

  assign when_DepthwiseConvCore_l238_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sInit);
  assign when_DepthwiseConvCore_l240_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_initAddrReg == 14'h2d7f);
  assign when_DepthwiseConvCore_l252_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sReceive);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_padWriteAddrReg = (_blocks_blocks_1_dw_Conv_output_0_quantized_rowElemReg == 9'h13f);
  assign when_DepthwiseConvCore_l264_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_recvCntReg == 13'h1dff);
  assign when_DepthwiseConvCore_l278_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sLoadBias);
  assign when_DepthwiseConvCore_l289_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sWaitBias);
  assign when_DepthwiseConvCore_l303_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sCompute);
  assign when_DepthwiseConvCore_l307_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg < 4'b1001);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg = (_blocks_blocks_1_dw_Conv_output_0_quantized_rowStepReg == 2'b10);
  assign when_DepthwiseConvCore_l319_1 = ((4'b0001 <= _blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg <= 4'b1001));
  assign when_DepthwiseConvCore_l325_1 = ((4'b0010 <= _blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg <= 4'b1010));
  assign when_DepthwiseConvCore_l334_1 = ((4'b0011 <= _blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg <= 4'b1011));
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_accumReg = ($signed(_blocks_blocks_1_dw_Conv_output_0_quantized_accumReg) + $signed(_blocks_blocks_1_dw_Conv_output_0_quantized_prodReg));
  assign when_DepthwiseConvCore_l337_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg == 4'b1011);
  assign when_DepthwiseConvCore_l346_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sRequant);
  assign when_DepthwiseConvCore_l352_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantMul);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pHL_Reg = _blocks_blocks_1_dw_Conv_output_0_quantized_absAReg[31 : 16];
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg = _blocks_blocks_1_dw_Conv_output_0_quantized_absAReg[15 : 0];
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLH_Reg = _blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal[31 : 16];
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg_1 = _blocks_blocks_1_dw_Conv_output_0_quantized_reqMultVal[15 : 0];
  assign when_DepthwiseConvCore_l362_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait);
  assign when_DepthwiseConvCore_l368_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait2);
  assign when_DepthwiseConvCore_l374_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait3);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2 = (_blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg + _blocks_blocks_1_dw_Conv_output_0_quantized_part2Reg);
  assign when_DepthwiseConvCore_l381_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantShift);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg = ($signed(_zz__zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg) + $signed(32'hffffff80));
  assign when_DepthwiseConvCore_l398_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_dw_Conv_output_0_quantized_sEmit);
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_fire = (_blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_valid && _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_ready);
  assign when_DepthwiseConvCore_l410_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_outChReg == 7'h3f);
  assign when_DepthwiseConvCore_l414_1 = (_blocks_blocks_1_dw_Conv_output_0_quantized_outColReg == 3'b100);
  assign _zz__blocks_blocks_1_dw_Conv_output_0_quantized_stateReg = (_blocks_blocks_1_dw_Conv_output_0_quantized_outRowReg == 5'h17);
  assign DepthwiseConvPlugin_logic_outStream_valid_1 = _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_valid;
  assign _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_ready = DepthwiseConvPlugin_logic_outStream_ready_1;
  assign DepthwiseConvPlugin_logic_outStream_payload_value_1 = _blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_payload_value;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_zpWideBits = {8'h80,{8'h80,{8'h80,{8'h80,{8'h80,{8'h80,{8'h80,8'h80}}}}}}};
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow = 4'b0000;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sLoadBias = 4'b0001;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sWaitBias = 4'b0010;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sCompute = 4'b0011;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sRequant = 4'b0100;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantMul = 4'b0101;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait = 4'b0110;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait2 = 4'b0111;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait3 = 4'b1000;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantShift = 4'b1001;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sEmit = 4'b1010;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sInit = 4'b1011;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_sLoadWeights = 4'b1100;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrComb = _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrReg;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_wAddrComb = _blocks_blocks_1_pw_Conv_output_0_quantized_wAddrReg;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rxAddr = (6'h0 + _blocks_blocks_1_pw_Conv_output_0_quantized_rxWordReg);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0 = _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrComb;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0 = _blocks_blocks_1_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_0 = _blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0[7 : 0];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_1 = _blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0[15 : 8];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_2 = _blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0[23 : 16];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_3 = _blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0[31 : 24];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_4 = _blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0[39 : 32];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_5 = _blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0[47 : 40];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_6 = _blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0[55 : 48];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_7 = _blocks_blocks_1_pw_Conv_output_0_quantized_rowWideReads_0[63 : 56];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw = _blocks_blocks_1_pw_Conv_output_0_quantized_wAddrComb;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw = _blocks_blocks_1_pw_Conv_output_0_quantized_weightBuf_spinal_port0;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_0 = _blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw[7 : 0];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_1 = _blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw[15 : 8];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_2 = _blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw[23 : 16];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_3 = _blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw[31 : 24];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_4 = _blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw[39 : 32];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_5 = _blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw[47 : 40];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_6 = _blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw[55 : 48];
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_7 = _blocks_blocks_1_pw_Conv_output_0_quantized_wDataRaw[63 : 56];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_biasVal = _blocks_blocks_1_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_biasVal = _blocks_blocks_1_pw_Conv_output_0_quantized_biasRom_spinal_port0;
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_1_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_1_pw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_1_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_1_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_isReal = (_blocks_blocks_1_pw_Conv_output_0_quantized_realRowsRecvReg < 5'h18);
  assign DepthwiseConvPlugin_logic_outStream_fire_1 = (DepthwiseConvPlugin_logic_outStream_valid_1 && DepthwiseConvPlugin_logic_outStream_ready_1);
  assign when_QLinearConvLineCore_l346_9 = ((((_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_1_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_1) && (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg == 4'b0000));
  assign when_QLinearConvLineCore_l346_10 = ((((_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_1_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_1) && (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg == 4'b0001));
  assign when_QLinearConvLineCore_l346_11 = ((((_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_1_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_1) && (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg == 4'b0010));
  assign when_QLinearConvLineCore_l346_12 = ((((_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_1_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_1) && (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg == 4'b0011));
  assign when_QLinearConvLineCore_l346_13 = ((((_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_1_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_1) && (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg == 4'b0100));
  assign when_QLinearConvLineCore_l346_14 = ((((_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_1_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_1) && (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg == 4'b0101));
  assign when_QLinearConvLineCore_l346_15 = ((((_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_1_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_1) && (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg == 4'b0110));
  assign when_QLinearConvLineCore_l346_16 = ((((_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_1_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_1) && (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg == 4'b0111));
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_recvDataSeq_7 = DepthwiseConvPlugin_logic_outStream_payload_value_1;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_recvData = {_blocks_blocks_1_pw_Conv_output_0_quantized_recvDataSeq_7,{_blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_6,{_blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_5,{_blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_4,{_blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_3,{_blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_2,{_blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_1,_blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_0}}}}}}};
  assign _zz_101 = (_blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg == 1'b0);
  assign _zz_102 = (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg == 4'b0111);
  assign _zz_103 = 1'b0;
  assign _zz_104 = (((((_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow) && _zz_101) && _blocks_blocks_1_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_1) && _zz_102);
  always @(*) begin
    DepthwiseConvPlugin_logic_outStream_ready_1 = 1'b0;
    if(when_QLinearConvLineCore_l406_2) begin
      DepthwiseConvPlugin_logic_outStream_ready_1 = _blocks_blocks_1_pw_Conv_output_0_quantized_isReal;
    end
  end

  always @(*) begin
    _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_valid = 1'b0;
    if(when_QLinearConvLineCore_l596_2) begin
      _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2;
    if(when_QLinearConvLineCore_l596_2) begin
      _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2;
    end
  end

  always @(*) begin
    _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_ready = 1'b0;
    if(when_QLinearConvLineCore_l438_2) begin
      if(when_QLinearConvLineCore_l439_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_ready = 1'b1;
      end
    end
  end

  assign when_QLinearConvLineCore_l406_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow);
  assign when_QLinearConvLineCore_l410_2 = ((_blocks_blocks_1_pw_Conv_output_0_quantized_isReal && DepthwiseConvPlugin_logic_outStream_fire_1) || (! _blocks_blocks_1_pw_Conv_output_0_quantized_isReal));
  assign when_QLinearConvLineCore_l413_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg == 4'b0111);
  assign when_QLinearConvLineCore_l418_2 = (when_QLinearConvLineCore_l413_2 && (_blocks_blocks_1_pw_Conv_output_0_quantized_rxWordReg == 6'h27));
  assign when_QLinearConvLineCore_l424_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1);
  assign when_QLinearConvLineCore_l438_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sLoadWeights);
  assign when_QLinearConvLineCore_l439_2 = (! _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatDraining);
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_fire = (_blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_valid && _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_ready);
  assign when_QLinearConvLineCore_l448_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_wStepReg < 4'b1000);
  assign when_QLinearConvLineCore_l454_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_wBeatStepReg == 4'b0111);
  assign when_QLinearConvLineCore_l456_2 = (4'b1000 <= _blocks_blocks_1_pw_Conv_output_0_quantized_wStepReg);
  assign when_QLinearConvLineCore_l466_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sLoadBias);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrBaseReg = (_blocks_blocks_1_pw_Conv_output_0_quantized_outColReg * 4'b1000);
  assign when_QLinearConvLineCore_l479_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sWaitBias);
  assign when_QLinearConvLineCore_l485_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sCompute);
  assign when_QLinearConvLineCore_l489_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg < 4'b1000);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg = (_zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg + _zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_1);
  assign when_QLinearConvLineCore_l493_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_rowStepReg == 4'b0111);
  assign when_QLinearConvLineCore_l505_2 = ((4'b0001 <= _blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg <= 4'b1000));
  assign when_QLinearConvLineCore_l515_2 = ((4'b0010 <= _blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg <= 4'b1001));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1 = 9'h180;
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_1 = 9'h0;
  assign when_QLinearConvLineCore_l532_2 = ((4'b0011 <= _blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg <= 4'b1010));
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_0 = ($signed(_blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_0) + $signed(_blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1));
  assign when_QLinearConvLineCore_l535_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg == 4'b1010);
  assign when_QLinearConvLineCore_l545_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sRequant);
  assign when_QLinearConvLineCore_l551_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantMul);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_9 = _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6[31 : 16];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7 = _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6[15 : 0];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_8 = _blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal[31 : 16];
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7_1 = _blocks_blocks_1_pw_Conv_output_0_quantized_reqMultVal[15 : 0];
  assign when_QLinearConvLineCore_l563_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait);
  assign when_QLinearConvLineCore_l570_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait2);
  assign when_QLinearConvLineCore_l576_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait3);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4 = (_blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14 + _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_15);
  assign when_QLinearConvLineCore_l583_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantShift);
  assign _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2 = ($signed(_zz__zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2) + $signed(32'hffffff80));
  assign when_QLinearConvLineCore_l596_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_1_pw_Conv_output_0_quantized_sEmit);
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_fire = (_blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_valid && _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_ready);
  assign when_QLinearConvLineCore_l608_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_outChReg == 7'h3f);
  assign when_QLinearConvLineCore_l612_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_outColReg == 3'b100);
  assign when_QLinearConvLineCore_l616_2 = (_blocks_blocks_1_pw_Conv_output_0_quantized_outRowReg == 5'h17);
  assign QLinearConvLineCorePlugin_logic_outStream_valid_2 = _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_valid;
  assign _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_ready = QLinearConvLineCorePlugin_logic_outStream_ready_2;
  assign QLinearConvLineCorePlugin_logic_outStream_payload_value_2 = _blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_payload_value;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sReceive = 4'b0000;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sLoadBias = 4'b0001;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sCompute = 4'b0010;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sRequant = 4'b0011;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantMul = 4'b0100;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait = 4'b0101;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait2 = 4'b0110;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait3 = 4'b0111;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantShift = 4'b1000;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sEmit = 4'b1001;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sInit = 4'b1010;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_sWaitBias = 4'b1011;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_inAddrComb = _blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_wAddrComb = _blocks_blocks_2_dw_Conv_output_0_quantized_wAddrReg;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inValR = _blocks_blocks_2_dw_Conv_output_0_quantized_inAddrComb;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_inValR = _blocks_blocks_2_dw_Conv_output_0_quantized_inputBuf_spinal_port0;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_wValR = _blocks_blocks_2_dw_Conv_output_0_quantized_wAddrComb;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_wValR = _blocks_blocks_2_dw_Conv_output_0_quantized_weightRom_spinal_port0;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_biasVal = _blocks_blocks_2_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_biasVal = _blocks_blocks_2_dw_Conv_output_0_quantized_biasRom_spinal_port0;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_2_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_2_dw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_2_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_2_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_doInit = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sInit);
  assign QLinearConvLineCorePlugin_logic_outStream_fire_2 = (QLinearConvLineCorePlugin_logic_outStream_valid_2 && QLinearConvLineCorePlugin_logic_outStream_ready_2);
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_doRecv = ((_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sReceive) && QLinearConvLineCorePlugin_logic_outStream_fire_2);
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_wrAddr = (_blocks_blocks_2_dw_Conv_output_0_quantized_doInit ? _blocks_blocks_2_dw_Conv_output_0_quantized_initAddrReg : _blocks_blocks_2_dw_Conv_output_0_quantized_padWriteAddrReg);
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_wrData = (_blocks_blocks_2_dw_Conv_output_0_quantized_doInit ? 8'h80 : QLinearConvLineCorePlugin_logic_outStream_payload_value_2);
  always @(*) begin
    QLinearConvLineCorePlugin_logic_outStream_ready_2 = 1'b0;
    if(when_DepthwiseConvCore_l252_2) begin
      QLinearConvLineCorePlugin_logic_outStream_ready_2 = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_valid = 1'b0;
    if(when_DepthwiseConvCore_l398_2) begin
      _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_2_dw_Conv_output_0_quantized_resultReg;
    if(when_DepthwiseConvCore_l398_2) begin
      _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_2_dw_Conv_output_0_quantized_resultReg;
    end
  end

  assign when_DepthwiseConvCore_l238_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sInit);
  assign when_DepthwiseConvCore_l240_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_initAddrReg == 14'h2d7f);
  assign when_DepthwiseConvCore_l252_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sReceive);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_padWriteAddrReg = (_blocks_blocks_2_dw_Conv_output_0_quantized_rowElemReg == 9'h13f);
  assign when_DepthwiseConvCore_l264_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_recvCntReg == 13'h1dff);
  assign when_DepthwiseConvCore_l278_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sLoadBias);
  assign when_DepthwiseConvCore_l289_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sWaitBias);
  assign when_DepthwiseConvCore_l303_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sCompute);
  assign when_DepthwiseConvCore_l307_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg < 4'b1001);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg = (_blocks_blocks_2_dw_Conv_output_0_quantized_rowStepReg == 2'b10);
  assign when_DepthwiseConvCore_l319_2 = ((4'b0001 <= _blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg <= 4'b1001));
  assign when_DepthwiseConvCore_l325_2 = ((4'b0010 <= _blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg <= 4'b1010));
  assign when_DepthwiseConvCore_l334_2 = ((4'b0011 <= _blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg <= 4'b1011));
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_accumReg = ($signed(_blocks_blocks_2_dw_Conv_output_0_quantized_accumReg) + $signed(_blocks_blocks_2_dw_Conv_output_0_quantized_prodReg));
  assign when_DepthwiseConvCore_l337_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg == 4'b1011);
  assign when_DepthwiseConvCore_l346_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sRequant);
  assign when_DepthwiseConvCore_l352_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantMul);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pHL_Reg = _blocks_blocks_2_dw_Conv_output_0_quantized_absAReg[31 : 16];
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg = _blocks_blocks_2_dw_Conv_output_0_quantized_absAReg[15 : 0];
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLH_Reg = _blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal[31 : 16];
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg_1 = _blocks_blocks_2_dw_Conv_output_0_quantized_reqMultVal[15 : 0];
  assign when_DepthwiseConvCore_l362_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait);
  assign when_DepthwiseConvCore_l368_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait2);
  assign when_DepthwiseConvCore_l374_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait3);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg + _blocks_blocks_2_dw_Conv_output_0_quantized_part2Reg);
  assign when_DepthwiseConvCore_l381_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantShift);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg = ($signed(_zz__zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg) + $signed(32'hffffff80));
  assign when_DepthwiseConvCore_l398_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_dw_Conv_output_0_quantized_sEmit);
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_fire = (_blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_valid && _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_ready);
  assign when_DepthwiseConvCore_l410_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_outChReg == 7'h3f);
  assign when_DepthwiseConvCore_l414_2 = (_blocks_blocks_2_dw_Conv_output_0_quantized_outColReg == 3'b100);
  assign _zz__blocks_blocks_2_dw_Conv_output_0_quantized_stateReg = (_blocks_blocks_2_dw_Conv_output_0_quantized_outRowReg == 5'h17);
  assign DepthwiseConvPlugin_logic_outStream_valid_2 = _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_valid;
  assign _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_ready = DepthwiseConvPlugin_logic_outStream_ready_2;
  assign DepthwiseConvPlugin_logic_outStream_payload_value_2 = _blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_payload_value;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_zpWideBits = {8'h80,{8'h80,{8'h80,{8'h80,{8'h80,{8'h80,{8'h80,8'h80}}}}}}};
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow = 4'b0000;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sLoadBias = 4'b0001;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sWaitBias = 4'b0010;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sCompute = 4'b0011;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sRequant = 4'b0100;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantMul = 4'b0101;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait = 4'b0110;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait2 = 4'b0111;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait3 = 4'b1000;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantShift = 4'b1001;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sEmit = 4'b1010;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sInit = 4'b1011;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_sLoadWeights = 4'b1100;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrComb = _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrReg;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_wAddrComb = _blocks_blocks_2_pw_Conv_output_0_quantized_wAddrReg;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rxAddr = (6'h0 + _blocks_blocks_2_pw_Conv_output_0_quantized_rxWordReg);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0 = _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrComb;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0 = _blocks_blocks_2_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_0 = _blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0[7 : 0];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_1 = _blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0[15 : 8];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_2 = _blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0[23 : 16];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_3 = _blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0[31 : 24];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_4 = _blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0[39 : 32];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_5 = _blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0[47 : 40];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_6 = _blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0[55 : 48];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_7 = _blocks_blocks_2_pw_Conv_output_0_quantized_rowWideReads_0[63 : 56];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw = _blocks_blocks_2_pw_Conv_output_0_quantized_wAddrComb;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw = _blocks_blocks_2_pw_Conv_output_0_quantized_weightBuf_spinal_port0;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_0 = _blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw[7 : 0];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_1 = _blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw[15 : 8];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_2 = _blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw[23 : 16];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_3 = _blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw[31 : 24];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_4 = _blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw[39 : 32];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_5 = _blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw[47 : 40];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_6 = _blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw[55 : 48];
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_7 = _blocks_blocks_2_pw_Conv_output_0_quantized_wDataRaw[63 : 56];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_biasVal = _blocks_blocks_2_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_biasVal = _blocks_blocks_2_pw_Conv_output_0_quantized_biasRom_spinal_port0;
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_2_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_2_pw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_2_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_2_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_isReal = (_blocks_blocks_2_pw_Conv_output_0_quantized_realRowsRecvReg < 5'h18);
  assign DepthwiseConvPlugin_logic_outStream_fire_2 = (DepthwiseConvPlugin_logic_outStream_valid_2 && DepthwiseConvPlugin_logic_outStream_ready_2);
  assign when_QLinearConvLineCore_l346_17 = ((((_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_2_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_2) && (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg == 4'b0000));
  assign when_QLinearConvLineCore_l346_18 = ((((_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_2_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_2) && (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg == 4'b0001));
  assign when_QLinearConvLineCore_l346_19 = ((((_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_2_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_2) && (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg == 4'b0010));
  assign when_QLinearConvLineCore_l346_20 = ((((_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_2_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_2) && (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg == 4'b0011));
  assign when_QLinearConvLineCore_l346_21 = ((((_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_2_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_2) && (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg == 4'b0100));
  assign when_QLinearConvLineCore_l346_22 = ((((_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_2_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_2) && (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg == 4'b0101));
  assign when_QLinearConvLineCore_l346_23 = ((((_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_2_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_2) && (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg == 4'b0110));
  assign when_QLinearConvLineCore_l346_24 = ((((_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_2_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_2) && (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg == 4'b0111));
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_recvDataSeq_7 = DepthwiseConvPlugin_logic_outStream_payload_value_2;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_recvData = {_blocks_blocks_2_pw_Conv_output_0_quantized_recvDataSeq_7,{_blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_6,{_blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_5,{_blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_4,{_blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_3,{_blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_2,{_blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_1,_blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_0}}}}}}};
  assign _zz_118 = (_blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg == 1'b0);
  assign _zz_119 = (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg == 4'b0111);
  assign _zz_120 = 1'b0;
  assign _zz_121 = (((((_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow) && _zz_118) && _blocks_blocks_2_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_2) && _zz_119);
  always @(*) begin
    DepthwiseConvPlugin_logic_outStream_ready_2 = 1'b0;
    if(when_QLinearConvLineCore_l406_3) begin
      DepthwiseConvPlugin_logic_outStream_ready_2 = _blocks_blocks_2_pw_Conv_output_0_quantized_isReal;
    end
  end

  always @(*) begin
    _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_valid = 1'b0;
    if(when_QLinearConvLineCore_l596_3) begin
      _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2;
    if(when_QLinearConvLineCore_l596_3) begin
      _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2;
    end
  end

  always @(*) begin
    _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_ready = 1'b0;
    if(when_QLinearConvLineCore_l438_3) begin
      if(when_QLinearConvLineCore_l439_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_ready = 1'b1;
      end
    end
  end

  assign when_QLinearConvLineCore_l406_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow);
  assign when_QLinearConvLineCore_l410_3 = ((_blocks_blocks_2_pw_Conv_output_0_quantized_isReal && DepthwiseConvPlugin_logic_outStream_fire_2) || (! _blocks_blocks_2_pw_Conv_output_0_quantized_isReal));
  assign when_QLinearConvLineCore_l413_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg == 4'b0111);
  assign when_QLinearConvLineCore_l418_3 = (when_QLinearConvLineCore_l413_3 && (_blocks_blocks_2_pw_Conv_output_0_quantized_rxWordReg == 6'h27));
  assign when_QLinearConvLineCore_l424_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1);
  assign when_QLinearConvLineCore_l438_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sLoadWeights);
  assign when_QLinearConvLineCore_l439_3 = (! _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatDraining);
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_fire = (_blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_valid && _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_ready);
  assign when_QLinearConvLineCore_l448_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_wStepReg < 4'b1000);
  assign when_QLinearConvLineCore_l454_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_wBeatStepReg == 4'b0111);
  assign when_QLinearConvLineCore_l456_3 = (4'b1000 <= _blocks_blocks_2_pw_Conv_output_0_quantized_wStepReg);
  assign when_QLinearConvLineCore_l466_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sLoadBias);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrBaseReg = (_blocks_blocks_2_pw_Conv_output_0_quantized_outColReg * 4'b1000);
  assign when_QLinearConvLineCore_l479_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sWaitBias);
  assign when_QLinearConvLineCore_l485_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sCompute);
  assign when_QLinearConvLineCore_l489_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg < 4'b1000);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg = (_zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg + _zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_1);
  assign when_QLinearConvLineCore_l493_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_rowStepReg == 4'b0111);
  assign when_QLinearConvLineCore_l505_3 = ((4'b0001 <= _blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg <= 4'b1000));
  assign when_QLinearConvLineCore_l515_3 = ((4'b0010 <= _blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg <= 4'b1001));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1 = 9'h180;
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_1 = 9'h0;
  assign when_QLinearConvLineCore_l532_3 = ((4'b0011 <= _blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg <= 4'b1010));
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_0 = ($signed(_blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_0) + $signed(_blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1));
  assign when_QLinearConvLineCore_l535_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg == 4'b1010);
  assign when_QLinearConvLineCore_l545_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sRequant);
  assign when_QLinearConvLineCore_l551_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantMul);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_9 = _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6[31 : 16];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7 = _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6[15 : 0];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_8 = _blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal[31 : 16];
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7_1 = _blocks_blocks_2_pw_Conv_output_0_quantized_reqMultVal[15 : 0];
  assign when_QLinearConvLineCore_l563_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait);
  assign when_QLinearConvLineCore_l570_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait2);
  assign when_QLinearConvLineCore_l576_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait3);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4 = (_blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14 + _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_15);
  assign when_QLinearConvLineCore_l583_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantShift);
  assign _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2 = ($signed(_zz__zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2) + $signed(32'hffffff80));
  assign when_QLinearConvLineCore_l596_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_2_pw_Conv_output_0_quantized_sEmit);
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_fire = (_blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_valid && _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_ready);
  assign when_QLinearConvLineCore_l608_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_outChReg == 7'h3f);
  assign when_QLinearConvLineCore_l612_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_outColReg == 3'b100);
  assign when_QLinearConvLineCore_l616_3 = (_blocks_blocks_2_pw_Conv_output_0_quantized_outRowReg == 5'h17);
  assign QLinearConvLineCorePlugin_logic_outStream_valid_3 = _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_valid;
  assign _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_ready = QLinearConvLineCorePlugin_logic_outStream_ready_3;
  assign QLinearConvLineCorePlugin_logic_outStream_payload_value_3 = _blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_payload_value;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sReceive = 4'b0000;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sLoadBias = 4'b0001;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sCompute = 4'b0010;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sRequant = 4'b0011;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantMul = 4'b0100;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait = 4'b0101;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait2 = 4'b0110;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait3 = 4'b0111;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantShift = 4'b1000;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sEmit = 4'b1001;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sInit = 4'b1010;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_sWaitBias = 4'b1011;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_inAddrComb = _blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_wAddrComb = _blocks_blocks_3_dw_Conv_output_0_quantized_wAddrReg;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inValR = _blocks_blocks_3_dw_Conv_output_0_quantized_inAddrComb;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_inValR = _blocks_blocks_3_dw_Conv_output_0_quantized_inputBuf_spinal_port0;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_wValR = _blocks_blocks_3_dw_Conv_output_0_quantized_wAddrComb;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_wValR = _blocks_blocks_3_dw_Conv_output_0_quantized_weightRom_spinal_port0;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_biasVal = _blocks_blocks_3_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_biasVal = _blocks_blocks_3_dw_Conv_output_0_quantized_biasRom_spinal_port0;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_3_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_3_dw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_3_dw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_3_dw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_doInit = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sInit);
  assign QLinearConvLineCorePlugin_logic_outStream_fire_3 = (QLinearConvLineCorePlugin_logic_outStream_valid_3 && QLinearConvLineCorePlugin_logic_outStream_ready_3);
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_doRecv = ((_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sReceive) && QLinearConvLineCorePlugin_logic_outStream_fire_3);
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_wrAddr = (_blocks_blocks_3_dw_Conv_output_0_quantized_doInit ? _blocks_blocks_3_dw_Conv_output_0_quantized_initAddrReg : _blocks_blocks_3_dw_Conv_output_0_quantized_padWriteAddrReg);
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_wrData = (_blocks_blocks_3_dw_Conv_output_0_quantized_doInit ? 8'h80 : QLinearConvLineCorePlugin_logic_outStream_payload_value_3);
  always @(*) begin
    QLinearConvLineCorePlugin_logic_outStream_ready_3 = 1'b0;
    if(when_DepthwiseConvCore_l252_3) begin
      QLinearConvLineCorePlugin_logic_outStream_ready_3 = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_valid = 1'b0;
    if(when_DepthwiseConvCore_l398_3) begin
      _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_3_dw_Conv_output_0_quantized_resultReg;
    if(when_DepthwiseConvCore_l398_3) begin
      _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_3_dw_Conv_output_0_quantized_resultReg;
    end
  end

  assign when_DepthwiseConvCore_l238_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sInit);
  assign when_DepthwiseConvCore_l240_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_initAddrReg == 14'h2d7f);
  assign when_DepthwiseConvCore_l252_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sReceive);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_padWriteAddrReg = (_blocks_blocks_3_dw_Conv_output_0_quantized_rowElemReg == 9'h13f);
  assign when_DepthwiseConvCore_l264_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_recvCntReg == 13'h1dff);
  assign when_DepthwiseConvCore_l278_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sLoadBias);
  assign when_DepthwiseConvCore_l289_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sWaitBias);
  assign when_DepthwiseConvCore_l303_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sCompute);
  assign when_DepthwiseConvCore_l307_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg < 4'b1001);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg = (_blocks_blocks_3_dw_Conv_output_0_quantized_rowStepReg == 2'b10);
  assign when_DepthwiseConvCore_l319_3 = ((4'b0001 <= _blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg <= 4'b1001));
  assign when_DepthwiseConvCore_l325_3 = ((4'b0010 <= _blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg <= 4'b1010));
  assign when_DepthwiseConvCore_l334_3 = ((4'b0011 <= _blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg <= 4'b1011));
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_accumReg = ($signed(_blocks_blocks_3_dw_Conv_output_0_quantized_accumReg) + $signed(_blocks_blocks_3_dw_Conv_output_0_quantized_prodReg));
  assign when_DepthwiseConvCore_l337_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg == 4'b1011);
  assign when_DepthwiseConvCore_l346_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sRequant);
  assign when_DepthwiseConvCore_l352_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantMul);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pHL_Reg = _blocks_blocks_3_dw_Conv_output_0_quantized_absAReg[31 : 16];
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg = _blocks_blocks_3_dw_Conv_output_0_quantized_absAReg[15 : 0];
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLH_Reg = _blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal[31 : 16];
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg_1 = _blocks_blocks_3_dw_Conv_output_0_quantized_reqMultVal[15 : 0];
  assign when_DepthwiseConvCore_l362_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait);
  assign when_DepthwiseConvCore_l368_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait2);
  assign when_DepthwiseConvCore_l374_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait3);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2 = (_blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg + _blocks_blocks_3_dw_Conv_output_0_quantized_part2Reg);
  assign when_DepthwiseConvCore_l381_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantShift);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg = ($signed(_zz__zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg) + $signed(32'hffffff80));
  assign when_DepthwiseConvCore_l398_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_dw_Conv_output_0_quantized_sEmit);
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_fire = (_blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_valid && _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_ready);
  assign when_DepthwiseConvCore_l410_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_outChReg == 7'h3f);
  assign when_DepthwiseConvCore_l414_3 = (_blocks_blocks_3_dw_Conv_output_0_quantized_outColReg == 3'b100);
  assign _zz__blocks_blocks_3_dw_Conv_output_0_quantized_stateReg = (_blocks_blocks_3_dw_Conv_output_0_quantized_outRowReg == 5'h17);
  assign DepthwiseConvPlugin_logic_outStream_valid_3 = _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_valid;
  assign _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_ready = DepthwiseConvPlugin_logic_outStream_ready_3;
  assign DepthwiseConvPlugin_logic_outStream_payload_value_3 = _blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_payload_value;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_zpWideBits = {8'h80,{8'h80,{8'h80,{8'h80,{8'h80,{8'h80,{8'h80,8'h80}}}}}}};
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow = 4'b0000;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sLoadBias = 4'b0001;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sWaitBias = 4'b0010;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sCompute = 4'b0011;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sRequant = 4'b0100;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantMul = 4'b0101;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait = 4'b0110;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait2 = 4'b0111;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait3 = 4'b1000;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantShift = 4'b1001;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sEmit = 4'b1010;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sInit = 4'b1011;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_sLoadWeights = 4'b1100;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrComb = _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrReg;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_wAddrComb = _blocks_blocks_3_pw_Conv_output_0_quantized_wAddrReg;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rxAddr = (6'h0 + _blocks_blocks_3_pw_Conv_output_0_quantized_rxWordReg);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0 = _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrComb;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0 = _blocks_blocks_3_pw_Conv_output_0_quantized_inputBuf_0_spinal_port0;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_0 = _blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0[7 : 0];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_1 = _blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0[15 : 8];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_2 = _blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0[23 : 16];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_3 = _blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0[31 : 24];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_4 = _blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0[39 : 32];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_5 = _blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0[47 : 40];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_6 = _blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0[55 : 48];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_7 = _blocks_blocks_3_pw_Conv_output_0_quantized_rowWideReads_0[63 : 56];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw = _blocks_blocks_3_pw_Conv_output_0_quantized_wAddrComb;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw = _blocks_blocks_3_pw_Conv_output_0_quantized_weightBuf_spinal_port0;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_0 = _blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw[7 : 0];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_1 = _blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw[15 : 8];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_2 = _blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw[23 : 16];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_3 = _blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw[31 : 24];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_4 = _blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw[39 : 32];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_5 = _blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw[47 : 40];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_6 = _blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw[55 : 48];
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_7 = _blocks_blocks_3_pw_Conv_output_0_quantized_wDataRaw[63 : 56];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_biasVal = _blocks_blocks_3_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_biasVal = _blocks_blocks_3_pw_Conv_output_0_quantized_biasRom_spinal_port0;
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_3_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal = _blocks_blocks_3_pw_Conv_output_0_quantized_reqMultRom_spinal_port0;
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_3_pw_Conv_output_0_quantized_outChReg;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftVal = _blocks_blocks_3_pw_Conv_output_0_quantized_reqShiftRom_spinal_port0;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_isReal = (_blocks_blocks_3_pw_Conv_output_0_quantized_realRowsRecvReg < 5'h18);
  assign DepthwiseConvPlugin_logic_outStream_fire_3 = (DepthwiseConvPlugin_logic_outStream_valid_3 && DepthwiseConvPlugin_logic_outStream_ready_3);
  assign when_QLinearConvLineCore_l346_25 = ((((_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_3_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_3) && (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg == 4'b0000));
  assign when_QLinearConvLineCore_l346_26 = ((((_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_3_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_3) && (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg == 4'b0001));
  assign when_QLinearConvLineCore_l346_27 = ((((_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_3_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_3) && (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg == 4'b0010));
  assign when_QLinearConvLineCore_l346_28 = ((((_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_3_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_3) && (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg == 4'b0011));
  assign when_QLinearConvLineCore_l346_29 = ((((_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_3_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_3) && (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg == 4'b0100));
  assign when_QLinearConvLineCore_l346_30 = ((((_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_3_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_3) && (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg == 4'b0101));
  assign when_QLinearConvLineCore_l346_31 = ((((_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_3_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_3) && (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg == 4'b0110));
  assign when_QLinearConvLineCore_l346_32 = ((((_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow) && _blocks_blocks_3_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_3) && (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg == 4'b0111));
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_recvDataSeq_7 = DepthwiseConvPlugin_logic_outStream_payload_value_3;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_recvData = {_blocks_blocks_3_pw_Conv_output_0_quantized_recvDataSeq_7,{_blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_6,{_blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_5,{_blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_4,{_blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_3,{_blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_2,{_blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_1,_blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_0}}}}}}};
  assign _zz_135 = (_blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg == 1'b0);
  assign _zz_136 = (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg == 4'b0111);
  assign _zz_137 = 1'b0;
  assign _zz_138 = (((((_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow) && _zz_135) && _blocks_blocks_3_pw_Conv_output_0_quantized_isReal) && DepthwiseConvPlugin_logic_outStream_fire_3) && _zz_136);
  always @(*) begin
    DepthwiseConvPlugin_logic_outStream_ready_3 = 1'b0;
    if(when_QLinearConvLineCore_l406_4) begin
      DepthwiseConvPlugin_logic_outStream_ready_3 = _blocks_blocks_3_pw_Conv_output_0_quantized_isReal;
    end
  end

  always @(*) begin
    _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_valid = 1'b0;
    if(when_QLinearConvLineCore_l596_4) begin
      _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2;
    if(when_QLinearConvLineCore_l596_4) begin
      _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_payload_value = _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2;
    end
  end

  always @(*) begin
    _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_ready = 1'b0;
    if(when_QLinearConvLineCore_l438_4) begin
      if(when_QLinearConvLineCore_l439_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_ready = 1'b1;
      end
    end
  end

  assign when_QLinearConvLineCore_l406_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow);
  assign when_QLinearConvLineCore_l410_4 = ((_blocks_blocks_3_pw_Conv_output_0_quantized_isReal && DepthwiseConvPlugin_logic_outStream_fire_3) || (! _blocks_blocks_3_pw_Conv_output_0_quantized_isReal));
  assign when_QLinearConvLineCore_l413_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg == 4'b0111);
  assign when_QLinearConvLineCore_l418_4 = (when_QLinearConvLineCore_l413_4 && (_blocks_blocks_3_pw_Conv_output_0_quantized_rxWordReg == 6'h27));
  assign when_QLinearConvLineCore_l424_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1);
  assign when_QLinearConvLineCore_l438_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sLoadWeights);
  assign when_QLinearConvLineCore_l439_4 = (! _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatDraining);
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_fire = (_blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_valid && _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_ready);
  assign when_QLinearConvLineCore_l448_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_wStepReg < 4'b1000);
  assign when_QLinearConvLineCore_l454_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_wBeatStepReg == 4'b0111);
  assign when_QLinearConvLineCore_l456_4 = (4'b1000 <= _blocks_blocks_3_pw_Conv_output_0_quantized_wStepReg);
  assign when_QLinearConvLineCore_l466_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sLoadBias);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrBaseReg = (_blocks_blocks_3_pw_Conv_output_0_quantized_outColReg * 4'b1000);
  assign when_QLinearConvLineCore_l479_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sWaitBias);
  assign when_QLinearConvLineCore_l485_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sCompute);
  assign when_QLinearConvLineCore_l489_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg < 4'b1000);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg = (_zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg + _zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_1);
  assign when_QLinearConvLineCore_l493_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_rowStepReg == 4'b0111);
  assign when_QLinearConvLineCore_l505_4 = ((4'b0001 <= _blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg <= 4'b1000));
  assign when_QLinearConvLineCore_l515_4 = ((4'b0010 <= _blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg <= 4'b1001));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1 = 9'h180;
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_1 = 9'h0;
  assign when_QLinearConvLineCore_l532_4 = ((4'b0011 <= _blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg) && (_blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg <= 4'b1010));
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_0 = ($signed(_blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_0) + $signed(_blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1));
  assign when_QLinearConvLineCore_l535_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg == 4'b1010);
  assign when_QLinearConvLineCore_l545_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sRequant);
  assign when_QLinearConvLineCore_l551_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantMul);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_9 = _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6[31 : 16];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7 = _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6[15 : 0];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_8 = _blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal[31 : 16];
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7_1 = _blocks_blocks_3_pw_Conv_output_0_quantized_reqMultVal[15 : 0];
  assign when_QLinearConvLineCore_l563_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait);
  assign when_QLinearConvLineCore_l570_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait2);
  assign when_QLinearConvLineCore_l576_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait3);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14 + _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_15);
  assign when_QLinearConvLineCore_l583_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantShift);
  assign _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2 = ($signed(_zz__zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2) + $signed(32'hffffff80));
  assign when_QLinearConvLineCore_l596_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_stateReg == _blocks_blocks_3_pw_Conv_output_0_quantized_sEmit);
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_fire = (_blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_valid && _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_ready);
  assign when_QLinearConvLineCore_l608_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_outChReg == 7'h3f);
  assign when_QLinearConvLineCore_l612_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_outColReg == 3'b100);
  assign when_QLinearConvLineCore_l616_4 = (_blocks_blocks_3_pw_Conv_output_0_quantized_outRowReg == 5'h17);
  assign QLinearConvLineCorePlugin_logic_outStream_valid_4 = _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_valid;
  assign _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_ready = QLinearConvLineCorePlugin_logic_outStream_ready_4;
  assign QLinearConvLineCorePlugin_logic_outStream_payload_value_4 = _blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_payload_value;
  assign _gap_GlobalAveragePool_output_0_quantized_sReceive = 4'b0000;
  assign _gap_GlobalAveragePool_output_0_quantized_sSettle = 4'b0001;
  assign _gap_GlobalAveragePool_output_0_quantized_sReadAcc = 4'b0010;
  assign _gap_GlobalAveragePool_output_0_quantized_sRequant = 4'b0011;
  assign _gap_GlobalAveragePool_output_0_quantized_sRequantMul = 4'b0100;
  assign _gap_GlobalAveragePool_output_0_quantized_sRequantWait = 4'b0101;
  assign _gap_GlobalAveragePool_output_0_quantized_sRequantWait2 = 4'b0110;
  assign _gap_GlobalAveragePool_output_0_quantized_sRequantWait3 = 4'b0111;
  assign _gap_GlobalAveragePool_output_0_quantized_sRequantShift = 4'b1000;
  assign _gap_GlobalAveragePool_output_0_quantized_sEmit = 4'b1001;
  always @(*) begin
    _gap_GlobalAveragePool_output_0_quantized_readAddr = _gap_GlobalAveragePool_output_0_quantized_chReg[5:0];
    if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sReceive)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sSettle)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sReadAcc)) begin
        _gap_GlobalAveragePool_output_0_quantized_readAddr = _gap_GlobalAveragePool_output_0_quantized_emitChReg[5:0];
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequant)) begin
        _gap_GlobalAveragePool_output_0_quantized_readAddr = _gap_GlobalAveragePool_output_0_quantized_emitChReg[5:0];
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantMul)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait2)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait3)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantShift)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sEmit)) begin
    end
  end

  assign _gap_GlobalAveragePool_output_0_quantized_readData = _gap_GlobalAveragePool_output_0_quantized_accumRam_spinal_port0;
  assign when_GlobalAveragePoolCore_l124 = (_gap_GlobalAveragePool_output_0_quantized_prevValidReg && (_gap_GlobalAveragePool_output_0_quantized_prevChReg == _gap_GlobalAveragePool_output_0_quantized_chReg_d1));
  always @(*) begin
    if(when_GlobalAveragePoolCore_l124) begin
      _gap_GlobalAveragePool_output_0_quantized_accumOld = _gap_GlobalAveragePool_output_0_quantized_accPrevReg;
    end else begin
      _gap_GlobalAveragePool_output_0_quantized_accumOld = _gap_GlobalAveragePool_output_0_quantized_readData;
    end
  end

  assign when_GlobalAveragePoolCore_l131 = ((_gap_GlobalAveragePool_output_0_quantized_rowReg_d1 == 5'h0) && (_gap_GlobalAveragePool_output_0_quantized_colReg_d1 == 3'b000));
  always @(*) begin
    if(when_GlobalAveragePoolCore_l131) begin
      _gap_GlobalAveragePool_output_0_quantized_accumNew = {{24{_gap_GlobalAveragePool_output_0_quantized_inValReg[7]}}, _gap_GlobalAveragePool_output_0_quantized_inValReg};
    end else begin
      _gap_GlobalAveragePool_output_0_quantized_accumNew = ($signed(_gap_GlobalAveragePool_output_0_quantized_accumOld) + $signed(_zz__gap_GlobalAveragePool_output_0_quantized_accumNew));
    end
  end

  always @(*) begin
    QLinearConvLineCorePlugin_logic_outStream_ready_4 = 1'b0;
    if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sReceive)) begin
        QLinearConvLineCorePlugin_logic_outStream_ready_4 = 1'b1;
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sSettle)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sReadAcc)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequant)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantMul)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait2)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait3)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantShift)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sEmit)) begin
    end
  end

  always @(*) begin
    _gap_GlobalAveragePool_output_0_quantized_activationOut_valid = 1'b0;
    if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sReceive)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sSettle)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sReadAcc)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequant)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantMul)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait2)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait3)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantShift)) begin
    end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sEmit)) begin
        _gap_GlobalAveragePool_output_0_quantized_activationOut_valid = 1'b1;
    end
  end

  assign _gap_GlobalAveragePool_output_0_quantized_activationOut_payload_value = _gap_GlobalAveragePool_output_0_quantized_resultReg;
  assign QLinearConvLineCorePlugin_logic_outStream_fire_4 = (QLinearConvLineCorePlugin_logic_outStream_valid_4 && QLinearConvLineCorePlugin_logic_outStream_ready_4);
  assign when_GlobalAveragePoolCore_l204 = (_gap_GlobalAveragePool_output_0_quantized_chReg == 7'h3f);
  assign when_GlobalAveragePoolCore_l206 = (_gap_GlobalAveragePool_output_0_quantized_colReg == 3'b100);
  assign when_GlobalAveragePoolCore_l208 = (_gap_GlobalAveragePool_output_0_quantized_rowReg == 5'h17);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_absAReg = ($signed(_gap_GlobalAveragePool_output_0_quantized_readData) - $signed(32'hffffc400));
  assign _zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg = 32'h51fc2cd2;
  assign _zz__gap_GlobalAveragePool_output_0_quantized_pHL_Reg = _gap_GlobalAveragePool_output_0_quantized_absAReg[31 : 16];
  assign _zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg_1 = _gap_GlobalAveragePool_output_0_quantized_absAReg[15 : 0];
  assign _zz__gap_GlobalAveragePool_output_0_quantized_pLH_Reg = _zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg[31 : 16];
  assign _zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg_2 = _zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg[15 : 0];
  assign _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2 = (_gap_GlobalAveragePool_output_0_quantized_part1Reg + _gap_GlobalAveragePool_output_0_quantized_part2Reg);
  assign _zz__gap_GlobalAveragePool_output_0_quantized_resultReg = ($signed(_zz__zz__gap_GlobalAveragePool_output_0_quantized_resultReg) + $signed(32'hffffff80));
  assign _gap_GlobalAveragePool_output_0_quantized_activationOut_fire = (_gap_GlobalAveragePool_output_0_quantized_activationOut_valid && _gap_GlobalAveragePool_output_0_quantized_activationOut_ready);
  assign when_GlobalAveragePoolCore_l291 = (_gap_GlobalAveragePool_output_0_quantized_emitChReg == 7'h3f);
  assign GlobalAveragePoolPlugin_logic_outStream_valid = _gap_GlobalAveragePool_output_0_quantized_activationOut_valid;
  assign _gap_GlobalAveragePool_output_0_quantized_activationOut_ready = GlobalAveragePoolPlugin_logic_outStream_ready;
  assign GlobalAveragePoolPlugin_logic_outStream_payload_value = _gap_GlobalAveragePool_output_0_quantized_activationOut_payload_value;
  assign output_quantized_sReceive = 4'b0000;
  assign output_quantized_sLoadBias = 4'b0001;
  assign output_quantized_sCompute = 4'b0010;
  assign output_quantized_sRequant = 4'b0011;
  assign output_quantized_sRequantMul = 4'b0100;
  assign output_quantized_sRequantWait = 4'b0101;
  assign output_quantized_sRequantWait2 = 4'b0110;
  assign output_quantized_sRequantWait3 = 4'b0111;
  assign output_quantized_sRequantShift = 4'b1000;
  assign output_quantized_sEmit = 4'b1001;
  assign output_quantized_sWaitBias = 4'b1010;
  assign output_quantized_sLoadWeights = 4'b1011;
  assign output_quantized_reqProdReg1 = 64'h0;
  always @(*) begin
    output_quantized_inAddrComb = 6'h0;
    if(when_QLinearLinearCore_l231) begin
      if(when_QLinearLinearCore_l235) begin
        output_quantized_inAddrComb = output_quantized_compCycleReg[5:0];
      end
    end
  end

  always @(*) begin
    output_quantized_wAddrComb = 6'h0;
    if(when_QLinearLinearCore_l231) begin
      if(when_QLinearLinearCore_l235) begin
        output_quantized_wAddrComb = output_quantized_compCycleReg[5:0];
      end
    end
  end

  assign output_quantized_inValR = output_quantized_inputBuf_spinal_port0;
  assign output_quantized_wValR = output_quantized_weightBuf_spinal_port0;
  assign _zz_output_quantized_biasVal = output_quantized_outNeurReg;
  assign output_quantized_biasVal = output_quantized_biasRom_spinal_port0;
  always @(*) begin
    GlobalAveragePoolPlugin_logic_outStream_ready = 1'b0;
    if(when_QLinearLinearCore_l174) begin
      GlobalAveragePoolPlugin_logic_outStream_ready = 1'b1;
    end
  end

  always @(*) begin
    output_quantized_activationOut_valid = 1'b0;
    if(when_QLinearLinearCore_l325) begin
      output_quantized_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    output_quantized_activationOut_payload_value = output_quantized_resultReg;
    if(when_QLinearLinearCore_l325) begin
      output_quantized_activationOut_payload_value = output_quantized_resultReg;
    end
  end

  always @(*) begin
    output_quantized_weightIn_ready = 1'b0;
    if(when_QLinearLinearCore_l191) begin
      if(when_QLinearLinearCore_l192) begin
        output_quantized_weightIn_ready = 1'b1;
      end
    end
  end

  assign when_QLinearLinearCore_l174 = (output_quantized_stateReg == output_quantized_sReceive);
  assign GlobalAveragePoolPlugin_logic_outStream_fire = (GlobalAveragePoolPlugin_logic_outStream_valid && GlobalAveragePoolPlugin_logic_outStream_ready);
  assign when_QLinearLinearCore_l179 = (output_quantized_recvCntReg == 7'h3f);
  assign when_QLinearLinearCore_l191 = (output_quantized_stateReg == output_quantized_sLoadWeights);
  assign when_QLinearLinearCore_l192 = (! output_quantized_wBeatDraining);
  assign output_quantized_weightIn_fire = (output_quantized_weightIn_valid && output_quantized_weightIn_ready);
  assign when_QLinearLinearCore_l201 = (output_quantized_wStepReg < 7'h40);
  assign when_QLinearLinearCore_l207 = (output_quantized_wBeatStepReg == 6'h3f);
  assign when_QLinearLinearCore_l209 = (7'h40 <= output_quantized_wStepReg);
  assign when_QLinearLinearCore_l219 = (output_quantized_stateReg == output_quantized_sLoadBias);
  assign when_QLinearLinearCore_l225 = (output_quantized_stateReg == output_quantized_sWaitBias);
  assign when_QLinearLinearCore_l231 = (output_quantized_stateReg == output_quantized_sCompute);
  assign when_QLinearLinearCore_l235 = (output_quantized_compCycleReg < 7'h40);
  assign when_QLinearLinearCore_l242 = ((7'h01 <= output_quantized_compCycleReg) && (output_quantized_compCycleReg <= 7'h40));
  assign when_QLinearLinearCore_l248 = ((7'h02 <= output_quantized_compCycleReg) && (output_quantized_compCycleReg <= 7'h41));
  assign when_QLinearLinearCore_l255 = ((7'h03 <= output_quantized_compCycleReg) && (output_quantized_compCycleReg <= 7'h42));
  assign _zz_output_quantized_accumReg = ($signed(output_quantized_accumReg) + $signed(output_quantized_prodReg));
  assign when_QLinearLinearCore_l259 = (output_quantized_compCycleReg == 7'h42);
  assign when_QLinearLinearCore_l268 = (output_quantized_stateReg == output_quantized_sRequant);
  assign when_QLinearLinearCore_l275 = (output_quantized_stateReg == output_quantized_sRequantMul);
  assign _zz_output_quantized_pLL_Reg = 32'h520d7aef;
  assign _zz_output_quantized_pHL_Reg = output_quantized_absAReg[31 : 16];
  assign _zz_output_quantized_pLL_Reg_1 = output_quantized_absAReg[15 : 0];
  assign _zz_output_quantized_pLH_Reg = _zz_output_quantized_pLL_Reg[31 : 16];
  assign _zz_output_quantized_pLL_Reg_2 = _zz_output_quantized_pLL_Reg[15 : 0];
  assign when_QLinearLinearCore_l291 = (output_quantized_stateReg == output_quantized_sRequantWait);
  assign when_QLinearLinearCore_l299 = (output_quantized_stateReg == output_quantized_sRequantWait2);
  assign when_QLinearLinearCore_l306 = (output_quantized_stateReg == output_quantized_sRequantWait3);
  assign _zz_output_quantized_reqProdReg2 = (output_quantized_part1Reg + output_quantized_part2Reg);
  assign when_QLinearLinearCore_l314 = (output_quantized_stateReg == output_quantized_sRequantShift);
  assign _zz_output_quantized_resultReg = ($signed(_zz__zz_output_quantized_resultReg) + $signed(32'hfffffffb));
  assign when_QLinearLinearCore_l325 = (output_quantized_stateReg == output_quantized_sEmit);
  assign output_quantized_activationOut_fire = (output_quantized_activationOut_valid && output_quantized_activationOut_ready);
  assign _zz_output_quantized_stateReg = (output_quantized_outNeurReg == 4'b1011);
  assign QLinearLinearPlugin_logic_outStream_valid = output_quantized_activationOut_valid;
  assign output_quantized_activationOut_ready = QLinearLinearPlugin_logic_outStream_ready;
  assign QLinearLinearPlugin_logic_outStream_payload_value = output_quantized_activationOut_payload_value;
  assign _zz_weightDmaAxi_ar_payload_len = _zz__zz_weightDmaAxi_ar_payload_len;
  always @(*) begin
    weightDmaAxi_ar_valid = 1'b0;
    if(when_WeightDmaCore_l137) begin
      weightDmaAxi_ar_valid = 1'b1;
    end
  end

  always @(*) begin
    weightDmaAxi_ar_payload_addr = 33'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_WeightDmaCore_l137) begin
      weightDmaAxi_ar_payload_addr = (_zz_weightDmaAxi_ar_payload_addr_3 + _zz_weightDmaAxi_ar_payload_addr_4);
    end
  end

  always @(*) begin
    weightDmaAxi_ar_payload_id = 6'bxxxxxx;
    if(when_WeightDmaCore_l137) begin
      weightDmaAxi_ar_payload_id = 6'h0;
    end
  end

  always @(*) begin
    weightDmaAxi_ar_payload_len = 8'bxxxxxxxx;
    if(when_WeightDmaCore_l137) begin
      weightDmaAxi_ar_payload_len = {7'd0, _zz_weightDmaAxi_ar_payload_len_1};
    end
  end

  always @(*) begin
    weightDmaAxi_ar_payload_size = 3'bxxx;
    if(when_WeightDmaCore_l137) begin
      weightDmaAxi_ar_payload_size = 3'b110;
    end
  end

  always @(*) begin
    weightDmaAxi_ar_payload_burst = 2'bxx;
    if(when_WeightDmaCore_l137) begin
      weightDmaAxi_ar_payload_burst = 2'b01;
    end
  end

  always @(*) begin
    weightDmaAxi_r_ready = 1'b0;
    if(when_WeightDmaCore_l155) begin
      weightDmaAxi_r_ready = 1'b1;
    end
  end

  always @(*) begin
    _stem_conv_Conv_output_0_quantized_weightIn_valid = 1'b0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166) begin
        _stem_conv_Conv_output_0_quantized_weightIn_valid = 1'b1;
      end
    end
  end

  always @(*) begin
    _stem_conv_Conv_output_0_quantized_weightIn_payload = 512'h0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166) begin
        _stem_conv_Conv_output_0_quantized_weightIn_payload = _zz__stem_conv_Conv_output_0_quantized_weightIn_payload;
      end
    end
  end

  always @(*) begin
    _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_valid = 1'b0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_valid = 1'b1;
      end
    end
  end

  always @(*) begin
    _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_payload = 512'h0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_payload = _zz__stem_conv_Conv_output_0_quantized_weightIn_payload;
      end
    end
  end

  always @(*) begin
    _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_valid = 1'b0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_valid = 1'b1;
      end
    end
  end

  always @(*) begin
    _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_payload = 512'h0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_payload = _zz__stem_conv_Conv_output_0_quantized_weightIn_payload;
      end
    end
  end

  always @(*) begin
    _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_valid = 1'b0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_valid = 1'b1;
      end
    end
  end

  always @(*) begin
    _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_payload = 512'h0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_payload = _zz__stem_conv_Conv_output_0_quantized_weightIn_payload;
      end
    end
  end

  always @(*) begin
    _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_valid = 1'b0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_valid = 1'b1;
      end
    end
  end

  always @(*) begin
    _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_payload = 512'h0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_payload = _zz__stem_conv_Conv_output_0_quantized_weightIn_payload;
      end
    end
  end

  always @(*) begin
    output_quantized_weightIn_valid = 1'b0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166_5) begin
        output_quantized_weightIn_valid = 1'b1;
      end
    end
  end

  always @(*) begin
    output_quantized_weightIn_payload = 512'h0;
    if(when_WeightDmaCore_l164) begin
      if(when_WeightDmaCore_l166_5) begin
        output_quantized_weightIn_payload = _zz__stem_conv_Conv_output_0_quantized_weightIn_payload;
      end
    end
  end

  assign when_WeightDmaCore_l137 = (_zz_when_WeightDmaCore_l137 == 3'b000);
  assign weightDmaAxi_ar_fire = (weightDmaAxi_ar_valid && weightDmaAxi_ar_ready);
  assign when_WeightDmaCore_l155 = (_zz_when_WeightDmaCore_l137 == 3'b001);
  assign weightDmaAxi_r_fire = (weightDmaAxi_r_valid && weightDmaAxi_r_ready);
  assign when_WeightDmaCore_l164 = (_zz_when_WeightDmaCore_l137 == 3'b010);
  assign when_WeightDmaCore_l166 = (_zz_weightDmaAxi_ar_payload_addr == 3'b000);
  assign when_WeightDmaCore_l166_1 = (_zz_weightDmaAxi_ar_payload_addr == 3'b001);
  assign when_WeightDmaCore_l166_2 = (_zz_weightDmaAxi_ar_payload_addr == 3'b010);
  assign when_WeightDmaCore_l166_3 = (_zz_weightDmaAxi_ar_payload_addr == 3'b011);
  assign when_WeightDmaCore_l166_4 = (_zz_weightDmaAxi_ar_payload_addr == 3'b100);
  assign when_WeightDmaCore_l166_5 = (_zz_weightDmaAxi_ar_payload_addr == 3'b101);
  assign when_WeightDmaCore_l176 = ((((((_stem_conv_Conv_output_0_quantized_weightIn_ready && (_zz_weightDmaAxi_ar_payload_addr == 3'b000)) || (_blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_ready && (_zz_weightDmaAxi_ar_payload_addr == 3'b001))) || (_blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_ready && (_zz_weightDmaAxi_ar_payload_addr == 3'b010))) || (_blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_ready && (_zz_weightDmaAxi_ar_payload_addr == 3'b011))) || (_blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_ready && (_zz_weightDmaAxi_ar_payload_addr == 3'b100))) || (output_quantized_weightIn_ready && (_zz_weightDmaAxi_ar_payload_addr == 3'b101)));
  assign when_WeightDmaCore_l178 = (_zz_when_WeightDmaCore_l178 == _zz_when_WeightDmaCore_l178_1);
  assign when_WeightDmaCore_l187 = (_zz_when_WeightDmaCore_l137 == 3'b011);
  assign _zz_weightDmaAxi_ar_payload_addr_2 = (_zz_weightDmaAxi_ar_payload_addr_1 == _zz__zz_weightDmaAxi_ar_payload_addr_2);
  assign activation_out_valid = QLinearLinearPlugin_logic_outStream_valid;
  assign QLinearLinearPlugin_logic_outStream_ready = activation_out_ready;
  assign activation_out_data = QLinearLinearPlugin_logic_outStream_payload_value;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      _stem_conv_Conv_output_0_quantized_wStepReg <= 6'h0;
      _stem_conv_Conv_output_0_quantized_wBeatStepReg <= 7'h0;
      _stem_conv_Conv_output_0_quantized_wBeatBuf <= 512'h0;
      _stem_conv_Conv_output_0_quantized_wBeatDraining <= 1'b0;
      _stem_conv_Conv_output_0_quantized_stateReg <= 4'b1011;
      _stem_conv_Conv_output_0_quantized_rowWrPtrReg <= 4'b0100;
      _stem_conv_Conv_output_0_quantized_rowsUntilComputeReg <= 4'b0110;
      _stem_conv_Conv_output_0_quantized_realRowsRecvReg <= 6'h0;
      _stem_conv_Conv_output_0_quantized_rxBankReg <= 1'b0;
      _stem_conv_Conv_output_0_quantized_rxWordReg <= 4'b0000;
      _stem_conv_Conv_output_0_quantized_initSlotReg <= 4'b0000;
      _stem_conv_Conv_output_0_quantized_initAddrReg <= 4'b0000;
      _stem_conv_Conv_output_0_quantized_outRowReg <= 5'h0;
      _stem_conv_Conv_output_0_quantized_outColReg <= 3'b000;
      _stem_conv_Conv_output_0_quantized_outChReg <= 7'h0;
      _stem_conv_Conv_output_0_quantized_khCntReg <= 4'b0000;
      _stem_conv_Conv_output_0_quantized_rowStepReg <= 3'b000;
      _stem_conv_Conv_output_0_quantized_compCycleReg <= 6'h0;
      _stem_conv_Conv_output_0_quantized_rowAddrBaseReg <= 4'b0000;
      _stem_conv_Conv_output_0_quantized_rowAddrReg <= 4'b0000;
      _stem_conv_Conv_output_0_quantized_wAddrReg <= 6'h0;
      _stem_conv_Conv_output_0_quantized_curSlotReg <= 4'b0000;
      _stem_conv_Conv_output_0_quantized_inValReg_0 <= 8'h0;
      _stem_conv_Conv_output_0_quantized_wValReg_0 <= 8'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_0 <= 32'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_1 <= 32'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_2 <= 8'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_3 <= 32'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_4 <= 64'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_5 <= 1'b0;
      _stem_conv_Conv_output_0_quantized_rqReg_6 <= 32'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_7 <= 32'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_8 <= 32'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_9 <= 32'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_10 <= 32'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_11 <= 33'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_12 <= 32'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_13 <= 32'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_14 <= 64'h0;
      _stem_conv_Conv_output_0_quantized_rqReg_15 <= 64'h0;
      _stem_conv_Conv_output_0_quantized_rxByteRegs_0 <= 8'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= 4'b1010;
      _blocks_blocks_0_dw_Conv_output_0_quantized_recvCntReg <= 13'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_padWriteAddrReg <= 14'h0200;
      _blocks_blocks_0_dw_Conv_output_0_quantized_rowElemReg <= 9'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_outRowReg <= 5'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_outColReg <= 3'b000;
      _blocks_blocks_0_dw_Conv_output_0_quantized_outChReg <= 7'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_accumReg <= 32'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_prodReg <= 32'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_resultReg <= 8'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_accumRequantReg <= 32'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2 <= 64'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_signAReg <= 1'b0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_absAReg <= 32'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg <= 32'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_pLH_Reg <= 32'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_pHL_Reg <= 32'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_pHH_Reg <= 32'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_pSumReg <= 33'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg2 <= 32'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_pHH_Reg2 <= 32'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg <= 64'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_part2Reg <= 64'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_initAddrReg <= 14'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg <= 14'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_wAddrReg <= 10'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
      _blocks_blocks_0_dw_Conv_output_0_quantized_rowStepReg <= 2'b00;
      _blocks_blocks_0_dw_Conv_output_0_quantized_inValReg <= 8'h0;
      _blocks_blocks_0_dw_Conv_output_0_quantized_wValReg <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wStepReg <= 4'b0000;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatStepReg <= 4'b0000;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatBuf <= 512'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatDraining <= 1'b0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= 4'b0000;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg <= 1'b0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
      _blocks_blocks_0_pw_Conv_output_0_quantized_realRowsRecvReg <= 5'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_initSlotReg <= 1'b0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_initAddrReg <= 6'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_outRowReg <= 5'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_outColReg <= 3'b000;
      _blocks_blocks_0_pw_Conv_output_0_quantized_outChReg <= 7'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_khCntReg <= 1'b0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
      _blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrBaseReg <= 6'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrReg <= 6'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wAddrReg <= 4'b0000;
      _blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg <= 1'b0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_0 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_1 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_2 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_3 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_4 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_5 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_6 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_7 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_0 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_1 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_2 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_3 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_4 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_5 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_6 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_7 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_0 <= 32'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1 <= 32'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_3 <= 32'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4 <= 64'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_5 <= 1'b0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6 <= 32'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7 <= 32'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_8 <= 32'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_9 <= 32'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_10 <= 32'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_11 <= 33'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_12 <= 32'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_13 <= 32'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14 <= 64'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_15 <= 64'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_0 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_1 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_2 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_3 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_4 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_5 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_6 <= 8'h0;
      _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_7 <= 8'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= 4'b1010;
      _blocks_blocks_1_dw_Conv_output_0_quantized_recvCntReg <= 13'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_padWriteAddrReg <= 14'h0200;
      _blocks_blocks_1_dw_Conv_output_0_quantized_rowElemReg <= 9'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_outRowReg <= 5'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_outColReg <= 3'b000;
      _blocks_blocks_1_dw_Conv_output_0_quantized_outChReg <= 7'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_accumReg <= 32'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_prodReg <= 32'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_resultReg <= 8'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_accumRequantReg <= 32'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2 <= 64'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_signAReg <= 1'b0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_absAReg <= 32'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg <= 32'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_pLH_Reg <= 32'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_pHL_Reg <= 32'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_pHH_Reg <= 32'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_pSumReg <= 33'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg2 <= 32'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_pHH_Reg2 <= 32'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg <= 64'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_part2Reg <= 64'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_initAddrReg <= 14'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg <= 14'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_wAddrReg <= 10'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
      _blocks_blocks_1_dw_Conv_output_0_quantized_rowStepReg <= 2'b00;
      _blocks_blocks_1_dw_Conv_output_0_quantized_inValReg <= 8'h0;
      _blocks_blocks_1_dw_Conv_output_0_quantized_wValReg <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wStepReg <= 4'b0000;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatStepReg <= 4'b0000;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatBuf <= 512'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatDraining <= 1'b0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= 4'b0000;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg <= 1'b0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
      _blocks_blocks_1_pw_Conv_output_0_quantized_realRowsRecvReg <= 5'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_initSlotReg <= 1'b0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_initAddrReg <= 6'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_outRowReg <= 5'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_outColReg <= 3'b000;
      _blocks_blocks_1_pw_Conv_output_0_quantized_outChReg <= 7'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_khCntReg <= 1'b0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
      _blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrBaseReg <= 6'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrReg <= 6'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wAddrReg <= 4'b0000;
      _blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg <= 1'b0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_0 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_1 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_2 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_3 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_4 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_5 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_6 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_7 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_0 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_1 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_2 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_3 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_4 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_5 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_6 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_7 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_0 <= 32'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1 <= 32'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_3 <= 32'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4 <= 64'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_5 <= 1'b0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6 <= 32'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7 <= 32'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_8 <= 32'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_9 <= 32'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_10 <= 32'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_11 <= 33'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_12 <= 32'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_13 <= 32'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14 <= 64'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_15 <= 64'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_0 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_1 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_2 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_3 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_4 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_5 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_6 <= 8'h0;
      _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_7 <= 8'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= 4'b1010;
      _blocks_blocks_2_dw_Conv_output_0_quantized_recvCntReg <= 13'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_padWriteAddrReg <= 14'h0200;
      _blocks_blocks_2_dw_Conv_output_0_quantized_rowElemReg <= 9'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_outRowReg <= 5'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_outColReg <= 3'b000;
      _blocks_blocks_2_dw_Conv_output_0_quantized_outChReg <= 7'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_accumReg <= 32'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_prodReg <= 32'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_resultReg <= 8'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_accumRequantReg <= 32'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2 <= 64'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_signAReg <= 1'b0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_absAReg <= 32'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg <= 32'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_pLH_Reg <= 32'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_pHL_Reg <= 32'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_pHH_Reg <= 32'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_pSumReg <= 33'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg2 <= 32'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_pHH_Reg2 <= 32'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg <= 64'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_part2Reg <= 64'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_initAddrReg <= 14'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg <= 14'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_wAddrReg <= 10'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
      _blocks_blocks_2_dw_Conv_output_0_quantized_rowStepReg <= 2'b00;
      _blocks_blocks_2_dw_Conv_output_0_quantized_inValReg <= 8'h0;
      _blocks_blocks_2_dw_Conv_output_0_quantized_wValReg <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wStepReg <= 4'b0000;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatStepReg <= 4'b0000;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatBuf <= 512'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatDraining <= 1'b0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= 4'b0000;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg <= 1'b0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
      _blocks_blocks_2_pw_Conv_output_0_quantized_realRowsRecvReg <= 5'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_initSlotReg <= 1'b0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_initAddrReg <= 6'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_outRowReg <= 5'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_outColReg <= 3'b000;
      _blocks_blocks_2_pw_Conv_output_0_quantized_outChReg <= 7'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_khCntReg <= 1'b0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
      _blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrBaseReg <= 6'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrReg <= 6'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wAddrReg <= 4'b0000;
      _blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg <= 1'b0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_0 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_1 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_2 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_3 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_4 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_5 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_6 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_7 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_0 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_1 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_2 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_3 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_4 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_5 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_6 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_7 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_0 <= 32'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1 <= 32'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_3 <= 32'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4 <= 64'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_5 <= 1'b0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6 <= 32'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7 <= 32'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_8 <= 32'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_9 <= 32'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_10 <= 32'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_11 <= 33'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_12 <= 32'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_13 <= 32'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14 <= 64'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_15 <= 64'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_0 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_1 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_2 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_3 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_4 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_5 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_6 <= 8'h0;
      _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_7 <= 8'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= 4'b1010;
      _blocks_blocks_3_dw_Conv_output_0_quantized_recvCntReg <= 13'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_padWriteAddrReg <= 14'h0200;
      _blocks_blocks_3_dw_Conv_output_0_quantized_rowElemReg <= 9'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_outRowReg <= 5'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_outColReg <= 3'b000;
      _blocks_blocks_3_dw_Conv_output_0_quantized_outChReg <= 7'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_accumReg <= 32'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_prodReg <= 32'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_resultReg <= 8'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_accumRequantReg <= 32'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2 <= 64'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_signAReg <= 1'b0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_absAReg <= 32'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg <= 32'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_pLH_Reg <= 32'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_pHL_Reg <= 32'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_pHH_Reg <= 32'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_pSumReg <= 33'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg2 <= 32'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_pHH_Reg2 <= 32'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg <= 64'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_part2Reg <= 64'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_initAddrReg <= 14'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg <= 14'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_wAddrReg <= 10'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
      _blocks_blocks_3_dw_Conv_output_0_quantized_rowStepReg <= 2'b00;
      _blocks_blocks_3_dw_Conv_output_0_quantized_inValReg <= 8'h0;
      _blocks_blocks_3_dw_Conv_output_0_quantized_wValReg <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wStepReg <= 4'b0000;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatStepReg <= 4'b0000;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatBuf <= 512'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatDraining <= 1'b0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= 4'b0000;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg <= 1'b0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
      _blocks_blocks_3_pw_Conv_output_0_quantized_realRowsRecvReg <= 5'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_initSlotReg <= 1'b0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_initAddrReg <= 6'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_outRowReg <= 5'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_outColReg <= 3'b000;
      _blocks_blocks_3_pw_Conv_output_0_quantized_outChReg <= 7'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_khCntReg <= 1'b0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
      _blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrBaseReg <= 6'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrReg <= 6'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wAddrReg <= 4'b0000;
      _blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg <= 1'b0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_0 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_1 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_2 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_3 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_4 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_5 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_6 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_7 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_0 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_1 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_2 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_3 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_4 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_5 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_6 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_7 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_0 <= 32'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1 <= 32'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_3 <= 32'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4 <= 64'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_5 <= 1'b0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6 <= 32'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7 <= 32'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_8 <= 32'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_9 <= 32'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_10 <= 32'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_11 <= 33'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_12 <= 32'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_13 <= 32'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14 <= 64'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_15 <= 64'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_0 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_1 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_2 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_3 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_4 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_5 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_6 <= 8'h0;
      _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_7 <= 8'h0;
      _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sReceive;
      _gap_GlobalAveragePool_output_0_quantized_chReg <= 7'h0;
      _gap_GlobalAveragePool_output_0_quantized_colReg <= 3'b000;
      _gap_GlobalAveragePool_output_0_quantized_rowReg <= 5'h0;
      _gap_GlobalAveragePool_output_0_quantized_pipelineValidReg <= 1'b0;
      _gap_GlobalAveragePool_output_0_quantized_inValReg <= 8'h0;
      _gap_GlobalAveragePool_output_0_quantized_chReg_d1 <= 7'h0;
      _gap_GlobalAveragePool_output_0_quantized_rowReg_d1 <= 5'h0;
      _gap_GlobalAveragePool_output_0_quantized_colReg_d1 <= 3'b000;
      _gap_GlobalAveragePool_output_0_quantized_accPrevReg <= 32'h0;
      _gap_GlobalAveragePool_output_0_quantized_prevChReg <= 7'h0;
      _gap_GlobalAveragePool_output_0_quantized_prevValidReg <= 1'b0;
      _gap_GlobalAveragePool_output_0_quantized_emitChReg <= 7'h0;
      _gap_GlobalAveragePool_output_0_quantized_absAReg <= 32'h0;
      _gap_GlobalAveragePool_output_0_quantized_signAReg <= 1'b0;
      _gap_GlobalAveragePool_output_0_quantized_pLL_Reg <= 32'h0;
      _gap_GlobalAveragePool_output_0_quantized_pLH_Reg <= 32'h0;
      _gap_GlobalAveragePool_output_0_quantized_pHL_Reg <= 32'h0;
      _gap_GlobalAveragePool_output_0_quantized_pHH_Reg <= 32'h0;
      _gap_GlobalAveragePool_output_0_quantized_pSumReg <= 33'h0;
      _gap_GlobalAveragePool_output_0_quantized_pLL_Reg2 <= 32'h0;
      _gap_GlobalAveragePool_output_0_quantized_pHH_Reg2 <= 32'h0;
      _gap_GlobalAveragePool_output_0_quantized_part1Reg <= 64'h0;
      _gap_GlobalAveragePool_output_0_quantized_part2Reg <= 64'h0;
      _gap_GlobalAveragePool_output_0_quantized_reqProdReg2 <= 64'h0;
      _gap_GlobalAveragePool_output_0_quantized_resultReg <= 8'h0;
      output_quantized_wStepReg <= 7'h0;
      output_quantized_wBeatStepReg <= 6'h0;
      output_quantized_wBeatBuf <= 512'h0;
      output_quantized_wBeatDraining <= 1'b0;
      output_quantized_stateReg <= 4'b0000;
      output_quantized_recvCntReg <= 7'h0;
      output_quantized_outNeurReg <= 4'b0000;
      output_quantized_compCycleReg <= 7'h0;
      output_quantized_accumReg <= 32'h0;
      output_quantized_prodReg <= 32'h0;
      output_quantized_resultReg <= 8'h0;
      output_quantized_reqProdReg2 <= 64'h0;
      output_quantized_accumRequantReg <= 32'h0;
      output_quantized_signAReg <= 1'b0;
      output_quantized_absAReg <= 32'h0;
      output_quantized_pLL_Reg <= 32'h0;
      output_quantized_pLH_Reg <= 32'h0;
      output_quantized_pHL_Reg <= 32'h0;
      output_quantized_pHH_Reg <= 32'h0;
      output_quantized_pSumReg <= 33'h0;
      output_quantized_pLL_Reg2 <= 32'h0;
      output_quantized_pHH_Reg2 <= 32'h0;
      output_quantized_part1Reg <= 64'h0;
      output_quantized_part2Reg <= 64'h0;
      output_quantized_inValReg <= 8'h0;
      output_quantized_wValReg <= 8'h0;
      _zz_when_WeightDmaCore_l137 <= 3'b000;
      _zz_weightDmaAxi_ar_payload_addr <= 3'b000;
      _zz_weightDmaAxi_ar_payload_addr_1 <= 7'h0;
      _zz_when_WeightDmaCore_l178 <= 1'b0;
      _zz__stem_conv_Conv_output_0_quantized_weightIn_payload <= 512'h0;
    end else begin
      if(when_QLinearConvLineCore_l346) begin
        _stem_conv_Conv_output_0_quantized_rxByteRegs_0 <= activation_in_data;
      end
      if(when_QLinearConvLineCore_l382) begin
        _stem_conv_Conv_output_0_quantized_initAddrReg <= (_stem_conv_Conv_output_0_quantized_initAddrReg + 4'b0001);
        if(when_QLinearConvLineCore_l384) begin
          _stem_conv_Conv_output_0_quantized_initAddrReg <= 4'b0000;
          _stem_conv_Conv_output_0_quantized_initSlotReg <= (_stem_conv_Conv_output_0_quantized_initSlotReg + 4'b0001);
          if(when_QLinearConvLineCore_l387) begin
            _stem_conv_Conv_output_0_quantized_initSlotReg <= 4'b0000;
            _stem_conv_Conv_output_0_quantized_rowWrPtrReg <= 4'b0100;
            _stem_conv_Conv_output_0_quantized_rowsUntilComputeReg <= 4'b0110;
            _stem_conv_Conv_output_0_quantized_realRowsRecvReg <= 6'h0;
            _stem_conv_Conv_output_0_quantized_rxBankReg <= 1'b0;
            _stem_conv_Conv_output_0_quantized_rxWordReg <= 4'b0000;
            _stem_conv_Conv_output_0_quantized_outRowReg <= 5'h0;
            _stem_conv_Conv_output_0_quantized_outColReg <= 3'b000;
            _stem_conv_Conv_output_0_quantized_outChReg <= 7'h0;
            _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sReceiveRow;
          end
        end
      end
      if(when_QLinearConvLineCore_l406) begin
        if(when_QLinearConvLineCore_l410) begin
          _stem_conv_Conv_output_0_quantized_rxBankReg <= (when_QLinearConvLineCore_l413 ? 1'b0 : _zz__stem_conv_Conv_output_0_quantized_rxBankReg);
          if(when_QLinearConvLineCore_l413) begin
            _stem_conv_Conv_output_0_quantized_rxWordReg <= (_stem_conv_Conv_output_0_quantized_rxWordReg + 4'b0001);
          end
          if(when_QLinearConvLineCore_l418) begin
            _stem_conv_Conv_output_0_quantized_rxBankReg <= 1'b0;
            _stem_conv_Conv_output_0_quantized_rxWordReg <= 4'b0000;
            _stem_conv_Conv_output_0_quantized_rowWrPtrReg <= ((_stem_conv_Conv_output_0_quantized_rowWrPtrReg == 4'b1001) ? 4'b0000 : _zz__stem_conv_Conv_output_0_quantized_rowWrPtrReg);
            if(_stem_conv_Conv_output_0_quantized_isReal) begin
              _stem_conv_Conv_output_0_quantized_realRowsRecvReg <= (_stem_conv_Conv_output_0_quantized_realRowsRecvReg + 6'h01);
            end
            if(when_QLinearConvLineCore_l424) begin
              _stem_conv_Conv_output_0_quantized_rowsUntilComputeReg <= 4'b0010;
              _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sLoadWeights;
            end else begin
              _stem_conv_Conv_output_0_quantized_rowsUntilComputeReg <= (_stem_conv_Conv_output_0_quantized_rowsUntilComputeReg - 4'b0001);
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l438) begin
        if(when_QLinearConvLineCore_l439) begin
          if(_stem_conv_Conv_output_0_quantized_weightIn_fire) begin
            _stem_conv_Conv_output_0_quantized_wBeatBuf <= _stem_conv_Conv_output_0_quantized_weightIn_payload;
            _stem_conv_Conv_output_0_quantized_wBeatDraining <= 1'b1;
            _stem_conv_Conv_output_0_quantized_wBeatStepReg <= 7'h0;
          end
        end else begin
          if(when_QLinearConvLineCore_l448) begin
            _stem_conv_Conv_output_0_quantized_wStepReg <= (_stem_conv_Conv_output_0_quantized_wStepReg + 6'h01);
          end
          _stem_conv_Conv_output_0_quantized_wBeatBuf <= {8'd0, _zz__stem_conv_Conv_output_0_quantized_wBeatBuf};
          _stem_conv_Conv_output_0_quantized_wBeatStepReg <= (_stem_conv_Conv_output_0_quantized_wBeatStepReg + 7'h01);
          if(when_QLinearConvLineCore_l454) begin
            _stem_conv_Conv_output_0_quantized_wBeatDraining <= 1'b0;
            if(when_QLinearConvLineCore_l456) begin
              _stem_conv_Conv_output_0_quantized_wStepReg <= 6'h0;
              _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sLoadBias;
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l466) begin
        _stem_conv_Conv_output_0_quantized_rowAddrBaseReg <= _zz__stem_conv_Conv_output_0_quantized_rowAddrBaseReg[3:0];
        _stem_conv_Conv_output_0_quantized_rowAddrReg <= _zz__stem_conv_Conv_output_0_quantized_rowAddrBaseReg[3:0];
        _stem_conv_Conv_output_0_quantized_wAddrReg <= 6'h0;
        _stem_conv_Conv_output_0_quantized_khCntReg <= 4'b0000;
        _stem_conv_Conv_output_0_quantized_rowStepReg <= 3'b000;
        _stem_conv_Conv_output_0_quantized_compCycleReg <= 6'h0;
        _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sWaitBias;
      end
      if(when_QLinearConvLineCore_l479) begin
        _stem_conv_Conv_output_0_quantized_rqReg_0 <= _stem_conv_Conv_output_0_quantized_biasVal;
        _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sCompute;
      end
      if(when_QLinearConvLineCore_l485) begin
        _stem_conv_Conv_output_0_quantized_compCycleReg <= (_stem_conv_Conv_output_0_quantized_compCycleReg + 6'h01);
        if(when_QLinearConvLineCore_l489) begin
          _stem_conv_Conv_output_0_quantized_curSlotReg <= ((5'h0a <= _zz__stem_conv_Conv_output_0_quantized_curSlotReg) ? _zz__stem_conv_Conv_output_0_quantized_curSlotReg_1 : _zz__stem_conv_Conv_output_0_quantized_curSlotReg_3);
          _stem_conv_Conv_output_0_quantized_wAddrReg <= (_stem_conv_Conv_output_0_quantized_wAddrReg + 6'h01);
          if(when_QLinearConvLineCore_l493) begin
            _stem_conv_Conv_output_0_quantized_rowStepReg <= 3'b000;
            _stem_conv_Conv_output_0_quantized_khCntReg <= (_stem_conv_Conv_output_0_quantized_khCntReg + 4'b0001);
            _stem_conv_Conv_output_0_quantized_rowAddrReg <= _stem_conv_Conv_output_0_quantized_rowAddrBaseReg;
          end else begin
            _stem_conv_Conv_output_0_quantized_rowStepReg <= (_stem_conv_Conv_output_0_quantized_rowStepReg + 3'b001);
            _stem_conv_Conv_output_0_quantized_rowAddrReg <= (_stem_conv_Conv_output_0_quantized_rowAddrReg + 4'b0001);
          end
        end
        if(when_QLinearConvLineCore_l505) begin
          _stem_conv_Conv_output_0_quantized_inValReg_0 <= _zz__stem_conv_Conv_output_0_quantized_inValReg_0;
          _stem_conv_Conv_output_0_quantized_wValReg_0 <= _stem_conv_Conv_output_0_quantized_wValsRaw_0;
        end
        if(when_QLinearConvLineCore_l515) begin
          _stem_conv_Conv_output_0_quantized_rqReg_1 <= {{14{_zz__stem_conv_Conv_output_0_quantized_rqReg_1[17]}}, _zz__stem_conv_Conv_output_0_quantized_rqReg_1};
        end
        if(when_QLinearConvLineCore_l532) begin
          _stem_conv_Conv_output_0_quantized_rqReg_0 <= _zz__stem_conv_Conv_output_0_quantized_rqReg_0;
          if(when_QLinearConvLineCore_l535) begin
            _stem_conv_Conv_output_0_quantized_rqReg_3 <= _zz__stem_conv_Conv_output_0_quantized_rqReg_0;
            _stem_conv_Conv_output_0_quantized_compCycleReg <= 6'h0;
            _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sRequant;
          end
        end
      end
      if(when_QLinearConvLineCore_l545) begin
        _stem_conv_Conv_output_0_quantized_rqReg_6 <= _zz__stem_conv_Conv_output_0_quantized_rqReg_6;
        _stem_conv_Conv_output_0_quantized_rqReg_5 <= ($signed(_stem_conv_Conv_output_0_quantized_rqReg_3) < $signed(32'h0));
        _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sRequantMul;
      end
      if(when_QLinearConvLineCore_l551) begin
        _stem_conv_Conv_output_0_quantized_rqReg_7 <= (_zz__stem_conv_Conv_output_0_quantized_rqReg_7 * _zz__stem_conv_Conv_output_0_quantized_rqReg_7_1);
        _stem_conv_Conv_output_0_quantized_rqReg_8 <= (_zz__stem_conv_Conv_output_0_quantized_rqReg_7 * _zz__stem_conv_Conv_output_0_quantized_rqReg_8);
        _stem_conv_Conv_output_0_quantized_rqReg_9 <= (_zz__stem_conv_Conv_output_0_quantized_rqReg_9 * _zz__stem_conv_Conv_output_0_quantized_rqReg_7_1);
        _stem_conv_Conv_output_0_quantized_rqReg_10 <= (_zz__stem_conv_Conv_output_0_quantized_rqReg_9 * _zz__stem_conv_Conv_output_0_quantized_rqReg_8);
        _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sRequantWait;
      end
      if(when_QLinearConvLineCore_l563) begin
        _stem_conv_Conv_output_0_quantized_rqReg_11 <= (_zz__stem_conv_Conv_output_0_quantized_rqReg_11 + _zz__stem_conv_Conv_output_0_quantized_rqReg_11_1);
        _stem_conv_Conv_output_0_quantized_rqReg_12 <= _stem_conv_Conv_output_0_quantized_rqReg_7;
        _stem_conv_Conv_output_0_quantized_rqReg_13 <= _stem_conv_Conv_output_0_quantized_rqReg_10;
        _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sRequantWait2;
      end
      if(when_QLinearConvLineCore_l570) begin
        _stem_conv_Conv_output_0_quantized_rqReg_14 <= (_zz__stem_conv_Conv_output_0_quantized_rqReg_14 + _zz__stem_conv_Conv_output_0_quantized_rqReg_14_1);
        _stem_conv_Conv_output_0_quantized_rqReg_15 <= _zz__stem_conv_Conv_output_0_quantized_rqReg_15[63:0];
        _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sRequantWait3;
      end
      if(when_QLinearConvLineCore_l576) begin
        _stem_conv_Conv_output_0_quantized_rqReg_4 <= (_stem_conv_Conv_output_0_quantized_rqReg_5 ? _zz__stem_conv_Conv_output_0_quantized_rqReg_4_1 : _zz__stem_conv_Conv_output_0_quantized_rqReg_4_3);
        _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sRequantShift;
      end
      if(when_QLinearConvLineCore_l583) begin
        _stem_conv_Conv_output_0_quantized_rqReg_2 <= (($signed(32'h0000007f) < $signed(_zz__stem_conv_Conv_output_0_quantized_rqReg_2)) ? 8'h7f : _zz__stem_conv_Conv_output_0_quantized_rqReg_2_1);
        _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sEmit;
      end
      if(when_QLinearConvLineCore_l596) begin
        if(_stem_conv_Conv_output_0_quantized_activationOut_fire) begin
          _stem_conv_Conv_output_0_quantized_outChReg <= (when_QLinearConvLineCore_l608 ? 7'h0 : _zz__stem_conv_Conv_output_0_quantized_outChReg);
          if(when_QLinearConvLineCore_l608) begin
            _stem_conv_Conv_output_0_quantized_outColReg <= (when_QLinearConvLineCore_l612 ? 3'b000 : _zz__stem_conv_Conv_output_0_quantized_outColReg);
            if(when_QLinearConvLineCore_l612) begin
              _stem_conv_Conv_output_0_quantized_outRowReg <= (when_QLinearConvLineCore_l616 ? 5'h0 : _zz__stem_conv_Conv_output_0_quantized_outRowReg);
              if(when_QLinearConvLineCore_l616) begin
                _stem_conv_Conv_output_0_quantized_realRowsRecvReg <= 6'h0;
                _stem_conv_Conv_output_0_quantized_rxBankReg <= 1'b0;
                _stem_conv_Conv_output_0_quantized_rxWordReg <= 4'b0000;
                _stem_conv_Conv_output_0_quantized_rowsUntilComputeReg <= 4'b0110;
                _stem_conv_Conv_output_0_quantized_rowWrPtrReg <= 4'b0100;
                _stem_conv_Conv_output_0_quantized_initSlotReg <= 4'b0000;
                _stem_conv_Conv_output_0_quantized_initAddrReg <= 4'b0000;
                _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sInit;
              end else begin
                _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sReceiveRow;
              end
            end else begin
              _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sLoadWeights;
            end
          end else begin
            _stem_conv_Conv_output_0_quantized_stateReg <= _stem_conv_Conv_output_0_quantized_sLoadWeights;
          end
        end
      end
      if(when_DepthwiseConvCore_l238) begin
        if(when_DepthwiseConvCore_l240) begin
          _blocks_blocks_0_dw_Conv_output_0_quantized_initAddrReg <= 14'h0;
          _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sReceive;
        end else begin
          _blocks_blocks_0_dw_Conv_output_0_quantized_initAddrReg <= (_blocks_blocks_0_dw_Conv_output_0_quantized_initAddrReg + 14'h0001);
        end
      end
      if(when_DepthwiseConvCore_l252) begin
        if(QLinearConvLineCorePlugin_logic_outStream_fire) begin
          _blocks_blocks_0_dw_Conv_output_0_quantized_rowElemReg <= (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_padWriteAddrReg ? 9'h0 : _zz__blocks_blocks_0_dw_Conv_output_0_quantized_rowElemReg);
          _blocks_blocks_0_dw_Conv_output_0_quantized_padWriteAddrReg <= (_blocks_blocks_0_dw_Conv_output_0_quantized_padWriteAddrReg + (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_padWriteAddrReg ? 14'h0081 : 14'h0001));
          _blocks_blocks_0_dw_Conv_output_0_quantized_recvCntReg <= (_blocks_blocks_0_dw_Conv_output_0_quantized_recvCntReg + 13'h0001);
          if(when_DepthwiseConvCore_l264) begin
            _blocks_blocks_0_dw_Conv_output_0_quantized_recvCntReg <= 13'h0;
            _blocks_blocks_0_dw_Conv_output_0_quantized_rowElemReg <= 9'h0;
            _blocks_blocks_0_dw_Conv_output_0_quantized_padWriteAddrReg <= 14'h0200;
            _blocks_blocks_0_dw_Conv_output_0_quantized_outRowReg <= 5'h0;
            _blocks_blocks_0_dw_Conv_output_0_quantized_outColReg <= 3'b000;
            _blocks_blocks_0_dw_Conv_output_0_quantized_outChReg <= 7'h0;
            _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sLoadBias;
          end
        end
      end
      if(when_DepthwiseConvCore_l278) begin
        _blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg <= (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_1 + _zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg_5);
        _blocks_blocks_0_dw_Conv_output_0_quantized_wAddrReg <= _zz__blocks_blocks_0_dw_Conv_output_0_quantized_wAddrReg[9:0];
        _blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
        _blocks_blocks_0_dw_Conv_output_0_quantized_rowStepReg <= 2'b00;
        _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sWaitBias;
      end
      if(when_DepthwiseConvCore_l289) begin
        _blocks_blocks_0_dw_Conv_output_0_quantized_accumReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_biasVal;
        _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sCompute;
      end
      if(when_DepthwiseConvCore_l303) begin
        _blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg <= (_blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg + 4'b0001);
        if(when_DepthwiseConvCore_l307) begin
          _blocks_blocks_0_dw_Conv_output_0_quantized_wAddrReg <= (_blocks_blocks_0_dw_Conv_output_0_quantized_wAddrReg + 10'h001);
          _blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg <= (_blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg + (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg ? 14'h0140 : 14'h0040));
          _blocks_blocks_0_dw_Conv_output_0_quantized_rowStepReg <= (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_inAddrReg ? 2'b00 : _zz__blocks_blocks_0_dw_Conv_output_0_quantized_rowStepReg);
        end
        if(when_DepthwiseConvCore_l319) begin
          _blocks_blocks_0_dw_Conv_output_0_quantized_inValReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_inValR;
          _blocks_blocks_0_dw_Conv_output_0_quantized_wValReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_wValR;
        end
        if(when_DepthwiseConvCore_l325) begin
          _blocks_blocks_0_dw_Conv_output_0_quantized_prodReg <= {{14{_zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg[17]}}, _zz__blocks_blocks_0_dw_Conv_output_0_quantized_prodReg};
        end
        if(when_DepthwiseConvCore_l334) begin
          _blocks_blocks_0_dw_Conv_output_0_quantized_accumReg <= _zz__blocks_blocks_0_dw_Conv_output_0_quantized_accumReg;
          if(when_DepthwiseConvCore_l337) begin
            _blocks_blocks_0_dw_Conv_output_0_quantized_accumRequantReg <= _zz__blocks_blocks_0_dw_Conv_output_0_quantized_accumReg;
            _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sRequant;
            _blocks_blocks_0_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
          end
        end
      end
      if(when_DepthwiseConvCore_l346) begin
        _blocks_blocks_0_dw_Conv_output_0_quantized_absAReg <= _zz__blocks_blocks_0_dw_Conv_output_0_quantized_absAReg;
        _blocks_blocks_0_dw_Conv_output_0_quantized_signAReg <= ($signed(_blocks_blocks_0_dw_Conv_output_0_quantized_accumRequantReg) < $signed(32'h0));
        _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantMul;
      end
      if(when_DepthwiseConvCore_l352) begin
        _blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg <= (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg * _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg_1);
        _blocks_blocks_0_dw_Conv_output_0_quantized_pLH_Reg <= (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg * _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLH_Reg);
        _blocks_blocks_0_dw_Conv_output_0_quantized_pHL_Reg <= (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_pHL_Reg * _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg_1);
        _blocks_blocks_0_dw_Conv_output_0_quantized_pHH_Reg <= (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_pHL_Reg * _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pLH_Reg);
        _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait;
      end
      if(when_DepthwiseConvCore_l362) begin
        _blocks_blocks_0_dw_Conv_output_0_quantized_pSumReg <= (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_pSumReg + _zz__blocks_blocks_0_dw_Conv_output_0_quantized_pSumReg_1);
        _blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg2 <= _blocks_blocks_0_dw_Conv_output_0_quantized_pLL_Reg;
        _blocks_blocks_0_dw_Conv_output_0_quantized_pHH_Reg2 <= _blocks_blocks_0_dw_Conv_output_0_quantized_pHH_Reg;
        _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait2;
      end
      if(when_DepthwiseConvCore_l368) begin
        _blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg <= (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg + _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part1Reg_1);
        _blocks_blocks_0_dw_Conv_output_0_quantized_part2Reg <= _zz__blocks_blocks_0_dw_Conv_output_0_quantized_part2Reg[63:0];
        _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantWait3;
      end
      if(when_DepthwiseConvCore_l374) begin
        _blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2 <= (_blocks_blocks_0_dw_Conv_output_0_quantized_signAReg ? _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2_1 : _zz__blocks_blocks_0_dw_Conv_output_0_quantized_reqProdReg2_3);
        _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sRequantShift;
      end
      if(when_DepthwiseConvCore_l381) begin
        _blocks_blocks_0_dw_Conv_output_0_quantized_resultReg <= (($signed(32'h0000007f) < $signed(_zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg)) ? 8'h7f : _zz__blocks_blocks_0_dw_Conv_output_0_quantized_resultReg_1);
        _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_dw_Conv_output_0_quantized_sEmit;
      end
      if(when_DepthwiseConvCore_l398) begin
        if(_blocks_blocks_0_dw_Conv_output_0_quantized_activationOut_fire) begin
          _blocks_blocks_0_dw_Conv_output_0_quantized_outChReg <= (when_DepthwiseConvCore_l410 ? 7'h0 : _zz__blocks_blocks_0_dw_Conv_output_0_quantized_outChReg);
          if(when_DepthwiseConvCore_l410) begin
            _blocks_blocks_0_dw_Conv_output_0_quantized_outColReg <= (when_DepthwiseConvCore_l414 ? 3'b000 : _zz__blocks_blocks_0_dw_Conv_output_0_quantized_outColReg);
            if(when_DepthwiseConvCore_l414) begin
              _blocks_blocks_0_dw_Conv_output_0_quantized_outRowReg <= (_zz__blocks_blocks_0_dw_Conv_output_0_quantized_stateReg ? 5'h0 : _zz__blocks_blocks_0_dw_Conv_output_0_quantized_outRowReg);
            end
          end
          _blocks_blocks_0_dw_Conv_output_0_quantized_stateReg <= (((when_DepthwiseConvCore_l410 && when_DepthwiseConvCore_l414) && _zz__blocks_blocks_0_dw_Conv_output_0_quantized_stateReg) ? _blocks_blocks_0_dw_Conv_output_0_quantized_sReceive : _blocks_blocks_0_dw_Conv_output_0_quantized_sLoadBias);
        end
      end
      if(when_QLinearConvLineCore_l346_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_0 <= DepthwiseConvPlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l346_2) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_1 <= DepthwiseConvPlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l346_3) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_2 <= DepthwiseConvPlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l346_4) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_3 <= DepthwiseConvPlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l346_5) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_4 <= DepthwiseConvPlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l346_6) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_5 <= DepthwiseConvPlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l346_7) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_6 <= DepthwiseConvPlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l346_8) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rxByteRegs_7 <= DepthwiseConvPlugin_logic_outStream_payload_value;
      end
      if(when_QLinearConvLineCore_l406_1) begin
        if(when_QLinearConvLineCore_l410_1) begin
          _blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg <= (when_QLinearConvLineCore_l413_1 ? 4'b0000 : _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg);
          if(when_QLinearConvLineCore_l413_1) begin
            _blocks_blocks_0_pw_Conv_output_0_quantized_rxWordReg <= (_blocks_blocks_0_pw_Conv_output_0_quantized_rxWordReg + 6'h01);
          end
          if(when_QLinearConvLineCore_l418_1) begin
            _blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
            _blocks_blocks_0_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
            _blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg <= ((_blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg == 1'b0) ? 1'b0 : _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg);
            if(_blocks_blocks_0_pw_Conv_output_0_quantized_isReal) begin
              _blocks_blocks_0_pw_Conv_output_0_quantized_realRowsRecvReg <= (_blocks_blocks_0_pw_Conv_output_0_quantized_realRowsRecvReg + 5'h01);
            end
            if(when_QLinearConvLineCore_l424_1) begin
              _blocks_blocks_0_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
              _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sLoadWeights;
            end else begin
              _blocks_blocks_0_pw_Conv_output_0_quantized_rowsUntilComputeReg <= (_blocks_blocks_0_pw_Conv_output_0_quantized_rowsUntilComputeReg - 1'b1);
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l438_1) begin
        if(when_QLinearConvLineCore_l439_1) begin
          if(_blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_fire) begin
            _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatBuf <= _blocks_blocks_0_pw_Conv_output_0_quantized_weightIn_payload;
            _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatDraining <= 1'b1;
            _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatStepReg <= 4'b0000;
          end
        end else begin
          if(when_QLinearConvLineCore_l448_1) begin
            _blocks_blocks_0_pw_Conv_output_0_quantized_wStepReg <= (_blocks_blocks_0_pw_Conv_output_0_quantized_wStepReg + 4'b0001);
          end
          _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatBuf <= {64'd0, _zz__blocks_blocks_0_pw_Conv_output_0_quantized_wBeatBuf};
          _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatStepReg <= (_blocks_blocks_0_pw_Conv_output_0_quantized_wBeatStepReg + 4'b0001);
          if(when_QLinearConvLineCore_l454_1) begin
            _blocks_blocks_0_pw_Conv_output_0_quantized_wBeatDraining <= 1'b0;
            if(when_QLinearConvLineCore_l456_1) begin
              _blocks_blocks_0_pw_Conv_output_0_quantized_wStepReg <= 4'b0000;
              _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sLoadBias;
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l466_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrBaseReg <= _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrBaseReg[5:0];
        _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrReg <= _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrBaseReg[5:0];
        _blocks_blocks_0_pw_Conv_output_0_quantized_wAddrReg <= 4'b0000;
        _blocks_blocks_0_pw_Conv_output_0_quantized_khCntReg <= 1'b0;
        _blocks_blocks_0_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
        _blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
        _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sWaitBias;
      end
      if(when_QLinearConvLineCore_l479_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_0 <= _blocks_blocks_0_pw_Conv_output_0_quantized_biasVal;
        _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sCompute;
      end
      if(when_QLinearConvLineCore_l485_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg <= (_blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg + 4'b0001);
        if(when_QLinearConvLineCore_l489_1) begin
          _blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg <= ((2'b01 <= _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg) ? _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_1 : _zz__blocks_blocks_0_pw_Conv_output_0_quantized_curSlotReg_3);
          _blocks_blocks_0_pw_Conv_output_0_quantized_wAddrReg <= (_blocks_blocks_0_pw_Conv_output_0_quantized_wAddrReg + 4'b0001);
          if(when_QLinearConvLineCore_l493_1) begin
            _blocks_blocks_0_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
            _blocks_blocks_0_pw_Conv_output_0_quantized_khCntReg <= (_blocks_blocks_0_pw_Conv_output_0_quantized_khCntReg + 1'b1);
            _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrBaseReg;
          end else begin
            _blocks_blocks_0_pw_Conv_output_0_quantized_rowStepReg <= (_blocks_blocks_0_pw_Conv_output_0_quantized_rowStepReg + 4'b0001);
            _blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrReg <= (_blocks_blocks_0_pw_Conv_output_0_quantized_rowAddrReg + 6'h01);
          end
        end
        if(when_QLinearConvLineCore_l505_1) begin
          _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_0 <= _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_0;
          _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_0 <= _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_0;
          _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_1 <= _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_1;
          _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_1 <= _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_1;
          _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_2 <= _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_2;
          _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_2 <= _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_2;
          _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_3 <= _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_3;
          _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_3 <= _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_3;
          _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_4 <= _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_4;
          _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_4 <= _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_4;
          _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_5 <= _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_5;
          _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_5 <= _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_5;
          _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_6 <= _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_6;
          _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_6 <= _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_6;
          _blocks_blocks_0_pw_Conv_output_0_quantized_inValReg_7 <= _blocks_blocks_0_pw_Conv_output_0_quantized_rowReads2D_0_7;
          _blocks_blocks_0_pw_Conv_output_0_quantized_wValReg_7 <= _blocks_blocks_0_pw_Conv_output_0_quantized_wValsRaw_7;
        end
        if(when_QLinearConvLineCore_l515_1) begin
          _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1 <= ($signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_2) + $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_1_29));
        end
        if(when_QLinearConvLineCore_l532_1) begin
          _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_0 <= _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_0;
          if(when_QLinearConvLineCore_l535_1) begin
            _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_3 <= _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_0;
            _blocks_blocks_0_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
            _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sRequant;
          end
        end
      end
      if(when_QLinearConvLineCore_l545_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6 <= _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_6;
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_5 <= ($signed(_blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_3) < $signed(32'h0));
        _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantMul;
      end
      if(when_QLinearConvLineCore_l551_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7 <= (_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7 * _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7_1);
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_8 <= (_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7 * _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_8);
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_9 <= (_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_9 * _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7_1);
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_10 <= (_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_9 * _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_8);
        _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait;
      end
      if(when_QLinearConvLineCore_l563_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_11 <= (_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_11 + _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_11_1);
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_12 <= _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_7;
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_13 <= _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_10;
        _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait2;
      end
      if(when_QLinearConvLineCore_l570_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14 <= (_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14 + _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_14_1);
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_15 <= _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_15[63:0];
        _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantWait3;
      end
      if(when_QLinearConvLineCore_l576_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4 <= (_blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_5 ? _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4_1 : _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_4_3);
        _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sRequantShift;
      end
      if(when_QLinearConvLineCore_l583_1) begin
        _blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2 <= (($signed(32'h0000007f) < $signed(_zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2)) ? 8'h7f : _zz__blocks_blocks_0_pw_Conv_output_0_quantized_rqReg_2_1);
        _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sEmit;
      end
      if(when_QLinearConvLineCore_l596_1) begin
        if(_blocks_blocks_0_pw_Conv_output_0_quantized_activationOut_fire) begin
          _blocks_blocks_0_pw_Conv_output_0_quantized_outChReg <= (when_QLinearConvLineCore_l608_1 ? 7'h0 : _zz__blocks_blocks_0_pw_Conv_output_0_quantized_outChReg);
          if(when_QLinearConvLineCore_l608_1) begin
            _blocks_blocks_0_pw_Conv_output_0_quantized_outColReg <= (when_QLinearConvLineCore_l612_1 ? 3'b000 : _zz__blocks_blocks_0_pw_Conv_output_0_quantized_outColReg);
            if(when_QLinearConvLineCore_l612_1) begin
              _blocks_blocks_0_pw_Conv_output_0_quantized_outRowReg <= (when_QLinearConvLineCore_l616_1 ? 5'h0 : _zz__blocks_blocks_0_pw_Conv_output_0_quantized_outRowReg);
              if(when_QLinearConvLineCore_l616_1) begin
                _blocks_blocks_0_pw_Conv_output_0_quantized_realRowsRecvReg <= 5'h0;
                _blocks_blocks_0_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
                _blocks_blocks_0_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
                _blocks_blocks_0_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
                _blocks_blocks_0_pw_Conv_output_0_quantized_rowWrPtrReg <= 1'b0;
                _blocks_blocks_0_pw_Conv_output_0_quantized_initSlotReg <= 1'b0;
                _blocks_blocks_0_pw_Conv_output_0_quantized_initAddrReg <= 6'h0;
                _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow;
              end else begin
                _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sReceiveRow;
              end
            end else begin
              _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sLoadWeights;
            end
          end else begin
            _blocks_blocks_0_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_0_pw_Conv_output_0_quantized_sLoadWeights;
          end
        end
      end
      if(when_DepthwiseConvCore_l238_1) begin
        if(when_DepthwiseConvCore_l240_1) begin
          _blocks_blocks_1_dw_Conv_output_0_quantized_initAddrReg <= 14'h0;
          _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sReceive;
        end else begin
          _blocks_blocks_1_dw_Conv_output_0_quantized_initAddrReg <= (_blocks_blocks_1_dw_Conv_output_0_quantized_initAddrReg + 14'h0001);
        end
      end
      if(when_DepthwiseConvCore_l252_1) begin
        if(QLinearConvLineCorePlugin_logic_outStream_fire_1) begin
          _blocks_blocks_1_dw_Conv_output_0_quantized_rowElemReg <= (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_padWriteAddrReg ? 9'h0 : _zz__blocks_blocks_1_dw_Conv_output_0_quantized_rowElemReg);
          _blocks_blocks_1_dw_Conv_output_0_quantized_padWriteAddrReg <= (_blocks_blocks_1_dw_Conv_output_0_quantized_padWriteAddrReg + (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_padWriteAddrReg ? 14'h0081 : 14'h0001));
          _blocks_blocks_1_dw_Conv_output_0_quantized_recvCntReg <= (_blocks_blocks_1_dw_Conv_output_0_quantized_recvCntReg + 13'h0001);
          if(when_DepthwiseConvCore_l264_1) begin
            _blocks_blocks_1_dw_Conv_output_0_quantized_recvCntReg <= 13'h0;
            _blocks_blocks_1_dw_Conv_output_0_quantized_rowElemReg <= 9'h0;
            _blocks_blocks_1_dw_Conv_output_0_quantized_padWriteAddrReg <= 14'h0200;
            _blocks_blocks_1_dw_Conv_output_0_quantized_outRowReg <= 5'h0;
            _blocks_blocks_1_dw_Conv_output_0_quantized_outColReg <= 3'b000;
            _blocks_blocks_1_dw_Conv_output_0_quantized_outChReg <= 7'h0;
            _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sLoadBias;
          end
        end
      end
      if(when_DepthwiseConvCore_l278_1) begin
        _blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg <= (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_1 + _zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg_5);
        _blocks_blocks_1_dw_Conv_output_0_quantized_wAddrReg <= _zz__blocks_blocks_1_dw_Conv_output_0_quantized_wAddrReg[9:0];
        _blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
        _blocks_blocks_1_dw_Conv_output_0_quantized_rowStepReg <= 2'b00;
        _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sWaitBias;
      end
      if(when_DepthwiseConvCore_l289_1) begin
        _blocks_blocks_1_dw_Conv_output_0_quantized_accumReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_biasVal;
        _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sCompute;
      end
      if(when_DepthwiseConvCore_l303_1) begin
        _blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg <= (_blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg + 4'b0001);
        if(when_DepthwiseConvCore_l307_1) begin
          _blocks_blocks_1_dw_Conv_output_0_quantized_wAddrReg <= (_blocks_blocks_1_dw_Conv_output_0_quantized_wAddrReg + 10'h001);
          _blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg <= (_blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg + (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg ? 14'h0140 : 14'h0040));
          _blocks_blocks_1_dw_Conv_output_0_quantized_rowStepReg <= (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_inAddrReg ? 2'b00 : _zz__blocks_blocks_1_dw_Conv_output_0_quantized_rowStepReg);
        end
        if(when_DepthwiseConvCore_l319_1) begin
          _blocks_blocks_1_dw_Conv_output_0_quantized_inValReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_inValR;
          _blocks_blocks_1_dw_Conv_output_0_quantized_wValReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_wValR;
        end
        if(when_DepthwiseConvCore_l325_1) begin
          _blocks_blocks_1_dw_Conv_output_0_quantized_prodReg <= {{14{_zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg[17]}}, _zz__blocks_blocks_1_dw_Conv_output_0_quantized_prodReg};
        end
        if(when_DepthwiseConvCore_l334_1) begin
          _blocks_blocks_1_dw_Conv_output_0_quantized_accumReg <= _zz__blocks_blocks_1_dw_Conv_output_0_quantized_accumReg;
          if(when_DepthwiseConvCore_l337_1) begin
            _blocks_blocks_1_dw_Conv_output_0_quantized_accumRequantReg <= _zz__blocks_blocks_1_dw_Conv_output_0_quantized_accumReg;
            _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sRequant;
            _blocks_blocks_1_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
          end
        end
      end
      if(when_DepthwiseConvCore_l346_1) begin
        _blocks_blocks_1_dw_Conv_output_0_quantized_absAReg <= _zz__blocks_blocks_1_dw_Conv_output_0_quantized_absAReg;
        _blocks_blocks_1_dw_Conv_output_0_quantized_signAReg <= ($signed(_blocks_blocks_1_dw_Conv_output_0_quantized_accumRequantReg) < $signed(32'h0));
        _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantMul;
      end
      if(when_DepthwiseConvCore_l352_1) begin
        _blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg <= (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg * _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg_1);
        _blocks_blocks_1_dw_Conv_output_0_quantized_pLH_Reg <= (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg * _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLH_Reg);
        _blocks_blocks_1_dw_Conv_output_0_quantized_pHL_Reg <= (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_pHL_Reg * _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg_1);
        _blocks_blocks_1_dw_Conv_output_0_quantized_pHH_Reg <= (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_pHL_Reg * _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pLH_Reg);
        _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait;
      end
      if(when_DepthwiseConvCore_l362_1) begin
        _blocks_blocks_1_dw_Conv_output_0_quantized_pSumReg <= (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_pSumReg + _zz__blocks_blocks_1_dw_Conv_output_0_quantized_pSumReg_1);
        _blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg2 <= _blocks_blocks_1_dw_Conv_output_0_quantized_pLL_Reg;
        _blocks_blocks_1_dw_Conv_output_0_quantized_pHH_Reg2 <= _blocks_blocks_1_dw_Conv_output_0_quantized_pHH_Reg;
        _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait2;
      end
      if(when_DepthwiseConvCore_l368_1) begin
        _blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg <= (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg + _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part1Reg_1);
        _blocks_blocks_1_dw_Conv_output_0_quantized_part2Reg <= _zz__blocks_blocks_1_dw_Conv_output_0_quantized_part2Reg[63:0];
        _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantWait3;
      end
      if(when_DepthwiseConvCore_l374_1) begin
        _blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2 <= (_blocks_blocks_1_dw_Conv_output_0_quantized_signAReg ? _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2_1 : _zz__blocks_blocks_1_dw_Conv_output_0_quantized_reqProdReg2_3);
        _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sRequantShift;
      end
      if(when_DepthwiseConvCore_l381_1) begin
        _blocks_blocks_1_dw_Conv_output_0_quantized_resultReg <= (($signed(32'h0000007f) < $signed(_zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg)) ? 8'h7f : _zz__blocks_blocks_1_dw_Conv_output_0_quantized_resultReg_1);
        _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_dw_Conv_output_0_quantized_sEmit;
      end
      if(when_DepthwiseConvCore_l398_1) begin
        if(_blocks_blocks_1_dw_Conv_output_0_quantized_activationOut_fire) begin
          _blocks_blocks_1_dw_Conv_output_0_quantized_outChReg <= (when_DepthwiseConvCore_l410_1 ? 7'h0 : _zz__blocks_blocks_1_dw_Conv_output_0_quantized_outChReg);
          if(when_DepthwiseConvCore_l410_1) begin
            _blocks_blocks_1_dw_Conv_output_0_quantized_outColReg <= (when_DepthwiseConvCore_l414_1 ? 3'b000 : _zz__blocks_blocks_1_dw_Conv_output_0_quantized_outColReg);
            if(when_DepthwiseConvCore_l414_1) begin
              _blocks_blocks_1_dw_Conv_output_0_quantized_outRowReg <= (_zz__blocks_blocks_1_dw_Conv_output_0_quantized_stateReg ? 5'h0 : _zz__blocks_blocks_1_dw_Conv_output_0_quantized_outRowReg);
            end
          end
          _blocks_blocks_1_dw_Conv_output_0_quantized_stateReg <= (((when_DepthwiseConvCore_l410_1 && when_DepthwiseConvCore_l414_1) && _zz__blocks_blocks_1_dw_Conv_output_0_quantized_stateReg) ? _blocks_blocks_1_dw_Conv_output_0_quantized_sReceive : _blocks_blocks_1_dw_Conv_output_0_quantized_sLoadBias);
        end
      end
      if(when_QLinearConvLineCore_l346_9) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_0 <= DepthwiseConvPlugin_logic_outStream_payload_value_1;
      end
      if(when_QLinearConvLineCore_l346_10) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_1 <= DepthwiseConvPlugin_logic_outStream_payload_value_1;
      end
      if(when_QLinearConvLineCore_l346_11) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_2 <= DepthwiseConvPlugin_logic_outStream_payload_value_1;
      end
      if(when_QLinearConvLineCore_l346_12) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_3 <= DepthwiseConvPlugin_logic_outStream_payload_value_1;
      end
      if(when_QLinearConvLineCore_l346_13) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_4 <= DepthwiseConvPlugin_logic_outStream_payload_value_1;
      end
      if(when_QLinearConvLineCore_l346_14) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_5 <= DepthwiseConvPlugin_logic_outStream_payload_value_1;
      end
      if(when_QLinearConvLineCore_l346_15) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_6 <= DepthwiseConvPlugin_logic_outStream_payload_value_1;
      end
      if(when_QLinearConvLineCore_l346_16) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rxByteRegs_7 <= DepthwiseConvPlugin_logic_outStream_payload_value_1;
      end
      if(when_QLinearConvLineCore_l406_2) begin
        if(when_QLinearConvLineCore_l410_2) begin
          _blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg <= (when_QLinearConvLineCore_l413_2 ? 4'b0000 : _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg);
          if(when_QLinearConvLineCore_l413_2) begin
            _blocks_blocks_1_pw_Conv_output_0_quantized_rxWordReg <= (_blocks_blocks_1_pw_Conv_output_0_quantized_rxWordReg + 6'h01);
          end
          if(when_QLinearConvLineCore_l418_2) begin
            _blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
            _blocks_blocks_1_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
            _blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg <= ((_blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg == 1'b0) ? 1'b0 : _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg);
            if(_blocks_blocks_1_pw_Conv_output_0_quantized_isReal) begin
              _blocks_blocks_1_pw_Conv_output_0_quantized_realRowsRecvReg <= (_blocks_blocks_1_pw_Conv_output_0_quantized_realRowsRecvReg + 5'h01);
            end
            if(when_QLinearConvLineCore_l424_2) begin
              _blocks_blocks_1_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
              _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sLoadWeights;
            end else begin
              _blocks_blocks_1_pw_Conv_output_0_quantized_rowsUntilComputeReg <= (_blocks_blocks_1_pw_Conv_output_0_quantized_rowsUntilComputeReg - 1'b1);
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l438_2) begin
        if(when_QLinearConvLineCore_l439_2) begin
          if(_blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_fire) begin
            _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatBuf <= _blocks_blocks_1_pw_Conv_output_0_quantized_weightIn_payload;
            _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatDraining <= 1'b1;
            _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatStepReg <= 4'b0000;
          end
        end else begin
          if(when_QLinearConvLineCore_l448_2) begin
            _blocks_blocks_1_pw_Conv_output_0_quantized_wStepReg <= (_blocks_blocks_1_pw_Conv_output_0_quantized_wStepReg + 4'b0001);
          end
          _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatBuf <= {64'd0, _zz__blocks_blocks_1_pw_Conv_output_0_quantized_wBeatBuf};
          _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatStepReg <= (_blocks_blocks_1_pw_Conv_output_0_quantized_wBeatStepReg + 4'b0001);
          if(when_QLinearConvLineCore_l454_2) begin
            _blocks_blocks_1_pw_Conv_output_0_quantized_wBeatDraining <= 1'b0;
            if(when_QLinearConvLineCore_l456_2) begin
              _blocks_blocks_1_pw_Conv_output_0_quantized_wStepReg <= 4'b0000;
              _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sLoadBias;
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l466_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrBaseReg <= _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrBaseReg[5:0];
        _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrReg <= _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrBaseReg[5:0];
        _blocks_blocks_1_pw_Conv_output_0_quantized_wAddrReg <= 4'b0000;
        _blocks_blocks_1_pw_Conv_output_0_quantized_khCntReg <= 1'b0;
        _blocks_blocks_1_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
        _blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
        _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sWaitBias;
      end
      if(when_QLinearConvLineCore_l479_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_0 <= _blocks_blocks_1_pw_Conv_output_0_quantized_biasVal;
        _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sCompute;
      end
      if(when_QLinearConvLineCore_l485_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg <= (_blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg + 4'b0001);
        if(when_QLinearConvLineCore_l489_2) begin
          _blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg <= ((2'b01 <= _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg) ? _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_1 : _zz__blocks_blocks_1_pw_Conv_output_0_quantized_curSlotReg_3);
          _blocks_blocks_1_pw_Conv_output_0_quantized_wAddrReg <= (_blocks_blocks_1_pw_Conv_output_0_quantized_wAddrReg + 4'b0001);
          if(when_QLinearConvLineCore_l493_2) begin
            _blocks_blocks_1_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
            _blocks_blocks_1_pw_Conv_output_0_quantized_khCntReg <= (_blocks_blocks_1_pw_Conv_output_0_quantized_khCntReg + 1'b1);
            _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrBaseReg;
          end else begin
            _blocks_blocks_1_pw_Conv_output_0_quantized_rowStepReg <= (_blocks_blocks_1_pw_Conv_output_0_quantized_rowStepReg + 4'b0001);
            _blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrReg <= (_blocks_blocks_1_pw_Conv_output_0_quantized_rowAddrReg + 6'h01);
          end
        end
        if(when_QLinearConvLineCore_l505_2) begin
          _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_0 <= _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_0;
          _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_0 <= _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_0;
          _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_1 <= _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_1;
          _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_1 <= _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_1;
          _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_2 <= _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_2;
          _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_2 <= _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_2;
          _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_3 <= _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_3;
          _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_3 <= _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_3;
          _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_4 <= _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_4;
          _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_4 <= _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_4;
          _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_5 <= _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_5;
          _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_5 <= _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_5;
          _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_6 <= _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_6;
          _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_6 <= _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_6;
          _blocks_blocks_1_pw_Conv_output_0_quantized_inValReg_7 <= _blocks_blocks_1_pw_Conv_output_0_quantized_rowReads2D_0_7;
          _blocks_blocks_1_pw_Conv_output_0_quantized_wValReg_7 <= _blocks_blocks_1_pw_Conv_output_0_quantized_wValsRaw_7;
        end
        if(when_QLinearConvLineCore_l515_2) begin
          _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1 <= ($signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_2) + $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_1_29));
        end
        if(when_QLinearConvLineCore_l532_2) begin
          _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_0 <= _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_0;
          if(when_QLinearConvLineCore_l535_2) begin
            _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_3 <= _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_0;
            _blocks_blocks_1_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
            _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sRequant;
          end
        end
      end
      if(when_QLinearConvLineCore_l545_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6 <= _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_6;
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_5 <= ($signed(_blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_3) < $signed(32'h0));
        _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantMul;
      end
      if(when_QLinearConvLineCore_l551_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7 <= (_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7 * _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7_1);
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_8 <= (_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7 * _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_8);
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_9 <= (_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_9 * _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7_1);
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_10 <= (_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_9 * _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_8);
        _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait;
      end
      if(when_QLinearConvLineCore_l563_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_11 <= (_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_11 + _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_11_1);
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_12 <= _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_7;
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_13 <= _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_10;
        _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait2;
      end
      if(when_QLinearConvLineCore_l570_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14 <= (_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14 + _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_14_1);
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_15 <= _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_15[63:0];
        _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantWait3;
      end
      if(when_QLinearConvLineCore_l576_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4 <= (_blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_5 ? _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4_1 : _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_4_3);
        _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sRequantShift;
      end
      if(when_QLinearConvLineCore_l583_2) begin
        _blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2 <= (($signed(32'h0000007f) < $signed(_zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2)) ? 8'h7f : _zz__blocks_blocks_1_pw_Conv_output_0_quantized_rqReg_2_1);
        _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sEmit;
      end
      if(when_QLinearConvLineCore_l596_2) begin
        if(_blocks_blocks_1_pw_Conv_output_0_quantized_activationOut_fire) begin
          _blocks_blocks_1_pw_Conv_output_0_quantized_outChReg <= (when_QLinearConvLineCore_l608_2 ? 7'h0 : _zz__blocks_blocks_1_pw_Conv_output_0_quantized_outChReg);
          if(when_QLinearConvLineCore_l608_2) begin
            _blocks_blocks_1_pw_Conv_output_0_quantized_outColReg <= (when_QLinearConvLineCore_l612_2 ? 3'b000 : _zz__blocks_blocks_1_pw_Conv_output_0_quantized_outColReg);
            if(when_QLinearConvLineCore_l612_2) begin
              _blocks_blocks_1_pw_Conv_output_0_quantized_outRowReg <= (when_QLinearConvLineCore_l616_2 ? 5'h0 : _zz__blocks_blocks_1_pw_Conv_output_0_quantized_outRowReg);
              if(when_QLinearConvLineCore_l616_2) begin
                _blocks_blocks_1_pw_Conv_output_0_quantized_realRowsRecvReg <= 5'h0;
                _blocks_blocks_1_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
                _blocks_blocks_1_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
                _blocks_blocks_1_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
                _blocks_blocks_1_pw_Conv_output_0_quantized_rowWrPtrReg <= 1'b0;
                _blocks_blocks_1_pw_Conv_output_0_quantized_initSlotReg <= 1'b0;
                _blocks_blocks_1_pw_Conv_output_0_quantized_initAddrReg <= 6'h0;
                _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow;
              end else begin
                _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sReceiveRow;
              end
            end else begin
              _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sLoadWeights;
            end
          end else begin
            _blocks_blocks_1_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_1_pw_Conv_output_0_quantized_sLoadWeights;
          end
        end
      end
      if(when_DepthwiseConvCore_l238_2) begin
        if(when_DepthwiseConvCore_l240_2) begin
          _blocks_blocks_2_dw_Conv_output_0_quantized_initAddrReg <= 14'h0;
          _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sReceive;
        end else begin
          _blocks_blocks_2_dw_Conv_output_0_quantized_initAddrReg <= (_blocks_blocks_2_dw_Conv_output_0_quantized_initAddrReg + 14'h0001);
        end
      end
      if(when_DepthwiseConvCore_l252_2) begin
        if(QLinearConvLineCorePlugin_logic_outStream_fire_2) begin
          _blocks_blocks_2_dw_Conv_output_0_quantized_rowElemReg <= (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_padWriteAddrReg ? 9'h0 : _zz__blocks_blocks_2_dw_Conv_output_0_quantized_rowElemReg);
          _blocks_blocks_2_dw_Conv_output_0_quantized_padWriteAddrReg <= (_blocks_blocks_2_dw_Conv_output_0_quantized_padWriteAddrReg + (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_padWriteAddrReg ? 14'h0081 : 14'h0001));
          _blocks_blocks_2_dw_Conv_output_0_quantized_recvCntReg <= (_blocks_blocks_2_dw_Conv_output_0_quantized_recvCntReg + 13'h0001);
          if(when_DepthwiseConvCore_l264_2) begin
            _blocks_blocks_2_dw_Conv_output_0_quantized_recvCntReg <= 13'h0;
            _blocks_blocks_2_dw_Conv_output_0_quantized_rowElemReg <= 9'h0;
            _blocks_blocks_2_dw_Conv_output_0_quantized_padWriteAddrReg <= 14'h0200;
            _blocks_blocks_2_dw_Conv_output_0_quantized_outRowReg <= 5'h0;
            _blocks_blocks_2_dw_Conv_output_0_quantized_outColReg <= 3'b000;
            _blocks_blocks_2_dw_Conv_output_0_quantized_outChReg <= 7'h0;
            _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sLoadBias;
          end
        end
      end
      if(when_DepthwiseConvCore_l278_2) begin
        _blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg <= (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_1 + _zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg_5);
        _blocks_blocks_2_dw_Conv_output_0_quantized_wAddrReg <= _zz__blocks_blocks_2_dw_Conv_output_0_quantized_wAddrReg[9:0];
        _blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
        _blocks_blocks_2_dw_Conv_output_0_quantized_rowStepReg <= 2'b00;
        _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sWaitBias;
      end
      if(when_DepthwiseConvCore_l289_2) begin
        _blocks_blocks_2_dw_Conv_output_0_quantized_accumReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_biasVal;
        _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sCompute;
      end
      if(when_DepthwiseConvCore_l303_2) begin
        _blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg <= (_blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg + 4'b0001);
        if(when_DepthwiseConvCore_l307_2) begin
          _blocks_blocks_2_dw_Conv_output_0_quantized_wAddrReg <= (_blocks_blocks_2_dw_Conv_output_0_quantized_wAddrReg + 10'h001);
          _blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg <= (_blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg + (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg ? 14'h0140 : 14'h0040));
          _blocks_blocks_2_dw_Conv_output_0_quantized_rowStepReg <= (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_inAddrReg ? 2'b00 : _zz__blocks_blocks_2_dw_Conv_output_0_quantized_rowStepReg);
        end
        if(when_DepthwiseConvCore_l319_2) begin
          _blocks_blocks_2_dw_Conv_output_0_quantized_inValReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_inValR;
          _blocks_blocks_2_dw_Conv_output_0_quantized_wValReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_wValR;
        end
        if(when_DepthwiseConvCore_l325_2) begin
          _blocks_blocks_2_dw_Conv_output_0_quantized_prodReg <= {{14{_zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg[17]}}, _zz__blocks_blocks_2_dw_Conv_output_0_quantized_prodReg};
        end
        if(when_DepthwiseConvCore_l334_2) begin
          _blocks_blocks_2_dw_Conv_output_0_quantized_accumReg <= _zz__blocks_blocks_2_dw_Conv_output_0_quantized_accumReg;
          if(when_DepthwiseConvCore_l337_2) begin
            _blocks_blocks_2_dw_Conv_output_0_quantized_accumRequantReg <= _zz__blocks_blocks_2_dw_Conv_output_0_quantized_accumReg;
            _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sRequant;
            _blocks_blocks_2_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
          end
        end
      end
      if(when_DepthwiseConvCore_l346_2) begin
        _blocks_blocks_2_dw_Conv_output_0_quantized_absAReg <= _zz__blocks_blocks_2_dw_Conv_output_0_quantized_absAReg;
        _blocks_blocks_2_dw_Conv_output_0_quantized_signAReg <= ($signed(_blocks_blocks_2_dw_Conv_output_0_quantized_accumRequantReg) < $signed(32'h0));
        _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantMul;
      end
      if(when_DepthwiseConvCore_l352_2) begin
        _blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg <= (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg * _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg_1);
        _blocks_blocks_2_dw_Conv_output_0_quantized_pLH_Reg <= (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg * _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLH_Reg);
        _blocks_blocks_2_dw_Conv_output_0_quantized_pHL_Reg <= (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_pHL_Reg * _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg_1);
        _blocks_blocks_2_dw_Conv_output_0_quantized_pHH_Reg <= (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_pHL_Reg * _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pLH_Reg);
        _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait;
      end
      if(when_DepthwiseConvCore_l362_2) begin
        _blocks_blocks_2_dw_Conv_output_0_quantized_pSumReg <= (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_pSumReg + _zz__blocks_blocks_2_dw_Conv_output_0_quantized_pSumReg_1);
        _blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg2 <= _blocks_blocks_2_dw_Conv_output_0_quantized_pLL_Reg;
        _blocks_blocks_2_dw_Conv_output_0_quantized_pHH_Reg2 <= _blocks_blocks_2_dw_Conv_output_0_quantized_pHH_Reg;
        _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait2;
      end
      if(when_DepthwiseConvCore_l368_2) begin
        _blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg <= (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg + _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part1Reg_1);
        _blocks_blocks_2_dw_Conv_output_0_quantized_part2Reg <= _zz__blocks_blocks_2_dw_Conv_output_0_quantized_part2Reg[63:0];
        _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantWait3;
      end
      if(when_DepthwiseConvCore_l374_2) begin
        _blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2 <= (_blocks_blocks_2_dw_Conv_output_0_quantized_signAReg ? _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2_1 : _zz__blocks_blocks_2_dw_Conv_output_0_quantized_reqProdReg2_3);
        _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sRequantShift;
      end
      if(when_DepthwiseConvCore_l381_2) begin
        _blocks_blocks_2_dw_Conv_output_0_quantized_resultReg <= (($signed(32'h0000007f) < $signed(_zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg)) ? 8'h7f : _zz__blocks_blocks_2_dw_Conv_output_0_quantized_resultReg_1);
        _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_dw_Conv_output_0_quantized_sEmit;
      end
      if(when_DepthwiseConvCore_l398_2) begin
        if(_blocks_blocks_2_dw_Conv_output_0_quantized_activationOut_fire) begin
          _blocks_blocks_2_dw_Conv_output_0_quantized_outChReg <= (when_DepthwiseConvCore_l410_2 ? 7'h0 : _zz__blocks_blocks_2_dw_Conv_output_0_quantized_outChReg);
          if(when_DepthwiseConvCore_l410_2) begin
            _blocks_blocks_2_dw_Conv_output_0_quantized_outColReg <= (when_DepthwiseConvCore_l414_2 ? 3'b000 : _zz__blocks_blocks_2_dw_Conv_output_0_quantized_outColReg);
            if(when_DepthwiseConvCore_l414_2) begin
              _blocks_blocks_2_dw_Conv_output_0_quantized_outRowReg <= (_zz__blocks_blocks_2_dw_Conv_output_0_quantized_stateReg ? 5'h0 : _zz__blocks_blocks_2_dw_Conv_output_0_quantized_outRowReg);
            end
          end
          _blocks_blocks_2_dw_Conv_output_0_quantized_stateReg <= (((when_DepthwiseConvCore_l410_2 && when_DepthwiseConvCore_l414_2) && _zz__blocks_blocks_2_dw_Conv_output_0_quantized_stateReg) ? _blocks_blocks_2_dw_Conv_output_0_quantized_sReceive : _blocks_blocks_2_dw_Conv_output_0_quantized_sLoadBias);
        end
      end
      if(when_QLinearConvLineCore_l346_17) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_0 <= DepthwiseConvPlugin_logic_outStream_payload_value_2;
      end
      if(when_QLinearConvLineCore_l346_18) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_1 <= DepthwiseConvPlugin_logic_outStream_payload_value_2;
      end
      if(when_QLinearConvLineCore_l346_19) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_2 <= DepthwiseConvPlugin_logic_outStream_payload_value_2;
      end
      if(when_QLinearConvLineCore_l346_20) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_3 <= DepthwiseConvPlugin_logic_outStream_payload_value_2;
      end
      if(when_QLinearConvLineCore_l346_21) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_4 <= DepthwiseConvPlugin_logic_outStream_payload_value_2;
      end
      if(when_QLinearConvLineCore_l346_22) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_5 <= DepthwiseConvPlugin_logic_outStream_payload_value_2;
      end
      if(when_QLinearConvLineCore_l346_23) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_6 <= DepthwiseConvPlugin_logic_outStream_payload_value_2;
      end
      if(when_QLinearConvLineCore_l346_24) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rxByteRegs_7 <= DepthwiseConvPlugin_logic_outStream_payload_value_2;
      end
      if(when_QLinearConvLineCore_l406_3) begin
        if(when_QLinearConvLineCore_l410_3) begin
          _blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg <= (when_QLinearConvLineCore_l413_3 ? 4'b0000 : _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg);
          if(when_QLinearConvLineCore_l413_3) begin
            _blocks_blocks_2_pw_Conv_output_0_quantized_rxWordReg <= (_blocks_blocks_2_pw_Conv_output_0_quantized_rxWordReg + 6'h01);
          end
          if(when_QLinearConvLineCore_l418_3) begin
            _blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
            _blocks_blocks_2_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
            _blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg <= ((_blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg == 1'b0) ? 1'b0 : _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg);
            if(_blocks_blocks_2_pw_Conv_output_0_quantized_isReal) begin
              _blocks_blocks_2_pw_Conv_output_0_quantized_realRowsRecvReg <= (_blocks_blocks_2_pw_Conv_output_0_quantized_realRowsRecvReg + 5'h01);
            end
            if(when_QLinearConvLineCore_l424_3) begin
              _blocks_blocks_2_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
              _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sLoadWeights;
            end else begin
              _blocks_blocks_2_pw_Conv_output_0_quantized_rowsUntilComputeReg <= (_blocks_blocks_2_pw_Conv_output_0_quantized_rowsUntilComputeReg - 1'b1);
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l438_3) begin
        if(when_QLinearConvLineCore_l439_3) begin
          if(_blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_fire) begin
            _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatBuf <= _blocks_blocks_2_pw_Conv_output_0_quantized_weightIn_payload;
            _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatDraining <= 1'b1;
            _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatStepReg <= 4'b0000;
          end
        end else begin
          if(when_QLinearConvLineCore_l448_3) begin
            _blocks_blocks_2_pw_Conv_output_0_quantized_wStepReg <= (_blocks_blocks_2_pw_Conv_output_0_quantized_wStepReg + 4'b0001);
          end
          _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatBuf <= {64'd0, _zz__blocks_blocks_2_pw_Conv_output_0_quantized_wBeatBuf};
          _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatStepReg <= (_blocks_blocks_2_pw_Conv_output_0_quantized_wBeatStepReg + 4'b0001);
          if(when_QLinearConvLineCore_l454_3) begin
            _blocks_blocks_2_pw_Conv_output_0_quantized_wBeatDraining <= 1'b0;
            if(when_QLinearConvLineCore_l456_3) begin
              _blocks_blocks_2_pw_Conv_output_0_quantized_wStepReg <= 4'b0000;
              _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sLoadBias;
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l466_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrBaseReg <= _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrBaseReg[5:0];
        _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrReg <= _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrBaseReg[5:0];
        _blocks_blocks_2_pw_Conv_output_0_quantized_wAddrReg <= 4'b0000;
        _blocks_blocks_2_pw_Conv_output_0_quantized_khCntReg <= 1'b0;
        _blocks_blocks_2_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
        _blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
        _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sWaitBias;
      end
      if(when_QLinearConvLineCore_l479_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_0 <= _blocks_blocks_2_pw_Conv_output_0_quantized_biasVal;
        _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sCompute;
      end
      if(when_QLinearConvLineCore_l485_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg <= (_blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg + 4'b0001);
        if(when_QLinearConvLineCore_l489_3) begin
          _blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg <= ((2'b01 <= _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg) ? _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_1 : _zz__blocks_blocks_2_pw_Conv_output_0_quantized_curSlotReg_3);
          _blocks_blocks_2_pw_Conv_output_0_quantized_wAddrReg <= (_blocks_blocks_2_pw_Conv_output_0_quantized_wAddrReg + 4'b0001);
          if(when_QLinearConvLineCore_l493_3) begin
            _blocks_blocks_2_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
            _blocks_blocks_2_pw_Conv_output_0_quantized_khCntReg <= (_blocks_blocks_2_pw_Conv_output_0_quantized_khCntReg + 1'b1);
            _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrBaseReg;
          end else begin
            _blocks_blocks_2_pw_Conv_output_0_quantized_rowStepReg <= (_blocks_blocks_2_pw_Conv_output_0_quantized_rowStepReg + 4'b0001);
            _blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrReg <= (_blocks_blocks_2_pw_Conv_output_0_quantized_rowAddrReg + 6'h01);
          end
        end
        if(when_QLinearConvLineCore_l505_3) begin
          _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_0 <= _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_0;
          _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_0 <= _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_0;
          _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_1 <= _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_1;
          _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_1 <= _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_1;
          _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_2 <= _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_2;
          _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_2 <= _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_2;
          _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_3 <= _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_3;
          _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_3 <= _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_3;
          _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_4 <= _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_4;
          _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_4 <= _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_4;
          _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_5 <= _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_5;
          _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_5 <= _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_5;
          _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_6 <= _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_6;
          _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_6 <= _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_6;
          _blocks_blocks_2_pw_Conv_output_0_quantized_inValReg_7 <= _blocks_blocks_2_pw_Conv_output_0_quantized_rowReads2D_0_7;
          _blocks_blocks_2_pw_Conv_output_0_quantized_wValReg_7 <= _blocks_blocks_2_pw_Conv_output_0_quantized_wValsRaw_7;
        end
        if(when_QLinearConvLineCore_l515_3) begin
          _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1 <= ($signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_2) + $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_1_29));
        end
        if(when_QLinearConvLineCore_l532_3) begin
          _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_0 <= _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_0;
          if(when_QLinearConvLineCore_l535_3) begin
            _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_3 <= _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_0;
            _blocks_blocks_2_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
            _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sRequant;
          end
        end
      end
      if(when_QLinearConvLineCore_l545_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6 <= _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_6;
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_5 <= ($signed(_blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_3) < $signed(32'h0));
        _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantMul;
      end
      if(when_QLinearConvLineCore_l551_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7 <= (_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7 * _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7_1);
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_8 <= (_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7 * _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_8);
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_9 <= (_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_9 * _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7_1);
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_10 <= (_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_9 * _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_8);
        _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait;
      end
      if(when_QLinearConvLineCore_l563_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_11 <= (_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_11 + _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_11_1);
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_12 <= _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_7;
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_13 <= _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_10;
        _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait2;
      end
      if(when_QLinearConvLineCore_l570_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14 <= (_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14 + _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_14_1);
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_15 <= _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_15[63:0];
        _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantWait3;
      end
      if(when_QLinearConvLineCore_l576_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4 <= (_blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_5 ? _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4_1 : _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_4_3);
        _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sRequantShift;
      end
      if(when_QLinearConvLineCore_l583_3) begin
        _blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2 <= (($signed(32'h0000007f) < $signed(_zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2)) ? 8'h7f : _zz__blocks_blocks_2_pw_Conv_output_0_quantized_rqReg_2_1);
        _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sEmit;
      end
      if(when_QLinearConvLineCore_l596_3) begin
        if(_blocks_blocks_2_pw_Conv_output_0_quantized_activationOut_fire) begin
          _blocks_blocks_2_pw_Conv_output_0_quantized_outChReg <= (when_QLinearConvLineCore_l608_3 ? 7'h0 : _zz__blocks_blocks_2_pw_Conv_output_0_quantized_outChReg);
          if(when_QLinearConvLineCore_l608_3) begin
            _blocks_blocks_2_pw_Conv_output_0_quantized_outColReg <= (when_QLinearConvLineCore_l612_3 ? 3'b000 : _zz__blocks_blocks_2_pw_Conv_output_0_quantized_outColReg);
            if(when_QLinearConvLineCore_l612_3) begin
              _blocks_blocks_2_pw_Conv_output_0_quantized_outRowReg <= (when_QLinearConvLineCore_l616_3 ? 5'h0 : _zz__blocks_blocks_2_pw_Conv_output_0_quantized_outRowReg);
              if(when_QLinearConvLineCore_l616_3) begin
                _blocks_blocks_2_pw_Conv_output_0_quantized_realRowsRecvReg <= 5'h0;
                _blocks_blocks_2_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
                _blocks_blocks_2_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
                _blocks_blocks_2_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
                _blocks_blocks_2_pw_Conv_output_0_quantized_rowWrPtrReg <= 1'b0;
                _blocks_blocks_2_pw_Conv_output_0_quantized_initSlotReg <= 1'b0;
                _blocks_blocks_2_pw_Conv_output_0_quantized_initAddrReg <= 6'h0;
                _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow;
              end else begin
                _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sReceiveRow;
              end
            end else begin
              _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sLoadWeights;
            end
          end else begin
            _blocks_blocks_2_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_2_pw_Conv_output_0_quantized_sLoadWeights;
          end
        end
      end
      if(when_DepthwiseConvCore_l238_3) begin
        if(when_DepthwiseConvCore_l240_3) begin
          _blocks_blocks_3_dw_Conv_output_0_quantized_initAddrReg <= 14'h0;
          _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sReceive;
        end else begin
          _blocks_blocks_3_dw_Conv_output_0_quantized_initAddrReg <= (_blocks_blocks_3_dw_Conv_output_0_quantized_initAddrReg + 14'h0001);
        end
      end
      if(when_DepthwiseConvCore_l252_3) begin
        if(QLinearConvLineCorePlugin_logic_outStream_fire_3) begin
          _blocks_blocks_3_dw_Conv_output_0_quantized_rowElemReg <= (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_padWriteAddrReg ? 9'h0 : _zz__blocks_blocks_3_dw_Conv_output_0_quantized_rowElemReg);
          _blocks_blocks_3_dw_Conv_output_0_quantized_padWriteAddrReg <= (_blocks_blocks_3_dw_Conv_output_0_quantized_padWriteAddrReg + (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_padWriteAddrReg ? 14'h0081 : 14'h0001));
          _blocks_blocks_3_dw_Conv_output_0_quantized_recvCntReg <= (_blocks_blocks_3_dw_Conv_output_0_quantized_recvCntReg + 13'h0001);
          if(when_DepthwiseConvCore_l264_3) begin
            _blocks_blocks_3_dw_Conv_output_0_quantized_recvCntReg <= 13'h0;
            _blocks_blocks_3_dw_Conv_output_0_quantized_rowElemReg <= 9'h0;
            _blocks_blocks_3_dw_Conv_output_0_quantized_padWriteAddrReg <= 14'h0200;
            _blocks_blocks_3_dw_Conv_output_0_quantized_outRowReg <= 5'h0;
            _blocks_blocks_3_dw_Conv_output_0_quantized_outColReg <= 3'b000;
            _blocks_blocks_3_dw_Conv_output_0_quantized_outChReg <= 7'h0;
            _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sLoadBias;
          end
        end
      end
      if(when_DepthwiseConvCore_l278_3) begin
        _blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg <= (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_1 + _zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg_5);
        _blocks_blocks_3_dw_Conv_output_0_quantized_wAddrReg <= _zz__blocks_blocks_3_dw_Conv_output_0_quantized_wAddrReg[9:0];
        _blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
        _blocks_blocks_3_dw_Conv_output_0_quantized_rowStepReg <= 2'b00;
        _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sWaitBias;
      end
      if(when_DepthwiseConvCore_l289_3) begin
        _blocks_blocks_3_dw_Conv_output_0_quantized_accumReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_biasVal;
        _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sCompute;
      end
      if(when_DepthwiseConvCore_l303_3) begin
        _blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg <= (_blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg + 4'b0001);
        if(when_DepthwiseConvCore_l307_3) begin
          _blocks_blocks_3_dw_Conv_output_0_quantized_wAddrReg <= (_blocks_blocks_3_dw_Conv_output_0_quantized_wAddrReg + 10'h001);
          _blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg <= (_blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg + (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg ? 14'h0140 : 14'h0040));
          _blocks_blocks_3_dw_Conv_output_0_quantized_rowStepReg <= (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_inAddrReg ? 2'b00 : _zz__blocks_blocks_3_dw_Conv_output_0_quantized_rowStepReg);
        end
        if(when_DepthwiseConvCore_l319_3) begin
          _blocks_blocks_3_dw_Conv_output_0_quantized_inValReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_inValR;
          _blocks_blocks_3_dw_Conv_output_0_quantized_wValReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_wValR;
        end
        if(when_DepthwiseConvCore_l325_3) begin
          _blocks_blocks_3_dw_Conv_output_0_quantized_prodReg <= {{14{_zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg[17]}}, _zz__blocks_blocks_3_dw_Conv_output_0_quantized_prodReg};
        end
        if(when_DepthwiseConvCore_l334_3) begin
          _blocks_blocks_3_dw_Conv_output_0_quantized_accumReg <= _zz__blocks_blocks_3_dw_Conv_output_0_quantized_accumReg;
          if(when_DepthwiseConvCore_l337_3) begin
            _blocks_blocks_3_dw_Conv_output_0_quantized_accumRequantReg <= _zz__blocks_blocks_3_dw_Conv_output_0_quantized_accumReg;
            _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sRequant;
            _blocks_blocks_3_dw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
          end
        end
      end
      if(when_DepthwiseConvCore_l346_3) begin
        _blocks_blocks_3_dw_Conv_output_0_quantized_absAReg <= _zz__blocks_blocks_3_dw_Conv_output_0_quantized_absAReg;
        _blocks_blocks_3_dw_Conv_output_0_quantized_signAReg <= ($signed(_blocks_blocks_3_dw_Conv_output_0_quantized_accumRequantReg) < $signed(32'h0));
        _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantMul;
      end
      if(when_DepthwiseConvCore_l352_3) begin
        _blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg <= (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg * _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg_1);
        _blocks_blocks_3_dw_Conv_output_0_quantized_pLH_Reg <= (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg * _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLH_Reg);
        _blocks_blocks_3_dw_Conv_output_0_quantized_pHL_Reg <= (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_pHL_Reg * _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg_1);
        _blocks_blocks_3_dw_Conv_output_0_quantized_pHH_Reg <= (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_pHL_Reg * _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pLH_Reg);
        _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait;
      end
      if(when_DepthwiseConvCore_l362_3) begin
        _blocks_blocks_3_dw_Conv_output_0_quantized_pSumReg <= (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_pSumReg + _zz__blocks_blocks_3_dw_Conv_output_0_quantized_pSumReg_1);
        _blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg2 <= _blocks_blocks_3_dw_Conv_output_0_quantized_pLL_Reg;
        _blocks_blocks_3_dw_Conv_output_0_quantized_pHH_Reg2 <= _blocks_blocks_3_dw_Conv_output_0_quantized_pHH_Reg;
        _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait2;
      end
      if(when_DepthwiseConvCore_l368_3) begin
        _blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg <= (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg + _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part1Reg_1);
        _blocks_blocks_3_dw_Conv_output_0_quantized_part2Reg <= _zz__blocks_blocks_3_dw_Conv_output_0_quantized_part2Reg[63:0];
        _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantWait3;
      end
      if(when_DepthwiseConvCore_l374_3) begin
        _blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2 <= (_blocks_blocks_3_dw_Conv_output_0_quantized_signAReg ? _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2_1 : _zz__blocks_blocks_3_dw_Conv_output_0_quantized_reqProdReg2_3);
        _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sRequantShift;
      end
      if(when_DepthwiseConvCore_l381_3) begin
        _blocks_blocks_3_dw_Conv_output_0_quantized_resultReg <= (($signed(32'h0000007f) < $signed(_zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg)) ? 8'h7f : _zz__blocks_blocks_3_dw_Conv_output_0_quantized_resultReg_1);
        _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_dw_Conv_output_0_quantized_sEmit;
      end
      if(when_DepthwiseConvCore_l398_3) begin
        if(_blocks_blocks_3_dw_Conv_output_0_quantized_activationOut_fire) begin
          _blocks_blocks_3_dw_Conv_output_0_quantized_outChReg <= (when_DepthwiseConvCore_l410_3 ? 7'h0 : _zz__blocks_blocks_3_dw_Conv_output_0_quantized_outChReg);
          if(when_DepthwiseConvCore_l410_3) begin
            _blocks_blocks_3_dw_Conv_output_0_quantized_outColReg <= (when_DepthwiseConvCore_l414_3 ? 3'b000 : _zz__blocks_blocks_3_dw_Conv_output_0_quantized_outColReg);
            if(when_DepthwiseConvCore_l414_3) begin
              _blocks_blocks_3_dw_Conv_output_0_quantized_outRowReg <= (_zz__blocks_blocks_3_dw_Conv_output_0_quantized_stateReg ? 5'h0 : _zz__blocks_blocks_3_dw_Conv_output_0_quantized_outRowReg);
            end
          end
          _blocks_blocks_3_dw_Conv_output_0_quantized_stateReg <= (((when_DepthwiseConvCore_l410_3 && when_DepthwiseConvCore_l414_3) && _zz__blocks_blocks_3_dw_Conv_output_0_quantized_stateReg) ? _blocks_blocks_3_dw_Conv_output_0_quantized_sReceive : _blocks_blocks_3_dw_Conv_output_0_quantized_sLoadBias);
        end
      end
      if(when_QLinearConvLineCore_l346_25) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_0 <= DepthwiseConvPlugin_logic_outStream_payload_value_3;
      end
      if(when_QLinearConvLineCore_l346_26) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_1 <= DepthwiseConvPlugin_logic_outStream_payload_value_3;
      end
      if(when_QLinearConvLineCore_l346_27) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_2 <= DepthwiseConvPlugin_logic_outStream_payload_value_3;
      end
      if(when_QLinearConvLineCore_l346_28) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_3 <= DepthwiseConvPlugin_logic_outStream_payload_value_3;
      end
      if(when_QLinearConvLineCore_l346_29) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_4 <= DepthwiseConvPlugin_logic_outStream_payload_value_3;
      end
      if(when_QLinearConvLineCore_l346_30) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_5 <= DepthwiseConvPlugin_logic_outStream_payload_value_3;
      end
      if(when_QLinearConvLineCore_l346_31) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_6 <= DepthwiseConvPlugin_logic_outStream_payload_value_3;
      end
      if(when_QLinearConvLineCore_l346_32) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rxByteRegs_7 <= DepthwiseConvPlugin_logic_outStream_payload_value_3;
      end
      if(when_QLinearConvLineCore_l406_4) begin
        if(when_QLinearConvLineCore_l410_4) begin
          _blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg <= (when_QLinearConvLineCore_l413_4 ? 4'b0000 : _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg);
          if(when_QLinearConvLineCore_l413_4) begin
            _blocks_blocks_3_pw_Conv_output_0_quantized_rxWordReg <= (_blocks_blocks_3_pw_Conv_output_0_quantized_rxWordReg + 6'h01);
          end
          if(when_QLinearConvLineCore_l418_4) begin
            _blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
            _blocks_blocks_3_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
            _blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg <= ((_blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg == 1'b0) ? 1'b0 : _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg);
            if(_blocks_blocks_3_pw_Conv_output_0_quantized_isReal) begin
              _blocks_blocks_3_pw_Conv_output_0_quantized_realRowsRecvReg <= (_blocks_blocks_3_pw_Conv_output_0_quantized_realRowsRecvReg + 5'h01);
            end
            if(when_QLinearConvLineCore_l424_4) begin
              _blocks_blocks_3_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
              _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sLoadWeights;
            end else begin
              _blocks_blocks_3_pw_Conv_output_0_quantized_rowsUntilComputeReg <= (_blocks_blocks_3_pw_Conv_output_0_quantized_rowsUntilComputeReg - 1'b1);
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l438_4) begin
        if(when_QLinearConvLineCore_l439_4) begin
          if(_blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_fire) begin
            _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatBuf <= _blocks_blocks_3_pw_Conv_output_0_quantized_weightIn_payload;
            _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatDraining <= 1'b1;
            _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatStepReg <= 4'b0000;
          end
        end else begin
          if(when_QLinearConvLineCore_l448_4) begin
            _blocks_blocks_3_pw_Conv_output_0_quantized_wStepReg <= (_blocks_blocks_3_pw_Conv_output_0_quantized_wStepReg + 4'b0001);
          end
          _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatBuf <= {64'd0, _zz__blocks_blocks_3_pw_Conv_output_0_quantized_wBeatBuf};
          _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatStepReg <= (_blocks_blocks_3_pw_Conv_output_0_quantized_wBeatStepReg + 4'b0001);
          if(when_QLinearConvLineCore_l454_4) begin
            _blocks_blocks_3_pw_Conv_output_0_quantized_wBeatDraining <= 1'b0;
            if(when_QLinearConvLineCore_l456_4) begin
              _blocks_blocks_3_pw_Conv_output_0_quantized_wStepReg <= 4'b0000;
              _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sLoadBias;
            end
          end
        end
      end
      if(when_QLinearConvLineCore_l466_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrBaseReg <= _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrBaseReg[5:0];
        _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrReg <= _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrBaseReg[5:0];
        _blocks_blocks_3_pw_Conv_output_0_quantized_wAddrReg <= 4'b0000;
        _blocks_blocks_3_pw_Conv_output_0_quantized_khCntReg <= 1'b0;
        _blocks_blocks_3_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
        _blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
        _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sWaitBias;
      end
      if(when_QLinearConvLineCore_l479_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_0 <= _blocks_blocks_3_pw_Conv_output_0_quantized_biasVal;
        _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sCompute;
      end
      if(when_QLinearConvLineCore_l485_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg <= (_blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg + 4'b0001);
        if(when_QLinearConvLineCore_l489_4) begin
          _blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg <= ((2'b01 <= _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg) ? _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_1 : _zz__blocks_blocks_3_pw_Conv_output_0_quantized_curSlotReg_3);
          _blocks_blocks_3_pw_Conv_output_0_quantized_wAddrReg <= (_blocks_blocks_3_pw_Conv_output_0_quantized_wAddrReg + 4'b0001);
          if(when_QLinearConvLineCore_l493_4) begin
            _blocks_blocks_3_pw_Conv_output_0_quantized_rowStepReg <= 4'b0000;
            _blocks_blocks_3_pw_Conv_output_0_quantized_khCntReg <= (_blocks_blocks_3_pw_Conv_output_0_quantized_khCntReg + 1'b1);
            _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrBaseReg;
          end else begin
            _blocks_blocks_3_pw_Conv_output_0_quantized_rowStepReg <= (_blocks_blocks_3_pw_Conv_output_0_quantized_rowStepReg + 4'b0001);
            _blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrReg <= (_blocks_blocks_3_pw_Conv_output_0_quantized_rowAddrReg + 6'h01);
          end
        end
        if(when_QLinearConvLineCore_l505_4) begin
          _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_0 <= _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_0;
          _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_0 <= _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_0;
          _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_1 <= _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_1;
          _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_1 <= _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_1;
          _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_2 <= _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_2;
          _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_2 <= _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_2;
          _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_3 <= _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_3;
          _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_3 <= _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_3;
          _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_4 <= _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_4;
          _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_4 <= _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_4;
          _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_5 <= _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_5;
          _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_5 <= _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_5;
          _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_6 <= _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_6;
          _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_6 <= _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_6;
          _blocks_blocks_3_pw_Conv_output_0_quantized_inValReg_7 <= _blocks_blocks_3_pw_Conv_output_0_quantized_rowReads2D_0_7;
          _blocks_blocks_3_pw_Conv_output_0_quantized_wValReg_7 <= _blocks_blocks_3_pw_Conv_output_0_quantized_wValsRaw_7;
        end
        if(when_QLinearConvLineCore_l515_4) begin
          _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1 <= ($signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_2) + $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_1_29));
        end
        if(when_QLinearConvLineCore_l532_4) begin
          _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_0 <= _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_0;
          if(when_QLinearConvLineCore_l535_4) begin
            _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_3 <= _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_0;
            _blocks_blocks_3_pw_Conv_output_0_quantized_compCycleReg <= 4'b0000;
            _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sRequant;
          end
        end
      end
      if(when_QLinearConvLineCore_l545_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6 <= _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_6;
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_5 <= ($signed(_blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_3) < $signed(32'h0));
        _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantMul;
      end
      if(when_QLinearConvLineCore_l551_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7 <= (_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7 * _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7_1);
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_8 <= (_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7 * _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_8);
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_9 <= (_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_9 * _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7_1);
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_10 <= (_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_9 * _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_8);
        _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait;
      end
      if(when_QLinearConvLineCore_l563_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_11 <= (_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_11 + _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_11_1);
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_12 <= _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_7;
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_13 <= _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_10;
        _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait2;
      end
      if(when_QLinearConvLineCore_l570_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14 <= (_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14 + _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_14_1);
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_15 <= _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_15[63:0];
        _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantWait3;
      end
      if(when_QLinearConvLineCore_l576_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4 <= (_blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_5 ? _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4_1 : _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_4_3);
        _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sRequantShift;
      end
      if(when_QLinearConvLineCore_l583_4) begin
        _blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2 <= (($signed(32'h0000007f) < $signed(_zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2)) ? 8'h7f : _zz__blocks_blocks_3_pw_Conv_output_0_quantized_rqReg_2_1);
        _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sEmit;
      end
      if(when_QLinearConvLineCore_l596_4) begin
        if(_blocks_blocks_3_pw_Conv_output_0_quantized_activationOut_fire) begin
          _blocks_blocks_3_pw_Conv_output_0_quantized_outChReg <= (when_QLinearConvLineCore_l608_4 ? 7'h0 : _zz__blocks_blocks_3_pw_Conv_output_0_quantized_outChReg);
          if(when_QLinearConvLineCore_l608_4) begin
            _blocks_blocks_3_pw_Conv_output_0_quantized_outColReg <= (when_QLinearConvLineCore_l612_4 ? 3'b000 : _zz__blocks_blocks_3_pw_Conv_output_0_quantized_outColReg);
            if(when_QLinearConvLineCore_l612_4) begin
              _blocks_blocks_3_pw_Conv_output_0_quantized_outRowReg <= (when_QLinearConvLineCore_l616_4 ? 5'h0 : _zz__blocks_blocks_3_pw_Conv_output_0_quantized_outRowReg);
              if(when_QLinearConvLineCore_l616_4) begin
                _blocks_blocks_3_pw_Conv_output_0_quantized_realRowsRecvReg <= 5'h0;
                _blocks_blocks_3_pw_Conv_output_0_quantized_rxBankReg <= 4'b0000;
                _blocks_blocks_3_pw_Conv_output_0_quantized_rxWordReg <= 6'h0;
                _blocks_blocks_3_pw_Conv_output_0_quantized_rowsUntilComputeReg <= 1'b1;
                _blocks_blocks_3_pw_Conv_output_0_quantized_rowWrPtrReg <= 1'b0;
                _blocks_blocks_3_pw_Conv_output_0_quantized_initSlotReg <= 1'b0;
                _blocks_blocks_3_pw_Conv_output_0_quantized_initAddrReg <= 6'h0;
                _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow;
              end else begin
                _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sReceiveRow;
              end
            end else begin
              _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sLoadWeights;
            end
          end else begin
            _blocks_blocks_3_pw_Conv_output_0_quantized_stateReg <= _blocks_blocks_3_pw_Conv_output_0_quantized_sLoadWeights;
          end
        end
      end
      if(_gap_GlobalAveragePool_output_0_quantized_pipelineValidReg) begin
        _gap_GlobalAveragePool_output_0_quantized_accPrevReg <= _gap_GlobalAveragePool_output_0_quantized_accumNew;
        _gap_GlobalAveragePool_output_0_quantized_prevChReg <= _gap_GlobalAveragePool_output_0_quantized_chReg_d1;
      end
      _gap_GlobalAveragePool_output_0_quantized_prevValidReg <= _gap_GlobalAveragePool_output_0_quantized_pipelineValidReg;
      if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sReceive)) begin
          if(QLinearConvLineCorePlugin_logic_outStream_fire_4) begin
            _gap_GlobalAveragePool_output_0_quantized_inValReg <= QLinearConvLineCorePlugin_logic_outStream_payload_value_4;
            _gap_GlobalAveragePool_output_0_quantized_chReg_d1 <= _gap_GlobalAveragePool_output_0_quantized_chReg;
            _gap_GlobalAveragePool_output_0_quantized_colReg_d1 <= _gap_GlobalAveragePool_output_0_quantized_colReg;
            _gap_GlobalAveragePool_output_0_quantized_rowReg_d1 <= _gap_GlobalAveragePool_output_0_quantized_rowReg;
            _gap_GlobalAveragePool_output_0_quantized_pipelineValidReg <= 1'b1;
            _gap_GlobalAveragePool_output_0_quantized_chReg <= (when_GlobalAveragePoolCore_l204 ? 7'h0 : _zz__gap_GlobalAveragePool_output_0_quantized_chReg);
            if(when_GlobalAveragePoolCore_l204) begin
              _gap_GlobalAveragePool_output_0_quantized_colReg <= (when_GlobalAveragePoolCore_l206 ? 3'b000 : _zz__gap_GlobalAveragePool_output_0_quantized_colReg);
              if(when_GlobalAveragePoolCore_l206) begin
                _gap_GlobalAveragePool_output_0_quantized_rowReg <= (when_GlobalAveragePoolCore_l208 ? 5'h0 : _zz__gap_GlobalAveragePool_output_0_quantized_rowReg);
                if(when_GlobalAveragePoolCore_l208) begin
                  _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sSettle;
                end
              end
            end
          end else begin
            _gap_GlobalAveragePool_output_0_quantized_pipelineValidReg <= 1'b0;
          end
      end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sSettle)) begin
          _gap_GlobalAveragePool_output_0_quantized_pipelineValidReg <= 1'b0;
          _gap_GlobalAveragePool_output_0_quantized_emitChReg <= 7'h0;
          _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sReadAcc;
      end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sReadAcc)) begin
          _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sRequant;
      end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequant)) begin
          _gap_GlobalAveragePool_output_0_quantized_absAReg <= _zz__gap_GlobalAveragePool_output_0_quantized_absAReg_1;
          _gap_GlobalAveragePool_output_0_quantized_signAReg <= ($signed(_zz__gap_GlobalAveragePool_output_0_quantized_absAReg) < $signed(32'h0));
          _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sRequantMul;
      end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantMul)) begin
          _gap_GlobalAveragePool_output_0_quantized_pLL_Reg <= (_zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg_1 * _zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg_2);
          _gap_GlobalAveragePool_output_0_quantized_pLH_Reg <= (_zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg_1 * _zz__gap_GlobalAveragePool_output_0_quantized_pLH_Reg);
          _gap_GlobalAveragePool_output_0_quantized_pHL_Reg <= (_zz__gap_GlobalAveragePool_output_0_quantized_pHL_Reg * _zz__gap_GlobalAveragePool_output_0_quantized_pLL_Reg_2);
          _gap_GlobalAveragePool_output_0_quantized_pHH_Reg <= (_zz__gap_GlobalAveragePool_output_0_quantized_pHL_Reg * _zz__gap_GlobalAveragePool_output_0_quantized_pLH_Reg);
          _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sRequantWait;
      end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait)) begin
          _gap_GlobalAveragePool_output_0_quantized_pSumReg <= (_zz__gap_GlobalAveragePool_output_0_quantized_pSumReg + _zz__gap_GlobalAveragePool_output_0_quantized_pSumReg_1);
          _gap_GlobalAveragePool_output_0_quantized_pLL_Reg2 <= _gap_GlobalAveragePool_output_0_quantized_pLL_Reg;
          _gap_GlobalAveragePool_output_0_quantized_pHH_Reg2 <= _gap_GlobalAveragePool_output_0_quantized_pHH_Reg;
          _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sRequantWait2;
      end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait2)) begin
          _gap_GlobalAveragePool_output_0_quantized_part1Reg <= (_zz__gap_GlobalAveragePool_output_0_quantized_part1Reg + _zz__gap_GlobalAveragePool_output_0_quantized_part1Reg_1);
          _gap_GlobalAveragePool_output_0_quantized_part2Reg <= _zz__gap_GlobalAveragePool_output_0_quantized_part2Reg[63:0];
          _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sRequantWait3;
      end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantWait3)) begin
          _gap_GlobalAveragePool_output_0_quantized_reqProdReg2 <= (_gap_GlobalAveragePool_output_0_quantized_signAReg ? _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2_1 : _zz__gap_GlobalAveragePool_output_0_quantized_reqProdReg2_3);
          _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sRequantShift;
      end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sRequantShift)) begin
          _gap_GlobalAveragePool_output_0_quantized_resultReg <= (($signed(32'h0000007f) < $signed(_zz__gap_GlobalAveragePool_output_0_quantized_resultReg)) ? 8'h7f : _zz__gap_GlobalAveragePool_output_0_quantized_resultReg_1);
          _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sEmit;
      end else if((_gap_GlobalAveragePool_output_0_quantized_stateReg == _gap_GlobalAveragePool_output_0_quantized_sEmit)) begin
          if(_gap_GlobalAveragePool_output_0_quantized_activationOut_fire) begin
            if(when_GlobalAveragePoolCore_l291) begin
              _gap_GlobalAveragePool_output_0_quantized_chReg <= 7'h0;
              _gap_GlobalAveragePool_output_0_quantized_colReg <= 3'b000;
              _gap_GlobalAveragePool_output_0_quantized_rowReg <= 5'h0;
              _gap_GlobalAveragePool_output_0_quantized_emitChReg <= 7'h0;
              _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sReceive;
            end else begin
              _gap_GlobalAveragePool_output_0_quantized_emitChReg <= (_gap_GlobalAveragePool_output_0_quantized_emitChReg + 7'h01);
              _gap_GlobalAveragePool_output_0_quantized_stateReg <= _gap_GlobalAveragePool_output_0_quantized_sReadAcc;
            end
          end
      end
      if(when_QLinearLinearCore_l174) begin
        if(GlobalAveragePoolPlugin_logic_outStream_fire) begin
          output_quantized_recvCntReg <= (output_quantized_recvCntReg + 7'h01);
          if(when_QLinearLinearCore_l179) begin
            output_quantized_recvCntReg <= 7'h0;
            output_quantized_outNeurReg <= 4'b0000;
            output_quantized_stateReg <= output_quantized_sLoadWeights;
          end
        end
      end
      if(when_QLinearLinearCore_l191) begin
        if(when_QLinearLinearCore_l192) begin
          if(output_quantized_weightIn_fire) begin
            output_quantized_wBeatBuf <= output_quantized_weightIn_payload;
            output_quantized_wBeatDraining <= 1'b1;
            output_quantized_wBeatStepReg <= 6'h0;
          end
        end else begin
          if(when_QLinearLinearCore_l201) begin
            output_quantized_wStepReg <= (output_quantized_wStepReg + 7'h01);
          end
          output_quantized_wBeatBuf <= {8'd0, _zz_output_quantized_wBeatBuf};
          output_quantized_wBeatStepReg <= (output_quantized_wBeatStepReg + 6'h01);
          if(when_QLinearLinearCore_l207) begin
            output_quantized_wBeatDraining <= 1'b0;
            if(when_QLinearLinearCore_l209) begin
              output_quantized_wStepReg <= 7'h0;
              output_quantized_stateReg <= output_quantized_sLoadBias;
            end
          end
        end
      end
      if(when_QLinearLinearCore_l219) begin
        output_quantized_compCycleReg <= 7'h0;
        output_quantized_stateReg <= output_quantized_sWaitBias;
      end
      if(when_QLinearLinearCore_l225) begin
        output_quantized_accumReg <= output_quantized_biasVal;
        output_quantized_stateReg <= output_quantized_sCompute;
      end
      if(when_QLinearLinearCore_l231) begin
        output_quantized_compCycleReg <= (output_quantized_compCycleReg + 7'h01);
        if(when_QLinearLinearCore_l242) begin
          output_quantized_inValReg <= output_quantized_inValR;
          output_quantized_wValReg <= output_quantized_wValR;
        end
        if(when_QLinearLinearCore_l248) begin
          output_quantized_prodReg <= {{14{_zz_output_quantized_prodReg[17]}}, _zz_output_quantized_prodReg};
        end
        if(when_QLinearLinearCore_l255) begin
          output_quantized_accumReg <= _zz_output_quantized_accumReg;
          if(when_QLinearLinearCore_l259) begin
            output_quantized_accumRequantReg <= _zz_output_quantized_accumReg;
            output_quantized_stateReg <= output_quantized_sRequant;
            output_quantized_compCycleReg <= 7'h0;
          end
        end
      end
      if(when_QLinearLinearCore_l268) begin
        output_quantized_absAReg <= _zz_output_quantized_absAReg;
        output_quantized_signAReg <= ($signed(output_quantized_accumRequantReg) < $signed(32'h0));
        output_quantized_stateReg <= output_quantized_sRequantMul;
      end
      if(when_QLinearLinearCore_l275) begin
        output_quantized_pLL_Reg <= (_zz_output_quantized_pLL_Reg_1 * _zz_output_quantized_pLL_Reg_2);
        output_quantized_pLH_Reg <= (_zz_output_quantized_pLL_Reg_1 * _zz_output_quantized_pLH_Reg);
        output_quantized_pHL_Reg <= (_zz_output_quantized_pHL_Reg * _zz_output_quantized_pLL_Reg_2);
        output_quantized_pHH_Reg <= (_zz_output_quantized_pHL_Reg * _zz_output_quantized_pLH_Reg);
        output_quantized_stateReg <= output_quantized_sRequantWait;
      end
      if(when_QLinearLinearCore_l291) begin
        output_quantized_pSumReg <= (_zz_output_quantized_pSumReg + _zz_output_quantized_pSumReg_1);
        output_quantized_pLL_Reg2 <= output_quantized_pLL_Reg;
        output_quantized_pHH_Reg2 <= output_quantized_pHH_Reg;
        output_quantized_stateReg <= output_quantized_sRequantWait2;
      end
      if(when_QLinearLinearCore_l299) begin
        output_quantized_part1Reg <= (_zz_output_quantized_part1Reg + _zz_output_quantized_part1Reg_1);
        output_quantized_part2Reg <= _zz_output_quantized_part2Reg[63:0];
        output_quantized_stateReg <= output_quantized_sRequantWait3;
      end
      if(when_QLinearLinearCore_l306) begin
        output_quantized_reqProdReg2 <= (output_quantized_signAReg ? _zz_output_quantized_reqProdReg2_1 : _zz_output_quantized_reqProdReg2_3);
        output_quantized_stateReg <= output_quantized_sRequantShift;
      end
      if(when_QLinearLinearCore_l314) begin
        output_quantized_resultReg <= (($signed(32'h0000007f) < $signed(_zz_output_quantized_resultReg)) ? 8'h7f : _zz_output_quantized_resultReg_1);
        output_quantized_stateReg <= output_quantized_sEmit;
      end
      if(when_QLinearLinearCore_l325) begin
        if(output_quantized_activationOut_fire) begin
          output_quantized_outNeurReg <= (_zz_output_quantized_stateReg ? 4'b0000 : _zz_output_quantized_outNeurReg);
          output_quantized_stateReg <= (_zz_output_quantized_stateReg ? output_quantized_sReceive : output_quantized_sLoadWeights);
        end
      end
      if(when_WeightDmaCore_l137) begin
        if(weightDmaAxi_ar_fire) begin
          _zz_when_WeightDmaCore_l178 <= 1'b0;
          _zz_when_WeightDmaCore_l137 <= 3'b001;
        end
      end
      if(when_WeightDmaCore_l155) begin
        if(weightDmaAxi_r_fire) begin
          _zz__stem_conv_Conv_output_0_quantized_weightIn_payload <= weightDmaAxi_r_payload_data;
          _zz_when_WeightDmaCore_l137 <= 3'b010;
        end
      end
      if(when_WeightDmaCore_l164) begin
        if(when_WeightDmaCore_l176) begin
          _zz_when_WeightDmaCore_l178 <= (_zz_when_WeightDmaCore_l178 + 1'b1);
          if(when_WeightDmaCore_l178) begin
            _zz_when_WeightDmaCore_l137 <= 3'b011;
          end else begin
            _zz_when_WeightDmaCore_l137 <= 3'b001;
          end
        end
      end
      if(when_WeightDmaCore_l187) begin
        _zz_weightDmaAxi_ar_payload_addr_1 <= (_zz_weightDmaAxi_ar_payload_addr_2 ? 7'h0 : _zz__zz_weightDmaAxi_ar_payload_addr_1);
        _zz_weightDmaAxi_ar_payload_addr <= ((_zz_weightDmaAxi_ar_payload_addr_2 && (_zz_weightDmaAxi_ar_payload_addr == 3'b101)) ? 3'b000 : (_zz_weightDmaAxi_ar_payload_addr_2 ? _zz__zz_weightDmaAxi_ar_payload_addr : _zz_weightDmaAxi_ar_payload_addr));
        _zz_when_WeightDmaCore_l137 <= 3'b000;
      end
    end
  end


endmodule
