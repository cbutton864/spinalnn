// Generator : SpinalHDL v1.14.0    git head : 95a5e6c65c54acfc4707c8fe6ef8b5d297cfcbde
// Component : ConvEngineBench
// Git hash  : 9ed26a27b6ab793f0a36c184aed3717e4c52dbf3

`timescale 1ns/1ps

module ConvEngineBench (
  input  wire          io_inValid,
  input  wire [7:0]    io_inValue,
  output wire          io_inReady,
  output wire          io_outValid,
  output wire [7:0]    io_outValue,
  input  wire          io_outReady,
  input  wire          clk,
  input  wire          reset
);

  reg        [7:0]    bench_N8_inputBuf_0_spinal_port0;
  reg        [7:0]    bench_N8_inputBuf_1_spinal_port0;
  reg        [7:0]    bench_N8_inputBuf_2_spinal_port0;
  reg        [7:0]    bench_N8_inputBuf_3_spinal_port0;
  reg        [7:0]    bench_N8_inputBuf_4_spinal_port0;
  reg        [7:0]    bench_N8_inputBuf_5_spinal_port0;
  reg        [7:0]    bench_N8_inputBuf_6_spinal_port0;
  reg        [7:0]    bench_N8_inputBuf_7_spinal_port0;
  reg        [7:0]    bench_N8_weightRom_0_spinal_port0;
  reg        [7:0]    bench_N8_weightRom_1_spinal_port0;
  reg        [7:0]    bench_N8_weightRom_2_spinal_port0;
  reg        [7:0]    bench_N8_weightRom_3_spinal_port0;
  reg        [7:0]    bench_N8_weightRom_4_spinal_port0;
  reg        [7:0]    bench_N8_weightRom_5_spinal_port0;
  reg        [7:0]    bench_N8_weightRom_6_spinal_port0;
  reg        [7:0]    bench_N8_weightRom_7_spinal_port0;
  reg        [31:0]   bench_N8_biasRom_spinal_port0;
  reg        [31:0]   bench_N8_reqMultRom_spinal_port0;
  reg        [7:0]    bench_N8_reqShiftRom_spinal_port0;
  wire                _zz_bench_N8_inputBuf_0_port;
  wire                _zz_bench_N8_inValsR_0_1;
  wire                _zz_bench_N8_inputBuf_1_port;
  wire                _zz_bench_N8_inValsR_1_1;
  wire                _zz_bench_N8_inputBuf_2_port;
  wire                _zz_bench_N8_inValsR_2_1;
  wire                _zz_bench_N8_inputBuf_3_port;
  wire                _zz_bench_N8_inValsR_3_1;
  wire                _zz_bench_N8_inputBuf_4_port;
  wire                _zz_bench_N8_inValsR_4_1;
  wire                _zz_bench_N8_inputBuf_5_port;
  wire                _zz_bench_N8_inValsR_5_1;
  wire                _zz_bench_N8_inputBuf_6_port;
  wire                _zz_bench_N8_inValsR_6_1;
  wire                _zz_bench_N8_inputBuf_7_port;
  wire                _zz_bench_N8_inValsR_7_1;
  wire                _zz_bench_N8_weightRom_0_port;
  wire                _zz_bench_N8_wValsR_0_1;
  wire                _zz_bench_N8_weightRom_1_port;
  wire                _zz_bench_N8_wValsR_1_1;
  wire                _zz_bench_N8_weightRom_2_port;
  wire                _zz_bench_N8_wValsR_2_1;
  wire                _zz_bench_N8_weightRom_3_port;
  wire                _zz_bench_N8_wValsR_3_1;
  wire                _zz_bench_N8_weightRom_4_port;
  wire                _zz_bench_N8_wValsR_4_1;
  wire                _zz_bench_N8_weightRom_5_port;
  wire                _zz_bench_N8_wValsR_5_1;
  wire                _zz_bench_N8_weightRom_6_port;
  wire                _zz_bench_N8_wValsR_6_1;
  wire                _zz_bench_N8_weightRom_7_port;
  wire                _zz_bench_N8_wValsR_7_1;
  wire       [4:0]    _zz_bench_N8_biasRom_port;
  wire                _zz_bench_N8_biasRom_port_1;
  wire       [4:0]    _zz_bench_N8_biasVal_1;
  wire                _zz_bench_N8_biasVal_2;
  wire       [4:0]    _zz_bench_N8_reqMultRom_port;
  wire                _zz_bench_N8_reqMultRom_port_1;
  wire       [4:0]    _zz_bench_N8_reqMultVal_1;
  wire                _zz_bench_N8_reqMultVal_2;
  wire       [4:0]    _zz_bench_N8_reqShiftRom_port;
  wire                _zz_bench_N8_reqShiftRom_port_1;
  wire       [4:0]    _zz_bench_N8_reqShiftVal_1;
  wire                _zz_bench_N8_reqShiftVal_2;
  wire       [7:0]    _zz_bench_N8_inputBuf_0_port_1;
  wire       [7:0]    _zz_bench_N8_inputBuf_0_port_2;
  wire       [7:0]    _zz_bench_N8_inputBuf_0_port_3;
  wire       [7:0]    _zz_bench_N8_inputBuf_0_port_4;
  wire                _zz_bench_N8_inputBuf_0_port_5;
  wire       [7:0]    _zz_bench_N8_inputBuf_1_port_1;
  wire       [7:0]    _zz_bench_N8_inputBuf_1_port_2;
  wire       [7:0]    _zz_bench_N8_inputBuf_1_port_3;
  wire       [7:0]    _zz_bench_N8_inputBuf_1_port_4;
  wire                _zz_bench_N8_inputBuf_1_port_5;
  wire       [7:0]    _zz_bench_N8_inputBuf_2_port_1;
  wire       [7:0]    _zz_bench_N8_inputBuf_2_port_2;
  wire       [7:0]    _zz_bench_N8_inputBuf_2_port_3;
  wire       [7:0]    _zz_bench_N8_inputBuf_2_port_4;
  wire                _zz_bench_N8_inputBuf_2_port_5;
  wire       [7:0]    _zz_bench_N8_inputBuf_3_port_1;
  wire       [7:0]    _zz_bench_N8_inputBuf_3_port_2;
  wire       [7:0]    _zz_bench_N8_inputBuf_3_port_3;
  wire       [7:0]    _zz_bench_N8_inputBuf_3_port_4;
  wire                _zz_bench_N8_inputBuf_3_port_5;
  wire       [7:0]    _zz_bench_N8_inputBuf_4_port_1;
  wire       [7:0]    _zz_bench_N8_inputBuf_4_port_2;
  wire       [7:0]    _zz_bench_N8_inputBuf_4_port_3;
  wire       [7:0]    _zz_bench_N8_inputBuf_4_port_4;
  wire                _zz_bench_N8_inputBuf_4_port_5;
  wire       [7:0]    _zz_bench_N8_inputBuf_5_port_1;
  wire       [7:0]    _zz_bench_N8_inputBuf_5_port_2;
  wire       [7:0]    _zz_bench_N8_inputBuf_5_port_3;
  wire       [7:0]    _zz_bench_N8_inputBuf_5_port_4;
  wire                _zz_bench_N8_inputBuf_5_port_5;
  wire       [7:0]    _zz_bench_N8_inputBuf_6_port_1;
  wire       [7:0]    _zz_bench_N8_inputBuf_6_port_2;
  wire       [7:0]    _zz_bench_N8_inputBuf_6_port_3;
  wire       [7:0]    _zz_bench_N8_inputBuf_6_port_4;
  wire                _zz_bench_N8_inputBuf_6_port_5;
  wire       [7:0]    _zz_bench_N8_inputBuf_7_port_1;
  wire       [7:0]    _zz_bench_N8_inputBuf_7_port_2;
  wire       [7:0]    _zz_bench_N8_inputBuf_7_port_3;
  wire       [7:0]    _zz_bench_N8_inputBuf_7_port_4;
  wire                _zz_bench_N8_inputBuf_7_port_5;
  wire       [7:0]    _zz_bench_N8_rowElemReg;
  wire       [9:0]    _zz_bench_N8_inAddrReg_1;
  wire       [9:0]    _zz_bench_N8_inAddrReg_2;
  wire       [9:0]    _zz_bench_N8_inAddrReg_3;
  wire       [4:0]    _zz_bench_N8_inAddrReg_4;
  wire       [9:0]    _zz_bench_N8_inAddrReg_5;
  wire       [6:0]    _zz_bench_N8_inAddrReg_6;
  wire       [4:0]    _zz_bench_N8_inAddrReg_7;
  wire       [9:0]    _zz_bench_N8_inAddrReg_8;
  wire       [1:0]    _zz_bench_N8_inAddrReg_9;
  wire       [10:0]   _zz_bench_N8_wAddrReg;
  wire       [10:0]   _zz_bench_N8_wAddrReg_1;
  wire       [10:0]   _zz_bench_N8_wAddrReg_2;
  wire       [10:0]   _zz_bench_N8_wAddrReg_3;
  wire       [10:0]   _zz_bench_N8_wAddrReg_4;
  wire       [2:0]    _zz_bench_N8_wAddrReg_5;
  wire       [10:0]   _zz_bench_N8_wAddrReg_6;
  wire       [1:0]    _zz_bench_N8_wAddrReg_7;
  wire       [10:0]   _zz_bench_N8_wAddrReg_8;
  wire       [1:0]    _zz_bench_N8_wAddrReg_9;
  wire       [2:0]    _zz_bench_N8_rowStepReg;
  wire       [31:0]   _zz_bench_N8_prodReg;
  wire       [31:0]   _zz_bench_N8_prodReg_1;
  wire       [31:0]   _zz_bench_N8_prodReg_2;
  wire       [31:0]   _zz_bench_N8_prodReg_3;
  wire       [31:0]   _zz_bench_N8_prodReg_4;
  wire       [31:0]   _zz_bench_N8_prodReg_5;
  wire       [31:0]   _zz_bench_N8_prodReg_6;
  wire       [17:0]   _zz_bench_N8_prodReg_7;
  wire       [8:0]    _zz_bench_N8_prodReg_8;
  wire       [8:0]    _zz_bench_N8_prodReg_9;
  wire       [8:0]    _zz_bench_N8_prodReg_10;
  wire       [8:0]    _zz_bench_N8_prodReg_11;
  wire       [31:0]   _zz_bench_N8_prodReg_12;
  wire       [17:0]   _zz_bench_N8_prodReg_13;
  wire       [8:0]    _zz_bench_N8_prodReg_14;
  wire       [8:0]    _zz_bench_N8_prodReg_15;
  wire       [8:0]    _zz_bench_N8_prodReg_16;
  wire       [8:0]    _zz_bench_N8_prodReg_17;
  wire       [31:0]   _zz_bench_N8_prodReg_18;
  wire       [17:0]   _zz_bench_N8_prodReg_19;
  wire       [8:0]    _zz_bench_N8_prodReg_20;
  wire       [8:0]    _zz_bench_N8_prodReg_21;
  wire       [8:0]    _zz_bench_N8_prodReg_22;
  wire       [8:0]    _zz_bench_N8_prodReg_23;
  wire       [31:0]   _zz_bench_N8_prodReg_24;
  wire       [17:0]   _zz_bench_N8_prodReg_25;
  wire       [8:0]    _zz_bench_N8_prodReg_26;
  wire       [8:0]    _zz_bench_N8_prodReg_27;
  wire       [8:0]    _zz_bench_N8_prodReg_28;
  wire       [8:0]    _zz_bench_N8_prodReg_29;
  wire       [31:0]   _zz_bench_N8_prodReg_30;
  wire       [17:0]   _zz_bench_N8_prodReg_31;
  wire       [8:0]    _zz_bench_N8_prodReg_32;
  wire       [8:0]    _zz_bench_N8_prodReg_33;
  wire       [8:0]    _zz_bench_N8_prodReg_34;
  wire       [8:0]    _zz_bench_N8_prodReg_35;
  wire       [31:0]   _zz_bench_N8_prodReg_36;
  wire       [17:0]   _zz_bench_N8_prodReg_37;
  wire       [8:0]    _zz_bench_N8_prodReg_38;
  wire       [8:0]    _zz_bench_N8_prodReg_39;
  wire       [8:0]    _zz_bench_N8_prodReg_40;
  wire       [8:0]    _zz_bench_N8_prodReg_41;
  wire       [31:0]   _zz_bench_N8_prodReg_42;
  wire       [17:0]   _zz_bench_N8_prodReg_43;
  wire       [8:0]    _zz_bench_N8_prodReg_44;
  wire       [8:0]    _zz_bench_N8_prodReg_45;
  wire       [8:0]    _zz_bench_N8_prodReg_46;
  wire       [8:0]    _zz_bench_N8_prodReg_47;
  wire       [31:0]   _zz_bench_N8_prodReg_48;
  wire       [17:0]   _zz_bench_N8_prodReg_49;
  wire       [8:0]    _zz_bench_N8_prodReg_50;
  wire       [8:0]    _zz_bench_N8_prodReg_51;
  wire       [8:0]    _zz_bench_N8_prodReg_52;
  wire       [8:0]    _zz_bench_N8_prodReg_53;
  wire       [31:0]   _zz_bench_N8_absAReg;
  wire       [31:0]   _zz_bench_N8_absAReg_1;
  wire       [32:0]   _zz_bench_N8_pSumReg;
  wire       [32:0]   _zz_bench_N8_pSumReg_1;
  wire       [63:0]   _zz_bench_N8_part1Reg;
  wire       [63:0]   _zz_bench_N8_part1Reg_1;
  wire       [79:0]   _zz_bench_N8_part1Reg_2;
  wire       [63:0]   _zz_bench_N8_part1Reg_3;
  wire       [95:0]   _zz_bench_N8_part2Reg;
  wire       [63:0]   _zz_bench_N8_part2Reg_1;
  wire       [63:0]   _zz_bench_N8_reqProdReg2_1;
  wire       [63:0]   _zz_bench_N8_reqProdReg2_2;
  wire       [63:0]   _zz_bench_N8_reqProdReg2_3;
  wire       [31:0]   _zz__zz_bench_N8_resultReg;
  wire       [63:0]   _zz__zz_bench_N8_resultReg_1;
  wire       [7:0]    _zz_bench_N8_resultReg_1;
  wire       [7:0]    _zz_bench_N8_resultReg_2;
  wire       [5:0]    _zz_bench_N8_outChReg;
  wire       [3:0]    _zz_bench_N8_outColReg;
  wire       [3:0]    _zz_bench_N8_outRowReg;
  reg                 inValidR;
  reg        [7:0]    inValueR;
  reg                 outReadyR;
  wire                inStream_valid;
  reg                 inStream_ready;
  wire       [7:0]    inStream_payload_value;
  reg                 bench_N8_activationOut_valid;
  wire                bench_N8_activationOut_ready;
  reg        [7:0]    bench_N8_activationOut_payload_value;
  wire       [3:0]    bench_N8_sReceive;
  wire       [3:0]    bench_N8_sLoadBias;
  wire       [3:0]    bench_N8_sCompute;
  wire       [3:0]    bench_N8_sRequant;
  wire       [3:0]    bench_N8_sRequantMul;
  wire       [3:0]    bench_N8_sRequantWait;
  wire       [3:0]    bench_N8_sRequantWait2;
  wire       [3:0]    bench_N8_sRequantWait3;
  wire       [3:0]    bench_N8_sRequantShift;
  wire       [3:0]    bench_N8_sEmit;
  wire       [3:0]    bench_N8_sInit;
  wire       [3:0]    bench_N8_sWaitBias;
  wire       [3:0]    bench_N8_sLoadWeights;
  reg        [3:0]    bench_N8_stateReg;
  reg        [10:0]   bench_N8_recvCntReg;
  reg        [10:0]   bench_N8_padWriteAddrReg;
  reg        [7:0]    bench_N8_rowElemReg;
  reg        [3:0]    bench_N8_outRowReg;
  reg        [3:0]    bench_N8_outColReg;
  reg        [5:0]    bench_N8_outChReg;
  reg        [31:0]   bench_N8_accumReg;
  reg        [31:0]   bench_N8_prodReg;
  reg        [7:0]    bench_N8_resultReg;
  wire       [63:0]   bench_N8_reqProdReg1;
  reg        [63:0]   bench_N8_reqProdReg2;
  reg        [31:0]   bench_N8_accumRequantReg;
  reg                 bench_N8_signAReg;
  reg        [31:0]   bench_N8_absAReg;
  reg        [31:0]   bench_N8_pLL_Reg;
  reg        [31:0]   bench_N8_pLH_Reg;
  reg        [31:0]   bench_N8_pHL_Reg;
  reg        [31:0]   bench_N8_pHH_Reg;
  reg        [32:0]   bench_N8_pSumReg;
  reg        [31:0]   bench_N8_pLL_Reg2;
  reg        [31:0]   bench_N8_pHH_Reg2;
  reg        [63:0]   bench_N8_part1Reg;
  reg        [63:0]   bench_N8_part2Reg;
  reg        [7:0]    bench_N8_initAddrReg;
  reg        [7:0]    bench_N8_inAddrReg;
  reg        [9:0]    bench_N8_wAddrReg;
  reg        [4:0]    bench_N8_compCycleReg;
  reg        [2:0]    bench_N8_rowStepReg;
  reg        [7:0]    bench_N8_inAddrComb;
  reg        [9:0]    bench_N8_wAddrComb;
  wire       [7:0]    _zz_bench_N8_inValsR_0;
  wire       [7:0]    bench_N8_inValsR_0;
  wire       [7:0]    _zz_bench_N8_inValsR_1;
  wire       [7:0]    bench_N8_inValsR_1;
  wire       [7:0]    _zz_bench_N8_inValsR_2;
  wire       [7:0]    bench_N8_inValsR_2;
  wire       [7:0]    _zz_bench_N8_inValsR_3;
  wire       [7:0]    bench_N8_inValsR_3;
  wire       [7:0]    _zz_bench_N8_inValsR_4;
  wire       [7:0]    bench_N8_inValsR_4;
  wire       [7:0]    _zz_bench_N8_inValsR_5;
  wire       [7:0]    bench_N8_inValsR_5;
  wire       [7:0]    _zz_bench_N8_inValsR_6;
  wire       [7:0]    bench_N8_inValsR_6;
  wire       [7:0]    _zz_bench_N8_inValsR_7;
  wire       [7:0]    bench_N8_inValsR_7;
  wire       [9:0]    _zz_bench_N8_wValsR_0;
  wire       [7:0]    bench_N8_wValsR_0;
  wire       [9:0]    _zz_bench_N8_wValsR_1;
  wire       [7:0]    bench_N8_wValsR_1;
  wire       [9:0]    _zz_bench_N8_wValsR_2;
  wire       [7:0]    bench_N8_wValsR_2;
  wire       [9:0]    _zz_bench_N8_wValsR_3;
  wire       [7:0]    bench_N8_wValsR_3;
  wire       [9:0]    _zz_bench_N8_wValsR_4;
  wire       [7:0]    bench_N8_wValsR_4;
  wire       [9:0]    _zz_bench_N8_wValsR_5;
  wire       [7:0]    bench_N8_wValsR_5;
  wire       [9:0]    _zz_bench_N8_wValsR_6;
  wire       [7:0]    bench_N8_wValsR_6;
  wire       [9:0]    _zz_bench_N8_wValsR_7;
  wire       [7:0]    bench_N8_wValsR_7;
  wire       [5:0]    _zz_bench_N8_biasVal;
  wire       [31:0]   bench_N8_biasVal;
  wire       [5:0]    _zz_bench_N8_reqMultVal;
  wire       [31:0]   bench_N8_reqMultVal;
  wire       [5:0]    _zz_bench_N8_reqShiftVal;
  wire       [7:0]    bench_N8_reqShiftVal;
  reg        [7:0]    bench_N8_inValsReg_0;
  reg        [7:0]    bench_N8_inValsReg_1;
  reg        [7:0]    bench_N8_inValsReg_2;
  reg        [7:0]    bench_N8_inValsReg_3;
  reg        [7:0]    bench_N8_inValsReg_4;
  reg        [7:0]    bench_N8_inValsReg_5;
  reg        [7:0]    bench_N8_inValsReg_6;
  reg        [7:0]    bench_N8_inValsReg_7;
  reg        [7:0]    bench_N8_wValsReg_0;
  reg        [7:0]    bench_N8_wValsReg_1;
  reg        [7:0]    bench_N8_wValsReg_2;
  reg        [7:0]    bench_N8_wValsReg_3;
  reg        [7:0]    bench_N8_wValsReg_4;
  reg        [7:0]    bench_N8_wValsReg_5;
  reg        [7:0]    bench_N8_wValsReg_6;
  reg        [7:0]    bench_N8_wValsReg_7;
  wire                _zz_20;
  wire                inStream_fire;
  wire                _zz_22;
  wire                _zz_24;
  wire                _zz_26;
  wire                _zz_28;
  wire                _zz_30;
  wire                _zz_32;
  wire                _zz_34;
  wire                when_QLinearConvCore_l331;
  wire                when_QLinearConvCore_l333;
  wire                when_QLinearConvCore_l347;
  wire                _zz_bench_N8_padWriteAddrReg;
  wire                when_QLinearConvCore_l357;
  wire                when_QLinearConvCore_l390;
  wire                when_QLinearConvCore_l404;
  wire                when_QLinearConvCore_l412;
  wire                when_QLinearConvCore_l416;
  wire                _zz_bench_N8_inAddrReg;
  wire                when_QLinearConvCore_l429;
  wire                when_QLinearConvCore_l437;
  wire                when_QLinearConvCore_l448;
  wire       [31:0]   _zz_bench_N8_accumReg;
  wire                when_QLinearConvCore_l452;
  wire                when_QLinearConvCore_l461;
  wire                when_QLinearConvCore_l468;
  wire       [15:0]   _zz_bench_N8_pHL_Reg;
  wire       [15:0]   _zz_bench_N8_pLL_Reg;
  wire       [15:0]   _zz_bench_N8_pLH_Reg;
  wire       [15:0]   _zz_bench_N8_pLL_Reg_1;
  wire                when_QLinearConvCore_l485;
  wire                when_QLinearConvCore_l493;
  wire                when_QLinearConvCore_l500;
  wire       [63:0]   _zz_bench_N8_reqProdReg2;
  wire                when_QLinearConvCore_l508;
  wire       [31:0]   _zz_bench_N8_resultReg;
  wire                when_QLinearConvCore_l519;
  wire                bench_N8_activationOut_fire;
  wire                when_QLinearConvCore_l529;
  wire                when_QLinearConvCore_l531;
  wire                _zz_bench_N8_stateReg;
  reg                 inStream_ready_regNext;
  reg                 bench_N8_activationOut_valid_regNext;
  reg        [7:0]    bench_N8_activationOut_payload_value_regNext;
  reg [7:0] bench_N8_inputBuf_0 [0:199];
  reg [7:0] bench_N8_inputBuf_1 [0:199];
  reg [7:0] bench_N8_inputBuf_2 [0:199];
  reg [7:0] bench_N8_inputBuf_3 [0:199];
  reg [7:0] bench_N8_inputBuf_4 [0:199];
  reg [7:0] bench_N8_inputBuf_5 [0:199];
  reg [7:0] bench_N8_inputBuf_6 [0:199];
  reg [7:0] bench_N8_inputBuf_7 [0:199];
  reg [7:0] bench_N8_weightRom_0 [0:575];
  reg [7:0] bench_N8_weightRom_1 [0:575];
  reg [7:0] bench_N8_weightRom_2 [0:575];
  reg [7:0] bench_N8_weightRom_3 [0:575];
  reg [7:0] bench_N8_weightRom_4 [0:575];
  reg [7:0] bench_N8_weightRom_5 [0:575];
  reg [7:0] bench_N8_weightRom_6 [0:575];
  reg [7:0] bench_N8_weightRom_7 [0:575];
  reg [31:0] bench_N8_biasRom [0:31];
  reg [31:0] bench_N8_reqMultRom [0:31];
  reg [7:0] bench_N8_reqShiftRom [0:31];

  assign _zz_bench_N8_biasVal_1 = _zz_bench_N8_biasVal[4:0];
  assign _zz_bench_N8_reqMultVal_1 = _zz_bench_N8_reqMultVal[4:0];
  assign _zz_bench_N8_reqShiftVal_1 = _zz_bench_N8_reqShiftVal[4:0];
  assign _zz_bench_N8_inputBuf_0_port_2 = (bench_N8_padWriteAddrReg >>> 2'd3);
  assign _zz_bench_N8_inputBuf_0_port_4 = (_zz_20 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N8_inputBuf_1_port_2 = (bench_N8_padWriteAddrReg >>> 2'd3);
  assign _zz_bench_N8_inputBuf_1_port_4 = (_zz_22 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N8_inputBuf_2_port_2 = (bench_N8_padWriteAddrReg >>> 2'd3);
  assign _zz_bench_N8_inputBuf_2_port_4 = (_zz_24 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N8_inputBuf_3_port_2 = (bench_N8_padWriteAddrReg >>> 2'd3);
  assign _zz_bench_N8_inputBuf_3_port_4 = (_zz_26 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N8_inputBuf_4_port_2 = (bench_N8_padWriteAddrReg >>> 2'd3);
  assign _zz_bench_N8_inputBuf_4_port_4 = (_zz_28 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N8_inputBuf_5_port_2 = (bench_N8_padWriteAddrReg >>> 2'd3);
  assign _zz_bench_N8_inputBuf_5_port_4 = (_zz_30 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N8_inputBuf_6_port_2 = (bench_N8_padWriteAddrReg >>> 2'd3);
  assign _zz_bench_N8_inputBuf_6_port_4 = (_zz_32 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N8_inputBuf_7_port_2 = (bench_N8_padWriteAddrReg >>> 2'd3);
  assign _zz_bench_N8_inputBuf_7_port_4 = (_zz_34 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N8_rowElemReg = (bench_N8_rowElemReg + 8'h01);
  assign _zz_bench_N8_inAddrReg_1 = (_zz_bench_N8_inAddrReg_2 + _zz_bench_N8_inAddrReg_8);
  assign _zz_bench_N8_inAddrReg_2 = (_zz_bench_N8_inAddrReg_3 + _zz_bench_N8_inAddrReg_5);
  assign _zz_bench_N8_inAddrReg_3 = (_zz_bench_N8_inAddrReg_4 * 5'h14);
  assign _zz_bench_N8_inAddrReg_4 = (bench_N8_outRowReg * 1'b1);
  assign _zz_bench_N8_inAddrReg_6 = (_zz_bench_N8_inAddrReg_7 * 2'b10);
  assign _zz_bench_N8_inAddrReg_5 = {3'd0, _zz_bench_N8_inAddrReg_6};
  assign _zz_bench_N8_inAddrReg_7 = (bench_N8_outColReg * 1'b1);
  assign _zz_bench_N8_inAddrReg_9 = 2'b00;
  assign _zz_bench_N8_inAddrReg_8 = {8'd0, _zz_bench_N8_inAddrReg_9};
  assign _zz_bench_N8_wAddrReg = (_zz_bench_N8_wAddrReg_1 + _zz_bench_N8_wAddrReg_8);
  assign _zz_bench_N8_wAddrReg_1 = (_zz_bench_N8_wAddrReg_2 + _zz_bench_N8_wAddrReg_6);
  assign _zz_bench_N8_wAddrReg_2 = (_zz_bench_N8_wAddrReg_3 + _zz_bench_N8_wAddrReg_4);
  assign _zz_bench_N8_wAddrReg_3 = (bench_N8_outChReg * 5'h12);
  assign _zz_bench_N8_wAddrReg_5 = 3'b000;
  assign _zz_bench_N8_wAddrReg_4 = {8'd0, _zz_bench_N8_wAddrReg_5};
  assign _zz_bench_N8_wAddrReg_7 = 2'b00;
  assign _zz_bench_N8_wAddrReg_6 = {9'd0, _zz_bench_N8_wAddrReg_7};
  assign _zz_bench_N8_wAddrReg_9 = 2'b00;
  assign _zz_bench_N8_wAddrReg_8 = {9'd0, _zz_bench_N8_wAddrReg_9};
  assign _zz_bench_N8_rowStepReg = (bench_N8_rowStepReg + 3'b001);
  assign _zz_bench_N8_prodReg = ($signed(_zz_bench_N8_prodReg_1) + $signed(_zz_bench_N8_prodReg_42));
  assign _zz_bench_N8_prodReg_1 = ($signed(_zz_bench_N8_prodReg_2) + $signed(_zz_bench_N8_prodReg_36));
  assign _zz_bench_N8_prodReg_2 = ($signed(_zz_bench_N8_prodReg_3) + $signed(_zz_bench_N8_prodReg_30));
  assign _zz_bench_N8_prodReg_3 = ($signed(_zz_bench_N8_prodReg_4) + $signed(_zz_bench_N8_prodReg_24));
  assign _zz_bench_N8_prodReg_4 = ($signed(_zz_bench_N8_prodReg_5) + $signed(_zz_bench_N8_prodReg_18));
  assign _zz_bench_N8_prodReg_5 = ($signed(_zz_bench_N8_prodReg_6) + $signed(_zz_bench_N8_prodReg_12));
  assign _zz_bench_N8_prodReg_7 = ($signed(_zz_bench_N8_prodReg_8) * $signed(_zz_bench_N8_prodReg_10));
  assign _zz_bench_N8_prodReg_6 = {{14{_zz_bench_N8_prodReg_7[17]}}, _zz_bench_N8_prodReg_7};
  assign _zz_bench_N8_prodReg_8 = ($signed(_zz_bench_N8_prodReg_9) - $signed(9'h180));
  assign _zz_bench_N8_prodReg_9 = {{1{bench_N8_inValsReg_0[7]}}, bench_N8_inValsReg_0};
  assign _zz_bench_N8_prodReg_10 = ($signed(_zz_bench_N8_prodReg_11) - $signed(9'h0));
  assign _zz_bench_N8_prodReg_11 = {{1{bench_N8_wValsReg_0[7]}}, bench_N8_wValsReg_0};
  assign _zz_bench_N8_prodReg_13 = ($signed(_zz_bench_N8_prodReg_14) * $signed(_zz_bench_N8_prodReg_16));
  assign _zz_bench_N8_prodReg_12 = {{14{_zz_bench_N8_prodReg_13[17]}}, _zz_bench_N8_prodReg_13};
  assign _zz_bench_N8_prodReg_14 = ($signed(_zz_bench_N8_prodReg_15) - $signed(9'h180));
  assign _zz_bench_N8_prodReg_15 = {{1{bench_N8_inValsReg_1[7]}}, bench_N8_inValsReg_1};
  assign _zz_bench_N8_prodReg_16 = ($signed(_zz_bench_N8_prodReg_17) - $signed(9'h0));
  assign _zz_bench_N8_prodReg_17 = {{1{bench_N8_wValsReg_1[7]}}, bench_N8_wValsReg_1};
  assign _zz_bench_N8_prodReg_19 = ($signed(_zz_bench_N8_prodReg_20) * $signed(_zz_bench_N8_prodReg_22));
  assign _zz_bench_N8_prodReg_18 = {{14{_zz_bench_N8_prodReg_19[17]}}, _zz_bench_N8_prodReg_19};
  assign _zz_bench_N8_prodReg_20 = ($signed(_zz_bench_N8_prodReg_21) - $signed(9'h180));
  assign _zz_bench_N8_prodReg_21 = {{1{bench_N8_inValsReg_2[7]}}, bench_N8_inValsReg_2};
  assign _zz_bench_N8_prodReg_22 = ($signed(_zz_bench_N8_prodReg_23) - $signed(9'h0));
  assign _zz_bench_N8_prodReg_23 = {{1{bench_N8_wValsReg_2[7]}}, bench_N8_wValsReg_2};
  assign _zz_bench_N8_prodReg_25 = ($signed(_zz_bench_N8_prodReg_26) * $signed(_zz_bench_N8_prodReg_28));
  assign _zz_bench_N8_prodReg_24 = {{14{_zz_bench_N8_prodReg_25[17]}}, _zz_bench_N8_prodReg_25};
  assign _zz_bench_N8_prodReg_26 = ($signed(_zz_bench_N8_prodReg_27) - $signed(9'h180));
  assign _zz_bench_N8_prodReg_27 = {{1{bench_N8_inValsReg_3[7]}}, bench_N8_inValsReg_3};
  assign _zz_bench_N8_prodReg_28 = ($signed(_zz_bench_N8_prodReg_29) - $signed(9'h0));
  assign _zz_bench_N8_prodReg_29 = {{1{bench_N8_wValsReg_3[7]}}, bench_N8_wValsReg_3};
  assign _zz_bench_N8_prodReg_31 = ($signed(_zz_bench_N8_prodReg_32) * $signed(_zz_bench_N8_prodReg_34));
  assign _zz_bench_N8_prodReg_30 = {{14{_zz_bench_N8_prodReg_31[17]}}, _zz_bench_N8_prodReg_31};
  assign _zz_bench_N8_prodReg_32 = ($signed(_zz_bench_N8_prodReg_33) - $signed(9'h180));
  assign _zz_bench_N8_prodReg_33 = {{1{bench_N8_inValsReg_4[7]}}, bench_N8_inValsReg_4};
  assign _zz_bench_N8_prodReg_34 = ($signed(_zz_bench_N8_prodReg_35) - $signed(9'h0));
  assign _zz_bench_N8_prodReg_35 = {{1{bench_N8_wValsReg_4[7]}}, bench_N8_wValsReg_4};
  assign _zz_bench_N8_prodReg_37 = ($signed(_zz_bench_N8_prodReg_38) * $signed(_zz_bench_N8_prodReg_40));
  assign _zz_bench_N8_prodReg_36 = {{14{_zz_bench_N8_prodReg_37[17]}}, _zz_bench_N8_prodReg_37};
  assign _zz_bench_N8_prodReg_38 = ($signed(_zz_bench_N8_prodReg_39) - $signed(9'h180));
  assign _zz_bench_N8_prodReg_39 = {{1{bench_N8_inValsReg_5[7]}}, bench_N8_inValsReg_5};
  assign _zz_bench_N8_prodReg_40 = ($signed(_zz_bench_N8_prodReg_41) - $signed(9'h0));
  assign _zz_bench_N8_prodReg_41 = {{1{bench_N8_wValsReg_5[7]}}, bench_N8_wValsReg_5};
  assign _zz_bench_N8_prodReg_43 = ($signed(_zz_bench_N8_prodReg_44) * $signed(_zz_bench_N8_prodReg_46));
  assign _zz_bench_N8_prodReg_42 = {{14{_zz_bench_N8_prodReg_43[17]}}, _zz_bench_N8_prodReg_43};
  assign _zz_bench_N8_prodReg_44 = ($signed(_zz_bench_N8_prodReg_45) - $signed(9'h180));
  assign _zz_bench_N8_prodReg_45 = {{1{bench_N8_inValsReg_6[7]}}, bench_N8_inValsReg_6};
  assign _zz_bench_N8_prodReg_46 = ($signed(_zz_bench_N8_prodReg_47) - $signed(9'h0));
  assign _zz_bench_N8_prodReg_47 = {{1{bench_N8_wValsReg_6[7]}}, bench_N8_wValsReg_6};
  assign _zz_bench_N8_prodReg_49 = ($signed(_zz_bench_N8_prodReg_50) * $signed(_zz_bench_N8_prodReg_52));
  assign _zz_bench_N8_prodReg_48 = {{14{_zz_bench_N8_prodReg_49[17]}}, _zz_bench_N8_prodReg_49};
  assign _zz_bench_N8_prodReg_50 = ($signed(_zz_bench_N8_prodReg_51) - $signed(9'h180));
  assign _zz_bench_N8_prodReg_51 = {{1{bench_N8_inValsReg_7[7]}}, bench_N8_inValsReg_7};
  assign _zz_bench_N8_prodReg_52 = ($signed(_zz_bench_N8_prodReg_53) - $signed(9'h0));
  assign _zz_bench_N8_prodReg_53 = {{1{bench_N8_wValsReg_7[7]}}, bench_N8_wValsReg_7};
  assign _zz_bench_N8_absAReg = (($signed(bench_N8_accumRequantReg) < $signed(32'h0)) ? _zz_bench_N8_absAReg_1 : bench_N8_accumRequantReg);
  assign _zz_bench_N8_absAReg_1 = (- bench_N8_accumRequantReg);
  assign _zz_bench_N8_pSumReg = {1'd0, bench_N8_pLH_Reg};
  assign _zz_bench_N8_pSumReg_1 = {1'd0, bench_N8_pHL_Reg};
  assign _zz_bench_N8_part1Reg = {32'd0, bench_N8_pLL_Reg2};
  assign _zz_bench_N8_part1Reg_2 = ({16'd0,_zz_bench_N8_part1Reg_3} <<< 5'd16);
  assign _zz_bench_N8_part1Reg_1 = _zz_bench_N8_part1Reg_2[63:0];
  assign _zz_bench_N8_part1Reg_3 = {31'd0, bench_N8_pSumReg};
  assign _zz_bench_N8_part2Reg = ({32'd0,_zz_bench_N8_part2Reg_1} <<< 6'd32);
  assign _zz_bench_N8_part2Reg_1 = {32'd0, bench_N8_pHH_Reg2};
  assign _zz_bench_N8_reqProdReg2_1 = (- _zz_bench_N8_reqProdReg2_2);
  assign _zz_bench_N8_reqProdReg2_2 = _zz_bench_N8_reqProdReg2;
  assign _zz_bench_N8_reqProdReg2_3 = _zz_bench_N8_reqProdReg2;
  assign _zz__zz_bench_N8_resultReg_1 = ($signed(bench_N8_reqProdReg2) >>> bench_N8_reqShiftVal);
  assign _zz__zz_bench_N8_resultReg = _zz__zz_bench_N8_resultReg_1[31:0];
  assign _zz_bench_N8_resultReg_1 = (($signed(_zz_bench_N8_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz_bench_N8_resultReg_2);
  assign _zz_bench_N8_resultReg_2 = _zz_bench_N8_resultReg[7:0];
  assign _zz_bench_N8_outChReg = (bench_N8_outChReg + 6'h01);
  assign _zz_bench_N8_outColReg = (bench_N8_outColReg + 4'b0001);
  assign _zz_bench_N8_outRowReg = (bench_N8_outRowReg + 4'b0001);
  assign _zz_bench_N8_inValsR_0_1 = 1'b1;
  assign _zz_bench_N8_inputBuf_0_port_1 = (_zz_20 ? bench_N8_initAddrReg : _zz_bench_N8_inputBuf_0_port_2);
  assign _zz_bench_N8_inputBuf_0_port_3 = _zz_bench_N8_inputBuf_0_port_4;
  assign _zz_bench_N8_inputBuf_0_port_5 = (_zz_20 || (((bench_N8_stateReg == bench_N8_sReceive) && inStream_fire) && (bench_N8_padWriteAddrReg[2 : 0] == 3'b000)));
  assign _zz_bench_N8_inValsR_1_1 = 1'b1;
  assign _zz_bench_N8_inputBuf_1_port_1 = (_zz_22 ? bench_N8_initAddrReg : _zz_bench_N8_inputBuf_1_port_2);
  assign _zz_bench_N8_inputBuf_1_port_3 = _zz_bench_N8_inputBuf_1_port_4;
  assign _zz_bench_N8_inputBuf_1_port_5 = (_zz_22 || (((bench_N8_stateReg == bench_N8_sReceive) && inStream_fire) && (bench_N8_padWriteAddrReg[2 : 0] == 3'b001)));
  assign _zz_bench_N8_inValsR_2_1 = 1'b1;
  assign _zz_bench_N8_inputBuf_2_port_1 = (_zz_24 ? bench_N8_initAddrReg : _zz_bench_N8_inputBuf_2_port_2);
  assign _zz_bench_N8_inputBuf_2_port_3 = _zz_bench_N8_inputBuf_2_port_4;
  assign _zz_bench_N8_inputBuf_2_port_5 = (_zz_24 || (((bench_N8_stateReg == bench_N8_sReceive) && inStream_fire) && (bench_N8_padWriteAddrReg[2 : 0] == 3'b010)));
  assign _zz_bench_N8_inValsR_3_1 = 1'b1;
  assign _zz_bench_N8_inputBuf_3_port_1 = (_zz_26 ? bench_N8_initAddrReg : _zz_bench_N8_inputBuf_3_port_2);
  assign _zz_bench_N8_inputBuf_3_port_3 = _zz_bench_N8_inputBuf_3_port_4;
  assign _zz_bench_N8_inputBuf_3_port_5 = (_zz_26 || (((bench_N8_stateReg == bench_N8_sReceive) && inStream_fire) && (bench_N8_padWriteAddrReg[2 : 0] == 3'b011)));
  assign _zz_bench_N8_inValsR_4_1 = 1'b1;
  assign _zz_bench_N8_inputBuf_4_port_1 = (_zz_28 ? bench_N8_initAddrReg : _zz_bench_N8_inputBuf_4_port_2);
  assign _zz_bench_N8_inputBuf_4_port_3 = _zz_bench_N8_inputBuf_4_port_4;
  assign _zz_bench_N8_inputBuf_4_port_5 = (_zz_28 || (((bench_N8_stateReg == bench_N8_sReceive) && inStream_fire) && (bench_N8_padWriteAddrReg[2 : 0] == 3'b100)));
  assign _zz_bench_N8_inValsR_5_1 = 1'b1;
  assign _zz_bench_N8_inputBuf_5_port_1 = (_zz_30 ? bench_N8_initAddrReg : _zz_bench_N8_inputBuf_5_port_2);
  assign _zz_bench_N8_inputBuf_5_port_3 = _zz_bench_N8_inputBuf_5_port_4;
  assign _zz_bench_N8_inputBuf_5_port_5 = (_zz_30 || (((bench_N8_stateReg == bench_N8_sReceive) && inStream_fire) && (bench_N8_padWriteAddrReg[2 : 0] == 3'b101)));
  assign _zz_bench_N8_inValsR_6_1 = 1'b1;
  assign _zz_bench_N8_inputBuf_6_port_1 = (_zz_32 ? bench_N8_initAddrReg : _zz_bench_N8_inputBuf_6_port_2);
  assign _zz_bench_N8_inputBuf_6_port_3 = _zz_bench_N8_inputBuf_6_port_4;
  assign _zz_bench_N8_inputBuf_6_port_5 = (_zz_32 || (((bench_N8_stateReg == bench_N8_sReceive) && inStream_fire) && (bench_N8_padWriteAddrReg[2 : 0] == 3'b110)));
  assign _zz_bench_N8_inValsR_7_1 = 1'b1;
  assign _zz_bench_N8_inputBuf_7_port_1 = (_zz_34 ? bench_N8_initAddrReg : _zz_bench_N8_inputBuf_7_port_2);
  assign _zz_bench_N8_inputBuf_7_port_3 = _zz_bench_N8_inputBuf_7_port_4;
  assign _zz_bench_N8_inputBuf_7_port_5 = (_zz_34 || (((bench_N8_stateReg == bench_N8_sReceive) && inStream_fire) && (bench_N8_padWriteAddrReg[2 : 0] == 3'b111)));
  assign _zz_bench_N8_wValsR_0_1 = 1'b1;
  assign _zz_bench_N8_wValsR_1_1 = 1'b1;
  assign _zz_bench_N8_wValsR_2_1 = 1'b1;
  assign _zz_bench_N8_wValsR_3_1 = 1'b1;
  assign _zz_bench_N8_wValsR_4_1 = 1'b1;
  assign _zz_bench_N8_wValsR_5_1 = 1'b1;
  assign _zz_bench_N8_wValsR_6_1 = 1'b1;
  assign _zz_bench_N8_wValsR_7_1 = 1'b1;
  assign _zz_bench_N8_biasVal_2 = 1'b1;
  assign _zz_bench_N8_reqMultVal_2 = 1'b1;
  assign _zz_bench_N8_reqShiftVal_2 = 1'b1;
  always @(posedge clk) begin
    if(_zz_bench_N8_inValsR_0_1) begin
      bench_N8_inputBuf_0_spinal_port0 <= bench_N8_inputBuf_0[_zz_bench_N8_inValsR_0];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inputBuf_0_port_5) begin
      bench_N8_inputBuf_0[_zz_bench_N8_inputBuf_0_port_1] <= _zz_bench_N8_inputBuf_0_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inValsR_1_1) begin
      bench_N8_inputBuf_1_spinal_port0 <= bench_N8_inputBuf_1[_zz_bench_N8_inValsR_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inputBuf_1_port_5) begin
      bench_N8_inputBuf_1[_zz_bench_N8_inputBuf_1_port_1] <= _zz_bench_N8_inputBuf_1_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inValsR_2_1) begin
      bench_N8_inputBuf_2_spinal_port0 <= bench_N8_inputBuf_2[_zz_bench_N8_inValsR_2];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inputBuf_2_port_5) begin
      bench_N8_inputBuf_2[_zz_bench_N8_inputBuf_2_port_1] <= _zz_bench_N8_inputBuf_2_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inValsR_3_1) begin
      bench_N8_inputBuf_3_spinal_port0 <= bench_N8_inputBuf_3[_zz_bench_N8_inValsR_3];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inputBuf_3_port_5) begin
      bench_N8_inputBuf_3[_zz_bench_N8_inputBuf_3_port_1] <= _zz_bench_N8_inputBuf_3_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inValsR_4_1) begin
      bench_N8_inputBuf_4_spinal_port0 <= bench_N8_inputBuf_4[_zz_bench_N8_inValsR_4];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inputBuf_4_port_5) begin
      bench_N8_inputBuf_4[_zz_bench_N8_inputBuf_4_port_1] <= _zz_bench_N8_inputBuf_4_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inValsR_5_1) begin
      bench_N8_inputBuf_5_spinal_port0 <= bench_N8_inputBuf_5[_zz_bench_N8_inValsR_5];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inputBuf_5_port_5) begin
      bench_N8_inputBuf_5[_zz_bench_N8_inputBuf_5_port_1] <= _zz_bench_N8_inputBuf_5_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inValsR_6_1) begin
      bench_N8_inputBuf_6_spinal_port0 <= bench_N8_inputBuf_6[_zz_bench_N8_inValsR_6];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inputBuf_6_port_5) begin
      bench_N8_inputBuf_6[_zz_bench_N8_inputBuf_6_port_1] <= _zz_bench_N8_inputBuf_6_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inValsR_7_1) begin
      bench_N8_inputBuf_7_spinal_port0 <= bench_N8_inputBuf_7[_zz_bench_N8_inValsR_7];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N8_inputBuf_7_port_5) begin
      bench_N8_inputBuf_7[_zz_bench_N8_inputBuf_7_port_1] <= _zz_bench_N8_inputBuf_7_port_3;
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_weightRom_0.bin",bench_N8_weightRom_0);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_wValsR_0_1) begin
      bench_N8_weightRom_0_spinal_port0 <= bench_N8_weightRom_0[_zz_bench_N8_wValsR_0];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_weightRom_1.bin",bench_N8_weightRom_1);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_wValsR_1_1) begin
      bench_N8_weightRom_1_spinal_port0 <= bench_N8_weightRom_1[_zz_bench_N8_wValsR_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_weightRom_2.bin",bench_N8_weightRom_2);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_wValsR_2_1) begin
      bench_N8_weightRom_2_spinal_port0 <= bench_N8_weightRom_2[_zz_bench_N8_wValsR_2];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_weightRom_3.bin",bench_N8_weightRom_3);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_wValsR_3_1) begin
      bench_N8_weightRom_3_spinal_port0 <= bench_N8_weightRom_3[_zz_bench_N8_wValsR_3];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_weightRom_4.bin",bench_N8_weightRom_4);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_wValsR_4_1) begin
      bench_N8_weightRom_4_spinal_port0 <= bench_N8_weightRom_4[_zz_bench_N8_wValsR_4];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_weightRom_5.bin",bench_N8_weightRom_5);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_wValsR_5_1) begin
      bench_N8_weightRom_5_spinal_port0 <= bench_N8_weightRom_5[_zz_bench_N8_wValsR_5];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_weightRom_6.bin",bench_N8_weightRom_6);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_wValsR_6_1) begin
      bench_N8_weightRom_6_spinal_port0 <= bench_N8_weightRom_6[_zz_bench_N8_wValsR_6];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_weightRom_7.bin",bench_N8_weightRom_7);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_wValsR_7_1) begin
      bench_N8_weightRom_7_spinal_port0 <= bench_N8_weightRom_7[_zz_bench_N8_wValsR_7];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_biasRom.bin",bench_N8_biasRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_biasVal_2) begin
      bench_N8_biasRom_spinal_port0 <= bench_N8_biasRom[_zz_bench_N8_biasVal_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_reqMultRom.bin",bench_N8_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_reqMultVal_2) begin
      bench_N8_reqMultRom_spinal_port0 <= bench_N8_reqMultRom[_zz_bench_N8_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N8_reqShiftRom.bin",bench_N8_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N8_reqShiftVal_2) begin
      bench_N8_reqShiftRom_spinal_port0 <= bench_N8_reqShiftRom[_zz_bench_N8_reqShiftVal_1];
    end
  end

  assign inStream_valid = inValidR;
  assign inStream_payload_value = inValueR;
  assign bench_N8_sReceive = 4'b0000;
  assign bench_N8_sLoadBias = 4'b0001;
  assign bench_N8_sCompute = 4'b0010;
  assign bench_N8_sRequant = 4'b0011;
  assign bench_N8_sRequantMul = 4'b0100;
  assign bench_N8_sRequantWait = 4'b0101;
  assign bench_N8_sRequantWait2 = 4'b0110;
  assign bench_N8_sRequantWait3 = 4'b0111;
  assign bench_N8_sRequantShift = 4'b1000;
  assign bench_N8_sEmit = 4'b1001;
  assign bench_N8_sInit = 4'b1010;
  assign bench_N8_sWaitBias = 4'b1011;
  assign bench_N8_sLoadWeights = 4'b1100;
  assign bench_N8_reqProdReg1 = 64'h0;
  always @(*) begin
    bench_N8_inAddrComb = bench_N8_inAddrReg;
    if(when_QLinearConvCore_l412) begin
      if(when_QLinearConvCore_l416) begin
        bench_N8_inAddrComb = bench_N8_inAddrReg;
      end
    end
  end

  always @(*) begin
    bench_N8_wAddrComb = bench_N8_wAddrReg;
    if(when_QLinearConvCore_l412) begin
      if(when_QLinearConvCore_l416) begin
        bench_N8_wAddrComb = bench_N8_wAddrReg;
      end
    end
  end

  assign _zz_bench_N8_inValsR_0 = bench_N8_inAddrComb;
  assign bench_N8_inValsR_0 = bench_N8_inputBuf_0_spinal_port0;
  assign _zz_bench_N8_inValsR_1 = bench_N8_inAddrComb;
  assign bench_N8_inValsR_1 = bench_N8_inputBuf_1_spinal_port0;
  assign _zz_bench_N8_inValsR_2 = bench_N8_inAddrComb;
  assign bench_N8_inValsR_2 = bench_N8_inputBuf_2_spinal_port0;
  assign _zz_bench_N8_inValsR_3 = bench_N8_inAddrComb;
  assign bench_N8_inValsR_3 = bench_N8_inputBuf_3_spinal_port0;
  assign _zz_bench_N8_inValsR_4 = bench_N8_inAddrComb;
  assign bench_N8_inValsR_4 = bench_N8_inputBuf_4_spinal_port0;
  assign _zz_bench_N8_inValsR_5 = bench_N8_inAddrComb;
  assign bench_N8_inValsR_5 = bench_N8_inputBuf_5_spinal_port0;
  assign _zz_bench_N8_inValsR_6 = bench_N8_inAddrComb;
  assign bench_N8_inValsR_6 = bench_N8_inputBuf_6_spinal_port0;
  assign _zz_bench_N8_inValsR_7 = bench_N8_inAddrComb;
  assign bench_N8_inValsR_7 = bench_N8_inputBuf_7_spinal_port0;
  assign _zz_bench_N8_wValsR_0 = bench_N8_wAddrComb;
  assign bench_N8_wValsR_0 = bench_N8_weightRom_0_spinal_port0;
  assign _zz_bench_N8_wValsR_1 = bench_N8_wAddrComb;
  assign bench_N8_wValsR_1 = bench_N8_weightRom_1_spinal_port0;
  assign _zz_bench_N8_wValsR_2 = bench_N8_wAddrComb;
  assign bench_N8_wValsR_2 = bench_N8_weightRom_2_spinal_port0;
  assign _zz_bench_N8_wValsR_3 = bench_N8_wAddrComb;
  assign bench_N8_wValsR_3 = bench_N8_weightRom_3_spinal_port0;
  assign _zz_bench_N8_wValsR_4 = bench_N8_wAddrComb;
  assign bench_N8_wValsR_4 = bench_N8_weightRom_4_spinal_port0;
  assign _zz_bench_N8_wValsR_5 = bench_N8_wAddrComb;
  assign bench_N8_wValsR_5 = bench_N8_weightRom_5_spinal_port0;
  assign _zz_bench_N8_wValsR_6 = bench_N8_wAddrComb;
  assign bench_N8_wValsR_6 = bench_N8_weightRom_6_spinal_port0;
  assign _zz_bench_N8_wValsR_7 = bench_N8_wAddrComb;
  assign bench_N8_wValsR_7 = bench_N8_weightRom_7_spinal_port0;
  assign _zz_bench_N8_biasVal = bench_N8_outChReg;
  assign bench_N8_biasVal = bench_N8_biasRom_spinal_port0;
  assign _zz_bench_N8_reqMultVal = bench_N8_outChReg;
  assign bench_N8_reqMultVal = bench_N8_reqMultRom_spinal_port0;
  assign _zz_bench_N8_reqShiftVal = bench_N8_outChReg;
  assign bench_N8_reqShiftVal = bench_N8_reqShiftRom_spinal_port0;
  assign _zz_20 = (bench_N8_stateReg == bench_N8_sInit);
  assign inStream_fire = (inStream_valid && inStream_ready);
  assign _zz_22 = (bench_N8_stateReg == bench_N8_sInit);
  assign _zz_24 = (bench_N8_stateReg == bench_N8_sInit);
  assign _zz_26 = (bench_N8_stateReg == bench_N8_sInit);
  assign _zz_28 = (bench_N8_stateReg == bench_N8_sInit);
  assign _zz_30 = (bench_N8_stateReg == bench_N8_sInit);
  assign _zz_32 = (bench_N8_stateReg == bench_N8_sInit);
  assign _zz_34 = (bench_N8_stateReg == bench_N8_sInit);
  always @(*) begin
    inStream_ready = 1'b0;
    if(when_QLinearConvCore_l347) begin
      inStream_ready = 1'b1;
    end
  end

  always @(*) begin
    bench_N8_activationOut_valid = 1'b0;
    if(when_QLinearConvCore_l519) begin
      bench_N8_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    bench_N8_activationOut_payload_value = bench_N8_resultReg;
    if(when_QLinearConvCore_l519) begin
      bench_N8_activationOut_payload_value = bench_N8_resultReg;
    end
  end

  assign when_QLinearConvCore_l331 = (bench_N8_stateReg == bench_N8_sInit);
  assign when_QLinearConvCore_l333 = (bench_N8_initAddrReg == 8'hc7);
  assign when_QLinearConvCore_l347 = (bench_N8_stateReg == bench_N8_sReceive);
  assign _zz_bench_N8_padWriteAddrReg = (bench_N8_rowElemReg == 8'h7f);
  assign when_QLinearConvCore_l357 = (bench_N8_recvCntReg == 11'h3ff);
  assign when_QLinearConvCore_l390 = (bench_N8_stateReg == bench_N8_sLoadBias);
  assign when_QLinearConvCore_l404 = (bench_N8_stateReg == bench_N8_sWaitBias);
  assign when_QLinearConvCore_l412 = (bench_N8_stateReg == bench_N8_sCompute);
  assign when_QLinearConvCore_l416 = (bench_N8_compCycleReg < 5'h12);
  assign _zz_bench_N8_inAddrReg = (bench_N8_rowStepReg == 3'b101);
  assign when_QLinearConvCore_l429 = ((5'h01 <= bench_N8_compCycleReg) && (bench_N8_compCycleReg <= 5'h12));
  assign when_QLinearConvCore_l437 = ((5'h02 <= bench_N8_compCycleReg) && (bench_N8_compCycleReg <= 5'h13));
  assign when_QLinearConvCore_l448 = ((5'h03 <= bench_N8_compCycleReg) && (bench_N8_compCycleReg <= 5'h14));
  assign _zz_bench_N8_accumReg = ($signed(bench_N8_accumReg) + $signed(bench_N8_prodReg));
  assign when_QLinearConvCore_l452 = (bench_N8_compCycleReg == 5'h14);
  assign when_QLinearConvCore_l461 = (bench_N8_stateReg == bench_N8_sRequant);
  assign when_QLinearConvCore_l468 = (bench_N8_stateReg == bench_N8_sRequantMul);
  assign _zz_bench_N8_pHL_Reg = bench_N8_absAReg[31 : 16];
  assign _zz_bench_N8_pLL_Reg = bench_N8_absAReg[15 : 0];
  assign _zz_bench_N8_pLH_Reg = bench_N8_reqMultVal[31 : 16];
  assign _zz_bench_N8_pLL_Reg_1 = bench_N8_reqMultVal[15 : 0];
  assign when_QLinearConvCore_l485 = (bench_N8_stateReg == bench_N8_sRequantWait);
  assign when_QLinearConvCore_l493 = (bench_N8_stateReg == bench_N8_sRequantWait2);
  assign when_QLinearConvCore_l500 = (bench_N8_stateReg == bench_N8_sRequantWait3);
  assign _zz_bench_N8_reqProdReg2 = (bench_N8_part1Reg + bench_N8_part2Reg);
  assign when_QLinearConvCore_l508 = (bench_N8_stateReg == bench_N8_sRequantShift);
  assign _zz_bench_N8_resultReg = ($signed(_zz__zz_bench_N8_resultReg) + $signed(32'hffffff80));
  assign when_QLinearConvCore_l519 = (bench_N8_stateReg == bench_N8_sEmit);
  assign bench_N8_activationOut_fire = (bench_N8_activationOut_valid && bench_N8_activationOut_ready);
  assign when_QLinearConvCore_l529 = (bench_N8_outChReg == 6'h1f);
  assign when_QLinearConvCore_l531 = (bench_N8_outColReg == 4'b0111);
  assign _zz_bench_N8_stateReg = (bench_N8_outRowReg == 4'b0111);
  assign bench_N8_activationOut_ready = outReadyR;
  assign io_inReady = inStream_ready_regNext;
  assign io_outValid = bench_N8_activationOut_valid_regNext;
  assign io_outValue = bench_N8_activationOut_payload_value_regNext;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      inValidR <= 1'b0;
      inValueR <= 8'h0;
      outReadyR <= 1'b0;
      bench_N8_stateReg <= 4'b1010;
      bench_N8_recvCntReg <= 11'h0;
      bench_N8_padWriteAddrReg <= 11'h0b0;
      bench_N8_rowElemReg <= 8'h0;
      bench_N8_outRowReg <= 4'b0000;
      bench_N8_outColReg <= 4'b0000;
      bench_N8_outChReg <= 6'h0;
      bench_N8_accumReg <= 32'h0;
      bench_N8_prodReg <= 32'h0;
      bench_N8_resultReg <= 8'h0;
      bench_N8_reqProdReg2 <= 64'h0;
      bench_N8_accumRequantReg <= 32'h0;
      bench_N8_signAReg <= 1'b0;
      bench_N8_absAReg <= 32'h0;
      bench_N8_pLL_Reg <= 32'h0;
      bench_N8_pLH_Reg <= 32'h0;
      bench_N8_pHL_Reg <= 32'h0;
      bench_N8_pHH_Reg <= 32'h0;
      bench_N8_pSumReg <= 33'h0;
      bench_N8_pLL_Reg2 <= 32'h0;
      bench_N8_pHH_Reg2 <= 32'h0;
      bench_N8_part1Reg <= 64'h0;
      bench_N8_part2Reg <= 64'h0;
      bench_N8_initAddrReg <= 8'h0;
      bench_N8_inAddrReg <= 8'h0;
      bench_N8_wAddrReg <= 10'h0;
      bench_N8_compCycleReg <= 5'h0;
      bench_N8_rowStepReg <= 3'b000;
      bench_N8_inValsReg_0 <= 8'h0;
      bench_N8_inValsReg_1 <= 8'h0;
      bench_N8_inValsReg_2 <= 8'h0;
      bench_N8_inValsReg_3 <= 8'h0;
      bench_N8_inValsReg_4 <= 8'h0;
      bench_N8_inValsReg_5 <= 8'h0;
      bench_N8_inValsReg_6 <= 8'h0;
      bench_N8_inValsReg_7 <= 8'h0;
      bench_N8_wValsReg_0 <= 8'h0;
      bench_N8_wValsReg_1 <= 8'h0;
      bench_N8_wValsReg_2 <= 8'h0;
      bench_N8_wValsReg_3 <= 8'h0;
      bench_N8_wValsReg_4 <= 8'h0;
      bench_N8_wValsReg_5 <= 8'h0;
      bench_N8_wValsReg_6 <= 8'h0;
      bench_N8_wValsReg_7 <= 8'h0;
      inStream_ready_regNext <= 1'b0;
      bench_N8_activationOut_valid_regNext <= 1'b0;
      bench_N8_activationOut_payload_value_regNext <= 8'h0;
    end else begin
      inValidR <= io_inValid;
      inValueR <= io_inValue;
      outReadyR <= io_outReady;
      if(when_QLinearConvCore_l331) begin
        if(when_QLinearConvCore_l333) begin
          bench_N8_initAddrReg <= 8'h0;
          bench_N8_stateReg <= bench_N8_sReceive;
        end else begin
          bench_N8_initAddrReg <= (bench_N8_initAddrReg + 8'h01);
        end
      end
      if(when_QLinearConvCore_l347) begin
        if(inStream_fire) begin
          bench_N8_rowElemReg <= (_zz_bench_N8_padWriteAddrReg ? 8'h0 : _zz_bench_N8_rowElemReg);
          bench_N8_padWriteAddrReg <= (bench_N8_padWriteAddrReg + (_zz_bench_N8_padWriteAddrReg ? 11'h021 : 11'h001));
          bench_N8_recvCntReg <= (bench_N8_recvCntReg + 11'h001);
          if(when_QLinearConvCore_l357) begin
            bench_N8_recvCntReg <= 11'h0;
            bench_N8_rowElemReg <= 8'h0;
            bench_N8_padWriteAddrReg <= 11'h0b0;
            bench_N8_outRowReg <= 4'b0000;
            bench_N8_outColReg <= 4'b0000;
            bench_N8_outChReg <= 6'h0;
            bench_N8_stateReg <= bench_N8_sLoadBias;
          end
        end
      end
      if(when_QLinearConvCore_l390) begin
        bench_N8_inAddrReg <= _zz_bench_N8_inAddrReg_1[7:0];
        bench_N8_wAddrReg <= _zz_bench_N8_wAddrReg[9:0];
        bench_N8_compCycleReg <= 5'h0;
        bench_N8_rowStepReg <= 3'b000;
        bench_N8_stateReg <= bench_N8_sWaitBias;
      end
      if(when_QLinearConvCore_l404) begin
        bench_N8_accumReg <= bench_N8_biasVal;
        bench_N8_stateReg <= bench_N8_sCompute;
      end
      if(when_QLinearConvCore_l412) begin
        bench_N8_compCycleReg <= (bench_N8_compCycleReg + 5'h01);
        if(when_QLinearConvCore_l416) begin
          bench_N8_wAddrReg <= (bench_N8_wAddrReg + 10'h001);
          bench_N8_inAddrReg <= (bench_N8_inAddrReg + (_zz_bench_N8_inAddrReg ? 8'h0f : 8'h01));
          bench_N8_rowStepReg <= (_zz_bench_N8_inAddrReg ? 3'b000 : _zz_bench_N8_rowStepReg);
        end
        if(when_QLinearConvCore_l429) begin
          bench_N8_inValsReg_0 <= bench_N8_inValsR_0;
          bench_N8_wValsReg_0 <= bench_N8_wValsR_0;
          bench_N8_inValsReg_1 <= bench_N8_inValsR_1;
          bench_N8_wValsReg_1 <= bench_N8_wValsR_1;
          bench_N8_inValsReg_2 <= bench_N8_inValsR_2;
          bench_N8_wValsReg_2 <= bench_N8_wValsR_2;
          bench_N8_inValsReg_3 <= bench_N8_inValsR_3;
          bench_N8_wValsReg_3 <= bench_N8_wValsR_3;
          bench_N8_inValsReg_4 <= bench_N8_inValsR_4;
          bench_N8_wValsReg_4 <= bench_N8_wValsR_4;
          bench_N8_inValsReg_5 <= bench_N8_inValsR_5;
          bench_N8_wValsReg_5 <= bench_N8_wValsR_5;
          bench_N8_inValsReg_6 <= bench_N8_inValsR_6;
          bench_N8_wValsReg_6 <= bench_N8_wValsR_6;
          bench_N8_inValsReg_7 <= bench_N8_inValsR_7;
          bench_N8_wValsReg_7 <= bench_N8_wValsR_7;
        end
        if(when_QLinearConvCore_l437) begin
          bench_N8_prodReg <= ($signed(_zz_bench_N8_prodReg) + $signed(_zz_bench_N8_prodReg_48));
        end
        if(when_QLinearConvCore_l448) begin
          bench_N8_accumReg <= _zz_bench_N8_accumReg;
          if(when_QLinearConvCore_l452) begin
            bench_N8_accumRequantReg <= _zz_bench_N8_accumReg;
            bench_N8_stateReg <= bench_N8_sRequant;
            bench_N8_compCycleReg <= 5'h0;
          end
        end
      end
      if(when_QLinearConvCore_l461) begin
        bench_N8_absAReg <= _zz_bench_N8_absAReg;
        bench_N8_signAReg <= ($signed(bench_N8_accumRequantReg) < $signed(32'h0));
        bench_N8_stateReg <= bench_N8_sRequantMul;
      end
      if(when_QLinearConvCore_l468) begin
        bench_N8_pLL_Reg <= (_zz_bench_N8_pLL_Reg * _zz_bench_N8_pLL_Reg_1);
        bench_N8_pLH_Reg <= (_zz_bench_N8_pLL_Reg * _zz_bench_N8_pLH_Reg);
        bench_N8_pHL_Reg <= (_zz_bench_N8_pHL_Reg * _zz_bench_N8_pLL_Reg_1);
        bench_N8_pHH_Reg <= (_zz_bench_N8_pHL_Reg * _zz_bench_N8_pLH_Reg);
        bench_N8_stateReg <= bench_N8_sRequantWait;
      end
      if(when_QLinearConvCore_l485) begin
        bench_N8_pSumReg <= (_zz_bench_N8_pSumReg + _zz_bench_N8_pSumReg_1);
        bench_N8_pLL_Reg2 <= bench_N8_pLL_Reg;
        bench_N8_pHH_Reg2 <= bench_N8_pHH_Reg;
        bench_N8_stateReg <= bench_N8_sRequantWait2;
      end
      if(when_QLinearConvCore_l493) begin
        bench_N8_part1Reg <= (_zz_bench_N8_part1Reg + _zz_bench_N8_part1Reg_1);
        bench_N8_part2Reg <= _zz_bench_N8_part2Reg[63:0];
        bench_N8_stateReg <= bench_N8_sRequantWait3;
      end
      if(when_QLinearConvCore_l500) begin
        bench_N8_reqProdReg2 <= (bench_N8_signAReg ? _zz_bench_N8_reqProdReg2_1 : _zz_bench_N8_reqProdReg2_3);
        bench_N8_stateReg <= bench_N8_sRequantShift;
      end
      if(when_QLinearConvCore_l508) begin
        bench_N8_resultReg <= (($signed(32'h0000007f) < $signed(_zz_bench_N8_resultReg)) ? 8'h7f : _zz_bench_N8_resultReg_1);
        bench_N8_stateReg <= bench_N8_sEmit;
      end
      if(when_QLinearConvCore_l519) begin
        if(bench_N8_activationOut_fire) begin
          bench_N8_outChReg <= (when_QLinearConvCore_l529 ? 6'h0 : _zz_bench_N8_outChReg);
          if(when_QLinearConvCore_l529) begin
            bench_N8_outColReg <= (when_QLinearConvCore_l531 ? 4'b0000 : _zz_bench_N8_outColReg);
            if(when_QLinearConvCore_l531) begin
              bench_N8_outRowReg <= (_zz_bench_N8_stateReg ? 4'b0000 : _zz_bench_N8_outRowReg);
            end
          end
          bench_N8_stateReg <= (((when_QLinearConvCore_l529 && when_QLinearConvCore_l531) && _zz_bench_N8_stateReg) ? bench_N8_sReceive : bench_N8_sLoadBias);
        end
      end
      inStream_ready_regNext <= inStream_ready;
      bench_N8_activationOut_valid_regNext <= bench_N8_activationOut_valid;
      bench_N8_activationOut_payload_value_regNext <= bench_N8_activationOut_payload_value;
    end
  end


endmodule
