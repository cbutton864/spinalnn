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
  input  wire          clk,
  input  wire          reset
);

  reg        [7:0]    conv1_inputBuf_0_spinal_port0;
  reg        [7:0]    conv1_weightRom_0_spinal_port0;
  reg        [31:0]   conv1_biasRom_spinal_port0;
  reg        [7:0]    pool1_inputBuf_spinal_port0;
  reg        [7:0]    conv2_inputBuf_0_spinal_port0;
  reg        [7:0]    conv2_weightRom_0_spinal_port0;
  reg        [31:0]   conv2_biasRom_spinal_port0;
  reg        [7:0]    pool2_inputBuf_spinal_port0;
  reg        [7:0]    linear1_inputBuf_spinal_port0;
  reg        [7:0]    linear1_weightRom_spinal_port0;
  reg        [31:0]   linear1_biasRom_spinal_port0;
  wire       [9:0]    _zz_conv1_inputBuf_0_port;
  wire                _zz_conv1_inputBuf_0_port_1;
  wire       [9:0]    _zz_conv1_inValsR_0_1;
  wire                _zz_conv1_inValsR_0_2;
  wire                _zz_conv1_weightRom_0_port;
  wire                _zz_conv1_wValsR_0_1;
  wire       [2:0]    _zz_conv1_biasRom_port;
  wire                _zz_conv1_biasRom_port_1;
  wire       [2:0]    _zz_conv1_biasVal_1;
  wire                _zz_conv1_biasVal_2;
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
  wire       [17:0]   _zz_conv1_prodReg;
  wire       [8:0]    _zz_conv1_prodReg_1;
  wire       [8:0]    _zz_conv1_prodReg_2;
  wire       [8:0]    _zz_conv1_prodReg_3;
  wire       [8:0]    _zz_conv1_prodReg_4;
  wire       [31:0]   _zz_conv1_absAReg;
  wire       [31:0]   _zz_conv1_absAReg_1;
  wire       [32:0]   _zz_conv1_pSumReg;
  wire       [32:0]   _zz_conv1_pSumReg_1;
  wire       [63:0]   _zz_conv1_part1Reg;
  wire       [63:0]   _zz_conv1_part1Reg_1;
  wire       [79:0]   _zz_conv1_part1Reg_2;
  wire       [63:0]   _zz_conv1_part1Reg_3;
  wire       [95:0]   _zz_conv1_part2Reg;
  wire       [63:0]   _zz_conv1_part2Reg_1;
  wire       [63:0]   _zz_conv1_reqProdReg2_1;
  wire       [63:0]   _zz_conv1_reqProdReg2_2;
  wire       [63:0]   _zz_conv1_reqProdReg2_3;
  wire       [31:0]   _zz__zz_conv1_resultReg;
  wire       [24:0]   _zz__zz_conv1_resultReg_1;
  wire       [7:0]    _zz_conv1_resultReg_1;
  wire       [7:0]    _zz_conv1_resultReg_2;
  wire       [3:0]    _zz_conv1_outChReg;
  wire       [4:0]    _zz_conv1_outColReg;
  wire       [4:0]    _zz_conv1_outRowReg;
  wire       [7:0]    _zz_relu1_activationOut_payload_value;
  wire                _zz_pool1_inputBuf_port;
  wire                _zz_pool1_readData;
  wire       [7:0]    _zz_pool1_inputBuf_port_1;
  wire       [12:0]   _zz_pool1_readAddr;
  wire       [12:0]   _zz_pool1_readAddr_1;
  wire       [4:0]    _zz_pool1_readAddr_2;
  wire       [5:0]    _zz_pool1_readAddr_3;
  wire       [5:0]    _zz_pool1_readAddr_4;
  wire       [5:0]    _zz_pool1_readAddr_5;
  wire       [12:0]   _zz_pool1_readAddr_6;
  wire       [8:0]    _zz_pool1_readAddr_7;
  wire       [4:0]    _zz_pool1_readAddr_8;
  wire       [5:0]    _zz_pool1_readAddr_9;
  wire       [5:0]    _zz_pool1_readAddr_10;
  wire       [5:0]    _zz_pool1_readAddr_11;
  wire       [12:0]   _zz_pool1_readAddr_12;
  wire       [1:0]    _zz_pool1_kcReg;
  wire       [3:0]    _zz_pool1_outChReg;
  wire       [3:0]    _zz_pool1_outColReg;
  wire       [3:0]    _zz_pool1_outRowReg;
  wire                _zz_conv2_inputBuf_0_port;
  wire                _zz_conv2_inValsR_0_1;
  wire                _zz_conv2_weightRom_0_port;
  wire                _zz_conv2_wValsR_0_1;
  wire       [3:0]    _zz_conv2_biasRom_port;
  wire                _zz_conv2_biasRom_port_1;
  wire       [3:0]    _zz_conv2_biasVal_1;
  wire                _zz_conv2_biasVal_2;
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
  wire       [17:0]   _zz_conv2_prodReg;
  wire       [8:0]    _zz_conv2_prodReg_1;
  wire       [8:0]    _zz_conv2_prodReg_2;
  wire       [8:0]    _zz_conv2_prodReg_3;
  wire       [8:0]    _zz_conv2_prodReg_4;
  wire       [31:0]   _zz_conv2_absAReg;
  wire       [31:0]   _zz_conv2_absAReg_1;
  wire       [32:0]   _zz_conv2_pSumReg;
  wire       [32:0]   _zz_conv2_pSumReg_1;
  wire       [63:0]   _zz_conv2_part1Reg;
  wire       [63:0]   _zz_conv2_part1Reg_1;
  wire       [79:0]   _zz_conv2_part1Reg_2;
  wire       [63:0]   _zz_conv2_part1Reg_3;
  wire       [95:0]   _zz_conv2_part2Reg;
  wire       [63:0]   _zz_conv2_part2Reg_1;
  wire       [63:0]   _zz_conv2_reqProdReg2_1;
  wire       [63:0]   _zz_conv2_reqProdReg2_2;
  wire       [63:0]   _zz_conv2_reqProdReg2_3;
  wire       [31:0]   _zz__zz_conv2_resultReg;
  wire       [24:0]   _zz__zz_conv2_resultReg_1;
  wire       [7:0]    _zz_conv2_resultReg_1;
  wire       [7:0]    _zz_conv2_resultReg_2;
  wire       [4:0]    _zz_conv2_outChReg;
  wire       [3:0]    _zz_conv2_outColReg;
  wire       [3:0]    _zz_conv2_outRowReg;
  wire       [7:0]    _zz_relu2_activationOut_payload_value;
  wire                _zz_pool2_inputBuf_port;
  wire                _zz_pool2_readData;
  wire       [7:0]    _zz_pool2_inputBuf_port_1;
  wire       [11:0]   _zz_pool2_readAddr;
  wire       [11:0]   _zz_pool2_readAddr_1;
  wire       [3:0]    _zz_pool2_readAddr_2;
  wire       [4:0]    _zz_pool2_readAddr_3;
  wire       [4:0]    _zz_pool2_readAddr_4;
  wire       [4:0]    _zz_pool2_readAddr_5;
  wire       [11:0]   _zz_pool2_readAddr_6;
  wire       [8:0]    _zz_pool2_readAddr_7;
  wire       [3:0]    _zz_pool2_readAddr_8;
  wire       [4:0]    _zz_pool2_readAddr_9;
  wire       [4:0]    _zz_pool2_readAddr_10;
  wire       [4:0]    _zz_pool2_readAddr_11;
  wire       [11:0]   _zz_pool2_readAddr_12;
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
  reg                 _zz_2;
  reg                 _zz_3;
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
  reg        [31:0]   conv1_accumReg;
  reg        [31:0]   conv1_prodReg;
  reg        [7:0]    conv1_resultReg;
  wire       [63:0]   conv1_reqProdReg1;
  reg        [63:0]   conv1_reqProdReg2;
  reg        [31:0]   conv1_accumRequantReg;
  reg                 conv1_signAReg;
  reg        [31:0]   conv1_absAReg;
  reg        [31:0]   conv1_pLL_Reg;
  reg        [31:0]   conv1_pLH_Reg;
  reg        [31:0]   conv1_pHL_Reg;
  reg        [31:0]   conv1_pHH_Reg;
  reg        [32:0]   conv1_pSumReg;
  reg        [31:0]   conv1_pLL_Reg2;
  reg        [31:0]   conv1_pHH_Reg2;
  reg        [63:0]   conv1_part1Reg;
  reg        [63:0]   conv1_part2Reg;
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
  wire       [3:0]    _zz_conv1_biasVal;
  wire       [31:0]   conv1_biasVal;
  reg        [7:0]    conv1_inValsReg_0;
  reg        [7:0]    conv1_wValsReg_0;
  wire                _zz_7;
  wire                io_activationIn_fire;
  wire                when_QLinearConvCore_l331;
  wire                when_QLinearConvCore_l333;
  wire                when_QLinearConvCore_l347;
  wire                _zz_conv1_padWriteAddrReg;
  wire                when_QLinearConvCore_l357;
  wire                when_QLinearConvCore_l390;
  wire                when_QLinearConvCore_l404;
  wire                when_QLinearConvCore_l412;
  wire                when_QLinearConvCore_l416;
  wire                _zz_conv1_inAddrReg;
  wire                when_QLinearConvCore_l429;
  wire                when_QLinearConvCore_l437;
  wire                when_QLinearConvCore_l448;
  wire       [31:0]   _zz_conv1_accumReg;
  wire                when_QLinearConvCore_l452;
  wire                when_QLinearConvCore_l461;
  wire                when_QLinearConvCore_l468;
  wire       [31:0]   _zz_conv1_pLL_Reg;
  wire       [15:0]   _zz_conv1_pHL_Reg;
  wire       [15:0]   _zz_conv1_pLL_Reg_1;
  wire       [15:0]   _zz_conv1_pLH_Reg;
  wire       [15:0]   _zz_conv1_pLL_Reg_2;
  wire                when_QLinearConvCore_l485;
  wire                when_QLinearConvCore_l493;
  wire                when_QLinearConvCore_l500;
  wire       [63:0]   _zz_conv1_reqProdReg2;
  wire                when_QLinearConvCore_l508;
  wire       [31:0]   _zz_conv1_resultReg;
  wire                when_QLinearConvCore_l519;
  wire                conv1_activationOut_fire;
  wire                when_QLinearConvCore_l529;
  wire                when_QLinearConvCore_l531;
  wire                _zz_conv1_stateReg;
  wire                ReLUPlugin_logic_outStream_valid;
  reg                 ReLUPlugin_logic_outStream_ready;
  wire       [7:0]    ReLUPlugin_logic_outStream_payload_value;
  wire                relu1_activationOut_valid;
  wire                relu1_activationOut_ready;
  wire       [7:0]    relu1_activationOut_payload_value;
  wire                MaxPoolPlugin_logic_outStream_valid;
  reg                 MaxPoolPlugin_logic_outStream_ready;
  wire       [7:0]    MaxPoolPlugin_logic_outStream_payload_value;
  reg                 pool1_activationOut_valid;
  wire                pool1_activationOut_ready;
  wire       [7:0]    pool1_activationOut_payload_value;
  reg                 pool1_computeReg;
  reg        [12:0]   pool1_recvCntReg;
  reg        [3:0]    pool1_outRowReg;
  reg        [3:0]    pool1_outColReg;
  reg        [3:0]    pool1_outChReg;
  reg        [2:0]    pool1_phaseReg;
  reg        [1:0]    pool1_krReg;
  reg        [1:0]    pool1_kcReg;
  reg        [7:0]    pool1_maxReg;
  reg        [12:0]   pool1_readAddr;
  wire       [7:0]    pool1_readData;
  reg        [7:0]    pool1_readDataReg;
  wire                when_MaxPoolCore_l93;
  wire                ReLUPlugin_logic_outStream_fire;
  wire                when_MaxPoolCore_l101;
  wire                when_MaxPoolCore_l129;
  wire                when_MaxPoolCore_l133;
  wire                when_MaxPoolCore_l137;
  wire                when_MaxPoolCore_l139;
  wire                when_MaxPoolCore_l144;
  wire                pool1_activationOut_fire;
  wire                when_MaxPoolCore_l155;
  wire                when_MaxPoolCore_l158;
  wire                when_MaxPoolCore_l161;
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
  reg        [31:0]   conv2_accumReg;
  reg        [31:0]   conv2_prodReg;
  reg        [7:0]    conv2_resultReg;
  wire       [63:0]   conv2_reqProdReg1;
  reg        [63:0]   conv2_reqProdReg2;
  reg        [31:0]   conv2_accumRequantReg;
  reg                 conv2_signAReg;
  reg        [31:0]   conv2_absAReg;
  reg        [31:0]   conv2_pLL_Reg;
  reg        [31:0]   conv2_pLH_Reg;
  reg        [31:0]   conv2_pHL_Reg;
  reg        [31:0]   conv2_pHH_Reg;
  reg        [32:0]   conv2_pSumReg;
  reg        [31:0]   conv2_pLL_Reg2;
  reg        [31:0]   conv2_pHH_Reg2;
  reg        [63:0]   conv2_part1Reg;
  reg        [63:0]   conv2_part2Reg;
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
  wire       [4:0]    _zz_conv2_biasVal;
  wire       [31:0]   conv2_biasVal;
  reg        [7:0]    conv2_inValsReg_0;
  reg        [7:0]    conv2_wValsReg_0;
  wire                _zz_14;
  wire                MaxPoolPlugin_logic_outStream_fire;
  wire                when_QLinearConvCore_l331_1;
  wire                when_QLinearConvCore_l333_1;
  wire                when_QLinearConvCore_l347_1;
  wire                _zz_conv2_padWriteAddrReg;
  wire                when_QLinearConvCore_l357_1;
  wire                when_QLinearConvCore_l390_1;
  wire                when_QLinearConvCore_l404_1;
  wire                when_QLinearConvCore_l412_1;
  wire                when_QLinearConvCore_l416_1;
  wire                _zz_conv2_inAddrReg;
  wire                when_QLinearConvCore_l429_1;
  wire                when_QLinearConvCore_l437_1;
  wire                when_QLinearConvCore_l448_1;
  wire       [31:0]   _zz_conv2_accumReg;
  wire                when_QLinearConvCore_l452_1;
  wire                when_QLinearConvCore_l461_1;
  wire                when_QLinearConvCore_l468_1;
  wire       [31:0]   _zz_conv2_pLL_Reg;
  wire       [15:0]   _zz_conv2_pHL_Reg;
  wire       [15:0]   _zz_conv2_pLL_Reg_1;
  wire       [15:0]   _zz_conv2_pLH_Reg;
  wire       [15:0]   _zz_conv2_pLL_Reg_2;
  wire                when_QLinearConvCore_l485_1;
  wire                when_QLinearConvCore_l493_1;
  wire                when_QLinearConvCore_l500_1;
  wire       [63:0]   _zz_conv2_reqProdReg2;
  wire                when_QLinearConvCore_l508_1;
  wire       [31:0]   _zz_conv2_resultReg;
  wire                when_QLinearConvCore_l519_1;
  wire                conv2_activationOut_fire;
  wire                when_QLinearConvCore_l529_1;
  wire                when_QLinearConvCore_l531_1;
  wire                _zz_conv2_stateReg;
  wire                ReLUPlugin_logic_outStream_valid_1;
  reg                 ReLUPlugin_logic_outStream_ready_1;
  wire       [7:0]    ReLUPlugin_logic_outStream_payload_value_1;
  wire                relu2_activationOut_valid;
  wire                relu2_activationOut_ready;
  wire       [7:0]    relu2_activationOut_payload_value;
  wire                MaxPoolPlugin_logic_outStream_valid_1;
  reg                 MaxPoolPlugin_logic_outStream_ready_1;
  wire       [7:0]    MaxPoolPlugin_logic_outStream_payload_value_1;
  reg                 pool2_activationOut_valid;
  wire                pool2_activationOut_ready;
  wire       [7:0]    pool2_activationOut_payload_value;
  reg                 pool2_computeReg;
  reg        [11:0]   pool2_recvCntReg;
  reg        [2:0]    pool2_outRowReg;
  reg        [2:0]    pool2_outColReg;
  reg        [4:0]    pool2_outChReg;
  reg        [3:0]    pool2_phaseReg;
  reg        [1:0]    pool2_krReg;
  reg        [1:0]    pool2_kcReg;
  reg        [7:0]    pool2_maxReg;
  reg        [11:0]   pool2_readAddr;
  wire       [7:0]    pool2_readData;
  reg        [7:0]    pool2_readDataReg;
  wire                when_MaxPoolCore_l93_1;
  wire                ReLUPlugin_logic_outStream_fire_1;
  wire                when_MaxPoolCore_l101_1;
  wire                when_MaxPoolCore_l129_1;
  wire                when_MaxPoolCore_l133_1;
  wire                when_MaxPoolCore_l137_1;
  wire                when_MaxPoolCore_l139_1;
  wire                when_MaxPoolCore_l144_1;
  wire                pool2_activationOut_fire;
  wire                when_MaxPoolCore_l155_1;
  wire                when_MaxPoolCore_l158_1;
  wire                when_MaxPoolCore_l161_1;
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
  wire                when_QLinearLinearCore_l160;
  wire                MaxPoolPlugin_logic_outStream_fire_1;
  wire                when_QLinearLinearCore_l165;
  wire                when_QLinearLinearCore_l189;
  wire                when_QLinearLinearCore_l195;
  wire                when_QLinearLinearCore_l201;
  wire                when_QLinearLinearCore_l205;
  wire                when_QLinearLinearCore_l212;
  wire                when_QLinearLinearCore_l218;
  wire                when_QLinearLinearCore_l225;
  wire       [31:0]   _zz_linear1_accumReg;
  wire                when_QLinearLinearCore_l229;
  wire                when_QLinearLinearCore_l238;
  wire                when_QLinearLinearCore_l245;
  wire       [31:0]   _zz_linear1_pLL_Reg;
  wire       [15:0]   _zz_linear1_pHL_Reg;
  wire       [15:0]   _zz_linear1_pLL_Reg_1;
  wire       [15:0]   _zz_linear1_pLH_Reg;
  wire       [15:0]   _zz_linear1_pLL_Reg_2;
  wire                when_QLinearLinearCore_l261;
  wire                when_QLinearLinearCore_l269;
  wire                when_QLinearLinearCore_l276;
  wire       [63:0]   _zz_linear1_reqProdReg2;
  wire                when_QLinearLinearCore_l284;
  wire       [31:0]   _zz_linear1_resultReg;
  wire                when_QLinearLinearCore_l295;
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
  reg [7:0] conv1_weightRom_0 [0:199];
  reg [31:0] conv1_biasRom [0:7];
  reg [7:0] pool1_inputBuf [0:6271];
  reg [7:0] conv2_inputBuf_0 [0:2591];
  reg [7:0] conv2_weightRom_0 [0:3199];
  reg [31:0] conv2_biasRom [0:15];
  reg [7:0] pool2_inputBuf [0:3135];
  reg [7:0] linear1_inputBuf [0:255];
  reg [7:0] linear1_weightRom [0:2559];
  reg [31:0] linear1_biasRom [0:9];

  assign _zz_conv1_inValsR_0_1 = _zz_conv1_inValsR_0[9:0];
  assign _zz_conv1_biasVal_1 = _zz_conv1_biasVal[2:0];
  assign _zz_conv1_inputBuf_0_port_3 = (_zz_7 ? conv1_initAddrReg : conv1_padWriteAddrReg);
  assign _zz_conv1_inputBuf_0_port_2 = _zz_conv1_inputBuf_0_port_3[9:0];
  assign _zz_conv1_inputBuf_0_port_5 = (_zz_7 ? 8'h0 : activation_in_data);
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
  assign _zz_conv1_prodReg = ($signed(_zz_conv1_prodReg_1) * $signed(_zz_conv1_prodReg_3));
  assign _zz_conv1_prodReg_1 = ($signed(_zz_conv1_prodReg_2) - $signed(9'h0));
  assign _zz_conv1_prodReg_2 = {{1{conv1_inValsReg_0[7]}}, conv1_inValsReg_0};
  assign _zz_conv1_prodReg_3 = ($signed(_zz_conv1_prodReg_4) - $signed(9'h0));
  assign _zz_conv1_prodReg_4 = {{1{conv1_wValsReg_0[7]}}, conv1_wValsReg_0};
  assign _zz_conv1_absAReg = (($signed(conv1_accumRequantReg) < $signed(32'h0)) ? _zz_conv1_absAReg_1 : conv1_accumRequantReg);
  assign _zz_conv1_absAReg_1 = (- conv1_accumRequantReg);
  assign _zz_conv1_pSumReg = {1'd0, conv1_pLH_Reg};
  assign _zz_conv1_pSumReg_1 = {1'd0, conv1_pHL_Reg};
  assign _zz_conv1_part1Reg = {32'd0, conv1_pLL_Reg2};
  assign _zz_conv1_part1Reg_2 = ({16'd0,_zz_conv1_part1Reg_3} <<< 5'd16);
  assign _zz_conv1_part1Reg_1 = _zz_conv1_part1Reg_2[63:0];
  assign _zz_conv1_part1Reg_3 = {31'd0, conv1_pSumReg};
  assign _zz_conv1_part2Reg = ({32'd0,_zz_conv1_part2Reg_1} <<< 6'd32);
  assign _zz_conv1_part2Reg_1 = {32'd0, conv1_pHH_Reg2};
  assign _zz_conv1_reqProdReg2_1 = (- _zz_conv1_reqProdReg2_2);
  assign _zz_conv1_reqProdReg2_2 = _zz_conv1_reqProdReg2;
  assign _zz_conv1_reqProdReg2_3 = _zz_conv1_reqProdReg2;
  assign _zz__zz_conv1_resultReg_1 = (conv1_reqProdReg2 >>> 6'd39);
  assign _zz__zz_conv1_resultReg = {{7{_zz__zz_conv1_resultReg_1[24]}}, _zz__zz_conv1_resultReg_1};
  assign _zz_conv1_resultReg_1 = (($signed(_zz_conv1_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz_conv1_resultReg_2);
  assign _zz_conv1_resultReg_2 = _zz_conv1_resultReg[7:0];
  assign _zz_conv1_outChReg = (conv1_outChReg + 4'b0001);
  assign _zz_conv1_outColReg = (conv1_outColReg + 5'h01);
  assign _zz_conv1_outRowReg = (conv1_outRowReg + 5'h01);
  assign _zz_relu1_activationOut_payload_value = (($signed(8'h7f) < $signed(QLinearConvPlugin_logic_outStream_payload_value)) ? 8'h7f : QLinearConvPlugin_logic_outStream_payload_value);
  assign _zz_pool1_readAddr = (_zz_pool1_readAddr_1 + _zz_pool1_readAddr_6);
  assign _zz_pool1_readAddr_1 = (_zz_pool1_readAddr_2 * 8'he0);
  assign _zz_pool1_readAddr_3 = (_zz_pool1_readAddr_4 + _zz_pool1_readAddr_5);
  assign _zz_pool1_readAddr_2 = _zz_pool1_readAddr_3[4:0];
  assign _zz_pool1_readAddr_4 = (pool1_outRowReg * 2'b10);
  assign _zz_pool1_readAddr_5 = {4'd0, pool1_krReg};
  assign _zz_pool1_readAddr_7 = (_zz_pool1_readAddr_8 * 4'b1000);
  assign _zz_pool1_readAddr_6 = {4'd0, _zz_pool1_readAddr_7};
  assign _zz_pool1_readAddr_9 = (_zz_pool1_readAddr_10 + _zz_pool1_readAddr_11);
  assign _zz_pool1_readAddr_8 = _zz_pool1_readAddr_9[4:0];
  assign _zz_pool1_readAddr_10 = (pool1_outColReg * 2'b10);
  assign _zz_pool1_readAddr_11 = {4'd0, pool1_kcReg};
  assign _zz_pool1_readAddr_12 = {9'd0, pool1_outChReg};
  assign _zz_pool1_kcReg = (pool1_kcReg + 2'b01);
  assign _zz_pool1_outChReg = (pool1_outChReg + 4'b0001);
  assign _zz_pool1_outColReg = (pool1_outColReg + 4'b0001);
  assign _zz_pool1_outRowReg = (pool1_outRowReg + 4'b0001);
  assign _zz_conv2_biasVal_1 = _zz_conv2_biasVal[3:0];
  assign _zz_conv2_inputBuf_0_port_3 = (_zz_14 ? 8'h0 : MaxPoolPlugin_logic_outStream_payload_value);
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
  assign _zz_conv2_prodReg = ($signed(_zz_conv2_prodReg_1) * $signed(_zz_conv2_prodReg_3));
  assign _zz_conv2_prodReg_1 = ($signed(_zz_conv2_prodReg_2) - $signed(9'h0));
  assign _zz_conv2_prodReg_2 = {{1{conv2_inValsReg_0[7]}}, conv2_inValsReg_0};
  assign _zz_conv2_prodReg_3 = ($signed(_zz_conv2_prodReg_4) - $signed(9'h0));
  assign _zz_conv2_prodReg_4 = {{1{conv2_wValsReg_0[7]}}, conv2_wValsReg_0};
  assign _zz_conv2_absAReg = (($signed(conv2_accumRequantReg) < $signed(32'h0)) ? _zz_conv2_absAReg_1 : conv2_accumRequantReg);
  assign _zz_conv2_absAReg_1 = (- conv2_accumRequantReg);
  assign _zz_conv2_pSumReg = {1'd0, conv2_pLH_Reg};
  assign _zz_conv2_pSumReg_1 = {1'd0, conv2_pHL_Reg};
  assign _zz_conv2_part1Reg = {32'd0, conv2_pLL_Reg2};
  assign _zz_conv2_part1Reg_2 = ({16'd0,_zz_conv2_part1Reg_3} <<< 5'd16);
  assign _zz_conv2_part1Reg_1 = _zz_conv2_part1Reg_2[63:0];
  assign _zz_conv2_part1Reg_3 = {31'd0, conv2_pSumReg};
  assign _zz_conv2_part2Reg = ({32'd0,_zz_conv2_part2Reg_1} <<< 6'd32);
  assign _zz_conv2_part2Reg_1 = {32'd0, conv2_pHH_Reg2};
  assign _zz_conv2_reqProdReg2_1 = (- _zz_conv2_reqProdReg2_2);
  assign _zz_conv2_reqProdReg2_2 = _zz_conv2_reqProdReg2;
  assign _zz_conv2_reqProdReg2_3 = _zz_conv2_reqProdReg2;
  assign _zz__zz_conv2_resultReg_1 = (conv2_reqProdReg2 >>> 6'd39);
  assign _zz__zz_conv2_resultReg = {{7{_zz__zz_conv2_resultReg_1[24]}}, _zz__zz_conv2_resultReg_1};
  assign _zz_conv2_resultReg_1 = (($signed(_zz_conv2_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz_conv2_resultReg_2);
  assign _zz_conv2_resultReg_2 = _zz_conv2_resultReg[7:0];
  assign _zz_conv2_outChReg = (conv2_outChReg + 5'h01);
  assign _zz_conv2_outColReg = (conv2_outColReg + 4'b0001);
  assign _zz_conv2_outRowReg = (conv2_outRowReg + 4'b0001);
  assign _zz_relu2_activationOut_payload_value = (($signed(8'h7f) < $signed(QLinearConvPlugin_logic_outStream_payload_value_1)) ? 8'h7f : QLinearConvPlugin_logic_outStream_payload_value_1);
  assign _zz_pool2_readAddr = (_zz_pool2_readAddr_1 + _zz_pool2_readAddr_6);
  assign _zz_pool2_readAddr_1 = (_zz_pool2_readAddr_2 * 8'he0);
  assign _zz_pool2_readAddr_3 = (_zz_pool2_readAddr_4 + _zz_pool2_readAddr_5);
  assign _zz_pool2_readAddr_2 = _zz_pool2_readAddr_3[3:0];
  assign _zz_pool2_readAddr_4 = (pool2_outRowReg * 2'b11);
  assign _zz_pool2_readAddr_5 = {3'd0, pool2_krReg};
  assign _zz_pool2_readAddr_7 = (_zz_pool2_readAddr_8 * 5'h10);
  assign _zz_pool2_readAddr_6 = {3'd0, _zz_pool2_readAddr_7};
  assign _zz_pool2_readAddr_9 = (_zz_pool2_readAddr_10 + _zz_pool2_readAddr_11);
  assign _zz_pool2_readAddr_8 = _zz_pool2_readAddr_9[3:0];
  assign _zz_pool2_readAddr_10 = (pool2_outColReg * 2'b11);
  assign _zz_pool2_readAddr_11 = {3'd0, pool2_kcReg};
  assign _zz_pool2_readAddr_12 = {7'd0, pool2_outChReg};
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
  assign _zz_conv1_inputBuf_0_port_6 = (_zz_7 || ((conv1_stateReg == conv1_sReceive) && io_activationIn_fire));
  assign _zz_conv1_wValsR_0_1 = 1'b1;
  assign _zz_conv1_biasVal_2 = 1'b1;
  assign _zz_pool1_readData = 1'b1;
  assign _zz_pool1_inputBuf_port_1 = ReLUPlugin_logic_outStream_payload_value;
  assign _zz_conv2_inValsR_0_1 = 1'b1;
  assign _zz_conv2_inputBuf_0_port_1 = (_zz_14 ? conv2_initAddrReg : conv2_padWriteAddrReg);
  assign _zz_conv2_inputBuf_0_port_2 = _zz_conv2_inputBuf_0_port_3;
  assign _zz_conv2_inputBuf_0_port_4 = (_zz_14 || ((conv2_stateReg == conv2_sReceive) && MaxPoolPlugin_logic_outStream_fire));
  assign _zz_conv2_wValsR_0_1 = 1'b1;
  assign _zz_conv2_biasVal_2 = 1'b1;
  assign _zz_pool2_readData = 1'b1;
  assign _zz_pool2_inputBuf_port_1 = ReLUPlugin_logic_outStream_payload_value_1;
  assign _zz_linear1_inValR = 1'b1;
  assign _zz_linear1_inputBuf_port_2 = MaxPoolPlugin_logic_outStream_payload_value_1;
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
    $readmemb("SpinalNNTop.v_toplevel_conv1_weightRom_0.bin",conv1_weightRom_0);
  end
  always @(posedge clk) begin
    if(_zz_conv1_wValsR_0_1) begin
      conv1_weightRom_0_spinal_port0 <= conv1_weightRom_0[_zz_conv1_wValsR_0];
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
    if(_zz_pool1_readData) begin
      pool1_inputBuf_spinal_port0 <= pool1_inputBuf[pool1_readAddr];
    end
  end

  always @(posedge clk) begin
    if(_zz_3) begin
      pool1_inputBuf[pool1_recvCntReg] <= _zz_pool1_inputBuf_port_1;
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
    $readmemb("SpinalNNTop.v_toplevel_conv2_weightRom_0.bin",conv2_weightRom_0);
  end
  always @(posedge clk) begin
    if(_zz_conv2_wValsR_0_1) begin
      conv2_weightRom_0_spinal_port0 <= conv2_weightRom_0[_zz_conv2_wValsR_0];
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
    if(_zz_pool2_readData) begin
      pool2_inputBuf_spinal_port0 <= pool2_inputBuf[pool2_readAddr];
    end
  end

  always @(posedge clk) begin
    if(_zz_2) begin
      pool2_inputBuf[pool2_recvCntReg] <= _zz_pool2_inputBuf_port_1;
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
    _zz_1 = 1'b0;
    if(when_QLinearLinearCore_l160) begin
      if(MaxPoolPlugin_logic_outStream_fire_1) begin
        _zz_1 = 1'b1;
      end
    end
  end

  always @(*) begin
    _zz_2 = 1'b0;
    if(when_MaxPoolCore_l93_1) begin
      if(ReLUPlugin_logic_outStream_fire_1) begin
        _zz_2 = 1'b1;
      end
    end
  end

  always @(*) begin
    _zz_3 = 1'b0;
    if(when_MaxPoolCore_l93) begin
      if(ReLUPlugin_logic_outStream_fire) begin
        _zz_3 = 1'b1;
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
  assign conv1_reqProdReg1 = 64'h0;
  always @(*) begin
    conv1_inAddrComb = conv1_inAddrReg;
    if(when_QLinearConvCore_l412) begin
      if(when_QLinearConvCore_l416) begin
        conv1_inAddrComb = conv1_inAddrReg;
      end
    end
  end

  always @(*) begin
    conv1_wAddrComb = conv1_wAddrReg;
    if(when_QLinearConvCore_l412) begin
      if(when_QLinearConvCore_l416) begin
        conv1_wAddrComb = conv1_wAddrReg;
      end
    end
  end

  assign _zz_conv1_inValsR_0 = conv1_inAddrComb;
  assign conv1_inValsR_0 = conv1_inputBuf_0_spinal_port0;
  assign _zz_conv1_wValsR_0 = conv1_wAddrComb;
  assign conv1_wValsR_0 = conv1_weightRom_0_spinal_port0;
  assign _zz_conv1_biasVal = conv1_outChReg;
  assign conv1_biasVal = conv1_biasRom_spinal_port0;
  assign _zz_7 = (conv1_stateReg == conv1_sInit);
  assign io_activationIn_fire = (activation_in_valid && activation_in_ready);
  always @(*) begin
    activation_in_ready = 1'b0;
    if(when_QLinearConvCore_l347) begin
      activation_in_ready = 1'b1;
    end
  end

  always @(*) begin
    conv1_activationOut_valid = 1'b0;
    if(when_QLinearConvCore_l519) begin
      conv1_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    conv1_activationOut_payload_value = conv1_resultReg;
    if(when_QLinearConvCore_l519) begin
      conv1_activationOut_payload_value = conv1_resultReg;
    end
  end

  assign when_QLinearConvCore_l331 = (conv1_stateReg == conv1_sInit);
  assign when_QLinearConvCore_l333 = (conv1_initAddrReg == 11'h3ff);
  assign when_QLinearConvCore_l347 = (conv1_stateReg == conv1_sReceive);
  assign _zz_conv1_padWriteAddrReg = (conv1_rowElemReg == 5'h1b);
  assign when_QLinearConvCore_l357 = (conv1_recvCntReg == 10'h30f);
  assign when_QLinearConvCore_l390 = (conv1_stateReg == conv1_sLoadBias);
  assign when_QLinearConvCore_l404 = (conv1_stateReg == conv1_sWaitBias);
  assign when_QLinearConvCore_l412 = (conv1_stateReg == conv1_sCompute);
  assign when_QLinearConvCore_l416 = (conv1_compCycleReg < 5'h19);
  assign _zz_conv1_inAddrReg = (conv1_rowStepReg == 3'b100);
  assign when_QLinearConvCore_l429 = ((5'h01 <= conv1_compCycleReg) && (conv1_compCycleReg <= 5'h19));
  assign when_QLinearConvCore_l437 = ((5'h02 <= conv1_compCycleReg) && (conv1_compCycleReg <= 5'h1a));
  assign when_QLinearConvCore_l448 = ((5'h03 <= conv1_compCycleReg) && (conv1_compCycleReg <= 5'h1b));
  assign _zz_conv1_accumReg = ($signed(conv1_accumReg) + $signed(conv1_prodReg));
  assign when_QLinearConvCore_l452 = (conv1_compCycleReg == 5'h1b);
  assign when_QLinearConvCore_l461 = (conv1_stateReg == conv1_sRequant);
  assign when_QLinearConvCore_l468 = (conv1_stateReg == conv1_sRequantMul);
  assign _zz_conv1_pLL_Reg = 32'h41ba2b80;
  assign _zz_conv1_pHL_Reg = conv1_absAReg[31 : 16];
  assign _zz_conv1_pLL_Reg_1 = conv1_absAReg[15 : 0];
  assign _zz_conv1_pLH_Reg = _zz_conv1_pLL_Reg[31 : 16];
  assign _zz_conv1_pLL_Reg_2 = _zz_conv1_pLL_Reg[15 : 0];
  assign when_QLinearConvCore_l485 = (conv1_stateReg == conv1_sRequantWait);
  assign when_QLinearConvCore_l493 = (conv1_stateReg == conv1_sRequantWait2);
  assign when_QLinearConvCore_l500 = (conv1_stateReg == conv1_sRequantWait3);
  assign _zz_conv1_reqProdReg2 = (conv1_part1Reg + conv1_part2Reg);
  assign when_QLinearConvCore_l508 = (conv1_stateReg == conv1_sRequantShift);
  assign _zz_conv1_resultReg = ($signed(_zz__zz_conv1_resultReg) + $signed(32'h0));
  assign when_QLinearConvCore_l519 = (conv1_stateReg == conv1_sEmit);
  assign conv1_activationOut_fire = (conv1_activationOut_valid && conv1_activationOut_ready);
  assign when_QLinearConvCore_l529 = (conv1_outChReg == 4'b0111);
  assign when_QLinearConvCore_l531 = (conv1_outColReg == 5'h1b);
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
  always @(*) begin
    pool1_readAddr = 13'h0;
    if(pool1_computeReg) begin
      if(when_MaxPoolCore_l129) begin
        pool1_readAddr = (_zz_pool1_readAddr + _zz_pool1_readAddr_12);
      end
    end
  end

  assign pool1_readData = pool1_inputBuf_spinal_port0;
  always @(*) begin
    ReLUPlugin_logic_outStream_ready = 1'b0;
    if(when_MaxPoolCore_l93) begin
      ReLUPlugin_logic_outStream_ready = 1'b1;
    end
  end

  always @(*) begin
    pool1_activationOut_valid = 1'b0;
    if(pool1_computeReg) begin
      if(!when_MaxPoolCore_l144) begin
        pool1_activationOut_valid = 1'b1;
      end
    end
  end

  assign pool1_activationOut_payload_value = pool1_maxReg;
  assign when_MaxPoolCore_l93 = (! pool1_computeReg);
  assign ReLUPlugin_logic_outStream_fire = (ReLUPlugin_logic_outStream_valid && ReLUPlugin_logic_outStream_ready);
  assign when_MaxPoolCore_l101 = (pool1_recvCntReg == 13'h187f);
  assign when_MaxPoolCore_l129 = (pool1_phaseReg < 3'b100);
  assign when_MaxPoolCore_l133 = (pool1_kcReg == 2'b01);
  assign when_MaxPoolCore_l137 = (pool1_phaseReg == 3'b010);
  assign when_MaxPoolCore_l139 = ((3'b010 < pool1_phaseReg) && (pool1_phaseReg <= 3'b101));
  assign when_MaxPoolCore_l144 = (pool1_phaseReg < 3'b110);
  assign pool1_activationOut_fire = (pool1_activationOut_valid && pool1_activationOut_ready);
  assign when_MaxPoolCore_l155 = (pool1_outChReg == 4'b0111);
  assign when_MaxPoolCore_l158 = (pool1_outColReg == 4'b1101);
  assign when_MaxPoolCore_l161 = (pool1_outRowReg == 4'b1101);
  assign MaxPoolPlugin_logic_outStream_valid = pool1_activationOut_valid;
  assign pool1_activationOut_ready = MaxPoolPlugin_logic_outStream_ready;
  assign MaxPoolPlugin_logic_outStream_payload_value = pool1_activationOut_payload_value;
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
  assign conv2_reqProdReg1 = 64'h0;
  always @(*) begin
    conv2_inAddrComb = conv2_inAddrReg;
    if(when_QLinearConvCore_l412_1) begin
      if(when_QLinearConvCore_l416_1) begin
        conv2_inAddrComb = conv2_inAddrReg;
      end
    end
  end

  always @(*) begin
    conv2_wAddrComb = conv2_wAddrReg;
    if(when_QLinearConvCore_l412_1) begin
      if(when_QLinearConvCore_l416_1) begin
        conv2_wAddrComb = conv2_wAddrReg;
      end
    end
  end

  assign _zz_conv2_inValsR_0 = conv2_inAddrComb;
  assign conv2_inValsR_0 = conv2_inputBuf_0_spinal_port0;
  assign _zz_conv2_wValsR_0 = conv2_wAddrComb;
  assign conv2_wValsR_0 = conv2_weightRom_0_spinal_port0;
  assign _zz_conv2_biasVal = conv2_outChReg;
  assign conv2_biasVal = conv2_biasRom_spinal_port0;
  assign _zz_14 = (conv2_stateReg == conv2_sInit);
  assign MaxPoolPlugin_logic_outStream_fire = (MaxPoolPlugin_logic_outStream_valid && MaxPoolPlugin_logic_outStream_ready);
  always @(*) begin
    MaxPoolPlugin_logic_outStream_ready = 1'b0;
    if(when_QLinearConvCore_l347_1) begin
      MaxPoolPlugin_logic_outStream_ready = 1'b1;
    end
  end

  always @(*) begin
    conv2_activationOut_valid = 1'b0;
    if(when_QLinearConvCore_l519_1) begin
      conv2_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    conv2_activationOut_payload_value = conv2_resultReg;
    if(when_QLinearConvCore_l519_1) begin
      conv2_activationOut_payload_value = conv2_resultReg;
    end
  end

  assign when_QLinearConvCore_l331_1 = (conv2_stateReg == conv2_sInit);
  assign when_QLinearConvCore_l333_1 = (conv2_initAddrReg == 12'ha1f);
  assign when_QLinearConvCore_l347_1 = (conv2_stateReg == conv2_sReceive);
  assign _zz_conv2_padWriteAddrReg = (conv2_rowElemReg == 7'h6f);
  assign when_QLinearConvCore_l357_1 = (conv2_recvCntReg == 11'h61f);
  assign when_QLinearConvCore_l390_1 = (conv2_stateReg == conv2_sLoadBias);
  assign when_QLinearConvCore_l404_1 = (conv2_stateReg == conv2_sWaitBias);
  assign when_QLinearConvCore_l412_1 = (conv2_stateReg == conv2_sCompute);
  assign when_QLinearConvCore_l416_1 = (conv2_compCycleReg < 8'hc8);
  assign _zz_conv2_inAddrReg = (conv2_rowStepReg == 6'h27);
  assign when_QLinearConvCore_l429_1 = ((8'h01 <= conv2_compCycleReg) && (conv2_compCycleReg <= 8'hc8));
  assign when_QLinearConvCore_l437_1 = ((8'h02 <= conv2_compCycleReg) && (conv2_compCycleReg <= 8'hc9));
  assign when_QLinearConvCore_l448_1 = ((8'h03 <= conv2_compCycleReg) && (conv2_compCycleReg <= 8'hca));
  assign _zz_conv2_accumReg = ($signed(conv2_accumReg) + $signed(conv2_prodReg));
  assign when_QLinearConvCore_l452_1 = (conv2_compCycleReg == 8'hca);
  assign when_QLinearConvCore_l461_1 = (conv2_stateReg == conv2_sRequant);
  assign when_QLinearConvCore_l468_1 = (conv2_stateReg == conv2_sRequantMul);
  assign _zz_conv2_pLL_Reg = 32'h48da7d80;
  assign _zz_conv2_pHL_Reg = conv2_absAReg[31 : 16];
  assign _zz_conv2_pLL_Reg_1 = conv2_absAReg[15 : 0];
  assign _zz_conv2_pLH_Reg = _zz_conv2_pLL_Reg[31 : 16];
  assign _zz_conv2_pLL_Reg_2 = _zz_conv2_pLL_Reg[15 : 0];
  assign when_QLinearConvCore_l485_1 = (conv2_stateReg == conv2_sRequantWait);
  assign when_QLinearConvCore_l493_1 = (conv2_stateReg == conv2_sRequantWait2);
  assign when_QLinearConvCore_l500_1 = (conv2_stateReg == conv2_sRequantWait3);
  assign _zz_conv2_reqProdReg2 = (conv2_part1Reg + conv2_part2Reg);
  assign when_QLinearConvCore_l508_1 = (conv2_stateReg == conv2_sRequantShift);
  assign _zz_conv2_resultReg = ($signed(_zz__zz_conv2_resultReg) + $signed(32'h0));
  assign when_QLinearConvCore_l519_1 = (conv2_stateReg == conv2_sEmit);
  assign conv2_activationOut_fire = (conv2_activationOut_valid && conv2_activationOut_ready);
  assign when_QLinearConvCore_l529_1 = (conv2_outChReg == 5'h0f);
  assign when_QLinearConvCore_l531_1 = (conv2_outColReg == 4'b1101);
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
  always @(*) begin
    pool2_readAddr = 12'h0;
    if(pool2_computeReg) begin
      if(when_MaxPoolCore_l129_1) begin
        pool2_readAddr = (_zz_pool2_readAddr + _zz_pool2_readAddr_12);
      end
    end
  end

  assign pool2_readData = pool2_inputBuf_spinal_port0;
  always @(*) begin
    ReLUPlugin_logic_outStream_ready_1 = 1'b0;
    if(when_MaxPoolCore_l93_1) begin
      ReLUPlugin_logic_outStream_ready_1 = 1'b1;
    end
  end

  always @(*) begin
    pool2_activationOut_valid = 1'b0;
    if(pool2_computeReg) begin
      if(!when_MaxPoolCore_l144_1) begin
        pool2_activationOut_valid = 1'b1;
      end
    end
  end

  assign pool2_activationOut_payload_value = pool2_maxReg;
  assign when_MaxPoolCore_l93_1 = (! pool2_computeReg);
  assign ReLUPlugin_logic_outStream_fire_1 = (ReLUPlugin_logic_outStream_valid_1 && ReLUPlugin_logic_outStream_ready_1);
  assign when_MaxPoolCore_l101_1 = (pool2_recvCntReg == 12'hc3f);
  assign when_MaxPoolCore_l129_1 = (pool2_phaseReg < 4'b1001);
  assign when_MaxPoolCore_l133_1 = (pool2_kcReg == 2'b10);
  assign when_MaxPoolCore_l137_1 = (pool2_phaseReg == 4'b0010);
  assign when_MaxPoolCore_l139_1 = ((4'b0010 < pool2_phaseReg) && (pool2_phaseReg <= 4'b1010));
  assign when_MaxPoolCore_l144_1 = (pool2_phaseReg < 4'b1011);
  assign pool2_activationOut_fire = (pool2_activationOut_valid && pool2_activationOut_ready);
  assign when_MaxPoolCore_l155_1 = (pool2_outChReg == 5'h0f);
  assign when_MaxPoolCore_l158_1 = (pool2_outColReg == 3'b011);
  assign when_MaxPoolCore_l161_1 = (pool2_outRowReg == 3'b011);
  assign MaxPoolPlugin_logic_outStream_valid_1 = pool2_activationOut_valid;
  assign pool2_activationOut_ready = MaxPoolPlugin_logic_outStream_ready_1;
  assign MaxPoolPlugin_logic_outStream_payload_value_1 = pool2_activationOut_payload_value;
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
    if(when_QLinearLinearCore_l201) begin
      if(when_QLinearLinearCore_l205) begin
        linear1_inAddrComb = linear1_compCycleReg[7:0];
      end
    end
  end

  always @(*) begin
    linear1_wAddrComb = 12'h0;
    if(when_QLinearLinearCore_l201) begin
      if(when_QLinearLinearCore_l205) begin
        linear1_wAddrComb = _zz_linear1_wAddrComb[11:0];
      end
    end
  end

  assign linear1_inValR = linear1_inputBuf_spinal_port0;
  assign linear1_wValR = linear1_weightRom_spinal_port0;
  assign _zz_linear1_biasVal = linear1_outNeurReg;
  assign linear1_biasVal = linear1_biasRom_spinal_port0;
  always @(*) begin
    MaxPoolPlugin_logic_outStream_ready_1 = 1'b0;
    if(when_QLinearLinearCore_l160) begin
      MaxPoolPlugin_logic_outStream_ready_1 = 1'b1;
    end
  end

  always @(*) begin
    linear1_activationOut_valid = 1'b0;
    if(when_QLinearLinearCore_l295) begin
      linear1_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    linear1_activationOut_payload_value = linear1_resultReg;
    if(when_QLinearLinearCore_l295) begin
      linear1_activationOut_payload_value = linear1_resultReg;
    end
  end

  assign when_QLinearLinearCore_l160 = (linear1_stateReg == linear1_sReceive);
  assign MaxPoolPlugin_logic_outStream_fire_1 = (MaxPoolPlugin_logic_outStream_valid_1 && MaxPoolPlugin_logic_outStream_ready_1);
  assign when_QLinearLinearCore_l165 = (linear1_recvCntReg == 9'h0ff);
  assign when_QLinearLinearCore_l189 = (linear1_stateReg == linear1_sLoadBias);
  assign when_QLinearLinearCore_l195 = (linear1_stateReg == linear1_sWaitBias);
  assign when_QLinearLinearCore_l201 = (linear1_stateReg == linear1_sCompute);
  assign when_QLinearLinearCore_l205 = (linear1_compCycleReg < 9'h100);
  assign when_QLinearLinearCore_l212 = ((9'h001 <= linear1_compCycleReg) && (linear1_compCycleReg <= 9'h100));
  assign when_QLinearLinearCore_l218 = ((9'h002 <= linear1_compCycleReg) && (linear1_compCycleReg <= 9'h101));
  assign when_QLinearLinearCore_l225 = ((9'h003 <= linear1_compCycleReg) && (linear1_compCycleReg <= 9'h102));
  assign _zz_linear1_accumReg = ($signed(linear1_accumReg) + $signed(linear1_prodReg));
  assign when_QLinearLinearCore_l229 = (linear1_compCycleReg == 9'h102);
  assign when_QLinearLinearCore_l238 = (linear1_stateReg == linear1_sRequant);
  assign when_QLinearLinearCore_l245 = (linear1_stateReg == linear1_sRequantMul);
  assign _zz_linear1_pLL_Reg = 32'h4c829700;
  assign _zz_linear1_pHL_Reg = linear1_absAReg[31 : 16];
  assign _zz_linear1_pLL_Reg_1 = linear1_absAReg[15 : 0];
  assign _zz_linear1_pLH_Reg = _zz_linear1_pLL_Reg[31 : 16];
  assign _zz_linear1_pLL_Reg_2 = _zz_linear1_pLL_Reg[15 : 0];
  assign when_QLinearLinearCore_l261 = (linear1_stateReg == linear1_sRequantWait);
  assign when_QLinearLinearCore_l269 = (linear1_stateReg == linear1_sRequantWait2);
  assign when_QLinearLinearCore_l276 = (linear1_stateReg == linear1_sRequantWait3);
  assign _zz_linear1_reqProdReg2 = (linear1_part1Reg + linear1_part2Reg);
  assign when_QLinearLinearCore_l284 = (linear1_stateReg == linear1_sRequantShift);
  assign _zz_linear1_resultReg = ($signed(_zz__zz_linear1_resultReg) + $signed(32'h0));
  assign when_QLinearLinearCore_l295 = (linear1_stateReg == linear1_sEmit);
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
      conv1_accumReg <= 32'h0;
      conv1_prodReg <= 32'h0;
      conv1_resultReg <= 8'h0;
      conv1_reqProdReg2 <= 64'h0;
      conv1_accumRequantReg <= 32'h0;
      conv1_signAReg <= 1'b0;
      conv1_absAReg <= 32'h0;
      conv1_pLL_Reg <= 32'h0;
      conv1_pLH_Reg <= 32'h0;
      conv1_pHL_Reg <= 32'h0;
      conv1_pHH_Reg <= 32'h0;
      conv1_pSumReg <= 33'h0;
      conv1_pLL_Reg2 <= 32'h0;
      conv1_pHH_Reg2 <= 32'h0;
      conv1_part1Reg <= 64'h0;
      conv1_part2Reg <= 64'h0;
      conv1_initAddrReg <= 11'h0;
      conv1_inAddrReg <= 11'h0;
      conv1_wAddrReg <= 8'h0;
      conv1_compCycleReg <= 5'h0;
      conv1_rowStepReg <= 3'b000;
      conv1_inValsReg_0 <= 8'h0;
      conv1_wValsReg_0 <= 8'h0;
      pool1_computeReg <= 1'b0;
      pool1_recvCntReg <= 13'h0;
      pool1_outRowReg <= 4'b0000;
      pool1_outColReg <= 4'b0000;
      pool1_outChReg <= 4'b0000;
      pool1_phaseReg <= 3'b000;
      pool1_krReg <= 2'b00;
      pool1_kcReg <= 2'b00;
      pool1_maxReg <= 8'h0;
      pool1_readDataReg <= 8'h0;
      conv2_stateReg <= 4'b1010;
      conv2_recvCntReg <= 11'h0;
      conv2_padWriteAddrReg <= 12'h130;
      conv2_rowElemReg <= 7'h0;
      conv2_outRowReg <= 4'b0000;
      conv2_outColReg <= 4'b0000;
      conv2_outChReg <= 5'h0;
      conv2_accumReg <= 32'h0;
      conv2_prodReg <= 32'h0;
      conv2_resultReg <= 8'h0;
      conv2_reqProdReg2 <= 64'h0;
      conv2_accumRequantReg <= 32'h0;
      conv2_signAReg <= 1'b0;
      conv2_absAReg <= 32'h0;
      conv2_pLL_Reg <= 32'h0;
      conv2_pLH_Reg <= 32'h0;
      conv2_pHL_Reg <= 32'h0;
      conv2_pHH_Reg <= 32'h0;
      conv2_pSumReg <= 33'h0;
      conv2_pLL_Reg2 <= 32'h0;
      conv2_pHH_Reg2 <= 32'h0;
      conv2_part1Reg <= 64'h0;
      conv2_part2Reg <= 64'h0;
      conv2_initAddrReg <= 12'h0;
      conv2_inAddrReg <= 12'h0;
      conv2_wAddrReg <= 12'h0;
      conv2_compCycleReg <= 8'h0;
      conv2_rowStepReg <= 6'h0;
      conv2_inValsReg_0 <= 8'h0;
      conv2_wValsReg_0 <= 8'h0;
      pool2_computeReg <= 1'b0;
      pool2_recvCntReg <= 12'h0;
      pool2_outRowReg <= 3'b000;
      pool2_outColReg <= 3'b000;
      pool2_outChReg <= 5'h0;
      pool2_phaseReg <= 4'b0000;
      pool2_krReg <= 2'b00;
      pool2_kcReg <= 2'b00;
      pool2_maxReg <= 8'h0;
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
      if(when_QLinearConvCore_l331) begin
        if(when_QLinearConvCore_l333) begin
          conv1_initAddrReg <= 11'h0;
          conv1_stateReg <= conv1_sReceive;
        end else begin
          conv1_initAddrReg <= (conv1_initAddrReg + 11'h001);
        end
      end
      if(when_QLinearConvCore_l347) begin
        if(io_activationIn_fire) begin
          conv1_rowElemReg <= (_zz_conv1_padWriteAddrReg ? 5'h0 : _zz_conv1_rowElemReg);
          conv1_padWriteAddrReg <= (conv1_padWriteAddrReg + (_zz_conv1_padWriteAddrReg ? 11'h005 : 11'h001));
          conv1_recvCntReg <= (conv1_recvCntReg + 10'h001);
          if(when_QLinearConvCore_l357) begin
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
      if(when_QLinearConvCore_l390) begin
        conv1_inAddrReg <= _zz_conv1_inAddrReg_1[10:0];
        conv1_wAddrReg <= _zz_conv1_wAddrReg[7:0];
        conv1_compCycleReg <= 5'h0;
        conv1_rowStepReg <= 3'b000;
        conv1_stateReg <= conv1_sWaitBias;
      end
      if(when_QLinearConvCore_l404) begin
        conv1_accumReg <= conv1_biasVal;
        conv1_stateReg <= conv1_sCompute;
      end
      if(when_QLinearConvCore_l412) begin
        conv1_compCycleReg <= (conv1_compCycleReg + 5'h01);
        if(when_QLinearConvCore_l416) begin
          conv1_wAddrReg <= (conv1_wAddrReg + 8'h01);
          conv1_inAddrReg <= (conv1_inAddrReg + (_zz_conv1_inAddrReg ? 11'h01c : 11'h001));
          conv1_rowStepReg <= (_zz_conv1_inAddrReg ? 3'b000 : _zz_conv1_rowStepReg);
        end
        if(when_QLinearConvCore_l429) begin
          conv1_inValsReg_0 <= conv1_inValsR_0;
          conv1_wValsReg_0 <= conv1_wValsR_0;
        end
        if(when_QLinearConvCore_l437) begin
          conv1_prodReg <= {{14{_zz_conv1_prodReg[17]}}, _zz_conv1_prodReg};
        end
        if(when_QLinearConvCore_l448) begin
          conv1_accumReg <= _zz_conv1_accumReg;
          if(when_QLinearConvCore_l452) begin
            conv1_accumRequantReg <= _zz_conv1_accumReg;
            conv1_stateReg <= conv1_sRequant;
            conv1_compCycleReg <= 5'h0;
          end
        end
      end
      if(when_QLinearConvCore_l461) begin
        conv1_absAReg <= _zz_conv1_absAReg;
        conv1_signAReg <= ($signed(conv1_accumRequantReg) < $signed(32'h0));
        conv1_stateReg <= conv1_sRequantMul;
      end
      if(when_QLinearConvCore_l468) begin
        conv1_pLL_Reg <= (_zz_conv1_pLL_Reg_1 * _zz_conv1_pLL_Reg_2);
        conv1_pLH_Reg <= (_zz_conv1_pLL_Reg_1 * _zz_conv1_pLH_Reg);
        conv1_pHL_Reg <= (_zz_conv1_pHL_Reg * _zz_conv1_pLL_Reg_2);
        conv1_pHH_Reg <= (_zz_conv1_pHL_Reg * _zz_conv1_pLH_Reg);
        conv1_stateReg <= conv1_sRequantWait;
      end
      if(when_QLinearConvCore_l485) begin
        conv1_pSumReg <= (_zz_conv1_pSumReg + _zz_conv1_pSumReg_1);
        conv1_pLL_Reg2 <= conv1_pLL_Reg;
        conv1_pHH_Reg2 <= conv1_pHH_Reg;
        conv1_stateReg <= conv1_sRequantWait2;
      end
      if(when_QLinearConvCore_l493) begin
        conv1_part1Reg <= (_zz_conv1_part1Reg + _zz_conv1_part1Reg_1);
        conv1_part2Reg <= _zz_conv1_part2Reg[63:0];
        conv1_stateReg <= conv1_sRequantWait3;
      end
      if(when_QLinearConvCore_l500) begin
        conv1_reqProdReg2 <= (conv1_signAReg ? _zz_conv1_reqProdReg2_1 : _zz_conv1_reqProdReg2_3);
        conv1_stateReg <= conv1_sRequantShift;
      end
      if(when_QLinearConvCore_l508) begin
        conv1_resultReg <= (($signed(32'h0000007f) < $signed(_zz_conv1_resultReg)) ? 8'h7f : _zz_conv1_resultReg_1);
        conv1_stateReg <= conv1_sEmit;
      end
      if(when_QLinearConvCore_l519) begin
        if(conv1_activationOut_fire) begin
          conv1_outChReg <= (when_QLinearConvCore_l529 ? 4'b0000 : _zz_conv1_outChReg);
          if(when_QLinearConvCore_l529) begin
            conv1_outColReg <= (when_QLinearConvCore_l531 ? 5'h0 : _zz_conv1_outColReg);
            if(when_QLinearConvCore_l531) begin
              conv1_outRowReg <= (_zz_conv1_stateReg ? 5'h0 : _zz_conv1_outRowReg);
            end
          end
          conv1_stateReg <= (((when_QLinearConvCore_l529 && when_QLinearConvCore_l531) && _zz_conv1_stateReg) ? conv1_sReceive : conv1_sLoadBias);
        end
      end
      if(when_MaxPoolCore_l93) begin
        pool1_phaseReg <= 3'b000;
        pool1_krReg <= 2'b00;
        pool1_kcReg <= 2'b00;
        if(ReLUPlugin_logic_outStream_fire) begin
          pool1_recvCntReg <= (pool1_recvCntReg + 13'h0001);
          if(when_MaxPoolCore_l101) begin
            pool1_recvCntReg <= 13'h0;
            pool1_outRowReg <= 4'b0000;
            pool1_outColReg <= 4'b0000;
            pool1_outChReg <= 4'b0000;
            pool1_computeReg <= 1'b1;
          end
        end
      end
      if(pool1_computeReg) begin
        pool1_readDataReg <= pool1_readData;
        if(when_MaxPoolCore_l129) begin
          pool1_kcReg <= (when_MaxPoolCore_l133 ? 2'b00 : _zz_pool1_kcReg);
          if(when_MaxPoolCore_l133) begin
            pool1_krReg <= (pool1_krReg + 2'b01);
          end
        end
        if(when_MaxPoolCore_l137) begin
          pool1_maxReg <= pool1_readDataReg;
        end else begin
          if(when_MaxPoolCore_l139) begin
            pool1_maxReg <= (($signed(pool1_maxReg) < $signed(pool1_readDataReg)) ? pool1_readDataReg : pool1_maxReg);
          end
        end
        if(when_MaxPoolCore_l144) begin
          pool1_phaseReg <= (pool1_phaseReg + 3'b001);
        end else begin
          if(pool1_activationOut_fire) begin
            pool1_outChReg <= (when_MaxPoolCore_l155 ? 4'b0000 : _zz_pool1_outChReg);
            if(when_MaxPoolCore_l155) begin
              pool1_outColReg <= (when_MaxPoolCore_l158 ? 4'b0000 : _zz_pool1_outColReg);
              if(when_MaxPoolCore_l158) begin
                pool1_outRowReg <= (when_MaxPoolCore_l161 ? 4'b0000 : _zz_pool1_outRowReg);
                if(when_MaxPoolCore_l161) begin
                  pool1_computeReg <= 1'b0;
                end
              end
            end
            pool1_phaseReg <= 3'b000;
            pool1_krReg <= 2'b00;
            pool1_kcReg <= 2'b00;
          end
        end
      end
      if(when_QLinearConvCore_l331_1) begin
        if(when_QLinearConvCore_l333_1) begin
          conv2_initAddrReg <= 12'h0;
          conv2_stateReg <= conv2_sReceive;
        end else begin
          conv2_initAddrReg <= (conv2_initAddrReg + 12'h001);
        end
      end
      if(when_QLinearConvCore_l347_1) begin
        if(MaxPoolPlugin_logic_outStream_fire) begin
          conv2_rowElemReg <= (_zz_conv2_padWriteAddrReg ? 7'h0 : _zz_conv2_rowElemReg);
          conv2_padWriteAddrReg <= (conv2_padWriteAddrReg + (_zz_conv2_padWriteAddrReg ? 12'h021 : 12'h001));
          conv2_recvCntReg <= (conv2_recvCntReg + 11'h001);
          if(when_QLinearConvCore_l357_1) begin
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
      if(when_QLinearConvCore_l390_1) begin
        conv2_inAddrReg <= _zz_conv2_inAddrReg_1[11:0];
        conv2_wAddrReg <= _zz_conv2_wAddrReg[11:0];
        conv2_compCycleReg <= 8'h0;
        conv2_rowStepReg <= 6'h0;
        conv2_stateReg <= conv2_sWaitBias;
      end
      if(when_QLinearConvCore_l404_1) begin
        conv2_accumReg <= conv2_biasVal;
        conv2_stateReg <= conv2_sCompute;
      end
      if(when_QLinearConvCore_l412_1) begin
        conv2_compCycleReg <= (conv2_compCycleReg + 8'h01);
        if(when_QLinearConvCore_l416_1) begin
          conv2_wAddrReg <= (conv2_wAddrReg + 12'h001);
          conv2_inAddrReg <= (conv2_inAddrReg + (_zz_conv2_inAddrReg ? 12'h069 : 12'h001));
          conv2_rowStepReg <= (_zz_conv2_inAddrReg ? 6'h0 : _zz_conv2_rowStepReg);
        end
        if(when_QLinearConvCore_l429_1) begin
          conv2_inValsReg_0 <= conv2_inValsR_0;
          conv2_wValsReg_0 <= conv2_wValsR_0;
        end
        if(when_QLinearConvCore_l437_1) begin
          conv2_prodReg <= {{14{_zz_conv2_prodReg[17]}}, _zz_conv2_prodReg};
        end
        if(when_QLinearConvCore_l448_1) begin
          conv2_accumReg <= _zz_conv2_accumReg;
          if(when_QLinearConvCore_l452_1) begin
            conv2_accumRequantReg <= _zz_conv2_accumReg;
            conv2_stateReg <= conv2_sRequant;
            conv2_compCycleReg <= 8'h0;
          end
        end
      end
      if(when_QLinearConvCore_l461_1) begin
        conv2_absAReg <= _zz_conv2_absAReg;
        conv2_signAReg <= ($signed(conv2_accumRequantReg) < $signed(32'h0));
        conv2_stateReg <= conv2_sRequantMul;
      end
      if(when_QLinearConvCore_l468_1) begin
        conv2_pLL_Reg <= (_zz_conv2_pLL_Reg_1 * _zz_conv2_pLL_Reg_2);
        conv2_pLH_Reg <= (_zz_conv2_pLL_Reg_1 * _zz_conv2_pLH_Reg);
        conv2_pHL_Reg <= (_zz_conv2_pHL_Reg * _zz_conv2_pLL_Reg_2);
        conv2_pHH_Reg <= (_zz_conv2_pHL_Reg * _zz_conv2_pLH_Reg);
        conv2_stateReg <= conv2_sRequantWait;
      end
      if(when_QLinearConvCore_l485_1) begin
        conv2_pSumReg <= (_zz_conv2_pSumReg + _zz_conv2_pSumReg_1);
        conv2_pLL_Reg2 <= conv2_pLL_Reg;
        conv2_pHH_Reg2 <= conv2_pHH_Reg;
        conv2_stateReg <= conv2_sRequantWait2;
      end
      if(when_QLinearConvCore_l493_1) begin
        conv2_part1Reg <= (_zz_conv2_part1Reg + _zz_conv2_part1Reg_1);
        conv2_part2Reg <= _zz_conv2_part2Reg[63:0];
        conv2_stateReg <= conv2_sRequantWait3;
      end
      if(when_QLinearConvCore_l500_1) begin
        conv2_reqProdReg2 <= (conv2_signAReg ? _zz_conv2_reqProdReg2_1 : _zz_conv2_reqProdReg2_3);
        conv2_stateReg <= conv2_sRequantShift;
      end
      if(when_QLinearConvCore_l508_1) begin
        conv2_resultReg <= (($signed(32'h0000007f) < $signed(_zz_conv2_resultReg)) ? 8'h7f : _zz_conv2_resultReg_1);
        conv2_stateReg <= conv2_sEmit;
      end
      if(when_QLinearConvCore_l519_1) begin
        if(conv2_activationOut_fire) begin
          conv2_outChReg <= (when_QLinearConvCore_l529_1 ? 5'h0 : _zz_conv2_outChReg);
          if(when_QLinearConvCore_l529_1) begin
            conv2_outColReg <= (when_QLinearConvCore_l531_1 ? 4'b0000 : _zz_conv2_outColReg);
            if(when_QLinearConvCore_l531_1) begin
              conv2_outRowReg <= (_zz_conv2_stateReg ? 4'b0000 : _zz_conv2_outRowReg);
            end
          end
          conv2_stateReg <= (((when_QLinearConvCore_l529_1 && when_QLinearConvCore_l531_1) && _zz_conv2_stateReg) ? conv2_sReceive : conv2_sLoadBias);
        end
      end
      if(when_MaxPoolCore_l93_1) begin
        pool2_phaseReg <= 4'b0000;
        pool2_krReg <= 2'b00;
        pool2_kcReg <= 2'b00;
        if(ReLUPlugin_logic_outStream_fire_1) begin
          pool2_recvCntReg <= (pool2_recvCntReg + 12'h001);
          if(when_MaxPoolCore_l101_1) begin
            pool2_recvCntReg <= 12'h0;
            pool2_outRowReg <= 3'b000;
            pool2_outColReg <= 3'b000;
            pool2_outChReg <= 5'h0;
            pool2_computeReg <= 1'b1;
          end
        end
      end
      if(pool2_computeReg) begin
        pool2_readDataReg <= pool2_readData;
        if(when_MaxPoolCore_l129_1) begin
          pool2_kcReg <= (when_MaxPoolCore_l133_1 ? 2'b00 : _zz_pool2_kcReg);
          if(when_MaxPoolCore_l133_1) begin
            pool2_krReg <= (pool2_krReg + 2'b01);
          end
        end
        if(when_MaxPoolCore_l137_1) begin
          pool2_maxReg <= pool2_readDataReg;
        end else begin
          if(when_MaxPoolCore_l139_1) begin
            pool2_maxReg <= (($signed(pool2_maxReg) < $signed(pool2_readDataReg)) ? pool2_readDataReg : pool2_maxReg);
          end
        end
        if(when_MaxPoolCore_l144_1) begin
          pool2_phaseReg <= (pool2_phaseReg + 4'b0001);
        end else begin
          if(pool2_activationOut_fire) begin
            pool2_outChReg <= (when_MaxPoolCore_l155_1 ? 5'h0 : _zz_pool2_outChReg);
            if(when_MaxPoolCore_l155_1) begin
              pool2_outColReg <= (when_MaxPoolCore_l158_1 ? 3'b000 : _zz_pool2_outColReg);
              if(when_MaxPoolCore_l158_1) begin
                pool2_outRowReg <= (when_MaxPoolCore_l161_1 ? 3'b000 : _zz_pool2_outRowReg);
                if(when_MaxPoolCore_l161_1) begin
                  pool2_computeReg <= 1'b0;
                end
              end
            end
            pool2_phaseReg <= 4'b0000;
            pool2_krReg <= 2'b00;
            pool2_kcReg <= 2'b00;
          end
        end
      end
      if(when_QLinearLinearCore_l160) begin
        if(MaxPoolPlugin_logic_outStream_fire_1) begin
          linear1_recvCntReg <= (linear1_recvCntReg + 9'h001);
          if(when_QLinearLinearCore_l165) begin
            linear1_recvCntReg <= 9'h0;
            linear1_outNeurReg <= 4'b0000;
            linear1_stateReg <= linear1_sLoadBias;
          end
        end
      end
      if(when_QLinearLinearCore_l189) begin
        linear1_compCycleReg <= 9'h0;
        linear1_stateReg <= linear1_sWaitBias;
      end
      if(when_QLinearLinearCore_l195) begin
        linear1_accumReg <= linear1_biasVal;
        linear1_stateReg <= linear1_sCompute;
      end
      if(when_QLinearLinearCore_l201) begin
        linear1_compCycleReg <= (linear1_compCycleReg + 9'h001);
        if(when_QLinearLinearCore_l212) begin
          linear1_inValReg <= linear1_inValR;
          linear1_wValReg <= linear1_wValR;
        end
        if(when_QLinearLinearCore_l218) begin
          linear1_prodReg <= {{14{_zz_linear1_prodReg[17]}}, _zz_linear1_prodReg};
        end
        if(when_QLinearLinearCore_l225) begin
          linear1_accumReg <= _zz_linear1_accumReg;
          if(when_QLinearLinearCore_l229) begin
            linear1_accumRequantReg <= _zz_linear1_accumReg;
            linear1_stateReg <= linear1_sRequant;
            linear1_compCycleReg <= 9'h0;
          end
        end
      end
      if(when_QLinearLinearCore_l238) begin
        linear1_absAReg <= _zz_linear1_absAReg;
        linear1_signAReg <= ($signed(linear1_accumRequantReg) < $signed(32'h0));
        linear1_stateReg <= linear1_sRequantMul;
      end
      if(when_QLinearLinearCore_l245) begin
        linear1_pLL_Reg <= (_zz_linear1_pLL_Reg_1 * _zz_linear1_pLL_Reg_2);
        linear1_pLH_Reg <= (_zz_linear1_pLL_Reg_1 * _zz_linear1_pLH_Reg);
        linear1_pHL_Reg <= (_zz_linear1_pHL_Reg * _zz_linear1_pLL_Reg_2);
        linear1_pHH_Reg <= (_zz_linear1_pHL_Reg * _zz_linear1_pLH_Reg);
        linear1_stateReg <= linear1_sRequantWait;
      end
      if(when_QLinearLinearCore_l261) begin
        linear1_pSumReg <= (_zz_linear1_pSumReg + _zz_linear1_pSumReg_1);
        linear1_pLL_Reg2 <= linear1_pLL_Reg;
        linear1_pHH_Reg2 <= linear1_pHH_Reg;
        linear1_stateReg <= linear1_sRequantWait2;
      end
      if(when_QLinearLinearCore_l269) begin
        linear1_part1Reg <= (_zz_linear1_part1Reg + _zz_linear1_part1Reg_1);
        linear1_part2Reg <= _zz_linear1_part2Reg[63:0];
        linear1_stateReg <= linear1_sRequantWait3;
      end
      if(when_QLinearLinearCore_l276) begin
        linear1_reqProdReg2 <= (linear1_signAReg ? _zz_linear1_reqProdReg2_1 : _zz_linear1_reqProdReg2_3);
        linear1_stateReg <= linear1_sRequantShift;
      end
      if(when_QLinearLinearCore_l284) begin
        linear1_resultReg <= (($signed(32'h0000007f) < $signed(_zz_linear1_resultReg)) ? 8'h7f : _zz_linear1_resultReg_1);
        linear1_stateReg <= linear1_sEmit;
      end
      if(when_QLinearLinearCore_l295) begin
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
