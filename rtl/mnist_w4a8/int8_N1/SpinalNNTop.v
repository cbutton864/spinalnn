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
  reg        [7:0]    conv1_weightRom_p0_i0_spinal_port0;
  reg        [31:0]   conv1_biasRom_p0_spinal_port0;
  reg        [7:0]    pool1_rowBuf_0_spinal_port0;
  reg        [7:0]    pool1_rowBuf_1_spinal_port0;
  reg        [7:0]    conv2_inputBuf_0_spinal_port0;
  reg        [7:0]    conv2_weightRom_p0_i0_spinal_port0;
  reg        [31:0]   conv2_biasRom_p0_spinal_port0;
  reg        [7:0]    pool2_rowBuf_0_spinal_port0;
  reg        [7:0]    pool2_rowBuf_1_spinal_port0;
  reg        [7:0]    pool2_rowBuf_2_spinal_port0;
  reg        [7:0]    linear1_inputBuf_spinal_port0;
  reg        [7:0]    linear1_weightRom_spinal_port0;
  reg        [31:0]   linear1_biasRom_spinal_port0;
  wire       [9:0]    _zz_conv1_inputBuf_0_port;
  wire                _zz_conv1_inputBuf_0_port_1;
  wire       [9:0]    _zz_conv1_inValsR_0_1;
  wire                _zz_conv1_inValsR_0_2;
  wire                _zz_conv1_weightRom_p0_i0_port;
  wire                _zz_conv1_wValsR_0_1;
  wire       [2:0]    _zz_conv1_biasRom_p0_port;
  wire                _zz_conv1_biasRom_p0_port_1;
  wire       [2:0]    _zz_conv1_biasVals_0_1;
  wire                _zz_conv1_biasVals_0_2;
  wire       [9:0]    _zz_conv1_inputBuf_0_port_2;
  wire       [10:0]   _zz_conv1_inputBuf_0_port_3;
  wire       [7:0]    _zz_conv1_inputBuf_0_port_4;
  wire       [7:0]    _zz_conv1_inputBuf_0_port_5;
  wire                _zz_conv1_inputBuf_0_port_6;
  wire       [4:0]    _zz_conv1_rowElemReg;
  wire       [11:0]   _zz_conv1_inAddrReg_1;
  wire       [11:0]   _zz_conv1_inAddrReg_2;
  wire       [11:0]   _zz_conv1_inAddrReg_3;
  wire       [5:0]    _zz_conv1_inAddrReg_4;
  wire       [11:0]   _zz_conv1_inAddrReg_5;
  wire       [6:0]    _zz_conv1_inAddrReg_6;
  wire       [5:0]    _zz_conv1_inAddrReg_7;
  wire       [11:0]   _zz_conv1_inAddrReg_8;
  wire       [0:0]    _zz_conv1_inAddrReg_9;
  wire       [8:0]    _zz_conv1_wAddrReg;
  wire       [8:0]    _zz_conv1_wAddrReg_1;
  wire       [8:0]    _zz_conv1_wAddrReg_2;
  wire       [8:0]    _zz_conv1_wAddrReg_3;
  wire       [8:0]    _zz_conv1_wAddrReg_4;
  wire       [2:0]    _zz_conv1_wAddrReg_5;
  wire       [8:0]    _zz_conv1_wAddrReg_6;
  wire       [0:0]    _zz_conv1_wAddrReg_7;
  wire       [8:0]    _zz_conv1_wAddrReg_8;
  wire       [0:0]    _zz_conv1_wAddrReg_9;
  wire       [2:0]    _zz_conv1_rowStepReg;
  wire       [17:0]   _zz_conv1_prodReg_p0;
  wire       [8:0]    _zz_conv1_prodReg_p0_1;
  wire       [8:0]    _zz_conv1_prodReg_p0_2;
  wire       [8:0]    _zz_conv1_prodReg_p0_3;
  wire       [8:0]    _zz_conv1_prodReg_p0_4;
  wire       [31:0]   _zz_conv1_absAReg_p0;
  wire       [31:0]   _zz_conv1_absAReg_p0_1;
  wire       [32:0]   _zz_conv1_pSumReg_p0;
  wire       [32:0]   _zz_conv1_pSumReg_p0_1;
  wire       [63:0]   _zz_conv1_part1Reg_p0;
  wire       [63:0]   _zz_conv1_part1Reg_p0_1;
  wire       [79:0]   _zz_conv1_part1Reg_p0_2;
  wire       [63:0]   _zz_conv1_part1Reg_p0_3;
  wire       [95:0]   _zz_conv1_part2Reg_p0;
  wire       [63:0]   _zz_conv1_part2Reg_p0_1;
  wire       [63:0]   _zz_conv1_reqProdReg2_p0_1;
  wire       [63:0]   _zz_conv1_reqProdReg2_p0_2;
  wire       [63:0]   _zz_conv1_reqProdReg2_p0_3;
  wire       [31:0]   _zz__zz_conv1_resultReg_p0;
  wire       [24:0]   _zz__zz_conv1_resultReg_p0_1;
  wire       [7:0]    _zz_conv1_resultReg_p0_1;
  wire       [7:0]    _zz_conv1_resultReg_p0_2;
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
  wire                _zz_conv2_inputBuf_0_port;
  wire                _zz_conv2_inValsR_0_1;
  wire                _zz_conv2_weightRom_p0_i0_port;
  wire                _zz_conv2_wValsR_0_1;
  wire       [3:0]    _zz_conv2_biasRom_p0_port;
  wire                _zz_conv2_biasRom_p0_port_1;
  wire       [3:0]    _zz_conv2_biasVals_0_1;
  wire                _zz_conv2_biasVals_0_2;
  wire       [11:0]   _zz_conv2_inputBuf_0_port_1;
  wire       [7:0]    _zz_conv2_inputBuf_0_port_2;
  wire       [7:0]    _zz_conv2_inputBuf_0_port_3;
  wire                _zz_conv2_inputBuf_0_port_4;
  wire       [6:0]    _zz_conv2_rowElemReg;
  wire       [12:0]   _zz_conv2_inAddrReg_1;
  wire       [12:0]   _zz_conv2_inAddrReg_2;
  wire       [12:0]   _zz_conv2_inAddrReg_3;
  wire       [4:0]    _zz_conv2_inAddrReg_4;
  wire       [12:0]   _zz_conv2_inAddrReg_5;
  wire       [8:0]    _zz_conv2_inAddrReg_6;
  wire       [4:0]    _zz_conv2_inAddrReg_7;
  wire       [12:0]   _zz_conv2_inAddrReg_8;
  wire       [3:0]    _zz_conv2_inAddrReg_9;
  wire       [12:0]   _zz_conv2_wAddrReg;
  wire       [12:0]   _zz_conv2_wAddrReg_1;
  wire       [12:0]   _zz_conv2_wAddrReg_2;
  wire       [12:0]   _zz_conv2_wAddrReg_3;
  wire       [12:0]   _zz_conv2_wAddrReg_4;
  wire       [5:0]    _zz_conv2_wAddrReg_5;
  wire       [12:0]   _zz_conv2_wAddrReg_6;
  wire       [3:0]    _zz_conv2_wAddrReg_7;
  wire       [12:0]   _zz_conv2_wAddrReg_8;
  wire       [3:0]    _zz_conv2_wAddrReg_9;
  wire       [5:0]    _zz_conv2_rowStepReg;
  wire       [17:0]   _zz_conv2_prodReg_p0;
  wire       [8:0]    _zz_conv2_prodReg_p0_1;
  wire       [8:0]    _zz_conv2_prodReg_p0_2;
  wire       [8:0]    _zz_conv2_prodReg_p0_3;
  wire       [8:0]    _zz_conv2_prodReg_p0_4;
  wire       [31:0]   _zz_conv2_absAReg_p0;
  wire       [31:0]   _zz_conv2_absAReg_p0_1;
  wire       [32:0]   _zz_conv2_pSumReg_p0;
  wire       [32:0]   _zz_conv2_pSumReg_p0_1;
  wire       [63:0]   _zz_conv2_part1Reg_p0;
  wire       [63:0]   _zz_conv2_part1Reg_p0_1;
  wire       [79:0]   _zz_conv2_part1Reg_p0_2;
  wire       [63:0]   _zz_conv2_part1Reg_p0_3;
  wire       [95:0]   _zz_conv2_part2Reg_p0;
  wire       [63:0]   _zz_conv2_part2Reg_p0_1;
  wire       [63:0]   _zz_conv2_reqProdReg2_p0_1;
  wire       [63:0]   _zz_conv2_reqProdReg2_p0_2;
  wire       [63:0]   _zz_conv2_reqProdReg2_p0_3;
  wire       [31:0]   _zz__zz_conv2_resultReg_p0;
  wire       [24:0]   _zz__zz_conv2_resultReg_p0_1;
  wire       [7:0]    _zz_conv2_resultReg_p0_1;
  wire       [7:0]    _zz_conv2_resultReg_p0_2;
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
  wire                QLinearConvPlugin_logic_outStream_valid;
  wire                QLinearConvPlugin_logic_outStream_ready;
  wire       [7:0]    QLinearConvPlugin_logic_outStream_payload_value;
  reg                 conv1_activationOut_valid;
  wire                conv1_activationOut_ready;
  reg        [7:0]    conv1_activationOut_payload_value;
  wire       [3:0]    conv1_sReceive;
  wire       [3:0]    conv1_sLoadBias;
  wire       [3:0]    conv1_sCompute;
  wire       [3:0]    conv1_sRequant;
  wire       [3:0]    conv1_sRequantMul;
  wire       [3:0]    conv1_sRequantWait;
  wire       [3:0]    conv1_sRequantWait2;
  wire       [3:0]    conv1_sRequantWait3;
  wire       [3:0]    conv1_sRequantShift;
  wire       [3:0]    conv1_sEmit;
  wire       [3:0]    conv1_sInit;
  wire       [3:0]    conv1_sWaitBias;
  wire       [3:0]    conv1_sLoadWeights;
  reg        [3:0]    conv1_stateReg;
  reg        [9:0]    conv1_recvCntReg;
  reg        [10:0]   conv1_padWriteAddrReg;
  reg        [4:0]    conv1_rowElemReg;
  reg        [4:0]    conv1_outRowReg;
  reg        [4:0]    conv1_outColReg;
  reg        [3:0]    conv1_outChReg;
  reg        [31:0]   conv1_accumReg_p0;
  reg        [31:0]   conv1_prodReg_p0;
  reg        [31:0]   conv1_accumRequantReg_p0;
  reg        [7:0]    conv1_resultReg_p0;
  reg        [63:0]   conv1_reqProdReg2_p0;
  reg                 conv1_signAReg_p0;
  reg        [31:0]   conv1_absAReg_p0;
  reg        [31:0]   conv1_pLL_Reg_p0;
  reg        [31:0]   conv1_pLH_Reg_p0;
  reg        [31:0]   conv1_pHL_Reg_p0;
  reg        [31:0]   conv1_pHH_Reg_p0;
  reg        [32:0]   conv1_pSumReg_p0;
  reg        [31:0]   conv1_pLL_Reg2_p0;
  reg        [31:0]   conv1_pHH_Reg2_p0;
  reg        [63:0]   conv1_part1Reg_p0;
  reg        [63:0]   conv1_part2Reg_p0;
  reg        [10:0]   conv1_initAddrReg;
  reg        [10:0]   conv1_inAddrReg;
  reg        [7:0]    conv1_wAddrReg;
  reg        [4:0]    conv1_compCycleReg;
  reg        [2:0]    conv1_rowStepReg;
  reg        [10:0]   conv1_inAddrComb;
  reg        [7:0]    conv1_wAddrComb;
  wire       [10:0]   _zz_conv1_inValsR_0;
  wire       [7:0]    conv1_inValsR_0;
  wire       [7:0]    _zz_conv1_wValsR_0;
  wire       [7:0]    conv1_wValsR_0;
  wire       [3:0]    _zz_conv1_biasVals_0;
  wire       [31:0]   conv1_biasVals_0;
  reg        [7:0]    conv1_inValsReg_0;
  reg        [7:0]    conv1_wValsReg_p0_i0;
  wire                _zz_5;
  wire                io_activationIn_fire;
  wire                when_QLinearConvCore_l378;
  wire                when_QLinearConvCore_l379;
  wire                when_QLinearConvCore_l389;
  wire                _zz_conv1_padWriteAddrReg;
  wire                when_QLinearConvCore_l398;
  wire                when_QLinearConvCore_l434;
  wire                when_QLinearConvCore_l445;
  wire                when_QLinearConvCore_l453;
  wire                when_QLinearConvCore_l456;
  wire                _zz_conv1_inAddrReg;
  wire                when_QLinearConvCore_l466;
  wire                when_QLinearConvCore_l471;
  wire                when_QLinearConvCore_l491;
  wire       [31:0]   _zz_conv1_accumReg_p0;
  wire                when_QLinearConvCore_l495;
  wire                when_QLinearConvCore_l499;
  wire                when_QLinearConvCore_l507;
  wire                when_QLinearConvCore_l515;
  wire       [31:0]   _zz_conv1_pLL_Reg_p0;
  wire       [15:0]   _zz_conv1_pHL_Reg_p0;
  wire       [15:0]   _zz_conv1_pLL_Reg_p0_1;
  wire       [15:0]   _zz_conv1_pLH_Reg_p0;
  wire       [15:0]   _zz_conv1_pLL_Reg_p0_2;
  wire                when_QLinearConvCore_l530;
  wire                when_QLinearConvCore_l539;
  wire                when_QLinearConvCore_l547;
  wire       [63:0]   _zz_conv1_reqProdReg2_p0;
  wire                when_QLinearConvCore_l556;
  wire       [31:0]   _zz_conv1_resultReg_p0;
  wire                when_QLinearConvCore_l569;
  wire                conv1_activationOut_fire;
  wire                when_QLinearConvCore_l591;
  wire                when_QLinearConvCore_l597;
  wire                when_QLinearConvCore_l599;
  wire                _zz_conv1_stateReg;
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
  wire                QLinearConvPlugin_logic_outStream_valid_1;
  wire                QLinearConvPlugin_logic_outStream_ready_1;
  wire       [7:0]    QLinearConvPlugin_logic_outStream_payload_value_1;
  reg                 conv2_activationOut_valid;
  wire                conv2_activationOut_ready;
  reg        [7:0]    conv2_activationOut_payload_value;
  wire       [3:0]    conv2_sReceive;
  wire       [3:0]    conv2_sLoadBias;
  wire       [3:0]    conv2_sCompute;
  wire       [3:0]    conv2_sRequant;
  wire       [3:0]    conv2_sRequantMul;
  wire       [3:0]    conv2_sRequantWait;
  wire       [3:0]    conv2_sRequantWait2;
  wire       [3:0]    conv2_sRequantWait3;
  wire       [3:0]    conv2_sRequantShift;
  wire       [3:0]    conv2_sEmit;
  wire       [3:0]    conv2_sInit;
  wire       [3:0]    conv2_sWaitBias;
  wire       [3:0]    conv2_sLoadWeights;
  reg        [3:0]    conv2_stateReg;
  reg        [10:0]   conv2_recvCntReg;
  reg        [11:0]   conv2_padWriteAddrReg;
  reg        [6:0]    conv2_rowElemReg;
  reg        [3:0]    conv2_outRowReg;
  reg        [3:0]    conv2_outColReg;
  reg        [4:0]    conv2_outChReg;
  reg        [31:0]   conv2_accumReg_p0;
  reg        [31:0]   conv2_prodReg_p0;
  reg        [31:0]   conv2_accumRequantReg_p0;
  reg        [7:0]    conv2_resultReg_p0;
  reg        [63:0]   conv2_reqProdReg2_p0;
  reg                 conv2_signAReg_p0;
  reg        [31:0]   conv2_absAReg_p0;
  reg        [31:0]   conv2_pLL_Reg_p0;
  reg        [31:0]   conv2_pLH_Reg_p0;
  reg        [31:0]   conv2_pHL_Reg_p0;
  reg        [31:0]   conv2_pHH_Reg_p0;
  reg        [32:0]   conv2_pSumReg_p0;
  reg        [31:0]   conv2_pLL_Reg2_p0;
  reg        [31:0]   conv2_pHH_Reg2_p0;
  reg        [63:0]   conv2_part1Reg_p0;
  reg        [63:0]   conv2_part2Reg_p0;
  reg        [11:0]   conv2_initAddrReg;
  reg        [11:0]   conv2_inAddrReg;
  reg        [11:0]   conv2_wAddrReg;
  reg        [7:0]    conv2_compCycleReg;
  reg        [5:0]    conv2_rowStepReg;
  reg        [11:0]   conv2_inAddrComb;
  reg        [11:0]   conv2_wAddrComb;
  wire       [11:0]   _zz_conv2_inValsR_0;
  wire       [7:0]    conv2_inValsR_0;
  wire       [11:0]   _zz_conv2_wValsR_0;
  wire       [7:0]    conv2_wValsR_0;
  wire       [4:0]    _zz_conv2_biasVals_0;
  wire       [31:0]   conv2_biasVals_0;
  reg        [7:0]    conv2_inValsReg_0;
  reg        [7:0]    conv2_wValsReg_p0_i0;
  wire                _zz_14;
  wire                MaxPoolLinePlugin_logic_outStream_fire;
  wire                when_QLinearConvCore_l378_1;
  wire                when_QLinearConvCore_l379_1;
  wire                when_QLinearConvCore_l389_1;
  wire                _zz_conv2_padWriteAddrReg;
  wire                when_QLinearConvCore_l398_1;
  wire                when_QLinearConvCore_l434_1;
  wire                when_QLinearConvCore_l445_1;
  wire                when_QLinearConvCore_l453_1;
  wire                when_QLinearConvCore_l456_1;
  wire                _zz_conv2_inAddrReg;
  wire                when_QLinearConvCore_l466_1;
  wire                when_QLinearConvCore_l471_1;
  wire                when_QLinearConvCore_l491_1;
  wire       [31:0]   _zz_conv2_accumReg_p0;
  wire                when_QLinearConvCore_l495_1;
  wire                when_QLinearConvCore_l499_1;
  wire                when_QLinearConvCore_l507_1;
  wire                when_QLinearConvCore_l515_1;
  wire       [31:0]   _zz_conv2_pLL_Reg_p0;
  wire       [15:0]   _zz_conv2_pHL_Reg_p0;
  wire       [15:0]   _zz_conv2_pLL_Reg_p0_1;
  wire       [15:0]   _zz_conv2_pLH_Reg_p0;
  wire       [15:0]   _zz_conv2_pLL_Reg_p0_2;
  wire                when_QLinearConvCore_l530_1;
  wire                when_QLinearConvCore_l539_1;
  wire                when_QLinearConvCore_l547_1;
  wire       [63:0]   _zz_conv2_reqProdReg2_p0;
  wire                when_QLinearConvCore_l556_1;
  wire       [31:0]   _zz_conv2_resultReg_p0;
  wire                when_QLinearConvCore_l569_1;
  wire                conv2_activationOut_fire;
  wire                when_QLinearConvCore_l591_1;
  wire                when_QLinearConvCore_l597_1;
  wire                when_QLinearConvCore_l599_1;
  wire                _zz_conv2_stateReg;
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
  reg [7:0] conv1_inputBuf_0 [0:1023];
  reg [7:0] conv1_weightRom_p0_i0 [0:199];
  reg [31:0] conv1_biasRom_p0 [0:7];
  reg [7:0] pool1_rowBuf_0 [0:223];
  reg [7:0] pool1_rowBuf_1 [0:223];
  reg [7:0] conv2_inputBuf_0 [0:2591];
  reg [7:0] conv2_weightRom_p0_i0 [0:3199];
  reg [31:0] conv2_biasRom_p0 [0:15];
  reg [7:0] pool2_rowBuf_0 [0:223];
  reg [7:0] pool2_rowBuf_1 [0:223];
  reg [7:0] pool2_rowBuf_2 [0:223];
  reg [7:0] linear1_inputBuf [0:255];
  reg [7:0] linear1_weightRom [0:2559];
  reg [31:0] linear1_biasRom [0:9];

  assign _zz_conv1_inValsR_0_1 = _zz_conv1_inValsR_0[9:0];
  assign _zz_conv1_biasVals_0_1 = _zz_conv1_biasVals_0[2:0];
  assign _zz_conv1_inputBuf_0_port_3 = (_zz_5 ? conv1_initAddrReg : conv1_padWriteAddrReg);
  assign _zz_conv1_inputBuf_0_port_2 = _zz_conv1_inputBuf_0_port_3[9:0];
  assign _zz_conv1_inputBuf_0_port_5 = (_zz_5 ? 8'h0 : activation_in_data);
  assign _zz_conv1_rowElemReg = (conv1_rowElemReg + 5'h01);
  assign _zz_conv1_inAddrReg_1 = (_zz_conv1_inAddrReg_2 + _zz_conv1_inAddrReg_8);
  assign _zz_conv1_inAddrReg_2 = (_zz_conv1_inAddrReg_3 + _zz_conv1_inAddrReg_5);
  assign _zz_conv1_inAddrReg_3 = (_zz_conv1_inAddrReg_4 * 6'h20);
  assign _zz_conv1_inAddrReg_4 = (conv1_outRowReg * 1'b1);
  assign _zz_conv1_inAddrReg_6 = (_zz_conv1_inAddrReg_7 * 1'b1);
  assign _zz_conv1_inAddrReg_5 = {5'd0, _zz_conv1_inAddrReg_6};
  assign _zz_conv1_inAddrReg_7 = (conv1_outColReg * 1'b1);
  assign _zz_conv1_inAddrReg_9 = 1'b0;
  assign _zz_conv1_inAddrReg_8 = {11'd0, _zz_conv1_inAddrReg_9};
  assign _zz_conv1_wAddrReg = (_zz_conv1_wAddrReg_1 + _zz_conv1_wAddrReg_8);
  assign _zz_conv1_wAddrReg_1 = (_zz_conv1_wAddrReg_2 + _zz_conv1_wAddrReg_6);
  assign _zz_conv1_wAddrReg_2 = (_zz_conv1_wAddrReg_3 + _zz_conv1_wAddrReg_4);
  assign _zz_conv1_wAddrReg_3 = (conv1_outChReg * 5'h19);
  assign _zz_conv1_wAddrReg_5 = 3'b000;
  assign _zz_conv1_wAddrReg_4 = {6'd0, _zz_conv1_wAddrReg_5};
  assign _zz_conv1_wAddrReg_7 = 1'b0;
  assign _zz_conv1_wAddrReg_6 = {8'd0, _zz_conv1_wAddrReg_7};
  assign _zz_conv1_wAddrReg_9 = 1'b0;
  assign _zz_conv1_wAddrReg_8 = {8'd0, _zz_conv1_wAddrReg_9};
  assign _zz_conv1_rowStepReg = (conv1_rowStepReg + 3'b001);
  assign _zz_conv1_prodReg_p0 = ($signed(_zz_conv1_prodReg_p0_1) * $signed(_zz_conv1_prodReg_p0_3));
  assign _zz_conv1_prodReg_p0_1 = ($signed(_zz_conv1_prodReg_p0_2) - $signed(9'h0));
  assign _zz_conv1_prodReg_p0_2 = {{1{conv1_inValsReg_0[7]}}, conv1_inValsReg_0};
  assign _zz_conv1_prodReg_p0_3 = ($signed(_zz_conv1_prodReg_p0_4) - $signed(9'h0));
  assign _zz_conv1_prodReg_p0_4 = {{1{conv1_wValsReg_p0_i0[7]}}, conv1_wValsReg_p0_i0};
  assign _zz_conv1_absAReg_p0 = (($signed(conv1_accumRequantReg_p0) < $signed(32'h0)) ? _zz_conv1_absAReg_p0_1 : conv1_accumRequantReg_p0);
  assign _zz_conv1_absAReg_p0_1 = (- conv1_accumRequantReg_p0);
  assign _zz_conv1_pSumReg_p0 = {1'd0, conv1_pLH_Reg_p0};
  assign _zz_conv1_pSumReg_p0_1 = {1'd0, conv1_pHL_Reg_p0};
  assign _zz_conv1_part1Reg_p0 = {32'd0, conv1_pLL_Reg2_p0};
  assign _zz_conv1_part1Reg_p0_2 = ({16'd0,_zz_conv1_part1Reg_p0_3} <<< 5'd16);
  assign _zz_conv1_part1Reg_p0_1 = _zz_conv1_part1Reg_p0_2[63:0];
  assign _zz_conv1_part1Reg_p0_3 = {31'd0, conv1_pSumReg_p0};
  assign _zz_conv1_part2Reg_p0 = ({32'd0,_zz_conv1_part2Reg_p0_1} <<< 6'd32);
  assign _zz_conv1_part2Reg_p0_1 = {32'd0, conv1_pHH_Reg2_p0};
  assign _zz_conv1_reqProdReg2_p0_1 = (- _zz_conv1_reqProdReg2_p0_2);
  assign _zz_conv1_reqProdReg2_p0_2 = _zz_conv1_reqProdReg2_p0;
  assign _zz_conv1_reqProdReg2_p0_3 = _zz_conv1_reqProdReg2_p0;
  assign _zz__zz_conv1_resultReg_p0_1 = (conv1_reqProdReg2_p0 >>> 6'd39);
  assign _zz__zz_conv1_resultReg_p0 = {{7{_zz__zz_conv1_resultReg_p0_1[24]}}, _zz__zz_conv1_resultReg_p0_1};
  assign _zz_conv1_resultReg_p0_1 = (($signed(_zz_conv1_resultReg_p0) < $signed(32'hffffff80)) ? 8'h80 : _zz_conv1_resultReg_p0_2);
  assign _zz_conv1_resultReg_p0_2 = _zz_conv1_resultReg_p0[7:0];
  assign _zz_conv1_outChReg = (conv1_outChReg + 4'b0001);
  assign _zz_conv1_outColReg = (conv1_outColReg + 5'h01);
  assign _zz_conv1_outRowReg = (conv1_outRowReg + 5'h01);
  assign _zz_relu1_activationOut_payload_value = (($signed(8'h7f) < $signed(QLinearConvPlugin_logic_outStream_payload_value)) ? 8'h7f : QLinearConvPlugin_logic_outStream_payload_value);
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
  assign _zz_conv2_biasVals_0_1 = _zz_conv2_biasVals_0[3:0];
  assign _zz_conv2_inputBuf_0_port_3 = (_zz_14 ? 8'h0 : MaxPoolLinePlugin_logic_outStream_payload_value);
  assign _zz_conv2_rowElemReg = (conv2_rowElemReg + 7'h01);
  assign _zz_conv2_inAddrReg_1 = (_zz_conv2_inAddrReg_2 + _zz_conv2_inAddrReg_8);
  assign _zz_conv2_inAddrReg_2 = (_zz_conv2_inAddrReg_3 + _zz_conv2_inAddrReg_5);
  assign _zz_conv2_inAddrReg_3 = (_zz_conv2_inAddrReg_4 * 8'h90);
  assign _zz_conv2_inAddrReg_4 = (conv2_outRowReg * 1'b1);
  assign _zz_conv2_inAddrReg_6 = (_zz_conv2_inAddrReg_7 * 4'b1000);
  assign _zz_conv2_inAddrReg_5 = {4'd0, _zz_conv2_inAddrReg_6};
  assign _zz_conv2_inAddrReg_7 = (conv2_outColReg * 1'b1);
  assign _zz_conv2_inAddrReg_9 = 4'b0000;
  assign _zz_conv2_inAddrReg_8 = {9'd0, _zz_conv2_inAddrReg_9};
  assign _zz_conv2_wAddrReg = (_zz_conv2_wAddrReg_1 + _zz_conv2_wAddrReg_8);
  assign _zz_conv2_wAddrReg_1 = (_zz_conv2_wAddrReg_2 + _zz_conv2_wAddrReg_6);
  assign _zz_conv2_wAddrReg_2 = (_zz_conv2_wAddrReg_3 + _zz_conv2_wAddrReg_4);
  assign _zz_conv2_wAddrReg_3 = (conv2_outChReg * 8'hc8);
  assign _zz_conv2_wAddrReg_5 = 6'h0;
  assign _zz_conv2_wAddrReg_4 = {7'd0, _zz_conv2_wAddrReg_5};
  assign _zz_conv2_wAddrReg_7 = 4'b0000;
  assign _zz_conv2_wAddrReg_6 = {9'd0, _zz_conv2_wAddrReg_7};
  assign _zz_conv2_wAddrReg_9 = 4'b0000;
  assign _zz_conv2_wAddrReg_8 = {9'd0, _zz_conv2_wAddrReg_9};
  assign _zz_conv2_rowStepReg = (conv2_rowStepReg + 6'h01);
  assign _zz_conv2_prodReg_p0 = ($signed(_zz_conv2_prodReg_p0_1) * $signed(_zz_conv2_prodReg_p0_3));
  assign _zz_conv2_prodReg_p0_1 = ($signed(_zz_conv2_prodReg_p0_2) - $signed(9'h0));
  assign _zz_conv2_prodReg_p0_2 = {{1{conv2_inValsReg_0[7]}}, conv2_inValsReg_0};
  assign _zz_conv2_prodReg_p0_3 = ($signed(_zz_conv2_prodReg_p0_4) - $signed(9'h0));
  assign _zz_conv2_prodReg_p0_4 = {{1{conv2_wValsReg_p0_i0[7]}}, conv2_wValsReg_p0_i0};
  assign _zz_conv2_absAReg_p0 = (($signed(conv2_accumRequantReg_p0) < $signed(32'h0)) ? _zz_conv2_absAReg_p0_1 : conv2_accumRequantReg_p0);
  assign _zz_conv2_absAReg_p0_1 = (- conv2_accumRequantReg_p0);
  assign _zz_conv2_pSumReg_p0 = {1'd0, conv2_pLH_Reg_p0};
  assign _zz_conv2_pSumReg_p0_1 = {1'd0, conv2_pHL_Reg_p0};
  assign _zz_conv2_part1Reg_p0 = {32'd0, conv2_pLL_Reg2_p0};
  assign _zz_conv2_part1Reg_p0_2 = ({16'd0,_zz_conv2_part1Reg_p0_3} <<< 5'd16);
  assign _zz_conv2_part1Reg_p0_1 = _zz_conv2_part1Reg_p0_2[63:0];
  assign _zz_conv2_part1Reg_p0_3 = {31'd0, conv2_pSumReg_p0};
  assign _zz_conv2_part2Reg_p0 = ({32'd0,_zz_conv2_part2Reg_p0_1} <<< 6'd32);
  assign _zz_conv2_part2Reg_p0_1 = {32'd0, conv2_pHH_Reg2_p0};
  assign _zz_conv2_reqProdReg2_p0_1 = (- _zz_conv2_reqProdReg2_p0_2);
  assign _zz_conv2_reqProdReg2_p0_2 = _zz_conv2_reqProdReg2_p0;
  assign _zz_conv2_reqProdReg2_p0_3 = _zz_conv2_reqProdReg2_p0;
  assign _zz__zz_conv2_resultReg_p0_1 = (conv2_reqProdReg2_p0 >>> 6'd39);
  assign _zz__zz_conv2_resultReg_p0 = {{7{_zz__zz_conv2_resultReg_p0_1[24]}}, _zz__zz_conv2_resultReg_p0_1};
  assign _zz_conv2_resultReg_p0_1 = (($signed(_zz_conv2_resultReg_p0) < $signed(32'hffffff80)) ? 8'h80 : _zz_conv2_resultReg_p0_2);
  assign _zz_conv2_resultReg_p0_2 = _zz_conv2_resultReg_p0[7:0];
  assign _zz_conv2_outChReg = (conv2_outChReg + 5'h01);
  assign _zz_conv2_outColReg = (conv2_outColReg + 4'b0001);
  assign _zz_conv2_outRowReg = (conv2_outRowReg + 4'b0001);
  assign _zz_relu2_activationOut_payload_value = (($signed(8'h7f) < $signed(QLinearConvPlugin_logic_outStream_payload_value_1)) ? 8'h7f : QLinearConvPlugin_logic_outStream_payload_value_1);
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
  assign _zz_conv1_inValsR_0_2 = 1'b1;
  assign _zz_conv1_inputBuf_0_port_4 = _zz_conv1_inputBuf_0_port_5;
  assign _zz_conv1_inputBuf_0_port_6 = (_zz_5 || ((conv1_stateReg == conv1_sReceive) && io_activationIn_fire));
  assign _zz_conv1_wValsR_0_1 = 1'b1;
  assign _zz_conv1_biasVals_0_2 = 1'b1;
  assign _zz_pool1_rowReads_0_1 = 1'b1;
  assign _zz_pool1_rowBuf_0_port_1 = ReLUPlugin_logic_outStream_payload_value;
  assign _zz_pool1_rowBuf_0_port_2 = ((((pool1_stateReg == pool1_sReceiveRow) && (pool1_rowWrPtrReg == 1'b0)) && ReLUPlugin_logic_outStream_fire) && (! 1'b0));
  assign _zz_pool1_rowReads_1_1 = 1'b1;
  assign _zz_pool1_rowBuf_1_port_1 = ReLUPlugin_logic_outStream_payload_value;
  assign _zz_pool1_rowBuf_1_port_2 = ((((pool1_stateReg == pool1_sReceiveRow) && (pool1_rowWrPtrReg == 1'b1)) && ReLUPlugin_logic_outStream_fire) && (! 1'b0));
  assign _zz_conv2_inValsR_0_1 = 1'b1;
  assign _zz_conv2_inputBuf_0_port_1 = (_zz_14 ? conv2_initAddrReg : conv2_padWriteAddrReg);
  assign _zz_conv2_inputBuf_0_port_2 = _zz_conv2_inputBuf_0_port_3;
  assign _zz_conv2_inputBuf_0_port_4 = (_zz_14 || ((conv2_stateReg == conv2_sReceive) && MaxPoolLinePlugin_logic_outStream_fire));
  assign _zz_conv2_wValsR_0_1 = 1'b1;
  assign _zz_conv2_biasVals_0_2 = 1'b1;
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
    if(_zz_conv1_inValsR_0_2) begin
      conv1_inputBuf_0_spinal_port0 <= conv1_inputBuf_0[_zz_conv1_inValsR_0_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv1_inputBuf_0_port_6) begin
      conv1_inputBuf_0[_zz_conv1_inputBuf_0_port_2] <= _zz_conv1_inputBuf_0_port_4;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv1_weightRom_p0_i0.bin",conv1_weightRom_p0_i0);
  end
  always @(posedge clk) begin
    if(_zz_conv1_wValsR_0_1) begin
      conv1_weightRom_p0_i0_spinal_port0 <= conv1_weightRom_p0_i0[_zz_conv1_wValsR_0];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv1_biasRom_p0.bin",conv1_biasRom_p0);
  end
  always @(posedge clk) begin
    if(_zz_conv1_biasVals_0_2) begin
      conv1_biasRom_p0_spinal_port0 <= conv1_biasRom_p0[_zz_conv1_biasVals_0_1];
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
    if(_zz_conv2_inValsR_0_1) begin
      conv2_inputBuf_0_spinal_port0 <= conv2_inputBuf_0[_zz_conv2_inValsR_0];
    end
  end

  always @(posedge clk) begin
    if(_zz_conv2_inputBuf_0_port_4) begin
      conv2_inputBuf_0[_zz_conv2_inputBuf_0_port_1] <= _zz_conv2_inputBuf_0_port_2;
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv2_weightRom_p0_i0.bin",conv2_weightRom_p0_i0);
  end
  always @(posedge clk) begin
    if(_zz_conv2_wValsR_0_1) begin
      conv2_weightRom_p0_i0_spinal_port0 <= conv2_weightRom_p0_i0[_zz_conv2_wValsR_0];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv2_biasRom_p0.bin",conv2_biasRom_p0);
  end
  always @(posedge clk) begin
    if(_zz_conv2_biasVals_0_2) begin
      conv2_biasRom_p0_spinal_port0 <= conv2_biasRom_p0[_zz_conv2_biasVals_0_1];
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
    case(pool1_curSlotReg)
      1'b0 : _zz_pool1_readData = pool1_rowReads_0;
      default : _zz_pool1_readData = pool1_rowReads_1;
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

  assign conv1_sReceive = 4'b0000;
  assign conv1_sLoadBias = 4'b0001;
  assign conv1_sCompute = 4'b0010;
  assign conv1_sRequant = 4'b0011;
  assign conv1_sRequantMul = 4'b0100;
  assign conv1_sRequantWait = 4'b0101;
  assign conv1_sRequantWait2 = 4'b0110;
  assign conv1_sRequantWait3 = 4'b0111;
  assign conv1_sRequantShift = 4'b1000;
  assign conv1_sEmit = 4'b1001;
  assign conv1_sInit = 4'b1010;
  assign conv1_sWaitBias = 4'b1011;
  assign conv1_sLoadWeights = 4'b1100;
  always @(*) begin
    conv1_inAddrComb = conv1_inAddrReg;
    if(when_QLinearConvCore_l453) begin
      if(when_QLinearConvCore_l456) begin
        conv1_inAddrComb = conv1_inAddrReg;
      end
    end
  end

  always @(*) begin
    conv1_wAddrComb = conv1_wAddrReg;
    if(when_QLinearConvCore_l453) begin
      if(when_QLinearConvCore_l456) begin
        conv1_wAddrComb = conv1_wAddrReg;
      end
    end
  end

  assign _zz_conv1_inValsR_0 = conv1_inAddrComb;
  assign conv1_inValsR_0 = conv1_inputBuf_0_spinal_port0;
  assign _zz_conv1_wValsR_0 = conv1_wAddrComb;
  assign conv1_wValsR_0 = conv1_weightRom_p0_i0_spinal_port0;
  assign _zz_conv1_biasVals_0 = conv1_outChReg;
  assign conv1_biasVals_0 = conv1_biasRom_p0_spinal_port0;
  assign _zz_5 = (conv1_stateReg == conv1_sInit);
  assign io_activationIn_fire = (activation_in_valid && activation_in_ready);
  always @(*) begin
    activation_in_ready = 1'b0;
    if(when_QLinearConvCore_l389) begin
      activation_in_ready = 1'b1;
    end
  end

  always @(*) begin
    conv1_activationOut_valid = 1'b0;
    if(when_QLinearConvCore_l569) begin
      conv1_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    conv1_activationOut_payload_value = conv1_resultReg_p0;
    if(when_QLinearConvCore_l569) begin
      conv1_activationOut_payload_value = conv1_resultReg_p0;
    end
  end

  assign when_QLinearConvCore_l378 = (conv1_stateReg == conv1_sInit);
  assign when_QLinearConvCore_l379 = (conv1_initAddrReg == 11'h3ff);
  assign when_QLinearConvCore_l389 = (conv1_stateReg == conv1_sReceive);
  assign _zz_conv1_padWriteAddrReg = (conv1_rowElemReg == 5'h1b);
  assign when_QLinearConvCore_l398 = (conv1_recvCntReg == 10'h30f);
  assign when_QLinearConvCore_l434 = (conv1_stateReg == conv1_sLoadBias);
  assign when_QLinearConvCore_l445 = (conv1_stateReg == conv1_sWaitBias);
  assign when_QLinearConvCore_l453 = (conv1_stateReg == conv1_sCompute);
  assign when_QLinearConvCore_l456 = (conv1_compCycleReg < 5'h19);
  assign _zz_conv1_inAddrReg = (conv1_rowStepReg == 3'b100);
  assign when_QLinearConvCore_l466 = ((5'h01 <= conv1_compCycleReg) && (conv1_compCycleReg <= 5'h19));
  assign when_QLinearConvCore_l471 = ((5'h02 <= conv1_compCycleReg) && (conv1_compCycleReg <= 5'h1a));
  assign when_QLinearConvCore_l491 = ((5'h03 <= conv1_compCycleReg) && (conv1_compCycleReg <= 5'h1b));
  assign _zz_conv1_accumReg_p0 = ($signed(conv1_accumReg_p0) + $signed(conv1_prodReg_p0));
  assign when_QLinearConvCore_l495 = (conv1_compCycleReg == 5'h1b);
  assign when_QLinearConvCore_l499 = (conv1_compCycleReg == 5'h1b);
  assign when_QLinearConvCore_l507 = (conv1_stateReg == conv1_sRequant);
  assign when_QLinearConvCore_l515 = (conv1_stateReg == conv1_sRequantMul);
  assign _zz_conv1_pLL_Reg_p0 = 32'h41ba2b80;
  assign _zz_conv1_pHL_Reg_p0 = conv1_absAReg_p0[31 : 16];
  assign _zz_conv1_pLL_Reg_p0_1 = conv1_absAReg_p0[15 : 0];
  assign _zz_conv1_pLH_Reg_p0 = _zz_conv1_pLL_Reg_p0[31 : 16];
  assign _zz_conv1_pLL_Reg_p0_2 = _zz_conv1_pLL_Reg_p0[15 : 0];
  assign when_QLinearConvCore_l530 = (conv1_stateReg == conv1_sRequantWait);
  assign when_QLinearConvCore_l539 = (conv1_stateReg == conv1_sRequantWait2);
  assign when_QLinearConvCore_l547 = (conv1_stateReg == conv1_sRequantWait3);
  assign _zz_conv1_reqProdReg2_p0 = (conv1_part1Reg_p0 + conv1_part2Reg_p0);
  assign when_QLinearConvCore_l556 = (conv1_stateReg == conv1_sRequantShift);
  assign _zz_conv1_resultReg_p0 = ($signed(_zz__zz_conv1_resultReg_p0) + $signed(32'h0));
  assign when_QLinearConvCore_l569 = (conv1_stateReg == conv1_sEmit);
  assign conv1_activationOut_fire = (conv1_activationOut_valid && conv1_activationOut_ready);
  assign when_QLinearConvCore_l591 = 1'b1;
  assign when_QLinearConvCore_l597 = (conv1_outChReg == 4'b0111);
  assign when_QLinearConvCore_l599 = (conv1_outColReg == 5'h1b);
  assign _zz_conv1_stateReg = (conv1_outRowReg == 5'h1b);
  assign QLinearConvPlugin_logic_outStream_valid = conv1_activationOut_valid;
  assign conv1_activationOut_ready = QLinearConvPlugin_logic_outStream_ready;
  assign QLinearConvPlugin_logic_outStream_payload_value = conv1_activationOut_payload_value;
  assign relu1_activationOut_valid = QLinearConvPlugin_logic_outStream_valid;
  assign QLinearConvPlugin_logic_outStream_ready = relu1_activationOut_ready;
  assign relu1_activationOut_payload_value = (($signed(QLinearConvPlugin_logic_outStream_payload_value) < $signed(8'h0)) ? 8'h0 : _zz_relu1_activationOut_payload_value);
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
  assign conv2_sReceive = 4'b0000;
  assign conv2_sLoadBias = 4'b0001;
  assign conv2_sCompute = 4'b0010;
  assign conv2_sRequant = 4'b0011;
  assign conv2_sRequantMul = 4'b0100;
  assign conv2_sRequantWait = 4'b0101;
  assign conv2_sRequantWait2 = 4'b0110;
  assign conv2_sRequantWait3 = 4'b0111;
  assign conv2_sRequantShift = 4'b1000;
  assign conv2_sEmit = 4'b1001;
  assign conv2_sInit = 4'b1010;
  assign conv2_sWaitBias = 4'b1011;
  assign conv2_sLoadWeights = 4'b1100;
  always @(*) begin
    conv2_inAddrComb = conv2_inAddrReg;
    if(when_QLinearConvCore_l453_1) begin
      if(when_QLinearConvCore_l456_1) begin
        conv2_inAddrComb = conv2_inAddrReg;
      end
    end
  end

  always @(*) begin
    conv2_wAddrComb = conv2_wAddrReg;
    if(when_QLinearConvCore_l453_1) begin
      if(when_QLinearConvCore_l456_1) begin
        conv2_wAddrComb = conv2_wAddrReg;
      end
    end
  end

  assign _zz_conv2_inValsR_0 = conv2_inAddrComb;
  assign conv2_inValsR_0 = conv2_inputBuf_0_spinal_port0;
  assign _zz_conv2_wValsR_0 = conv2_wAddrComb;
  assign conv2_wValsR_0 = conv2_weightRom_p0_i0_spinal_port0;
  assign _zz_conv2_biasVals_0 = conv2_outChReg;
  assign conv2_biasVals_0 = conv2_biasRom_p0_spinal_port0;
  assign _zz_14 = (conv2_stateReg == conv2_sInit);
  assign MaxPoolLinePlugin_logic_outStream_fire = (MaxPoolLinePlugin_logic_outStream_valid && MaxPoolLinePlugin_logic_outStream_ready);
  always @(*) begin
    MaxPoolLinePlugin_logic_outStream_ready = 1'b0;
    if(when_QLinearConvCore_l389_1) begin
      MaxPoolLinePlugin_logic_outStream_ready = 1'b1;
    end
  end

  always @(*) begin
    conv2_activationOut_valid = 1'b0;
    if(when_QLinearConvCore_l569_1) begin
      conv2_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    conv2_activationOut_payload_value = conv2_resultReg_p0;
    if(when_QLinearConvCore_l569_1) begin
      conv2_activationOut_payload_value = conv2_resultReg_p0;
    end
  end

  assign when_QLinearConvCore_l378_1 = (conv2_stateReg == conv2_sInit);
  assign when_QLinearConvCore_l379_1 = (conv2_initAddrReg == 12'ha1f);
  assign when_QLinearConvCore_l389_1 = (conv2_stateReg == conv2_sReceive);
  assign _zz_conv2_padWriteAddrReg = (conv2_rowElemReg == 7'h6f);
  assign when_QLinearConvCore_l398_1 = (conv2_recvCntReg == 11'h61f);
  assign when_QLinearConvCore_l434_1 = (conv2_stateReg == conv2_sLoadBias);
  assign when_QLinearConvCore_l445_1 = (conv2_stateReg == conv2_sWaitBias);
  assign when_QLinearConvCore_l453_1 = (conv2_stateReg == conv2_sCompute);
  assign when_QLinearConvCore_l456_1 = (conv2_compCycleReg < 8'hc8);
  assign _zz_conv2_inAddrReg = (conv2_rowStepReg == 6'h27);
  assign when_QLinearConvCore_l466_1 = ((8'h01 <= conv2_compCycleReg) && (conv2_compCycleReg <= 8'hc8));
  assign when_QLinearConvCore_l471_1 = ((8'h02 <= conv2_compCycleReg) && (conv2_compCycleReg <= 8'hc9));
  assign when_QLinearConvCore_l491_1 = ((8'h03 <= conv2_compCycleReg) && (conv2_compCycleReg <= 8'hca));
  assign _zz_conv2_accumReg_p0 = ($signed(conv2_accumReg_p0) + $signed(conv2_prodReg_p0));
  assign when_QLinearConvCore_l495_1 = (conv2_compCycleReg == 8'hca);
  assign when_QLinearConvCore_l499_1 = (conv2_compCycleReg == 8'hca);
  assign when_QLinearConvCore_l507_1 = (conv2_stateReg == conv2_sRequant);
  assign when_QLinearConvCore_l515_1 = (conv2_stateReg == conv2_sRequantMul);
  assign _zz_conv2_pLL_Reg_p0 = 32'h48da7d80;
  assign _zz_conv2_pHL_Reg_p0 = conv2_absAReg_p0[31 : 16];
  assign _zz_conv2_pLL_Reg_p0_1 = conv2_absAReg_p0[15 : 0];
  assign _zz_conv2_pLH_Reg_p0 = _zz_conv2_pLL_Reg_p0[31 : 16];
  assign _zz_conv2_pLL_Reg_p0_2 = _zz_conv2_pLL_Reg_p0[15 : 0];
  assign when_QLinearConvCore_l530_1 = (conv2_stateReg == conv2_sRequantWait);
  assign when_QLinearConvCore_l539_1 = (conv2_stateReg == conv2_sRequantWait2);
  assign when_QLinearConvCore_l547_1 = (conv2_stateReg == conv2_sRequantWait3);
  assign _zz_conv2_reqProdReg2_p0 = (conv2_part1Reg_p0 + conv2_part2Reg_p0);
  assign when_QLinearConvCore_l556_1 = (conv2_stateReg == conv2_sRequantShift);
  assign _zz_conv2_resultReg_p0 = ($signed(_zz__zz_conv2_resultReg_p0) + $signed(32'h0));
  assign when_QLinearConvCore_l569_1 = (conv2_stateReg == conv2_sEmit);
  assign conv2_activationOut_fire = (conv2_activationOut_valid && conv2_activationOut_ready);
  assign when_QLinearConvCore_l591_1 = 1'b1;
  assign when_QLinearConvCore_l597_1 = (conv2_outChReg == 5'h0f);
  assign when_QLinearConvCore_l599_1 = (conv2_outColReg == 4'b1101);
  assign _zz_conv2_stateReg = (conv2_outRowReg == 4'b1101);
  assign QLinearConvPlugin_logic_outStream_valid_1 = conv2_activationOut_valid;
  assign conv2_activationOut_ready = QLinearConvPlugin_logic_outStream_ready_1;
  assign QLinearConvPlugin_logic_outStream_payload_value_1 = conv2_activationOut_payload_value;
  assign relu2_activationOut_valid = QLinearConvPlugin_logic_outStream_valid_1;
  assign QLinearConvPlugin_logic_outStream_ready_1 = relu2_activationOut_ready;
  assign relu2_activationOut_payload_value = (($signed(QLinearConvPlugin_logic_outStream_payload_value_1) < $signed(8'h0)) ? 8'h0 : _zz_relu2_activationOut_payload_value);
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
      conv1_stateReg <= 4'b1010;
      conv1_recvCntReg <= 10'h0;
      conv1_padWriteAddrReg <= 11'h042;
      conv1_rowElemReg <= 5'h0;
      conv1_outRowReg <= 5'h0;
      conv1_outColReg <= 5'h0;
      conv1_outChReg <= 4'b0000;
      conv1_accumReg_p0 <= 32'h0;
      conv1_prodReg_p0 <= 32'h0;
      conv1_accumRequantReg_p0 <= 32'h0;
      conv1_resultReg_p0 <= 8'h0;
      conv1_reqProdReg2_p0 <= 64'h0;
      conv1_signAReg_p0 <= 1'b0;
      conv1_absAReg_p0 <= 32'h0;
      conv1_pLL_Reg_p0 <= 32'h0;
      conv1_pLH_Reg_p0 <= 32'h0;
      conv1_pHL_Reg_p0 <= 32'h0;
      conv1_pHH_Reg_p0 <= 32'h0;
      conv1_pSumReg_p0 <= 33'h0;
      conv1_pLL_Reg2_p0 <= 32'h0;
      conv1_pHH_Reg2_p0 <= 32'h0;
      conv1_part1Reg_p0 <= 64'h0;
      conv1_part2Reg_p0 <= 64'h0;
      conv1_initAddrReg <= 11'h0;
      conv1_inAddrReg <= 11'h0;
      conv1_wAddrReg <= 8'h0;
      conv1_compCycleReg <= 5'h0;
      conv1_rowStepReg <= 3'b000;
      conv1_inValsReg_0 <= 8'h0;
      conv1_wValsReg_p0_i0 <= 8'h0;
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
      conv2_stateReg <= 4'b1010;
      conv2_recvCntReg <= 11'h0;
      conv2_padWriteAddrReg <= 12'h130;
      conv2_rowElemReg <= 7'h0;
      conv2_outRowReg <= 4'b0000;
      conv2_outColReg <= 4'b0000;
      conv2_outChReg <= 5'h0;
      conv2_accumReg_p0 <= 32'h0;
      conv2_prodReg_p0 <= 32'h0;
      conv2_accumRequantReg_p0 <= 32'h0;
      conv2_resultReg_p0 <= 8'h0;
      conv2_reqProdReg2_p0 <= 64'h0;
      conv2_signAReg_p0 <= 1'b0;
      conv2_absAReg_p0 <= 32'h0;
      conv2_pLL_Reg_p0 <= 32'h0;
      conv2_pLH_Reg_p0 <= 32'h0;
      conv2_pHL_Reg_p0 <= 32'h0;
      conv2_pHH_Reg_p0 <= 32'h0;
      conv2_pSumReg_p0 <= 33'h0;
      conv2_pLL_Reg2_p0 <= 32'h0;
      conv2_pHH_Reg2_p0 <= 32'h0;
      conv2_part1Reg_p0 <= 64'h0;
      conv2_part2Reg_p0 <= 64'h0;
      conv2_initAddrReg <= 12'h0;
      conv2_inAddrReg <= 12'h0;
      conv2_wAddrReg <= 12'h0;
      conv2_compCycleReg <= 8'h0;
      conv2_rowStepReg <= 6'h0;
      conv2_inValsReg_0 <= 8'h0;
      conv2_wValsReg_p0_i0 <= 8'h0;
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
      if(when_QLinearConvCore_l378) begin
        if(when_QLinearConvCore_l379) begin
          conv1_initAddrReg <= 11'h0;
          conv1_stateReg <= conv1_sReceive;
        end else begin
          conv1_initAddrReg <= (conv1_initAddrReg + 11'h001);
        end
      end
      if(when_QLinearConvCore_l389) begin
        if(io_activationIn_fire) begin
          conv1_rowElemReg <= (_zz_conv1_padWriteAddrReg ? 5'h0 : _zz_conv1_rowElemReg);
          conv1_padWriteAddrReg <= (conv1_padWriteAddrReg + (_zz_conv1_padWriteAddrReg ? 11'h005 : 11'h001));
          conv1_recvCntReg <= (conv1_recvCntReg + 10'h001);
          if(when_QLinearConvCore_l398) begin
            conv1_recvCntReg <= 10'h0;
            conv1_rowElemReg <= 5'h0;
            conv1_padWriteAddrReg <= 11'h042;
            conv1_outRowReg <= 5'h0;
            conv1_outColReg <= 5'h0;
            conv1_outChReg <= 4'b0000;
            conv1_stateReg <= conv1_sLoadBias;
          end
        end
      end
      if(when_QLinearConvCore_l434) begin
        conv1_inAddrReg <= _zz_conv1_inAddrReg_1[10:0];
        conv1_wAddrReg <= _zz_conv1_wAddrReg[7:0];
        conv1_compCycleReg <= 5'h0;
        conv1_rowStepReg <= 3'b000;
        conv1_stateReg <= conv1_sWaitBias;
      end
      if(when_QLinearConvCore_l445) begin
        conv1_accumReg_p0 <= conv1_biasVals_0;
        conv1_stateReg <= conv1_sCompute;
      end
      if(when_QLinearConvCore_l453) begin
        conv1_compCycleReg <= (conv1_compCycleReg + 5'h01);
        if(when_QLinearConvCore_l456) begin
          conv1_wAddrReg <= (conv1_wAddrReg + 8'h01);
          conv1_inAddrReg <= (conv1_inAddrReg + (_zz_conv1_inAddrReg ? 11'h01c : 11'h001));
          conv1_rowStepReg <= (_zz_conv1_inAddrReg ? 3'b000 : _zz_conv1_rowStepReg);
        end
        if(when_QLinearConvCore_l466) begin
          conv1_inValsReg_0 <= conv1_inValsR_0;
          conv1_wValsReg_p0_i0 <= conv1_wValsR_0;
        end
        if(when_QLinearConvCore_l471) begin
          conv1_prodReg_p0 <= {{14{_zz_conv1_prodReg_p0[17]}}, _zz_conv1_prodReg_p0};
        end
        if(when_QLinearConvCore_l491) begin
          conv1_accumReg_p0 <= _zz_conv1_accumReg_p0;
          if(when_QLinearConvCore_l495) begin
            conv1_accumRequantReg_p0 <= _zz_conv1_accumReg_p0;
          end
          if(when_QLinearConvCore_l499) begin
            conv1_stateReg <= conv1_sRequant;
            conv1_compCycleReg <= 5'h0;
          end
        end
      end
      if(when_QLinearConvCore_l507) begin
        conv1_absAReg_p0 <= _zz_conv1_absAReg_p0;
        conv1_signAReg_p0 <= ($signed(conv1_accumRequantReg_p0) < $signed(32'h0));
        conv1_stateReg <= conv1_sRequantMul;
      end
      if(when_QLinearConvCore_l515) begin
        conv1_pLL_Reg_p0 <= (_zz_conv1_pLL_Reg_p0_1 * _zz_conv1_pLL_Reg_p0_2);
        conv1_pLH_Reg_p0 <= (_zz_conv1_pLL_Reg_p0_1 * _zz_conv1_pLH_Reg_p0);
        conv1_pHL_Reg_p0 <= (_zz_conv1_pHL_Reg_p0 * _zz_conv1_pLL_Reg_p0_2);
        conv1_pHH_Reg_p0 <= (_zz_conv1_pHL_Reg_p0 * _zz_conv1_pLH_Reg_p0);
        conv1_stateReg <= conv1_sRequantWait;
      end
      if(when_QLinearConvCore_l530) begin
        conv1_pSumReg_p0 <= (_zz_conv1_pSumReg_p0 + _zz_conv1_pSumReg_p0_1);
        conv1_pLL_Reg2_p0 <= conv1_pLL_Reg_p0;
        conv1_pHH_Reg2_p0 <= conv1_pHH_Reg_p0;
        conv1_stateReg <= conv1_sRequantWait2;
      end
      if(when_QLinearConvCore_l539) begin
        conv1_part1Reg_p0 <= (_zz_conv1_part1Reg_p0 + _zz_conv1_part1Reg_p0_1);
        conv1_part2Reg_p0 <= _zz_conv1_part2Reg_p0[63:0];
        conv1_stateReg <= conv1_sRequantWait3;
      end
      if(when_QLinearConvCore_l547) begin
        conv1_reqProdReg2_p0 <= (conv1_signAReg_p0 ? _zz_conv1_reqProdReg2_p0_1 : _zz_conv1_reqProdReg2_p0_3);
        conv1_stateReg <= conv1_sRequantShift;
      end
      if(when_QLinearConvCore_l556) begin
        conv1_resultReg_p0 <= (($signed(32'h0000007f) < $signed(_zz_conv1_resultReg_p0)) ? 8'h7f : _zz_conv1_resultReg_p0_1);
        conv1_stateReg <= conv1_sEmit;
      end
      if(when_QLinearConvCore_l569) begin
        if(conv1_activationOut_fire) begin
          if(when_QLinearConvCore_l591) begin
            conv1_outChReg <= (when_QLinearConvCore_l597 ? 4'b0000 : _zz_conv1_outChReg);
            if(when_QLinearConvCore_l597) begin
              conv1_outColReg <= (when_QLinearConvCore_l599 ? 5'h0 : _zz_conv1_outColReg);
              if(when_QLinearConvCore_l599) begin
                conv1_outRowReg <= (_zz_conv1_stateReg ? 5'h0 : _zz_conv1_outRowReg);
              end
            end
            conv1_stateReg <= (((when_QLinearConvCore_l597 && when_QLinearConvCore_l599) && _zz_conv1_stateReg) ? conv1_sReceive : conv1_sLoadBias);
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
      if(when_QLinearConvCore_l378_1) begin
        if(when_QLinearConvCore_l379_1) begin
          conv2_initAddrReg <= 12'h0;
          conv2_stateReg <= conv2_sReceive;
        end else begin
          conv2_initAddrReg <= (conv2_initAddrReg + 12'h001);
        end
      end
      if(when_QLinearConvCore_l389_1) begin
        if(MaxPoolLinePlugin_logic_outStream_fire) begin
          conv2_rowElemReg <= (_zz_conv2_padWriteAddrReg ? 7'h0 : _zz_conv2_rowElemReg);
          conv2_padWriteAddrReg <= (conv2_padWriteAddrReg + (_zz_conv2_padWriteAddrReg ? 12'h021 : 12'h001));
          conv2_recvCntReg <= (conv2_recvCntReg + 11'h001);
          if(when_QLinearConvCore_l398_1) begin
            conv2_recvCntReg <= 11'h0;
            conv2_rowElemReg <= 7'h0;
            conv2_padWriteAddrReg <= 12'h130;
            conv2_outRowReg <= 4'b0000;
            conv2_outColReg <= 4'b0000;
            conv2_outChReg <= 5'h0;
            conv2_stateReg <= conv2_sLoadBias;
          end
        end
      end
      if(when_QLinearConvCore_l434_1) begin
        conv2_inAddrReg <= _zz_conv2_inAddrReg_1[11:0];
        conv2_wAddrReg <= _zz_conv2_wAddrReg[11:0];
        conv2_compCycleReg <= 8'h0;
        conv2_rowStepReg <= 6'h0;
        conv2_stateReg <= conv2_sWaitBias;
      end
      if(when_QLinearConvCore_l445_1) begin
        conv2_accumReg_p0 <= conv2_biasVals_0;
        conv2_stateReg <= conv2_sCompute;
      end
      if(when_QLinearConvCore_l453_1) begin
        conv2_compCycleReg <= (conv2_compCycleReg + 8'h01);
        if(when_QLinearConvCore_l456_1) begin
          conv2_wAddrReg <= (conv2_wAddrReg + 12'h001);
          conv2_inAddrReg <= (conv2_inAddrReg + (_zz_conv2_inAddrReg ? 12'h069 : 12'h001));
          conv2_rowStepReg <= (_zz_conv2_inAddrReg ? 6'h0 : _zz_conv2_rowStepReg);
        end
        if(when_QLinearConvCore_l466_1) begin
          conv2_inValsReg_0 <= conv2_inValsR_0;
          conv2_wValsReg_p0_i0 <= conv2_wValsR_0;
        end
        if(when_QLinearConvCore_l471_1) begin
          conv2_prodReg_p0 <= {{14{_zz_conv2_prodReg_p0[17]}}, _zz_conv2_prodReg_p0};
        end
        if(when_QLinearConvCore_l491_1) begin
          conv2_accumReg_p0 <= _zz_conv2_accumReg_p0;
          if(when_QLinearConvCore_l495_1) begin
            conv2_accumRequantReg_p0 <= _zz_conv2_accumReg_p0;
          end
          if(when_QLinearConvCore_l499_1) begin
            conv2_stateReg <= conv2_sRequant;
            conv2_compCycleReg <= 8'h0;
          end
        end
      end
      if(when_QLinearConvCore_l507_1) begin
        conv2_absAReg_p0 <= _zz_conv2_absAReg_p0;
        conv2_signAReg_p0 <= ($signed(conv2_accumRequantReg_p0) < $signed(32'h0));
        conv2_stateReg <= conv2_sRequantMul;
      end
      if(when_QLinearConvCore_l515_1) begin
        conv2_pLL_Reg_p0 <= (_zz_conv2_pLL_Reg_p0_1 * _zz_conv2_pLL_Reg_p0_2);
        conv2_pLH_Reg_p0 <= (_zz_conv2_pLL_Reg_p0_1 * _zz_conv2_pLH_Reg_p0);
        conv2_pHL_Reg_p0 <= (_zz_conv2_pHL_Reg_p0 * _zz_conv2_pLL_Reg_p0_2);
        conv2_pHH_Reg_p0 <= (_zz_conv2_pHL_Reg_p0 * _zz_conv2_pLH_Reg_p0);
        conv2_stateReg <= conv2_sRequantWait;
      end
      if(when_QLinearConvCore_l530_1) begin
        conv2_pSumReg_p0 <= (_zz_conv2_pSumReg_p0 + _zz_conv2_pSumReg_p0_1);
        conv2_pLL_Reg2_p0 <= conv2_pLL_Reg_p0;
        conv2_pHH_Reg2_p0 <= conv2_pHH_Reg_p0;
        conv2_stateReg <= conv2_sRequantWait2;
      end
      if(when_QLinearConvCore_l539_1) begin
        conv2_part1Reg_p0 <= (_zz_conv2_part1Reg_p0 + _zz_conv2_part1Reg_p0_1);
        conv2_part2Reg_p0 <= _zz_conv2_part2Reg_p0[63:0];
        conv2_stateReg <= conv2_sRequantWait3;
      end
      if(when_QLinearConvCore_l547_1) begin
        conv2_reqProdReg2_p0 <= (conv2_signAReg_p0 ? _zz_conv2_reqProdReg2_p0_1 : _zz_conv2_reqProdReg2_p0_3);
        conv2_stateReg <= conv2_sRequantShift;
      end
      if(when_QLinearConvCore_l556_1) begin
        conv2_resultReg_p0 <= (($signed(32'h0000007f) < $signed(_zz_conv2_resultReg_p0)) ? 8'h7f : _zz_conv2_resultReg_p0_1);
        conv2_stateReg <= conv2_sEmit;
      end
      if(when_QLinearConvCore_l569_1) begin
        if(conv2_activationOut_fire) begin
          if(when_QLinearConvCore_l591_1) begin
            conv2_outChReg <= (when_QLinearConvCore_l597_1 ? 5'h0 : _zz_conv2_outChReg);
            if(when_QLinearConvCore_l597_1) begin
              conv2_outColReg <= (when_QLinearConvCore_l599_1 ? 4'b0000 : _zz_conv2_outColReg);
              if(when_QLinearConvCore_l599_1) begin
                conv2_outRowReg <= (_zz_conv2_stateReg ? 4'b0000 : _zz_conv2_outRowReg);
              end
            end
            conv2_stateReg <= (((when_QLinearConvCore_l597_1 && when_QLinearConvCore_l599_1) && _zz_conv2_stateReg) ? conv2_sReceive : conv2_sLoadBias);
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
