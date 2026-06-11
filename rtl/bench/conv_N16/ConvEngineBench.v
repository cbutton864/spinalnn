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

  reg        [7:0]    bench_N16_inputBuf_0_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_1_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_2_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_3_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_4_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_5_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_6_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_7_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_8_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_9_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_10_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_11_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_12_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_13_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_14_spinal_port0;
  reg        [7:0]    bench_N16_inputBuf_15_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_0_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_1_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_2_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_3_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_4_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_5_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_6_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_7_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_8_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_9_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_10_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_11_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_12_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_13_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_14_spinal_port0;
  reg        [7:0]    bench_N16_weightRom_15_spinal_port0;
  reg        [31:0]   bench_N16_biasRom_spinal_port0;
  reg        [31:0]   bench_N16_reqMultRom_spinal_port0;
  reg        [7:0]    bench_N16_reqShiftRom_spinal_port0;
  wire                _zz_bench_N16_inputBuf_0_port;
  wire                _zz_bench_N16_inValsR_0_1;
  wire                _zz_bench_N16_inputBuf_1_port;
  wire                _zz_bench_N16_inValsR_1_1;
  wire                _zz_bench_N16_inputBuf_2_port;
  wire                _zz_bench_N16_inValsR_2_1;
  wire                _zz_bench_N16_inputBuf_3_port;
  wire                _zz_bench_N16_inValsR_3_1;
  wire                _zz_bench_N16_inputBuf_4_port;
  wire                _zz_bench_N16_inValsR_4_1;
  wire                _zz_bench_N16_inputBuf_5_port;
  wire                _zz_bench_N16_inValsR_5_1;
  wire                _zz_bench_N16_inputBuf_6_port;
  wire                _zz_bench_N16_inValsR_6_1;
  wire                _zz_bench_N16_inputBuf_7_port;
  wire                _zz_bench_N16_inValsR_7_1;
  wire                _zz_bench_N16_inputBuf_8_port;
  wire                _zz_bench_N16_inValsR_8_1;
  wire                _zz_bench_N16_inputBuf_9_port;
  wire                _zz_bench_N16_inValsR_9_1;
  wire                _zz_bench_N16_inputBuf_10_port;
  wire                _zz_bench_N16_inValsR_10_1;
  wire                _zz_bench_N16_inputBuf_11_port;
  wire                _zz_bench_N16_inValsR_11_1;
  wire                _zz_bench_N16_inputBuf_12_port;
  wire                _zz_bench_N16_inValsR_12_1;
  wire                _zz_bench_N16_inputBuf_13_port;
  wire                _zz_bench_N16_inValsR_13_1;
  wire                _zz_bench_N16_inputBuf_14_port;
  wire                _zz_bench_N16_inValsR_14_1;
  wire                _zz_bench_N16_inputBuf_15_port;
  wire                _zz_bench_N16_inValsR_15_1;
  wire                _zz_bench_N16_weightRom_0_port;
  wire                _zz_bench_N16_wValsR_0_1;
  wire                _zz_bench_N16_weightRom_1_port;
  wire                _zz_bench_N16_wValsR_1_1;
  wire                _zz_bench_N16_weightRom_2_port;
  wire                _zz_bench_N16_wValsR_2_1;
  wire                _zz_bench_N16_weightRom_3_port;
  wire                _zz_bench_N16_wValsR_3_1;
  wire                _zz_bench_N16_weightRom_4_port;
  wire                _zz_bench_N16_wValsR_4_1;
  wire                _zz_bench_N16_weightRom_5_port;
  wire                _zz_bench_N16_wValsR_5_1;
  wire                _zz_bench_N16_weightRom_6_port;
  wire                _zz_bench_N16_wValsR_6_1;
  wire                _zz_bench_N16_weightRom_7_port;
  wire                _zz_bench_N16_wValsR_7_1;
  wire                _zz_bench_N16_weightRom_8_port;
  wire                _zz_bench_N16_wValsR_8_1;
  wire                _zz_bench_N16_weightRom_9_port;
  wire                _zz_bench_N16_wValsR_9_1;
  wire                _zz_bench_N16_weightRom_10_port;
  wire                _zz_bench_N16_wValsR_10_1;
  wire                _zz_bench_N16_weightRom_11_port;
  wire                _zz_bench_N16_wValsR_11_1;
  wire                _zz_bench_N16_weightRom_12_port;
  wire                _zz_bench_N16_wValsR_12_1;
  wire                _zz_bench_N16_weightRom_13_port;
  wire                _zz_bench_N16_wValsR_13_1;
  wire                _zz_bench_N16_weightRom_14_port;
  wire                _zz_bench_N16_wValsR_14_1;
  wire                _zz_bench_N16_weightRom_15_port;
  wire                _zz_bench_N16_wValsR_15_1;
  wire       [4:0]    _zz_bench_N16_biasRom_port;
  wire                _zz_bench_N16_biasRom_port_1;
  wire       [4:0]    _zz_bench_N16_biasVal_1;
  wire                _zz_bench_N16_biasVal_2;
  wire       [4:0]    _zz_bench_N16_reqMultRom_port;
  wire                _zz_bench_N16_reqMultRom_port_1;
  wire       [4:0]    _zz_bench_N16_reqMultVal_1;
  wire                _zz_bench_N16_reqMultVal_2;
  wire       [4:0]    _zz_bench_N16_reqShiftRom_port;
  wire                _zz_bench_N16_reqShiftRom_port_1;
  wire       [4:0]    _zz_bench_N16_reqShiftVal_1;
  wire                _zz_bench_N16_reqShiftVal_2;
  wire       [6:0]    _zz_bench_N16_inputBuf_0_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_0_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_0_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_0_port_4;
  wire                _zz_bench_N16_inputBuf_0_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_1_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_1_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_1_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_1_port_4;
  wire                _zz_bench_N16_inputBuf_1_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_2_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_2_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_2_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_2_port_4;
  wire                _zz_bench_N16_inputBuf_2_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_3_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_3_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_3_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_3_port_4;
  wire                _zz_bench_N16_inputBuf_3_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_4_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_4_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_4_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_4_port_4;
  wire                _zz_bench_N16_inputBuf_4_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_5_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_5_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_5_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_5_port_4;
  wire                _zz_bench_N16_inputBuf_5_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_6_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_6_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_6_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_6_port_4;
  wire                _zz_bench_N16_inputBuf_6_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_7_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_7_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_7_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_7_port_4;
  wire                _zz_bench_N16_inputBuf_7_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_8_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_8_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_8_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_8_port_4;
  wire                _zz_bench_N16_inputBuf_8_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_9_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_9_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_9_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_9_port_4;
  wire                _zz_bench_N16_inputBuf_9_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_10_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_10_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_10_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_10_port_4;
  wire                _zz_bench_N16_inputBuf_10_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_11_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_11_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_11_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_11_port_4;
  wire                _zz_bench_N16_inputBuf_11_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_12_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_12_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_12_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_12_port_4;
  wire                _zz_bench_N16_inputBuf_12_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_13_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_13_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_13_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_13_port_4;
  wire                _zz_bench_N16_inputBuf_13_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_14_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_14_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_14_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_14_port_4;
  wire                _zz_bench_N16_inputBuf_14_port_5;
  wire       [6:0]    _zz_bench_N16_inputBuf_15_port_1;
  wire       [6:0]    _zz_bench_N16_inputBuf_15_port_2;
  wire       [7:0]    _zz_bench_N16_inputBuf_15_port_3;
  wire       [7:0]    _zz_bench_N16_inputBuf_15_port_4;
  wire                _zz_bench_N16_inputBuf_15_port_5;
  wire       [7:0]    _zz_bench_N16_rowElemReg;
  wire       [8:0]    _zz_bench_N16_inAddrReg_1;
  wire       [8:0]    _zz_bench_N16_inAddrReg_2;
  wire       [8:0]    _zz_bench_N16_inAddrReg_3;
  wire       [4:0]    _zz_bench_N16_inAddrReg_4;
  wire       [8:0]    _zz_bench_N16_inAddrReg_5;
  wire       [5:0]    _zz_bench_N16_inAddrReg_6;
  wire       [4:0]    _zz_bench_N16_inAddrReg_7;
  wire       [8:0]    _zz_bench_N16_inAddrReg_8;
  wire       [0:0]    _zz_bench_N16_inAddrReg_9;
  wire       [9:0]    _zz_bench_N16_wAddrReg;
  wire       [9:0]    _zz_bench_N16_wAddrReg_1;
  wire       [9:0]    _zz_bench_N16_wAddrReg_2;
  wire       [9:0]    _zz_bench_N16_wAddrReg_3;
  wire       [9:0]    _zz_bench_N16_wAddrReg_4;
  wire       [1:0]    _zz_bench_N16_wAddrReg_5;
  wire       [9:0]    _zz_bench_N16_wAddrReg_6;
  wire       [0:0]    _zz_bench_N16_wAddrReg_7;
  wire       [9:0]    _zz_bench_N16_wAddrReg_8;
  wire       [0:0]    _zz_bench_N16_wAddrReg_9;
  wire       [1:0]    _zz_bench_N16_rowStepReg;
  wire       [31:0]   _zz_bench_N16_prodReg;
  wire       [31:0]   _zz_bench_N16_prodReg_1;
  wire       [31:0]   _zz_bench_N16_prodReg_2;
  wire       [31:0]   _zz_bench_N16_prodReg_3;
  wire       [31:0]   _zz_bench_N16_prodReg_4;
  wire       [31:0]   _zz_bench_N16_prodReg_5;
  wire       [31:0]   _zz_bench_N16_prodReg_6;
  wire       [31:0]   _zz_bench_N16_prodReg_7;
  wire       [31:0]   _zz_bench_N16_prodReg_8;
  wire       [31:0]   _zz_bench_N16_prodReg_9;
  wire       [31:0]   _zz_bench_N16_prodReg_10;
  wire       [31:0]   _zz_bench_N16_prodReg_11;
  wire       [31:0]   _zz_bench_N16_prodReg_12;
  wire       [31:0]   _zz_bench_N16_prodReg_13;
  wire       [31:0]   _zz_bench_N16_prodReg_14;
  wire       [17:0]   _zz_bench_N16_prodReg_15;
  wire       [8:0]    _zz_bench_N16_prodReg_16;
  wire       [8:0]    _zz_bench_N16_prodReg_17;
  wire       [8:0]    _zz_bench_N16_prodReg_18;
  wire       [8:0]    _zz_bench_N16_prodReg_19;
  wire       [31:0]   _zz_bench_N16_prodReg_20;
  wire       [17:0]   _zz_bench_N16_prodReg_21;
  wire       [8:0]    _zz_bench_N16_prodReg_22;
  wire       [8:0]    _zz_bench_N16_prodReg_23;
  wire       [8:0]    _zz_bench_N16_prodReg_24;
  wire       [8:0]    _zz_bench_N16_prodReg_25;
  wire       [31:0]   _zz_bench_N16_prodReg_26;
  wire       [17:0]   _zz_bench_N16_prodReg_27;
  wire       [8:0]    _zz_bench_N16_prodReg_28;
  wire       [8:0]    _zz_bench_N16_prodReg_29;
  wire       [8:0]    _zz_bench_N16_prodReg_30;
  wire       [8:0]    _zz_bench_N16_prodReg_31;
  wire       [31:0]   _zz_bench_N16_prodReg_32;
  wire       [17:0]   _zz_bench_N16_prodReg_33;
  wire       [8:0]    _zz_bench_N16_prodReg_34;
  wire       [8:0]    _zz_bench_N16_prodReg_35;
  wire       [8:0]    _zz_bench_N16_prodReg_36;
  wire       [8:0]    _zz_bench_N16_prodReg_37;
  wire       [31:0]   _zz_bench_N16_prodReg_38;
  wire       [17:0]   _zz_bench_N16_prodReg_39;
  wire       [8:0]    _zz_bench_N16_prodReg_40;
  wire       [8:0]    _zz_bench_N16_prodReg_41;
  wire       [8:0]    _zz_bench_N16_prodReg_42;
  wire       [8:0]    _zz_bench_N16_prodReg_43;
  wire       [31:0]   _zz_bench_N16_prodReg_44;
  wire       [17:0]   _zz_bench_N16_prodReg_45;
  wire       [8:0]    _zz_bench_N16_prodReg_46;
  wire       [8:0]    _zz_bench_N16_prodReg_47;
  wire       [8:0]    _zz_bench_N16_prodReg_48;
  wire       [8:0]    _zz_bench_N16_prodReg_49;
  wire       [31:0]   _zz_bench_N16_prodReg_50;
  wire       [17:0]   _zz_bench_N16_prodReg_51;
  wire       [8:0]    _zz_bench_N16_prodReg_52;
  wire       [8:0]    _zz_bench_N16_prodReg_53;
  wire       [8:0]    _zz_bench_N16_prodReg_54;
  wire       [8:0]    _zz_bench_N16_prodReg_55;
  wire       [31:0]   _zz_bench_N16_prodReg_56;
  wire       [17:0]   _zz_bench_N16_prodReg_57;
  wire       [8:0]    _zz_bench_N16_prodReg_58;
  wire       [8:0]    _zz_bench_N16_prodReg_59;
  wire       [8:0]    _zz_bench_N16_prodReg_60;
  wire       [8:0]    _zz_bench_N16_prodReg_61;
  wire       [31:0]   _zz_bench_N16_prodReg_62;
  wire       [17:0]   _zz_bench_N16_prodReg_63;
  wire       [8:0]    _zz_bench_N16_prodReg_64;
  wire       [8:0]    _zz_bench_N16_prodReg_65;
  wire       [8:0]    _zz_bench_N16_prodReg_66;
  wire       [8:0]    _zz_bench_N16_prodReg_67;
  wire       [31:0]   _zz_bench_N16_prodReg_68;
  wire       [17:0]   _zz_bench_N16_prodReg_69;
  wire       [8:0]    _zz_bench_N16_prodReg_70;
  wire       [8:0]    _zz_bench_N16_prodReg_71;
  wire       [8:0]    _zz_bench_N16_prodReg_72;
  wire       [8:0]    _zz_bench_N16_prodReg_73;
  wire       [31:0]   _zz_bench_N16_prodReg_74;
  wire       [17:0]   _zz_bench_N16_prodReg_75;
  wire       [8:0]    _zz_bench_N16_prodReg_76;
  wire       [8:0]    _zz_bench_N16_prodReg_77;
  wire       [8:0]    _zz_bench_N16_prodReg_78;
  wire       [8:0]    _zz_bench_N16_prodReg_79;
  wire       [31:0]   _zz_bench_N16_prodReg_80;
  wire       [17:0]   _zz_bench_N16_prodReg_81;
  wire       [8:0]    _zz_bench_N16_prodReg_82;
  wire       [8:0]    _zz_bench_N16_prodReg_83;
  wire       [8:0]    _zz_bench_N16_prodReg_84;
  wire       [8:0]    _zz_bench_N16_prodReg_85;
  wire       [31:0]   _zz_bench_N16_prodReg_86;
  wire       [17:0]   _zz_bench_N16_prodReg_87;
  wire       [8:0]    _zz_bench_N16_prodReg_88;
  wire       [8:0]    _zz_bench_N16_prodReg_89;
  wire       [8:0]    _zz_bench_N16_prodReg_90;
  wire       [8:0]    _zz_bench_N16_prodReg_91;
  wire       [31:0]   _zz_bench_N16_prodReg_92;
  wire       [17:0]   _zz_bench_N16_prodReg_93;
  wire       [8:0]    _zz_bench_N16_prodReg_94;
  wire       [8:0]    _zz_bench_N16_prodReg_95;
  wire       [8:0]    _zz_bench_N16_prodReg_96;
  wire       [8:0]    _zz_bench_N16_prodReg_97;
  wire       [31:0]   _zz_bench_N16_prodReg_98;
  wire       [17:0]   _zz_bench_N16_prodReg_99;
  wire       [8:0]    _zz_bench_N16_prodReg_100;
  wire       [8:0]    _zz_bench_N16_prodReg_101;
  wire       [8:0]    _zz_bench_N16_prodReg_102;
  wire       [8:0]    _zz_bench_N16_prodReg_103;
  wire       [31:0]   _zz_bench_N16_prodReg_104;
  wire       [17:0]   _zz_bench_N16_prodReg_105;
  wire       [8:0]    _zz_bench_N16_prodReg_106;
  wire       [8:0]    _zz_bench_N16_prodReg_107;
  wire       [8:0]    _zz_bench_N16_prodReg_108;
  wire       [8:0]    _zz_bench_N16_prodReg_109;
  wire       [31:0]   _zz_bench_N16_absAReg;
  wire       [31:0]   _zz_bench_N16_absAReg_1;
  wire       [32:0]   _zz_bench_N16_pSumReg;
  wire       [32:0]   _zz_bench_N16_pSumReg_1;
  wire       [63:0]   _zz_bench_N16_part1Reg;
  wire       [63:0]   _zz_bench_N16_part1Reg_1;
  wire       [79:0]   _zz_bench_N16_part1Reg_2;
  wire       [63:0]   _zz_bench_N16_part1Reg_3;
  wire       [95:0]   _zz_bench_N16_part2Reg;
  wire       [63:0]   _zz_bench_N16_part2Reg_1;
  wire       [63:0]   _zz_bench_N16_reqProdReg2_1;
  wire       [63:0]   _zz_bench_N16_reqProdReg2_2;
  wire       [63:0]   _zz_bench_N16_reqProdReg2_3;
  wire       [31:0]   _zz__zz_bench_N16_resultReg;
  wire       [63:0]   _zz__zz_bench_N16_resultReg_1;
  wire       [7:0]    _zz_bench_N16_resultReg_1;
  wire       [7:0]    _zz_bench_N16_resultReg_2;
  wire       [5:0]    _zz_bench_N16_outChReg;
  wire       [3:0]    _zz_bench_N16_outColReg;
  wire       [3:0]    _zz_bench_N16_outRowReg;
  reg                 inValidR;
  reg        [7:0]    inValueR;
  reg                 outReadyR;
  wire                inStream_valid;
  reg                 inStream_ready;
  wire       [7:0]    inStream_payload_value;
  reg                 bench_N16_activationOut_valid;
  wire                bench_N16_activationOut_ready;
  reg        [7:0]    bench_N16_activationOut_payload_value;
  wire       [3:0]    bench_N16_sReceive;
  wire       [3:0]    bench_N16_sLoadBias;
  wire       [3:0]    bench_N16_sCompute;
  wire       [3:0]    bench_N16_sRequant;
  wire       [3:0]    bench_N16_sRequantMul;
  wire       [3:0]    bench_N16_sRequantWait;
  wire       [3:0]    bench_N16_sRequantWait2;
  wire       [3:0]    bench_N16_sRequantWait3;
  wire       [3:0]    bench_N16_sRequantShift;
  wire       [3:0]    bench_N16_sEmit;
  wire       [3:0]    bench_N16_sInit;
  wire       [3:0]    bench_N16_sWaitBias;
  wire       [3:0]    bench_N16_sLoadWeights;
  reg        [3:0]    bench_N16_stateReg;
  reg        [10:0]   bench_N16_recvCntReg;
  reg        [10:0]   bench_N16_padWriteAddrReg;
  reg        [7:0]    bench_N16_rowElemReg;
  reg        [3:0]    bench_N16_outRowReg;
  reg        [3:0]    bench_N16_outColReg;
  reg        [5:0]    bench_N16_outChReg;
  reg        [31:0]   bench_N16_accumReg;
  reg        [31:0]   bench_N16_prodReg;
  reg        [7:0]    bench_N16_resultReg;
  wire       [63:0]   bench_N16_reqProdReg1;
  reg        [63:0]   bench_N16_reqProdReg2;
  reg        [31:0]   bench_N16_accumRequantReg;
  reg                 bench_N16_signAReg;
  reg        [31:0]   bench_N16_absAReg;
  reg        [31:0]   bench_N16_pLL_Reg;
  reg        [31:0]   bench_N16_pLH_Reg;
  reg        [31:0]   bench_N16_pHL_Reg;
  reg        [31:0]   bench_N16_pHH_Reg;
  reg        [32:0]   bench_N16_pSumReg;
  reg        [31:0]   bench_N16_pLL_Reg2;
  reg        [31:0]   bench_N16_pHH_Reg2;
  reg        [63:0]   bench_N16_part1Reg;
  reg        [63:0]   bench_N16_part2Reg;
  reg        [6:0]    bench_N16_initAddrReg;
  reg        [6:0]    bench_N16_inAddrReg;
  reg        [8:0]    bench_N16_wAddrReg;
  reg        [3:0]    bench_N16_compCycleReg;
  reg        [1:0]    bench_N16_rowStepReg;
  reg        [6:0]    bench_N16_inAddrComb;
  reg        [8:0]    bench_N16_wAddrComb;
  wire       [6:0]    _zz_bench_N16_inValsR_0;
  wire       [7:0]    bench_N16_inValsR_0;
  wire       [6:0]    _zz_bench_N16_inValsR_1;
  wire       [7:0]    bench_N16_inValsR_1;
  wire       [6:0]    _zz_bench_N16_inValsR_2;
  wire       [7:0]    bench_N16_inValsR_2;
  wire       [6:0]    _zz_bench_N16_inValsR_3;
  wire       [7:0]    bench_N16_inValsR_3;
  wire       [6:0]    _zz_bench_N16_inValsR_4;
  wire       [7:0]    bench_N16_inValsR_4;
  wire       [6:0]    _zz_bench_N16_inValsR_5;
  wire       [7:0]    bench_N16_inValsR_5;
  wire       [6:0]    _zz_bench_N16_inValsR_6;
  wire       [7:0]    bench_N16_inValsR_6;
  wire       [6:0]    _zz_bench_N16_inValsR_7;
  wire       [7:0]    bench_N16_inValsR_7;
  wire       [6:0]    _zz_bench_N16_inValsR_8;
  wire       [7:0]    bench_N16_inValsR_8;
  wire       [6:0]    _zz_bench_N16_inValsR_9;
  wire       [7:0]    bench_N16_inValsR_9;
  wire       [6:0]    _zz_bench_N16_inValsR_10;
  wire       [7:0]    bench_N16_inValsR_10;
  wire       [6:0]    _zz_bench_N16_inValsR_11;
  wire       [7:0]    bench_N16_inValsR_11;
  wire       [6:0]    _zz_bench_N16_inValsR_12;
  wire       [7:0]    bench_N16_inValsR_12;
  wire       [6:0]    _zz_bench_N16_inValsR_13;
  wire       [7:0]    bench_N16_inValsR_13;
  wire       [6:0]    _zz_bench_N16_inValsR_14;
  wire       [7:0]    bench_N16_inValsR_14;
  wire       [6:0]    _zz_bench_N16_inValsR_15;
  wire       [7:0]    bench_N16_inValsR_15;
  wire       [8:0]    _zz_bench_N16_wValsR_0;
  wire       [7:0]    bench_N16_wValsR_0;
  wire       [8:0]    _zz_bench_N16_wValsR_1;
  wire       [7:0]    bench_N16_wValsR_1;
  wire       [8:0]    _zz_bench_N16_wValsR_2;
  wire       [7:0]    bench_N16_wValsR_2;
  wire       [8:0]    _zz_bench_N16_wValsR_3;
  wire       [7:0]    bench_N16_wValsR_3;
  wire       [8:0]    _zz_bench_N16_wValsR_4;
  wire       [7:0]    bench_N16_wValsR_4;
  wire       [8:0]    _zz_bench_N16_wValsR_5;
  wire       [7:0]    bench_N16_wValsR_5;
  wire       [8:0]    _zz_bench_N16_wValsR_6;
  wire       [7:0]    bench_N16_wValsR_6;
  wire       [8:0]    _zz_bench_N16_wValsR_7;
  wire       [7:0]    bench_N16_wValsR_7;
  wire       [8:0]    _zz_bench_N16_wValsR_8;
  wire       [7:0]    bench_N16_wValsR_8;
  wire       [8:0]    _zz_bench_N16_wValsR_9;
  wire       [7:0]    bench_N16_wValsR_9;
  wire       [8:0]    _zz_bench_N16_wValsR_10;
  wire       [7:0]    bench_N16_wValsR_10;
  wire       [8:0]    _zz_bench_N16_wValsR_11;
  wire       [7:0]    bench_N16_wValsR_11;
  wire       [8:0]    _zz_bench_N16_wValsR_12;
  wire       [7:0]    bench_N16_wValsR_12;
  wire       [8:0]    _zz_bench_N16_wValsR_13;
  wire       [7:0]    bench_N16_wValsR_13;
  wire       [8:0]    _zz_bench_N16_wValsR_14;
  wire       [7:0]    bench_N16_wValsR_14;
  wire       [8:0]    _zz_bench_N16_wValsR_15;
  wire       [7:0]    bench_N16_wValsR_15;
  wire       [5:0]    _zz_bench_N16_biasVal;
  wire       [31:0]   bench_N16_biasVal;
  wire       [5:0]    _zz_bench_N16_reqMultVal;
  wire       [31:0]   bench_N16_reqMultVal;
  wire       [5:0]    _zz_bench_N16_reqShiftVal;
  wire       [7:0]    bench_N16_reqShiftVal;
  reg        [7:0]    bench_N16_inValsReg_0;
  reg        [7:0]    bench_N16_inValsReg_1;
  reg        [7:0]    bench_N16_inValsReg_2;
  reg        [7:0]    bench_N16_inValsReg_3;
  reg        [7:0]    bench_N16_inValsReg_4;
  reg        [7:0]    bench_N16_inValsReg_5;
  reg        [7:0]    bench_N16_inValsReg_6;
  reg        [7:0]    bench_N16_inValsReg_7;
  reg        [7:0]    bench_N16_inValsReg_8;
  reg        [7:0]    bench_N16_inValsReg_9;
  reg        [7:0]    bench_N16_inValsReg_10;
  reg        [7:0]    bench_N16_inValsReg_11;
  reg        [7:0]    bench_N16_inValsReg_12;
  reg        [7:0]    bench_N16_inValsReg_13;
  reg        [7:0]    bench_N16_inValsReg_14;
  reg        [7:0]    bench_N16_inValsReg_15;
  reg        [7:0]    bench_N16_wValsReg_0;
  reg        [7:0]    bench_N16_wValsReg_1;
  reg        [7:0]    bench_N16_wValsReg_2;
  reg        [7:0]    bench_N16_wValsReg_3;
  reg        [7:0]    bench_N16_wValsReg_4;
  reg        [7:0]    bench_N16_wValsReg_5;
  reg        [7:0]    bench_N16_wValsReg_6;
  reg        [7:0]    bench_N16_wValsReg_7;
  reg        [7:0]    bench_N16_wValsReg_8;
  reg        [7:0]    bench_N16_wValsReg_9;
  reg        [7:0]    bench_N16_wValsReg_10;
  reg        [7:0]    bench_N16_wValsReg_11;
  reg        [7:0]    bench_N16_wValsReg_12;
  reg        [7:0]    bench_N16_wValsReg_13;
  reg        [7:0]    bench_N16_wValsReg_14;
  reg        [7:0]    bench_N16_wValsReg_15;
  wire                _zz_36;
  wire                inStream_fire;
  wire                _zz_38;
  wire                _zz_40;
  wire                _zz_42;
  wire                _zz_44;
  wire                _zz_46;
  wire                _zz_48;
  wire                _zz_50;
  wire                _zz_52;
  wire                _zz_54;
  wire                _zz_56;
  wire                _zz_58;
  wire                _zz_60;
  wire                _zz_62;
  wire                _zz_64;
  wire                _zz_66;
  wire                when_QLinearConvCore_l331;
  wire                when_QLinearConvCore_l333;
  wire                when_QLinearConvCore_l347;
  wire                _zz_bench_N16_padWriteAddrReg;
  wire                when_QLinearConvCore_l357;
  wire                when_QLinearConvCore_l390;
  wire                when_QLinearConvCore_l404;
  wire                when_QLinearConvCore_l412;
  wire                when_QLinearConvCore_l416;
  wire                _zz_bench_N16_inAddrReg;
  wire                when_QLinearConvCore_l429;
  wire                when_QLinearConvCore_l437;
  wire                when_QLinearConvCore_l448;
  wire       [31:0]   _zz_bench_N16_accumReg;
  wire                when_QLinearConvCore_l452;
  wire                when_QLinearConvCore_l461;
  wire                when_QLinearConvCore_l468;
  wire       [15:0]   _zz_bench_N16_pHL_Reg;
  wire       [15:0]   _zz_bench_N16_pLL_Reg;
  wire       [15:0]   _zz_bench_N16_pLH_Reg;
  wire       [15:0]   _zz_bench_N16_pLL_Reg_1;
  wire                when_QLinearConvCore_l485;
  wire                when_QLinearConvCore_l493;
  wire                when_QLinearConvCore_l500;
  wire       [63:0]   _zz_bench_N16_reqProdReg2;
  wire                when_QLinearConvCore_l508;
  wire       [31:0]   _zz_bench_N16_resultReg;
  wire                when_QLinearConvCore_l519;
  wire                bench_N16_activationOut_fire;
  wire                when_QLinearConvCore_l529;
  wire                when_QLinearConvCore_l531;
  wire                _zz_bench_N16_stateReg;
  reg                 inStream_ready_regNext;
  reg                 bench_N16_activationOut_valid_regNext;
  reg        [7:0]    bench_N16_activationOut_payload_value_regNext;
  reg [7:0] bench_N16_inputBuf_0 [0:99];
  reg [7:0] bench_N16_inputBuf_1 [0:99];
  reg [7:0] bench_N16_inputBuf_2 [0:99];
  reg [7:0] bench_N16_inputBuf_3 [0:99];
  reg [7:0] bench_N16_inputBuf_4 [0:99];
  reg [7:0] bench_N16_inputBuf_5 [0:99];
  reg [7:0] bench_N16_inputBuf_6 [0:99];
  reg [7:0] bench_N16_inputBuf_7 [0:99];
  reg [7:0] bench_N16_inputBuf_8 [0:99];
  reg [7:0] bench_N16_inputBuf_9 [0:99];
  reg [7:0] bench_N16_inputBuf_10 [0:99];
  reg [7:0] bench_N16_inputBuf_11 [0:99];
  reg [7:0] bench_N16_inputBuf_12 [0:99];
  reg [7:0] bench_N16_inputBuf_13 [0:99];
  reg [7:0] bench_N16_inputBuf_14 [0:99];
  reg [7:0] bench_N16_inputBuf_15 [0:99];
  reg [7:0] bench_N16_weightRom_0 [0:287];
  reg [7:0] bench_N16_weightRom_1 [0:287];
  reg [7:0] bench_N16_weightRom_2 [0:287];
  reg [7:0] bench_N16_weightRom_3 [0:287];
  reg [7:0] bench_N16_weightRom_4 [0:287];
  reg [7:0] bench_N16_weightRom_5 [0:287];
  reg [7:0] bench_N16_weightRom_6 [0:287];
  reg [7:0] bench_N16_weightRom_7 [0:287];
  reg [7:0] bench_N16_weightRom_8 [0:287];
  reg [7:0] bench_N16_weightRom_9 [0:287];
  reg [7:0] bench_N16_weightRom_10 [0:287];
  reg [7:0] bench_N16_weightRom_11 [0:287];
  reg [7:0] bench_N16_weightRom_12 [0:287];
  reg [7:0] bench_N16_weightRom_13 [0:287];
  reg [7:0] bench_N16_weightRom_14 [0:287];
  reg [7:0] bench_N16_weightRom_15 [0:287];
  reg [31:0] bench_N16_biasRom [0:31];
  reg [31:0] bench_N16_reqMultRom [0:31];
  reg [7:0] bench_N16_reqShiftRom [0:31];

  assign _zz_bench_N16_biasVal_1 = _zz_bench_N16_biasVal[4:0];
  assign _zz_bench_N16_reqMultVal_1 = _zz_bench_N16_reqMultVal[4:0];
  assign _zz_bench_N16_reqShiftVal_1 = _zz_bench_N16_reqShiftVal[4:0];
  assign _zz_bench_N16_inputBuf_0_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_0_port_4 = (_zz_36 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_1_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_1_port_4 = (_zz_38 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_2_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_2_port_4 = (_zz_40 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_3_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_3_port_4 = (_zz_42 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_4_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_4_port_4 = (_zz_44 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_5_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_5_port_4 = (_zz_46 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_6_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_6_port_4 = (_zz_48 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_7_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_7_port_4 = (_zz_50 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_8_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_8_port_4 = (_zz_52 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_9_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_9_port_4 = (_zz_54 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_10_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_10_port_4 = (_zz_56 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_11_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_11_port_4 = (_zz_58 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_12_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_12_port_4 = (_zz_60 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_13_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_13_port_4 = (_zz_62 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_14_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_14_port_4 = (_zz_64 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_inputBuf_15_port_2 = (bench_N16_padWriteAddrReg >>> 3'd4);
  assign _zz_bench_N16_inputBuf_15_port_4 = (_zz_66 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N16_rowElemReg = (bench_N16_rowElemReg + 8'h01);
  assign _zz_bench_N16_inAddrReg_1 = (_zz_bench_N16_inAddrReg_2 + _zz_bench_N16_inAddrReg_8);
  assign _zz_bench_N16_inAddrReg_2 = (_zz_bench_N16_inAddrReg_3 + _zz_bench_N16_inAddrReg_5);
  assign _zz_bench_N16_inAddrReg_3 = (_zz_bench_N16_inAddrReg_4 * 4'b1010);
  assign _zz_bench_N16_inAddrReg_4 = (bench_N16_outRowReg * 1'b1);
  assign _zz_bench_N16_inAddrReg_6 = (_zz_bench_N16_inAddrReg_7 * 1'b1);
  assign _zz_bench_N16_inAddrReg_5 = {3'd0, _zz_bench_N16_inAddrReg_6};
  assign _zz_bench_N16_inAddrReg_7 = (bench_N16_outColReg * 1'b1);
  assign _zz_bench_N16_inAddrReg_9 = 1'b0;
  assign _zz_bench_N16_inAddrReg_8 = {8'd0, _zz_bench_N16_inAddrReg_9};
  assign _zz_bench_N16_wAddrReg = (_zz_bench_N16_wAddrReg_1 + _zz_bench_N16_wAddrReg_8);
  assign _zz_bench_N16_wAddrReg_1 = (_zz_bench_N16_wAddrReg_2 + _zz_bench_N16_wAddrReg_6);
  assign _zz_bench_N16_wAddrReg_2 = (_zz_bench_N16_wAddrReg_3 + _zz_bench_N16_wAddrReg_4);
  assign _zz_bench_N16_wAddrReg_3 = (bench_N16_outChReg * 4'b1001);
  assign _zz_bench_N16_wAddrReg_5 = 2'b00;
  assign _zz_bench_N16_wAddrReg_4 = {8'd0, _zz_bench_N16_wAddrReg_5};
  assign _zz_bench_N16_wAddrReg_7 = 1'b0;
  assign _zz_bench_N16_wAddrReg_6 = {9'd0, _zz_bench_N16_wAddrReg_7};
  assign _zz_bench_N16_wAddrReg_9 = 1'b0;
  assign _zz_bench_N16_wAddrReg_8 = {9'd0, _zz_bench_N16_wAddrReg_9};
  assign _zz_bench_N16_rowStepReg = (bench_N16_rowStepReg + 2'b01);
  assign _zz_bench_N16_prodReg = ($signed(_zz_bench_N16_prodReg_1) + $signed(_zz_bench_N16_prodReg_98));
  assign _zz_bench_N16_prodReg_1 = ($signed(_zz_bench_N16_prodReg_2) + $signed(_zz_bench_N16_prodReg_92));
  assign _zz_bench_N16_prodReg_2 = ($signed(_zz_bench_N16_prodReg_3) + $signed(_zz_bench_N16_prodReg_86));
  assign _zz_bench_N16_prodReg_3 = ($signed(_zz_bench_N16_prodReg_4) + $signed(_zz_bench_N16_prodReg_80));
  assign _zz_bench_N16_prodReg_4 = ($signed(_zz_bench_N16_prodReg_5) + $signed(_zz_bench_N16_prodReg_74));
  assign _zz_bench_N16_prodReg_5 = ($signed(_zz_bench_N16_prodReg_6) + $signed(_zz_bench_N16_prodReg_68));
  assign _zz_bench_N16_prodReg_6 = ($signed(_zz_bench_N16_prodReg_7) + $signed(_zz_bench_N16_prodReg_62));
  assign _zz_bench_N16_prodReg_7 = ($signed(_zz_bench_N16_prodReg_8) + $signed(_zz_bench_N16_prodReg_56));
  assign _zz_bench_N16_prodReg_8 = ($signed(_zz_bench_N16_prodReg_9) + $signed(_zz_bench_N16_prodReg_50));
  assign _zz_bench_N16_prodReg_9 = ($signed(_zz_bench_N16_prodReg_10) + $signed(_zz_bench_N16_prodReg_44));
  assign _zz_bench_N16_prodReg_10 = ($signed(_zz_bench_N16_prodReg_11) + $signed(_zz_bench_N16_prodReg_38));
  assign _zz_bench_N16_prodReg_11 = ($signed(_zz_bench_N16_prodReg_12) + $signed(_zz_bench_N16_prodReg_32));
  assign _zz_bench_N16_prodReg_12 = ($signed(_zz_bench_N16_prodReg_13) + $signed(_zz_bench_N16_prodReg_26));
  assign _zz_bench_N16_prodReg_13 = ($signed(_zz_bench_N16_prodReg_14) + $signed(_zz_bench_N16_prodReg_20));
  assign _zz_bench_N16_prodReg_15 = ($signed(_zz_bench_N16_prodReg_16) * $signed(_zz_bench_N16_prodReg_18));
  assign _zz_bench_N16_prodReg_14 = {{14{_zz_bench_N16_prodReg_15[17]}}, _zz_bench_N16_prodReg_15};
  assign _zz_bench_N16_prodReg_16 = ($signed(_zz_bench_N16_prodReg_17) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_17 = {{1{bench_N16_inValsReg_0[7]}}, bench_N16_inValsReg_0};
  assign _zz_bench_N16_prodReg_18 = ($signed(_zz_bench_N16_prodReg_19) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_19 = {{1{bench_N16_wValsReg_0[7]}}, bench_N16_wValsReg_0};
  assign _zz_bench_N16_prodReg_21 = ($signed(_zz_bench_N16_prodReg_22) * $signed(_zz_bench_N16_prodReg_24));
  assign _zz_bench_N16_prodReg_20 = {{14{_zz_bench_N16_prodReg_21[17]}}, _zz_bench_N16_prodReg_21};
  assign _zz_bench_N16_prodReg_22 = ($signed(_zz_bench_N16_prodReg_23) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_23 = {{1{bench_N16_inValsReg_1[7]}}, bench_N16_inValsReg_1};
  assign _zz_bench_N16_prodReg_24 = ($signed(_zz_bench_N16_prodReg_25) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_25 = {{1{bench_N16_wValsReg_1[7]}}, bench_N16_wValsReg_1};
  assign _zz_bench_N16_prodReg_27 = ($signed(_zz_bench_N16_prodReg_28) * $signed(_zz_bench_N16_prodReg_30));
  assign _zz_bench_N16_prodReg_26 = {{14{_zz_bench_N16_prodReg_27[17]}}, _zz_bench_N16_prodReg_27};
  assign _zz_bench_N16_prodReg_28 = ($signed(_zz_bench_N16_prodReg_29) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_29 = {{1{bench_N16_inValsReg_2[7]}}, bench_N16_inValsReg_2};
  assign _zz_bench_N16_prodReg_30 = ($signed(_zz_bench_N16_prodReg_31) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_31 = {{1{bench_N16_wValsReg_2[7]}}, bench_N16_wValsReg_2};
  assign _zz_bench_N16_prodReg_33 = ($signed(_zz_bench_N16_prodReg_34) * $signed(_zz_bench_N16_prodReg_36));
  assign _zz_bench_N16_prodReg_32 = {{14{_zz_bench_N16_prodReg_33[17]}}, _zz_bench_N16_prodReg_33};
  assign _zz_bench_N16_prodReg_34 = ($signed(_zz_bench_N16_prodReg_35) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_35 = {{1{bench_N16_inValsReg_3[7]}}, bench_N16_inValsReg_3};
  assign _zz_bench_N16_prodReg_36 = ($signed(_zz_bench_N16_prodReg_37) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_37 = {{1{bench_N16_wValsReg_3[7]}}, bench_N16_wValsReg_3};
  assign _zz_bench_N16_prodReg_39 = ($signed(_zz_bench_N16_prodReg_40) * $signed(_zz_bench_N16_prodReg_42));
  assign _zz_bench_N16_prodReg_38 = {{14{_zz_bench_N16_prodReg_39[17]}}, _zz_bench_N16_prodReg_39};
  assign _zz_bench_N16_prodReg_40 = ($signed(_zz_bench_N16_prodReg_41) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_41 = {{1{bench_N16_inValsReg_4[7]}}, bench_N16_inValsReg_4};
  assign _zz_bench_N16_prodReg_42 = ($signed(_zz_bench_N16_prodReg_43) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_43 = {{1{bench_N16_wValsReg_4[7]}}, bench_N16_wValsReg_4};
  assign _zz_bench_N16_prodReg_45 = ($signed(_zz_bench_N16_prodReg_46) * $signed(_zz_bench_N16_prodReg_48));
  assign _zz_bench_N16_prodReg_44 = {{14{_zz_bench_N16_prodReg_45[17]}}, _zz_bench_N16_prodReg_45};
  assign _zz_bench_N16_prodReg_46 = ($signed(_zz_bench_N16_prodReg_47) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_47 = {{1{bench_N16_inValsReg_5[7]}}, bench_N16_inValsReg_5};
  assign _zz_bench_N16_prodReg_48 = ($signed(_zz_bench_N16_prodReg_49) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_49 = {{1{bench_N16_wValsReg_5[7]}}, bench_N16_wValsReg_5};
  assign _zz_bench_N16_prodReg_51 = ($signed(_zz_bench_N16_prodReg_52) * $signed(_zz_bench_N16_prodReg_54));
  assign _zz_bench_N16_prodReg_50 = {{14{_zz_bench_N16_prodReg_51[17]}}, _zz_bench_N16_prodReg_51};
  assign _zz_bench_N16_prodReg_52 = ($signed(_zz_bench_N16_prodReg_53) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_53 = {{1{bench_N16_inValsReg_6[7]}}, bench_N16_inValsReg_6};
  assign _zz_bench_N16_prodReg_54 = ($signed(_zz_bench_N16_prodReg_55) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_55 = {{1{bench_N16_wValsReg_6[7]}}, bench_N16_wValsReg_6};
  assign _zz_bench_N16_prodReg_57 = ($signed(_zz_bench_N16_prodReg_58) * $signed(_zz_bench_N16_prodReg_60));
  assign _zz_bench_N16_prodReg_56 = {{14{_zz_bench_N16_prodReg_57[17]}}, _zz_bench_N16_prodReg_57};
  assign _zz_bench_N16_prodReg_58 = ($signed(_zz_bench_N16_prodReg_59) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_59 = {{1{bench_N16_inValsReg_7[7]}}, bench_N16_inValsReg_7};
  assign _zz_bench_N16_prodReg_60 = ($signed(_zz_bench_N16_prodReg_61) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_61 = {{1{bench_N16_wValsReg_7[7]}}, bench_N16_wValsReg_7};
  assign _zz_bench_N16_prodReg_63 = ($signed(_zz_bench_N16_prodReg_64) * $signed(_zz_bench_N16_prodReg_66));
  assign _zz_bench_N16_prodReg_62 = {{14{_zz_bench_N16_prodReg_63[17]}}, _zz_bench_N16_prodReg_63};
  assign _zz_bench_N16_prodReg_64 = ($signed(_zz_bench_N16_prodReg_65) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_65 = {{1{bench_N16_inValsReg_8[7]}}, bench_N16_inValsReg_8};
  assign _zz_bench_N16_prodReg_66 = ($signed(_zz_bench_N16_prodReg_67) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_67 = {{1{bench_N16_wValsReg_8[7]}}, bench_N16_wValsReg_8};
  assign _zz_bench_N16_prodReg_69 = ($signed(_zz_bench_N16_prodReg_70) * $signed(_zz_bench_N16_prodReg_72));
  assign _zz_bench_N16_prodReg_68 = {{14{_zz_bench_N16_prodReg_69[17]}}, _zz_bench_N16_prodReg_69};
  assign _zz_bench_N16_prodReg_70 = ($signed(_zz_bench_N16_prodReg_71) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_71 = {{1{bench_N16_inValsReg_9[7]}}, bench_N16_inValsReg_9};
  assign _zz_bench_N16_prodReg_72 = ($signed(_zz_bench_N16_prodReg_73) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_73 = {{1{bench_N16_wValsReg_9[7]}}, bench_N16_wValsReg_9};
  assign _zz_bench_N16_prodReg_75 = ($signed(_zz_bench_N16_prodReg_76) * $signed(_zz_bench_N16_prodReg_78));
  assign _zz_bench_N16_prodReg_74 = {{14{_zz_bench_N16_prodReg_75[17]}}, _zz_bench_N16_prodReg_75};
  assign _zz_bench_N16_prodReg_76 = ($signed(_zz_bench_N16_prodReg_77) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_77 = {{1{bench_N16_inValsReg_10[7]}}, bench_N16_inValsReg_10};
  assign _zz_bench_N16_prodReg_78 = ($signed(_zz_bench_N16_prodReg_79) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_79 = {{1{bench_N16_wValsReg_10[7]}}, bench_N16_wValsReg_10};
  assign _zz_bench_N16_prodReg_81 = ($signed(_zz_bench_N16_prodReg_82) * $signed(_zz_bench_N16_prodReg_84));
  assign _zz_bench_N16_prodReg_80 = {{14{_zz_bench_N16_prodReg_81[17]}}, _zz_bench_N16_prodReg_81};
  assign _zz_bench_N16_prodReg_82 = ($signed(_zz_bench_N16_prodReg_83) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_83 = {{1{bench_N16_inValsReg_11[7]}}, bench_N16_inValsReg_11};
  assign _zz_bench_N16_prodReg_84 = ($signed(_zz_bench_N16_prodReg_85) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_85 = {{1{bench_N16_wValsReg_11[7]}}, bench_N16_wValsReg_11};
  assign _zz_bench_N16_prodReg_87 = ($signed(_zz_bench_N16_prodReg_88) * $signed(_zz_bench_N16_prodReg_90));
  assign _zz_bench_N16_prodReg_86 = {{14{_zz_bench_N16_prodReg_87[17]}}, _zz_bench_N16_prodReg_87};
  assign _zz_bench_N16_prodReg_88 = ($signed(_zz_bench_N16_prodReg_89) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_89 = {{1{bench_N16_inValsReg_12[7]}}, bench_N16_inValsReg_12};
  assign _zz_bench_N16_prodReg_90 = ($signed(_zz_bench_N16_prodReg_91) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_91 = {{1{bench_N16_wValsReg_12[7]}}, bench_N16_wValsReg_12};
  assign _zz_bench_N16_prodReg_93 = ($signed(_zz_bench_N16_prodReg_94) * $signed(_zz_bench_N16_prodReg_96));
  assign _zz_bench_N16_prodReg_92 = {{14{_zz_bench_N16_prodReg_93[17]}}, _zz_bench_N16_prodReg_93};
  assign _zz_bench_N16_prodReg_94 = ($signed(_zz_bench_N16_prodReg_95) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_95 = {{1{bench_N16_inValsReg_13[7]}}, bench_N16_inValsReg_13};
  assign _zz_bench_N16_prodReg_96 = ($signed(_zz_bench_N16_prodReg_97) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_97 = {{1{bench_N16_wValsReg_13[7]}}, bench_N16_wValsReg_13};
  assign _zz_bench_N16_prodReg_99 = ($signed(_zz_bench_N16_prodReg_100) * $signed(_zz_bench_N16_prodReg_102));
  assign _zz_bench_N16_prodReg_98 = {{14{_zz_bench_N16_prodReg_99[17]}}, _zz_bench_N16_prodReg_99};
  assign _zz_bench_N16_prodReg_100 = ($signed(_zz_bench_N16_prodReg_101) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_101 = {{1{bench_N16_inValsReg_14[7]}}, bench_N16_inValsReg_14};
  assign _zz_bench_N16_prodReg_102 = ($signed(_zz_bench_N16_prodReg_103) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_103 = {{1{bench_N16_wValsReg_14[7]}}, bench_N16_wValsReg_14};
  assign _zz_bench_N16_prodReg_105 = ($signed(_zz_bench_N16_prodReg_106) * $signed(_zz_bench_N16_prodReg_108));
  assign _zz_bench_N16_prodReg_104 = {{14{_zz_bench_N16_prodReg_105[17]}}, _zz_bench_N16_prodReg_105};
  assign _zz_bench_N16_prodReg_106 = ($signed(_zz_bench_N16_prodReg_107) - $signed(9'h180));
  assign _zz_bench_N16_prodReg_107 = {{1{bench_N16_inValsReg_15[7]}}, bench_N16_inValsReg_15};
  assign _zz_bench_N16_prodReg_108 = ($signed(_zz_bench_N16_prodReg_109) - $signed(9'h0));
  assign _zz_bench_N16_prodReg_109 = {{1{bench_N16_wValsReg_15[7]}}, bench_N16_wValsReg_15};
  assign _zz_bench_N16_absAReg = (($signed(bench_N16_accumRequantReg) < $signed(32'h0)) ? _zz_bench_N16_absAReg_1 : bench_N16_accumRequantReg);
  assign _zz_bench_N16_absAReg_1 = (- bench_N16_accumRequantReg);
  assign _zz_bench_N16_pSumReg = {1'd0, bench_N16_pLH_Reg};
  assign _zz_bench_N16_pSumReg_1 = {1'd0, bench_N16_pHL_Reg};
  assign _zz_bench_N16_part1Reg = {32'd0, bench_N16_pLL_Reg2};
  assign _zz_bench_N16_part1Reg_2 = ({16'd0,_zz_bench_N16_part1Reg_3} <<< 5'd16);
  assign _zz_bench_N16_part1Reg_1 = _zz_bench_N16_part1Reg_2[63:0];
  assign _zz_bench_N16_part1Reg_3 = {31'd0, bench_N16_pSumReg};
  assign _zz_bench_N16_part2Reg = ({32'd0,_zz_bench_N16_part2Reg_1} <<< 6'd32);
  assign _zz_bench_N16_part2Reg_1 = {32'd0, bench_N16_pHH_Reg2};
  assign _zz_bench_N16_reqProdReg2_1 = (- _zz_bench_N16_reqProdReg2_2);
  assign _zz_bench_N16_reqProdReg2_2 = _zz_bench_N16_reqProdReg2;
  assign _zz_bench_N16_reqProdReg2_3 = _zz_bench_N16_reqProdReg2;
  assign _zz__zz_bench_N16_resultReg_1 = ($signed(bench_N16_reqProdReg2) >>> bench_N16_reqShiftVal);
  assign _zz__zz_bench_N16_resultReg = _zz__zz_bench_N16_resultReg_1[31:0];
  assign _zz_bench_N16_resultReg_1 = (($signed(_zz_bench_N16_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz_bench_N16_resultReg_2);
  assign _zz_bench_N16_resultReg_2 = _zz_bench_N16_resultReg[7:0];
  assign _zz_bench_N16_outChReg = (bench_N16_outChReg + 6'h01);
  assign _zz_bench_N16_outColReg = (bench_N16_outColReg + 4'b0001);
  assign _zz_bench_N16_outRowReg = (bench_N16_outRowReg + 4'b0001);
  assign _zz_bench_N16_inValsR_0_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_0_port_1 = (_zz_36 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_0_port_2);
  assign _zz_bench_N16_inputBuf_0_port_3 = _zz_bench_N16_inputBuf_0_port_4;
  assign _zz_bench_N16_inputBuf_0_port_5 = (_zz_36 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b0000)));
  assign _zz_bench_N16_inValsR_1_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_1_port_1 = (_zz_38 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_1_port_2);
  assign _zz_bench_N16_inputBuf_1_port_3 = _zz_bench_N16_inputBuf_1_port_4;
  assign _zz_bench_N16_inputBuf_1_port_5 = (_zz_38 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b0001)));
  assign _zz_bench_N16_inValsR_2_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_2_port_1 = (_zz_40 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_2_port_2);
  assign _zz_bench_N16_inputBuf_2_port_3 = _zz_bench_N16_inputBuf_2_port_4;
  assign _zz_bench_N16_inputBuf_2_port_5 = (_zz_40 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b0010)));
  assign _zz_bench_N16_inValsR_3_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_3_port_1 = (_zz_42 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_3_port_2);
  assign _zz_bench_N16_inputBuf_3_port_3 = _zz_bench_N16_inputBuf_3_port_4;
  assign _zz_bench_N16_inputBuf_3_port_5 = (_zz_42 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b0011)));
  assign _zz_bench_N16_inValsR_4_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_4_port_1 = (_zz_44 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_4_port_2);
  assign _zz_bench_N16_inputBuf_4_port_3 = _zz_bench_N16_inputBuf_4_port_4;
  assign _zz_bench_N16_inputBuf_4_port_5 = (_zz_44 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b0100)));
  assign _zz_bench_N16_inValsR_5_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_5_port_1 = (_zz_46 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_5_port_2);
  assign _zz_bench_N16_inputBuf_5_port_3 = _zz_bench_N16_inputBuf_5_port_4;
  assign _zz_bench_N16_inputBuf_5_port_5 = (_zz_46 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b0101)));
  assign _zz_bench_N16_inValsR_6_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_6_port_1 = (_zz_48 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_6_port_2);
  assign _zz_bench_N16_inputBuf_6_port_3 = _zz_bench_N16_inputBuf_6_port_4;
  assign _zz_bench_N16_inputBuf_6_port_5 = (_zz_48 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b0110)));
  assign _zz_bench_N16_inValsR_7_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_7_port_1 = (_zz_50 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_7_port_2);
  assign _zz_bench_N16_inputBuf_7_port_3 = _zz_bench_N16_inputBuf_7_port_4;
  assign _zz_bench_N16_inputBuf_7_port_5 = (_zz_50 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b0111)));
  assign _zz_bench_N16_inValsR_8_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_8_port_1 = (_zz_52 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_8_port_2);
  assign _zz_bench_N16_inputBuf_8_port_3 = _zz_bench_N16_inputBuf_8_port_4;
  assign _zz_bench_N16_inputBuf_8_port_5 = (_zz_52 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b1000)));
  assign _zz_bench_N16_inValsR_9_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_9_port_1 = (_zz_54 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_9_port_2);
  assign _zz_bench_N16_inputBuf_9_port_3 = _zz_bench_N16_inputBuf_9_port_4;
  assign _zz_bench_N16_inputBuf_9_port_5 = (_zz_54 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b1001)));
  assign _zz_bench_N16_inValsR_10_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_10_port_1 = (_zz_56 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_10_port_2);
  assign _zz_bench_N16_inputBuf_10_port_3 = _zz_bench_N16_inputBuf_10_port_4;
  assign _zz_bench_N16_inputBuf_10_port_5 = (_zz_56 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b1010)));
  assign _zz_bench_N16_inValsR_11_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_11_port_1 = (_zz_58 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_11_port_2);
  assign _zz_bench_N16_inputBuf_11_port_3 = _zz_bench_N16_inputBuf_11_port_4;
  assign _zz_bench_N16_inputBuf_11_port_5 = (_zz_58 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b1011)));
  assign _zz_bench_N16_inValsR_12_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_12_port_1 = (_zz_60 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_12_port_2);
  assign _zz_bench_N16_inputBuf_12_port_3 = _zz_bench_N16_inputBuf_12_port_4;
  assign _zz_bench_N16_inputBuf_12_port_5 = (_zz_60 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b1100)));
  assign _zz_bench_N16_inValsR_13_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_13_port_1 = (_zz_62 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_13_port_2);
  assign _zz_bench_N16_inputBuf_13_port_3 = _zz_bench_N16_inputBuf_13_port_4;
  assign _zz_bench_N16_inputBuf_13_port_5 = (_zz_62 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b1101)));
  assign _zz_bench_N16_inValsR_14_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_14_port_1 = (_zz_64 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_14_port_2);
  assign _zz_bench_N16_inputBuf_14_port_3 = _zz_bench_N16_inputBuf_14_port_4;
  assign _zz_bench_N16_inputBuf_14_port_5 = (_zz_64 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b1110)));
  assign _zz_bench_N16_inValsR_15_1 = 1'b1;
  assign _zz_bench_N16_inputBuf_15_port_1 = (_zz_66 ? bench_N16_initAddrReg : _zz_bench_N16_inputBuf_15_port_2);
  assign _zz_bench_N16_inputBuf_15_port_3 = _zz_bench_N16_inputBuf_15_port_4;
  assign _zz_bench_N16_inputBuf_15_port_5 = (_zz_66 || (((bench_N16_stateReg == bench_N16_sReceive) && inStream_fire) && (bench_N16_padWriteAddrReg[3 : 0] == 4'b1111)));
  assign _zz_bench_N16_wValsR_0_1 = 1'b1;
  assign _zz_bench_N16_wValsR_1_1 = 1'b1;
  assign _zz_bench_N16_wValsR_2_1 = 1'b1;
  assign _zz_bench_N16_wValsR_3_1 = 1'b1;
  assign _zz_bench_N16_wValsR_4_1 = 1'b1;
  assign _zz_bench_N16_wValsR_5_1 = 1'b1;
  assign _zz_bench_N16_wValsR_6_1 = 1'b1;
  assign _zz_bench_N16_wValsR_7_1 = 1'b1;
  assign _zz_bench_N16_wValsR_8_1 = 1'b1;
  assign _zz_bench_N16_wValsR_9_1 = 1'b1;
  assign _zz_bench_N16_wValsR_10_1 = 1'b1;
  assign _zz_bench_N16_wValsR_11_1 = 1'b1;
  assign _zz_bench_N16_wValsR_12_1 = 1'b1;
  assign _zz_bench_N16_wValsR_13_1 = 1'b1;
  assign _zz_bench_N16_wValsR_14_1 = 1'b1;
  assign _zz_bench_N16_wValsR_15_1 = 1'b1;
  assign _zz_bench_N16_biasVal_2 = 1'b1;
  assign _zz_bench_N16_reqMultVal_2 = 1'b1;
  assign _zz_bench_N16_reqShiftVal_2 = 1'b1;
  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_0_1) begin
      bench_N16_inputBuf_0_spinal_port0 <= bench_N16_inputBuf_0[_zz_bench_N16_inValsR_0];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_0_port_5) begin
      bench_N16_inputBuf_0[_zz_bench_N16_inputBuf_0_port_1] <= _zz_bench_N16_inputBuf_0_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_1_1) begin
      bench_N16_inputBuf_1_spinal_port0 <= bench_N16_inputBuf_1[_zz_bench_N16_inValsR_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_1_port_5) begin
      bench_N16_inputBuf_1[_zz_bench_N16_inputBuf_1_port_1] <= _zz_bench_N16_inputBuf_1_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_2_1) begin
      bench_N16_inputBuf_2_spinal_port0 <= bench_N16_inputBuf_2[_zz_bench_N16_inValsR_2];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_2_port_5) begin
      bench_N16_inputBuf_2[_zz_bench_N16_inputBuf_2_port_1] <= _zz_bench_N16_inputBuf_2_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_3_1) begin
      bench_N16_inputBuf_3_spinal_port0 <= bench_N16_inputBuf_3[_zz_bench_N16_inValsR_3];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_3_port_5) begin
      bench_N16_inputBuf_3[_zz_bench_N16_inputBuf_3_port_1] <= _zz_bench_N16_inputBuf_3_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_4_1) begin
      bench_N16_inputBuf_4_spinal_port0 <= bench_N16_inputBuf_4[_zz_bench_N16_inValsR_4];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_4_port_5) begin
      bench_N16_inputBuf_4[_zz_bench_N16_inputBuf_4_port_1] <= _zz_bench_N16_inputBuf_4_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_5_1) begin
      bench_N16_inputBuf_5_spinal_port0 <= bench_N16_inputBuf_5[_zz_bench_N16_inValsR_5];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_5_port_5) begin
      bench_N16_inputBuf_5[_zz_bench_N16_inputBuf_5_port_1] <= _zz_bench_N16_inputBuf_5_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_6_1) begin
      bench_N16_inputBuf_6_spinal_port0 <= bench_N16_inputBuf_6[_zz_bench_N16_inValsR_6];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_6_port_5) begin
      bench_N16_inputBuf_6[_zz_bench_N16_inputBuf_6_port_1] <= _zz_bench_N16_inputBuf_6_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_7_1) begin
      bench_N16_inputBuf_7_spinal_port0 <= bench_N16_inputBuf_7[_zz_bench_N16_inValsR_7];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_7_port_5) begin
      bench_N16_inputBuf_7[_zz_bench_N16_inputBuf_7_port_1] <= _zz_bench_N16_inputBuf_7_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_8_1) begin
      bench_N16_inputBuf_8_spinal_port0 <= bench_N16_inputBuf_8[_zz_bench_N16_inValsR_8];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_8_port_5) begin
      bench_N16_inputBuf_8[_zz_bench_N16_inputBuf_8_port_1] <= _zz_bench_N16_inputBuf_8_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_9_1) begin
      bench_N16_inputBuf_9_spinal_port0 <= bench_N16_inputBuf_9[_zz_bench_N16_inValsR_9];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_9_port_5) begin
      bench_N16_inputBuf_9[_zz_bench_N16_inputBuf_9_port_1] <= _zz_bench_N16_inputBuf_9_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_10_1) begin
      bench_N16_inputBuf_10_spinal_port0 <= bench_N16_inputBuf_10[_zz_bench_N16_inValsR_10];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_10_port_5) begin
      bench_N16_inputBuf_10[_zz_bench_N16_inputBuf_10_port_1] <= _zz_bench_N16_inputBuf_10_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_11_1) begin
      bench_N16_inputBuf_11_spinal_port0 <= bench_N16_inputBuf_11[_zz_bench_N16_inValsR_11];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_11_port_5) begin
      bench_N16_inputBuf_11[_zz_bench_N16_inputBuf_11_port_1] <= _zz_bench_N16_inputBuf_11_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_12_1) begin
      bench_N16_inputBuf_12_spinal_port0 <= bench_N16_inputBuf_12[_zz_bench_N16_inValsR_12];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_12_port_5) begin
      bench_N16_inputBuf_12[_zz_bench_N16_inputBuf_12_port_1] <= _zz_bench_N16_inputBuf_12_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_13_1) begin
      bench_N16_inputBuf_13_spinal_port0 <= bench_N16_inputBuf_13[_zz_bench_N16_inValsR_13];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_13_port_5) begin
      bench_N16_inputBuf_13[_zz_bench_N16_inputBuf_13_port_1] <= _zz_bench_N16_inputBuf_13_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_14_1) begin
      bench_N16_inputBuf_14_spinal_port0 <= bench_N16_inputBuf_14[_zz_bench_N16_inValsR_14];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_14_port_5) begin
      bench_N16_inputBuf_14[_zz_bench_N16_inputBuf_14_port_1] <= _zz_bench_N16_inputBuf_14_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inValsR_15_1) begin
      bench_N16_inputBuf_15_spinal_port0 <= bench_N16_inputBuf_15[_zz_bench_N16_inValsR_15];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N16_inputBuf_15_port_5) begin
      bench_N16_inputBuf_15[_zz_bench_N16_inputBuf_15_port_1] <= _zz_bench_N16_inputBuf_15_port_3;
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_0.bin",bench_N16_weightRom_0);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_0_1) begin
      bench_N16_weightRom_0_spinal_port0 <= bench_N16_weightRom_0[_zz_bench_N16_wValsR_0];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_1.bin",bench_N16_weightRom_1);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_1_1) begin
      bench_N16_weightRom_1_spinal_port0 <= bench_N16_weightRom_1[_zz_bench_N16_wValsR_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_2.bin",bench_N16_weightRom_2);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_2_1) begin
      bench_N16_weightRom_2_spinal_port0 <= bench_N16_weightRom_2[_zz_bench_N16_wValsR_2];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_3.bin",bench_N16_weightRom_3);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_3_1) begin
      bench_N16_weightRom_3_spinal_port0 <= bench_N16_weightRom_3[_zz_bench_N16_wValsR_3];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_4.bin",bench_N16_weightRom_4);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_4_1) begin
      bench_N16_weightRom_4_spinal_port0 <= bench_N16_weightRom_4[_zz_bench_N16_wValsR_4];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_5.bin",bench_N16_weightRom_5);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_5_1) begin
      bench_N16_weightRom_5_spinal_port0 <= bench_N16_weightRom_5[_zz_bench_N16_wValsR_5];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_6.bin",bench_N16_weightRom_6);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_6_1) begin
      bench_N16_weightRom_6_spinal_port0 <= bench_N16_weightRom_6[_zz_bench_N16_wValsR_6];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_7.bin",bench_N16_weightRom_7);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_7_1) begin
      bench_N16_weightRom_7_spinal_port0 <= bench_N16_weightRom_7[_zz_bench_N16_wValsR_7];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_8.bin",bench_N16_weightRom_8);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_8_1) begin
      bench_N16_weightRom_8_spinal_port0 <= bench_N16_weightRom_8[_zz_bench_N16_wValsR_8];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_9.bin",bench_N16_weightRom_9);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_9_1) begin
      bench_N16_weightRom_9_spinal_port0 <= bench_N16_weightRom_9[_zz_bench_N16_wValsR_9];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_10.bin",bench_N16_weightRom_10);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_10_1) begin
      bench_N16_weightRom_10_spinal_port0 <= bench_N16_weightRom_10[_zz_bench_N16_wValsR_10];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_11.bin",bench_N16_weightRom_11);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_11_1) begin
      bench_N16_weightRom_11_spinal_port0 <= bench_N16_weightRom_11[_zz_bench_N16_wValsR_11];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_12.bin",bench_N16_weightRom_12);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_12_1) begin
      bench_N16_weightRom_12_spinal_port0 <= bench_N16_weightRom_12[_zz_bench_N16_wValsR_12];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_13.bin",bench_N16_weightRom_13);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_13_1) begin
      bench_N16_weightRom_13_spinal_port0 <= bench_N16_weightRom_13[_zz_bench_N16_wValsR_13];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_14.bin",bench_N16_weightRom_14);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_14_1) begin
      bench_N16_weightRom_14_spinal_port0 <= bench_N16_weightRom_14[_zz_bench_N16_wValsR_14];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_weightRom_15.bin",bench_N16_weightRom_15);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_wValsR_15_1) begin
      bench_N16_weightRom_15_spinal_port0 <= bench_N16_weightRom_15[_zz_bench_N16_wValsR_15];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_biasRom.bin",bench_N16_biasRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_biasVal_2) begin
      bench_N16_biasRom_spinal_port0 <= bench_N16_biasRom[_zz_bench_N16_biasVal_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_reqMultRom.bin",bench_N16_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_reqMultVal_2) begin
      bench_N16_reqMultRom_spinal_port0 <= bench_N16_reqMultRom[_zz_bench_N16_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N16_reqShiftRom.bin",bench_N16_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N16_reqShiftVal_2) begin
      bench_N16_reqShiftRom_spinal_port0 <= bench_N16_reqShiftRom[_zz_bench_N16_reqShiftVal_1];
    end
  end

  assign inStream_valid = inValidR;
  assign inStream_payload_value = inValueR;
  assign bench_N16_sReceive = 4'b0000;
  assign bench_N16_sLoadBias = 4'b0001;
  assign bench_N16_sCompute = 4'b0010;
  assign bench_N16_sRequant = 4'b0011;
  assign bench_N16_sRequantMul = 4'b0100;
  assign bench_N16_sRequantWait = 4'b0101;
  assign bench_N16_sRequantWait2 = 4'b0110;
  assign bench_N16_sRequantWait3 = 4'b0111;
  assign bench_N16_sRequantShift = 4'b1000;
  assign bench_N16_sEmit = 4'b1001;
  assign bench_N16_sInit = 4'b1010;
  assign bench_N16_sWaitBias = 4'b1011;
  assign bench_N16_sLoadWeights = 4'b1100;
  assign bench_N16_reqProdReg1 = 64'h0;
  always @(*) begin
    bench_N16_inAddrComb = bench_N16_inAddrReg;
    if(when_QLinearConvCore_l412) begin
      if(when_QLinearConvCore_l416) begin
        bench_N16_inAddrComb = bench_N16_inAddrReg;
      end
    end
  end

  always @(*) begin
    bench_N16_wAddrComb = bench_N16_wAddrReg;
    if(when_QLinearConvCore_l412) begin
      if(when_QLinearConvCore_l416) begin
        bench_N16_wAddrComb = bench_N16_wAddrReg;
      end
    end
  end

  assign _zz_bench_N16_inValsR_0 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_0 = bench_N16_inputBuf_0_spinal_port0;
  assign _zz_bench_N16_inValsR_1 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_1 = bench_N16_inputBuf_1_spinal_port0;
  assign _zz_bench_N16_inValsR_2 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_2 = bench_N16_inputBuf_2_spinal_port0;
  assign _zz_bench_N16_inValsR_3 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_3 = bench_N16_inputBuf_3_spinal_port0;
  assign _zz_bench_N16_inValsR_4 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_4 = bench_N16_inputBuf_4_spinal_port0;
  assign _zz_bench_N16_inValsR_5 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_5 = bench_N16_inputBuf_5_spinal_port0;
  assign _zz_bench_N16_inValsR_6 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_6 = bench_N16_inputBuf_6_spinal_port0;
  assign _zz_bench_N16_inValsR_7 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_7 = bench_N16_inputBuf_7_spinal_port0;
  assign _zz_bench_N16_inValsR_8 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_8 = bench_N16_inputBuf_8_spinal_port0;
  assign _zz_bench_N16_inValsR_9 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_9 = bench_N16_inputBuf_9_spinal_port0;
  assign _zz_bench_N16_inValsR_10 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_10 = bench_N16_inputBuf_10_spinal_port0;
  assign _zz_bench_N16_inValsR_11 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_11 = bench_N16_inputBuf_11_spinal_port0;
  assign _zz_bench_N16_inValsR_12 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_12 = bench_N16_inputBuf_12_spinal_port0;
  assign _zz_bench_N16_inValsR_13 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_13 = bench_N16_inputBuf_13_spinal_port0;
  assign _zz_bench_N16_inValsR_14 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_14 = bench_N16_inputBuf_14_spinal_port0;
  assign _zz_bench_N16_inValsR_15 = bench_N16_inAddrComb;
  assign bench_N16_inValsR_15 = bench_N16_inputBuf_15_spinal_port0;
  assign _zz_bench_N16_wValsR_0 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_0 = bench_N16_weightRom_0_spinal_port0;
  assign _zz_bench_N16_wValsR_1 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_1 = bench_N16_weightRom_1_spinal_port0;
  assign _zz_bench_N16_wValsR_2 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_2 = bench_N16_weightRom_2_spinal_port0;
  assign _zz_bench_N16_wValsR_3 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_3 = bench_N16_weightRom_3_spinal_port0;
  assign _zz_bench_N16_wValsR_4 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_4 = bench_N16_weightRom_4_spinal_port0;
  assign _zz_bench_N16_wValsR_5 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_5 = bench_N16_weightRom_5_spinal_port0;
  assign _zz_bench_N16_wValsR_6 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_6 = bench_N16_weightRom_6_spinal_port0;
  assign _zz_bench_N16_wValsR_7 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_7 = bench_N16_weightRom_7_spinal_port0;
  assign _zz_bench_N16_wValsR_8 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_8 = bench_N16_weightRom_8_spinal_port0;
  assign _zz_bench_N16_wValsR_9 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_9 = bench_N16_weightRom_9_spinal_port0;
  assign _zz_bench_N16_wValsR_10 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_10 = bench_N16_weightRom_10_spinal_port0;
  assign _zz_bench_N16_wValsR_11 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_11 = bench_N16_weightRom_11_spinal_port0;
  assign _zz_bench_N16_wValsR_12 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_12 = bench_N16_weightRom_12_spinal_port0;
  assign _zz_bench_N16_wValsR_13 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_13 = bench_N16_weightRom_13_spinal_port0;
  assign _zz_bench_N16_wValsR_14 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_14 = bench_N16_weightRom_14_spinal_port0;
  assign _zz_bench_N16_wValsR_15 = bench_N16_wAddrComb;
  assign bench_N16_wValsR_15 = bench_N16_weightRom_15_spinal_port0;
  assign _zz_bench_N16_biasVal = bench_N16_outChReg;
  assign bench_N16_biasVal = bench_N16_biasRom_spinal_port0;
  assign _zz_bench_N16_reqMultVal = bench_N16_outChReg;
  assign bench_N16_reqMultVal = bench_N16_reqMultRom_spinal_port0;
  assign _zz_bench_N16_reqShiftVal = bench_N16_outChReg;
  assign bench_N16_reqShiftVal = bench_N16_reqShiftRom_spinal_port0;
  assign _zz_36 = (bench_N16_stateReg == bench_N16_sInit);
  assign inStream_fire = (inStream_valid && inStream_ready);
  assign _zz_38 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_40 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_42 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_44 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_46 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_48 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_50 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_52 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_54 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_56 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_58 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_60 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_62 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_64 = (bench_N16_stateReg == bench_N16_sInit);
  assign _zz_66 = (bench_N16_stateReg == bench_N16_sInit);
  always @(*) begin
    inStream_ready = 1'b0;
    if(when_QLinearConvCore_l347) begin
      inStream_ready = 1'b1;
    end
  end

  always @(*) begin
    bench_N16_activationOut_valid = 1'b0;
    if(when_QLinearConvCore_l519) begin
      bench_N16_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    bench_N16_activationOut_payload_value = bench_N16_resultReg;
    if(when_QLinearConvCore_l519) begin
      bench_N16_activationOut_payload_value = bench_N16_resultReg;
    end
  end

  assign when_QLinearConvCore_l331 = (bench_N16_stateReg == bench_N16_sInit);
  assign when_QLinearConvCore_l333 = (bench_N16_initAddrReg == 7'h63);
  assign when_QLinearConvCore_l347 = (bench_N16_stateReg == bench_N16_sReceive);
  assign _zz_bench_N16_padWriteAddrReg = (bench_N16_rowElemReg == 8'h7f);
  assign when_QLinearConvCore_l357 = (bench_N16_recvCntReg == 11'h3ff);
  assign when_QLinearConvCore_l390 = (bench_N16_stateReg == bench_N16_sLoadBias);
  assign when_QLinearConvCore_l404 = (bench_N16_stateReg == bench_N16_sWaitBias);
  assign when_QLinearConvCore_l412 = (bench_N16_stateReg == bench_N16_sCompute);
  assign when_QLinearConvCore_l416 = (bench_N16_compCycleReg < 4'b1001);
  assign _zz_bench_N16_inAddrReg = (bench_N16_rowStepReg == 2'b10);
  assign when_QLinearConvCore_l429 = ((4'b0001 <= bench_N16_compCycleReg) && (bench_N16_compCycleReg <= 4'b1001));
  assign when_QLinearConvCore_l437 = ((4'b0010 <= bench_N16_compCycleReg) && (bench_N16_compCycleReg <= 4'b1010));
  assign when_QLinearConvCore_l448 = ((4'b0011 <= bench_N16_compCycleReg) && (bench_N16_compCycleReg <= 4'b1011));
  assign _zz_bench_N16_accumReg = ($signed(bench_N16_accumReg) + $signed(bench_N16_prodReg));
  assign when_QLinearConvCore_l452 = (bench_N16_compCycleReg == 4'b1011);
  assign when_QLinearConvCore_l461 = (bench_N16_stateReg == bench_N16_sRequant);
  assign when_QLinearConvCore_l468 = (bench_N16_stateReg == bench_N16_sRequantMul);
  assign _zz_bench_N16_pHL_Reg = bench_N16_absAReg[31 : 16];
  assign _zz_bench_N16_pLL_Reg = bench_N16_absAReg[15 : 0];
  assign _zz_bench_N16_pLH_Reg = bench_N16_reqMultVal[31 : 16];
  assign _zz_bench_N16_pLL_Reg_1 = bench_N16_reqMultVal[15 : 0];
  assign when_QLinearConvCore_l485 = (bench_N16_stateReg == bench_N16_sRequantWait);
  assign when_QLinearConvCore_l493 = (bench_N16_stateReg == bench_N16_sRequantWait2);
  assign when_QLinearConvCore_l500 = (bench_N16_stateReg == bench_N16_sRequantWait3);
  assign _zz_bench_N16_reqProdReg2 = (bench_N16_part1Reg + bench_N16_part2Reg);
  assign when_QLinearConvCore_l508 = (bench_N16_stateReg == bench_N16_sRequantShift);
  assign _zz_bench_N16_resultReg = ($signed(_zz__zz_bench_N16_resultReg) + $signed(32'hffffff80));
  assign when_QLinearConvCore_l519 = (bench_N16_stateReg == bench_N16_sEmit);
  assign bench_N16_activationOut_fire = (bench_N16_activationOut_valid && bench_N16_activationOut_ready);
  assign when_QLinearConvCore_l529 = (bench_N16_outChReg == 6'h1f);
  assign when_QLinearConvCore_l531 = (bench_N16_outColReg == 4'b0111);
  assign _zz_bench_N16_stateReg = (bench_N16_outRowReg == 4'b0111);
  assign bench_N16_activationOut_ready = outReadyR;
  assign io_inReady = inStream_ready_regNext;
  assign io_outValid = bench_N16_activationOut_valid_regNext;
  assign io_outValue = bench_N16_activationOut_payload_value_regNext;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      inValidR <= 1'b0;
      inValueR <= 8'h0;
      outReadyR <= 1'b0;
      bench_N16_stateReg <= 4'b1010;
      bench_N16_recvCntReg <= 11'h0;
      bench_N16_padWriteAddrReg <= 11'h0b0;
      bench_N16_rowElemReg <= 8'h0;
      bench_N16_outRowReg <= 4'b0000;
      bench_N16_outColReg <= 4'b0000;
      bench_N16_outChReg <= 6'h0;
      bench_N16_accumReg <= 32'h0;
      bench_N16_prodReg <= 32'h0;
      bench_N16_resultReg <= 8'h0;
      bench_N16_reqProdReg2 <= 64'h0;
      bench_N16_accumRequantReg <= 32'h0;
      bench_N16_signAReg <= 1'b0;
      bench_N16_absAReg <= 32'h0;
      bench_N16_pLL_Reg <= 32'h0;
      bench_N16_pLH_Reg <= 32'h0;
      bench_N16_pHL_Reg <= 32'h0;
      bench_N16_pHH_Reg <= 32'h0;
      bench_N16_pSumReg <= 33'h0;
      bench_N16_pLL_Reg2 <= 32'h0;
      bench_N16_pHH_Reg2 <= 32'h0;
      bench_N16_part1Reg <= 64'h0;
      bench_N16_part2Reg <= 64'h0;
      bench_N16_initAddrReg <= 7'h0;
      bench_N16_inAddrReg <= 7'h0;
      bench_N16_wAddrReg <= 9'h0;
      bench_N16_compCycleReg <= 4'b0000;
      bench_N16_rowStepReg <= 2'b00;
      bench_N16_inValsReg_0 <= 8'h0;
      bench_N16_inValsReg_1 <= 8'h0;
      bench_N16_inValsReg_2 <= 8'h0;
      bench_N16_inValsReg_3 <= 8'h0;
      bench_N16_inValsReg_4 <= 8'h0;
      bench_N16_inValsReg_5 <= 8'h0;
      bench_N16_inValsReg_6 <= 8'h0;
      bench_N16_inValsReg_7 <= 8'h0;
      bench_N16_inValsReg_8 <= 8'h0;
      bench_N16_inValsReg_9 <= 8'h0;
      bench_N16_inValsReg_10 <= 8'h0;
      bench_N16_inValsReg_11 <= 8'h0;
      bench_N16_inValsReg_12 <= 8'h0;
      bench_N16_inValsReg_13 <= 8'h0;
      bench_N16_inValsReg_14 <= 8'h0;
      bench_N16_inValsReg_15 <= 8'h0;
      bench_N16_wValsReg_0 <= 8'h0;
      bench_N16_wValsReg_1 <= 8'h0;
      bench_N16_wValsReg_2 <= 8'h0;
      bench_N16_wValsReg_3 <= 8'h0;
      bench_N16_wValsReg_4 <= 8'h0;
      bench_N16_wValsReg_5 <= 8'h0;
      bench_N16_wValsReg_6 <= 8'h0;
      bench_N16_wValsReg_7 <= 8'h0;
      bench_N16_wValsReg_8 <= 8'h0;
      bench_N16_wValsReg_9 <= 8'h0;
      bench_N16_wValsReg_10 <= 8'h0;
      bench_N16_wValsReg_11 <= 8'h0;
      bench_N16_wValsReg_12 <= 8'h0;
      bench_N16_wValsReg_13 <= 8'h0;
      bench_N16_wValsReg_14 <= 8'h0;
      bench_N16_wValsReg_15 <= 8'h0;
      inStream_ready_regNext <= 1'b0;
      bench_N16_activationOut_valid_regNext <= 1'b0;
      bench_N16_activationOut_payload_value_regNext <= 8'h0;
    end else begin
      inValidR <= io_inValid;
      inValueR <= io_inValue;
      outReadyR <= io_outReady;
      if(when_QLinearConvCore_l331) begin
        if(when_QLinearConvCore_l333) begin
          bench_N16_initAddrReg <= 7'h0;
          bench_N16_stateReg <= bench_N16_sReceive;
        end else begin
          bench_N16_initAddrReg <= (bench_N16_initAddrReg + 7'h01);
        end
      end
      if(when_QLinearConvCore_l347) begin
        if(inStream_fire) begin
          bench_N16_rowElemReg <= (_zz_bench_N16_padWriteAddrReg ? 8'h0 : _zz_bench_N16_rowElemReg);
          bench_N16_padWriteAddrReg <= (bench_N16_padWriteAddrReg + (_zz_bench_N16_padWriteAddrReg ? 11'h021 : 11'h001));
          bench_N16_recvCntReg <= (bench_N16_recvCntReg + 11'h001);
          if(when_QLinearConvCore_l357) begin
            bench_N16_recvCntReg <= 11'h0;
            bench_N16_rowElemReg <= 8'h0;
            bench_N16_padWriteAddrReg <= 11'h0b0;
            bench_N16_outRowReg <= 4'b0000;
            bench_N16_outColReg <= 4'b0000;
            bench_N16_outChReg <= 6'h0;
            bench_N16_stateReg <= bench_N16_sLoadBias;
          end
        end
      end
      if(when_QLinearConvCore_l390) begin
        bench_N16_inAddrReg <= _zz_bench_N16_inAddrReg_1[6:0];
        bench_N16_wAddrReg <= _zz_bench_N16_wAddrReg[8:0];
        bench_N16_compCycleReg <= 4'b0000;
        bench_N16_rowStepReg <= 2'b00;
        bench_N16_stateReg <= bench_N16_sWaitBias;
      end
      if(when_QLinearConvCore_l404) begin
        bench_N16_accumReg <= bench_N16_biasVal;
        bench_N16_stateReg <= bench_N16_sCompute;
      end
      if(when_QLinearConvCore_l412) begin
        bench_N16_compCycleReg <= (bench_N16_compCycleReg + 4'b0001);
        if(when_QLinearConvCore_l416) begin
          bench_N16_wAddrReg <= (bench_N16_wAddrReg + 9'h001);
          bench_N16_inAddrReg <= (bench_N16_inAddrReg + (_zz_bench_N16_inAddrReg ? 7'h08 : 7'h01));
          bench_N16_rowStepReg <= (_zz_bench_N16_inAddrReg ? 2'b00 : _zz_bench_N16_rowStepReg);
        end
        if(when_QLinearConvCore_l429) begin
          bench_N16_inValsReg_0 <= bench_N16_inValsR_0;
          bench_N16_wValsReg_0 <= bench_N16_wValsR_0;
          bench_N16_inValsReg_1 <= bench_N16_inValsR_1;
          bench_N16_wValsReg_1 <= bench_N16_wValsR_1;
          bench_N16_inValsReg_2 <= bench_N16_inValsR_2;
          bench_N16_wValsReg_2 <= bench_N16_wValsR_2;
          bench_N16_inValsReg_3 <= bench_N16_inValsR_3;
          bench_N16_wValsReg_3 <= bench_N16_wValsR_3;
          bench_N16_inValsReg_4 <= bench_N16_inValsR_4;
          bench_N16_wValsReg_4 <= bench_N16_wValsR_4;
          bench_N16_inValsReg_5 <= bench_N16_inValsR_5;
          bench_N16_wValsReg_5 <= bench_N16_wValsR_5;
          bench_N16_inValsReg_6 <= bench_N16_inValsR_6;
          bench_N16_wValsReg_6 <= bench_N16_wValsR_6;
          bench_N16_inValsReg_7 <= bench_N16_inValsR_7;
          bench_N16_wValsReg_7 <= bench_N16_wValsR_7;
          bench_N16_inValsReg_8 <= bench_N16_inValsR_8;
          bench_N16_wValsReg_8 <= bench_N16_wValsR_8;
          bench_N16_inValsReg_9 <= bench_N16_inValsR_9;
          bench_N16_wValsReg_9 <= bench_N16_wValsR_9;
          bench_N16_inValsReg_10 <= bench_N16_inValsR_10;
          bench_N16_wValsReg_10 <= bench_N16_wValsR_10;
          bench_N16_inValsReg_11 <= bench_N16_inValsR_11;
          bench_N16_wValsReg_11 <= bench_N16_wValsR_11;
          bench_N16_inValsReg_12 <= bench_N16_inValsR_12;
          bench_N16_wValsReg_12 <= bench_N16_wValsR_12;
          bench_N16_inValsReg_13 <= bench_N16_inValsR_13;
          bench_N16_wValsReg_13 <= bench_N16_wValsR_13;
          bench_N16_inValsReg_14 <= bench_N16_inValsR_14;
          bench_N16_wValsReg_14 <= bench_N16_wValsR_14;
          bench_N16_inValsReg_15 <= bench_N16_inValsR_15;
          bench_N16_wValsReg_15 <= bench_N16_wValsR_15;
        end
        if(when_QLinearConvCore_l437) begin
          bench_N16_prodReg <= ($signed(_zz_bench_N16_prodReg) + $signed(_zz_bench_N16_prodReg_104));
        end
        if(when_QLinearConvCore_l448) begin
          bench_N16_accumReg <= _zz_bench_N16_accumReg;
          if(when_QLinearConvCore_l452) begin
            bench_N16_accumRequantReg <= _zz_bench_N16_accumReg;
            bench_N16_stateReg <= bench_N16_sRequant;
            bench_N16_compCycleReg <= 4'b0000;
          end
        end
      end
      if(when_QLinearConvCore_l461) begin
        bench_N16_absAReg <= _zz_bench_N16_absAReg;
        bench_N16_signAReg <= ($signed(bench_N16_accumRequantReg) < $signed(32'h0));
        bench_N16_stateReg <= bench_N16_sRequantMul;
      end
      if(when_QLinearConvCore_l468) begin
        bench_N16_pLL_Reg <= (_zz_bench_N16_pLL_Reg * _zz_bench_N16_pLL_Reg_1);
        bench_N16_pLH_Reg <= (_zz_bench_N16_pLL_Reg * _zz_bench_N16_pLH_Reg);
        bench_N16_pHL_Reg <= (_zz_bench_N16_pHL_Reg * _zz_bench_N16_pLL_Reg_1);
        bench_N16_pHH_Reg <= (_zz_bench_N16_pHL_Reg * _zz_bench_N16_pLH_Reg);
        bench_N16_stateReg <= bench_N16_sRequantWait;
      end
      if(when_QLinearConvCore_l485) begin
        bench_N16_pSumReg <= (_zz_bench_N16_pSumReg + _zz_bench_N16_pSumReg_1);
        bench_N16_pLL_Reg2 <= bench_N16_pLL_Reg;
        bench_N16_pHH_Reg2 <= bench_N16_pHH_Reg;
        bench_N16_stateReg <= bench_N16_sRequantWait2;
      end
      if(when_QLinearConvCore_l493) begin
        bench_N16_part1Reg <= (_zz_bench_N16_part1Reg + _zz_bench_N16_part1Reg_1);
        bench_N16_part2Reg <= _zz_bench_N16_part2Reg[63:0];
        bench_N16_stateReg <= bench_N16_sRequantWait3;
      end
      if(when_QLinearConvCore_l500) begin
        bench_N16_reqProdReg2 <= (bench_N16_signAReg ? _zz_bench_N16_reqProdReg2_1 : _zz_bench_N16_reqProdReg2_3);
        bench_N16_stateReg <= bench_N16_sRequantShift;
      end
      if(when_QLinearConvCore_l508) begin
        bench_N16_resultReg <= (($signed(32'h0000007f) < $signed(_zz_bench_N16_resultReg)) ? 8'h7f : _zz_bench_N16_resultReg_1);
        bench_N16_stateReg <= bench_N16_sEmit;
      end
      if(when_QLinearConvCore_l519) begin
        if(bench_N16_activationOut_fire) begin
          bench_N16_outChReg <= (when_QLinearConvCore_l529 ? 6'h0 : _zz_bench_N16_outChReg);
          if(when_QLinearConvCore_l529) begin
            bench_N16_outColReg <= (when_QLinearConvCore_l531 ? 4'b0000 : _zz_bench_N16_outColReg);
            if(when_QLinearConvCore_l531) begin
              bench_N16_outRowReg <= (_zz_bench_N16_stateReg ? 4'b0000 : _zz_bench_N16_outRowReg);
            end
          end
          bench_N16_stateReg <= (((when_QLinearConvCore_l529 && when_QLinearConvCore_l531) && _zz_bench_N16_stateReg) ? bench_N16_sReceive : bench_N16_sLoadBias);
        end
      end
      inStream_ready_regNext <= inStream_ready;
      bench_N16_activationOut_valid_regNext <= bench_N16_activationOut_valid;
      bench_N16_activationOut_payload_value_regNext <= bench_N16_activationOut_payload_value;
    end
  end


endmodule
