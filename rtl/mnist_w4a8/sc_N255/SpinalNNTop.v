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

  reg        [7:0]    conv1_actBuf_spinal_port1;
  reg        [7:0]    conv1_wThrRom_spinal_port0;
  reg        [0:0]    conv1_wSignRom_spinal_port0;
  reg        [31:0]   conv1_combAdjRom_spinal_port0;
  reg        [7:0]    pool1_rowBuf_0_spinal_port0;
  reg        [7:0]    pool1_rowBuf_1_spinal_port0;
  reg        [7:0]    conv2_actBuf_spinal_port1;
  reg        [7:0]    conv2_wThrRom_spinal_port0;
  reg        [0:0]    conv2_wSignRom_spinal_port0;
  reg        [31:0]   conv2_combAdjRom_spinal_port0;
  reg        [7:0]    pool2_rowBuf_0_spinal_port0;
  reg        [7:0]    pool2_rowBuf_1_spinal_port0;
  reg        [7:0]    pool2_rowBuf_2_spinal_port0;
  reg        [7:0]    linear1_inputBuf_spinal_port0;
  reg        [7:0]    linear1_weightRom_spinal_port0;
  reg        [31:0]   linear1_biasRom_spinal_port0;
  wire       [5:0]    _zz_conv1_posCount_8;
  wire       [4:0]    _zz_conv1_posCount_9;
  wire       [4:0]    _zz_conv1_posCount_10;
  wire       [4:0]    _zz_conv1_posCount_11;
  wire       [4:0]    _zz_conv1_posCount_12;
  reg        [4:0]    _zz_conv1_posCount_13;
  wire       [2:0]    _zz_conv1_posCount_14;
  reg        [4:0]    _zz_conv1_posCount_15;
  wire       [2:0]    _zz_conv1_posCount_16;
  wire       [4:0]    _zz_conv1_posCount_17;
  reg        [4:0]    _zz_conv1_posCount_18;
  wire       [2:0]    _zz_conv1_posCount_19;
  reg        [4:0]    _zz_conv1_posCount_20;
  wire       [2:0]    _zz_conv1_posCount_21;
  wire       [4:0]    _zz_conv1_posCount_22;
  wire       [4:0]    _zz_conv1_posCount_23;
  reg        [4:0]    _zz_conv1_posCount_24;
  wire       [2:0]    _zz_conv1_posCount_25;
  reg        [4:0]    _zz_conv1_posCount_26;
  wire       [2:0]    _zz_conv1_posCount_27;
  wire       [4:0]    _zz_conv1_posCount_28;
  reg        [4:0]    _zz_conv1_posCount_29;
  wire       [2:0]    _zz_conv1_posCount_30;
  reg        [4:0]    _zz_conv1_posCount_31;
  wire       [2:0]    _zz_conv1_posCount_32;
  reg        [4:0]    _zz_conv1_posCount_33;
  wire       [2:0]    _zz_conv1_posCount_34;
  wire       [0:0]    _zz_conv1_posCount_35;
  wire       [5:0]    _zz_conv1_negCount_8;
  wire       [4:0]    _zz_conv1_negCount_9;
  wire       [4:0]    _zz_conv1_negCount_10;
  wire       [4:0]    _zz_conv1_negCount_11;
  wire       [4:0]    _zz_conv1_negCount_12;
  reg        [4:0]    _zz_conv1_negCount_13;
  wire       [2:0]    _zz_conv1_negCount_14;
  reg        [4:0]    _zz_conv1_negCount_15;
  wire       [2:0]    _zz_conv1_negCount_16;
  wire       [4:0]    _zz_conv1_negCount_17;
  reg        [4:0]    _zz_conv1_negCount_18;
  wire       [2:0]    _zz_conv1_negCount_19;
  reg        [4:0]    _zz_conv1_negCount_20;
  wire       [2:0]    _zz_conv1_negCount_21;
  wire       [4:0]    _zz_conv1_negCount_22;
  wire       [4:0]    _zz_conv1_negCount_23;
  reg        [4:0]    _zz_conv1_negCount_24;
  wire       [2:0]    _zz_conv1_negCount_25;
  reg        [4:0]    _zz_conv1_negCount_26;
  wire       [2:0]    _zz_conv1_negCount_27;
  wire       [4:0]    _zz_conv1_negCount_28;
  reg        [4:0]    _zz_conv1_negCount_29;
  wire       [2:0]    _zz_conv1_negCount_30;
  reg        [4:0]    _zz_conv1_negCount_31;
  wire       [2:0]    _zz_conv1_negCount_32;
  reg        [4:0]    _zz_conv1_negCount_33;
  wire       [2:0]    _zz_conv1_negCount_34;
  wire       [0:0]    _zz_conv1_negCount_35;
  wire       [4:0]    _zz_conv1_rxRow;
  wire       [9:0]    _zz_conv1_actBuf_port;
  wire       [9:0]    _zz_conv1_actBuf_port_1;
  wire       [9:0]    _zz_conv1_actBuf_port_2;
  wire       [7:0]    _zz_conv1_actBuf_port_3;
  wire       [7:0]    _zz_conv1_actBuf_port_4;
  wire       [10:0]   _zz_conv1_pixelBase;
  wire       [10:0]   _zz_conv1_pixelBase_1;
  wire       [5:0]    _zz_conv1_pixelBase_2;
  reg        [10:0]   _zz_conv1_actReadAddr;
  wire       [9:0]    _zz_conv1_actBuf_port_5;
  wire       [9:0]    _zz_conv1_actBufRead;
  wire       [7:0]    _zz__zz_conv1_wThrRead;
  wire       [7:0]    _zz__zz_conv1_wSignRead;
  wire       [2:0]    _zz_conv1_combAdjRom_port;
  wire       [2:0]    _zz_conv1_combAdjRead_2;
  wire       [14:0]   _zz_conv1_scAcc;
  wire       [5:0]    _zz_conv1_scAcc_1;
  wire       [26:0]   _zz__zz_conv1_activationOut_payload_value;
  wire       [48:0]   _zz__zz_conv1_activationOut_payload_value_1;
  wire       [16:0]   _zz__zz_conv1_activationOut_payload_value_2;
  wire       [31:0]   _zz__zz_conv1_activationOut_payload_value_3;
  wire       [31:0]   _zz__zz_conv1_activationOut_payload_value_4;
  wire       [7:0]    _zz_conv1_activationOut_payload_value_1;
  wire       [7:0]    _zz_conv1_activationOut_payload_value_2;
  wire       [3:0]    _zz_conv1_ocReg;
  wire       [7:0]    _zz_conv1_wAddrBase;
  wire       [4:0]    _zz_conv1_outWReg;
  wire       [4:0]    _zz_conv1_outHReg;
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
  wire       [8:0]    _zz_conv2_posCount_8;
  wire       [7:0]    _zz_conv2_posCount_9;
  wire       [7:0]    _zz_conv2_posCount_10;
  wire       [7:0]    _zz_conv2_posCount_11;
  wire       [7:0]    _zz_conv2_posCount_12;
  wire       [7:0]    _zz_conv2_posCount_13;
  wire       [7:0]    _zz_conv2_posCount_14;
  wire       [7:0]    _zz_conv2_posCount_15;
  reg        [7:0]    _zz_conv2_posCount_16;
  wire       [2:0]    _zz_conv2_posCount_17;
  reg        [7:0]    _zz_conv2_posCount_18;
  wire       [2:0]    _zz_conv2_posCount_19;
  wire       [7:0]    _zz_conv2_posCount_20;
  reg        [7:0]    _zz_conv2_posCount_21;
  wire       [2:0]    _zz_conv2_posCount_22;
  reg        [7:0]    _zz_conv2_posCount_23;
  wire       [2:0]    _zz_conv2_posCount_24;
  wire       [7:0]    _zz_conv2_posCount_25;
  wire       [7:0]    _zz_conv2_posCount_26;
  reg        [7:0]    _zz_conv2_posCount_27;
  wire       [2:0]    _zz_conv2_posCount_28;
  reg        [7:0]    _zz_conv2_posCount_29;
  wire       [2:0]    _zz_conv2_posCount_30;
  wire       [7:0]    _zz_conv2_posCount_31;
  reg        [7:0]    _zz_conv2_posCount_32;
  wire       [2:0]    _zz_conv2_posCount_33;
  reg        [7:0]    _zz_conv2_posCount_34;
  wire       [2:0]    _zz_conv2_posCount_35;
  wire       [7:0]    _zz_conv2_posCount_36;
  wire       [7:0]    _zz_conv2_posCount_37;
  wire       [7:0]    _zz_conv2_posCount_38;
  reg        [7:0]    _zz_conv2_posCount_39;
  wire       [2:0]    _zz_conv2_posCount_40;
  reg        [7:0]    _zz_conv2_posCount_41;
  wire       [2:0]    _zz_conv2_posCount_42;
  wire       [7:0]    _zz_conv2_posCount_43;
  reg        [7:0]    _zz_conv2_posCount_44;
  wire       [2:0]    _zz_conv2_posCount_45;
  reg        [7:0]    _zz_conv2_posCount_46;
  wire       [2:0]    _zz_conv2_posCount_47;
  wire       [7:0]    _zz_conv2_posCount_48;
  wire       [7:0]    _zz_conv2_posCount_49;
  reg        [7:0]    _zz_conv2_posCount_50;
  wire       [2:0]    _zz_conv2_posCount_51;
  reg        [7:0]    _zz_conv2_posCount_52;
  wire       [2:0]    _zz_conv2_posCount_53;
  wire       [7:0]    _zz_conv2_posCount_54;
  reg        [7:0]    _zz_conv2_posCount_55;
  wire       [2:0]    _zz_conv2_posCount_56;
  reg        [7:0]    _zz_conv2_posCount_57;
  wire       [2:0]    _zz_conv2_posCount_58;
  wire       [7:0]    _zz_conv2_posCount_59;
  wire       [7:0]    _zz_conv2_posCount_60;
  wire       [7:0]    _zz_conv2_posCount_61;
  wire       [7:0]    _zz_conv2_posCount_62;
  reg        [7:0]    _zz_conv2_posCount_63;
  wire       [2:0]    _zz_conv2_posCount_64;
  reg        [7:0]    _zz_conv2_posCount_65;
  wire       [2:0]    _zz_conv2_posCount_66;
  wire       [7:0]    _zz_conv2_posCount_67;
  reg        [7:0]    _zz_conv2_posCount_68;
  wire       [2:0]    _zz_conv2_posCount_69;
  reg        [7:0]    _zz_conv2_posCount_70;
  wire       [2:0]    _zz_conv2_posCount_71;
  wire       [7:0]    _zz_conv2_posCount_72;
  wire       [7:0]    _zz_conv2_posCount_73;
  reg        [7:0]    _zz_conv2_posCount_74;
  wire       [2:0]    _zz_conv2_posCount_75;
  reg        [7:0]    _zz_conv2_posCount_76;
  wire       [2:0]    _zz_conv2_posCount_77;
  wire       [7:0]    _zz_conv2_posCount_78;
  reg        [7:0]    _zz_conv2_posCount_79;
  wire       [2:0]    _zz_conv2_posCount_80;
  reg        [7:0]    _zz_conv2_posCount_81;
  wire       [2:0]    _zz_conv2_posCount_82;
  wire       [7:0]    _zz_conv2_posCount_83;
  wire       [7:0]    _zz_conv2_posCount_84;
  wire       [7:0]    _zz_conv2_posCount_85;
  reg        [7:0]    _zz_conv2_posCount_86;
  wire       [2:0]    _zz_conv2_posCount_87;
  reg        [7:0]    _zz_conv2_posCount_88;
  wire       [2:0]    _zz_conv2_posCount_89;
  wire       [7:0]    _zz_conv2_posCount_90;
  reg        [7:0]    _zz_conv2_posCount_91;
  wire       [2:0]    _zz_conv2_posCount_92;
  reg        [7:0]    _zz_conv2_posCount_93;
  wire       [2:0]    _zz_conv2_posCount_94;
  wire       [7:0]    _zz_conv2_posCount_95;
  wire       [7:0]    _zz_conv2_posCount_96;
  reg        [7:0]    _zz_conv2_posCount_97;
  wire       [2:0]    _zz_conv2_posCount_98;
  reg        [7:0]    _zz_conv2_posCount_99;
  wire       [2:0]    _zz_conv2_posCount_100;
  wire       [7:0]    _zz_conv2_posCount_101;
  reg        [7:0]    _zz_conv2_posCount_102;
  wire       [2:0]    _zz_conv2_posCount_103;
  reg        [7:0]    _zz_conv2_posCount_104;
  wire       [2:0]    _zz_conv2_posCount_105;
  wire       [7:0]    _zz_conv2_posCount_106;
  wire       [7:0]    _zz_conv2_posCount_107;
  wire       [7:0]    _zz_conv2_posCount_108;
  wire       [7:0]    _zz_conv2_posCount_109;
  wire       [7:0]    _zz_conv2_posCount_110;
  reg        [7:0]    _zz_conv2_posCount_111;
  wire       [2:0]    _zz_conv2_posCount_112;
  reg        [7:0]    _zz_conv2_posCount_113;
  wire       [2:0]    _zz_conv2_posCount_114;
  wire       [7:0]    _zz_conv2_posCount_115;
  reg        [7:0]    _zz_conv2_posCount_116;
  wire       [2:0]    _zz_conv2_posCount_117;
  reg        [7:0]    _zz_conv2_posCount_118;
  wire       [2:0]    _zz_conv2_posCount_119;
  wire       [7:0]    _zz_conv2_posCount_120;
  wire       [7:0]    _zz_conv2_posCount_121;
  reg        [7:0]    _zz_conv2_posCount_122;
  wire       [2:0]    _zz_conv2_posCount_123;
  reg        [7:0]    _zz_conv2_posCount_124;
  wire       [2:0]    _zz_conv2_posCount_125;
  wire       [7:0]    _zz_conv2_posCount_126;
  reg        [7:0]    _zz_conv2_posCount_127;
  wire       [2:0]    _zz_conv2_posCount_128;
  reg        [7:0]    _zz_conv2_posCount_129;
  wire       [2:0]    _zz_conv2_posCount_130;
  wire       [7:0]    _zz_conv2_posCount_131;
  wire       [7:0]    _zz_conv2_posCount_132;
  wire       [7:0]    _zz_conv2_posCount_133;
  reg        [7:0]    _zz_conv2_posCount_134;
  wire       [2:0]    _zz_conv2_posCount_135;
  reg        [7:0]    _zz_conv2_posCount_136;
  wire       [2:0]    _zz_conv2_posCount_137;
  wire       [7:0]    _zz_conv2_posCount_138;
  reg        [7:0]    _zz_conv2_posCount_139;
  wire       [2:0]    _zz_conv2_posCount_140;
  reg        [7:0]    _zz_conv2_posCount_141;
  wire       [2:0]    _zz_conv2_posCount_142;
  wire       [7:0]    _zz_conv2_posCount_143;
  wire       [7:0]    _zz_conv2_posCount_144;
  reg        [7:0]    _zz_conv2_posCount_145;
  wire       [2:0]    _zz_conv2_posCount_146;
  reg        [7:0]    _zz_conv2_posCount_147;
  wire       [2:0]    _zz_conv2_posCount_148;
  wire       [7:0]    _zz_conv2_posCount_149;
  reg        [7:0]    _zz_conv2_posCount_150;
  wire       [2:0]    _zz_conv2_posCount_151;
  reg        [7:0]    _zz_conv2_posCount_152;
  wire       [2:0]    _zz_conv2_posCount_153;
  wire       [7:0]    _zz_conv2_posCount_154;
  wire       [7:0]    _zz_conv2_posCount_155;
  wire       [7:0]    _zz_conv2_posCount_156;
  wire       [7:0]    _zz_conv2_posCount_157;
  reg        [7:0]    _zz_conv2_posCount_158;
  wire       [2:0]    _zz_conv2_posCount_159;
  reg        [7:0]    _zz_conv2_posCount_160;
  wire       [2:0]    _zz_conv2_posCount_161;
  wire       [7:0]    _zz_conv2_posCount_162;
  reg        [7:0]    _zz_conv2_posCount_163;
  wire       [2:0]    _zz_conv2_posCount_164;
  reg        [7:0]    _zz_conv2_posCount_165;
  wire       [2:0]    _zz_conv2_posCount_166;
  wire       [7:0]    _zz_conv2_posCount_167;
  wire       [7:0]    _zz_conv2_posCount_168;
  reg        [7:0]    _zz_conv2_posCount_169;
  wire       [2:0]    _zz_conv2_posCount_170;
  reg        [7:0]    _zz_conv2_posCount_171;
  wire       [2:0]    _zz_conv2_posCount_172;
  wire       [7:0]    _zz_conv2_posCount_173;
  reg        [7:0]    _zz_conv2_posCount_174;
  wire       [2:0]    _zz_conv2_posCount_175;
  reg        [7:0]    _zz_conv2_posCount_176;
  wire       [2:0]    _zz_conv2_posCount_177;
  wire       [7:0]    _zz_conv2_posCount_178;
  wire       [7:0]    _zz_conv2_posCount_179;
  wire       [7:0]    _zz_conv2_posCount_180;
  reg        [7:0]    _zz_conv2_posCount_181;
  wire       [2:0]    _zz_conv2_posCount_182;
  reg        [7:0]    _zz_conv2_posCount_183;
  wire       [2:0]    _zz_conv2_posCount_184;
  wire       [7:0]    _zz_conv2_posCount_185;
  reg        [7:0]    _zz_conv2_posCount_186;
  wire       [2:0]    _zz_conv2_posCount_187;
  reg        [7:0]    _zz_conv2_posCount_188;
  wire       [2:0]    _zz_conv2_posCount_189;
  wire       [7:0]    _zz_conv2_posCount_190;
  wire       [7:0]    _zz_conv2_posCount_191;
  reg        [7:0]    _zz_conv2_posCount_192;
  wire       [2:0]    _zz_conv2_posCount_193;
  reg        [7:0]    _zz_conv2_posCount_194;
  wire       [2:0]    _zz_conv2_posCount_195;
  wire       [7:0]    _zz_conv2_posCount_196;
  reg        [7:0]    _zz_conv2_posCount_197;
  wire       [2:0]    _zz_conv2_posCount_198;
  reg        [7:0]    _zz_conv2_posCount_199;
  wire       [2:0]    _zz_conv2_posCount_200;
  wire       [7:0]    _zz_conv2_posCount_201;
  wire       [7:0]    _zz_conv2_posCount_202;
  reg        [7:0]    _zz_conv2_posCount_203;
  wire       [2:0]    _zz_conv2_posCount_204;
  reg        [7:0]    _zz_conv2_posCount_205;
  wire       [2:0]    _zz_conv2_posCount_206;
  reg        [7:0]    _zz_conv2_posCount_207;
  wire       [2:0]    _zz_conv2_posCount_208;
  wire       [1:0]    _zz_conv2_posCount_209;
  wire       [8:0]    _zz_conv2_negCount_8;
  wire       [7:0]    _zz_conv2_negCount_9;
  wire       [7:0]    _zz_conv2_negCount_10;
  wire       [7:0]    _zz_conv2_negCount_11;
  wire       [7:0]    _zz_conv2_negCount_12;
  wire       [7:0]    _zz_conv2_negCount_13;
  wire       [7:0]    _zz_conv2_negCount_14;
  wire       [7:0]    _zz_conv2_negCount_15;
  reg        [7:0]    _zz_conv2_negCount_16;
  wire       [2:0]    _zz_conv2_negCount_17;
  reg        [7:0]    _zz_conv2_negCount_18;
  wire       [2:0]    _zz_conv2_negCount_19;
  wire       [7:0]    _zz_conv2_negCount_20;
  reg        [7:0]    _zz_conv2_negCount_21;
  wire       [2:0]    _zz_conv2_negCount_22;
  reg        [7:0]    _zz_conv2_negCount_23;
  wire       [2:0]    _zz_conv2_negCount_24;
  wire       [7:0]    _zz_conv2_negCount_25;
  wire       [7:0]    _zz_conv2_negCount_26;
  reg        [7:0]    _zz_conv2_negCount_27;
  wire       [2:0]    _zz_conv2_negCount_28;
  reg        [7:0]    _zz_conv2_negCount_29;
  wire       [2:0]    _zz_conv2_negCount_30;
  wire       [7:0]    _zz_conv2_negCount_31;
  reg        [7:0]    _zz_conv2_negCount_32;
  wire       [2:0]    _zz_conv2_negCount_33;
  reg        [7:0]    _zz_conv2_negCount_34;
  wire       [2:0]    _zz_conv2_negCount_35;
  wire       [7:0]    _zz_conv2_negCount_36;
  wire       [7:0]    _zz_conv2_negCount_37;
  wire       [7:0]    _zz_conv2_negCount_38;
  reg        [7:0]    _zz_conv2_negCount_39;
  wire       [2:0]    _zz_conv2_negCount_40;
  reg        [7:0]    _zz_conv2_negCount_41;
  wire       [2:0]    _zz_conv2_negCount_42;
  wire       [7:0]    _zz_conv2_negCount_43;
  reg        [7:0]    _zz_conv2_negCount_44;
  wire       [2:0]    _zz_conv2_negCount_45;
  reg        [7:0]    _zz_conv2_negCount_46;
  wire       [2:0]    _zz_conv2_negCount_47;
  wire       [7:0]    _zz_conv2_negCount_48;
  wire       [7:0]    _zz_conv2_negCount_49;
  reg        [7:0]    _zz_conv2_negCount_50;
  wire       [2:0]    _zz_conv2_negCount_51;
  reg        [7:0]    _zz_conv2_negCount_52;
  wire       [2:0]    _zz_conv2_negCount_53;
  wire       [7:0]    _zz_conv2_negCount_54;
  reg        [7:0]    _zz_conv2_negCount_55;
  wire       [2:0]    _zz_conv2_negCount_56;
  reg        [7:0]    _zz_conv2_negCount_57;
  wire       [2:0]    _zz_conv2_negCount_58;
  wire       [7:0]    _zz_conv2_negCount_59;
  wire       [7:0]    _zz_conv2_negCount_60;
  wire       [7:0]    _zz_conv2_negCount_61;
  wire       [7:0]    _zz_conv2_negCount_62;
  reg        [7:0]    _zz_conv2_negCount_63;
  wire       [2:0]    _zz_conv2_negCount_64;
  reg        [7:0]    _zz_conv2_negCount_65;
  wire       [2:0]    _zz_conv2_negCount_66;
  wire       [7:0]    _zz_conv2_negCount_67;
  reg        [7:0]    _zz_conv2_negCount_68;
  wire       [2:0]    _zz_conv2_negCount_69;
  reg        [7:0]    _zz_conv2_negCount_70;
  wire       [2:0]    _zz_conv2_negCount_71;
  wire       [7:0]    _zz_conv2_negCount_72;
  wire       [7:0]    _zz_conv2_negCount_73;
  reg        [7:0]    _zz_conv2_negCount_74;
  wire       [2:0]    _zz_conv2_negCount_75;
  reg        [7:0]    _zz_conv2_negCount_76;
  wire       [2:0]    _zz_conv2_negCount_77;
  wire       [7:0]    _zz_conv2_negCount_78;
  reg        [7:0]    _zz_conv2_negCount_79;
  wire       [2:0]    _zz_conv2_negCount_80;
  reg        [7:0]    _zz_conv2_negCount_81;
  wire       [2:0]    _zz_conv2_negCount_82;
  wire       [7:0]    _zz_conv2_negCount_83;
  wire       [7:0]    _zz_conv2_negCount_84;
  wire       [7:0]    _zz_conv2_negCount_85;
  reg        [7:0]    _zz_conv2_negCount_86;
  wire       [2:0]    _zz_conv2_negCount_87;
  reg        [7:0]    _zz_conv2_negCount_88;
  wire       [2:0]    _zz_conv2_negCount_89;
  wire       [7:0]    _zz_conv2_negCount_90;
  reg        [7:0]    _zz_conv2_negCount_91;
  wire       [2:0]    _zz_conv2_negCount_92;
  reg        [7:0]    _zz_conv2_negCount_93;
  wire       [2:0]    _zz_conv2_negCount_94;
  wire       [7:0]    _zz_conv2_negCount_95;
  wire       [7:0]    _zz_conv2_negCount_96;
  reg        [7:0]    _zz_conv2_negCount_97;
  wire       [2:0]    _zz_conv2_negCount_98;
  reg        [7:0]    _zz_conv2_negCount_99;
  wire       [2:0]    _zz_conv2_negCount_100;
  wire       [7:0]    _zz_conv2_negCount_101;
  reg        [7:0]    _zz_conv2_negCount_102;
  wire       [2:0]    _zz_conv2_negCount_103;
  reg        [7:0]    _zz_conv2_negCount_104;
  wire       [2:0]    _zz_conv2_negCount_105;
  wire       [7:0]    _zz_conv2_negCount_106;
  wire       [7:0]    _zz_conv2_negCount_107;
  wire       [7:0]    _zz_conv2_negCount_108;
  wire       [7:0]    _zz_conv2_negCount_109;
  wire       [7:0]    _zz_conv2_negCount_110;
  reg        [7:0]    _zz_conv2_negCount_111;
  wire       [2:0]    _zz_conv2_negCount_112;
  reg        [7:0]    _zz_conv2_negCount_113;
  wire       [2:0]    _zz_conv2_negCount_114;
  wire       [7:0]    _zz_conv2_negCount_115;
  reg        [7:0]    _zz_conv2_negCount_116;
  wire       [2:0]    _zz_conv2_negCount_117;
  reg        [7:0]    _zz_conv2_negCount_118;
  wire       [2:0]    _zz_conv2_negCount_119;
  wire       [7:0]    _zz_conv2_negCount_120;
  wire       [7:0]    _zz_conv2_negCount_121;
  reg        [7:0]    _zz_conv2_negCount_122;
  wire       [2:0]    _zz_conv2_negCount_123;
  reg        [7:0]    _zz_conv2_negCount_124;
  wire       [2:0]    _zz_conv2_negCount_125;
  wire       [7:0]    _zz_conv2_negCount_126;
  reg        [7:0]    _zz_conv2_negCount_127;
  wire       [2:0]    _zz_conv2_negCount_128;
  reg        [7:0]    _zz_conv2_negCount_129;
  wire       [2:0]    _zz_conv2_negCount_130;
  wire       [7:0]    _zz_conv2_negCount_131;
  wire       [7:0]    _zz_conv2_negCount_132;
  wire       [7:0]    _zz_conv2_negCount_133;
  reg        [7:0]    _zz_conv2_negCount_134;
  wire       [2:0]    _zz_conv2_negCount_135;
  reg        [7:0]    _zz_conv2_negCount_136;
  wire       [2:0]    _zz_conv2_negCount_137;
  wire       [7:0]    _zz_conv2_negCount_138;
  reg        [7:0]    _zz_conv2_negCount_139;
  wire       [2:0]    _zz_conv2_negCount_140;
  reg        [7:0]    _zz_conv2_negCount_141;
  wire       [2:0]    _zz_conv2_negCount_142;
  wire       [7:0]    _zz_conv2_negCount_143;
  wire       [7:0]    _zz_conv2_negCount_144;
  reg        [7:0]    _zz_conv2_negCount_145;
  wire       [2:0]    _zz_conv2_negCount_146;
  reg        [7:0]    _zz_conv2_negCount_147;
  wire       [2:0]    _zz_conv2_negCount_148;
  wire       [7:0]    _zz_conv2_negCount_149;
  reg        [7:0]    _zz_conv2_negCount_150;
  wire       [2:0]    _zz_conv2_negCount_151;
  reg        [7:0]    _zz_conv2_negCount_152;
  wire       [2:0]    _zz_conv2_negCount_153;
  wire       [7:0]    _zz_conv2_negCount_154;
  wire       [7:0]    _zz_conv2_negCount_155;
  wire       [7:0]    _zz_conv2_negCount_156;
  wire       [7:0]    _zz_conv2_negCount_157;
  reg        [7:0]    _zz_conv2_negCount_158;
  wire       [2:0]    _zz_conv2_negCount_159;
  reg        [7:0]    _zz_conv2_negCount_160;
  wire       [2:0]    _zz_conv2_negCount_161;
  wire       [7:0]    _zz_conv2_negCount_162;
  reg        [7:0]    _zz_conv2_negCount_163;
  wire       [2:0]    _zz_conv2_negCount_164;
  reg        [7:0]    _zz_conv2_negCount_165;
  wire       [2:0]    _zz_conv2_negCount_166;
  wire       [7:0]    _zz_conv2_negCount_167;
  wire       [7:0]    _zz_conv2_negCount_168;
  reg        [7:0]    _zz_conv2_negCount_169;
  wire       [2:0]    _zz_conv2_negCount_170;
  reg        [7:0]    _zz_conv2_negCount_171;
  wire       [2:0]    _zz_conv2_negCount_172;
  wire       [7:0]    _zz_conv2_negCount_173;
  reg        [7:0]    _zz_conv2_negCount_174;
  wire       [2:0]    _zz_conv2_negCount_175;
  reg        [7:0]    _zz_conv2_negCount_176;
  wire       [2:0]    _zz_conv2_negCount_177;
  wire       [7:0]    _zz_conv2_negCount_178;
  wire       [7:0]    _zz_conv2_negCount_179;
  wire       [7:0]    _zz_conv2_negCount_180;
  reg        [7:0]    _zz_conv2_negCount_181;
  wire       [2:0]    _zz_conv2_negCount_182;
  reg        [7:0]    _zz_conv2_negCount_183;
  wire       [2:0]    _zz_conv2_negCount_184;
  wire       [7:0]    _zz_conv2_negCount_185;
  reg        [7:0]    _zz_conv2_negCount_186;
  wire       [2:0]    _zz_conv2_negCount_187;
  reg        [7:0]    _zz_conv2_negCount_188;
  wire       [2:0]    _zz_conv2_negCount_189;
  wire       [7:0]    _zz_conv2_negCount_190;
  wire       [7:0]    _zz_conv2_negCount_191;
  reg        [7:0]    _zz_conv2_negCount_192;
  wire       [2:0]    _zz_conv2_negCount_193;
  reg        [7:0]    _zz_conv2_negCount_194;
  wire       [2:0]    _zz_conv2_negCount_195;
  wire       [7:0]    _zz_conv2_negCount_196;
  reg        [7:0]    _zz_conv2_negCount_197;
  wire       [2:0]    _zz_conv2_negCount_198;
  reg        [7:0]    _zz_conv2_negCount_199;
  wire       [2:0]    _zz_conv2_negCount_200;
  wire       [7:0]    _zz_conv2_negCount_201;
  wire       [7:0]    _zz_conv2_negCount_202;
  reg        [7:0]    _zz_conv2_negCount_203;
  wire       [2:0]    _zz_conv2_negCount_204;
  reg        [7:0]    _zz_conv2_negCount_205;
  wire       [2:0]    _zz_conv2_negCount_206;
  reg        [7:0]    _zz_conv2_negCount_207;
  wire       [2:0]    _zz_conv2_negCount_208;
  wire       [1:0]    _zz_conv2_negCount_209;
  wire       [6:0]    _zz_conv2_rxRow;
  wire       [11:0]   _zz_conv2_actBuf_port;
  wire       [7:0]    _zz_conv2_actBuf_port_1;
  wire       [7:0]    _zz_conv2_actBuf_port_2;
  wire       [11:0]   _zz_conv2_pixelBase;
  wire       [11:0]   _zz_conv2_pixelBase_1;
  wire       [7:0]    _zz_conv2_pixelBase_2;
  reg        [11:0]   _zz_conv2_actReadAddr;
  wire       [11:0]   _zz__zz_conv2_wThrRead;
  wire       [11:0]   _zz__zz_conv2_wSignRead;
  wire       [3:0]    _zz_conv2_combAdjRom_port;
  wire       [3:0]    _zz_conv2_combAdjRead_2;
  wire       [17:0]   _zz_conv2_scAcc;
  wire       [8:0]    _zz_conv2_scAcc_1;
  wire       [29:0]   _zz__zz_conv2_activationOut_payload_value;
  wire       [51:0]   _zz__zz_conv2_activationOut_payload_value_1;
  wire       [19:0]   _zz__zz_conv2_activationOut_payload_value_2;
  wire       [31:0]   _zz__zz_conv2_activationOut_payload_value_3;
  wire       [31:0]   _zz__zz_conv2_activationOut_payload_value_4;
  wire       [7:0]    _zz_conv2_activationOut_payload_value_1;
  wire       [7:0]    _zz_conv2_activationOut_payload_value_2;
  wire       [4:0]    _zz_conv2_ocReg;
  wire       [11:0]   _zz_conv2_wAddrBase;
  wire       [3:0]    _zz_conv2_outWReg;
  wire       [3:0]    _zz_conv2_outHReg;
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
  reg                 _zz_2;
  reg                 _zz_3;
  wire                StochasticConvPlugin_logic_outStream_valid;
  wire                StochasticConvPlugin_logic_outStream_ready;
  wire       [7:0]    StochasticConvPlugin_logic_outStream_payload_value;
  wire       [2:0]    conv1_sRx;
  wire       [2:0]    conv1_sInit;
  wire       [2:0]    conv1_sLoad;
  wire       [2:0]    conv1_sSC;
  wire       [2:0]    conv1_sDecode;
  reg        [2:0]    conv1_state;
  reg        [7:0]    conv1_wRootLfsr;
  reg        [7:0]    conv1_aRootLfsr;
  reg        [7:0]    conv1_wLfsrChain_0;
  reg        [7:0]    conv1_wLfsrChain_1;
  reg        [7:0]    conv1_wLfsrChain_2;
  reg        [7:0]    conv1_wLfsrChain_3;
  reg        [7:0]    conv1_wLfsrChain_4;
  reg        [7:0]    conv1_wLfsrChain_5;
  reg        [7:0]    conv1_wLfsrChain_6;
  reg        [7:0]    conv1_wLfsrChain_7;
  reg        [7:0]    conv1_wLfsrChain_8;
  reg        [7:0]    conv1_wLfsrChain_9;
  reg        [7:0]    conv1_wLfsrChain_10;
  reg        [7:0]    conv1_wLfsrChain_11;
  reg        [7:0]    conv1_wLfsrChain_12;
  reg        [7:0]    conv1_wLfsrChain_13;
  reg        [7:0]    conv1_wLfsrChain_14;
  reg        [7:0]    conv1_wLfsrChain_15;
  reg        [7:0]    conv1_wLfsrChain_16;
  reg        [7:0]    conv1_wLfsrChain_17;
  reg        [7:0]    conv1_wLfsrChain_18;
  reg        [7:0]    conv1_wLfsrChain_19;
  reg        [7:0]    conv1_wLfsrChain_20;
  reg        [7:0]    conv1_wLfsrChain_21;
  reg        [7:0]    conv1_wLfsrChain_22;
  reg        [7:0]    conv1_wLfsrChain_23;
  reg        [7:0]    conv1_wLfsrChain_24;
  reg        [7:0]    conv1_aLfsrChain_0;
  reg        [7:0]    conv1_aLfsrChain_1;
  reg        [7:0]    conv1_aLfsrChain_2;
  reg        [7:0]    conv1_aLfsrChain_3;
  reg        [7:0]    conv1_aLfsrChain_4;
  reg        [7:0]    conv1_aLfsrChain_5;
  reg        [7:0]    conv1_aLfsrChain_6;
  reg        [7:0]    conv1_aLfsrChain_7;
  reg        [7:0]    conv1_aLfsrChain_8;
  reg        [7:0]    conv1_aLfsrChain_9;
  reg        [7:0]    conv1_aLfsrChain_10;
  reg        [7:0]    conv1_aLfsrChain_11;
  reg        [7:0]    conv1_aLfsrChain_12;
  reg        [7:0]    conv1_aLfsrChain_13;
  reg        [7:0]    conv1_aLfsrChain_14;
  reg        [7:0]    conv1_aLfsrChain_15;
  reg        [7:0]    conv1_aLfsrChain_16;
  reg        [7:0]    conv1_aLfsrChain_17;
  reg        [7:0]    conv1_aLfsrChain_18;
  reg        [7:0]    conv1_aLfsrChain_19;
  reg        [7:0]    conv1_aLfsrChain_20;
  reg        [7:0]    conv1_aLfsrChain_21;
  reg        [7:0]    conv1_aLfsrChain_22;
  reg        [7:0]    conv1_aLfsrChain_23;
  reg        [7:0]    conv1_aLfsrChain_24;
  reg        [7:0]    conv1_activThresh_0;
  reg        [7:0]    conv1_activThresh_1;
  reg        [7:0]    conv1_activThresh_2;
  reg        [7:0]    conv1_activThresh_3;
  reg        [7:0]    conv1_activThresh_4;
  reg        [7:0]    conv1_activThresh_5;
  reg        [7:0]    conv1_activThresh_6;
  reg        [7:0]    conv1_activThresh_7;
  reg        [7:0]    conv1_activThresh_8;
  reg        [7:0]    conv1_activThresh_9;
  reg        [7:0]    conv1_activThresh_10;
  reg        [7:0]    conv1_activThresh_11;
  reg        [7:0]    conv1_activThresh_12;
  reg        [7:0]    conv1_activThresh_13;
  reg        [7:0]    conv1_activThresh_14;
  reg        [7:0]    conv1_activThresh_15;
  reg        [7:0]    conv1_activThresh_16;
  reg        [7:0]    conv1_activThresh_17;
  reg        [7:0]    conv1_activThresh_18;
  reg        [7:0]    conv1_activThresh_19;
  reg        [7:0]    conv1_activThresh_20;
  reg        [7:0]    conv1_activThresh_21;
  reg        [7:0]    conv1_activThresh_22;
  reg        [7:0]    conv1_activThresh_23;
  reg        [7:0]    conv1_activThresh_24;
  reg        [7:0]    conv1_wThrRegs_0;
  reg        [7:0]    conv1_wThrRegs_1;
  reg        [7:0]    conv1_wThrRegs_2;
  reg        [7:0]    conv1_wThrRegs_3;
  reg        [7:0]    conv1_wThrRegs_4;
  reg        [7:0]    conv1_wThrRegs_5;
  reg        [7:0]    conv1_wThrRegs_6;
  reg        [7:0]    conv1_wThrRegs_7;
  reg        [7:0]    conv1_wThrRegs_8;
  reg        [7:0]    conv1_wThrRegs_9;
  reg        [7:0]    conv1_wThrRegs_10;
  reg        [7:0]    conv1_wThrRegs_11;
  reg        [7:0]    conv1_wThrRegs_12;
  reg        [7:0]    conv1_wThrRegs_13;
  reg        [7:0]    conv1_wThrRegs_14;
  reg        [7:0]    conv1_wThrRegs_15;
  reg        [7:0]    conv1_wThrRegs_16;
  reg        [7:0]    conv1_wThrRegs_17;
  reg        [7:0]    conv1_wThrRegs_18;
  reg        [7:0]    conv1_wThrRegs_19;
  reg        [7:0]    conv1_wThrRegs_20;
  reg        [7:0]    conv1_wThrRegs_21;
  reg        [7:0]    conv1_wThrRegs_22;
  reg        [7:0]    conv1_wThrRegs_23;
  reg        [7:0]    conv1_wThrRegs_24;
  reg                 conv1_wSignRegs_0;
  reg                 conv1_wSignRegs_1;
  reg                 conv1_wSignRegs_2;
  reg                 conv1_wSignRegs_3;
  reg                 conv1_wSignRegs_4;
  reg                 conv1_wSignRegs_5;
  reg                 conv1_wSignRegs_6;
  reg                 conv1_wSignRegs_7;
  reg                 conv1_wSignRegs_8;
  reg                 conv1_wSignRegs_9;
  reg                 conv1_wSignRegs_10;
  reg                 conv1_wSignRegs_11;
  reg                 conv1_wSignRegs_12;
  reg                 conv1_wSignRegs_13;
  reg                 conv1_wSignRegs_14;
  reg                 conv1_wSignRegs_15;
  reg                 conv1_wSignRegs_16;
  reg                 conv1_wSignRegs_17;
  reg                 conv1_wSignRegs_18;
  reg                 conv1_wSignRegs_19;
  reg                 conv1_wSignRegs_20;
  reg                 conv1_wSignRegs_21;
  reg                 conv1_wSignRegs_22;
  reg                 conv1_wSignRegs_23;
  reg                 conv1_wSignRegs_24;
  reg        [14:0]   conv1_scAcc;
  reg        [31:0]   conv1_combAdjReg;
  reg                 conv1_posBitRegs_0;
  reg                 conv1_posBitRegs_1;
  reg                 conv1_posBitRegs_2;
  reg                 conv1_posBitRegs_3;
  reg                 conv1_posBitRegs_4;
  reg                 conv1_posBitRegs_5;
  reg                 conv1_posBitRegs_6;
  reg                 conv1_posBitRegs_7;
  reg                 conv1_posBitRegs_8;
  reg                 conv1_posBitRegs_9;
  reg                 conv1_posBitRegs_10;
  reg                 conv1_posBitRegs_11;
  reg                 conv1_posBitRegs_12;
  reg                 conv1_posBitRegs_13;
  reg                 conv1_posBitRegs_14;
  reg                 conv1_posBitRegs_15;
  reg                 conv1_posBitRegs_16;
  reg                 conv1_posBitRegs_17;
  reg                 conv1_posBitRegs_18;
  reg                 conv1_posBitRegs_19;
  reg                 conv1_posBitRegs_20;
  reg                 conv1_posBitRegs_21;
  reg                 conv1_posBitRegs_22;
  reg                 conv1_posBitRegs_23;
  reg                 conv1_posBitRegs_24;
  reg                 conv1_negBitRegs_0;
  reg                 conv1_negBitRegs_1;
  reg                 conv1_negBitRegs_2;
  reg                 conv1_negBitRegs_3;
  reg                 conv1_negBitRegs_4;
  reg                 conv1_negBitRegs_5;
  reg                 conv1_negBitRegs_6;
  reg                 conv1_negBitRegs_7;
  reg                 conv1_negBitRegs_8;
  reg                 conv1_negBitRegs_9;
  reg                 conv1_negBitRegs_10;
  reg                 conv1_negBitRegs_11;
  reg                 conv1_negBitRegs_12;
  reg                 conv1_negBitRegs_13;
  reg                 conv1_negBitRegs_14;
  reg                 conv1_negBitRegs_15;
  reg                 conv1_negBitRegs_16;
  reg                 conv1_negBitRegs_17;
  reg                 conv1_negBitRegs_18;
  reg                 conv1_negBitRegs_19;
  reg                 conv1_negBitRegs_20;
  reg                 conv1_negBitRegs_21;
  reg                 conv1_negBitRegs_22;
  reg                 conv1_negBitRegs_23;
  reg                 conv1_negBitRegs_24;
  wire                _zz_conv1_posBitRegs_0;
  wire                _zz_conv1_posBitRegs_1;
  wire                _zz_conv1_posBitRegs_2;
  wire                _zz_conv1_posBitRegs_3;
  wire                _zz_conv1_posBitRegs_4;
  wire                _zz_conv1_posBitRegs_5;
  wire                _zz_conv1_posBitRegs_6;
  wire                _zz_conv1_posBitRegs_7;
  wire                _zz_conv1_posBitRegs_8;
  wire                _zz_conv1_posBitRegs_9;
  wire                _zz_conv1_posBitRegs_10;
  wire                _zz_conv1_posBitRegs_11;
  wire                _zz_conv1_posBitRegs_12;
  wire                _zz_conv1_posBitRegs_13;
  wire                _zz_conv1_posBitRegs_14;
  wire                _zz_conv1_posBitRegs_15;
  wire                _zz_conv1_posBitRegs_16;
  wire                _zz_conv1_posBitRegs_17;
  wire                _zz_conv1_posBitRegs_18;
  wire                _zz_conv1_posBitRegs_19;
  wire                _zz_conv1_posBitRegs_20;
  wire                _zz_conv1_posBitRegs_21;
  wire                _zz_conv1_posBitRegs_22;
  wire                _zz_conv1_posBitRegs_23;
  wire                _zz_conv1_posBitRegs_24;
  wire       [4:0]    _zz_conv1_posCount;
  wire       [4:0]    _zz_conv1_posCount_1;
  wire       [4:0]    _zz_conv1_posCount_2;
  wire       [4:0]    _zz_conv1_posCount_3;
  wire       [4:0]    _zz_conv1_posCount_4;
  wire       [4:0]    _zz_conv1_posCount_5;
  wire       [4:0]    _zz_conv1_posCount_6;
  wire       [4:0]    _zz_conv1_posCount_7;
  wire       [5:0]    conv1_posCount;
  wire       [4:0]    _zz_conv1_negCount;
  wire       [4:0]    _zz_conv1_negCount_1;
  wire       [4:0]    _zz_conv1_negCount_2;
  wire       [4:0]    _zz_conv1_negCount_3;
  wire       [4:0]    _zz_conv1_negCount_4;
  wire       [4:0]    _zz_conv1_negCount_5;
  wire       [4:0]    _zz_conv1_negCount_6;
  wire       [4:0]    _zz_conv1_negCount_7;
  wire       [5:0]    conv1_negCount;
  reg        [9:0]    conv1_rxCnt;
  reg        [10:0]   conv1_rxAddr;
  reg        [4:0]    conv1_rxRow;
  reg        [3:0]    conv1_ocReg;
  reg        [4:0]    conv1_outHReg;
  reg        [4:0]    conv1_outWReg;
  reg        [4:0]    conv1_loadStep;
  reg        [7:0]    conv1_scStep;
  reg        [7:0]    conv1_wAddrBase;
  reg        [10:0]   conv1_initAddr;
  reg                 conv1_activationOut_valid;
  wire                conv1_activationOut_ready;
  reg        [7:0]    conv1_activationOut_payload_value;
  wire                when_StochasticConvCore_l279;
  wire                when_StochasticConvCore_l280;
  wire                when_StochasticConvCore_l288;
  wire                io_activationIn_fire;
  wire                _zz_conv1_rxAddr;
  wire                when_StochasticConvCore_l295;
  wire                when_StochasticConvCore_l315;
  wire       [10:0]   conv1_pixelBase;
  wire       [10:0]   conv1_kOffVec_0;
  wire       [10:0]   conv1_kOffVec_1;
  wire       [10:0]   conv1_kOffVec_2;
  wire       [10:0]   conv1_kOffVec_3;
  wire       [10:0]   conv1_kOffVec_4;
  wire       [10:0]   conv1_kOffVec_5;
  wire       [10:0]   conv1_kOffVec_6;
  wire       [10:0]   conv1_kOffVec_7;
  wire       [10:0]   conv1_kOffVec_8;
  wire       [10:0]   conv1_kOffVec_9;
  wire       [10:0]   conv1_kOffVec_10;
  wire       [10:0]   conv1_kOffVec_11;
  wire       [10:0]   conv1_kOffVec_12;
  wire       [10:0]   conv1_kOffVec_13;
  wire       [10:0]   conv1_kOffVec_14;
  wire       [10:0]   conv1_kOffVec_15;
  wire       [10:0]   conv1_kOffVec_16;
  wire       [10:0]   conv1_kOffVec_17;
  wire       [10:0]   conv1_kOffVec_18;
  wire       [10:0]   conv1_kOffVec_19;
  wire       [10:0]   conv1_kOffVec_20;
  wire       [10:0]   conv1_kOffVec_21;
  wire       [10:0]   conv1_kOffVec_22;
  wire       [10:0]   conv1_kOffVec_23;
  wire       [10:0]   conv1_kOffVec_24;
  wire       [4:0]    conv1_safeStep;
  wire       [10:0]   conv1_actReadAddr;
  wire                conv1_loadInRange;
  wire       [7:0]    conv1_actBufRead;
  wire       [7:0]    _zz_conv1_wThrRead;
  wire       [7:0]    conv1_wThrRead;
  wire       [7:0]    _zz_conv1_wSignRead;
  wire                conv1_wSignRead;
  wire       [3:0]    _zz_conv1_combAdjRead;
  wire                _zz_conv1_combAdjRead_1;
  wire       [31:0]   conv1_combAdjRead;
  wire                when_StochasticConvCore_l345;
  wire                when_StochasticConvCore_l349;
  wire                when_StochasticConvCore_l353;
  wire                when_StochasticConvCore_l353_1;
  wire                when_StochasticConvCore_l353_2;
  wire                when_StochasticConvCore_l353_3;
  wire                when_StochasticConvCore_l353_4;
  wire                when_StochasticConvCore_l353_5;
  wire                when_StochasticConvCore_l353_6;
  wire                when_StochasticConvCore_l353_7;
  wire                when_StochasticConvCore_l353_8;
  wire                when_StochasticConvCore_l353_9;
  wire                when_StochasticConvCore_l353_10;
  wire                when_StochasticConvCore_l353_11;
  wire                when_StochasticConvCore_l353_12;
  wire                when_StochasticConvCore_l353_13;
  wire                when_StochasticConvCore_l353_14;
  wire                when_StochasticConvCore_l353_15;
  wire                when_StochasticConvCore_l353_16;
  wire                when_StochasticConvCore_l353_17;
  wire                when_StochasticConvCore_l353_18;
  wire                when_StochasticConvCore_l353_19;
  wire                when_StochasticConvCore_l353_20;
  wire                when_StochasticConvCore_l353_21;
  wire                when_StochasticConvCore_l353_22;
  wire                when_StochasticConvCore_l353_23;
  wire                when_StochasticConvCore_l353_24;
  wire                when_StochasticConvCore_l361;
  wire                when_StochasticConvCore_l373;
  wire                when_StochasticConvCore_l376;
  wire                when_StochasticConvCore_l387;
  wire       [26:0]   _zz_conv1_activationOut_payload_value;
  wire                conv1_activationOut_fire;
  wire                when_StochasticConvCore_l408;
  wire                when_StochasticConvCore_l410;
  wire                _zz_conv1_state;
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
  wire                StochasticConvPlugin_logic_outStream_valid_1;
  wire                StochasticConvPlugin_logic_outStream_ready_1;
  wire       [7:0]    StochasticConvPlugin_logic_outStream_payload_value_1;
  wire       [2:0]    conv2_sRx;
  wire       [2:0]    conv2_sInit;
  wire       [2:0]    conv2_sLoad;
  wire       [2:0]    conv2_sSC;
  wire       [2:0]    conv2_sDecode;
  reg        [2:0]    conv2_state;
  reg        [7:0]    conv2_wRootLfsr;
  reg        [7:0]    conv2_aRootLfsr;
  reg        [7:0]    conv2_wLfsrChain_0;
  reg        [7:0]    conv2_wLfsrChain_1;
  reg        [7:0]    conv2_wLfsrChain_2;
  reg        [7:0]    conv2_wLfsrChain_3;
  reg        [7:0]    conv2_wLfsrChain_4;
  reg        [7:0]    conv2_wLfsrChain_5;
  reg        [7:0]    conv2_wLfsrChain_6;
  reg        [7:0]    conv2_wLfsrChain_7;
  reg        [7:0]    conv2_wLfsrChain_8;
  reg        [7:0]    conv2_wLfsrChain_9;
  reg        [7:0]    conv2_wLfsrChain_10;
  reg        [7:0]    conv2_wLfsrChain_11;
  reg        [7:0]    conv2_wLfsrChain_12;
  reg        [7:0]    conv2_wLfsrChain_13;
  reg        [7:0]    conv2_wLfsrChain_14;
  reg        [7:0]    conv2_wLfsrChain_15;
  reg        [7:0]    conv2_wLfsrChain_16;
  reg        [7:0]    conv2_wLfsrChain_17;
  reg        [7:0]    conv2_wLfsrChain_18;
  reg        [7:0]    conv2_wLfsrChain_19;
  reg        [7:0]    conv2_wLfsrChain_20;
  reg        [7:0]    conv2_wLfsrChain_21;
  reg        [7:0]    conv2_wLfsrChain_22;
  reg        [7:0]    conv2_wLfsrChain_23;
  reg        [7:0]    conv2_wLfsrChain_24;
  reg        [7:0]    conv2_wLfsrChain_25;
  reg        [7:0]    conv2_wLfsrChain_26;
  reg        [7:0]    conv2_wLfsrChain_27;
  reg        [7:0]    conv2_wLfsrChain_28;
  reg        [7:0]    conv2_wLfsrChain_29;
  reg        [7:0]    conv2_wLfsrChain_30;
  reg        [7:0]    conv2_wLfsrChain_31;
  reg        [7:0]    conv2_wLfsrChain_32;
  reg        [7:0]    conv2_wLfsrChain_33;
  reg        [7:0]    conv2_wLfsrChain_34;
  reg        [7:0]    conv2_wLfsrChain_35;
  reg        [7:0]    conv2_wLfsrChain_36;
  reg        [7:0]    conv2_wLfsrChain_37;
  reg        [7:0]    conv2_wLfsrChain_38;
  reg        [7:0]    conv2_wLfsrChain_39;
  reg        [7:0]    conv2_wLfsrChain_40;
  reg        [7:0]    conv2_wLfsrChain_41;
  reg        [7:0]    conv2_wLfsrChain_42;
  reg        [7:0]    conv2_wLfsrChain_43;
  reg        [7:0]    conv2_wLfsrChain_44;
  reg        [7:0]    conv2_wLfsrChain_45;
  reg        [7:0]    conv2_wLfsrChain_46;
  reg        [7:0]    conv2_wLfsrChain_47;
  reg        [7:0]    conv2_wLfsrChain_48;
  reg        [7:0]    conv2_wLfsrChain_49;
  reg        [7:0]    conv2_wLfsrChain_50;
  reg        [7:0]    conv2_wLfsrChain_51;
  reg        [7:0]    conv2_wLfsrChain_52;
  reg        [7:0]    conv2_wLfsrChain_53;
  reg        [7:0]    conv2_wLfsrChain_54;
  reg        [7:0]    conv2_wLfsrChain_55;
  reg        [7:0]    conv2_wLfsrChain_56;
  reg        [7:0]    conv2_wLfsrChain_57;
  reg        [7:0]    conv2_wLfsrChain_58;
  reg        [7:0]    conv2_wLfsrChain_59;
  reg        [7:0]    conv2_wLfsrChain_60;
  reg        [7:0]    conv2_wLfsrChain_61;
  reg        [7:0]    conv2_wLfsrChain_62;
  reg        [7:0]    conv2_wLfsrChain_63;
  reg        [7:0]    conv2_wLfsrChain_64;
  reg        [7:0]    conv2_wLfsrChain_65;
  reg        [7:0]    conv2_wLfsrChain_66;
  reg        [7:0]    conv2_wLfsrChain_67;
  reg        [7:0]    conv2_wLfsrChain_68;
  reg        [7:0]    conv2_wLfsrChain_69;
  reg        [7:0]    conv2_wLfsrChain_70;
  reg        [7:0]    conv2_wLfsrChain_71;
  reg        [7:0]    conv2_wLfsrChain_72;
  reg        [7:0]    conv2_wLfsrChain_73;
  reg        [7:0]    conv2_wLfsrChain_74;
  reg        [7:0]    conv2_wLfsrChain_75;
  reg        [7:0]    conv2_wLfsrChain_76;
  reg        [7:0]    conv2_wLfsrChain_77;
  reg        [7:0]    conv2_wLfsrChain_78;
  reg        [7:0]    conv2_wLfsrChain_79;
  reg        [7:0]    conv2_wLfsrChain_80;
  reg        [7:0]    conv2_wLfsrChain_81;
  reg        [7:0]    conv2_wLfsrChain_82;
  reg        [7:0]    conv2_wLfsrChain_83;
  reg        [7:0]    conv2_wLfsrChain_84;
  reg        [7:0]    conv2_wLfsrChain_85;
  reg        [7:0]    conv2_wLfsrChain_86;
  reg        [7:0]    conv2_wLfsrChain_87;
  reg        [7:0]    conv2_wLfsrChain_88;
  reg        [7:0]    conv2_wLfsrChain_89;
  reg        [7:0]    conv2_wLfsrChain_90;
  reg        [7:0]    conv2_wLfsrChain_91;
  reg        [7:0]    conv2_wLfsrChain_92;
  reg        [7:0]    conv2_wLfsrChain_93;
  reg        [7:0]    conv2_wLfsrChain_94;
  reg        [7:0]    conv2_wLfsrChain_95;
  reg        [7:0]    conv2_wLfsrChain_96;
  reg        [7:0]    conv2_wLfsrChain_97;
  reg        [7:0]    conv2_wLfsrChain_98;
  reg        [7:0]    conv2_wLfsrChain_99;
  reg        [7:0]    conv2_wLfsrChain_100;
  reg        [7:0]    conv2_wLfsrChain_101;
  reg        [7:0]    conv2_wLfsrChain_102;
  reg        [7:0]    conv2_wLfsrChain_103;
  reg        [7:0]    conv2_wLfsrChain_104;
  reg        [7:0]    conv2_wLfsrChain_105;
  reg        [7:0]    conv2_wLfsrChain_106;
  reg        [7:0]    conv2_wLfsrChain_107;
  reg        [7:0]    conv2_wLfsrChain_108;
  reg        [7:0]    conv2_wLfsrChain_109;
  reg        [7:0]    conv2_wLfsrChain_110;
  reg        [7:0]    conv2_wLfsrChain_111;
  reg        [7:0]    conv2_wLfsrChain_112;
  reg        [7:0]    conv2_wLfsrChain_113;
  reg        [7:0]    conv2_wLfsrChain_114;
  reg        [7:0]    conv2_wLfsrChain_115;
  reg        [7:0]    conv2_wLfsrChain_116;
  reg        [7:0]    conv2_wLfsrChain_117;
  reg        [7:0]    conv2_wLfsrChain_118;
  reg        [7:0]    conv2_wLfsrChain_119;
  reg        [7:0]    conv2_wLfsrChain_120;
  reg        [7:0]    conv2_wLfsrChain_121;
  reg        [7:0]    conv2_wLfsrChain_122;
  reg        [7:0]    conv2_wLfsrChain_123;
  reg        [7:0]    conv2_wLfsrChain_124;
  reg        [7:0]    conv2_wLfsrChain_125;
  reg        [7:0]    conv2_wLfsrChain_126;
  reg        [7:0]    conv2_wLfsrChain_127;
  reg        [7:0]    conv2_wLfsrChain_128;
  reg        [7:0]    conv2_wLfsrChain_129;
  reg        [7:0]    conv2_wLfsrChain_130;
  reg        [7:0]    conv2_wLfsrChain_131;
  reg        [7:0]    conv2_wLfsrChain_132;
  reg        [7:0]    conv2_wLfsrChain_133;
  reg        [7:0]    conv2_wLfsrChain_134;
  reg        [7:0]    conv2_wLfsrChain_135;
  reg        [7:0]    conv2_wLfsrChain_136;
  reg        [7:0]    conv2_wLfsrChain_137;
  reg        [7:0]    conv2_wLfsrChain_138;
  reg        [7:0]    conv2_wLfsrChain_139;
  reg        [7:0]    conv2_wLfsrChain_140;
  reg        [7:0]    conv2_wLfsrChain_141;
  reg        [7:0]    conv2_wLfsrChain_142;
  reg        [7:0]    conv2_wLfsrChain_143;
  reg        [7:0]    conv2_wLfsrChain_144;
  reg        [7:0]    conv2_wLfsrChain_145;
  reg        [7:0]    conv2_wLfsrChain_146;
  reg        [7:0]    conv2_wLfsrChain_147;
  reg        [7:0]    conv2_wLfsrChain_148;
  reg        [7:0]    conv2_wLfsrChain_149;
  reg        [7:0]    conv2_wLfsrChain_150;
  reg        [7:0]    conv2_wLfsrChain_151;
  reg        [7:0]    conv2_wLfsrChain_152;
  reg        [7:0]    conv2_wLfsrChain_153;
  reg        [7:0]    conv2_wLfsrChain_154;
  reg        [7:0]    conv2_wLfsrChain_155;
  reg        [7:0]    conv2_wLfsrChain_156;
  reg        [7:0]    conv2_wLfsrChain_157;
  reg        [7:0]    conv2_wLfsrChain_158;
  reg        [7:0]    conv2_wLfsrChain_159;
  reg        [7:0]    conv2_wLfsrChain_160;
  reg        [7:0]    conv2_wLfsrChain_161;
  reg        [7:0]    conv2_wLfsrChain_162;
  reg        [7:0]    conv2_wLfsrChain_163;
  reg        [7:0]    conv2_wLfsrChain_164;
  reg        [7:0]    conv2_wLfsrChain_165;
  reg        [7:0]    conv2_wLfsrChain_166;
  reg        [7:0]    conv2_wLfsrChain_167;
  reg        [7:0]    conv2_wLfsrChain_168;
  reg        [7:0]    conv2_wLfsrChain_169;
  reg        [7:0]    conv2_wLfsrChain_170;
  reg        [7:0]    conv2_wLfsrChain_171;
  reg        [7:0]    conv2_wLfsrChain_172;
  reg        [7:0]    conv2_wLfsrChain_173;
  reg        [7:0]    conv2_wLfsrChain_174;
  reg        [7:0]    conv2_wLfsrChain_175;
  reg        [7:0]    conv2_wLfsrChain_176;
  reg        [7:0]    conv2_wLfsrChain_177;
  reg        [7:0]    conv2_wLfsrChain_178;
  reg        [7:0]    conv2_wLfsrChain_179;
  reg        [7:0]    conv2_wLfsrChain_180;
  reg        [7:0]    conv2_wLfsrChain_181;
  reg        [7:0]    conv2_wLfsrChain_182;
  reg        [7:0]    conv2_wLfsrChain_183;
  reg        [7:0]    conv2_wLfsrChain_184;
  reg        [7:0]    conv2_wLfsrChain_185;
  reg        [7:0]    conv2_wLfsrChain_186;
  reg        [7:0]    conv2_wLfsrChain_187;
  reg        [7:0]    conv2_wLfsrChain_188;
  reg        [7:0]    conv2_wLfsrChain_189;
  reg        [7:0]    conv2_wLfsrChain_190;
  reg        [7:0]    conv2_wLfsrChain_191;
  reg        [7:0]    conv2_wLfsrChain_192;
  reg        [7:0]    conv2_wLfsrChain_193;
  reg        [7:0]    conv2_wLfsrChain_194;
  reg        [7:0]    conv2_wLfsrChain_195;
  reg        [7:0]    conv2_wLfsrChain_196;
  reg        [7:0]    conv2_wLfsrChain_197;
  reg        [7:0]    conv2_wLfsrChain_198;
  reg        [7:0]    conv2_wLfsrChain_199;
  reg        [7:0]    conv2_aLfsrChain_0;
  reg        [7:0]    conv2_aLfsrChain_1;
  reg        [7:0]    conv2_aLfsrChain_2;
  reg        [7:0]    conv2_aLfsrChain_3;
  reg        [7:0]    conv2_aLfsrChain_4;
  reg        [7:0]    conv2_aLfsrChain_5;
  reg        [7:0]    conv2_aLfsrChain_6;
  reg        [7:0]    conv2_aLfsrChain_7;
  reg        [7:0]    conv2_aLfsrChain_8;
  reg        [7:0]    conv2_aLfsrChain_9;
  reg        [7:0]    conv2_aLfsrChain_10;
  reg        [7:0]    conv2_aLfsrChain_11;
  reg        [7:0]    conv2_aLfsrChain_12;
  reg        [7:0]    conv2_aLfsrChain_13;
  reg        [7:0]    conv2_aLfsrChain_14;
  reg        [7:0]    conv2_aLfsrChain_15;
  reg        [7:0]    conv2_aLfsrChain_16;
  reg        [7:0]    conv2_aLfsrChain_17;
  reg        [7:0]    conv2_aLfsrChain_18;
  reg        [7:0]    conv2_aLfsrChain_19;
  reg        [7:0]    conv2_aLfsrChain_20;
  reg        [7:0]    conv2_aLfsrChain_21;
  reg        [7:0]    conv2_aLfsrChain_22;
  reg        [7:0]    conv2_aLfsrChain_23;
  reg        [7:0]    conv2_aLfsrChain_24;
  reg        [7:0]    conv2_aLfsrChain_25;
  reg        [7:0]    conv2_aLfsrChain_26;
  reg        [7:0]    conv2_aLfsrChain_27;
  reg        [7:0]    conv2_aLfsrChain_28;
  reg        [7:0]    conv2_aLfsrChain_29;
  reg        [7:0]    conv2_aLfsrChain_30;
  reg        [7:0]    conv2_aLfsrChain_31;
  reg        [7:0]    conv2_aLfsrChain_32;
  reg        [7:0]    conv2_aLfsrChain_33;
  reg        [7:0]    conv2_aLfsrChain_34;
  reg        [7:0]    conv2_aLfsrChain_35;
  reg        [7:0]    conv2_aLfsrChain_36;
  reg        [7:0]    conv2_aLfsrChain_37;
  reg        [7:0]    conv2_aLfsrChain_38;
  reg        [7:0]    conv2_aLfsrChain_39;
  reg        [7:0]    conv2_aLfsrChain_40;
  reg        [7:0]    conv2_aLfsrChain_41;
  reg        [7:0]    conv2_aLfsrChain_42;
  reg        [7:0]    conv2_aLfsrChain_43;
  reg        [7:0]    conv2_aLfsrChain_44;
  reg        [7:0]    conv2_aLfsrChain_45;
  reg        [7:0]    conv2_aLfsrChain_46;
  reg        [7:0]    conv2_aLfsrChain_47;
  reg        [7:0]    conv2_aLfsrChain_48;
  reg        [7:0]    conv2_aLfsrChain_49;
  reg        [7:0]    conv2_aLfsrChain_50;
  reg        [7:0]    conv2_aLfsrChain_51;
  reg        [7:0]    conv2_aLfsrChain_52;
  reg        [7:0]    conv2_aLfsrChain_53;
  reg        [7:0]    conv2_aLfsrChain_54;
  reg        [7:0]    conv2_aLfsrChain_55;
  reg        [7:0]    conv2_aLfsrChain_56;
  reg        [7:0]    conv2_aLfsrChain_57;
  reg        [7:0]    conv2_aLfsrChain_58;
  reg        [7:0]    conv2_aLfsrChain_59;
  reg        [7:0]    conv2_aLfsrChain_60;
  reg        [7:0]    conv2_aLfsrChain_61;
  reg        [7:0]    conv2_aLfsrChain_62;
  reg        [7:0]    conv2_aLfsrChain_63;
  reg        [7:0]    conv2_aLfsrChain_64;
  reg        [7:0]    conv2_aLfsrChain_65;
  reg        [7:0]    conv2_aLfsrChain_66;
  reg        [7:0]    conv2_aLfsrChain_67;
  reg        [7:0]    conv2_aLfsrChain_68;
  reg        [7:0]    conv2_aLfsrChain_69;
  reg        [7:0]    conv2_aLfsrChain_70;
  reg        [7:0]    conv2_aLfsrChain_71;
  reg        [7:0]    conv2_aLfsrChain_72;
  reg        [7:0]    conv2_aLfsrChain_73;
  reg        [7:0]    conv2_aLfsrChain_74;
  reg        [7:0]    conv2_aLfsrChain_75;
  reg        [7:0]    conv2_aLfsrChain_76;
  reg        [7:0]    conv2_aLfsrChain_77;
  reg        [7:0]    conv2_aLfsrChain_78;
  reg        [7:0]    conv2_aLfsrChain_79;
  reg        [7:0]    conv2_aLfsrChain_80;
  reg        [7:0]    conv2_aLfsrChain_81;
  reg        [7:0]    conv2_aLfsrChain_82;
  reg        [7:0]    conv2_aLfsrChain_83;
  reg        [7:0]    conv2_aLfsrChain_84;
  reg        [7:0]    conv2_aLfsrChain_85;
  reg        [7:0]    conv2_aLfsrChain_86;
  reg        [7:0]    conv2_aLfsrChain_87;
  reg        [7:0]    conv2_aLfsrChain_88;
  reg        [7:0]    conv2_aLfsrChain_89;
  reg        [7:0]    conv2_aLfsrChain_90;
  reg        [7:0]    conv2_aLfsrChain_91;
  reg        [7:0]    conv2_aLfsrChain_92;
  reg        [7:0]    conv2_aLfsrChain_93;
  reg        [7:0]    conv2_aLfsrChain_94;
  reg        [7:0]    conv2_aLfsrChain_95;
  reg        [7:0]    conv2_aLfsrChain_96;
  reg        [7:0]    conv2_aLfsrChain_97;
  reg        [7:0]    conv2_aLfsrChain_98;
  reg        [7:0]    conv2_aLfsrChain_99;
  reg        [7:0]    conv2_aLfsrChain_100;
  reg        [7:0]    conv2_aLfsrChain_101;
  reg        [7:0]    conv2_aLfsrChain_102;
  reg        [7:0]    conv2_aLfsrChain_103;
  reg        [7:0]    conv2_aLfsrChain_104;
  reg        [7:0]    conv2_aLfsrChain_105;
  reg        [7:0]    conv2_aLfsrChain_106;
  reg        [7:0]    conv2_aLfsrChain_107;
  reg        [7:0]    conv2_aLfsrChain_108;
  reg        [7:0]    conv2_aLfsrChain_109;
  reg        [7:0]    conv2_aLfsrChain_110;
  reg        [7:0]    conv2_aLfsrChain_111;
  reg        [7:0]    conv2_aLfsrChain_112;
  reg        [7:0]    conv2_aLfsrChain_113;
  reg        [7:0]    conv2_aLfsrChain_114;
  reg        [7:0]    conv2_aLfsrChain_115;
  reg        [7:0]    conv2_aLfsrChain_116;
  reg        [7:0]    conv2_aLfsrChain_117;
  reg        [7:0]    conv2_aLfsrChain_118;
  reg        [7:0]    conv2_aLfsrChain_119;
  reg        [7:0]    conv2_aLfsrChain_120;
  reg        [7:0]    conv2_aLfsrChain_121;
  reg        [7:0]    conv2_aLfsrChain_122;
  reg        [7:0]    conv2_aLfsrChain_123;
  reg        [7:0]    conv2_aLfsrChain_124;
  reg        [7:0]    conv2_aLfsrChain_125;
  reg        [7:0]    conv2_aLfsrChain_126;
  reg        [7:0]    conv2_aLfsrChain_127;
  reg        [7:0]    conv2_aLfsrChain_128;
  reg        [7:0]    conv2_aLfsrChain_129;
  reg        [7:0]    conv2_aLfsrChain_130;
  reg        [7:0]    conv2_aLfsrChain_131;
  reg        [7:0]    conv2_aLfsrChain_132;
  reg        [7:0]    conv2_aLfsrChain_133;
  reg        [7:0]    conv2_aLfsrChain_134;
  reg        [7:0]    conv2_aLfsrChain_135;
  reg        [7:0]    conv2_aLfsrChain_136;
  reg        [7:0]    conv2_aLfsrChain_137;
  reg        [7:0]    conv2_aLfsrChain_138;
  reg        [7:0]    conv2_aLfsrChain_139;
  reg        [7:0]    conv2_aLfsrChain_140;
  reg        [7:0]    conv2_aLfsrChain_141;
  reg        [7:0]    conv2_aLfsrChain_142;
  reg        [7:0]    conv2_aLfsrChain_143;
  reg        [7:0]    conv2_aLfsrChain_144;
  reg        [7:0]    conv2_aLfsrChain_145;
  reg        [7:0]    conv2_aLfsrChain_146;
  reg        [7:0]    conv2_aLfsrChain_147;
  reg        [7:0]    conv2_aLfsrChain_148;
  reg        [7:0]    conv2_aLfsrChain_149;
  reg        [7:0]    conv2_aLfsrChain_150;
  reg        [7:0]    conv2_aLfsrChain_151;
  reg        [7:0]    conv2_aLfsrChain_152;
  reg        [7:0]    conv2_aLfsrChain_153;
  reg        [7:0]    conv2_aLfsrChain_154;
  reg        [7:0]    conv2_aLfsrChain_155;
  reg        [7:0]    conv2_aLfsrChain_156;
  reg        [7:0]    conv2_aLfsrChain_157;
  reg        [7:0]    conv2_aLfsrChain_158;
  reg        [7:0]    conv2_aLfsrChain_159;
  reg        [7:0]    conv2_aLfsrChain_160;
  reg        [7:0]    conv2_aLfsrChain_161;
  reg        [7:0]    conv2_aLfsrChain_162;
  reg        [7:0]    conv2_aLfsrChain_163;
  reg        [7:0]    conv2_aLfsrChain_164;
  reg        [7:0]    conv2_aLfsrChain_165;
  reg        [7:0]    conv2_aLfsrChain_166;
  reg        [7:0]    conv2_aLfsrChain_167;
  reg        [7:0]    conv2_aLfsrChain_168;
  reg        [7:0]    conv2_aLfsrChain_169;
  reg        [7:0]    conv2_aLfsrChain_170;
  reg        [7:0]    conv2_aLfsrChain_171;
  reg        [7:0]    conv2_aLfsrChain_172;
  reg        [7:0]    conv2_aLfsrChain_173;
  reg        [7:0]    conv2_aLfsrChain_174;
  reg        [7:0]    conv2_aLfsrChain_175;
  reg        [7:0]    conv2_aLfsrChain_176;
  reg        [7:0]    conv2_aLfsrChain_177;
  reg        [7:0]    conv2_aLfsrChain_178;
  reg        [7:0]    conv2_aLfsrChain_179;
  reg        [7:0]    conv2_aLfsrChain_180;
  reg        [7:0]    conv2_aLfsrChain_181;
  reg        [7:0]    conv2_aLfsrChain_182;
  reg        [7:0]    conv2_aLfsrChain_183;
  reg        [7:0]    conv2_aLfsrChain_184;
  reg        [7:0]    conv2_aLfsrChain_185;
  reg        [7:0]    conv2_aLfsrChain_186;
  reg        [7:0]    conv2_aLfsrChain_187;
  reg        [7:0]    conv2_aLfsrChain_188;
  reg        [7:0]    conv2_aLfsrChain_189;
  reg        [7:0]    conv2_aLfsrChain_190;
  reg        [7:0]    conv2_aLfsrChain_191;
  reg        [7:0]    conv2_aLfsrChain_192;
  reg        [7:0]    conv2_aLfsrChain_193;
  reg        [7:0]    conv2_aLfsrChain_194;
  reg        [7:0]    conv2_aLfsrChain_195;
  reg        [7:0]    conv2_aLfsrChain_196;
  reg        [7:0]    conv2_aLfsrChain_197;
  reg        [7:0]    conv2_aLfsrChain_198;
  reg        [7:0]    conv2_aLfsrChain_199;
  reg        [7:0]    conv2_activThresh_0;
  reg        [7:0]    conv2_activThresh_1;
  reg        [7:0]    conv2_activThresh_2;
  reg        [7:0]    conv2_activThresh_3;
  reg        [7:0]    conv2_activThresh_4;
  reg        [7:0]    conv2_activThresh_5;
  reg        [7:0]    conv2_activThresh_6;
  reg        [7:0]    conv2_activThresh_7;
  reg        [7:0]    conv2_activThresh_8;
  reg        [7:0]    conv2_activThresh_9;
  reg        [7:0]    conv2_activThresh_10;
  reg        [7:0]    conv2_activThresh_11;
  reg        [7:0]    conv2_activThresh_12;
  reg        [7:0]    conv2_activThresh_13;
  reg        [7:0]    conv2_activThresh_14;
  reg        [7:0]    conv2_activThresh_15;
  reg        [7:0]    conv2_activThresh_16;
  reg        [7:0]    conv2_activThresh_17;
  reg        [7:0]    conv2_activThresh_18;
  reg        [7:0]    conv2_activThresh_19;
  reg        [7:0]    conv2_activThresh_20;
  reg        [7:0]    conv2_activThresh_21;
  reg        [7:0]    conv2_activThresh_22;
  reg        [7:0]    conv2_activThresh_23;
  reg        [7:0]    conv2_activThresh_24;
  reg        [7:0]    conv2_activThresh_25;
  reg        [7:0]    conv2_activThresh_26;
  reg        [7:0]    conv2_activThresh_27;
  reg        [7:0]    conv2_activThresh_28;
  reg        [7:0]    conv2_activThresh_29;
  reg        [7:0]    conv2_activThresh_30;
  reg        [7:0]    conv2_activThresh_31;
  reg        [7:0]    conv2_activThresh_32;
  reg        [7:0]    conv2_activThresh_33;
  reg        [7:0]    conv2_activThresh_34;
  reg        [7:0]    conv2_activThresh_35;
  reg        [7:0]    conv2_activThresh_36;
  reg        [7:0]    conv2_activThresh_37;
  reg        [7:0]    conv2_activThresh_38;
  reg        [7:0]    conv2_activThresh_39;
  reg        [7:0]    conv2_activThresh_40;
  reg        [7:0]    conv2_activThresh_41;
  reg        [7:0]    conv2_activThresh_42;
  reg        [7:0]    conv2_activThresh_43;
  reg        [7:0]    conv2_activThresh_44;
  reg        [7:0]    conv2_activThresh_45;
  reg        [7:0]    conv2_activThresh_46;
  reg        [7:0]    conv2_activThresh_47;
  reg        [7:0]    conv2_activThresh_48;
  reg        [7:0]    conv2_activThresh_49;
  reg        [7:0]    conv2_activThresh_50;
  reg        [7:0]    conv2_activThresh_51;
  reg        [7:0]    conv2_activThresh_52;
  reg        [7:0]    conv2_activThresh_53;
  reg        [7:0]    conv2_activThresh_54;
  reg        [7:0]    conv2_activThresh_55;
  reg        [7:0]    conv2_activThresh_56;
  reg        [7:0]    conv2_activThresh_57;
  reg        [7:0]    conv2_activThresh_58;
  reg        [7:0]    conv2_activThresh_59;
  reg        [7:0]    conv2_activThresh_60;
  reg        [7:0]    conv2_activThresh_61;
  reg        [7:0]    conv2_activThresh_62;
  reg        [7:0]    conv2_activThresh_63;
  reg        [7:0]    conv2_activThresh_64;
  reg        [7:0]    conv2_activThresh_65;
  reg        [7:0]    conv2_activThresh_66;
  reg        [7:0]    conv2_activThresh_67;
  reg        [7:0]    conv2_activThresh_68;
  reg        [7:0]    conv2_activThresh_69;
  reg        [7:0]    conv2_activThresh_70;
  reg        [7:0]    conv2_activThresh_71;
  reg        [7:0]    conv2_activThresh_72;
  reg        [7:0]    conv2_activThresh_73;
  reg        [7:0]    conv2_activThresh_74;
  reg        [7:0]    conv2_activThresh_75;
  reg        [7:0]    conv2_activThresh_76;
  reg        [7:0]    conv2_activThresh_77;
  reg        [7:0]    conv2_activThresh_78;
  reg        [7:0]    conv2_activThresh_79;
  reg        [7:0]    conv2_activThresh_80;
  reg        [7:0]    conv2_activThresh_81;
  reg        [7:0]    conv2_activThresh_82;
  reg        [7:0]    conv2_activThresh_83;
  reg        [7:0]    conv2_activThresh_84;
  reg        [7:0]    conv2_activThresh_85;
  reg        [7:0]    conv2_activThresh_86;
  reg        [7:0]    conv2_activThresh_87;
  reg        [7:0]    conv2_activThresh_88;
  reg        [7:0]    conv2_activThresh_89;
  reg        [7:0]    conv2_activThresh_90;
  reg        [7:0]    conv2_activThresh_91;
  reg        [7:0]    conv2_activThresh_92;
  reg        [7:0]    conv2_activThresh_93;
  reg        [7:0]    conv2_activThresh_94;
  reg        [7:0]    conv2_activThresh_95;
  reg        [7:0]    conv2_activThresh_96;
  reg        [7:0]    conv2_activThresh_97;
  reg        [7:0]    conv2_activThresh_98;
  reg        [7:0]    conv2_activThresh_99;
  reg        [7:0]    conv2_activThresh_100;
  reg        [7:0]    conv2_activThresh_101;
  reg        [7:0]    conv2_activThresh_102;
  reg        [7:0]    conv2_activThresh_103;
  reg        [7:0]    conv2_activThresh_104;
  reg        [7:0]    conv2_activThresh_105;
  reg        [7:0]    conv2_activThresh_106;
  reg        [7:0]    conv2_activThresh_107;
  reg        [7:0]    conv2_activThresh_108;
  reg        [7:0]    conv2_activThresh_109;
  reg        [7:0]    conv2_activThresh_110;
  reg        [7:0]    conv2_activThresh_111;
  reg        [7:0]    conv2_activThresh_112;
  reg        [7:0]    conv2_activThresh_113;
  reg        [7:0]    conv2_activThresh_114;
  reg        [7:0]    conv2_activThresh_115;
  reg        [7:0]    conv2_activThresh_116;
  reg        [7:0]    conv2_activThresh_117;
  reg        [7:0]    conv2_activThresh_118;
  reg        [7:0]    conv2_activThresh_119;
  reg        [7:0]    conv2_activThresh_120;
  reg        [7:0]    conv2_activThresh_121;
  reg        [7:0]    conv2_activThresh_122;
  reg        [7:0]    conv2_activThresh_123;
  reg        [7:0]    conv2_activThresh_124;
  reg        [7:0]    conv2_activThresh_125;
  reg        [7:0]    conv2_activThresh_126;
  reg        [7:0]    conv2_activThresh_127;
  reg        [7:0]    conv2_activThresh_128;
  reg        [7:0]    conv2_activThresh_129;
  reg        [7:0]    conv2_activThresh_130;
  reg        [7:0]    conv2_activThresh_131;
  reg        [7:0]    conv2_activThresh_132;
  reg        [7:0]    conv2_activThresh_133;
  reg        [7:0]    conv2_activThresh_134;
  reg        [7:0]    conv2_activThresh_135;
  reg        [7:0]    conv2_activThresh_136;
  reg        [7:0]    conv2_activThresh_137;
  reg        [7:0]    conv2_activThresh_138;
  reg        [7:0]    conv2_activThresh_139;
  reg        [7:0]    conv2_activThresh_140;
  reg        [7:0]    conv2_activThresh_141;
  reg        [7:0]    conv2_activThresh_142;
  reg        [7:0]    conv2_activThresh_143;
  reg        [7:0]    conv2_activThresh_144;
  reg        [7:0]    conv2_activThresh_145;
  reg        [7:0]    conv2_activThresh_146;
  reg        [7:0]    conv2_activThresh_147;
  reg        [7:0]    conv2_activThresh_148;
  reg        [7:0]    conv2_activThresh_149;
  reg        [7:0]    conv2_activThresh_150;
  reg        [7:0]    conv2_activThresh_151;
  reg        [7:0]    conv2_activThresh_152;
  reg        [7:0]    conv2_activThresh_153;
  reg        [7:0]    conv2_activThresh_154;
  reg        [7:0]    conv2_activThresh_155;
  reg        [7:0]    conv2_activThresh_156;
  reg        [7:0]    conv2_activThresh_157;
  reg        [7:0]    conv2_activThresh_158;
  reg        [7:0]    conv2_activThresh_159;
  reg        [7:0]    conv2_activThresh_160;
  reg        [7:0]    conv2_activThresh_161;
  reg        [7:0]    conv2_activThresh_162;
  reg        [7:0]    conv2_activThresh_163;
  reg        [7:0]    conv2_activThresh_164;
  reg        [7:0]    conv2_activThresh_165;
  reg        [7:0]    conv2_activThresh_166;
  reg        [7:0]    conv2_activThresh_167;
  reg        [7:0]    conv2_activThresh_168;
  reg        [7:0]    conv2_activThresh_169;
  reg        [7:0]    conv2_activThresh_170;
  reg        [7:0]    conv2_activThresh_171;
  reg        [7:0]    conv2_activThresh_172;
  reg        [7:0]    conv2_activThresh_173;
  reg        [7:0]    conv2_activThresh_174;
  reg        [7:0]    conv2_activThresh_175;
  reg        [7:0]    conv2_activThresh_176;
  reg        [7:0]    conv2_activThresh_177;
  reg        [7:0]    conv2_activThresh_178;
  reg        [7:0]    conv2_activThresh_179;
  reg        [7:0]    conv2_activThresh_180;
  reg        [7:0]    conv2_activThresh_181;
  reg        [7:0]    conv2_activThresh_182;
  reg        [7:0]    conv2_activThresh_183;
  reg        [7:0]    conv2_activThresh_184;
  reg        [7:0]    conv2_activThresh_185;
  reg        [7:0]    conv2_activThresh_186;
  reg        [7:0]    conv2_activThresh_187;
  reg        [7:0]    conv2_activThresh_188;
  reg        [7:0]    conv2_activThresh_189;
  reg        [7:0]    conv2_activThresh_190;
  reg        [7:0]    conv2_activThresh_191;
  reg        [7:0]    conv2_activThresh_192;
  reg        [7:0]    conv2_activThresh_193;
  reg        [7:0]    conv2_activThresh_194;
  reg        [7:0]    conv2_activThresh_195;
  reg        [7:0]    conv2_activThresh_196;
  reg        [7:0]    conv2_activThresh_197;
  reg        [7:0]    conv2_activThresh_198;
  reg        [7:0]    conv2_activThresh_199;
  reg        [7:0]    conv2_wThrRegs_0;
  reg        [7:0]    conv2_wThrRegs_1;
  reg        [7:0]    conv2_wThrRegs_2;
  reg        [7:0]    conv2_wThrRegs_3;
  reg        [7:0]    conv2_wThrRegs_4;
  reg        [7:0]    conv2_wThrRegs_5;
  reg        [7:0]    conv2_wThrRegs_6;
  reg        [7:0]    conv2_wThrRegs_7;
  reg        [7:0]    conv2_wThrRegs_8;
  reg        [7:0]    conv2_wThrRegs_9;
  reg        [7:0]    conv2_wThrRegs_10;
  reg        [7:0]    conv2_wThrRegs_11;
  reg        [7:0]    conv2_wThrRegs_12;
  reg        [7:0]    conv2_wThrRegs_13;
  reg        [7:0]    conv2_wThrRegs_14;
  reg        [7:0]    conv2_wThrRegs_15;
  reg        [7:0]    conv2_wThrRegs_16;
  reg        [7:0]    conv2_wThrRegs_17;
  reg        [7:0]    conv2_wThrRegs_18;
  reg        [7:0]    conv2_wThrRegs_19;
  reg        [7:0]    conv2_wThrRegs_20;
  reg        [7:0]    conv2_wThrRegs_21;
  reg        [7:0]    conv2_wThrRegs_22;
  reg        [7:0]    conv2_wThrRegs_23;
  reg        [7:0]    conv2_wThrRegs_24;
  reg        [7:0]    conv2_wThrRegs_25;
  reg        [7:0]    conv2_wThrRegs_26;
  reg        [7:0]    conv2_wThrRegs_27;
  reg        [7:0]    conv2_wThrRegs_28;
  reg        [7:0]    conv2_wThrRegs_29;
  reg        [7:0]    conv2_wThrRegs_30;
  reg        [7:0]    conv2_wThrRegs_31;
  reg        [7:0]    conv2_wThrRegs_32;
  reg        [7:0]    conv2_wThrRegs_33;
  reg        [7:0]    conv2_wThrRegs_34;
  reg        [7:0]    conv2_wThrRegs_35;
  reg        [7:0]    conv2_wThrRegs_36;
  reg        [7:0]    conv2_wThrRegs_37;
  reg        [7:0]    conv2_wThrRegs_38;
  reg        [7:0]    conv2_wThrRegs_39;
  reg        [7:0]    conv2_wThrRegs_40;
  reg        [7:0]    conv2_wThrRegs_41;
  reg        [7:0]    conv2_wThrRegs_42;
  reg        [7:0]    conv2_wThrRegs_43;
  reg        [7:0]    conv2_wThrRegs_44;
  reg        [7:0]    conv2_wThrRegs_45;
  reg        [7:0]    conv2_wThrRegs_46;
  reg        [7:0]    conv2_wThrRegs_47;
  reg        [7:0]    conv2_wThrRegs_48;
  reg        [7:0]    conv2_wThrRegs_49;
  reg        [7:0]    conv2_wThrRegs_50;
  reg        [7:0]    conv2_wThrRegs_51;
  reg        [7:0]    conv2_wThrRegs_52;
  reg        [7:0]    conv2_wThrRegs_53;
  reg        [7:0]    conv2_wThrRegs_54;
  reg        [7:0]    conv2_wThrRegs_55;
  reg        [7:0]    conv2_wThrRegs_56;
  reg        [7:0]    conv2_wThrRegs_57;
  reg        [7:0]    conv2_wThrRegs_58;
  reg        [7:0]    conv2_wThrRegs_59;
  reg        [7:0]    conv2_wThrRegs_60;
  reg        [7:0]    conv2_wThrRegs_61;
  reg        [7:0]    conv2_wThrRegs_62;
  reg        [7:0]    conv2_wThrRegs_63;
  reg        [7:0]    conv2_wThrRegs_64;
  reg        [7:0]    conv2_wThrRegs_65;
  reg        [7:0]    conv2_wThrRegs_66;
  reg        [7:0]    conv2_wThrRegs_67;
  reg        [7:0]    conv2_wThrRegs_68;
  reg        [7:0]    conv2_wThrRegs_69;
  reg        [7:0]    conv2_wThrRegs_70;
  reg        [7:0]    conv2_wThrRegs_71;
  reg        [7:0]    conv2_wThrRegs_72;
  reg        [7:0]    conv2_wThrRegs_73;
  reg        [7:0]    conv2_wThrRegs_74;
  reg        [7:0]    conv2_wThrRegs_75;
  reg        [7:0]    conv2_wThrRegs_76;
  reg        [7:0]    conv2_wThrRegs_77;
  reg        [7:0]    conv2_wThrRegs_78;
  reg        [7:0]    conv2_wThrRegs_79;
  reg        [7:0]    conv2_wThrRegs_80;
  reg        [7:0]    conv2_wThrRegs_81;
  reg        [7:0]    conv2_wThrRegs_82;
  reg        [7:0]    conv2_wThrRegs_83;
  reg        [7:0]    conv2_wThrRegs_84;
  reg        [7:0]    conv2_wThrRegs_85;
  reg        [7:0]    conv2_wThrRegs_86;
  reg        [7:0]    conv2_wThrRegs_87;
  reg        [7:0]    conv2_wThrRegs_88;
  reg        [7:0]    conv2_wThrRegs_89;
  reg        [7:0]    conv2_wThrRegs_90;
  reg        [7:0]    conv2_wThrRegs_91;
  reg        [7:0]    conv2_wThrRegs_92;
  reg        [7:0]    conv2_wThrRegs_93;
  reg        [7:0]    conv2_wThrRegs_94;
  reg        [7:0]    conv2_wThrRegs_95;
  reg        [7:0]    conv2_wThrRegs_96;
  reg        [7:0]    conv2_wThrRegs_97;
  reg        [7:0]    conv2_wThrRegs_98;
  reg        [7:0]    conv2_wThrRegs_99;
  reg        [7:0]    conv2_wThrRegs_100;
  reg        [7:0]    conv2_wThrRegs_101;
  reg        [7:0]    conv2_wThrRegs_102;
  reg        [7:0]    conv2_wThrRegs_103;
  reg        [7:0]    conv2_wThrRegs_104;
  reg        [7:0]    conv2_wThrRegs_105;
  reg        [7:0]    conv2_wThrRegs_106;
  reg        [7:0]    conv2_wThrRegs_107;
  reg        [7:0]    conv2_wThrRegs_108;
  reg        [7:0]    conv2_wThrRegs_109;
  reg        [7:0]    conv2_wThrRegs_110;
  reg        [7:0]    conv2_wThrRegs_111;
  reg        [7:0]    conv2_wThrRegs_112;
  reg        [7:0]    conv2_wThrRegs_113;
  reg        [7:0]    conv2_wThrRegs_114;
  reg        [7:0]    conv2_wThrRegs_115;
  reg        [7:0]    conv2_wThrRegs_116;
  reg        [7:0]    conv2_wThrRegs_117;
  reg        [7:0]    conv2_wThrRegs_118;
  reg        [7:0]    conv2_wThrRegs_119;
  reg        [7:0]    conv2_wThrRegs_120;
  reg        [7:0]    conv2_wThrRegs_121;
  reg        [7:0]    conv2_wThrRegs_122;
  reg        [7:0]    conv2_wThrRegs_123;
  reg        [7:0]    conv2_wThrRegs_124;
  reg        [7:0]    conv2_wThrRegs_125;
  reg        [7:0]    conv2_wThrRegs_126;
  reg        [7:0]    conv2_wThrRegs_127;
  reg        [7:0]    conv2_wThrRegs_128;
  reg        [7:0]    conv2_wThrRegs_129;
  reg        [7:0]    conv2_wThrRegs_130;
  reg        [7:0]    conv2_wThrRegs_131;
  reg        [7:0]    conv2_wThrRegs_132;
  reg        [7:0]    conv2_wThrRegs_133;
  reg        [7:0]    conv2_wThrRegs_134;
  reg        [7:0]    conv2_wThrRegs_135;
  reg        [7:0]    conv2_wThrRegs_136;
  reg        [7:0]    conv2_wThrRegs_137;
  reg        [7:0]    conv2_wThrRegs_138;
  reg        [7:0]    conv2_wThrRegs_139;
  reg        [7:0]    conv2_wThrRegs_140;
  reg        [7:0]    conv2_wThrRegs_141;
  reg        [7:0]    conv2_wThrRegs_142;
  reg        [7:0]    conv2_wThrRegs_143;
  reg        [7:0]    conv2_wThrRegs_144;
  reg        [7:0]    conv2_wThrRegs_145;
  reg        [7:0]    conv2_wThrRegs_146;
  reg        [7:0]    conv2_wThrRegs_147;
  reg        [7:0]    conv2_wThrRegs_148;
  reg        [7:0]    conv2_wThrRegs_149;
  reg        [7:0]    conv2_wThrRegs_150;
  reg        [7:0]    conv2_wThrRegs_151;
  reg        [7:0]    conv2_wThrRegs_152;
  reg        [7:0]    conv2_wThrRegs_153;
  reg        [7:0]    conv2_wThrRegs_154;
  reg        [7:0]    conv2_wThrRegs_155;
  reg        [7:0]    conv2_wThrRegs_156;
  reg        [7:0]    conv2_wThrRegs_157;
  reg        [7:0]    conv2_wThrRegs_158;
  reg        [7:0]    conv2_wThrRegs_159;
  reg        [7:0]    conv2_wThrRegs_160;
  reg        [7:0]    conv2_wThrRegs_161;
  reg        [7:0]    conv2_wThrRegs_162;
  reg        [7:0]    conv2_wThrRegs_163;
  reg        [7:0]    conv2_wThrRegs_164;
  reg        [7:0]    conv2_wThrRegs_165;
  reg        [7:0]    conv2_wThrRegs_166;
  reg        [7:0]    conv2_wThrRegs_167;
  reg        [7:0]    conv2_wThrRegs_168;
  reg        [7:0]    conv2_wThrRegs_169;
  reg        [7:0]    conv2_wThrRegs_170;
  reg        [7:0]    conv2_wThrRegs_171;
  reg        [7:0]    conv2_wThrRegs_172;
  reg        [7:0]    conv2_wThrRegs_173;
  reg        [7:0]    conv2_wThrRegs_174;
  reg        [7:0]    conv2_wThrRegs_175;
  reg        [7:0]    conv2_wThrRegs_176;
  reg        [7:0]    conv2_wThrRegs_177;
  reg        [7:0]    conv2_wThrRegs_178;
  reg        [7:0]    conv2_wThrRegs_179;
  reg        [7:0]    conv2_wThrRegs_180;
  reg        [7:0]    conv2_wThrRegs_181;
  reg        [7:0]    conv2_wThrRegs_182;
  reg        [7:0]    conv2_wThrRegs_183;
  reg        [7:0]    conv2_wThrRegs_184;
  reg        [7:0]    conv2_wThrRegs_185;
  reg        [7:0]    conv2_wThrRegs_186;
  reg        [7:0]    conv2_wThrRegs_187;
  reg        [7:0]    conv2_wThrRegs_188;
  reg        [7:0]    conv2_wThrRegs_189;
  reg        [7:0]    conv2_wThrRegs_190;
  reg        [7:0]    conv2_wThrRegs_191;
  reg        [7:0]    conv2_wThrRegs_192;
  reg        [7:0]    conv2_wThrRegs_193;
  reg        [7:0]    conv2_wThrRegs_194;
  reg        [7:0]    conv2_wThrRegs_195;
  reg        [7:0]    conv2_wThrRegs_196;
  reg        [7:0]    conv2_wThrRegs_197;
  reg        [7:0]    conv2_wThrRegs_198;
  reg        [7:0]    conv2_wThrRegs_199;
  reg                 conv2_wSignRegs_0;
  reg                 conv2_wSignRegs_1;
  reg                 conv2_wSignRegs_2;
  reg                 conv2_wSignRegs_3;
  reg                 conv2_wSignRegs_4;
  reg                 conv2_wSignRegs_5;
  reg                 conv2_wSignRegs_6;
  reg                 conv2_wSignRegs_7;
  reg                 conv2_wSignRegs_8;
  reg                 conv2_wSignRegs_9;
  reg                 conv2_wSignRegs_10;
  reg                 conv2_wSignRegs_11;
  reg                 conv2_wSignRegs_12;
  reg                 conv2_wSignRegs_13;
  reg                 conv2_wSignRegs_14;
  reg                 conv2_wSignRegs_15;
  reg                 conv2_wSignRegs_16;
  reg                 conv2_wSignRegs_17;
  reg                 conv2_wSignRegs_18;
  reg                 conv2_wSignRegs_19;
  reg                 conv2_wSignRegs_20;
  reg                 conv2_wSignRegs_21;
  reg                 conv2_wSignRegs_22;
  reg                 conv2_wSignRegs_23;
  reg                 conv2_wSignRegs_24;
  reg                 conv2_wSignRegs_25;
  reg                 conv2_wSignRegs_26;
  reg                 conv2_wSignRegs_27;
  reg                 conv2_wSignRegs_28;
  reg                 conv2_wSignRegs_29;
  reg                 conv2_wSignRegs_30;
  reg                 conv2_wSignRegs_31;
  reg                 conv2_wSignRegs_32;
  reg                 conv2_wSignRegs_33;
  reg                 conv2_wSignRegs_34;
  reg                 conv2_wSignRegs_35;
  reg                 conv2_wSignRegs_36;
  reg                 conv2_wSignRegs_37;
  reg                 conv2_wSignRegs_38;
  reg                 conv2_wSignRegs_39;
  reg                 conv2_wSignRegs_40;
  reg                 conv2_wSignRegs_41;
  reg                 conv2_wSignRegs_42;
  reg                 conv2_wSignRegs_43;
  reg                 conv2_wSignRegs_44;
  reg                 conv2_wSignRegs_45;
  reg                 conv2_wSignRegs_46;
  reg                 conv2_wSignRegs_47;
  reg                 conv2_wSignRegs_48;
  reg                 conv2_wSignRegs_49;
  reg                 conv2_wSignRegs_50;
  reg                 conv2_wSignRegs_51;
  reg                 conv2_wSignRegs_52;
  reg                 conv2_wSignRegs_53;
  reg                 conv2_wSignRegs_54;
  reg                 conv2_wSignRegs_55;
  reg                 conv2_wSignRegs_56;
  reg                 conv2_wSignRegs_57;
  reg                 conv2_wSignRegs_58;
  reg                 conv2_wSignRegs_59;
  reg                 conv2_wSignRegs_60;
  reg                 conv2_wSignRegs_61;
  reg                 conv2_wSignRegs_62;
  reg                 conv2_wSignRegs_63;
  reg                 conv2_wSignRegs_64;
  reg                 conv2_wSignRegs_65;
  reg                 conv2_wSignRegs_66;
  reg                 conv2_wSignRegs_67;
  reg                 conv2_wSignRegs_68;
  reg                 conv2_wSignRegs_69;
  reg                 conv2_wSignRegs_70;
  reg                 conv2_wSignRegs_71;
  reg                 conv2_wSignRegs_72;
  reg                 conv2_wSignRegs_73;
  reg                 conv2_wSignRegs_74;
  reg                 conv2_wSignRegs_75;
  reg                 conv2_wSignRegs_76;
  reg                 conv2_wSignRegs_77;
  reg                 conv2_wSignRegs_78;
  reg                 conv2_wSignRegs_79;
  reg                 conv2_wSignRegs_80;
  reg                 conv2_wSignRegs_81;
  reg                 conv2_wSignRegs_82;
  reg                 conv2_wSignRegs_83;
  reg                 conv2_wSignRegs_84;
  reg                 conv2_wSignRegs_85;
  reg                 conv2_wSignRegs_86;
  reg                 conv2_wSignRegs_87;
  reg                 conv2_wSignRegs_88;
  reg                 conv2_wSignRegs_89;
  reg                 conv2_wSignRegs_90;
  reg                 conv2_wSignRegs_91;
  reg                 conv2_wSignRegs_92;
  reg                 conv2_wSignRegs_93;
  reg                 conv2_wSignRegs_94;
  reg                 conv2_wSignRegs_95;
  reg                 conv2_wSignRegs_96;
  reg                 conv2_wSignRegs_97;
  reg                 conv2_wSignRegs_98;
  reg                 conv2_wSignRegs_99;
  reg                 conv2_wSignRegs_100;
  reg                 conv2_wSignRegs_101;
  reg                 conv2_wSignRegs_102;
  reg                 conv2_wSignRegs_103;
  reg                 conv2_wSignRegs_104;
  reg                 conv2_wSignRegs_105;
  reg                 conv2_wSignRegs_106;
  reg                 conv2_wSignRegs_107;
  reg                 conv2_wSignRegs_108;
  reg                 conv2_wSignRegs_109;
  reg                 conv2_wSignRegs_110;
  reg                 conv2_wSignRegs_111;
  reg                 conv2_wSignRegs_112;
  reg                 conv2_wSignRegs_113;
  reg                 conv2_wSignRegs_114;
  reg                 conv2_wSignRegs_115;
  reg                 conv2_wSignRegs_116;
  reg                 conv2_wSignRegs_117;
  reg                 conv2_wSignRegs_118;
  reg                 conv2_wSignRegs_119;
  reg                 conv2_wSignRegs_120;
  reg                 conv2_wSignRegs_121;
  reg                 conv2_wSignRegs_122;
  reg                 conv2_wSignRegs_123;
  reg                 conv2_wSignRegs_124;
  reg                 conv2_wSignRegs_125;
  reg                 conv2_wSignRegs_126;
  reg                 conv2_wSignRegs_127;
  reg                 conv2_wSignRegs_128;
  reg                 conv2_wSignRegs_129;
  reg                 conv2_wSignRegs_130;
  reg                 conv2_wSignRegs_131;
  reg                 conv2_wSignRegs_132;
  reg                 conv2_wSignRegs_133;
  reg                 conv2_wSignRegs_134;
  reg                 conv2_wSignRegs_135;
  reg                 conv2_wSignRegs_136;
  reg                 conv2_wSignRegs_137;
  reg                 conv2_wSignRegs_138;
  reg                 conv2_wSignRegs_139;
  reg                 conv2_wSignRegs_140;
  reg                 conv2_wSignRegs_141;
  reg                 conv2_wSignRegs_142;
  reg                 conv2_wSignRegs_143;
  reg                 conv2_wSignRegs_144;
  reg                 conv2_wSignRegs_145;
  reg                 conv2_wSignRegs_146;
  reg                 conv2_wSignRegs_147;
  reg                 conv2_wSignRegs_148;
  reg                 conv2_wSignRegs_149;
  reg                 conv2_wSignRegs_150;
  reg                 conv2_wSignRegs_151;
  reg                 conv2_wSignRegs_152;
  reg                 conv2_wSignRegs_153;
  reg                 conv2_wSignRegs_154;
  reg                 conv2_wSignRegs_155;
  reg                 conv2_wSignRegs_156;
  reg                 conv2_wSignRegs_157;
  reg                 conv2_wSignRegs_158;
  reg                 conv2_wSignRegs_159;
  reg                 conv2_wSignRegs_160;
  reg                 conv2_wSignRegs_161;
  reg                 conv2_wSignRegs_162;
  reg                 conv2_wSignRegs_163;
  reg                 conv2_wSignRegs_164;
  reg                 conv2_wSignRegs_165;
  reg                 conv2_wSignRegs_166;
  reg                 conv2_wSignRegs_167;
  reg                 conv2_wSignRegs_168;
  reg                 conv2_wSignRegs_169;
  reg                 conv2_wSignRegs_170;
  reg                 conv2_wSignRegs_171;
  reg                 conv2_wSignRegs_172;
  reg                 conv2_wSignRegs_173;
  reg                 conv2_wSignRegs_174;
  reg                 conv2_wSignRegs_175;
  reg                 conv2_wSignRegs_176;
  reg                 conv2_wSignRegs_177;
  reg                 conv2_wSignRegs_178;
  reg                 conv2_wSignRegs_179;
  reg                 conv2_wSignRegs_180;
  reg                 conv2_wSignRegs_181;
  reg                 conv2_wSignRegs_182;
  reg                 conv2_wSignRegs_183;
  reg                 conv2_wSignRegs_184;
  reg                 conv2_wSignRegs_185;
  reg                 conv2_wSignRegs_186;
  reg                 conv2_wSignRegs_187;
  reg                 conv2_wSignRegs_188;
  reg                 conv2_wSignRegs_189;
  reg                 conv2_wSignRegs_190;
  reg                 conv2_wSignRegs_191;
  reg                 conv2_wSignRegs_192;
  reg                 conv2_wSignRegs_193;
  reg                 conv2_wSignRegs_194;
  reg                 conv2_wSignRegs_195;
  reg                 conv2_wSignRegs_196;
  reg                 conv2_wSignRegs_197;
  reg                 conv2_wSignRegs_198;
  reg                 conv2_wSignRegs_199;
  reg        [17:0]   conv2_scAcc;
  reg        [31:0]   conv2_combAdjReg;
  reg                 conv2_posBitRegs_0;
  reg                 conv2_posBitRegs_1;
  reg                 conv2_posBitRegs_2;
  reg                 conv2_posBitRegs_3;
  reg                 conv2_posBitRegs_4;
  reg                 conv2_posBitRegs_5;
  reg                 conv2_posBitRegs_6;
  reg                 conv2_posBitRegs_7;
  reg                 conv2_posBitRegs_8;
  reg                 conv2_posBitRegs_9;
  reg                 conv2_posBitRegs_10;
  reg                 conv2_posBitRegs_11;
  reg                 conv2_posBitRegs_12;
  reg                 conv2_posBitRegs_13;
  reg                 conv2_posBitRegs_14;
  reg                 conv2_posBitRegs_15;
  reg                 conv2_posBitRegs_16;
  reg                 conv2_posBitRegs_17;
  reg                 conv2_posBitRegs_18;
  reg                 conv2_posBitRegs_19;
  reg                 conv2_posBitRegs_20;
  reg                 conv2_posBitRegs_21;
  reg                 conv2_posBitRegs_22;
  reg                 conv2_posBitRegs_23;
  reg                 conv2_posBitRegs_24;
  reg                 conv2_posBitRegs_25;
  reg                 conv2_posBitRegs_26;
  reg                 conv2_posBitRegs_27;
  reg                 conv2_posBitRegs_28;
  reg                 conv2_posBitRegs_29;
  reg                 conv2_posBitRegs_30;
  reg                 conv2_posBitRegs_31;
  reg                 conv2_posBitRegs_32;
  reg                 conv2_posBitRegs_33;
  reg                 conv2_posBitRegs_34;
  reg                 conv2_posBitRegs_35;
  reg                 conv2_posBitRegs_36;
  reg                 conv2_posBitRegs_37;
  reg                 conv2_posBitRegs_38;
  reg                 conv2_posBitRegs_39;
  reg                 conv2_posBitRegs_40;
  reg                 conv2_posBitRegs_41;
  reg                 conv2_posBitRegs_42;
  reg                 conv2_posBitRegs_43;
  reg                 conv2_posBitRegs_44;
  reg                 conv2_posBitRegs_45;
  reg                 conv2_posBitRegs_46;
  reg                 conv2_posBitRegs_47;
  reg                 conv2_posBitRegs_48;
  reg                 conv2_posBitRegs_49;
  reg                 conv2_posBitRegs_50;
  reg                 conv2_posBitRegs_51;
  reg                 conv2_posBitRegs_52;
  reg                 conv2_posBitRegs_53;
  reg                 conv2_posBitRegs_54;
  reg                 conv2_posBitRegs_55;
  reg                 conv2_posBitRegs_56;
  reg                 conv2_posBitRegs_57;
  reg                 conv2_posBitRegs_58;
  reg                 conv2_posBitRegs_59;
  reg                 conv2_posBitRegs_60;
  reg                 conv2_posBitRegs_61;
  reg                 conv2_posBitRegs_62;
  reg                 conv2_posBitRegs_63;
  reg                 conv2_posBitRegs_64;
  reg                 conv2_posBitRegs_65;
  reg                 conv2_posBitRegs_66;
  reg                 conv2_posBitRegs_67;
  reg                 conv2_posBitRegs_68;
  reg                 conv2_posBitRegs_69;
  reg                 conv2_posBitRegs_70;
  reg                 conv2_posBitRegs_71;
  reg                 conv2_posBitRegs_72;
  reg                 conv2_posBitRegs_73;
  reg                 conv2_posBitRegs_74;
  reg                 conv2_posBitRegs_75;
  reg                 conv2_posBitRegs_76;
  reg                 conv2_posBitRegs_77;
  reg                 conv2_posBitRegs_78;
  reg                 conv2_posBitRegs_79;
  reg                 conv2_posBitRegs_80;
  reg                 conv2_posBitRegs_81;
  reg                 conv2_posBitRegs_82;
  reg                 conv2_posBitRegs_83;
  reg                 conv2_posBitRegs_84;
  reg                 conv2_posBitRegs_85;
  reg                 conv2_posBitRegs_86;
  reg                 conv2_posBitRegs_87;
  reg                 conv2_posBitRegs_88;
  reg                 conv2_posBitRegs_89;
  reg                 conv2_posBitRegs_90;
  reg                 conv2_posBitRegs_91;
  reg                 conv2_posBitRegs_92;
  reg                 conv2_posBitRegs_93;
  reg                 conv2_posBitRegs_94;
  reg                 conv2_posBitRegs_95;
  reg                 conv2_posBitRegs_96;
  reg                 conv2_posBitRegs_97;
  reg                 conv2_posBitRegs_98;
  reg                 conv2_posBitRegs_99;
  reg                 conv2_posBitRegs_100;
  reg                 conv2_posBitRegs_101;
  reg                 conv2_posBitRegs_102;
  reg                 conv2_posBitRegs_103;
  reg                 conv2_posBitRegs_104;
  reg                 conv2_posBitRegs_105;
  reg                 conv2_posBitRegs_106;
  reg                 conv2_posBitRegs_107;
  reg                 conv2_posBitRegs_108;
  reg                 conv2_posBitRegs_109;
  reg                 conv2_posBitRegs_110;
  reg                 conv2_posBitRegs_111;
  reg                 conv2_posBitRegs_112;
  reg                 conv2_posBitRegs_113;
  reg                 conv2_posBitRegs_114;
  reg                 conv2_posBitRegs_115;
  reg                 conv2_posBitRegs_116;
  reg                 conv2_posBitRegs_117;
  reg                 conv2_posBitRegs_118;
  reg                 conv2_posBitRegs_119;
  reg                 conv2_posBitRegs_120;
  reg                 conv2_posBitRegs_121;
  reg                 conv2_posBitRegs_122;
  reg                 conv2_posBitRegs_123;
  reg                 conv2_posBitRegs_124;
  reg                 conv2_posBitRegs_125;
  reg                 conv2_posBitRegs_126;
  reg                 conv2_posBitRegs_127;
  reg                 conv2_posBitRegs_128;
  reg                 conv2_posBitRegs_129;
  reg                 conv2_posBitRegs_130;
  reg                 conv2_posBitRegs_131;
  reg                 conv2_posBitRegs_132;
  reg                 conv2_posBitRegs_133;
  reg                 conv2_posBitRegs_134;
  reg                 conv2_posBitRegs_135;
  reg                 conv2_posBitRegs_136;
  reg                 conv2_posBitRegs_137;
  reg                 conv2_posBitRegs_138;
  reg                 conv2_posBitRegs_139;
  reg                 conv2_posBitRegs_140;
  reg                 conv2_posBitRegs_141;
  reg                 conv2_posBitRegs_142;
  reg                 conv2_posBitRegs_143;
  reg                 conv2_posBitRegs_144;
  reg                 conv2_posBitRegs_145;
  reg                 conv2_posBitRegs_146;
  reg                 conv2_posBitRegs_147;
  reg                 conv2_posBitRegs_148;
  reg                 conv2_posBitRegs_149;
  reg                 conv2_posBitRegs_150;
  reg                 conv2_posBitRegs_151;
  reg                 conv2_posBitRegs_152;
  reg                 conv2_posBitRegs_153;
  reg                 conv2_posBitRegs_154;
  reg                 conv2_posBitRegs_155;
  reg                 conv2_posBitRegs_156;
  reg                 conv2_posBitRegs_157;
  reg                 conv2_posBitRegs_158;
  reg                 conv2_posBitRegs_159;
  reg                 conv2_posBitRegs_160;
  reg                 conv2_posBitRegs_161;
  reg                 conv2_posBitRegs_162;
  reg                 conv2_posBitRegs_163;
  reg                 conv2_posBitRegs_164;
  reg                 conv2_posBitRegs_165;
  reg                 conv2_posBitRegs_166;
  reg                 conv2_posBitRegs_167;
  reg                 conv2_posBitRegs_168;
  reg                 conv2_posBitRegs_169;
  reg                 conv2_posBitRegs_170;
  reg                 conv2_posBitRegs_171;
  reg                 conv2_posBitRegs_172;
  reg                 conv2_posBitRegs_173;
  reg                 conv2_posBitRegs_174;
  reg                 conv2_posBitRegs_175;
  reg                 conv2_posBitRegs_176;
  reg                 conv2_posBitRegs_177;
  reg                 conv2_posBitRegs_178;
  reg                 conv2_posBitRegs_179;
  reg                 conv2_posBitRegs_180;
  reg                 conv2_posBitRegs_181;
  reg                 conv2_posBitRegs_182;
  reg                 conv2_posBitRegs_183;
  reg                 conv2_posBitRegs_184;
  reg                 conv2_posBitRegs_185;
  reg                 conv2_posBitRegs_186;
  reg                 conv2_posBitRegs_187;
  reg                 conv2_posBitRegs_188;
  reg                 conv2_posBitRegs_189;
  reg                 conv2_posBitRegs_190;
  reg                 conv2_posBitRegs_191;
  reg                 conv2_posBitRegs_192;
  reg                 conv2_posBitRegs_193;
  reg                 conv2_posBitRegs_194;
  reg                 conv2_posBitRegs_195;
  reg                 conv2_posBitRegs_196;
  reg                 conv2_posBitRegs_197;
  reg                 conv2_posBitRegs_198;
  reg                 conv2_posBitRegs_199;
  reg                 conv2_negBitRegs_0;
  reg                 conv2_negBitRegs_1;
  reg                 conv2_negBitRegs_2;
  reg                 conv2_negBitRegs_3;
  reg                 conv2_negBitRegs_4;
  reg                 conv2_negBitRegs_5;
  reg                 conv2_negBitRegs_6;
  reg                 conv2_negBitRegs_7;
  reg                 conv2_negBitRegs_8;
  reg                 conv2_negBitRegs_9;
  reg                 conv2_negBitRegs_10;
  reg                 conv2_negBitRegs_11;
  reg                 conv2_negBitRegs_12;
  reg                 conv2_negBitRegs_13;
  reg                 conv2_negBitRegs_14;
  reg                 conv2_negBitRegs_15;
  reg                 conv2_negBitRegs_16;
  reg                 conv2_negBitRegs_17;
  reg                 conv2_negBitRegs_18;
  reg                 conv2_negBitRegs_19;
  reg                 conv2_negBitRegs_20;
  reg                 conv2_negBitRegs_21;
  reg                 conv2_negBitRegs_22;
  reg                 conv2_negBitRegs_23;
  reg                 conv2_negBitRegs_24;
  reg                 conv2_negBitRegs_25;
  reg                 conv2_negBitRegs_26;
  reg                 conv2_negBitRegs_27;
  reg                 conv2_negBitRegs_28;
  reg                 conv2_negBitRegs_29;
  reg                 conv2_negBitRegs_30;
  reg                 conv2_negBitRegs_31;
  reg                 conv2_negBitRegs_32;
  reg                 conv2_negBitRegs_33;
  reg                 conv2_negBitRegs_34;
  reg                 conv2_negBitRegs_35;
  reg                 conv2_negBitRegs_36;
  reg                 conv2_negBitRegs_37;
  reg                 conv2_negBitRegs_38;
  reg                 conv2_negBitRegs_39;
  reg                 conv2_negBitRegs_40;
  reg                 conv2_negBitRegs_41;
  reg                 conv2_negBitRegs_42;
  reg                 conv2_negBitRegs_43;
  reg                 conv2_negBitRegs_44;
  reg                 conv2_negBitRegs_45;
  reg                 conv2_negBitRegs_46;
  reg                 conv2_negBitRegs_47;
  reg                 conv2_negBitRegs_48;
  reg                 conv2_negBitRegs_49;
  reg                 conv2_negBitRegs_50;
  reg                 conv2_negBitRegs_51;
  reg                 conv2_negBitRegs_52;
  reg                 conv2_negBitRegs_53;
  reg                 conv2_negBitRegs_54;
  reg                 conv2_negBitRegs_55;
  reg                 conv2_negBitRegs_56;
  reg                 conv2_negBitRegs_57;
  reg                 conv2_negBitRegs_58;
  reg                 conv2_negBitRegs_59;
  reg                 conv2_negBitRegs_60;
  reg                 conv2_negBitRegs_61;
  reg                 conv2_negBitRegs_62;
  reg                 conv2_negBitRegs_63;
  reg                 conv2_negBitRegs_64;
  reg                 conv2_negBitRegs_65;
  reg                 conv2_negBitRegs_66;
  reg                 conv2_negBitRegs_67;
  reg                 conv2_negBitRegs_68;
  reg                 conv2_negBitRegs_69;
  reg                 conv2_negBitRegs_70;
  reg                 conv2_negBitRegs_71;
  reg                 conv2_negBitRegs_72;
  reg                 conv2_negBitRegs_73;
  reg                 conv2_negBitRegs_74;
  reg                 conv2_negBitRegs_75;
  reg                 conv2_negBitRegs_76;
  reg                 conv2_negBitRegs_77;
  reg                 conv2_negBitRegs_78;
  reg                 conv2_negBitRegs_79;
  reg                 conv2_negBitRegs_80;
  reg                 conv2_negBitRegs_81;
  reg                 conv2_negBitRegs_82;
  reg                 conv2_negBitRegs_83;
  reg                 conv2_negBitRegs_84;
  reg                 conv2_negBitRegs_85;
  reg                 conv2_negBitRegs_86;
  reg                 conv2_negBitRegs_87;
  reg                 conv2_negBitRegs_88;
  reg                 conv2_negBitRegs_89;
  reg                 conv2_negBitRegs_90;
  reg                 conv2_negBitRegs_91;
  reg                 conv2_negBitRegs_92;
  reg                 conv2_negBitRegs_93;
  reg                 conv2_negBitRegs_94;
  reg                 conv2_negBitRegs_95;
  reg                 conv2_negBitRegs_96;
  reg                 conv2_negBitRegs_97;
  reg                 conv2_negBitRegs_98;
  reg                 conv2_negBitRegs_99;
  reg                 conv2_negBitRegs_100;
  reg                 conv2_negBitRegs_101;
  reg                 conv2_negBitRegs_102;
  reg                 conv2_negBitRegs_103;
  reg                 conv2_negBitRegs_104;
  reg                 conv2_negBitRegs_105;
  reg                 conv2_negBitRegs_106;
  reg                 conv2_negBitRegs_107;
  reg                 conv2_negBitRegs_108;
  reg                 conv2_negBitRegs_109;
  reg                 conv2_negBitRegs_110;
  reg                 conv2_negBitRegs_111;
  reg                 conv2_negBitRegs_112;
  reg                 conv2_negBitRegs_113;
  reg                 conv2_negBitRegs_114;
  reg                 conv2_negBitRegs_115;
  reg                 conv2_negBitRegs_116;
  reg                 conv2_negBitRegs_117;
  reg                 conv2_negBitRegs_118;
  reg                 conv2_negBitRegs_119;
  reg                 conv2_negBitRegs_120;
  reg                 conv2_negBitRegs_121;
  reg                 conv2_negBitRegs_122;
  reg                 conv2_negBitRegs_123;
  reg                 conv2_negBitRegs_124;
  reg                 conv2_negBitRegs_125;
  reg                 conv2_negBitRegs_126;
  reg                 conv2_negBitRegs_127;
  reg                 conv2_negBitRegs_128;
  reg                 conv2_negBitRegs_129;
  reg                 conv2_negBitRegs_130;
  reg                 conv2_negBitRegs_131;
  reg                 conv2_negBitRegs_132;
  reg                 conv2_negBitRegs_133;
  reg                 conv2_negBitRegs_134;
  reg                 conv2_negBitRegs_135;
  reg                 conv2_negBitRegs_136;
  reg                 conv2_negBitRegs_137;
  reg                 conv2_negBitRegs_138;
  reg                 conv2_negBitRegs_139;
  reg                 conv2_negBitRegs_140;
  reg                 conv2_negBitRegs_141;
  reg                 conv2_negBitRegs_142;
  reg                 conv2_negBitRegs_143;
  reg                 conv2_negBitRegs_144;
  reg                 conv2_negBitRegs_145;
  reg                 conv2_negBitRegs_146;
  reg                 conv2_negBitRegs_147;
  reg                 conv2_negBitRegs_148;
  reg                 conv2_negBitRegs_149;
  reg                 conv2_negBitRegs_150;
  reg                 conv2_negBitRegs_151;
  reg                 conv2_negBitRegs_152;
  reg                 conv2_negBitRegs_153;
  reg                 conv2_negBitRegs_154;
  reg                 conv2_negBitRegs_155;
  reg                 conv2_negBitRegs_156;
  reg                 conv2_negBitRegs_157;
  reg                 conv2_negBitRegs_158;
  reg                 conv2_negBitRegs_159;
  reg                 conv2_negBitRegs_160;
  reg                 conv2_negBitRegs_161;
  reg                 conv2_negBitRegs_162;
  reg                 conv2_negBitRegs_163;
  reg                 conv2_negBitRegs_164;
  reg                 conv2_negBitRegs_165;
  reg                 conv2_negBitRegs_166;
  reg                 conv2_negBitRegs_167;
  reg                 conv2_negBitRegs_168;
  reg                 conv2_negBitRegs_169;
  reg                 conv2_negBitRegs_170;
  reg                 conv2_negBitRegs_171;
  reg                 conv2_negBitRegs_172;
  reg                 conv2_negBitRegs_173;
  reg                 conv2_negBitRegs_174;
  reg                 conv2_negBitRegs_175;
  reg                 conv2_negBitRegs_176;
  reg                 conv2_negBitRegs_177;
  reg                 conv2_negBitRegs_178;
  reg                 conv2_negBitRegs_179;
  reg                 conv2_negBitRegs_180;
  reg                 conv2_negBitRegs_181;
  reg                 conv2_negBitRegs_182;
  reg                 conv2_negBitRegs_183;
  reg                 conv2_negBitRegs_184;
  reg                 conv2_negBitRegs_185;
  reg                 conv2_negBitRegs_186;
  reg                 conv2_negBitRegs_187;
  reg                 conv2_negBitRegs_188;
  reg                 conv2_negBitRegs_189;
  reg                 conv2_negBitRegs_190;
  reg                 conv2_negBitRegs_191;
  reg                 conv2_negBitRegs_192;
  reg                 conv2_negBitRegs_193;
  reg                 conv2_negBitRegs_194;
  reg                 conv2_negBitRegs_195;
  reg                 conv2_negBitRegs_196;
  reg                 conv2_negBitRegs_197;
  reg                 conv2_negBitRegs_198;
  reg                 conv2_negBitRegs_199;
  wire                _zz_conv2_posBitRegs_0;
  wire                _zz_conv2_posBitRegs_1;
  wire                _zz_conv2_posBitRegs_2;
  wire                _zz_conv2_posBitRegs_3;
  wire                _zz_conv2_posBitRegs_4;
  wire                _zz_conv2_posBitRegs_5;
  wire                _zz_conv2_posBitRegs_6;
  wire                _zz_conv2_posBitRegs_7;
  wire                _zz_conv2_posBitRegs_8;
  wire                _zz_conv2_posBitRegs_9;
  wire                _zz_conv2_posBitRegs_10;
  wire                _zz_conv2_posBitRegs_11;
  wire                _zz_conv2_posBitRegs_12;
  wire                _zz_conv2_posBitRegs_13;
  wire                _zz_conv2_posBitRegs_14;
  wire                _zz_conv2_posBitRegs_15;
  wire                _zz_conv2_posBitRegs_16;
  wire                _zz_conv2_posBitRegs_17;
  wire                _zz_conv2_posBitRegs_18;
  wire                _zz_conv2_posBitRegs_19;
  wire                _zz_conv2_posBitRegs_20;
  wire                _zz_conv2_posBitRegs_21;
  wire                _zz_conv2_posBitRegs_22;
  wire                _zz_conv2_posBitRegs_23;
  wire                _zz_conv2_posBitRegs_24;
  wire                _zz_conv2_posBitRegs_25;
  wire                _zz_conv2_posBitRegs_26;
  wire                _zz_conv2_posBitRegs_27;
  wire                _zz_conv2_posBitRegs_28;
  wire                _zz_conv2_posBitRegs_29;
  wire                _zz_conv2_posBitRegs_30;
  wire                _zz_conv2_posBitRegs_31;
  wire                _zz_conv2_posBitRegs_32;
  wire                _zz_conv2_posBitRegs_33;
  wire                _zz_conv2_posBitRegs_34;
  wire                _zz_conv2_posBitRegs_35;
  wire                _zz_conv2_posBitRegs_36;
  wire                _zz_conv2_posBitRegs_37;
  wire                _zz_conv2_posBitRegs_38;
  wire                _zz_conv2_posBitRegs_39;
  wire                _zz_conv2_posBitRegs_40;
  wire                _zz_conv2_posBitRegs_41;
  wire                _zz_conv2_posBitRegs_42;
  wire                _zz_conv2_posBitRegs_43;
  wire                _zz_conv2_posBitRegs_44;
  wire                _zz_conv2_posBitRegs_45;
  wire                _zz_conv2_posBitRegs_46;
  wire                _zz_conv2_posBitRegs_47;
  wire                _zz_conv2_posBitRegs_48;
  wire                _zz_conv2_posBitRegs_49;
  wire                _zz_conv2_posBitRegs_50;
  wire                _zz_conv2_posBitRegs_51;
  wire                _zz_conv2_posBitRegs_52;
  wire                _zz_conv2_posBitRegs_53;
  wire                _zz_conv2_posBitRegs_54;
  wire                _zz_conv2_posBitRegs_55;
  wire                _zz_conv2_posBitRegs_56;
  wire                _zz_conv2_posBitRegs_57;
  wire                _zz_conv2_posBitRegs_58;
  wire                _zz_conv2_posBitRegs_59;
  wire                _zz_conv2_posBitRegs_60;
  wire                _zz_conv2_posBitRegs_61;
  wire                _zz_conv2_posBitRegs_62;
  wire                _zz_conv2_posBitRegs_63;
  wire                _zz_conv2_posBitRegs_64;
  wire                _zz_conv2_posBitRegs_65;
  wire                _zz_conv2_posBitRegs_66;
  wire                _zz_conv2_posBitRegs_67;
  wire                _zz_conv2_posBitRegs_68;
  wire                _zz_conv2_posBitRegs_69;
  wire                _zz_conv2_posBitRegs_70;
  wire                _zz_conv2_posBitRegs_71;
  wire                _zz_conv2_posBitRegs_72;
  wire                _zz_conv2_posBitRegs_73;
  wire                _zz_conv2_posBitRegs_74;
  wire                _zz_conv2_posBitRegs_75;
  wire                _zz_conv2_posBitRegs_76;
  wire                _zz_conv2_posBitRegs_77;
  wire                _zz_conv2_posBitRegs_78;
  wire                _zz_conv2_posBitRegs_79;
  wire                _zz_conv2_posBitRegs_80;
  wire                _zz_conv2_posBitRegs_81;
  wire                _zz_conv2_posBitRegs_82;
  wire                _zz_conv2_posBitRegs_83;
  wire                _zz_conv2_posBitRegs_84;
  wire                _zz_conv2_posBitRegs_85;
  wire                _zz_conv2_posBitRegs_86;
  wire                _zz_conv2_posBitRegs_87;
  wire                _zz_conv2_posBitRegs_88;
  wire                _zz_conv2_posBitRegs_89;
  wire                _zz_conv2_posBitRegs_90;
  wire                _zz_conv2_posBitRegs_91;
  wire                _zz_conv2_posBitRegs_92;
  wire                _zz_conv2_posBitRegs_93;
  wire                _zz_conv2_posBitRegs_94;
  wire                _zz_conv2_posBitRegs_95;
  wire                _zz_conv2_posBitRegs_96;
  wire                _zz_conv2_posBitRegs_97;
  wire                _zz_conv2_posBitRegs_98;
  wire                _zz_conv2_posBitRegs_99;
  wire                _zz_conv2_posBitRegs_100;
  wire                _zz_conv2_posBitRegs_101;
  wire                _zz_conv2_posBitRegs_102;
  wire                _zz_conv2_posBitRegs_103;
  wire                _zz_conv2_posBitRegs_104;
  wire                _zz_conv2_posBitRegs_105;
  wire                _zz_conv2_posBitRegs_106;
  wire                _zz_conv2_posBitRegs_107;
  wire                _zz_conv2_posBitRegs_108;
  wire                _zz_conv2_posBitRegs_109;
  wire                _zz_conv2_posBitRegs_110;
  wire                _zz_conv2_posBitRegs_111;
  wire                _zz_conv2_posBitRegs_112;
  wire                _zz_conv2_posBitRegs_113;
  wire                _zz_conv2_posBitRegs_114;
  wire                _zz_conv2_posBitRegs_115;
  wire                _zz_conv2_posBitRegs_116;
  wire                _zz_conv2_posBitRegs_117;
  wire                _zz_conv2_posBitRegs_118;
  wire                _zz_conv2_posBitRegs_119;
  wire                _zz_conv2_posBitRegs_120;
  wire                _zz_conv2_posBitRegs_121;
  wire                _zz_conv2_posBitRegs_122;
  wire                _zz_conv2_posBitRegs_123;
  wire                _zz_conv2_posBitRegs_124;
  wire                _zz_conv2_posBitRegs_125;
  wire                _zz_conv2_posBitRegs_126;
  wire                _zz_conv2_posBitRegs_127;
  wire                _zz_conv2_posBitRegs_128;
  wire                _zz_conv2_posBitRegs_129;
  wire                _zz_conv2_posBitRegs_130;
  wire                _zz_conv2_posBitRegs_131;
  wire                _zz_conv2_posBitRegs_132;
  wire                _zz_conv2_posBitRegs_133;
  wire                _zz_conv2_posBitRegs_134;
  wire                _zz_conv2_posBitRegs_135;
  wire                _zz_conv2_posBitRegs_136;
  wire                _zz_conv2_posBitRegs_137;
  wire                _zz_conv2_posBitRegs_138;
  wire                _zz_conv2_posBitRegs_139;
  wire                _zz_conv2_posBitRegs_140;
  wire                _zz_conv2_posBitRegs_141;
  wire                _zz_conv2_posBitRegs_142;
  wire                _zz_conv2_posBitRegs_143;
  wire                _zz_conv2_posBitRegs_144;
  wire                _zz_conv2_posBitRegs_145;
  wire                _zz_conv2_posBitRegs_146;
  wire                _zz_conv2_posBitRegs_147;
  wire                _zz_conv2_posBitRegs_148;
  wire                _zz_conv2_posBitRegs_149;
  wire                _zz_conv2_posBitRegs_150;
  wire                _zz_conv2_posBitRegs_151;
  wire                _zz_conv2_posBitRegs_152;
  wire                _zz_conv2_posBitRegs_153;
  wire                _zz_conv2_posBitRegs_154;
  wire                _zz_conv2_posBitRegs_155;
  wire                _zz_conv2_posBitRegs_156;
  wire                _zz_conv2_posBitRegs_157;
  wire                _zz_conv2_posBitRegs_158;
  wire                _zz_conv2_posBitRegs_159;
  wire                _zz_conv2_posBitRegs_160;
  wire                _zz_conv2_posBitRegs_161;
  wire                _zz_conv2_posBitRegs_162;
  wire                _zz_conv2_posBitRegs_163;
  wire                _zz_conv2_posBitRegs_164;
  wire                _zz_conv2_posBitRegs_165;
  wire                _zz_conv2_posBitRegs_166;
  wire                _zz_conv2_posBitRegs_167;
  wire                _zz_conv2_posBitRegs_168;
  wire                _zz_conv2_posBitRegs_169;
  wire                _zz_conv2_posBitRegs_170;
  wire                _zz_conv2_posBitRegs_171;
  wire                _zz_conv2_posBitRegs_172;
  wire                _zz_conv2_posBitRegs_173;
  wire                _zz_conv2_posBitRegs_174;
  wire                _zz_conv2_posBitRegs_175;
  wire                _zz_conv2_posBitRegs_176;
  wire                _zz_conv2_posBitRegs_177;
  wire                _zz_conv2_posBitRegs_178;
  wire                _zz_conv2_posBitRegs_179;
  wire                _zz_conv2_posBitRegs_180;
  wire                _zz_conv2_posBitRegs_181;
  wire                _zz_conv2_posBitRegs_182;
  wire                _zz_conv2_posBitRegs_183;
  wire                _zz_conv2_posBitRegs_184;
  wire                _zz_conv2_posBitRegs_185;
  wire                _zz_conv2_posBitRegs_186;
  wire                _zz_conv2_posBitRegs_187;
  wire                _zz_conv2_posBitRegs_188;
  wire                _zz_conv2_posBitRegs_189;
  wire                _zz_conv2_posBitRegs_190;
  wire                _zz_conv2_posBitRegs_191;
  wire                _zz_conv2_posBitRegs_192;
  wire                _zz_conv2_posBitRegs_193;
  wire                _zz_conv2_posBitRegs_194;
  wire                _zz_conv2_posBitRegs_195;
  wire                _zz_conv2_posBitRegs_196;
  wire                _zz_conv2_posBitRegs_197;
  wire                _zz_conv2_posBitRegs_198;
  wire                _zz_conv2_posBitRegs_199;
  wire       [7:0]    _zz_conv2_posCount;
  wire       [7:0]    _zz_conv2_posCount_1;
  wire       [7:0]    _zz_conv2_posCount_2;
  wire       [7:0]    _zz_conv2_posCount_3;
  wire       [7:0]    _zz_conv2_posCount_4;
  wire       [7:0]    _zz_conv2_posCount_5;
  wire       [7:0]    _zz_conv2_posCount_6;
  wire       [7:0]    _zz_conv2_posCount_7;
  wire       [8:0]    conv2_posCount;
  wire       [7:0]    _zz_conv2_negCount;
  wire       [7:0]    _zz_conv2_negCount_1;
  wire       [7:0]    _zz_conv2_negCount_2;
  wire       [7:0]    _zz_conv2_negCount_3;
  wire       [7:0]    _zz_conv2_negCount_4;
  wire       [7:0]    _zz_conv2_negCount_5;
  wire       [7:0]    _zz_conv2_negCount_6;
  wire       [7:0]    _zz_conv2_negCount_7;
  wire       [8:0]    conv2_negCount;
  reg        [10:0]   conv2_rxCnt;
  reg        [11:0]   conv2_rxAddr;
  reg        [6:0]    conv2_rxRow;
  reg        [4:0]    conv2_ocReg;
  reg        [3:0]    conv2_outHReg;
  reg        [3:0]    conv2_outWReg;
  reg        [7:0]    conv2_loadStep;
  reg        [7:0]    conv2_scStep;
  reg        [11:0]   conv2_wAddrBase;
  reg        [11:0]   conv2_initAddr;
  reg                 conv2_activationOut_valid;
  wire                conv2_activationOut_ready;
  reg        [7:0]    conv2_activationOut_payload_value;
  wire                when_StochasticConvCore_l279_1;
  wire                when_StochasticConvCore_l280_1;
  wire                when_StochasticConvCore_l288_1;
  wire                MaxPoolLinePlugin_logic_outStream_fire;
  wire                _zz_conv2_rxAddr;
  wire                when_StochasticConvCore_l295_1;
  wire                when_StochasticConvCore_l315_1;
  wire       [11:0]   conv2_pixelBase;
  wire       [11:0]   conv2_kOffVec_0;
  wire       [11:0]   conv2_kOffVec_1;
  wire       [11:0]   conv2_kOffVec_2;
  wire       [11:0]   conv2_kOffVec_3;
  wire       [11:0]   conv2_kOffVec_4;
  wire       [11:0]   conv2_kOffVec_5;
  wire       [11:0]   conv2_kOffVec_6;
  wire       [11:0]   conv2_kOffVec_7;
  wire       [11:0]   conv2_kOffVec_8;
  wire       [11:0]   conv2_kOffVec_9;
  wire       [11:0]   conv2_kOffVec_10;
  wire       [11:0]   conv2_kOffVec_11;
  wire       [11:0]   conv2_kOffVec_12;
  wire       [11:0]   conv2_kOffVec_13;
  wire       [11:0]   conv2_kOffVec_14;
  wire       [11:0]   conv2_kOffVec_15;
  wire       [11:0]   conv2_kOffVec_16;
  wire       [11:0]   conv2_kOffVec_17;
  wire       [11:0]   conv2_kOffVec_18;
  wire       [11:0]   conv2_kOffVec_19;
  wire       [11:0]   conv2_kOffVec_20;
  wire       [11:0]   conv2_kOffVec_21;
  wire       [11:0]   conv2_kOffVec_22;
  wire       [11:0]   conv2_kOffVec_23;
  wire       [11:0]   conv2_kOffVec_24;
  wire       [11:0]   conv2_kOffVec_25;
  wire       [11:0]   conv2_kOffVec_26;
  wire       [11:0]   conv2_kOffVec_27;
  wire       [11:0]   conv2_kOffVec_28;
  wire       [11:0]   conv2_kOffVec_29;
  wire       [11:0]   conv2_kOffVec_30;
  wire       [11:0]   conv2_kOffVec_31;
  wire       [11:0]   conv2_kOffVec_32;
  wire       [11:0]   conv2_kOffVec_33;
  wire       [11:0]   conv2_kOffVec_34;
  wire       [11:0]   conv2_kOffVec_35;
  wire       [11:0]   conv2_kOffVec_36;
  wire       [11:0]   conv2_kOffVec_37;
  wire       [11:0]   conv2_kOffVec_38;
  wire       [11:0]   conv2_kOffVec_39;
  wire       [11:0]   conv2_kOffVec_40;
  wire       [11:0]   conv2_kOffVec_41;
  wire       [11:0]   conv2_kOffVec_42;
  wire       [11:0]   conv2_kOffVec_43;
  wire       [11:0]   conv2_kOffVec_44;
  wire       [11:0]   conv2_kOffVec_45;
  wire       [11:0]   conv2_kOffVec_46;
  wire       [11:0]   conv2_kOffVec_47;
  wire       [11:0]   conv2_kOffVec_48;
  wire       [11:0]   conv2_kOffVec_49;
  wire       [11:0]   conv2_kOffVec_50;
  wire       [11:0]   conv2_kOffVec_51;
  wire       [11:0]   conv2_kOffVec_52;
  wire       [11:0]   conv2_kOffVec_53;
  wire       [11:0]   conv2_kOffVec_54;
  wire       [11:0]   conv2_kOffVec_55;
  wire       [11:0]   conv2_kOffVec_56;
  wire       [11:0]   conv2_kOffVec_57;
  wire       [11:0]   conv2_kOffVec_58;
  wire       [11:0]   conv2_kOffVec_59;
  wire       [11:0]   conv2_kOffVec_60;
  wire       [11:0]   conv2_kOffVec_61;
  wire       [11:0]   conv2_kOffVec_62;
  wire       [11:0]   conv2_kOffVec_63;
  wire       [11:0]   conv2_kOffVec_64;
  wire       [11:0]   conv2_kOffVec_65;
  wire       [11:0]   conv2_kOffVec_66;
  wire       [11:0]   conv2_kOffVec_67;
  wire       [11:0]   conv2_kOffVec_68;
  wire       [11:0]   conv2_kOffVec_69;
  wire       [11:0]   conv2_kOffVec_70;
  wire       [11:0]   conv2_kOffVec_71;
  wire       [11:0]   conv2_kOffVec_72;
  wire       [11:0]   conv2_kOffVec_73;
  wire       [11:0]   conv2_kOffVec_74;
  wire       [11:0]   conv2_kOffVec_75;
  wire       [11:0]   conv2_kOffVec_76;
  wire       [11:0]   conv2_kOffVec_77;
  wire       [11:0]   conv2_kOffVec_78;
  wire       [11:0]   conv2_kOffVec_79;
  wire       [11:0]   conv2_kOffVec_80;
  wire       [11:0]   conv2_kOffVec_81;
  wire       [11:0]   conv2_kOffVec_82;
  wire       [11:0]   conv2_kOffVec_83;
  wire       [11:0]   conv2_kOffVec_84;
  wire       [11:0]   conv2_kOffVec_85;
  wire       [11:0]   conv2_kOffVec_86;
  wire       [11:0]   conv2_kOffVec_87;
  wire       [11:0]   conv2_kOffVec_88;
  wire       [11:0]   conv2_kOffVec_89;
  wire       [11:0]   conv2_kOffVec_90;
  wire       [11:0]   conv2_kOffVec_91;
  wire       [11:0]   conv2_kOffVec_92;
  wire       [11:0]   conv2_kOffVec_93;
  wire       [11:0]   conv2_kOffVec_94;
  wire       [11:0]   conv2_kOffVec_95;
  wire       [11:0]   conv2_kOffVec_96;
  wire       [11:0]   conv2_kOffVec_97;
  wire       [11:0]   conv2_kOffVec_98;
  wire       [11:0]   conv2_kOffVec_99;
  wire       [11:0]   conv2_kOffVec_100;
  wire       [11:0]   conv2_kOffVec_101;
  wire       [11:0]   conv2_kOffVec_102;
  wire       [11:0]   conv2_kOffVec_103;
  wire       [11:0]   conv2_kOffVec_104;
  wire       [11:0]   conv2_kOffVec_105;
  wire       [11:0]   conv2_kOffVec_106;
  wire       [11:0]   conv2_kOffVec_107;
  wire       [11:0]   conv2_kOffVec_108;
  wire       [11:0]   conv2_kOffVec_109;
  wire       [11:0]   conv2_kOffVec_110;
  wire       [11:0]   conv2_kOffVec_111;
  wire       [11:0]   conv2_kOffVec_112;
  wire       [11:0]   conv2_kOffVec_113;
  wire       [11:0]   conv2_kOffVec_114;
  wire       [11:0]   conv2_kOffVec_115;
  wire       [11:0]   conv2_kOffVec_116;
  wire       [11:0]   conv2_kOffVec_117;
  wire       [11:0]   conv2_kOffVec_118;
  wire       [11:0]   conv2_kOffVec_119;
  wire       [11:0]   conv2_kOffVec_120;
  wire       [11:0]   conv2_kOffVec_121;
  wire       [11:0]   conv2_kOffVec_122;
  wire       [11:0]   conv2_kOffVec_123;
  wire       [11:0]   conv2_kOffVec_124;
  wire       [11:0]   conv2_kOffVec_125;
  wire       [11:0]   conv2_kOffVec_126;
  wire       [11:0]   conv2_kOffVec_127;
  wire       [11:0]   conv2_kOffVec_128;
  wire       [11:0]   conv2_kOffVec_129;
  wire       [11:0]   conv2_kOffVec_130;
  wire       [11:0]   conv2_kOffVec_131;
  wire       [11:0]   conv2_kOffVec_132;
  wire       [11:0]   conv2_kOffVec_133;
  wire       [11:0]   conv2_kOffVec_134;
  wire       [11:0]   conv2_kOffVec_135;
  wire       [11:0]   conv2_kOffVec_136;
  wire       [11:0]   conv2_kOffVec_137;
  wire       [11:0]   conv2_kOffVec_138;
  wire       [11:0]   conv2_kOffVec_139;
  wire       [11:0]   conv2_kOffVec_140;
  wire       [11:0]   conv2_kOffVec_141;
  wire       [11:0]   conv2_kOffVec_142;
  wire       [11:0]   conv2_kOffVec_143;
  wire       [11:0]   conv2_kOffVec_144;
  wire       [11:0]   conv2_kOffVec_145;
  wire       [11:0]   conv2_kOffVec_146;
  wire       [11:0]   conv2_kOffVec_147;
  wire       [11:0]   conv2_kOffVec_148;
  wire       [11:0]   conv2_kOffVec_149;
  wire       [11:0]   conv2_kOffVec_150;
  wire       [11:0]   conv2_kOffVec_151;
  wire       [11:0]   conv2_kOffVec_152;
  wire       [11:0]   conv2_kOffVec_153;
  wire       [11:0]   conv2_kOffVec_154;
  wire       [11:0]   conv2_kOffVec_155;
  wire       [11:0]   conv2_kOffVec_156;
  wire       [11:0]   conv2_kOffVec_157;
  wire       [11:0]   conv2_kOffVec_158;
  wire       [11:0]   conv2_kOffVec_159;
  wire       [11:0]   conv2_kOffVec_160;
  wire       [11:0]   conv2_kOffVec_161;
  wire       [11:0]   conv2_kOffVec_162;
  wire       [11:0]   conv2_kOffVec_163;
  wire       [11:0]   conv2_kOffVec_164;
  wire       [11:0]   conv2_kOffVec_165;
  wire       [11:0]   conv2_kOffVec_166;
  wire       [11:0]   conv2_kOffVec_167;
  wire       [11:0]   conv2_kOffVec_168;
  wire       [11:0]   conv2_kOffVec_169;
  wire       [11:0]   conv2_kOffVec_170;
  wire       [11:0]   conv2_kOffVec_171;
  wire       [11:0]   conv2_kOffVec_172;
  wire       [11:0]   conv2_kOffVec_173;
  wire       [11:0]   conv2_kOffVec_174;
  wire       [11:0]   conv2_kOffVec_175;
  wire       [11:0]   conv2_kOffVec_176;
  wire       [11:0]   conv2_kOffVec_177;
  wire       [11:0]   conv2_kOffVec_178;
  wire       [11:0]   conv2_kOffVec_179;
  wire       [11:0]   conv2_kOffVec_180;
  wire       [11:0]   conv2_kOffVec_181;
  wire       [11:0]   conv2_kOffVec_182;
  wire       [11:0]   conv2_kOffVec_183;
  wire       [11:0]   conv2_kOffVec_184;
  wire       [11:0]   conv2_kOffVec_185;
  wire       [11:0]   conv2_kOffVec_186;
  wire       [11:0]   conv2_kOffVec_187;
  wire       [11:0]   conv2_kOffVec_188;
  wire       [11:0]   conv2_kOffVec_189;
  wire       [11:0]   conv2_kOffVec_190;
  wire       [11:0]   conv2_kOffVec_191;
  wire       [11:0]   conv2_kOffVec_192;
  wire       [11:0]   conv2_kOffVec_193;
  wire       [11:0]   conv2_kOffVec_194;
  wire       [11:0]   conv2_kOffVec_195;
  wire       [11:0]   conv2_kOffVec_196;
  wire       [11:0]   conv2_kOffVec_197;
  wire       [11:0]   conv2_kOffVec_198;
  wire       [11:0]   conv2_kOffVec_199;
  wire       [7:0]    conv2_safeStep;
  wire       [11:0]   conv2_actReadAddr;
  wire                conv2_loadInRange;
  wire       [7:0]    conv2_actBufRead;
  wire       [11:0]   _zz_conv2_wThrRead;
  wire       [7:0]    conv2_wThrRead;
  wire       [11:0]   _zz_conv2_wSignRead;
  wire                conv2_wSignRead;
  wire       [4:0]    _zz_conv2_combAdjRead;
  wire                _zz_conv2_combAdjRead_1;
  wire       [31:0]   conv2_combAdjRead;
  wire                when_StochasticConvCore_l345_1;
  wire                when_StochasticConvCore_l349_1;
  wire                when_StochasticConvCore_l353_25;
  wire                when_StochasticConvCore_l353_26;
  wire                when_StochasticConvCore_l353_27;
  wire                when_StochasticConvCore_l353_28;
  wire                when_StochasticConvCore_l353_29;
  wire                when_StochasticConvCore_l353_30;
  wire                when_StochasticConvCore_l353_31;
  wire                when_StochasticConvCore_l353_32;
  wire                when_StochasticConvCore_l353_33;
  wire                when_StochasticConvCore_l353_34;
  wire                when_StochasticConvCore_l353_35;
  wire                when_StochasticConvCore_l353_36;
  wire                when_StochasticConvCore_l353_37;
  wire                when_StochasticConvCore_l353_38;
  wire                when_StochasticConvCore_l353_39;
  wire                when_StochasticConvCore_l353_40;
  wire                when_StochasticConvCore_l353_41;
  wire                when_StochasticConvCore_l353_42;
  wire                when_StochasticConvCore_l353_43;
  wire                when_StochasticConvCore_l353_44;
  wire                when_StochasticConvCore_l353_45;
  wire                when_StochasticConvCore_l353_46;
  wire                when_StochasticConvCore_l353_47;
  wire                when_StochasticConvCore_l353_48;
  wire                when_StochasticConvCore_l353_49;
  wire                when_StochasticConvCore_l353_50;
  wire                when_StochasticConvCore_l353_51;
  wire                when_StochasticConvCore_l353_52;
  wire                when_StochasticConvCore_l353_53;
  wire                when_StochasticConvCore_l353_54;
  wire                when_StochasticConvCore_l353_55;
  wire                when_StochasticConvCore_l353_56;
  wire                when_StochasticConvCore_l353_57;
  wire                when_StochasticConvCore_l353_58;
  wire                when_StochasticConvCore_l353_59;
  wire                when_StochasticConvCore_l353_60;
  wire                when_StochasticConvCore_l353_61;
  wire                when_StochasticConvCore_l353_62;
  wire                when_StochasticConvCore_l353_63;
  wire                when_StochasticConvCore_l353_64;
  wire                when_StochasticConvCore_l353_65;
  wire                when_StochasticConvCore_l353_66;
  wire                when_StochasticConvCore_l353_67;
  wire                when_StochasticConvCore_l353_68;
  wire                when_StochasticConvCore_l353_69;
  wire                when_StochasticConvCore_l353_70;
  wire                when_StochasticConvCore_l353_71;
  wire                when_StochasticConvCore_l353_72;
  wire                when_StochasticConvCore_l353_73;
  wire                when_StochasticConvCore_l353_74;
  wire                when_StochasticConvCore_l353_75;
  wire                when_StochasticConvCore_l353_76;
  wire                when_StochasticConvCore_l353_77;
  wire                when_StochasticConvCore_l353_78;
  wire                when_StochasticConvCore_l353_79;
  wire                when_StochasticConvCore_l353_80;
  wire                when_StochasticConvCore_l353_81;
  wire                when_StochasticConvCore_l353_82;
  wire                when_StochasticConvCore_l353_83;
  wire                when_StochasticConvCore_l353_84;
  wire                when_StochasticConvCore_l353_85;
  wire                when_StochasticConvCore_l353_86;
  wire                when_StochasticConvCore_l353_87;
  wire                when_StochasticConvCore_l353_88;
  wire                when_StochasticConvCore_l353_89;
  wire                when_StochasticConvCore_l353_90;
  wire                when_StochasticConvCore_l353_91;
  wire                when_StochasticConvCore_l353_92;
  wire                when_StochasticConvCore_l353_93;
  wire                when_StochasticConvCore_l353_94;
  wire                when_StochasticConvCore_l353_95;
  wire                when_StochasticConvCore_l353_96;
  wire                when_StochasticConvCore_l353_97;
  wire                when_StochasticConvCore_l353_98;
  wire                when_StochasticConvCore_l353_99;
  wire                when_StochasticConvCore_l353_100;
  wire                when_StochasticConvCore_l353_101;
  wire                when_StochasticConvCore_l353_102;
  wire                when_StochasticConvCore_l353_103;
  wire                when_StochasticConvCore_l353_104;
  wire                when_StochasticConvCore_l353_105;
  wire                when_StochasticConvCore_l353_106;
  wire                when_StochasticConvCore_l353_107;
  wire                when_StochasticConvCore_l353_108;
  wire                when_StochasticConvCore_l353_109;
  wire                when_StochasticConvCore_l353_110;
  wire                when_StochasticConvCore_l353_111;
  wire                when_StochasticConvCore_l353_112;
  wire                when_StochasticConvCore_l353_113;
  wire                when_StochasticConvCore_l353_114;
  wire                when_StochasticConvCore_l353_115;
  wire                when_StochasticConvCore_l353_116;
  wire                when_StochasticConvCore_l353_117;
  wire                when_StochasticConvCore_l353_118;
  wire                when_StochasticConvCore_l353_119;
  wire                when_StochasticConvCore_l353_120;
  wire                when_StochasticConvCore_l353_121;
  wire                when_StochasticConvCore_l353_122;
  wire                when_StochasticConvCore_l353_123;
  wire                when_StochasticConvCore_l353_124;
  wire                when_StochasticConvCore_l353_125;
  wire                when_StochasticConvCore_l353_126;
  wire                when_StochasticConvCore_l353_127;
  wire                when_StochasticConvCore_l353_128;
  wire                when_StochasticConvCore_l353_129;
  wire                when_StochasticConvCore_l353_130;
  wire                when_StochasticConvCore_l353_131;
  wire                when_StochasticConvCore_l353_132;
  wire                when_StochasticConvCore_l353_133;
  wire                when_StochasticConvCore_l353_134;
  wire                when_StochasticConvCore_l353_135;
  wire                when_StochasticConvCore_l353_136;
  wire                when_StochasticConvCore_l353_137;
  wire                when_StochasticConvCore_l353_138;
  wire                when_StochasticConvCore_l353_139;
  wire                when_StochasticConvCore_l353_140;
  wire                when_StochasticConvCore_l353_141;
  wire                when_StochasticConvCore_l353_142;
  wire                when_StochasticConvCore_l353_143;
  wire                when_StochasticConvCore_l353_144;
  wire                when_StochasticConvCore_l353_145;
  wire                when_StochasticConvCore_l353_146;
  wire                when_StochasticConvCore_l353_147;
  wire                when_StochasticConvCore_l353_148;
  wire                when_StochasticConvCore_l353_149;
  wire                when_StochasticConvCore_l353_150;
  wire                when_StochasticConvCore_l353_151;
  wire                when_StochasticConvCore_l353_152;
  wire                when_StochasticConvCore_l353_153;
  wire                when_StochasticConvCore_l353_154;
  wire                when_StochasticConvCore_l353_155;
  wire                when_StochasticConvCore_l353_156;
  wire                when_StochasticConvCore_l353_157;
  wire                when_StochasticConvCore_l353_158;
  wire                when_StochasticConvCore_l353_159;
  wire                when_StochasticConvCore_l353_160;
  wire                when_StochasticConvCore_l353_161;
  wire                when_StochasticConvCore_l353_162;
  wire                when_StochasticConvCore_l353_163;
  wire                when_StochasticConvCore_l353_164;
  wire                when_StochasticConvCore_l353_165;
  wire                when_StochasticConvCore_l353_166;
  wire                when_StochasticConvCore_l353_167;
  wire                when_StochasticConvCore_l353_168;
  wire                when_StochasticConvCore_l353_169;
  wire                when_StochasticConvCore_l353_170;
  wire                when_StochasticConvCore_l353_171;
  wire                when_StochasticConvCore_l353_172;
  wire                when_StochasticConvCore_l353_173;
  wire                when_StochasticConvCore_l353_174;
  wire                when_StochasticConvCore_l353_175;
  wire                when_StochasticConvCore_l353_176;
  wire                when_StochasticConvCore_l353_177;
  wire                when_StochasticConvCore_l353_178;
  wire                when_StochasticConvCore_l353_179;
  wire                when_StochasticConvCore_l353_180;
  wire                when_StochasticConvCore_l353_181;
  wire                when_StochasticConvCore_l353_182;
  wire                when_StochasticConvCore_l353_183;
  wire                when_StochasticConvCore_l353_184;
  wire                when_StochasticConvCore_l353_185;
  wire                when_StochasticConvCore_l353_186;
  wire                when_StochasticConvCore_l353_187;
  wire                when_StochasticConvCore_l353_188;
  wire                when_StochasticConvCore_l353_189;
  wire                when_StochasticConvCore_l353_190;
  wire                when_StochasticConvCore_l353_191;
  wire                when_StochasticConvCore_l353_192;
  wire                when_StochasticConvCore_l353_193;
  wire                when_StochasticConvCore_l353_194;
  wire                when_StochasticConvCore_l353_195;
  wire                when_StochasticConvCore_l353_196;
  wire                when_StochasticConvCore_l353_197;
  wire                when_StochasticConvCore_l353_198;
  wire                when_StochasticConvCore_l353_199;
  wire                when_StochasticConvCore_l353_200;
  wire                when_StochasticConvCore_l353_201;
  wire                when_StochasticConvCore_l353_202;
  wire                when_StochasticConvCore_l353_203;
  wire                when_StochasticConvCore_l353_204;
  wire                when_StochasticConvCore_l353_205;
  wire                when_StochasticConvCore_l353_206;
  wire                when_StochasticConvCore_l353_207;
  wire                when_StochasticConvCore_l353_208;
  wire                when_StochasticConvCore_l353_209;
  wire                when_StochasticConvCore_l353_210;
  wire                when_StochasticConvCore_l353_211;
  wire                when_StochasticConvCore_l353_212;
  wire                when_StochasticConvCore_l353_213;
  wire                when_StochasticConvCore_l353_214;
  wire                when_StochasticConvCore_l353_215;
  wire                when_StochasticConvCore_l353_216;
  wire                when_StochasticConvCore_l353_217;
  wire                when_StochasticConvCore_l353_218;
  wire                when_StochasticConvCore_l353_219;
  wire                when_StochasticConvCore_l353_220;
  wire                when_StochasticConvCore_l353_221;
  wire                when_StochasticConvCore_l353_222;
  wire                when_StochasticConvCore_l353_223;
  wire                when_StochasticConvCore_l353_224;
  wire                when_StochasticConvCore_l361_1;
  wire                when_StochasticConvCore_l373_1;
  wire                when_StochasticConvCore_l376_1;
  wire                when_StochasticConvCore_l387_1;
  wire       [29:0]   _zz_conv2_activationOut_payload_value;
  wire                conv2_activationOut_fire;
  wire                when_StochasticConvCore_l408_1;
  wire                when_StochasticConvCore_l410_1;
  wire                _zz_conv2_state;
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
  reg [7:0] conv1_actBuf [0:1023];
  reg [7:0] conv1_wThrRom [0:199];
  reg [0:0] conv1_wSignRom [0:199];
  reg [31:0] conv1_combAdjRom [0:7];
  reg [7:0] pool1_rowBuf_0 [0:223];
  reg [7:0] pool1_rowBuf_1 [0:223];
  reg [7:0] conv2_actBuf [0:2591];
  reg [7:0] conv2_wThrRom [0:3199];
  reg [0:0] conv2_wSignRom [0:3199];
  reg [31:0] conv2_combAdjRom [0:15];
  reg [7:0] pool2_rowBuf_0 [0:223];
  reg [7:0] pool2_rowBuf_1 [0:223];
  reg [7:0] pool2_rowBuf_2 [0:223];
  reg [7:0] linear1_inputBuf [0:255];
  reg [7:0] linear1_weightRom [0:2559];
  reg [31:0] linear1_biasRom [0:9];

  assign _zz_conv1_posCount_9 = (_zz_conv1_posCount_10 + _zz_conv1_posCount_33);
  assign _zz_conv1_posCount_8 = {1'd0, _zz_conv1_posCount_9};
  assign _zz_conv1_posCount_10 = (_zz_conv1_posCount_11 + _zz_conv1_posCount_22);
  assign _zz_conv1_posCount_11 = (_zz_conv1_posCount_12 + _zz_conv1_posCount_17);
  assign _zz_conv1_posCount_12 = (_zz_conv1_posCount_13 + _zz_conv1_posCount_15);
  assign _zz_conv1_posCount_17 = (_zz_conv1_posCount_18 + _zz_conv1_posCount_20);
  assign _zz_conv1_posCount_22 = (_zz_conv1_posCount_23 + _zz_conv1_posCount_28);
  assign _zz_conv1_posCount_23 = (_zz_conv1_posCount_24 + _zz_conv1_posCount_26);
  assign _zz_conv1_posCount_28 = (_zz_conv1_posCount_29 + _zz_conv1_posCount_31);
  assign _zz_conv1_posCount_35 = conv1_posBitRegs_24;
  assign _zz_conv1_posCount_34 = {2'd0, _zz_conv1_posCount_35};
  assign _zz_conv1_negCount_9 = (_zz_conv1_negCount_10 + _zz_conv1_negCount_33);
  assign _zz_conv1_negCount_8 = {1'd0, _zz_conv1_negCount_9};
  assign _zz_conv1_negCount_10 = (_zz_conv1_negCount_11 + _zz_conv1_negCount_22);
  assign _zz_conv1_negCount_11 = (_zz_conv1_negCount_12 + _zz_conv1_negCount_17);
  assign _zz_conv1_negCount_12 = (_zz_conv1_negCount_13 + _zz_conv1_negCount_15);
  assign _zz_conv1_negCount_17 = (_zz_conv1_negCount_18 + _zz_conv1_negCount_20);
  assign _zz_conv1_negCount_22 = (_zz_conv1_negCount_23 + _zz_conv1_negCount_28);
  assign _zz_conv1_negCount_23 = (_zz_conv1_negCount_24 + _zz_conv1_negCount_26);
  assign _zz_conv1_negCount_28 = (_zz_conv1_negCount_29 + _zz_conv1_negCount_31);
  assign _zz_conv1_negCount_35 = conv1_negBitRegs_24;
  assign _zz_conv1_negCount_34 = {2'd0, _zz_conv1_negCount_35};
  assign _zz_conv1_rxRow = (conv1_rxRow + 5'h01);
  assign _zz_conv1_actBuf_port_1 = conv1_initAddr[9:0];
  assign _zz_conv1_actBuf_port_2 = conv1_rxAddr[9:0];
  assign _zz_conv1_actBuf_port_4 = ((conv1_state == conv1_sInit) ? 8'h0 : activation_in_data);
  assign _zz_conv1_pixelBase = (conv1_outHReg * 6'h20);
  assign _zz_conv1_pixelBase_2 = (conv1_outWReg * 1'b1);
  assign _zz_conv1_pixelBase_1 = {5'd0, _zz_conv1_pixelBase_2};
  assign _zz_conv1_actBufRead = conv1_actReadAddr[9:0];
  assign _zz__zz_conv1_wThrRead = {3'd0, conv1_loadStep};
  assign _zz__zz_conv1_wSignRead = {3'd0, conv1_loadStep};
  assign _zz_conv1_combAdjRead_2 = _zz_conv1_combAdjRead[2:0];
  assign _zz_conv1_scAcc_1 = ($signed(conv1_posCount) - $signed(conv1_negCount));
  assign _zz_conv1_scAcc = {{9{_zz_conv1_scAcc_1[5]}}, _zz_conv1_scAcc_1};
  assign _zz__zz_conv1_activationOut_payload_value = (_zz__zz_conv1_activationOut_payload_value_1 >>> 5'd22);
  assign _zz__zz_conv1_activationOut_payload_value_1 = ($signed(_zz__zz_conv1_activationOut_payload_value_2) * $signed(32'h00105e1c));
  assign _zz__zz_conv1_activationOut_payload_value_3 = ($signed(_zz__zz_conv1_activationOut_payload_value_4) + $signed(conv1_combAdjReg));
  assign _zz__zz_conv1_activationOut_payload_value_2 = _zz__zz_conv1_activationOut_payload_value_3[16:0];
  assign _zz__zz_conv1_activationOut_payload_value_4 = {{17{conv1_scAcc[14]}}, conv1_scAcc};
  assign _zz_conv1_activationOut_payload_value_1 = (($signed(_zz_conv1_activationOut_payload_value) < $signed(27'h7ffff80)) ? 8'h80 : _zz_conv1_activationOut_payload_value_2);
  assign _zz_conv1_activationOut_payload_value_2 = _zz_conv1_activationOut_payload_value[7:0];
  assign _zz_conv1_ocReg = (conv1_ocReg + 4'b0001);
  assign _zz_conv1_wAddrBase = (conv1_wAddrBase + 8'h19);
  assign _zz_conv1_outWReg = (conv1_outWReg + 5'h01);
  assign _zz_conv1_outHReg = (conv1_outHReg + 5'h01);
  assign _zz_relu1_activationOut_payload_value = (($signed(8'h7f) < $signed(StochasticConvPlugin_logic_outStream_payload_value)) ? 8'h7f : StochasticConvPlugin_logic_outStream_payload_value);
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
  assign _zz_conv2_posCount_9 = (_zz_conv2_posCount_10 + _zz_conv2_posCount_201);
  assign _zz_conv2_posCount_8 = {1'd0, _zz_conv2_posCount_9};
  assign _zz_conv2_posCount_10 = (_zz_conv2_posCount_11 + _zz_conv2_posCount_106);
  assign _zz_conv2_posCount_11 = (_zz_conv2_posCount_12 + _zz_conv2_posCount_59);
  assign _zz_conv2_posCount_12 = (_zz_conv2_posCount_13 + _zz_conv2_posCount_36);
  assign _zz_conv2_posCount_13 = (_zz_conv2_posCount_14 + _zz_conv2_posCount_25);
  assign _zz_conv2_posCount_14 = (_zz_conv2_posCount_15 + _zz_conv2_posCount_20);
  assign _zz_conv2_posCount_15 = (_zz_conv2_posCount_16 + _zz_conv2_posCount_18);
  assign _zz_conv2_posCount_20 = (_zz_conv2_posCount_21 + _zz_conv2_posCount_23);
  assign _zz_conv2_posCount_25 = (_zz_conv2_posCount_26 + _zz_conv2_posCount_31);
  assign _zz_conv2_posCount_26 = (_zz_conv2_posCount_27 + _zz_conv2_posCount_29);
  assign _zz_conv2_posCount_31 = (_zz_conv2_posCount_32 + _zz_conv2_posCount_34);
  assign _zz_conv2_posCount_36 = (_zz_conv2_posCount_37 + _zz_conv2_posCount_48);
  assign _zz_conv2_posCount_37 = (_zz_conv2_posCount_38 + _zz_conv2_posCount_43);
  assign _zz_conv2_posCount_38 = (_zz_conv2_posCount_39 + _zz_conv2_posCount_41);
  assign _zz_conv2_posCount_43 = (_zz_conv2_posCount_44 + _zz_conv2_posCount_46);
  assign _zz_conv2_posCount_48 = (_zz_conv2_posCount_49 + _zz_conv2_posCount_54);
  assign _zz_conv2_posCount_49 = (_zz_conv2_posCount_50 + _zz_conv2_posCount_52);
  assign _zz_conv2_posCount_54 = (_zz_conv2_posCount_55 + _zz_conv2_posCount_57);
  assign _zz_conv2_posCount_59 = (_zz_conv2_posCount_60 + _zz_conv2_posCount_83);
  assign _zz_conv2_posCount_60 = (_zz_conv2_posCount_61 + _zz_conv2_posCount_72);
  assign _zz_conv2_posCount_61 = (_zz_conv2_posCount_62 + _zz_conv2_posCount_67);
  assign _zz_conv2_posCount_62 = (_zz_conv2_posCount_63 + _zz_conv2_posCount_65);
  assign _zz_conv2_posCount_67 = (_zz_conv2_posCount_68 + _zz_conv2_posCount_70);
  assign _zz_conv2_posCount_72 = (_zz_conv2_posCount_73 + _zz_conv2_posCount_78);
  assign _zz_conv2_posCount_73 = (_zz_conv2_posCount_74 + _zz_conv2_posCount_76);
  assign _zz_conv2_posCount_78 = (_zz_conv2_posCount_79 + _zz_conv2_posCount_81);
  assign _zz_conv2_posCount_83 = (_zz_conv2_posCount_84 + _zz_conv2_posCount_95);
  assign _zz_conv2_posCount_84 = (_zz_conv2_posCount_85 + _zz_conv2_posCount_90);
  assign _zz_conv2_posCount_85 = (_zz_conv2_posCount_86 + _zz_conv2_posCount_88);
  assign _zz_conv2_posCount_90 = (_zz_conv2_posCount_91 + _zz_conv2_posCount_93);
  assign _zz_conv2_posCount_95 = (_zz_conv2_posCount_96 + _zz_conv2_posCount_101);
  assign _zz_conv2_posCount_96 = (_zz_conv2_posCount_97 + _zz_conv2_posCount_99);
  assign _zz_conv2_posCount_101 = (_zz_conv2_posCount_102 + _zz_conv2_posCount_104);
  assign _zz_conv2_posCount_106 = (_zz_conv2_posCount_107 + _zz_conv2_posCount_154);
  assign _zz_conv2_posCount_107 = (_zz_conv2_posCount_108 + _zz_conv2_posCount_131);
  assign _zz_conv2_posCount_108 = (_zz_conv2_posCount_109 + _zz_conv2_posCount_120);
  assign _zz_conv2_posCount_109 = (_zz_conv2_posCount_110 + _zz_conv2_posCount_115);
  assign _zz_conv2_posCount_110 = (_zz_conv2_posCount_111 + _zz_conv2_posCount_113);
  assign _zz_conv2_posCount_115 = (_zz_conv2_posCount_116 + _zz_conv2_posCount_118);
  assign _zz_conv2_posCount_120 = (_zz_conv2_posCount_121 + _zz_conv2_posCount_126);
  assign _zz_conv2_posCount_121 = (_zz_conv2_posCount_122 + _zz_conv2_posCount_124);
  assign _zz_conv2_posCount_126 = (_zz_conv2_posCount_127 + _zz_conv2_posCount_129);
  assign _zz_conv2_posCount_131 = (_zz_conv2_posCount_132 + _zz_conv2_posCount_143);
  assign _zz_conv2_posCount_132 = (_zz_conv2_posCount_133 + _zz_conv2_posCount_138);
  assign _zz_conv2_posCount_133 = (_zz_conv2_posCount_134 + _zz_conv2_posCount_136);
  assign _zz_conv2_posCount_138 = (_zz_conv2_posCount_139 + _zz_conv2_posCount_141);
  assign _zz_conv2_posCount_143 = (_zz_conv2_posCount_144 + _zz_conv2_posCount_149);
  assign _zz_conv2_posCount_144 = (_zz_conv2_posCount_145 + _zz_conv2_posCount_147);
  assign _zz_conv2_posCount_149 = (_zz_conv2_posCount_150 + _zz_conv2_posCount_152);
  assign _zz_conv2_posCount_154 = (_zz_conv2_posCount_155 + _zz_conv2_posCount_178);
  assign _zz_conv2_posCount_155 = (_zz_conv2_posCount_156 + _zz_conv2_posCount_167);
  assign _zz_conv2_posCount_156 = (_zz_conv2_posCount_157 + _zz_conv2_posCount_162);
  assign _zz_conv2_posCount_157 = (_zz_conv2_posCount_158 + _zz_conv2_posCount_160);
  assign _zz_conv2_posCount_162 = (_zz_conv2_posCount_163 + _zz_conv2_posCount_165);
  assign _zz_conv2_posCount_167 = (_zz_conv2_posCount_168 + _zz_conv2_posCount_173);
  assign _zz_conv2_posCount_168 = (_zz_conv2_posCount_169 + _zz_conv2_posCount_171);
  assign _zz_conv2_posCount_173 = (_zz_conv2_posCount_174 + _zz_conv2_posCount_176);
  assign _zz_conv2_posCount_178 = (_zz_conv2_posCount_179 + _zz_conv2_posCount_190);
  assign _zz_conv2_posCount_179 = (_zz_conv2_posCount_180 + _zz_conv2_posCount_185);
  assign _zz_conv2_posCount_180 = (_zz_conv2_posCount_181 + _zz_conv2_posCount_183);
  assign _zz_conv2_posCount_185 = (_zz_conv2_posCount_186 + _zz_conv2_posCount_188);
  assign _zz_conv2_posCount_190 = (_zz_conv2_posCount_191 + _zz_conv2_posCount_196);
  assign _zz_conv2_posCount_191 = (_zz_conv2_posCount_192 + _zz_conv2_posCount_194);
  assign _zz_conv2_posCount_196 = (_zz_conv2_posCount_197 + _zz_conv2_posCount_199);
  assign _zz_conv2_posCount_201 = (_zz_conv2_posCount_202 + _zz_conv2_posCount_207);
  assign _zz_conv2_posCount_202 = (_zz_conv2_posCount_203 + _zz_conv2_posCount_205);
  assign _zz_conv2_posCount_209 = {conv2_posBitRegs_199,conv2_posBitRegs_198};
  assign _zz_conv2_posCount_208 = {1'd0, _zz_conv2_posCount_209};
  assign _zz_conv2_negCount_9 = (_zz_conv2_negCount_10 + _zz_conv2_negCount_201);
  assign _zz_conv2_negCount_8 = {1'd0, _zz_conv2_negCount_9};
  assign _zz_conv2_negCount_10 = (_zz_conv2_negCount_11 + _zz_conv2_negCount_106);
  assign _zz_conv2_negCount_11 = (_zz_conv2_negCount_12 + _zz_conv2_negCount_59);
  assign _zz_conv2_negCount_12 = (_zz_conv2_negCount_13 + _zz_conv2_negCount_36);
  assign _zz_conv2_negCount_13 = (_zz_conv2_negCount_14 + _zz_conv2_negCount_25);
  assign _zz_conv2_negCount_14 = (_zz_conv2_negCount_15 + _zz_conv2_negCount_20);
  assign _zz_conv2_negCount_15 = (_zz_conv2_negCount_16 + _zz_conv2_negCount_18);
  assign _zz_conv2_negCount_20 = (_zz_conv2_negCount_21 + _zz_conv2_negCount_23);
  assign _zz_conv2_negCount_25 = (_zz_conv2_negCount_26 + _zz_conv2_negCount_31);
  assign _zz_conv2_negCount_26 = (_zz_conv2_negCount_27 + _zz_conv2_negCount_29);
  assign _zz_conv2_negCount_31 = (_zz_conv2_negCount_32 + _zz_conv2_negCount_34);
  assign _zz_conv2_negCount_36 = (_zz_conv2_negCount_37 + _zz_conv2_negCount_48);
  assign _zz_conv2_negCount_37 = (_zz_conv2_negCount_38 + _zz_conv2_negCount_43);
  assign _zz_conv2_negCount_38 = (_zz_conv2_negCount_39 + _zz_conv2_negCount_41);
  assign _zz_conv2_negCount_43 = (_zz_conv2_negCount_44 + _zz_conv2_negCount_46);
  assign _zz_conv2_negCount_48 = (_zz_conv2_negCount_49 + _zz_conv2_negCount_54);
  assign _zz_conv2_negCount_49 = (_zz_conv2_negCount_50 + _zz_conv2_negCount_52);
  assign _zz_conv2_negCount_54 = (_zz_conv2_negCount_55 + _zz_conv2_negCount_57);
  assign _zz_conv2_negCount_59 = (_zz_conv2_negCount_60 + _zz_conv2_negCount_83);
  assign _zz_conv2_negCount_60 = (_zz_conv2_negCount_61 + _zz_conv2_negCount_72);
  assign _zz_conv2_negCount_61 = (_zz_conv2_negCount_62 + _zz_conv2_negCount_67);
  assign _zz_conv2_negCount_62 = (_zz_conv2_negCount_63 + _zz_conv2_negCount_65);
  assign _zz_conv2_negCount_67 = (_zz_conv2_negCount_68 + _zz_conv2_negCount_70);
  assign _zz_conv2_negCount_72 = (_zz_conv2_negCount_73 + _zz_conv2_negCount_78);
  assign _zz_conv2_negCount_73 = (_zz_conv2_negCount_74 + _zz_conv2_negCount_76);
  assign _zz_conv2_negCount_78 = (_zz_conv2_negCount_79 + _zz_conv2_negCount_81);
  assign _zz_conv2_negCount_83 = (_zz_conv2_negCount_84 + _zz_conv2_negCount_95);
  assign _zz_conv2_negCount_84 = (_zz_conv2_negCount_85 + _zz_conv2_negCount_90);
  assign _zz_conv2_negCount_85 = (_zz_conv2_negCount_86 + _zz_conv2_negCount_88);
  assign _zz_conv2_negCount_90 = (_zz_conv2_negCount_91 + _zz_conv2_negCount_93);
  assign _zz_conv2_negCount_95 = (_zz_conv2_negCount_96 + _zz_conv2_negCount_101);
  assign _zz_conv2_negCount_96 = (_zz_conv2_negCount_97 + _zz_conv2_negCount_99);
  assign _zz_conv2_negCount_101 = (_zz_conv2_negCount_102 + _zz_conv2_negCount_104);
  assign _zz_conv2_negCount_106 = (_zz_conv2_negCount_107 + _zz_conv2_negCount_154);
  assign _zz_conv2_negCount_107 = (_zz_conv2_negCount_108 + _zz_conv2_negCount_131);
  assign _zz_conv2_negCount_108 = (_zz_conv2_negCount_109 + _zz_conv2_negCount_120);
  assign _zz_conv2_negCount_109 = (_zz_conv2_negCount_110 + _zz_conv2_negCount_115);
  assign _zz_conv2_negCount_110 = (_zz_conv2_negCount_111 + _zz_conv2_negCount_113);
  assign _zz_conv2_negCount_115 = (_zz_conv2_negCount_116 + _zz_conv2_negCount_118);
  assign _zz_conv2_negCount_120 = (_zz_conv2_negCount_121 + _zz_conv2_negCount_126);
  assign _zz_conv2_negCount_121 = (_zz_conv2_negCount_122 + _zz_conv2_negCount_124);
  assign _zz_conv2_negCount_126 = (_zz_conv2_negCount_127 + _zz_conv2_negCount_129);
  assign _zz_conv2_negCount_131 = (_zz_conv2_negCount_132 + _zz_conv2_negCount_143);
  assign _zz_conv2_negCount_132 = (_zz_conv2_negCount_133 + _zz_conv2_negCount_138);
  assign _zz_conv2_negCount_133 = (_zz_conv2_negCount_134 + _zz_conv2_negCount_136);
  assign _zz_conv2_negCount_138 = (_zz_conv2_negCount_139 + _zz_conv2_negCount_141);
  assign _zz_conv2_negCount_143 = (_zz_conv2_negCount_144 + _zz_conv2_negCount_149);
  assign _zz_conv2_negCount_144 = (_zz_conv2_negCount_145 + _zz_conv2_negCount_147);
  assign _zz_conv2_negCount_149 = (_zz_conv2_negCount_150 + _zz_conv2_negCount_152);
  assign _zz_conv2_negCount_154 = (_zz_conv2_negCount_155 + _zz_conv2_negCount_178);
  assign _zz_conv2_negCount_155 = (_zz_conv2_negCount_156 + _zz_conv2_negCount_167);
  assign _zz_conv2_negCount_156 = (_zz_conv2_negCount_157 + _zz_conv2_negCount_162);
  assign _zz_conv2_negCount_157 = (_zz_conv2_negCount_158 + _zz_conv2_negCount_160);
  assign _zz_conv2_negCount_162 = (_zz_conv2_negCount_163 + _zz_conv2_negCount_165);
  assign _zz_conv2_negCount_167 = (_zz_conv2_negCount_168 + _zz_conv2_negCount_173);
  assign _zz_conv2_negCount_168 = (_zz_conv2_negCount_169 + _zz_conv2_negCount_171);
  assign _zz_conv2_negCount_173 = (_zz_conv2_negCount_174 + _zz_conv2_negCount_176);
  assign _zz_conv2_negCount_178 = (_zz_conv2_negCount_179 + _zz_conv2_negCount_190);
  assign _zz_conv2_negCount_179 = (_zz_conv2_negCount_180 + _zz_conv2_negCount_185);
  assign _zz_conv2_negCount_180 = (_zz_conv2_negCount_181 + _zz_conv2_negCount_183);
  assign _zz_conv2_negCount_185 = (_zz_conv2_negCount_186 + _zz_conv2_negCount_188);
  assign _zz_conv2_negCount_190 = (_zz_conv2_negCount_191 + _zz_conv2_negCount_196);
  assign _zz_conv2_negCount_191 = (_zz_conv2_negCount_192 + _zz_conv2_negCount_194);
  assign _zz_conv2_negCount_196 = (_zz_conv2_negCount_197 + _zz_conv2_negCount_199);
  assign _zz_conv2_negCount_201 = (_zz_conv2_negCount_202 + _zz_conv2_negCount_207);
  assign _zz_conv2_negCount_202 = (_zz_conv2_negCount_203 + _zz_conv2_negCount_205);
  assign _zz_conv2_negCount_209 = {conv2_negBitRegs_199,conv2_negBitRegs_198};
  assign _zz_conv2_negCount_208 = {1'd0, _zz_conv2_negCount_209};
  assign _zz_conv2_rxRow = (conv2_rxRow + 7'h01);
  assign _zz_conv2_actBuf_port_2 = ((conv2_state == conv2_sInit) ? 8'h0 : MaxPoolLinePlugin_logic_outStream_payload_value);
  assign _zz_conv2_pixelBase = (conv2_outHReg * 8'h90);
  assign _zz_conv2_pixelBase_2 = (conv2_outWReg * 4'b1000);
  assign _zz_conv2_pixelBase_1 = {4'd0, _zz_conv2_pixelBase_2};
  assign _zz__zz_conv2_wThrRead = {4'd0, conv2_loadStep};
  assign _zz__zz_conv2_wSignRead = {4'd0, conv2_loadStep};
  assign _zz_conv2_combAdjRead_2 = _zz_conv2_combAdjRead[3:0];
  assign _zz_conv2_scAcc_1 = ($signed(conv2_posCount) - $signed(conv2_negCount));
  assign _zz_conv2_scAcc = {{9{_zz_conv2_scAcc_1[8]}}, _zz_conv2_scAcc_1};
  assign _zz__zz_conv2_activationOut_payload_value = (_zz__zz_conv2_activationOut_payload_value_1 >>> 5'd22);
  assign _zz__zz_conv2_activationOut_payload_value_1 = ($signed(_zz__zz_conv2_activationOut_payload_value_2) * $signed(32'h00122469));
  assign _zz__zz_conv2_activationOut_payload_value_3 = ($signed(_zz__zz_conv2_activationOut_payload_value_4) + $signed(conv2_combAdjReg));
  assign _zz__zz_conv2_activationOut_payload_value_2 = _zz__zz_conv2_activationOut_payload_value_3[19:0];
  assign _zz__zz_conv2_activationOut_payload_value_4 = {{14{conv2_scAcc[17]}}, conv2_scAcc};
  assign _zz_conv2_activationOut_payload_value_1 = (($signed(_zz_conv2_activationOut_payload_value) < $signed(30'h3fffff80)) ? 8'h80 : _zz_conv2_activationOut_payload_value_2);
  assign _zz_conv2_activationOut_payload_value_2 = _zz_conv2_activationOut_payload_value[7:0];
  assign _zz_conv2_ocReg = (conv2_ocReg + 5'h01);
  assign _zz_conv2_wAddrBase = (conv2_wAddrBase + 12'h0c8);
  assign _zz_conv2_outWReg = (conv2_outWReg + 4'b0001);
  assign _zz_conv2_outHReg = (conv2_outHReg + 4'b0001);
  assign _zz_relu2_activationOut_payload_value = (($signed(8'h7f) < $signed(StochasticConvPlugin_logic_outStream_payload_value_1)) ? 8'h7f : StochasticConvPlugin_logic_outStream_payload_value_1);
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
  assign _zz_conv1_actBuf_port = ((conv1_state == conv1_sInit) ? _zz_conv1_actBuf_port_1 : _zz_conv1_actBuf_port_2);
  assign _zz_conv1_actBuf_port_3 = _zz_conv1_actBuf_port_4;
  assign _zz_pool1_rowReads_0_1 = 1'b1;
  assign _zz_pool1_rowBuf_0_port_1 = ReLUPlugin_logic_outStream_payload_value;
  assign _zz_pool1_rowBuf_0_port_2 = ((((pool1_stateReg == pool1_sReceiveRow) && (pool1_rowWrPtrReg == 1'b0)) && ReLUPlugin_logic_outStream_fire) && (! 1'b0));
  assign _zz_pool1_rowReads_1_1 = 1'b1;
  assign _zz_pool1_rowBuf_1_port_1 = ReLUPlugin_logic_outStream_payload_value;
  assign _zz_pool1_rowBuf_1_port_2 = ((((pool1_stateReg == pool1_sReceiveRow) && (pool1_rowWrPtrReg == 1'b1)) && ReLUPlugin_logic_outStream_fire) && (! 1'b0));
  assign _zz_conv2_actBuf_port = ((conv2_state == conv2_sInit) ? conv2_initAddr : conv2_rxAddr);
  assign _zz_conv2_actBuf_port_1 = _zz_conv2_actBuf_port_2;
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
  assign _zz_conv1_posCount_14 = {conv1_posBitRegs_2,{conv1_posBitRegs_1,conv1_posBitRegs_0}};
  assign _zz_conv1_posCount_16 = {conv1_posBitRegs_5,{conv1_posBitRegs_4,conv1_posBitRegs_3}};
  assign _zz_conv1_posCount_19 = {conv1_posBitRegs_8,{conv1_posBitRegs_7,conv1_posBitRegs_6}};
  assign _zz_conv1_posCount_21 = {conv1_posBitRegs_11,{conv1_posBitRegs_10,conv1_posBitRegs_9}};
  assign _zz_conv1_posCount_25 = {conv1_posBitRegs_14,{conv1_posBitRegs_13,conv1_posBitRegs_12}};
  assign _zz_conv1_posCount_27 = {conv1_posBitRegs_17,{conv1_posBitRegs_16,conv1_posBitRegs_15}};
  assign _zz_conv1_posCount_30 = {conv1_posBitRegs_20,{conv1_posBitRegs_19,conv1_posBitRegs_18}};
  assign _zz_conv1_posCount_32 = {conv1_posBitRegs_23,{conv1_posBitRegs_22,conv1_posBitRegs_21}};
  assign _zz_conv1_negCount_14 = {conv1_negBitRegs_2,{conv1_negBitRegs_1,conv1_negBitRegs_0}};
  assign _zz_conv1_negCount_16 = {conv1_negBitRegs_5,{conv1_negBitRegs_4,conv1_negBitRegs_3}};
  assign _zz_conv1_negCount_19 = {conv1_negBitRegs_8,{conv1_negBitRegs_7,conv1_negBitRegs_6}};
  assign _zz_conv1_negCount_21 = {conv1_negBitRegs_11,{conv1_negBitRegs_10,conv1_negBitRegs_9}};
  assign _zz_conv1_negCount_25 = {conv1_negBitRegs_14,{conv1_negBitRegs_13,conv1_negBitRegs_12}};
  assign _zz_conv1_negCount_27 = {conv1_negBitRegs_17,{conv1_negBitRegs_16,conv1_negBitRegs_15}};
  assign _zz_conv1_negCount_30 = {conv1_negBitRegs_20,{conv1_negBitRegs_19,conv1_negBitRegs_18}};
  assign _zz_conv1_negCount_32 = {conv1_negBitRegs_23,{conv1_negBitRegs_22,conv1_negBitRegs_21}};
  assign _zz_conv2_posCount_17 = {conv2_posBitRegs_2,{conv2_posBitRegs_1,conv2_posBitRegs_0}};
  assign _zz_conv2_posCount_19 = {conv2_posBitRegs_5,{conv2_posBitRegs_4,conv2_posBitRegs_3}};
  assign _zz_conv2_posCount_22 = {conv2_posBitRegs_8,{conv2_posBitRegs_7,conv2_posBitRegs_6}};
  assign _zz_conv2_posCount_24 = {conv2_posBitRegs_11,{conv2_posBitRegs_10,conv2_posBitRegs_9}};
  assign _zz_conv2_posCount_28 = {conv2_posBitRegs_14,{conv2_posBitRegs_13,conv2_posBitRegs_12}};
  assign _zz_conv2_posCount_30 = {conv2_posBitRegs_17,{conv2_posBitRegs_16,conv2_posBitRegs_15}};
  assign _zz_conv2_posCount_33 = {conv2_posBitRegs_20,{conv2_posBitRegs_19,conv2_posBitRegs_18}};
  assign _zz_conv2_posCount_35 = {conv2_posBitRegs_23,{conv2_posBitRegs_22,conv2_posBitRegs_21}};
  assign _zz_conv2_posCount_40 = {conv2_posBitRegs_26,{conv2_posBitRegs_25,conv2_posBitRegs_24}};
  assign _zz_conv2_posCount_42 = {conv2_posBitRegs_29,{conv2_posBitRegs_28,conv2_posBitRegs_27}};
  assign _zz_conv2_posCount_45 = {conv2_posBitRegs_32,{conv2_posBitRegs_31,conv2_posBitRegs_30}};
  assign _zz_conv2_posCount_47 = {conv2_posBitRegs_35,{conv2_posBitRegs_34,conv2_posBitRegs_33}};
  assign _zz_conv2_posCount_51 = {conv2_posBitRegs_38,{conv2_posBitRegs_37,conv2_posBitRegs_36}};
  assign _zz_conv2_posCount_53 = {conv2_posBitRegs_41,{conv2_posBitRegs_40,conv2_posBitRegs_39}};
  assign _zz_conv2_posCount_56 = {conv2_posBitRegs_44,{conv2_posBitRegs_43,conv2_posBitRegs_42}};
  assign _zz_conv2_posCount_58 = {conv2_posBitRegs_47,{conv2_posBitRegs_46,conv2_posBitRegs_45}};
  assign _zz_conv2_posCount_64 = {conv2_posBitRegs_50,{conv2_posBitRegs_49,conv2_posBitRegs_48}};
  assign _zz_conv2_posCount_66 = {conv2_posBitRegs_53,{conv2_posBitRegs_52,conv2_posBitRegs_51}};
  assign _zz_conv2_posCount_69 = {conv2_posBitRegs_56,{conv2_posBitRegs_55,conv2_posBitRegs_54}};
  assign _zz_conv2_posCount_71 = {conv2_posBitRegs_59,{conv2_posBitRegs_58,conv2_posBitRegs_57}};
  assign _zz_conv2_posCount_75 = {conv2_posBitRegs_62,{conv2_posBitRegs_61,conv2_posBitRegs_60}};
  assign _zz_conv2_posCount_77 = {conv2_posBitRegs_65,{conv2_posBitRegs_64,conv2_posBitRegs_63}};
  assign _zz_conv2_posCount_80 = {conv2_posBitRegs_68,{conv2_posBitRegs_67,conv2_posBitRegs_66}};
  assign _zz_conv2_posCount_82 = {conv2_posBitRegs_71,{conv2_posBitRegs_70,conv2_posBitRegs_69}};
  assign _zz_conv2_posCount_87 = {conv2_posBitRegs_74,{conv2_posBitRegs_73,conv2_posBitRegs_72}};
  assign _zz_conv2_posCount_89 = {conv2_posBitRegs_77,{conv2_posBitRegs_76,conv2_posBitRegs_75}};
  assign _zz_conv2_posCount_92 = {conv2_posBitRegs_80,{conv2_posBitRegs_79,conv2_posBitRegs_78}};
  assign _zz_conv2_posCount_94 = {conv2_posBitRegs_83,{conv2_posBitRegs_82,conv2_posBitRegs_81}};
  assign _zz_conv2_posCount_98 = {conv2_posBitRegs_86,{conv2_posBitRegs_85,conv2_posBitRegs_84}};
  assign _zz_conv2_posCount_100 = {conv2_posBitRegs_89,{conv2_posBitRegs_88,conv2_posBitRegs_87}};
  assign _zz_conv2_posCount_103 = {conv2_posBitRegs_92,{conv2_posBitRegs_91,conv2_posBitRegs_90}};
  assign _zz_conv2_posCount_105 = {conv2_posBitRegs_95,{conv2_posBitRegs_94,conv2_posBitRegs_93}};
  assign _zz_conv2_posCount_112 = {conv2_posBitRegs_98,{conv2_posBitRegs_97,conv2_posBitRegs_96}};
  assign _zz_conv2_posCount_114 = {conv2_posBitRegs_101,{conv2_posBitRegs_100,conv2_posBitRegs_99}};
  assign _zz_conv2_posCount_117 = {conv2_posBitRegs_104,{conv2_posBitRegs_103,conv2_posBitRegs_102}};
  assign _zz_conv2_posCount_119 = {conv2_posBitRegs_107,{conv2_posBitRegs_106,conv2_posBitRegs_105}};
  assign _zz_conv2_posCount_123 = {conv2_posBitRegs_110,{conv2_posBitRegs_109,conv2_posBitRegs_108}};
  assign _zz_conv2_posCount_125 = {conv2_posBitRegs_113,{conv2_posBitRegs_112,conv2_posBitRegs_111}};
  assign _zz_conv2_posCount_128 = {conv2_posBitRegs_116,{conv2_posBitRegs_115,conv2_posBitRegs_114}};
  assign _zz_conv2_posCount_130 = {conv2_posBitRegs_119,{conv2_posBitRegs_118,conv2_posBitRegs_117}};
  assign _zz_conv2_posCount_135 = {conv2_posBitRegs_122,{conv2_posBitRegs_121,conv2_posBitRegs_120}};
  assign _zz_conv2_posCount_137 = {conv2_posBitRegs_125,{conv2_posBitRegs_124,conv2_posBitRegs_123}};
  assign _zz_conv2_posCount_140 = {conv2_posBitRegs_128,{conv2_posBitRegs_127,conv2_posBitRegs_126}};
  assign _zz_conv2_posCount_142 = {conv2_posBitRegs_131,{conv2_posBitRegs_130,conv2_posBitRegs_129}};
  assign _zz_conv2_posCount_146 = {conv2_posBitRegs_134,{conv2_posBitRegs_133,conv2_posBitRegs_132}};
  assign _zz_conv2_posCount_148 = {conv2_posBitRegs_137,{conv2_posBitRegs_136,conv2_posBitRegs_135}};
  assign _zz_conv2_posCount_151 = {conv2_posBitRegs_140,{conv2_posBitRegs_139,conv2_posBitRegs_138}};
  assign _zz_conv2_posCount_153 = {conv2_posBitRegs_143,{conv2_posBitRegs_142,conv2_posBitRegs_141}};
  assign _zz_conv2_posCount_159 = {conv2_posBitRegs_146,{conv2_posBitRegs_145,conv2_posBitRegs_144}};
  assign _zz_conv2_posCount_161 = {conv2_posBitRegs_149,{conv2_posBitRegs_148,conv2_posBitRegs_147}};
  assign _zz_conv2_posCount_164 = {conv2_posBitRegs_152,{conv2_posBitRegs_151,conv2_posBitRegs_150}};
  assign _zz_conv2_posCount_166 = {conv2_posBitRegs_155,{conv2_posBitRegs_154,conv2_posBitRegs_153}};
  assign _zz_conv2_posCount_170 = {conv2_posBitRegs_158,{conv2_posBitRegs_157,conv2_posBitRegs_156}};
  assign _zz_conv2_posCount_172 = {conv2_posBitRegs_161,{conv2_posBitRegs_160,conv2_posBitRegs_159}};
  assign _zz_conv2_posCount_175 = {conv2_posBitRegs_164,{conv2_posBitRegs_163,conv2_posBitRegs_162}};
  assign _zz_conv2_posCount_177 = {conv2_posBitRegs_167,{conv2_posBitRegs_166,conv2_posBitRegs_165}};
  assign _zz_conv2_posCount_182 = {conv2_posBitRegs_170,{conv2_posBitRegs_169,conv2_posBitRegs_168}};
  assign _zz_conv2_posCount_184 = {conv2_posBitRegs_173,{conv2_posBitRegs_172,conv2_posBitRegs_171}};
  assign _zz_conv2_posCount_187 = {conv2_posBitRegs_176,{conv2_posBitRegs_175,conv2_posBitRegs_174}};
  assign _zz_conv2_posCount_189 = {conv2_posBitRegs_179,{conv2_posBitRegs_178,conv2_posBitRegs_177}};
  assign _zz_conv2_posCount_193 = {conv2_posBitRegs_182,{conv2_posBitRegs_181,conv2_posBitRegs_180}};
  assign _zz_conv2_posCount_195 = {conv2_posBitRegs_185,{conv2_posBitRegs_184,conv2_posBitRegs_183}};
  assign _zz_conv2_posCount_198 = {conv2_posBitRegs_188,{conv2_posBitRegs_187,conv2_posBitRegs_186}};
  assign _zz_conv2_posCount_200 = {conv2_posBitRegs_191,{conv2_posBitRegs_190,conv2_posBitRegs_189}};
  assign _zz_conv2_posCount_204 = {conv2_posBitRegs_194,{conv2_posBitRegs_193,conv2_posBitRegs_192}};
  assign _zz_conv2_posCount_206 = {conv2_posBitRegs_197,{conv2_posBitRegs_196,conv2_posBitRegs_195}};
  assign _zz_conv2_negCount_17 = {conv2_negBitRegs_2,{conv2_negBitRegs_1,conv2_negBitRegs_0}};
  assign _zz_conv2_negCount_19 = {conv2_negBitRegs_5,{conv2_negBitRegs_4,conv2_negBitRegs_3}};
  assign _zz_conv2_negCount_22 = {conv2_negBitRegs_8,{conv2_negBitRegs_7,conv2_negBitRegs_6}};
  assign _zz_conv2_negCount_24 = {conv2_negBitRegs_11,{conv2_negBitRegs_10,conv2_negBitRegs_9}};
  assign _zz_conv2_negCount_28 = {conv2_negBitRegs_14,{conv2_negBitRegs_13,conv2_negBitRegs_12}};
  assign _zz_conv2_negCount_30 = {conv2_negBitRegs_17,{conv2_negBitRegs_16,conv2_negBitRegs_15}};
  assign _zz_conv2_negCount_33 = {conv2_negBitRegs_20,{conv2_negBitRegs_19,conv2_negBitRegs_18}};
  assign _zz_conv2_negCount_35 = {conv2_negBitRegs_23,{conv2_negBitRegs_22,conv2_negBitRegs_21}};
  assign _zz_conv2_negCount_40 = {conv2_negBitRegs_26,{conv2_negBitRegs_25,conv2_negBitRegs_24}};
  assign _zz_conv2_negCount_42 = {conv2_negBitRegs_29,{conv2_negBitRegs_28,conv2_negBitRegs_27}};
  assign _zz_conv2_negCount_45 = {conv2_negBitRegs_32,{conv2_negBitRegs_31,conv2_negBitRegs_30}};
  assign _zz_conv2_negCount_47 = {conv2_negBitRegs_35,{conv2_negBitRegs_34,conv2_negBitRegs_33}};
  assign _zz_conv2_negCount_51 = {conv2_negBitRegs_38,{conv2_negBitRegs_37,conv2_negBitRegs_36}};
  assign _zz_conv2_negCount_53 = {conv2_negBitRegs_41,{conv2_negBitRegs_40,conv2_negBitRegs_39}};
  assign _zz_conv2_negCount_56 = {conv2_negBitRegs_44,{conv2_negBitRegs_43,conv2_negBitRegs_42}};
  assign _zz_conv2_negCount_58 = {conv2_negBitRegs_47,{conv2_negBitRegs_46,conv2_negBitRegs_45}};
  assign _zz_conv2_negCount_64 = {conv2_negBitRegs_50,{conv2_negBitRegs_49,conv2_negBitRegs_48}};
  assign _zz_conv2_negCount_66 = {conv2_negBitRegs_53,{conv2_negBitRegs_52,conv2_negBitRegs_51}};
  assign _zz_conv2_negCount_69 = {conv2_negBitRegs_56,{conv2_negBitRegs_55,conv2_negBitRegs_54}};
  assign _zz_conv2_negCount_71 = {conv2_negBitRegs_59,{conv2_negBitRegs_58,conv2_negBitRegs_57}};
  assign _zz_conv2_negCount_75 = {conv2_negBitRegs_62,{conv2_negBitRegs_61,conv2_negBitRegs_60}};
  assign _zz_conv2_negCount_77 = {conv2_negBitRegs_65,{conv2_negBitRegs_64,conv2_negBitRegs_63}};
  assign _zz_conv2_negCount_80 = {conv2_negBitRegs_68,{conv2_negBitRegs_67,conv2_negBitRegs_66}};
  assign _zz_conv2_negCount_82 = {conv2_negBitRegs_71,{conv2_negBitRegs_70,conv2_negBitRegs_69}};
  assign _zz_conv2_negCount_87 = {conv2_negBitRegs_74,{conv2_negBitRegs_73,conv2_negBitRegs_72}};
  assign _zz_conv2_negCount_89 = {conv2_negBitRegs_77,{conv2_negBitRegs_76,conv2_negBitRegs_75}};
  assign _zz_conv2_negCount_92 = {conv2_negBitRegs_80,{conv2_negBitRegs_79,conv2_negBitRegs_78}};
  assign _zz_conv2_negCount_94 = {conv2_negBitRegs_83,{conv2_negBitRegs_82,conv2_negBitRegs_81}};
  assign _zz_conv2_negCount_98 = {conv2_negBitRegs_86,{conv2_negBitRegs_85,conv2_negBitRegs_84}};
  assign _zz_conv2_negCount_100 = {conv2_negBitRegs_89,{conv2_negBitRegs_88,conv2_negBitRegs_87}};
  assign _zz_conv2_negCount_103 = {conv2_negBitRegs_92,{conv2_negBitRegs_91,conv2_negBitRegs_90}};
  assign _zz_conv2_negCount_105 = {conv2_negBitRegs_95,{conv2_negBitRegs_94,conv2_negBitRegs_93}};
  assign _zz_conv2_negCount_112 = {conv2_negBitRegs_98,{conv2_negBitRegs_97,conv2_negBitRegs_96}};
  assign _zz_conv2_negCount_114 = {conv2_negBitRegs_101,{conv2_negBitRegs_100,conv2_negBitRegs_99}};
  assign _zz_conv2_negCount_117 = {conv2_negBitRegs_104,{conv2_negBitRegs_103,conv2_negBitRegs_102}};
  assign _zz_conv2_negCount_119 = {conv2_negBitRegs_107,{conv2_negBitRegs_106,conv2_negBitRegs_105}};
  assign _zz_conv2_negCount_123 = {conv2_negBitRegs_110,{conv2_negBitRegs_109,conv2_negBitRegs_108}};
  assign _zz_conv2_negCount_125 = {conv2_negBitRegs_113,{conv2_negBitRegs_112,conv2_negBitRegs_111}};
  assign _zz_conv2_negCount_128 = {conv2_negBitRegs_116,{conv2_negBitRegs_115,conv2_negBitRegs_114}};
  assign _zz_conv2_negCount_130 = {conv2_negBitRegs_119,{conv2_negBitRegs_118,conv2_negBitRegs_117}};
  assign _zz_conv2_negCount_135 = {conv2_negBitRegs_122,{conv2_negBitRegs_121,conv2_negBitRegs_120}};
  assign _zz_conv2_negCount_137 = {conv2_negBitRegs_125,{conv2_negBitRegs_124,conv2_negBitRegs_123}};
  assign _zz_conv2_negCount_140 = {conv2_negBitRegs_128,{conv2_negBitRegs_127,conv2_negBitRegs_126}};
  assign _zz_conv2_negCount_142 = {conv2_negBitRegs_131,{conv2_negBitRegs_130,conv2_negBitRegs_129}};
  assign _zz_conv2_negCount_146 = {conv2_negBitRegs_134,{conv2_negBitRegs_133,conv2_negBitRegs_132}};
  assign _zz_conv2_negCount_148 = {conv2_negBitRegs_137,{conv2_negBitRegs_136,conv2_negBitRegs_135}};
  assign _zz_conv2_negCount_151 = {conv2_negBitRegs_140,{conv2_negBitRegs_139,conv2_negBitRegs_138}};
  assign _zz_conv2_negCount_153 = {conv2_negBitRegs_143,{conv2_negBitRegs_142,conv2_negBitRegs_141}};
  assign _zz_conv2_negCount_159 = {conv2_negBitRegs_146,{conv2_negBitRegs_145,conv2_negBitRegs_144}};
  assign _zz_conv2_negCount_161 = {conv2_negBitRegs_149,{conv2_negBitRegs_148,conv2_negBitRegs_147}};
  assign _zz_conv2_negCount_164 = {conv2_negBitRegs_152,{conv2_negBitRegs_151,conv2_negBitRegs_150}};
  assign _zz_conv2_negCount_166 = {conv2_negBitRegs_155,{conv2_negBitRegs_154,conv2_negBitRegs_153}};
  assign _zz_conv2_negCount_170 = {conv2_negBitRegs_158,{conv2_negBitRegs_157,conv2_negBitRegs_156}};
  assign _zz_conv2_negCount_172 = {conv2_negBitRegs_161,{conv2_negBitRegs_160,conv2_negBitRegs_159}};
  assign _zz_conv2_negCount_175 = {conv2_negBitRegs_164,{conv2_negBitRegs_163,conv2_negBitRegs_162}};
  assign _zz_conv2_negCount_177 = {conv2_negBitRegs_167,{conv2_negBitRegs_166,conv2_negBitRegs_165}};
  assign _zz_conv2_negCount_182 = {conv2_negBitRegs_170,{conv2_negBitRegs_169,conv2_negBitRegs_168}};
  assign _zz_conv2_negCount_184 = {conv2_negBitRegs_173,{conv2_negBitRegs_172,conv2_negBitRegs_171}};
  assign _zz_conv2_negCount_187 = {conv2_negBitRegs_176,{conv2_negBitRegs_175,conv2_negBitRegs_174}};
  assign _zz_conv2_negCount_189 = {conv2_negBitRegs_179,{conv2_negBitRegs_178,conv2_negBitRegs_177}};
  assign _zz_conv2_negCount_193 = {conv2_negBitRegs_182,{conv2_negBitRegs_181,conv2_negBitRegs_180}};
  assign _zz_conv2_negCount_195 = {conv2_negBitRegs_185,{conv2_negBitRegs_184,conv2_negBitRegs_183}};
  assign _zz_conv2_negCount_198 = {conv2_negBitRegs_188,{conv2_negBitRegs_187,conv2_negBitRegs_186}};
  assign _zz_conv2_negCount_200 = {conv2_negBitRegs_191,{conv2_negBitRegs_190,conv2_negBitRegs_189}};
  assign _zz_conv2_negCount_204 = {conv2_negBitRegs_194,{conv2_negBitRegs_193,conv2_negBitRegs_192}};
  assign _zz_conv2_negCount_206 = {conv2_negBitRegs_197,{conv2_negBitRegs_196,conv2_negBitRegs_195}};
  always @(posedge clk) begin
    if(_zz_3) begin
      conv1_actBuf[_zz_conv1_actBuf_port] <= _zz_conv1_actBuf_port_3;
    end
  end

  always @(posedge clk) begin
    if(conv1_loadInRange) begin
      conv1_actBuf_spinal_port1 <= conv1_actBuf[_zz_conv1_actBufRead];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv1_wThrRom.bin",conv1_wThrRom);
  end
  always @(posedge clk) begin
    if(conv1_loadInRange) begin
      conv1_wThrRom_spinal_port0 <= conv1_wThrRom[_zz_conv1_wThrRead];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv1_wSignRom.bin",conv1_wSignRom);
  end
  always @(posedge clk) begin
    if(conv1_loadInRange) begin
      conv1_wSignRom_spinal_port0 <= conv1_wSignRom[_zz_conv1_wSignRead];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv1_combAdjRom.bin",conv1_combAdjRom);
  end
  always @(posedge clk) begin
    if(_zz_conv1_combAdjRead_1) begin
      conv1_combAdjRom_spinal_port0 <= conv1_combAdjRom[_zz_conv1_combAdjRead_2];
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
    if(_zz_2) begin
      conv2_actBuf[_zz_conv2_actBuf_port] <= _zz_conv2_actBuf_port_1;
    end
  end

  always @(posedge clk) begin
    if(conv2_loadInRange) begin
      conv2_actBuf_spinal_port1 <= conv2_actBuf[conv2_actReadAddr];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv2_wThrRom.bin",conv2_wThrRom);
  end
  always @(posedge clk) begin
    if(conv2_loadInRange) begin
      conv2_wThrRom_spinal_port0 <= conv2_wThrRom[_zz_conv2_wThrRead];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv2_wSignRom.bin",conv2_wSignRom);
  end
  always @(posedge clk) begin
    if(conv2_loadInRange) begin
      conv2_wSignRom_spinal_port0 <= conv2_wSignRom[_zz_conv2_wSignRead];
    end
  end

  initial begin
    $readmemb("SpinalNNTop.v_toplevel_conv2_combAdjRom.bin",conv2_combAdjRom);
  end
  always @(posedge clk) begin
    if(_zz_conv2_combAdjRead_1) begin
      conv2_combAdjRom_spinal_port0 <= conv2_combAdjRom[_zz_conv2_combAdjRead_2];
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
    case(_zz_conv1_posCount_14)
      3'b000 : _zz_conv1_posCount_13 = _zz_conv1_posCount;
      3'b001 : _zz_conv1_posCount_13 = _zz_conv1_posCount_1;
      3'b010 : _zz_conv1_posCount_13 = _zz_conv1_posCount_2;
      3'b011 : _zz_conv1_posCount_13 = _zz_conv1_posCount_3;
      3'b100 : _zz_conv1_posCount_13 = _zz_conv1_posCount_4;
      3'b101 : _zz_conv1_posCount_13 = _zz_conv1_posCount_5;
      3'b110 : _zz_conv1_posCount_13 = _zz_conv1_posCount_6;
      default : _zz_conv1_posCount_13 = _zz_conv1_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_posCount_16)
      3'b000 : _zz_conv1_posCount_15 = _zz_conv1_posCount;
      3'b001 : _zz_conv1_posCount_15 = _zz_conv1_posCount_1;
      3'b010 : _zz_conv1_posCount_15 = _zz_conv1_posCount_2;
      3'b011 : _zz_conv1_posCount_15 = _zz_conv1_posCount_3;
      3'b100 : _zz_conv1_posCount_15 = _zz_conv1_posCount_4;
      3'b101 : _zz_conv1_posCount_15 = _zz_conv1_posCount_5;
      3'b110 : _zz_conv1_posCount_15 = _zz_conv1_posCount_6;
      default : _zz_conv1_posCount_15 = _zz_conv1_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_posCount_19)
      3'b000 : _zz_conv1_posCount_18 = _zz_conv1_posCount;
      3'b001 : _zz_conv1_posCount_18 = _zz_conv1_posCount_1;
      3'b010 : _zz_conv1_posCount_18 = _zz_conv1_posCount_2;
      3'b011 : _zz_conv1_posCount_18 = _zz_conv1_posCount_3;
      3'b100 : _zz_conv1_posCount_18 = _zz_conv1_posCount_4;
      3'b101 : _zz_conv1_posCount_18 = _zz_conv1_posCount_5;
      3'b110 : _zz_conv1_posCount_18 = _zz_conv1_posCount_6;
      default : _zz_conv1_posCount_18 = _zz_conv1_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_posCount_21)
      3'b000 : _zz_conv1_posCount_20 = _zz_conv1_posCount;
      3'b001 : _zz_conv1_posCount_20 = _zz_conv1_posCount_1;
      3'b010 : _zz_conv1_posCount_20 = _zz_conv1_posCount_2;
      3'b011 : _zz_conv1_posCount_20 = _zz_conv1_posCount_3;
      3'b100 : _zz_conv1_posCount_20 = _zz_conv1_posCount_4;
      3'b101 : _zz_conv1_posCount_20 = _zz_conv1_posCount_5;
      3'b110 : _zz_conv1_posCount_20 = _zz_conv1_posCount_6;
      default : _zz_conv1_posCount_20 = _zz_conv1_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_posCount_25)
      3'b000 : _zz_conv1_posCount_24 = _zz_conv1_posCount;
      3'b001 : _zz_conv1_posCount_24 = _zz_conv1_posCount_1;
      3'b010 : _zz_conv1_posCount_24 = _zz_conv1_posCount_2;
      3'b011 : _zz_conv1_posCount_24 = _zz_conv1_posCount_3;
      3'b100 : _zz_conv1_posCount_24 = _zz_conv1_posCount_4;
      3'b101 : _zz_conv1_posCount_24 = _zz_conv1_posCount_5;
      3'b110 : _zz_conv1_posCount_24 = _zz_conv1_posCount_6;
      default : _zz_conv1_posCount_24 = _zz_conv1_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_posCount_27)
      3'b000 : _zz_conv1_posCount_26 = _zz_conv1_posCount;
      3'b001 : _zz_conv1_posCount_26 = _zz_conv1_posCount_1;
      3'b010 : _zz_conv1_posCount_26 = _zz_conv1_posCount_2;
      3'b011 : _zz_conv1_posCount_26 = _zz_conv1_posCount_3;
      3'b100 : _zz_conv1_posCount_26 = _zz_conv1_posCount_4;
      3'b101 : _zz_conv1_posCount_26 = _zz_conv1_posCount_5;
      3'b110 : _zz_conv1_posCount_26 = _zz_conv1_posCount_6;
      default : _zz_conv1_posCount_26 = _zz_conv1_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_posCount_30)
      3'b000 : _zz_conv1_posCount_29 = _zz_conv1_posCount;
      3'b001 : _zz_conv1_posCount_29 = _zz_conv1_posCount_1;
      3'b010 : _zz_conv1_posCount_29 = _zz_conv1_posCount_2;
      3'b011 : _zz_conv1_posCount_29 = _zz_conv1_posCount_3;
      3'b100 : _zz_conv1_posCount_29 = _zz_conv1_posCount_4;
      3'b101 : _zz_conv1_posCount_29 = _zz_conv1_posCount_5;
      3'b110 : _zz_conv1_posCount_29 = _zz_conv1_posCount_6;
      default : _zz_conv1_posCount_29 = _zz_conv1_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_posCount_32)
      3'b000 : _zz_conv1_posCount_31 = _zz_conv1_posCount;
      3'b001 : _zz_conv1_posCount_31 = _zz_conv1_posCount_1;
      3'b010 : _zz_conv1_posCount_31 = _zz_conv1_posCount_2;
      3'b011 : _zz_conv1_posCount_31 = _zz_conv1_posCount_3;
      3'b100 : _zz_conv1_posCount_31 = _zz_conv1_posCount_4;
      3'b101 : _zz_conv1_posCount_31 = _zz_conv1_posCount_5;
      3'b110 : _zz_conv1_posCount_31 = _zz_conv1_posCount_6;
      default : _zz_conv1_posCount_31 = _zz_conv1_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_posCount_34)
      3'b000 : _zz_conv1_posCount_33 = _zz_conv1_posCount;
      3'b001 : _zz_conv1_posCount_33 = _zz_conv1_posCount_1;
      3'b010 : _zz_conv1_posCount_33 = _zz_conv1_posCount_2;
      3'b011 : _zz_conv1_posCount_33 = _zz_conv1_posCount_3;
      3'b100 : _zz_conv1_posCount_33 = _zz_conv1_posCount_4;
      3'b101 : _zz_conv1_posCount_33 = _zz_conv1_posCount_5;
      3'b110 : _zz_conv1_posCount_33 = _zz_conv1_posCount_6;
      default : _zz_conv1_posCount_33 = _zz_conv1_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_negCount_14)
      3'b000 : _zz_conv1_negCount_13 = _zz_conv1_negCount;
      3'b001 : _zz_conv1_negCount_13 = _zz_conv1_negCount_1;
      3'b010 : _zz_conv1_negCount_13 = _zz_conv1_negCount_2;
      3'b011 : _zz_conv1_negCount_13 = _zz_conv1_negCount_3;
      3'b100 : _zz_conv1_negCount_13 = _zz_conv1_negCount_4;
      3'b101 : _zz_conv1_negCount_13 = _zz_conv1_negCount_5;
      3'b110 : _zz_conv1_negCount_13 = _zz_conv1_negCount_6;
      default : _zz_conv1_negCount_13 = _zz_conv1_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_negCount_16)
      3'b000 : _zz_conv1_negCount_15 = _zz_conv1_negCount;
      3'b001 : _zz_conv1_negCount_15 = _zz_conv1_negCount_1;
      3'b010 : _zz_conv1_negCount_15 = _zz_conv1_negCount_2;
      3'b011 : _zz_conv1_negCount_15 = _zz_conv1_negCount_3;
      3'b100 : _zz_conv1_negCount_15 = _zz_conv1_negCount_4;
      3'b101 : _zz_conv1_negCount_15 = _zz_conv1_negCount_5;
      3'b110 : _zz_conv1_negCount_15 = _zz_conv1_negCount_6;
      default : _zz_conv1_negCount_15 = _zz_conv1_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_negCount_19)
      3'b000 : _zz_conv1_negCount_18 = _zz_conv1_negCount;
      3'b001 : _zz_conv1_negCount_18 = _zz_conv1_negCount_1;
      3'b010 : _zz_conv1_negCount_18 = _zz_conv1_negCount_2;
      3'b011 : _zz_conv1_negCount_18 = _zz_conv1_negCount_3;
      3'b100 : _zz_conv1_negCount_18 = _zz_conv1_negCount_4;
      3'b101 : _zz_conv1_negCount_18 = _zz_conv1_negCount_5;
      3'b110 : _zz_conv1_negCount_18 = _zz_conv1_negCount_6;
      default : _zz_conv1_negCount_18 = _zz_conv1_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_negCount_21)
      3'b000 : _zz_conv1_negCount_20 = _zz_conv1_negCount;
      3'b001 : _zz_conv1_negCount_20 = _zz_conv1_negCount_1;
      3'b010 : _zz_conv1_negCount_20 = _zz_conv1_negCount_2;
      3'b011 : _zz_conv1_negCount_20 = _zz_conv1_negCount_3;
      3'b100 : _zz_conv1_negCount_20 = _zz_conv1_negCount_4;
      3'b101 : _zz_conv1_negCount_20 = _zz_conv1_negCount_5;
      3'b110 : _zz_conv1_negCount_20 = _zz_conv1_negCount_6;
      default : _zz_conv1_negCount_20 = _zz_conv1_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_negCount_25)
      3'b000 : _zz_conv1_negCount_24 = _zz_conv1_negCount;
      3'b001 : _zz_conv1_negCount_24 = _zz_conv1_negCount_1;
      3'b010 : _zz_conv1_negCount_24 = _zz_conv1_negCount_2;
      3'b011 : _zz_conv1_negCount_24 = _zz_conv1_negCount_3;
      3'b100 : _zz_conv1_negCount_24 = _zz_conv1_negCount_4;
      3'b101 : _zz_conv1_negCount_24 = _zz_conv1_negCount_5;
      3'b110 : _zz_conv1_negCount_24 = _zz_conv1_negCount_6;
      default : _zz_conv1_negCount_24 = _zz_conv1_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_negCount_27)
      3'b000 : _zz_conv1_negCount_26 = _zz_conv1_negCount;
      3'b001 : _zz_conv1_negCount_26 = _zz_conv1_negCount_1;
      3'b010 : _zz_conv1_negCount_26 = _zz_conv1_negCount_2;
      3'b011 : _zz_conv1_negCount_26 = _zz_conv1_negCount_3;
      3'b100 : _zz_conv1_negCount_26 = _zz_conv1_negCount_4;
      3'b101 : _zz_conv1_negCount_26 = _zz_conv1_negCount_5;
      3'b110 : _zz_conv1_negCount_26 = _zz_conv1_negCount_6;
      default : _zz_conv1_negCount_26 = _zz_conv1_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_negCount_30)
      3'b000 : _zz_conv1_negCount_29 = _zz_conv1_negCount;
      3'b001 : _zz_conv1_negCount_29 = _zz_conv1_negCount_1;
      3'b010 : _zz_conv1_negCount_29 = _zz_conv1_negCount_2;
      3'b011 : _zz_conv1_negCount_29 = _zz_conv1_negCount_3;
      3'b100 : _zz_conv1_negCount_29 = _zz_conv1_negCount_4;
      3'b101 : _zz_conv1_negCount_29 = _zz_conv1_negCount_5;
      3'b110 : _zz_conv1_negCount_29 = _zz_conv1_negCount_6;
      default : _zz_conv1_negCount_29 = _zz_conv1_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_negCount_32)
      3'b000 : _zz_conv1_negCount_31 = _zz_conv1_negCount;
      3'b001 : _zz_conv1_negCount_31 = _zz_conv1_negCount_1;
      3'b010 : _zz_conv1_negCount_31 = _zz_conv1_negCount_2;
      3'b011 : _zz_conv1_negCount_31 = _zz_conv1_negCount_3;
      3'b100 : _zz_conv1_negCount_31 = _zz_conv1_negCount_4;
      3'b101 : _zz_conv1_negCount_31 = _zz_conv1_negCount_5;
      3'b110 : _zz_conv1_negCount_31 = _zz_conv1_negCount_6;
      default : _zz_conv1_negCount_31 = _zz_conv1_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv1_negCount_34)
      3'b000 : _zz_conv1_negCount_33 = _zz_conv1_negCount;
      3'b001 : _zz_conv1_negCount_33 = _zz_conv1_negCount_1;
      3'b010 : _zz_conv1_negCount_33 = _zz_conv1_negCount_2;
      3'b011 : _zz_conv1_negCount_33 = _zz_conv1_negCount_3;
      3'b100 : _zz_conv1_negCount_33 = _zz_conv1_negCount_4;
      3'b101 : _zz_conv1_negCount_33 = _zz_conv1_negCount_5;
      3'b110 : _zz_conv1_negCount_33 = _zz_conv1_negCount_6;
      default : _zz_conv1_negCount_33 = _zz_conv1_negCount_7;
    endcase
  end

  always @(*) begin
    case(conv1_safeStep)
      5'b00000 : _zz_conv1_actReadAddr = conv1_kOffVec_0;
      5'b00001 : _zz_conv1_actReadAddr = conv1_kOffVec_1;
      5'b00010 : _zz_conv1_actReadAddr = conv1_kOffVec_2;
      5'b00011 : _zz_conv1_actReadAddr = conv1_kOffVec_3;
      5'b00100 : _zz_conv1_actReadAddr = conv1_kOffVec_4;
      5'b00101 : _zz_conv1_actReadAddr = conv1_kOffVec_5;
      5'b00110 : _zz_conv1_actReadAddr = conv1_kOffVec_6;
      5'b00111 : _zz_conv1_actReadAddr = conv1_kOffVec_7;
      5'b01000 : _zz_conv1_actReadAddr = conv1_kOffVec_8;
      5'b01001 : _zz_conv1_actReadAddr = conv1_kOffVec_9;
      5'b01010 : _zz_conv1_actReadAddr = conv1_kOffVec_10;
      5'b01011 : _zz_conv1_actReadAddr = conv1_kOffVec_11;
      5'b01100 : _zz_conv1_actReadAddr = conv1_kOffVec_12;
      5'b01101 : _zz_conv1_actReadAddr = conv1_kOffVec_13;
      5'b01110 : _zz_conv1_actReadAddr = conv1_kOffVec_14;
      5'b01111 : _zz_conv1_actReadAddr = conv1_kOffVec_15;
      5'b10000 : _zz_conv1_actReadAddr = conv1_kOffVec_16;
      5'b10001 : _zz_conv1_actReadAddr = conv1_kOffVec_17;
      5'b10010 : _zz_conv1_actReadAddr = conv1_kOffVec_18;
      5'b10011 : _zz_conv1_actReadAddr = conv1_kOffVec_19;
      5'b10100 : _zz_conv1_actReadAddr = conv1_kOffVec_20;
      5'b10101 : _zz_conv1_actReadAddr = conv1_kOffVec_21;
      5'b10110 : _zz_conv1_actReadAddr = conv1_kOffVec_22;
      5'b10111 : _zz_conv1_actReadAddr = conv1_kOffVec_23;
      default : _zz_conv1_actReadAddr = conv1_kOffVec_24;
    endcase
  end

  always @(*) begin
    case(pool1_curSlotReg)
      1'b0 : _zz_pool1_readData = pool1_rowReads_0;
      default : _zz_pool1_readData = pool1_rowReads_1;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_17)
      3'b000 : _zz_conv2_posCount_16 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_16 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_16 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_16 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_16 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_16 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_16 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_16 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_19)
      3'b000 : _zz_conv2_posCount_18 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_18 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_18 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_18 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_18 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_18 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_18 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_18 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_22)
      3'b000 : _zz_conv2_posCount_21 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_21 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_21 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_21 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_21 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_21 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_21 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_21 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_24)
      3'b000 : _zz_conv2_posCount_23 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_23 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_23 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_23 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_23 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_23 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_23 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_23 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_28)
      3'b000 : _zz_conv2_posCount_27 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_27 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_27 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_27 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_27 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_27 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_27 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_27 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_30)
      3'b000 : _zz_conv2_posCount_29 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_29 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_29 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_29 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_29 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_29 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_29 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_29 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_33)
      3'b000 : _zz_conv2_posCount_32 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_32 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_32 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_32 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_32 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_32 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_32 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_32 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_35)
      3'b000 : _zz_conv2_posCount_34 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_34 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_34 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_34 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_34 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_34 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_34 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_34 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_40)
      3'b000 : _zz_conv2_posCount_39 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_39 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_39 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_39 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_39 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_39 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_39 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_39 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_42)
      3'b000 : _zz_conv2_posCount_41 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_41 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_41 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_41 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_41 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_41 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_41 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_41 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_45)
      3'b000 : _zz_conv2_posCount_44 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_44 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_44 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_44 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_44 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_44 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_44 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_44 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_47)
      3'b000 : _zz_conv2_posCount_46 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_46 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_46 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_46 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_46 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_46 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_46 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_46 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_51)
      3'b000 : _zz_conv2_posCount_50 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_50 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_50 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_50 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_50 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_50 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_50 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_50 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_53)
      3'b000 : _zz_conv2_posCount_52 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_52 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_52 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_52 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_52 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_52 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_52 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_52 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_56)
      3'b000 : _zz_conv2_posCount_55 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_55 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_55 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_55 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_55 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_55 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_55 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_55 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_58)
      3'b000 : _zz_conv2_posCount_57 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_57 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_57 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_57 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_57 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_57 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_57 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_57 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_64)
      3'b000 : _zz_conv2_posCount_63 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_63 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_63 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_63 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_63 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_63 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_63 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_63 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_66)
      3'b000 : _zz_conv2_posCount_65 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_65 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_65 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_65 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_65 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_65 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_65 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_65 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_69)
      3'b000 : _zz_conv2_posCount_68 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_68 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_68 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_68 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_68 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_68 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_68 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_68 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_71)
      3'b000 : _zz_conv2_posCount_70 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_70 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_70 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_70 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_70 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_70 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_70 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_70 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_75)
      3'b000 : _zz_conv2_posCount_74 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_74 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_74 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_74 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_74 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_74 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_74 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_74 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_77)
      3'b000 : _zz_conv2_posCount_76 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_76 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_76 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_76 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_76 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_76 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_76 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_76 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_80)
      3'b000 : _zz_conv2_posCount_79 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_79 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_79 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_79 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_79 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_79 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_79 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_79 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_82)
      3'b000 : _zz_conv2_posCount_81 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_81 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_81 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_81 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_81 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_81 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_81 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_81 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_87)
      3'b000 : _zz_conv2_posCount_86 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_86 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_86 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_86 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_86 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_86 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_86 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_86 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_89)
      3'b000 : _zz_conv2_posCount_88 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_88 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_88 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_88 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_88 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_88 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_88 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_88 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_92)
      3'b000 : _zz_conv2_posCount_91 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_91 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_91 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_91 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_91 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_91 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_91 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_91 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_94)
      3'b000 : _zz_conv2_posCount_93 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_93 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_93 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_93 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_93 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_93 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_93 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_93 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_98)
      3'b000 : _zz_conv2_posCount_97 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_97 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_97 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_97 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_97 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_97 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_97 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_97 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_100)
      3'b000 : _zz_conv2_posCount_99 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_99 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_99 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_99 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_99 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_99 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_99 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_99 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_103)
      3'b000 : _zz_conv2_posCount_102 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_102 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_102 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_102 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_102 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_102 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_102 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_102 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_105)
      3'b000 : _zz_conv2_posCount_104 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_104 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_104 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_104 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_104 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_104 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_104 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_104 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_112)
      3'b000 : _zz_conv2_posCount_111 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_111 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_111 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_111 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_111 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_111 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_111 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_111 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_114)
      3'b000 : _zz_conv2_posCount_113 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_113 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_113 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_113 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_113 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_113 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_113 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_113 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_117)
      3'b000 : _zz_conv2_posCount_116 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_116 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_116 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_116 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_116 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_116 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_116 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_116 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_119)
      3'b000 : _zz_conv2_posCount_118 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_118 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_118 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_118 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_118 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_118 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_118 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_118 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_123)
      3'b000 : _zz_conv2_posCount_122 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_122 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_122 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_122 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_122 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_122 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_122 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_122 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_125)
      3'b000 : _zz_conv2_posCount_124 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_124 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_124 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_124 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_124 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_124 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_124 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_124 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_128)
      3'b000 : _zz_conv2_posCount_127 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_127 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_127 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_127 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_127 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_127 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_127 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_127 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_130)
      3'b000 : _zz_conv2_posCount_129 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_129 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_129 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_129 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_129 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_129 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_129 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_129 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_135)
      3'b000 : _zz_conv2_posCount_134 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_134 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_134 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_134 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_134 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_134 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_134 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_134 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_137)
      3'b000 : _zz_conv2_posCount_136 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_136 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_136 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_136 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_136 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_136 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_136 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_136 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_140)
      3'b000 : _zz_conv2_posCount_139 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_139 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_139 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_139 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_139 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_139 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_139 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_139 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_142)
      3'b000 : _zz_conv2_posCount_141 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_141 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_141 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_141 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_141 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_141 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_141 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_141 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_146)
      3'b000 : _zz_conv2_posCount_145 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_145 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_145 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_145 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_145 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_145 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_145 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_145 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_148)
      3'b000 : _zz_conv2_posCount_147 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_147 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_147 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_147 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_147 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_147 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_147 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_147 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_151)
      3'b000 : _zz_conv2_posCount_150 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_150 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_150 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_150 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_150 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_150 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_150 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_150 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_153)
      3'b000 : _zz_conv2_posCount_152 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_152 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_152 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_152 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_152 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_152 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_152 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_152 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_159)
      3'b000 : _zz_conv2_posCount_158 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_158 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_158 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_158 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_158 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_158 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_158 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_158 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_161)
      3'b000 : _zz_conv2_posCount_160 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_160 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_160 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_160 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_160 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_160 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_160 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_160 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_164)
      3'b000 : _zz_conv2_posCount_163 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_163 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_163 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_163 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_163 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_163 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_163 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_163 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_166)
      3'b000 : _zz_conv2_posCount_165 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_165 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_165 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_165 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_165 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_165 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_165 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_165 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_170)
      3'b000 : _zz_conv2_posCount_169 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_169 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_169 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_169 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_169 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_169 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_169 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_169 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_172)
      3'b000 : _zz_conv2_posCount_171 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_171 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_171 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_171 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_171 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_171 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_171 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_171 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_175)
      3'b000 : _zz_conv2_posCount_174 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_174 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_174 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_174 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_174 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_174 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_174 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_174 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_177)
      3'b000 : _zz_conv2_posCount_176 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_176 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_176 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_176 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_176 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_176 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_176 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_176 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_182)
      3'b000 : _zz_conv2_posCount_181 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_181 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_181 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_181 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_181 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_181 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_181 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_181 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_184)
      3'b000 : _zz_conv2_posCount_183 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_183 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_183 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_183 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_183 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_183 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_183 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_183 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_187)
      3'b000 : _zz_conv2_posCount_186 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_186 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_186 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_186 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_186 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_186 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_186 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_186 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_189)
      3'b000 : _zz_conv2_posCount_188 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_188 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_188 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_188 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_188 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_188 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_188 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_188 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_193)
      3'b000 : _zz_conv2_posCount_192 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_192 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_192 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_192 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_192 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_192 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_192 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_192 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_195)
      3'b000 : _zz_conv2_posCount_194 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_194 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_194 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_194 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_194 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_194 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_194 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_194 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_198)
      3'b000 : _zz_conv2_posCount_197 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_197 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_197 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_197 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_197 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_197 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_197 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_197 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_200)
      3'b000 : _zz_conv2_posCount_199 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_199 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_199 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_199 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_199 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_199 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_199 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_199 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_204)
      3'b000 : _zz_conv2_posCount_203 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_203 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_203 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_203 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_203 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_203 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_203 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_203 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_206)
      3'b000 : _zz_conv2_posCount_205 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_205 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_205 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_205 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_205 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_205 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_205 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_205 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_posCount_208)
      3'b000 : _zz_conv2_posCount_207 = _zz_conv2_posCount;
      3'b001 : _zz_conv2_posCount_207 = _zz_conv2_posCount_1;
      3'b010 : _zz_conv2_posCount_207 = _zz_conv2_posCount_2;
      3'b011 : _zz_conv2_posCount_207 = _zz_conv2_posCount_3;
      3'b100 : _zz_conv2_posCount_207 = _zz_conv2_posCount_4;
      3'b101 : _zz_conv2_posCount_207 = _zz_conv2_posCount_5;
      3'b110 : _zz_conv2_posCount_207 = _zz_conv2_posCount_6;
      default : _zz_conv2_posCount_207 = _zz_conv2_posCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_17)
      3'b000 : _zz_conv2_negCount_16 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_16 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_16 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_16 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_16 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_16 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_16 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_16 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_19)
      3'b000 : _zz_conv2_negCount_18 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_18 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_18 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_18 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_18 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_18 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_18 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_18 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_22)
      3'b000 : _zz_conv2_negCount_21 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_21 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_21 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_21 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_21 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_21 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_21 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_21 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_24)
      3'b000 : _zz_conv2_negCount_23 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_23 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_23 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_23 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_23 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_23 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_23 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_23 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_28)
      3'b000 : _zz_conv2_negCount_27 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_27 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_27 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_27 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_27 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_27 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_27 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_27 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_30)
      3'b000 : _zz_conv2_negCount_29 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_29 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_29 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_29 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_29 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_29 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_29 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_29 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_33)
      3'b000 : _zz_conv2_negCount_32 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_32 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_32 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_32 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_32 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_32 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_32 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_32 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_35)
      3'b000 : _zz_conv2_negCount_34 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_34 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_34 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_34 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_34 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_34 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_34 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_34 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_40)
      3'b000 : _zz_conv2_negCount_39 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_39 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_39 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_39 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_39 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_39 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_39 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_39 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_42)
      3'b000 : _zz_conv2_negCount_41 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_41 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_41 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_41 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_41 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_41 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_41 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_41 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_45)
      3'b000 : _zz_conv2_negCount_44 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_44 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_44 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_44 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_44 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_44 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_44 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_44 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_47)
      3'b000 : _zz_conv2_negCount_46 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_46 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_46 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_46 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_46 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_46 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_46 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_46 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_51)
      3'b000 : _zz_conv2_negCount_50 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_50 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_50 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_50 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_50 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_50 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_50 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_50 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_53)
      3'b000 : _zz_conv2_negCount_52 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_52 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_52 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_52 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_52 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_52 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_52 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_52 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_56)
      3'b000 : _zz_conv2_negCount_55 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_55 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_55 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_55 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_55 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_55 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_55 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_55 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_58)
      3'b000 : _zz_conv2_negCount_57 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_57 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_57 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_57 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_57 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_57 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_57 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_57 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_64)
      3'b000 : _zz_conv2_negCount_63 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_63 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_63 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_63 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_63 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_63 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_63 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_63 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_66)
      3'b000 : _zz_conv2_negCount_65 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_65 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_65 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_65 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_65 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_65 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_65 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_65 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_69)
      3'b000 : _zz_conv2_negCount_68 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_68 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_68 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_68 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_68 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_68 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_68 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_68 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_71)
      3'b000 : _zz_conv2_negCount_70 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_70 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_70 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_70 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_70 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_70 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_70 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_70 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_75)
      3'b000 : _zz_conv2_negCount_74 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_74 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_74 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_74 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_74 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_74 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_74 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_74 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_77)
      3'b000 : _zz_conv2_negCount_76 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_76 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_76 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_76 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_76 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_76 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_76 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_76 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_80)
      3'b000 : _zz_conv2_negCount_79 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_79 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_79 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_79 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_79 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_79 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_79 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_79 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_82)
      3'b000 : _zz_conv2_negCount_81 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_81 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_81 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_81 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_81 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_81 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_81 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_81 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_87)
      3'b000 : _zz_conv2_negCount_86 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_86 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_86 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_86 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_86 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_86 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_86 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_86 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_89)
      3'b000 : _zz_conv2_negCount_88 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_88 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_88 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_88 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_88 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_88 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_88 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_88 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_92)
      3'b000 : _zz_conv2_negCount_91 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_91 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_91 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_91 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_91 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_91 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_91 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_91 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_94)
      3'b000 : _zz_conv2_negCount_93 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_93 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_93 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_93 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_93 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_93 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_93 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_93 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_98)
      3'b000 : _zz_conv2_negCount_97 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_97 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_97 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_97 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_97 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_97 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_97 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_97 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_100)
      3'b000 : _zz_conv2_negCount_99 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_99 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_99 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_99 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_99 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_99 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_99 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_99 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_103)
      3'b000 : _zz_conv2_negCount_102 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_102 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_102 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_102 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_102 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_102 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_102 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_102 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_105)
      3'b000 : _zz_conv2_negCount_104 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_104 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_104 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_104 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_104 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_104 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_104 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_104 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_112)
      3'b000 : _zz_conv2_negCount_111 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_111 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_111 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_111 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_111 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_111 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_111 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_111 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_114)
      3'b000 : _zz_conv2_negCount_113 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_113 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_113 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_113 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_113 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_113 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_113 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_113 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_117)
      3'b000 : _zz_conv2_negCount_116 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_116 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_116 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_116 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_116 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_116 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_116 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_116 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_119)
      3'b000 : _zz_conv2_negCount_118 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_118 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_118 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_118 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_118 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_118 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_118 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_118 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_123)
      3'b000 : _zz_conv2_negCount_122 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_122 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_122 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_122 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_122 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_122 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_122 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_122 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_125)
      3'b000 : _zz_conv2_negCount_124 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_124 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_124 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_124 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_124 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_124 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_124 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_124 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_128)
      3'b000 : _zz_conv2_negCount_127 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_127 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_127 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_127 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_127 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_127 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_127 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_127 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_130)
      3'b000 : _zz_conv2_negCount_129 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_129 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_129 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_129 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_129 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_129 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_129 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_129 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_135)
      3'b000 : _zz_conv2_negCount_134 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_134 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_134 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_134 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_134 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_134 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_134 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_134 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_137)
      3'b000 : _zz_conv2_negCount_136 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_136 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_136 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_136 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_136 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_136 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_136 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_136 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_140)
      3'b000 : _zz_conv2_negCount_139 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_139 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_139 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_139 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_139 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_139 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_139 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_139 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_142)
      3'b000 : _zz_conv2_negCount_141 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_141 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_141 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_141 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_141 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_141 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_141 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_141 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_146)
      3'b000 : _zz_conv2_negCount_145 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_145 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_145 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_145 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_145 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_145 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_145 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_145 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_148)
      3'b000 : _zz_conv2_negCount_147 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_147 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_147 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_147 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_147 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_147 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_147 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_147 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_151)
      3'b000 : _zz_conv2_negCount_150 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_150 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_150 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_150 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_150 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_150 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_150 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_150 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_153)
      3'b000 : _zz_conv2_negCount_152 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_152 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_152 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_152 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_152 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_152 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_152 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_152 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_159)
      3'b000 : _zz_conv2_negCount_158 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_158 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_158 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_158 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_158 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_158 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_158 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_158 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_161)
      3'b000 : _zz_conv2_negCount_160 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_160 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_160 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_160 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_160 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_160 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_160 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_160 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_164)
      3'b000 : _zz_conv2_negCount_163 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_163 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_163 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_163 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_163 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_163 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_163 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_163 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_166)
      3'b000 : _zz_conv2_negCount_165 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_165 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_165 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_165 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_165 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_165 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_165 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_165 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_170)
      3'b000 : _zz_conv2_negCount_169 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_169 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_169 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_169 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_169 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_169 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_169 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_169 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_172)
      3'b000 : _zz_conv2_negCount_171 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_171 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_171 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_171 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_171 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_171 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_171 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_171 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_175)
      3'b000 : _zz_conv2_negCount_174 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_174 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_174 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_174 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_174 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_174 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_174 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_174 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_177)
      3'b000 : _zz_conv2_negCount_176 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_176 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_176 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_176 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_176 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_176 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_176 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_176 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_182)
      3'b000 : _zz_conv2_negCount_181 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_181 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_181 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_181 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_181 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_181 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_181 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_181 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_184)
      3'b000 : _zz_conv2_negCount_183 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_183 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_183 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_183 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_183 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_183 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_183 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_183 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_187)
      3'b000 : _zz_conv2_negCount_186 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_186 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_186 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_186 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_186 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_186 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_186 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_186 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_189)
      3'b000 : _zz_conv2_negCount_188 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_188 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_188 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_188 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_188 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_188 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_188 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_188 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_193)
      3'b000 : _zz_conv2_negCount_192 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_192 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_192 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_192 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_192 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_192 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_192 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_192 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_195)
      3'b000 : _zz_conv2_negCount_194 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_194 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_194 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_194 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_194 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_194 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_194 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_194 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_198)
      3'b000 : _zz_conv2_negCount_197 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_197 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_197 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_197 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_197 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_197 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_197 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_197 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_200)
      3'b000 : _zz_conv2_negCount_199 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_199 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_199 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_199 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_199 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_199 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_199 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_199 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_204)
      3'b000 : _zz_conv2_negCount_203 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_203 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_203 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_203 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_203 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_203 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_203 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_203 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_206)
      3'b000 : _zz_conv2_negCount_205 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_205 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_205 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_205 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_205 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_205 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_205 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_205 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(_zz_conv2_negCount_208)
      3'b000 : _zz_conv2_negCount_207 = _zz_conv2_negCount;
      3'b001 : _zz_conv2_negCount_207 = _zz_conv2_negCount_1;
      3'b010 : _zz_conv2_negCount_207 = _zz_conv2_negCount_2;
      3'b011 : _zz_conv2_negCount_207 = _zz_conv2_negCount_3;
      3'b100 : _zz_conv2_negCount_207 = _zz_conv2_negCount_4;
      3'b101 : _zz_conv2_negCount_207 = _zz_conv2_negCount_5;
      3'b110 : _zz_conv2_negCount_207 = _zz_conv2_negCount_6;
      default : _zz_conv2_negCount_207 = _zz_conv2_negCount_7;
    endcase
  end

  always @(*) begin
    case(conv2_safeStep)
      8'b00000000 : _zz_conv2_actReadAddr = conv2_kOffVec_0;
      8'b00000001 : _zz_conv2_actReadAddr = conv2_kOffVec_1;
      8'b00000010 : _zz_conv2_actReadAddr = conv2_kOffVec_2;
      8'b00000011 : _zz_conv2_actReadAddr = conv2_kOffVec_3;
      8'b00000100 : _zz_conv2_actReadAddr = conv2_kOffVec_4;
      8'b00000101 : _zz_conv2_actReadAddr = conv2_kOffVec_5;
      8'b00000110 : _zz_conv2_actReadAddr = conv2_kOffVec_6;
      8'b00000111 : _zz_conv2_actReadAddr = conv2_kOffVec_7;
      8'b00001000 : _zz_conv2_actReadAddr = conv2_kOffVec_8;
      8'b00001001 : _zz_conv2_actReadAddr = conv2_kOffVec_9;
      8'b00001010 : _zz_conv2_actReadAddr = conv2_kOffVec_10;
      8'b00001011 : _zz_conv2_actReadAddr = conv2_kOffVec_11;
      8'b00001100 : _zz_conv2_actReadAddr = conv2_kOffVec_12;
      8'b00001101 : _zz_conv2_actReadAddr = conv2_kOffVec_13;
      8'b00001110 : _zz_conv2_actReadAddr = conv2_kOffVec_14;
      8'b00001111 : _zz_conv2_actReadAddr = conv2_kOffVec_15;
      8'b00010000 : _zz_conv2_actReadAddr = conv2_kOffVec_16;
      8'b00010001 : _zz_conv2_actReadAddr = conv2_kOffVec_17;
      8'b00010010 : _zz_conv2_actReadAddr = conv2_kOffVec_18;
      8'b00010011 : _zz_conv2_actReadAddr = conv2_kOffVec_19;
      8'b00010100 : _zz_conv2_actReadAddr = conv2_kOffVec_20;
      8'b00010101 : _zz_conv2_actReadAddr = conv2_kOffVec_21;
      8'b00010110 : _zz_conv2_actReadAddr = conv2_kOffVec_22;
      8'b00010111 : _zz_conv2_actReadAddr = conv2_kOffVec_23;
      8'b00011000 : _zz_conv2_actReadAddr = conv2_kOffVec_24;
      8'b00011001 : _zz_conv2_actReadAddr = conv2_kOffVec_25;
      8'b00011010 : _zz_conv2_actReadAddr = conv2_kOffVec_26;
      8'b00011011 : _zz_conv2_actReadAddr = conv2_kOffVec_27;
      8'b00011100 : _zz_conv2_actReadAddr = conv2_kOffVec_28;
      8'b00011101 : _zz_conv2_actReadAddr = conv2_kOffVec_29;
      8'b00011110 : _zz_conv2_actReadAddr = conv2_kOffVec_30;
      8'b00011111 : _zz_conv2_actReadAddr = conv2_kOffVec_31;
      8'b00100000 : _zz_conv2_actReadAddr = conv2_kOffVec_32;
      8'b00100001 : _zz_conv2_actReadAddr = conv2_kOffVec_33;
      8'b00100010 : _zz_conv2_actReadAddr = conv2_kOffVec_34;
      8'b00100011 : _zz_conv2_actReadAddr = conv2_kOffVec_35;
      8'b00100100 : _zz_conv2_actReadAddr = conv2_kOffVec_36;
      8'b00100101 : _zz_conv2_actReadAddr = conv2_kOffVec_37;
      8'b00100110 : _zz_conv2_actReadAddr = conv2_kOffVec_38;
      8'b00100111 : _zz_conv2_actReadAddr = conv2_kOffVec_39;
      8'b00101000 : _zz_conv2_actReadAddr = conv2_kOffVec_40;
      8'b00101001 : _zz_conv2_actReadAddr = conv2_kOffVec_41;
      8'b00101010 : _zz_conv2_actReadAddr = conv2_kOffVec_42;
      8'b00101011 : _zz_conv2_actReadAddr = conv2_kOffVec_43;
      8'b00101100 : _zz_conv2_actReadAddr = conv2_kOffVec_44;
      8'b00101101 : _zz_conv2_actReadAddr = conv2_kOffVec_45;
      8'b00101110 : _zz_conv2_actReadAddr = conv2_kOffVec_46;
      8'b00101111 : _zz_conv2_actReadAddr = conv2_kOffVec_47;
      8'b00110000 : _zz_conv2_actReadAddr = conv2_kOffVec_48;
      8'b00110001 : _zz_conv2_actReadAddr = conv2_kOffVec_49;
      8'b00110010 : _zz_conv2_actReadAddr = conv2_kOffVec_50;
      8'b00110011 : _zz_conv2_actReadAddr = conv2_kOffVec_51;
      8'b00110100 : _zz_conv2_actReadAddr = conv2_kOffVec_52;
      8'b00110101 : _zz_conv2_actReadAddr = conv2_kOffVec_53;
      8'b00110110 : _zz_conv2_actReadAddr = conv2_kOffVec_54;
      8'b00110111 : _zz_conv2_actReadAddr = conv2_kOffVec_55;
      8'b00111000 : _zz_conv2_actReadAddr = conv2_kOffVec_56;
      8'b00111001 : _zz_conv2_actReadAddr = conv2_kOffVec_57;
      8'b00111010 : _zz_conv2_actReadAddr = conv2_kOffVec_58;
      8'b00111011 : _zz_conv2_actReadAddr = conv2_kOffVec_59;
      8'b00111100 : _zz_conv2_actReadAddr = conv2_kOffVec_60;
      8'b00111101 : _zz_conv2_actReadAddr = conv2_kOffVec_61;
      8'b00111110 : _zz_conv2_actReadAddr = conv2_kOffVec_62;
      8'b00111111 : _zz_conv2_actReadAddr = conv2_kOffVec_63;
      8'b01000000 : _zz_conv2_actReadAddr = conv2_kOffVec_64;
      8'b01000001 : _zz_conv2_actReadAddr = conv2_kOffVec_65;
      8'b01000010 : _zz_conv2_actReadAddr = conv2_kOffVec_66;
      8'b01000011 : _zz_conv2_actReadAddr = conv2_kOffVec_67;
      8'b01000100 : _zz_conv2_actReadAddr = conv2_kOffVec_68;
      8'b01000101 : _zz_conv2_actReadAddr = conv2_kOffVec_69;
      8'b01000110 : _zz_conv2_actReadAddr = conv2_kOffVec_70;
      8'b01000111 : _zz_conv2_actReadAddr = conv2_kOffVec_71;
      8'b01001000 : _zz_conv2_actReadAddr = conv2_kOffVec_72;
      8'b01001001 : _zz_conv2_actReadAddr = conv2_kOffVec_73;
      8'b01001010 : _zz_conv2_actReadAddr = conv2_kOffVec_74;
      8'b01001011 : _zz_conv2_actReadAddr = conv2_kOffVec_75;
      8'b01001100 : _zz_conv2_actReadAddr = conv2_kOffVec_76;
      8'b01001101 : _zz_conv2_actReadAddr = conv2_kOffVec_77;
      8'b01001110 : _zz_conv2_actReadAddr = conv2_kOffVec_78;
      8'b01001111 : _zz_conv2_actReadAddr = conv2_kOffVec_79;
      8'b01010000 : _zz_conv2_actReadAddr = conv2_kOffVec_80;
      8'b01010001 : _zz_conv2_actReadAddr = conv2_kOffVec_81;
      8'b01010010 : _zz_conv2_actReadAddr = conv2_kOffVec_82;
      8'b01010011 : _zz_conv2_actReadAddr = conv2_kOffVec_83;
      8'b01010100 : _zz_conv2_actReadAddr = conv2_kOffVec_84;
      8'b01010101 : _zz_conv2_actReadAddr = conv2_kOffVec_85;
      8'b01010110 : _zz_conv2_actReadAddr = conv2_kOffVec_86;
      8'b01010111 : _zz_conv2_actReadAddr = conv2_kOffVec_87;
      8'b01011000 : _zz_conv2_actReadAddr = conv2_kOffVec_88;
      8'b01011001 : _zz_conv2_actReadAddr = conv2_kOffVec_89;
      8'b01011010 : _zz_conv2_actReadAddr = conv2_kOffVec_90;
      8'b01011011 : _zz_conv2_actReadAddr = conv2_kOffVec_91;
      8'b01011100 : _zz_conv2_actReadAddr = conv2_kOffVec_92;
      8'b01011101 : _zz_conv2_actReadAddr = conv2_kOffVec_93;
      8'b01011110 : _zz_conv2_actReadAddr = conv2_kOffVec_94;
      8'b01011111 : _zz_conv2_actReadAddr = conv2_kOffVec_95;
      8'b01100000 : _zz_conv2_actReadAddr = conv2_kOffVec_96;
      8'b01100001 : _zz_conv2_actReadAddr = conv2_kOffVec_97;
      8'b01100010 : _zz_conv2_actReadAddr = conv2_kOffVec_98;
      8'b01100011 : _zz_conv2_actReadAddr = conv2_kOffVec_99;
      8'b01100100 : _zz_conv2_actReadAddr = conv2_kOffVec_100;
      8'b01100101 : _zz_conv2_actReadAddr = conv2_kOffVec_101;
      8'b01100110 : _zz_conv2_actReadAddr = conv2_kOffVec_102;
      8'b01100111 : _zz_conv2_actReadAddr = conv2_kOffVec_103;
      8'b01101000 : _zz_conv2_actReadAddr = conv2_kOffVec_104;
      8'b01101001 : _zz_conv2_actReadAddr = conv2_kOffVec_105;
      8'b01101010 : _zz_conv2_actReadAddr = conv2_kOffVec_106;
      8'b01101011 : _zz_conv2_actReadAddr = conv2_kOffVec_107;
      8'b01101100 : _zz_conv2_actReadAddr = conv2_kOffVec_108;
      8'b01101101 : _zz_conv2_actReadAddr = conv2_kOffVec_109;
      8'b01101110 : _zz_conv2_actReadAddr = conv2_kOffVec_110;
      8'b01101111 : _zz_conv2_actReadAddr = conv2_kOffVec_111;
      8'b01110000 : _zz_conv2_actReadAddr = conv2_kOffVec_112;
      8'b01110001 : _zz_conv2_actReadAddr = conv2_kOffVec_113;
      8'b01110010 : _zz_conv2_actReadAddr = conv2_kOffVec_114;
      8'b01110011 : _zz_conv2_actReadAddr = conv2_kOffVec_115;
      8'b01110100 : _zz_conv2_actReadAddr = conv2_kOffVec_116;
      8'b01110101 : _zz_conv2_actReadAddr = conv2_kOffVec_117;
      8'b01110110 : _zz_conv2_actReadAddr = conv2_kOffVec_118;
      8'b01110111 : _zz_conv2_actReadAddr = conv2_kOffVec_119;
      8'b01111000 : _zz_conv2_actReadAddr = conv2_kOffVec_120;
      8'b01111001 : _zz_conv2_actReadAddr = conv2_kOffVec_121;
      8'b01111010 : _zz_conv2_actReadAddr = conv2_kOffVec_122;
      8'b01111011 : _zz_conv2_actReadAddr = conv2_kOffVec_123;
      8'b01111100 : _zz_conv2_actReadAddr = conv2_kOffVec_124;
      8'b01111101 : _zz_conv2_actReadAddr = conv2_kOffVec_125;
      8'b01111110 : _zz_conv2_actReadAddr = conv2_kOffVec_126;
      8'b01111111 : _zz_conv2_actReadAddr = conv2_kOffVec_127;
      8'b10000000 : _zz_conv2_actReadAddr = conv2_kOffVec_128;
      8'b10000001 : _zz_conv2_actReadAddr = conv2_kOffVec_129;
      8'b10000010 : _zz_conv2_actReadAddr = conv2_kOffVec_130;
      8'b10000011 : _zz_conv2_actReadAddr = conv2_kOffVec_131;
      8'b10000100 : _zz_conv2_actReadAddr = conv2_kOffVec_132;
      8'b10000101 : _zz_conv2_actReadAddr = conv2_kOffVec_133;
      8'b10000110 : _zz_conv2_actReadAddr = conv2_kOffVec_134;
      8'b10000111 : _zz_conv2_actReadAddr = conv2_kOffVec_135;
      8'b10001000 : _zz_conv2_actReadAddr = conv2_kOffVec_136;
      8'b10001001 : _zz_conv2_actReadAddr = conv2_kOffVec_137;
      8'b10001010 : _zz_conv2_actReadAddr = conv2_kOffVec_138;
      8'b10001011 : _zz_conv2_actReadAddr = conv2_kOffVec_139;
      8'b10001100 : _zz_conv2_actReadAddr = conv2_kOffVec_140;
      8'b10001101 : _zz_conv2_actReadAddr = conv2_kOffVec_141;
      8'b10001110 : _zz_conv2_actReadAddr = conv2_kOffVec_142;
      8'b10001111 : _zz_conv2_actReadAddr = conv2_kOffVec_143;
      8'b10010000 : _zz_conv2_actReadAddr = conv2_kOffVec_144;
      8'b10010001 : _zz_conv2_actReadAddr = conv2_kOffVec_145;
      8'b10010010 : _zz_conv2_actReadAddr = conv2_kOffVec_146;
      8'b10010011 : _zz_conv2_actReadAddr = conv2_kOffVec_147;
      8'b10010100 : _zz_conv2_actReadAddr = conv2_kOffVec_148;
      8'b10010101 : _zz_conv2_actReadAddr = conv2_kOffVec_149;
      8'b10010110 : _zz_conv2_actReadAddr = conv2_kOffVec_150;
      8'b10010111 : _zz_conv2_actReadAddr = conv2_kOffVec_151;
      8'b10011000 : _zz_conv2_actReadAddr = conv2_kOffVec_152;
      8'b10011001 : _zz_conv2_actReadAddr = conv2_kOffVec_153;
      8'b10011010 : _zz_conv2_actReadAddr = conv2_kOffVec_154;
      8'b10011011 : _zz_conv2_actReadAddr = conv2_kOffVec_155;
      8'b10011100 : _zz_conv2_actReadAddr = conv2_kOffVec_156;
      8'b10011101 : _zz_conv2_actReadAddr = conv2_kOffVec_157;
      8'b10011110 : _zz_conv2_actReadAddr = conv2_kOffVec_158;
      8'b10011111 : _zz_conv2_actReadAddr = conv2_kOffVec_159;
      8'b10100000 : _zz_conv2_actReadAddr = conv2_kOffVec_160;
      8'b10100001 : _zz_conv2_actReadAddr = conv2_kOffVec_161;
      8'b10100010 : _zz_conv2_actReadAddr = conv2_kOffVec_162;
      8'b10100011 : _zz_conv2_actReadAddr = conv2_kOffVec_163;
      8'b10100100 : _zz_conv2_actReadAddr = conv2_kOffVec_164;
      8'b10100101 : _zz_conv2_actReadAddr = conv2_kOffVec_165;
      8'b10100110 : _zz_conv2_actReadAddr = conv2_kOffVec_166;
      8'b10100111 : _zz_conv2_actReadAddr = conv2_kOffVec_167;
      8'b10101000 : _zz_conv2_actReadAddr = conv2_kOffVec_168;
      8'b10101001 : _zz_conv2_actReadAddr = conv2_kOffVec_169;
      8'b10101010 : _zz_conv2_actReadAddr = conv2_kOffVec_170;
      8'b10101011 : _zz_conv2_actReadAddr = conv2_kOffVec_171;
      8'b10101100 : _zz_conv2_actReadAddr = conv2_kOffVec_172;
      8'b10101101 : _zz_conv2_actReadAddr = conv2_kOffVec_173;
      8'b10101110 : _zz_conv2_actReadAddr = conv2_kOffVec_174;
      8'b10101111 : _zz_conv2_actReadAddr = conv2_kOffVec_175;
      8'b10110000 : _zz_conv2_actReadAddr = conv2_kOffVec_176;
      8'b10110001 : _zz_conv2_actReadAddr = conv2_kOffVec_177;
      8'b10110010 : _zz_conv2_actReadAddr = conv2_kOffVec_178;
      8'b10110011 : _zz_conv2_actReadAddr = conv2_kOffVec_179;
      8'b10110100 : _zz_conv2_actReadAddr = conv2_kOffVec_180;
      8'b10110101 : _zz_conv2_actReadAddr = conv2_kOffVec_181;
      8'b10110110 : _zz_conv2_actReadAddr = conv2_kOffVec_182;
      8'b10110111 : _zz_conv2_actReadAddr = conv2_kOffVec_183;
      8'b10111000 : _zz_conv2_actReadAddr = conv2_kOffVec_184;
      8'b10111001 : _zz_conv2_actReadAddr = conv2_kOffVec_185;
      8'b10111010 : _zz_conv2_actReadAddr = conv2_kOffVec_186;
      8'b10111011 : _zz_conv2_actReadAddr = conv2_kOffVec_187;
      8'b10111100 : _zz_conv2_actReadAddr = conv2_kOffVec_188;
      8'b10111101 : _zz_conv2_actReadAddr = conv2_kOffVec_189;
      8'b10111110 : _zz_conv2_actReadAddr = conv2_kOffVec_190;
      8'b10111111 : _zz_conv2_actReadAddr = conv2_kOffVec_191;
      8'b11000000 : _zz_conv2_actReadAddr = conv2_kOffVec_192;
      8'b11000001 : _zz_conv2_actReadAddr = conv2_kOffVec_193;
      8'b11000010 : _zz_conv2_actReadAddr = conv2_kOffVec_194;
      8'b11000011 : _zz_conv2_actReadAddr = conv2_kOffVec_195;
      8'b11000100 : _zz_conv2_actReadAddr = conv2_kOffVec_196;
      8'b11000101 : _zz_conv2_actReadAddr = conv2_kOffVec_197;
      8'b11000110 : _zz_conv2_actReadAddr = conv2_kOffVec_198;
      default : _zz_conv2_actReadAddr = conv2_kOffVec_199;
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

  always @(*) begin
    _zz_2 = 1'b0;
    if(when_StochasticConvCore_l315_1) begin
      _zz_2 = 1'b1;
    end
  end

  always @(*) begin
    _zz_3 = 1'b0;
    if(when_StochasticConvCore_l315) begin
      _zz_3 = 1'b1;
    end
  end

  assign conv1_sRx = 3'b000;
  assign conv1_sInit = 3'b001;
  assign conv1_sLoad = 3'b010;
  assign conv1_sSC = 3'b011;
  assign conv1_sDecode = 3'b100;
  assign _zz_conv1_posBitRegs_0 = ((conv1_wLfsrChain_0 < conv1_wThrRegs_0) && (conv1_aLfsrChain_0 < conv1_activThresh_0));
  assign _zz_conv1_posBitRegs_1 = ((conv1_wLfsrChain_1 < conv1_wThrRegs_1) && (conv1_aLfsrChain_1 < conv1_activThresh_1));
  assign _zz_conv1_posBitRegs_2 = ((conv1_wLfsrChain_2 < conv1_wThrRegs_2) && (conv1_aLfsrChain_2 < conv1_activThresh_2));
  assign _zz_conv1_posBitRegs_3 = ((conv1_wLfsrChain_3 < conv1_wThrRegs_3) && (conv1_aLfsrChain_3 < conv1_activThresh_3));
  assign _zz_conv1_posBitRegs_4 = ((conv1_wLfsrChain_4 < conv1_wThrRegs_4) && (conv1_aLfsrChain_4 < conv1_activThresh_4));
  assign _zz_conv1_posBitRegs_5 = ((conv1_wLfsrChain_5 < conv1_wThrRegs_5) && (conv1_aLfsrChain_5 < conv1_activThresh_5));
  assign _zz_conv1_posBitRegs_6 = ((conv1_wLfsrChain_6 < conv1_wThrRegs_6) && (conv1_aLfsrChain_6 < conv1_activThresh_6));
  assign _zz_conv1_posBitRegs_7 = ((conv1_wLfsrChain_7 < conv1_wThrRegs_7) && (conv1_aLfsrChain_7 < conv1_activThresh_7));
  assign _zz_conv1_posBitRegs_8 = ((conv1_wLfsrChain_8 < conv1_wThrRegs_8) && (conv1_aLfsrChain_8 < conv1_activThresh_8));
  assign _zz_conv1_posBitRegs_9 = ((conv1_wLfsrChain_9 < conv1_wThrRegs_9) && (conv1_aLfsrChain_9 < conv1_activThresh_9));
  assign _zz_conv1_posBitRegs_10 = ((conv1_wLfsrChain_10 < conv1_wThrRegs_10) && (conv1_aLfsrChain_10 < conv1_activThresh_10));
  assign _zz_conv1_posBitRegs_11 = ((conv1_wLfsrChain_11 < conv1_wThrRegs_11) && (conv1_aLfsrChain_11 < conv1_activThresh_11));
  assign _zz_conv1_posBitRegs_12 = ((conv1_wLfsrChain_12 < conv1_wThrRegs_12) && (conv1_aLfsrChain_12 < conv1_activThresh_12));
  assign _zz_conv1_posBitRegs_13 = ((conv1_wLfsrChain_13 < conv1_wThrRegs_13) && (conv1_aLfsrChain_13 < conv1_activThresh_13));
  assign _zz_conv1_posBitRegs_14 = ((conv1_wLfsrChain_14 < conv1_wThrRegs_14) && (conv1_aLfsrChain_14 < conv1_activThresh_14));
  assign _zz_conv1_posBitRegs_15 = ((conv1_wLfsrChain_15 < conv1_wThrRegs_15) && (conv1_aLfsrChain_15 < conv1_activThresh_15));
  assign _zz_conv1_posBitRegs_16 = ((conv1_wLfsrChain_16 < conv1_wThrRegs_16) && (conv1_aLfsrChain_16 < conv1_activThresh_16));
  assign _zz_conv1_posBitRegs_17 = ((conv1_wLfsrChain_17 < conv1_wThrRegs_17) && (conv1_aLfsrChain_17 < conv1_activThresh_17));
  assign _zz_conv1_posBitRegs_18 = ((conv1_wLfsrChain_18 < conv1_wThrRegs_18) && (conv1_aLfsrChain_18 < conv1_activThresh_18));
  assign _zz_conv1_posBitRegs_19 = ((conv1_wLfsrChain_19 < conv1_wThrRegs_19) && (conv1_aLfsrChain_19 < conv1_activThresh_19));
  assign _zz_conv1_posBitRegs_20 = ((conv1_wLfsrChain_20 < conv1_wThrRegs_20) && (conv1_aLfsrChain_20 < conv1_activThresh_20));
  assign _zz_conv1_posBitRegs_21 = ((conv1_wLfsrChain_21 < conv1_wThrRegs_21) && (conv1_aLfsrChain_21 < conv1_activThresh_21));
  assign _zz_conv1_posBitRegs_22 = ((conv1_wLfsrChain_22 < conv1_wThrRegs_22) && (conv1_aLfsrChain_22 < conv1_activThresh_22));
  assign _zz_conv1_posBitRegs_23 = ((conv1_wLfsrChain_23 < conv1_wThrRegs_23) && (conv1_aLfsrChain_23 < conv1_activThresh_23));
  assign _zz_conv1_posBitRegs_24 = ((conv1_wLfsrChain_24 < conv1_wThrRegs_24) && (conv1_aLfsrChain_24 < conv1_activThresh_24));
  assign _zz_conv1_posCount = 5'h0;
  assign _zz_conv1_posCount_1 = 5'h01;
  assign _zz_conv1_posCount_2 = 5'h01;
  assign _zz_conv1_posCount_3 = 5'h02;
  assign _zz_conv1_posCount_4 = 5'h01;
  assign _zz_conv1_posCount_5 = 5'h02;
  assign _zz_conv1_posCount_6 = 5'h02;
  assign _zz_conv1_posCount_7 = 5'h03;
  assign conv1_posCount = _zz_conv1_posCount_8;
  assign _zz_conv1_negCount = 5'h0;
  assign _zz_conv1_negCount_1 = 5'h01;
  assign _zz_conv1_negCount_2 = 5'h01;
  assign _zz_conv1_negCount_3 = 5'h02;
  assign _zz_conv1_negCount_4 = 5'h01;
  assign _zz_conv1_negCount_5 = 5'h02;
  assign _zz_conv1_negCount_6 = 5'h02;
  assign _zz_conv1_negCount_7 = 5'h03;
  assign conv1_negCount = _zz_conv1_negCount_8;
  always @(*) begin
    conv1_activationOut_valid = 1'b0;
    if(when_StochasticConvCore_l387) begin
      conv1_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    conv1_activationOut_payload_value = 8'h0;
    if(when_StochasticConvCore_l387) begin
      conv1_activationOut_payload_value = (($signed(27'h000007f) < $signed(_zz_conv1_activationOut_payload_value)) ? 8'h7f : _zz_conv1_activationOut_payload_value_1);
    end
  end

  always @(*) begin
    activation_in_ready = 1'b0;
    if(when_StochasticConvCore_l288) begin
      activation_in_ready = 1'b1;
    end
  end

  assign when_StochasticConvCore_l279 = (conv1_state == conv1_sInit);
  assign when_StochasticConvCore_l280 = (conv1_initAddr == 11'h3ff);
  assign when_StochasticConvCore_l288 = (conv1_state == conv1_sRx);
  assign io_activationIn_fire = (activation_in_valid && activation_in_ready);
  assign _zz_conv1_rxAddr = (conv1_rxRow == 5'h1b);
  assign when_StochasticConvCore_l295 = (conv1_rxCnt == 10'h30f);
  assign when_StochasticConvCore_l315 = ((conv1_state == conv1_sInit) || ((conv1_state == conv1_sRx) && io_activationIn_fire));
  assign conv1_pixelBase = (_zz_conv1_pixelBase + _zz_conv1_pixelBase_1);
  assign conv1_kOffVec_0 = 11'h0;
  assign conv1_kOffVec_1 = 11'h001;
  assign conv1_kOffVec_2 = 11'h002;
  assign conv1_kOffVec_3 = 11'h003;
  assign conv1_kOffVec_4 = 11'h004;
  assign conv1_kOffVec_5 = 11'h020;
  assign conv1_kOffVec_6 = 11'h021;
  assign conv1_kOffVec_7 = 11'h022;
  assign conv1_kOffVec_8 = 11'h023;
  assign conv1_kOffVec_9 = 11'h024;
  assign conv1_kOffVec_10 = 11'h040;
  assign conv1_kOffVec_11 = 11'h041;
  assign conv1_kOffVec_12 = 11'h042;
  assign conv1_kOffVec_13 = 11'h043;
  assign conv1_kOffVec_14 = 11'h044;
  assign conv1_kOffVec_15 = 11'h060;
  assign conv1_kOffVec_16 = 11'h061;
  assign conv1_kOffVec_17 = 11'h062;
  assign conv1_kOffVec_18 = 11'h063;
  assign conv1_kOffVec_19 = 11'h064;
  assign conv1_kOffVec_20 = 11'h080;
  assign conv1_kOffVec_21 = 11'h081;
  assign conv1_kOffVec_22 = 11'h082;
  assign conv1_kOffVec_23 = 11'h083;
  assign conv1_kOffVec_24 = 11'h084;
  assign conv1_safeStep = ((conv1_loadStep < 5'h19) ? conv1_loadStep : 5'h18);
  assign conv1_actReadAddr = (conv1_pixelBase + _zz_conv1_actReadAddr);
  assign conv1_loadInRange = ((conv1_state == conv1_sLoad) && (conv1_loadStep < 5'h19));
  assign conv1_actBufRead = conv1_actBuf_spinal_port1;
  assign _zz_conv1_wThrRead = (conv1_wAddrBase + _zz__zz_conv1_wThrRead);
  assign conv1_wThrRead = conv1_wThrRom_spinal_port0;
  assign _zz_conv1_wSignRead = (conv1_wAddrBase + _zz__zz_conv1_wSignRead);
  assign conv1_wSignRead = conv1_wSignRom_spinal_port0[0];
  assign _zz_conv1_combAdjRead = conv1_ocReg;
  assign _zz_conv1_combAdjRead_1 = ((conv1_state == conv1_sLoad) && (conv1_loadStep == 5'h0));
  assign conv1_combAdjRead = conv1_combAdjRom_spinal_port0;
  assign when_StochasticConvCore_l345 = (conv1_state == conv1_sLoad);
  assign when_StochasticConvCore_l349 = (conv1_loadStep == 5'h01);
  assign when_StochasticConvCore_l353 = (conv1_loadStep == 5'h01);
  assign when_StochasticConvCore_l353_1 = (conv1_loadStep == 5'h02);
  assign when_StochasticConvCore_l353_2 = (conv1_loadStep == 5'h03);
  assign when_StochasticConvCore_l353_3 = (conv1_loadStep == 5'h04);
  assign when_StochasticConvCore_l353_4 = (conv1_loadStep == 5'h05);
  assign when_StochasticConvCore_l353_5 = (conv1_loadStep == 5'h06);
  assign when_StochasticConvCore_l353_6 = (conv1_loadStep == 5'h07);
  assign when_StochasticConvCore_l353_7 = (conv1_loadStep == 5'h08);
  assign when_StochasticConvCore_l353_8 = (conv1_loadStep == 5'h09);
  assign when_StochasticConvCore_l353_9 = (conv1_loadStep == 5'h0a);
  assign when_StochasticConvCore_l353_10 = (conv1_loadStep == 5'h0b);
  assign when_StochasticConvCore_l353_11 = (conv1_loadStep == 5'h0c);
  assign when_StochasticConvCore_l353_12 = (conv1_loadStep == 5'h0d);
  assign when_StochasticConvCore_l353_13 = (conv1_loadStep == 5'h0e);
  assign when_StochasticConvCore_l353_14 = (conv1_loadStep == 5'h0f);
  assign when_StochasticConvCore_l353_15 = (conv1_loadStep == 5'h10);
  assign when_StochasticConvCore_l353_16 = (conv1_loadStep == 5'h11);
  assign when_StochasticConvCore_l353_17 = (conv1_loadStep == 5'h12);
  assign when_StochasticConvCore_l353_18 = (conv1_loadStep == 5'h13);
  assign when_StochasticConvCore_l353_19 = (conv1_loadStep == 5'h14);
  assign when_StochasticConvCore_l353_20 = (conv1_loadStep == 5'h15);
  assign when_StochasticConvCore_l353_21 = (conv1_loadStep == 5'h16);
  assign when_StochasticConvCore_l353_22 = (conv1_loadStep == 5'h17);
  assign when_StochasticConvCore_l353_23 = (conv1_loadStep == 5'h18);
  assign when_StochasticConvCore_l353_24 = (conv1_loadStep == 5'h19);
  assign when_StochasticConvCore_l361 = (conv1_loadStep == 5'h19);
  assign when_StochasticConvCore_l373 = (conv1_state == conv1_sSC);
  assign when_StochasticConvCore_l376 = (conv1_scStep == 8'hfe);
  assign when_StochasticConvCore_l387 = (conv1_state == conv1_sDecode);
  assign _zz_conv1_activationOut_payload_value = ($signed(_zz__zz_conv1_activationOut_payload_value) + $signed(27'h0));
  assign conv1_activationOut_fire = (conv1_activationOut_valid && conv1_activationOut_ready);
  assign when_StochasticConvCore_l408 = (conv1_ocReg == 4'b0111);
  assign when_StochasticConvCore_l410 = (conv1_outWReg == 5'h1b);
  assign _zz_conv1_state = (conv1_outHReg == 5'h1b);
  assign StochasticConvPlugin_logic_outStream_valid = conv1_activationOut_valid;
  assign conv1_activationOut_ready = StochasticConvPlugin_logic_outStream_ready;
  assign StochasticConvPlugin_logic_outStream_payload_value = conv1_activationOut_payload_value;
  assign relu1_activationOut_valid = StochasticConvPlugin_logic_outStream_valid;
  assign StochasticConvPlugin_logic_outStream_ready = relu1_activationOut_ready;
  assign relu1_activationOut_payload_value = (($signed(StochasticConvPlugin_logic_outStream_payload_value) < $signed(8'h0)) ? 8'h0 : _zz_relu1_activationOut_payload_value);
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
  assign conv2_sRx = 3'b000;
  assign conv2_sInit = 3'b001;
  assign conv2_sLoad = 3'b010;
  assign conv2_sSC = 3'b011;
  assign conv2_sDecode = 3'b100;
  assign _zz_conv2_posBitRegs_0 = ((conv2_wLfsrChain_0 < conv2_wThrRegs_0) && (conv2_aLfsrChain_0 < conv2_activThresh_0));
  assign _zz_conv2_posBitRegs_1 = ((conv2_wLfsrChain_1 < conv2_wThrRegs_1) && (conv2_aLfsrChain_1 < conv2_activThresh_1));
  assign _zz_conv2_posBitRegs_2 = ((conv2_wLfsrChain_2 < conv2_wThrRegs_2) && (conv2_aLfsrChain_2 < conv2_activThresh_2));
  assign _zz_conv2_posBitRegs_3 = ((conv2_wLfsrChain_3 < conv2_wThrRegs_3) && (conv2_aLfsrChain_3 < conv2_activThresh_3));
  assign _zz_conv2_posBitRegs_4 = ((conv2_wLfsrChain_4 < conv2_wThrRegs_4) && (conv2_aLfsrChain_4 < conv2_activThresh_4));
  assign _zz_conv2_posBitRegs_5 = ((conv2_wLfsrChain_5 < conv2_wThrRegs_5) && (conv2_aLfsrChain_5 < conv2_activThresh_5));
  assign _zz_conv2_posBitRegs_6 = ((conv2_wLfsrChain_6 < conv2_wThrRegs_6) && (conv2_aLfsrChain_6 < conv2_activThresh_6));
  assign _zz_conv2_posBitRegs_7 = ((conv2_wLfsrChain_7 < conv2_wThrRegs_7) && (conv2_aLfsrChain_7 < conv2_activThresh_7));
  assign _zz_conv2_posBitRegs_8 = ((conv2_wLfsrChain_8 < conv2_wThrRegs_8) && (conv2_aLfsrChain_8 < conv2_activThresh_8));
  assign _zz_conv2_posBitRegs_9 = ((conv2_wLfsrChain_9 < conv2_wThrRegs_9) && (conv2_aLfsrChain_9 < conv2_activThresh_9));
  assign _zz_conv2_posBitRegs_10 = ((conv2_wLfsrChain_10 < conv2_wThrRegs_10) && (conv2_aLfsrChain_10 < conv2_activThresh_10));
  assign _zz_conv2_posBitRegs_11 = ((conv2_wLfsrChain_11 < conv2_wThrRegs_11) && (conv2_aLfsrChain_11 < conv2_activThresh_11));
  assign _zz_conv2_posBitRegs_12 = ((conv2_wLfsrChain_12 < conv2_wThrRegs_12) && (conv2_aLfsrChain_12 < conv2_activThresh_12));
  assign _zz_conv2_posBitRegs_13 = ((conv2_wLfsrChain_13 < conv2_wThrRegs_13) && (conv2_aLfsrChain_13 < conv2_activThresh_13));
  assign _zz_conv2_posBitRegs_14 = ((conv2_wLfsrChain_14 < conv2_wThrRegs_14) && (conv2_aLfsrChain_14 < conv2_activThresh_14));
  assign _zz_conv2_posBitRegs_15 = ((conv2_wLfsrChain_15 < conv2_wThrRegs_15) && (conv2_aLfsrChain_15 < conv2_activThresh_15));
  assign _zz_conv2_posBitRegs_16 = ((conv2_wLfsrChain_16 < conv2_wThrRegs_16) && (conv2_aLfsrChain_16 < conv2_activThresh_16));
  assign _zz_conv2_posBitRegs_17 = ((conv2_wLfsrChain_17 < conv2_wThrRegs_17) && (conv2_aLfsrChain_17 < conv2_activThresh_17));
  assign _zz_conv2_posBitRegs_18 = ((conv2_wLfsrChain_18 < conv2_wThrRegs_18) && (conv2_aLfsrChain_18 < conv2_activThresh_18));
  assign _zz_conv2_posBitRegs_19 = ((conv2_wLfsrChain_19 < conv2_wThrRegs_19) && (conv2_aLfsrChain_19 < conv2_activThresh_19));
  assign _zz_conv2_posBitRegs_20 = ((conv2_wLfsrChain_20 < conv2_wThrRegs_20) && (conv2_aLfsrChain_20 < conv2_activThresh_20));
  assign _zz_conv2_posBitRegs_21 = ((conv2_wLfsrChain_21 < conv2_wThrRegs_21) && (conv2_aLfsrChain_21 < conv2_activThresh_21));
  assign _zz_conv2_posBitRegs_22 = ((conv2_wLfsrChain_22 < conv2_wThrRegs_22) && (conv2_aLfsrChain_22 < conv2_activThresh_22));
  assign _zz_conv2_posBitRegs_23 = ((conv2_wLfsrChain_23 < conv2_wThrRegs_23) && (conv2_aLfsrChain_23 < conv2_activThresh_23));
  assign _zz_conv2_posBitRegs_24 = ((conv2_wLfsrChain_24 < conv2_wThrRegs_24) && (conv2_aLfsrChain_24 < conv2_activThresh_24));
  assign _zz_conv2_posBitRegs_25 = ((conv2_wLfsrChain_25 < conv2_wThrRegs_25) && (conv2_aLfsrChain_25 < conv2_activThresh_25));
  assign _zz_conv2_posBitRegs_26 = ((conv2_wLfsrChain_26 < conv2_wThrRegs_26) && (conv2_aLfsrChain_26 < conv2_activThresh_26));
  assign _zz_conv2_posBitRegs_27 = ((conv2_wLfsrChain_27 < conv2_wThrRegs_27) && (conv2_aLfsrChain_27 < conv2_activThresh_27));
  assign _zz_conv2_posBitRegs_28 = ((conv2_wLfsrChain_28 < conv2_wThrRegs_28) && (conv2_aLfsrChain_28 < conv2_activThresh_28));
  assign _zz_conv2_posBitRegs_29 = ((conv2_wLfsrChain_29 < conv2_wThrRegs_29) && (conv2_aLfsrChain_29 < conv2_activThresh_29));
  assign _zz_conv2_posBitRegs_30 = ((conv2_wLfsrChain_30 < conv2_wThrRegs_30) && (conv2_aLfsrChain_30 < conv2_activThresh_30));
  assign _zz_conv2_posBitRegs_31 = ((conv2_wLfsrChain_31 < conv2_wThrRegs_31) && (conv2_aLfsrChain_31 < conv2_activThresh_31));
  assign _zz_conv2_posBitRegs_32 = ((conv2_wLfsrChain_32 < conv2_wThrRegs_32) && (conv2_aLfsrChain_32 < conv2_activThresh_32));
  assign _zz_conv2_posBitRegs_33 = ((conv2_wLfsrChain_33 < conv2_wThrRegs_33) && (conv2_aLfsrChain_33 < conv2_activThresh_33));
  assign _zz_conv2_posBitRegs_34 = ((conv2_wLfsrChain_34 < conv2_wThrRegs_34) && (conv2_aLfsrChain_34 < conv2_activThresh_34));
  assign _zz_conv2_posBitRegs_35 = ((conv2_wLfsrChain_35 < conv2_wThrRegs_35) && (conv2_aLfsrChain_35 < conv2_activThresh_35));
  assign _zz_conv2_posBitRegs_36 = ((conv2_wLfsrChain_36 < conv2_wThrRegs_36) && (conv2_aLfsrChain_36 < conv2_activThresh_36));
  assign _zz_conv2_posBitRegs_37 = ((conv2_wLfsrChain_37 < conv2_wThrRegs_37) && (conv2_aLfsrChain_37 < conv2_activThresh_37));
  assign _zz_conv2_posBitRegs_38 = ((conv2_wLfsrChain_38 < conv2_wThrRegs_38) && (conv2_aLfsrChain_38 < conv2_activThresh_38));
  assign _zz_conv2_posBitRegs_39 = ((conv2_wLfsrChain_39 < conv2_wThrRegs_39) && (conv2_aLfsrChain_39 < conv2_activThresh_39));
  assign _zz_conv2_posBitRegs_40 = ((conv2_wLfsrChain_40 < conv2_wThrRegs_40) && (conv2_aLfsrChain_40 < conv2_activThresh_40));
  assign _zz_conv2_posBitRegs_41 = ((conv2_wLfsrChain_41 < conv2_wThrRegs_41) && (conv2_aLfsrChain_41 < conv2_activThresh_41));
  assign _zz_conv2_posBitRegs_42 = ((conv2_wLfsrChain_42 < conv2_wThrRegs_42) && (conv2_aLfsrChain_42 < conv2_activThresh_42));
  assign _zz_conv2_posBitRegs_43 = ((conv2_wLfsrChain_43 < conv2_wThrRegs_43) && (conv2_aLfsrChain_43 < conv2_activThresh_43));
  assign _zz_conv2_posBitRegs_44 = ((conv2_wLfsrChain_44 < conv2_wThrRegs_44) && (conv2_aLfsrChain_44 < conv2_activThresh_44));
  assign _zz_conv2_posBitRegs_45 = ((conv2_wLfsrChain_45 < conv2_wThrRegs_45) && (conv2_aLfsrChain_45 < conv2_activThresh_45));
  assign _zz_conv2_posBitRegs_46 = ((conv2_wLfsrChain_46 < conv2_wThrRegs_46) && (conv2_aLfsrChain_46 < conv2_activThresh_46));
  assign _zz_conv2_posBitRegs_47 = ((conv2_wLfsrChain_47 < conv2_wThrRegs_47) && (conv2_aLfsrChain_47 < conv2_activThresh_47));
  assign _zz_conv2_posBitRegs_48 = ((conv2_wLfsrChain_48 < conv2_wThrRegs_48) && (conv2_aLfsrChain_48 < conv2_activThresh_48));
  assign _zz_conv2_posBitRegs_49 = ((conv2_wLfsrChain_49 < conv2_wThrRegs_49) && (conv2_aLfsrChain_49 < conv2_activThresh_49));
  assign _zz_conv2_posBitRegs_50 = ((conv2_wLfsrChain_50 < conv2_wThrRegs_50) && (conv2_aLfsrChain_50 < conv2_activThresh_50));
  assign _zz_conv2_posBitRegs_51 = ((conv2_wLfsrChain_51 < conv2_wThrRegs_51) && (conv2_aLfsrChain_51 < conv2_activThresh_51));
  assign _zz_conv2_posBitRegs_52 = ((conv2_wLfsrChain_52 < conv2_wThrRegs_52) && (conv2_aLfsrChain_52 < conv2_activThresh_52));
  assign _zz_conv2_posBitRegs_53 = ((conv2_wLfsrChain_53 < conv2_wThrRegs_53) && (conv2_aLfsrChain_53 < conv2_activThresh_53));
  assign _zz_conv2_posBitRegs_54 = ((conv2_wLfsrChain_54 < conv2_wThrRegs_54) && (conv2_aLfsrChain_54 < conv2_activThresh_54));
  assign _zz_conv2_posBitRegs_55 = ((conv2_wLfsrChain_55 < conv2_wThrRegs_55) && (conv2_aLfsrChain_55 < conv2_activThresh_55));
  assign _zz_conv2_posBitRegs_56 = ((conv2_wLfsrChain_56 < conv2_wThrRegs_56) && (conv2_aLfsrChain_56 < conv2_activThresh_56));
  assign _zz_conv2_posBitRegs_57 = ((conv2_wLfsrChain_57 < conv2_wThrRegs_57) && (conv2_aLfsrChain_57 < conv2_activThresh_57));
  assign _zz_conv2_posBitRegs_58 = ((conv2_wLfsrChain_58 < conv2_wThrRegs_58) && (conv2_aLfsrChain_58 < conv2_activThresh_58));
  assign _zz_conv2_posBitRegs_59 = ((conv2_wLfsrChain_59 < conv2_wThrRegs_59) && (conv2_aLfsrChain_59 < conv2_activThresh_59));
  assign _zz_conv2_posBitRegs_60 = ((conv2_wLfsrChain_60 < conv2_wThrRegs_60) && (conv2_aLfsrChain_60 < conv2_activThresh_60));
  assign _zz_conv2_posBitRegs_61 = ((conv2_wLfsrChain_61 < conv2_wThrRegs_61) && (conv2_aLfsrChain_61 < conv2_activThresh_61));
  assign _zz_conv2_posBitRegs_62 = ((conv2_wLfsrChain_62 < conv2_wThrRegs_62) && (conv2_aLfsrChain_62 < conv2_activThresh_62));
  assign _zz_conv2_posBitRegs_63 = ((conv2_wLfsrChain_63 < conv2_wThrRegs_63) && (conv2_aLfsrChain_63 < conv2_activThresh_63));
  assign _zz_conv2_posBitRegs_64 = ((conv2_wLfsrChain_64 < conv2_wThrRegs_64) && (conv2_aLfsrChain_64 < conv2_activThresh_64));
  assign _zz_conv2_posBitRegs_65 = ((conv2_wLfsrChain_65 < conv2_wThrRegs_65) && (conv2_aLfsrChain_65 < conv2_activThresh_65));
  assign _zz_conv2_posBitRegs_66 = ((conv2_wLfsrChain_66 < conv2_wThrRegs_66) && (conv2_aLfsrChain_66 < conv2_activThresh_66));
  assign _zz_conv2_posBitRegs_67 = ((conv2_wLfsrChain_67 < conv2_wThrRegs_67) && (conv2_aLfsrChain_67 < conv2_activThresh_67));
  assign _zz_conv2_posBitRegs_68 = ((conv2_wLfsrChain_68 < conv2_wThrRegs_68) && (conv2_aLfsrChain_68 < conv2_activThresh_68));
  assign _zz_conv2_posBitRegs_69 = ((conv2_wLfsrChain_69 < conv2_wThrRegs_69) && (conv2_aLfsrChain_69 < conv2_activThresh_69));
  assign _zz_conv2_posBitRegs_70 = ((conv2_wLfsrChain_70 < conv2_wThrRegs_70) && (conv2_aLfsrChain_70 < conv2_activThresh_70));
  assign _zz_conv2_posBitRegs_71 = ((conv2_wLfsrChain_71 < conv2_wThrRegs_71) && (conv2_aLfsrChain_71 < conv2_activThresh_71));
  assign _zz_conv2_posBitRegs_72 = ((conv2_wLfsrChain_72 < conv2_wThrRegs_72) && (conv2_aLfsrChain_72 < conv2_activThresh_72));
  assign _zz_conv2_posBitRegs_73 = ((conv2_wLfsrChain_73 < conv2_wThrRegs_73) && (conv2_aLfsrChain_73 < conv2_activThresh_73));
  assign _zz_conv2_posBitRegs_74 = ((conv2_wLfsrChain_74 < conv2_wThrRegs_74) && (conv2_aLfsrChain_74 < conv2_activThresh_74));
  assign _zz_conv2_posBitRegs_75 = ((conv2_wLfsrChain_75 < conv2_wThrRegs_75) && (conv2_aLfsrChain_75 < conv2_activThresh_75));
  assign _zz_conv2_posBitRegs_76 = ((conv2_wLfsrChain_76 < conv2_wThrRegs_76) && (conv2_aLfsrChain_76 < conv2_activThresh_76));
  assign _zz_conv2_posBitRegs_77 = ((conv2_wLfsrChain_77 < conv2_wThrRegs_77) && (conv2_aLfsrChain_77 < conv2_activThresh_77));
  assign _zz_conv2_posBitRegs_78 = ((conv2_wLfsrChain_78 < conv2_wThrRegs_78) && (conv2_aLfsrChain_78 < conv2_activThresh_78));
  assign _zz_conv2_posBitRegs_79 = ((conv2_wLfsrChain_79 < conv2_wThrRegs_79) && (conv2_aLfsrChain_79 < conv2_activThresh_79));
  assign _zz_conv2_posBitRegs_80 = ((conv2_wLfsrChain_80 < conv2_wThrRegs_80) && (conv2_aLfsrChain_80 < conv2_activThresh_80));
  assign _zz_conv2_posBitRegs_81 = ((conv2_wLfsrChain_81 < conv2_wThrRegs_81) && (conv2_aLfsrChain_81 < conv2_activThresh_81));
  assign _zz_conv2_posBitRegs_82 = ((conv2_wLfsrChain_82 < conv2_wThrRegs_82) && (conv2_aLfsrChain_82 < conv2_activThresh_82));
  assign _zz_conv2_posBitRegs_83 = ((conv2_wLfsrChain_83 < conv2_wThrRegs_83) && (conv2_aLfsrChain_83 < conv2_activThresh_83));
  assign _zz_conv2_posBitRegs_84 = ((conv2_wLfsrChain_84 < conv2_wThrRegs_84) && (conv2_aLfsrChain_84 < conv2_activThresh_84));
  assign _zz_conv2_posBitRegs_85 = ((conv2_wLfsrChain_85 < conv2_wThrRegs_85) && (conv2_aLfsrChain_85 < conv2_activThresh_85));
  assign _zz_conv2_posBitRegs_86 = ((conv2_wLfsrChain_86 < conv2_wThrRegs_86) && (conv2_aLfsrChain_86 < conv2_activThresh_86));
  assign _zz_conv2_posBitRegs_87 = ((conv2_wLfsrChain_87 < conv2_wThrRegs_87) && (conv2_aLfsrChain_87 < conv2_activThresh_87));
  assign _zz_conv2_posBitRegs_88 = ((conv2_wLfsrChain_88 < conv2_wThrRegs_88) && (conv2_aLfsrChain_88 < conv2_activThresh_88));
  assign _zz_conv2_posBitRegs_89 = ((conv2_wLfsrChain_89 < conv2_wThrRegs_89) && (conv2_aLfsrChain_89 < conv2_activThresh_89));
  assign _zz_conv2_posBitRegs_90 = ((conv2_wLfsrChain_90 < conv2_wThrRegs_90) && (conv2_aLfsrChain_90 < conv2_activThresh_90));
  assign _zz_conv2_posBitRegs_91 = ((conv2_wLfsrChain_91 < conv2_wThrRegs_91) && (conv2_aLfsrChain_91 < conv2_activThresh_91));
  assign _zz_conv2_posBitRegs_92 = ((conv2_wLfsrChain_92 < conv2_wThrRegs_92) && (conv2_aLfsrChain_92 < conv2_activThresh_92));
  assign _zz_conv2_posBitRegs_93 = ((conv2_wLfsrChain_93 < conv2_wThrRegs_93) && (conv2_aLfsrChain_93 < conv2_activThresh_93));
  assign _zz_conv2_posBitRegs_94 = ((conv2_wLfsrChain_94 < conv2_wThrRegs_94) && (conv2_aLfsrChain_94 < conv2_activThresh_94));
  assign _zz_conv2_posBitRegs_95 = ((conv2_wLfsrChain_95 < conv2_wThrRegs_95) && (conv2_aLfsrChain_95 < conv2_activThresh_95));
  assign _zz_conv2_posBitRegs_96 = ((conv2_wLfsrChain_96 < conv2_wThrRegs_96) && (conv2_aLfsrChain_96 < conv2_activThresh_96));
  assign _zz_conv2_posBitRegs_97 = ((conv2_wLfsrChain_97 < conv2_wThrRegs_97) && (conv2_aLfsrChain_97 < conv2_activThresh_97));
  assign _zz_conv2_posBitRegs_98 = ((conv2_wLfsrChain_98 < conv2_wThrRegs_98) && (conv2_aLfsrChain_98 < conv2_activThresh_98));
  assign _zz_conv2_posBitRegs_99 = ((conv2_wLfsrChain_99 < conv2_wThrRegs_99) && (conv2_aLfsrChain_99 < conv2_activThresh_99));
  assign _zz_conv2_posBitRegs_100 = ((conv2_wLfsrChain_100 < conv2_wThrRegs_100) && (conv2_aLfsrChain_100 < conv2_activThresh_100));
  assign _zz_conv2_posBitRegs_101 = ((conv2_wLfsrChain_101 < conv2_wThrRegs_101) && (conv2_aLfsrChain_101 < conv2_activThresh_101));
  assign _zz_conv2_posBitRegs_102 = ((conv2_wLfsrChain_102 < conv2_wThrRegs_102) && (conv2_aLfsrChain_102 < conv2_activThresh_102));
  assign _zz_conv2_posBitRegs_103 = ((conv2_wLfsrChain_103 < conv2_wThrRegs_103) && (conv2_aLfsrChain_103 < conv2_activThresh_103));
  assign _zz_conv2_posBitRegs_104 = ((conv2_wLfsrChain_104 < conv2_wThrRegs_104) && (conv2_aLfsrChain_104 < conv2_activThresh_104));
  assign _zz_conv2_posBitRegs_105 = ((conv2_wLfsrChain_105 < conv2_wThrRegs_105) && (conv2_aLfsrChain_105 < conv2_activThresh_105));
  assign _zz_conv2_posBitRegs_106 = ((conv2_wLfsrChain_106 < conv2_wThrRegs_106) && (conv2_aLfsrChain_106 < conv2_activThresh_106));
  assign _zz_conv2_posBitRegs_107 = ((conv2_wLfsrChain_107 < conv2_wThrRegs_107) && (conv2_aLfsrChain_107 < conv2_activThresh_107));
  assign _zz_conv2_posBitRegs_108 = ((conv2_wLfsrChain_108 < conv2_wThrRegs_108) && (conv2_aLfsrChain_108 < conv2_activThresh_108));
  assign _zz_conv2_posBitRegs_109 = ((conv2_wLfsrChain_109 < conv2_wThrRegs_109) && (conv2_aLfsrChain_109 < conv2_activThresh_109));
  assign _zz_conv2_posBitRegs_110 = ((conv2_wLfsrChain_110 < conv2_wThrRegs_110) && (conv2_aLfsrChain_110 < conv2_activThresh_110));
  assign _zz_conv2_posBitRegs_111 = ((conv2_wLfsrChain_111 < conv2_wThrRegs_111) && (conv2_aLfsrChain_111 < conv2_activThresh_111));
  assign _zz_conv2_posBitRegs_112 = ((conv2_wLfsrChain_112 < conv2_wThrRegs_112) && (conv2_aLfsrChain_112 < conv2_activThresh_112));
  assign _zz_conv2_posBitRegs_113 = ((conv2_wLfsrChain_113 < conv2_wThrRegs_113) && (conv2_aLfsrChain_113 < conv2_activThresh_113));
  assign _zz_conv2_posBitRegs_114 = ((conv2_wLfsrChain_114 < conv2_wThrRegs_114) && (conv2_aLfsrChain_114 < conv2_activThresh_114));
  assign _zz_conv2_posBitRegs_115 = ((conv2_wLfsrChain_115 < conv2_wThrRegs_115) && (conv2_aLfsrChain_115 < conv2_activThresh_115));
  assign _zz_conv2_posBitRegs_116 = ((conv2_wLfsrChain_116 < conv2_wThrRegs_116) && (conv2_aLfsrChain_116 < conv2_activThresh_116));
  assign _zz_conv2_posBitRegs_117 = ((conv2_wLfsrChain_117 < conv2_wThrRegs_117) && (conv2_aLfsrChain_117 < conv2_activThresh_117));
  assign _zz_conv2_posBitRegs_118 = ((conv2_wLfsrChain_118 < conv2_wThrRegs_118) && (conv2_aLfsrChain_118 < conv2_activThresh_118));
  assign _zz_conv2_posBitRegs_119 = ((conv2_wLfsrChain_119 < conv2_wThrRegs_119) && (conv2_aLfsrChain_119 < conv2_activThresh_119));
  assign _zz_conv2_posBitRegs_120 = ((conv2_wLfsrChain_120 < conv2_wThrRegs_120) && (conv2_aLfsrChain_120 < conv2_activThresh_120));
  assign _zz_conv2_posBitRegs_121 = ((conv2_wLfsrChain_121 < conv2_wThrRegs_121) && (conv2_aLfsrChain_121 < conv2_activThresh_121));
  assign _zz_conv2_posBitRegs_122 = ((conv2_wLfsrChain_122 < conv2_wThrRegs_122) && (conv2_aLfsrChain_122 < conv2_activThresh_122));
  assign _zz_conv2_posBitRegs_123 = ((conv2_wLfsrChain_123 < conv2_wThrRegs_123) && (conv2_aLfsrChain_123 < conv2_activThresh_123));
  assign _zz_conv2_posBitRegs_124 = ((conv2_wLfsrChain_124 < conv2_wThrRegs_124) && (conv2_aLfsrChain_124 < conv2_activThresh_124));
  assign _zz_conv2_posBitRegs_125 = ((conv2_wLfsrChain_125 < conv2_wThrRegs_125) && (conv2_aLfsrChain_125 < conv2_activThresh_125));
  assign _zz_conv2_posBitRegs_126 = ((conv2_wLfsrChain_126 < conv2_wThrRegs_126) && (conv2_aLfsrChain_126 < conv2_activThresh_126));
  assign _zz_conv2_posBitRegs_127 = ((conv2_wLfsrChain_127 < conv2_wThrRegs_127) && (conv2_aLfsrChain_127 < conv2_activThresh_127));
  assign _zz_conv2_posBitRegs_128 = ((conv2_wLfsrChain_128 < conv2_wThrRegs_128) && (conv2_aLfsrChain_128 < conv2_activThresh_128));
  assign _zz_conv2_posBitRegs_129 = ((conv2_wLfsrChain_129 < conv2_wThrRegs_129) && (conv2_aLfsrChain_129 < conv2_activThresh_129));
  assign _zz_conv2_posBitRegs_130 = ((conv2_wLfsrChain_130 < conv2_wThrRegs_130) && (conv2_aLfsrChain_130 < conv2_activThresh_130));
  assign _zz_conv2_posBitRegs_131 = ((conv2_wLfsrChain_131 < conv2_wThrRegs_131) && (conv2_aLfsrChain_131 < conv2_activThresh_131));
  assign _zz_conv2_posBitRegs_132 = ((conv2_wLfsrChain_132 < conv2_wThrRegs_132) && (conv2_aLfsrChain_132 < conv2_activThresh_132));
  assign _zz_conv2_posBitRegs_133 = ((conv2_wLfsrChain_133 < conv2_wThrRegs_133) && (conv2_aLfsrChain_133 < conv2_activThresh_133));
  assign _zz_conv2_posBitRegs_134 = ((conv2_wLfsrChain_134 < conv2_wThrRegs_134) && (conv2_aLfsrChain_134 < conv2_activThresh_134));
  assign _zz_conv2_posBitRegs_135 = ((conv2_wLfsrChain_135 < conv2_wThrRegs_135) && (conv2_aLfsrChain_135 < conv2_activThresh_135));
  assign _zz_conv2_posBitRegs_136 = ((conv2_wLfsrChain_136 < conv2_wThrRegs_136) && (conv2_aLfsrChain_136 < conv2_activThresh_136));
  assign _zz_conv2_posBitRegs_137 = ((conv2_wLfsrChain_137 < conv2_wThrRegs_137) && (conv2_aLfsrChain_137 < conv2_activThresh_137));
  assign _zz_conv2_posBitRegs_138 = ((conv2_wLfsrChain_138 < conv2_wThrRegs_138) && (conv2_aLfsrChain_138 < conv2_activThresh_138));
  assign _zz_conv2_posBitRegs_139 = ((conv2_wLfsrChain_139 < conv2_wThrRegs_139) && (conv2_aLfsrChain_139 < conv2_activThresh_139));
  assign _zz_conv2_posBitRegs_140 = ((conv2_wLfsrChain_140 < conv2_wThrRegs_140) && (conv2_aLfsrChain_140 < conv2_activThresh_140));
  assign _zz_conv2_posBitRegs_141 = ((conv2_wLfsrChain_141 < conv2_wThrRegs_141) && (conv2_aLfsrChain_141 < conv2_activThresh_141));
  assign _zz_conv2_posBitRegs_142 = ((conv2_wLfsrChain_142 < conv2_wThrRegs_142) && (conv2_aLfsrChain_142 < conv2_activThresh_142));
  assign _zz_conv2_posBitRegs_143 = ((conv2_wLfsrChain_143 < conv2_wThrRegs_143) && (conv2_aLfsrChain_143 < conv2_activThresh_143));
  assign _zz_conv2_posBitRegs_144 = ((conv2_wLfsrChain_144 < conv2_wThrRegs_144) && (conv2_aLfsrChain_144 < conv2_activThresh_144));
  assign _zz_conv2_posBitRegs_145 = ((conv2_wLfsrChain_145 < conv2_wThrRegs_145) && (conv2_aLfsrChain_145 < conv2_activThresh_145));
  assign _zz_conv2_posBitRegs_146 = ((conv2_wLfsrChain_146 < conv2_wThrRegs_146) && (conv2_aLfsrChain_146 < conv2_activThresh_146));
  assign _zz_conv2_posBitRegs_147 = ((conv2_wLfsrChain_147 < conv2_wThrRegs_147) && (conv2_aLfsrChain_147 < conv2_activThresh_147));
  assign _zz_conv2_posBitRegs_148 = ((conv2_wLfsrChain_148 < conv2_wThrRegs_148) && (conv2_aLfsrChain_148 < conv2_activThresh_148));
  assign _zz_conv2_posBitRegs_149 = ((conv2_wLfsrChain_149 < conv2_wThrRegs_149) && (conv2_aLfsrChain_149 < conv2_activThresh_149));
  assign _zz_conv2_posBitRegs_150 = ((conv2_wLfsrChain_150 < conv2_wThrRegs_150) && (conv2_aLfsrChain_150 < conv2_activThresh_150));
  assign _zz_conv2_posBitRegs_151 = ((conv2_wLfsrChain_151 < conv2_wThrRegs_151) && (conv2_aLfsrChain_151 < conv2_activThresh_151));
  assign _zz_conv2_posBitRegs_152 = ((conv2_wLfsrChain_152 < conv2_wThrRegs_152) && (conv2_aLfsrChain_152 < conv2_activThresh_152));
  assign _zz_conv2_posBitRegs_153 = ((conv2_wLfsrChain_153 < conv2_wThrRegs_153) && (conv2_aLfsrChain_153 < conv2_activThresh_153));
  assign _zz_conv2_posBitRegs_154 = ((conv2_wLfsrChain_154 < conv2_wThrRegs_154) && (conv2_aLfsrChain_154 < conv2_activThresh_154));
  assign _zz_conv2_posBitRegs_155 = ((conv2_wLfsrChain_155 < conv2_wThrRegs_155) && (conv2_aLfsrChain_155 < conv2_activThresh_155));
  assign _zz_conv2_posBitRegs_156 = ((conv2_wLfsrChain_156 < conv2_wThrRegs_156) && (conv2_aLfsrChain_156 < conv2_activThresh_156));
  assign _zz_conv2_posBitRegs_157 = ((conv2_wLfsrChain_157 < conv2_wThrRegs_157) && (conv2_aLfsrChain_157 < conv2_activThresh_157));
  assign _zz_conv2_posBitRegs_158 = ((conv2_wLfsrChain_158 < conv2_wThrRegs_158) && (conv2_aLfsrChain_158 < conv2_activThresh_158));
  assign _zz_conv2_posBitRegs_159 = ((conv2_wLfsrChain_159 < conv2_wThrRegs_159) && (conv2_aLfsrChain_159 < conv2_activThresh_159));
  assign _zz_conv2_posBitRegs_160 = ((conv2_wLfsrChain_160 < conv2_wThrRegs_160) && (conv2_aLfsrChain_160 < conv2_activThresh_160));
  assign _zz_conv2_posBitRegs_161 = ((conv2_wLfsrChain_161 < conv2_wThrRegs_161) && (conv2_aLfsrChain_161 < conv2_activThresh_161));
  assign _zz_conv2_posBitRegs_162 = ((conv2_wLfsrChain_162 < conv2_wThrRegs_162) && (conv2_aLfsrChain_162 < conv2_activThresh_162));
  assign _zz_conv2_posBitRegs_163 = ((conv2_wLfsrChain_163 < conv2_wThrRegs_163) && (conv2_aLfsrChain_163 < conv2_activThresh_163));
  assign _zz_conv2_posBitRegs_164 = ((conv2_wLfsrChain_164 < conv2_wThrRegs_164) && (conv2_aLfsrChain_164 < conv2_activThresh_164));
  assign _zz_conv2_posBitRegs_165 = ((conv2_wLfsrChain_165 < conv2_wThrRegs_165) && (conv2_aLfsrChain_165 < conv2_activThresh_165));
  assign _zz_conv2_posBitRegs_166 = ((conv2_wLfsrChain_166 < conv2_wThrRegs_166) && (conv2_aLfsrChain_166 < conv2_activThresh_166));
  assign _zz_conv2_posBitRegs_167 = ((conv2_wLfsrChain_167 < conv2_wThrRegs_167) && (conv2_aLfsrChain_167 < conv2_activThresh_167));
  assign _zz_conv2_posBitRegs_168 = ((conv2_wLfsrChain_168 < conv2_wThrRegs_168) && (conv2_aLfsrChain_168 < conv2_activThresh_168));
  assign _zz_conv2_posBitRegs_169 = ((conv2_wLfsrChain_169 < conv2_wThrRegs_169) && (conv2_aLfsrChain_169 < conv2_activThresh_169));
  assign _zz_conv2_posBitRegs_170 = ((conv2_wLfsrChain_170 < conv2_wThrRegs_170) && (conv2_aLfsrChain_170 < conv2_activThresh_170));
  assign _zz_conv2_posBitRegs_171 = ((conv2_wLfsrChain_171 < conv2_wThrRegs_171) && (conv2_aLfsrChain_171 < conv2_activThresh_171));
  assign _zz_conv2_posBitRegs_172 = ((conv2_wLfsrChain_172 < conv2_wThrRegs_172) && (conv2_aLfsrChain_172 < conv2_activThresh_172));
  assign _zz_conv2_posBitRegs_173 = ((conv2_wLfsrChain_173 < conv2_wThrRegs_173) && (conv2_aLfsrChain_173 < conv2_activThresh_173));
  assign _zz_conv2_posBitRegs_174 = ((conv2_wLfsrChain_174 < conv2_wThrRegs_174) && (conv2_aLfsrChain_174 < conv2_activThresh_174));
  assign _zz_conv2_posBitRegs_175 = ((conv2_wLfsrChain_175 < conv2_wThrRegs_175) && (conv2_aLfsrChain_175 < conv2_activThresh_175));
  assign _zz_conv2_posBitRegs_176 = ((conv2_wLfsrChain_176 < conv2_wThrRegs_176) && (conv2_aLfsrChain_176 < conv2_activThresh_176));
  assign _zz_conv2_posBitRegs_177 = ((conv2_wLfsrChain_177 < conv2_wThrRegs_177) && (conv2_aLfsrChain_177 < conv2_activThresh_177));
  assign _zz_conv2_posBitRegs_178 = ((conv2_wLfsrChain_178 < conv2_wThrRegs_178) && (conv2_aLfsrChain_178 < conv2_activThresh_178));
  assign _zz_conv2_posBitRegs_179 = ((conv2_wLfsrChain_179 < conv2_wThrRegs_179) && (conv2_aLfsrChain_179 < conv2_activThresh_179));
  assign _zz_conv2_posBitRegs_180 = ((conv2_wLfsrChain_180 < conv2_wThrRegs_180) && (conv2_aLfsrChain_180 < conv2_activThresh_180));
  assign _zz_conv2_posBitRegs_181 = ((conv2_wLfsrChain_181 < conv2_wThrRegs_181) && (conv2_aLfsrChain_181 < conv2_activThresh_181));
  assign _zz_conv2_posBitRegs_182 = ((conv2_wLfsrChain_182 < conv2_wThrRegs_182) && (conv2_aLfsrChain_182 < conv2_activThresh_182));
  assign _zz_conv2_posBitRegs_183 = ((conv2_wLfsrChain_183 < conv2_wThrRegs_183) && (conv2_aLfsrChain_183 < conv2_activThresh_183));
  assign _zz_conv2_posBitRegs_184 = ((conv2_wLfsrChain_184 < conv2_wThrRegs_184) && (conv2_aLfsrChain_184 < conv2_activThresh_184));
  assign _zz_conv2_posBitRegs_185 = ((conv2_wLfsrChain_185 < conv2_wThrRegs_185) && (conv2_aLfsrChain_185 < conv2_activThresh_185));
  assign _zz_conv2_posBitRegs_186 = ((conv2_wLfsrChain_186 < conv2_wThrRegs_186) && (conv2_aLfsrChain_186 < conv2_activThresh_186));
  assign _zz_conv2_posBitRegs_187 = ((conv2_wLfsrChain_187 < conv2_wThrRegs_187) && (conv2_aLfsrChain_187 < conv2_activThresh_187));
  assign _zz_conv2_posBitRegs_188 = ((conv2_wLfsrChain_188 < conv2_wThrRegs_188) && (conv2_aLfsrChain_188 < conv2_activThresh_188));
  assign _zz_conv2_posBitRegs_189 = ((conv2_wLfsrChain_189 < conv2_wThrRegs_189) && (conv2_aLfsrChain_189 < conv2_activThresh_189));
  assign _zz_conv2_posBitRegs_190 = ((conv2_wLfsrChain_190 < conv2_wThrRegs_190) && (conv2_aLfsrChain_190 < conv2_activThresh_190));
  assign _zz_conv2_posBitRegs_191 = ((conv2_wLfsrChain_191 < conv2_wThrRegs_191) && (conv2_aLfsrChain_191 < conv2_activThresh_191));
  assign _zz_conv2_posBitRegs_192 = ((conv2_wLfsrChain_192 < conv2_wThrRegs_192) && (conv2_aLfsrChain_192 < conv2_activThresh_192));
  assign _zz_conv2_posBitRegs_193 = ((conv2_wLfsrChain_193 < conv2_wThrRegs_193) && (conv2_aLfsrChain_193 < conv2_activThresh_193));
  assign _zz_conv2_posBitRegs_194 = ((conv2_wLfsrChain_194 < conv2_wThrRegs_194) && (conv2_aLfsrChain_194 < conv2_activThresh_194));
  assign _zz_conv2_posBitRegs_195 = ((conv2_wLfsrChain_195 < conv2_wThrRegs_195) && (conv2_aLfsrChain_195 < conv2_activThresh_195));
  assign _zz_conv2_posBitRegs_196 = ((conv2_wLfsrChain_196 < conv2_wThrRegs_196) && (conv2_aLfsrChain_196 < conv2_activThresh_196));
  assign _zz_conv2_posBitRegs_197 = ((conv2_wLfsrChain_197 < conv2_wThrRegs_197) && (conv2_aLfsrChain_197 < conv2_activThresh_197));
  assign _zz_conv2_posBitRegs_198 = ((conv2_wLfsrChain_198 < conv2_wThrRegs_198) && (conv2_aLfsrChain_198 < conv2_activThresh_198));
  assign _zz_conv2_posBitRegs_199 = ((conv2_wLfsrChain_199 < conv2_wThrRegs_199) && (conv2_aLfsrChain_199 < conv2_activThresh_199));
  assign _zz_conv2_posCount = 8'h0;
  assign _zz_conv2_posCount_1 = 8'h01;
  assign _zz_conv2_posCount_2 = 8'h01;
  assign _zz_conv2_posCount_3 = 8'h02;
  assign _zz_conv2_posCount_4 = 8'h01;
  assign _zz_conv2_posCount_5 = 8'h02;
  assign _zz_conv2_posCount_6 = 8'h02;
  assign _zz_conv2_posCount_7 = 8'h03;
  assign conv2_posCount = _zz_conv2_posCount_8;
  assign _zz_conv2_negCount = 8'h0;
  assign _zz_conv2_negCount_1 = 8'h01;
  assign _zz_conv2_negCount_2 = 8'h01;
  assign _zz_conv2_negCount_3 = 8'h02;
  assign _zz_conv2_negCount_4 = 8'h01;
  assign _zz_conv2_negCount_5 = 8'h02;
  assign _zz_conv2_negCount_6 = 8'h02;
  assign _zz_conv2_negCount_7 = 8'h03;
  assign conv2_negCount = _zz_conv2_negCount_8;
  always @(*) begin
    conv2_activationOut_valid = 1'b0;
    if(when_StochasticConvCore_l387_1) begin
      conv2_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    conv2_activationOut_payload_value = 8'h0;
    if(when_StochasticConvCore_l387_1) begin
      conv2_activationOut_payload_value = (($signed(30'h0000007f) < $signed(_zz_conv2_activationOut_payload_value)) ? 8'h7f : _zz_conv2_activationOut_payload_value_1);
    end
  end

  always @(*) begin
    MaxPoolLinePlugin_logic_outStream_ready = 1'b0;
    if(when_StochasticConvCore_l288_1) begin
      MaxPoolLinePlugin_logic_outStream_ready = 1'b1;
    end
  end

  assign when_StochasticConvCore_l279_1 = (conv2_state == conv2_sInit);
  assign when_StochasticConvCore_l280_1 = (conv2_initAddr == 12'ha1f);
  assign when_StochasticConvCore_l288_1 = (conv2_state == conv2_sRx);
  assign MaxPoolLinePlugin_logic_outStream_fire = (MaxPoolLinePlugin_logic_outStream_valid && MaxPoolLinePlugin_logic_outStream_ready);
  assign _zz_conv2_rxAddr = (conv2_rxRow == 7'h6f);
  assign when_StochasticConvCore_l295_1 = (conv2_rxCnt == 11'h61f);
  assign when_StochasticConvCore_l315_1 = ((conv2_state == conv2_sInit) || ((conv2_state == conv2_sRx) && MaxPoolLinePlugin_logic_outStream_fire));
  assign conv2_pixelBase = (_zz_conv2_pixelBase + _zz_conv2_pixelBase_1);
  assign conv2_kOffVec_0 = 12'h0;
  assign conv2_kOffVec_1 = 12'h001;
  assign conv2_kOffVec_2 = 12'h002;
  assign conv2_kOffVec_3 = 12'h003;
  assign conv2_kOffVec_4 = 12'h004;
  assign conv2_kOffVec_5 = 12'h005;
  assign conv2_kOffVec_6 = 12'h006;
  assign conv2_kOffVec_7 = 12'h007;
  assign conv2_kOffVec_8 = 12'h008;
  assign conv2_kOffVec_9 = 12'h009;
  assign conv2_kOffVec_10 = 12'h00a;
  assign conv2_kOffVec_11 = 12'h00b;
  assign conv2_kOffVec_12 = 12'h00c;
  assign conv2_kOffVec_13 = 12'h00d;
  assign conv2_kOffVec_14 = 12'h00e;
  assign conv2_kOffVec_15 = 12'h00f;
  assign conv2_kOffVec_16 = 12'h010;
  assign conv2_kOffVec_17 = 12'h011;
  assign conv2_kOffVec_18 = 12'h012;
  assign conv2_kOffVec_19 = 12'h013;
  assign conv2_kOffVec_20 = 12'h014;
  assign conv2_kOffVec_21 = 12'h015;
  assign conv2_kOffVec_22 = 12'h016;
  assign conv2_kOffVec_23 = 12'h017;
  assign conv2_kOffVec_24 = 12'h018;
  assign conv2_kOffVec_25 = 12'h019;
  assign conv2_kOffVec_26 = 12'h01a;
  assign conv2_kOffVec_27 = 12'h01b;
  assign conv2_kOffVec_28 = 12'h01c;
  assign conv2_kOffVec_29 = 12'h01d;
  assign conv2_kOffVec_30 = 12'h01e;
  assign conv2_kOffVec_31 = 12'h01f;
  assign conv2_kOffVec_32 = 12'h020;
  assign conv2_kOffVec_33 = 12'h021;
  assign conv2_kOffVec_34 = 12'h022;
  assign conv2_kOffVec_35 = 12'h023;
  assign conv2_kOffVec_36 = 12'h024;
  assign conv2_kOffVec_37 = 12'h025;
  assign conv2_kOffVec_38 = 12'h026;
  assign conv2_kOffVec_39 = 12'h027;
  assign conv2_kOffVec_40 = 12'h090;
  assign conv2_kOffVec_41 = 12'h091;
  assign conv2_kOffVec_42 = 12'h092;
  assign conv2_kOffVec_43 = 12'h093;
  assign conv2_kOffVec_44 = 12'h094;
  assign conv2_kOffVec_45 = 12'h095;
  assign conv2_kOffVec_46 = 12'h096;
  assign conv2_kOffVec_47 = 12'h097;
  assign conv2_kOffVec_48 = 12'h098;
  assign conv2_kOffVec_49 = 12'h099;
  assign conv2_kOffVec_50 = 12'h09a;
  assign conv2_kOffVec_51 = 12'h09b;
  assign conv2_kOffVec_52 = 12'h09c;
  assign conv2_kOffVec_53 = 12'h09d;
  assign conv2_kOffVec_54 = 12'h09e;
  assign conv2_kOffVec_55 = 12'h09f;
  assign conv2_kOffVec_56 = 12'h0a0;
  assign conv2_kOffVec_57 = 12'h0a1;
  assign conv2_kOffVec_58 = 12'h0a2;
  assign conv2_kOffVec_59 = 12'h0a3;
  assign conv2_kOffVec_60 = 12'h0a4;
  assign conv2_kOffVec_61 = 12'h0a5;
  assign conv2_kOffVec_62 = 12'h0a6;
  assign conv2_kOffVec_63 = 12'h0a7;
  assign conv2_kOffVec_64 = 12'h0a8;
  assign conv2_kOffVec_65 = 12'h0a9;
  assign conv2_kOffVec_66 = 12'h0aa;
  assign conv2_kOffVec_67 = 12'h0ab;
  assign conv2_kOffVec_68 = 12'h0ac;
  assign conv2_kOffVec_69 = 12'h0ad;
  assign conv2_kOffVec_70 = 12'h0ae;
  assign conv2_kOffVec_71 = 12'h0af;
  assign conv2_kOffVec_72 = 12'h0b0;
  assign conv2_kOffVec_73 = 12'h0b1;
  assign conv2_kOffVec_74 = 12'h0b2;
  assign conv2_kOffVec_75 = 12'h0b3;
  assign conv2_kOffVec_76 = 12'h0b4;
  assign conv2_kOffVec_77 = 12'h0b5;
  assign conv2_kOffVec_78 = 12'h0b6;
  assign conv2_kOffVec_79 = 12'h0b7;
  assign conv2_kOffVec_80 = 12'h120;
  assign conv2_kOffVec_81 = 12'h121;
  assign conv2_kOffVec_82 = 12'h122;
  assign conv2_kOffVec_83 = 12'h123;
  assign conv2_kOffVec_84 = 12'h124;
  assign conv2_kOffVec_85 = 12'h125;
  assign conv2_kOffVec_86 = 12'h126;
  assign conv2_kOffVec_87 = 12'h127;
  assign conv2_kOffVec_88 = 12'h128;
  assign conv2_kOffVec_89 = 12'h129;
  assign conv2_kOffVec_90 = 12'h12a;
  assign conv2_kOffVec_91 = 12'h12b;
  assign conv2_kOffVec_92 = 12'h12c;
  assign conv2_kOffVec_93 = 12'h12d;
  assign conv2_kOffVec_94 = 12'h12e;
  assign conv2_kOffVec_95 = 12'h12f;
  assign conv2_kOffVec_96 = 12'h130;
  assign conv2_kOffVec_97 = 12'h131;
  assign conv2_kOffVec_98 = 12'h132;
  assign conv2_kOffVec_99 = 12'h133;
  assign conv2_kOffVec_100 = 12'h134;
  assign conv2_kOffVec_101 = 12'h135;
  assign conv2_kOffVec_102 = 12'h136;
  assign conv2_kOffVec_103 = 12'h137;
  assign conv2_kOffVec_104 = 12'h138;
  assign conv2_kOffVec_105 = 12'h139;
  assign conv2_kOffVec_106 = 12'h13a;
  assign conv2_kOffVec_107 = 12'h13b;
  assign conv2_kOffVec_108 = 12'h13c;
  assign conv2_kOffVec_109 = 12'h13d;
  assign conv2_kOffVec_110 = 12'h13e;
  assign conv2_kOffVec_111 = 12'h13f;
  assign conv2_kOffVec_112 = 12'h140;
  assign conv2_kOffVec_113 = 12'h141;
  assign conv2_kOffVec_114 = 12'h142;
  assign conv2_kOffVec_115 = 12'h143;
  assign conv2_kOffVec_116 = 12'h144;
  assign conv2_kOffVec_117 = 12'h145;
  assign conv2_kOffVec_118 = 12'h146;
  assign conv2_kOffVec_119 = 12'h147;
  assign conv2_kOffVec_120 = 12'h1b0;
  assign conv2_kOffVec_121 = 12'h1b1;
  assign conv2_kOffVec_122 = 12'h1b2;
  assign conv2_kOffVec_123 = 12'h1b3;
  assign conv2_kOffVec_124 = 12'h1b4;
  assign conv2_kOffVec_125 = 12'h1b5;
  assign conv2_kOffVec_126 = 12'h1b6;
  assign conv2_kOffVec_127 = 12'h1b7;
  assign conv2_kOffVec_128 = 12'h1b8;
  assign conv2_kOffVec_129 = 12'h1b9;
  assign conv2_kOffVec_130 = 12'h1ba;
  assign conv2_kOffVec_131 = 12'h1bb;
  assign conv2_kOffVec_132 = 12'h1bc;
  assign conv2_kOffVec_133 = 12'h1bd;
  assign conv2_kOffVec_134 = 12'h1be;
  assign conv2_kOffVec_135 = 12'h1bf;
  assign conv2_kOffVec_136 = 12'h1c0;
  assign conv2_kOffVec_137 = 12'h1c1;
  assign conv2_kOffVec_138 = 12'h1c2;
  assign conv2_kOffVec_139 = 12'h1c3;
  assign conv2_kOffVec_140 = 12'h1c4;
  assign conv2_kOffVec_141 = 12'h1c5;
  assign conv2_kOffVec_142 = 12'h1c6;
  assign conv2_kOffVec_143 = 12'h1c7;
  assign conv2_kOffVec_144 = 12'h1c8;
  assign conv2_kOffVec_145 = 12'h1c9;
  assign conv2_kOffVec_146 = 12'h1ca;
  assign conv2_kOffVec_147 = 12'h1cb;
  assign conv2_kOffVec_148 = 12'h1cc;
  assign conv2_kOffVec_149 = 12'h1cd;
  assign conv2_kOffVec_150 = 12'h1ce;
  assign conv2_kOffVec_151 = 12'h1cf;
  assign conv2_kOffVec_152 = 12'h1d0;
  assign conv2_kOffVec_153 = 12'h1d1;
  assign conv2_kOffVec_154 = 12'h1d2;
  assign conv2_kOffVec_155 = 12'h1d3;
  assign conv2_kOffVec_156 = 12'h1d4;
  assign conv2_kOffVec_157 = 12'h1d5;
  assign conv2_kOffVec_158 = 12'h1d6;
  assign conv2_kOffVec_159 = 12'h1d7;
  assign conv2_kOffVec_160 = 12'h240;
  assign conv2_kOffVec_161 = 12'h241;
  assign conv2_kOffVec_162 = 12'h242;
  assign conv2_kOffVec_163 = 12'h243;
  assign conv2_kOffVec_164 = 12'h244;
  assign conv2_kOffVec_165 = 12'h245;
  assign conv2_kOffVec_166 = 12'h246;
  assign conv2_kOffVec_167 = 12'h247;
  assign conv2_kOffVec_168 = 12'h248;
  assign conv2_kOffVec_169 = 12'h249;
  assign conv2_kOffVec_170 = 12'h24a;
  assign conv2_kOffVec_171 = 12'h24b;
  assign conv2_kOffVec_172 = 12'h24c;
  assign conv2_kOffVec_173 = 12'h24d;
  assign conv2_kOffVec_174 = 12'h24e;
  assign conv2_kOffVec_175 = 12'h24f;
  assign conv2_kOffVec_176 = 12'h250;
  assign conv2_kOffVec_177 = 12'h251;
  assign conv2_kOffVec_178 = 12'h252;
  assign conv2_kOffVec_179 = 12'h253;
  assign conv2_kOffVec_180 = 12'h254;
  assign conv2_kOffVec_181 = 12'h255;
  assign conv2_kOffVec_182 = 12'h256;
  assign conv2_kOffVec_183 = 12'h257;
  assign conv2_kOffVec_184 = 12'h258;
  assign conv2_kOffVec_185 = 12'h259;
  assign conv2_kOffVec_186 = 12'h25a;
  assign conv2_kOffVec_187 = 12'h25b;
  assign conv2_kOffVec_188 = 12'h25c;
  assign conv2_kOffVec_189 = 12'h25d;
  assign conv2_kOffVec_190 = 12'h25e;
  assign conv2_kOffVec_191 = 12'h25f;
  assign conv2_kOffVec_192 = 12'h260;
  assign conv2_kOffVec_193 = 12'h261;
  assign conv2_kOffVec_194 = 12'h262;
  assign conv2_kOffVec_195 = 12'h263;
  assign conv2_kOffVec_196 = 12'h264;
  assign conv2_kOffVec_197 = 12'h265;
  assign conv2_kOffVec_198 = 12'h266;
  assign conv2_kOffVec_199 = 12'h267;
  assign conv2_safeStep = ((conv2_loadStep < 8'hc8) ? conv2_loadStep : 8'hc7);
  assign conv2_actReadAddr = (conv2_pixelBase + _zz_conv2_actReadAddr);
  assign conv2_loadInRange = ((conv2_state == conv2_sLoad) && (conv2_loadStep < 8'hc8));
  assign conv2_actBufRead = conv2_actBuf_spinal_port1;
  assign _zz_conv2_wThrRead = (conv2_wAddrBase + _zz__zz_conv2_wThrRead);
  assign conv2_wThrRead = conv2_wThrRom_spinal_port0;
  assign _zz_conv2_wSignRead = (conv2_wAddrBase + _zz__zz_conv2_wSignRead);
  assign conv2_wSignRead = conv2_wSignRom_spinal_port0[0];
  assign _zz_conv2_combAdjRead = conv2_ocReg;
  assign _zz_conv2_combAdjRead_1 = ((conv2_state == conv2_sLoad) && (conv2_loadStep == 8'h0));
  assign conv2_combAdjRead = conv2_combAdjRom_spinal_port0;
  assign when_StochasticConvCore_l345_1 = (conv2_state == conv2_sLoad);
  assign when_StochasticConvCore_l349_1 = (conv2_loadStep == 8'h01);
  assign when_StochasticConvCore_l353_25 = (conv2_loadStep == 8'h01);
  assign when_StochasticConvCore_l353_26 = (conv2_loadStep == 8'h02);
  assign when_StochasticConvCore_l353_27 = (conv2_loadStep == 8'h03);
  assign when_StochasticConvCore_l353_28 = (conv2_loadStep == 8'h04);
  assign when_StochasticConvCore_l353_29 = (conv2_loadStep == 8'h05);
  assign when_StochasticConvCore_l353_30 = (conv2_loadStep == 8'h06);
  assign when_StochasticConvCore_l353_31 = (conv2_loadStep == 8'h07);
  assign when_StochasticConvCore_l353_32 = (conv2_loadStep == 8'h08);
  assign when_StochasticConvCore_l353_33 = (conv2_loadStep == 8'h09);
  assign when_StochasticConvCore_l353_34 = (conv2_loadStep == 8'h0a);
  assign when_StochasticConvCore_l353_35 = (conv2_loadStep == 8'h0b);
  assign when_StochasticConvCore_l353_36 = (conv2_loadStep == 8'h0c);
  assign when_StochasticConvCore_l353_37 = (conv2_loadStep == 8'h0d);
  assign when_StochasticConvCore_l353_38 = (conv2_loadStep == 8'h0e);
  assign when_StochasticConvCore_l353_39 = (conv2_loadStep == 8'h0f);
  assign when_StochasticConvCore_l353_40 = (conv2_loadStep == 8'h10);
  assign when_StochasticConvCore_l353_41 = (conv2_loadStep == 8'h11);
  assign when_StochasticConvCore_l353_42 = (conv2_loadStep == 8'h12);
  assign when_StochasticConvCore_l353_43 = (conv2_loadStep == 8'h13);
  assign when_StochasticConvCore_l353_44 = (conv2_loadStep == 8'h14);
  assign when_StochasticConvCore_l353_45 = (conv2_loadStep == 8'h15);
  assign when_StochasticConvCore_l353_46 = (conv2_loadStep == 8'h16);
  assign when_StochasticConvCore_l353_47 = (conv2_loadStep == 8'h17);
  assign when_StochasticConvCore_l353_48 = (conv2_loadStep == 8'h18);
  assign when_StochasticConvCore_l353_49 = (conv2_loadStep == 8'h19);
  assign when_StochasticConvCore_l353_50 = (conv2_loadStep == 8'h1a);
  assign when_StochasticConvCore_l353_51 = (conv2_loadStep == 8'h1b);
  assign when_StochasticConvCore_l353_52 = (conv2_loadStep == 8'h1c);
  assign when_StochasticConvCore_l353_53 = (conv2_loadStep == 8'h1d);
  assign when_StochasticConvCore_l353_54 = (conv2_loadStep == 8'h1e);
  assign when_StochasticConvCore_l353_55 = (conv2_loadStep == 8'h1f);
  assign when_StochasticConvCore_l353_56 = (conv2_loadStep == 8'h20);
  assign when_StochasticConvCore_l353_57 = (conv2_loadStep == 8'h21);
  assign when_StochasticConvCore_l353_58 = (conv2_loadStep == 8'h22);
  assign when_StochasticConvCore_l353_59 = (conv2_loadStep == 8'h23);
  assign when_StochasticConvCore_l353_60 = (conv2_loadStep == 8'h24);
  assign when_StochasticConvCore_l353_61 = (conv2_loadStep == 8'h25);
  assign when_StochasticConvCore_l353_62 = (conv2_loadStep == 8'h26);
  assign when_StochasticConvCore_l353_63 = (conv2_loadStep == 8'h27);
  assign when_StochasticConvCore_l353_64 = (conv2_loadStep == 8'h28);
  assign when_StochasticConvCore_l353_65 = (conv2_loadStep == 8'h29);
  assign when_StochasticConvCore_l353_66 = (conv2_loadStep == 8'h2a);
  assign when_StochasticConvCore_l353_67 = (conv2_loadStep == 8'h2b);
  assign when_StochasticConvCore_l353_68 = (conv2_loadStep == 8'h2c);
  assign when_StochasticConvCore_l353_69 = (conv2_loadStep == 8'h2d);
  assign when_StochasticConvCore_l353_70 = (conv2_loadStep == 8'h2e);
  assign when_StochasticConvCore_l353_71 = (conv2_loadStep == 8'h2f);
  assign when_StochasticConvCore_l353_72 = (conv2_loadStep == 8'h30);
  assign when_StochasticConvCore_l353_73 = (conv2_loadStep == 8'h31);
  assign when_StochasticConvCore_l353_74 = (conv2_loadStep == 8'h32);
  assign when_StochasticConvCore_l353_75 = (conv2_loadStep == 8'h33);
  assign when_StochasticConvCore_l353_76 = (conv2_loadStep == 8'h34);
  assign when_StochasticConvCore_l353_77 = (conv2_loadStep == 8'h35);
  assign when_StochasticConvCore_l353_78 = (conv2_loadStep == 8'h36);
  assign when_StochasticConvCore_l353_79 = (conv2_loadStep == 8'h37);
  assign when_StochasticConvCore_l353_80 = (conv2_loadStep == 8'h38);
  assign when_StochasticConvCore_l353_81 = (conv2_loadStep == 8'h39);
  assign when_StochasticConvCore_l353_82 = (conv2_loadStep == 8'h3a);
  assign when_StochasticConvCore_l353_83 = (conv2_loadStep == 8'h3b);
  assign when_StochasticConvCore_l353_84 = (conv2_loadStep == 8'h3c);
  assign when_StochasticConvCore_l353_85 = (conv2_loadStep == 8'h3d);
  assign when_StochasticConvCore_l353_86 = (conv2_loadStep == 8'h3e);
  assign when_StochasticConvCore_l353_87 = (conv2_loadStep == 8'h3f);
  assign when_StochasticConvCore_l353_88 = (conv2_loadStep == 8'h40);
  assign when_StochasticConvCore_l353_89 = (conv2_loadStep == 8'h41);
  assign when_StochasticConvCore_l353_90 = (conv2_loadStep == 8'h42);
  assign when_StochasticConvCore_l353_91 = (conv2_loadStep == 8'h43);
  assign when_StochasticConvCore_l353_92 = (conv2_loadStep == 8'h44);
  assign when_StochasticConvCore_l353_93 = (conv2_loadStep == 8'h45);
  assign when_StochasticConvCore_l353_94 = (conv2_loadStep == 8'h46);
  assign when_StochasticConvCore_l353_95 = (conv2_loadStep == 8'h47);
  assign when_StochasticConvCore_l353_96 = (conv2_loadStep == 8'h48);
  assign when_StochasticConvCore_l353_97 = (conv2_loadStep == 8'h49);
  assign when_StochasticConvCore_l353_98 = (conv2_loadStep == 8'h4a);
  assign when_StochasticConvCore_l353_99 = (conv2_loadStep == 8'h4b);
  assign when_StochasticConvCore_l353_100 = (conv2_loadStep == 8'h4c);
  assign when_StochasticConvCore_l353_101 = (conv2_loadStep == 8'h4d);
  assign when_StochasticConvCore_l353_102 = (conv2_loadStep == 8'h4e);
  assign when_StochasticConvCore_l353_103 = (conv2_loadStep == 8'h4f);
  assign when_StochasticConvCore_l353_104 = (conv2_loadStep == 8'h50);
  assign when_StochasticConvCore_l353_105 = (conv2_loadStep == 8'h51);
  assign when_StochasticConvCore_l353_106 = (conv2_loadStep == 8'h52);
  assign when_StochasticConvCore_l353_107 = (conv2_loadStep == 8'h53);
  assign when_StochasticConvCore_l353_108 = (conv2_loadStep == 8'h54);
  assign when_StochasticConvCore_l353_109 = (conv2_loadStep == 8'h55);
  assign when_StochasticConvCore_l353_110 = (conv2_loadStep == 8'h56);
  assign when_StochasticConvCore_l353_111 = (conv2_loadStep == 8'h57);
  assign when_StochasticConvCore_l353_112 = (conv2_loadStep == 8'h58);
  assign when_StochasticConvCore_l353_113 = (conv2_loadStep == 8'h59);
  assign when_StochasticConvCore_l353_114 = (conv2_loadStep == 8'h5a);
  assign when_StochasticConvCore_l353_115 = (conv2_loadStep == 8'h5b);
  assign when_StochasticConvCore_l353_116 = (conv2_loadStep == 8'h5c);
  assign when_StochasticConvCore_l353_117 = (conv2_loadStep == 8'h5d);
  assign when_StochasticConvCore_l353_118 = (conv2_loadStep == 8'h5e);
  assign when_StochasticConvCore_l353_119 = (conv2_loadStep == 8'h5f);
  assign when_StochasticConvCore_l353_120 = (conv2_loadStep == 8'h60);
  assign when_StochasticConvCore_l353_121 = (conv2_loadStep == 8'h61);
  assign when_StochasticConvCore_l353_122 = (conv2_loadStep == 8'h62);
  assign when_StochasticConvCore_l353_123 = (conv2_loadStep == 8'h63);
  assign when_StochasticConvCore_l353_124 = (conv2_loadStep == 8'h64);
  assign when_StochasticConvCore_l353_125 = (conv2_loadStep == 8'h65);
  assign when_StochasticConvCore_l353_126 = (conv2_loadStep == 8'h66);
  assign when_StochasticConvCore_l353_127 = (conv2_loadStep == 8'h67);
  assign when_StochasticConvCore_l353_128 = (conv2_loadStep == 8'h68);
  assign when_StochasticConvCore_l353_129 = (conv2_loadStep == 8'h69);
  assign when_StochasticConvCore_l353_130 = (conv2_loadStep == 8'h6a);
  assign when_StochasticConvCore_l353_131 = (conv2_loadStep == 8'h6b);
  assign when_StochasticConvCore_l353_132 = (conv2_loadStep == 8'h6c);
  assign when_StochasticConvCore_l353_133 = (conv2_loadStep == 8'h6d);
  assign when_StochasticConvCore_l353_134 = (conv2_loadStep == 8'h6e);
  assign when_StochasticConvCore_l353_135 = (conv2_loadStep == 8'h6f);
  assign when_StochasticConvCore_l353_136 = (conv2_loadStep == 8'h70);
  assign when_StochasticConvCore_l353_137 = (conv2_loadStep == 8'h71);
  assign when_StochasticConvCore_l353_138 = (conv2_loadStep == 8'h72);
  assign when_StochasticConvCore_l353_139 = (conv2_loadStep == 8'h73);
  assign when_StochasticConvCore_l353_140 = (conv2_loadStep == 8'h74);
  assign when_StochasticConvCore_l353_141 = (conv2_loadStep == 8'h75);
  assign when_StochasticConvCore_l353_142 = (conv2_loadStep == 8'h76);
  assign when_StochasticConvCore_l353_143 = (conv2_loadStep == 8'h77);
  assign when_StochasticConvCore_l353_144 = (conv2_loadStep == 8'h78);
  assign when_StochasticConvCore_l353_145 = (conv2_loadStep == 8'h79);
  assign when_StochasticConvCore_l353_146 = (conv2_loadStep == 8'h7a);
  assign when_StochasticConvCore_l353_147 = (conv2_loadStep == 8'h7b);
  assign when_StochasticConvCore_l353_148 = (conv2_loadStep == 8'h7c);
  assign when_StochasticConvCore_l353_149 = (conv2_loadStep == 8'h7d);
  assign when_StochasticConvCore_l353_150 = (conv2_loadStep == 8'h7e);
  assign when_StochasticConvCore_l353_151 = (conv2_loadStep == 8'h7f);
  assign when_StochasticConvCore_l353_152 = (conv2_loadStep == 8'h80);
  assign when_StochasticConvCore_l353_153 = (conv2_loadStep == 8'h81);
  assign when_StochasticConvCore_l353_154 = (conv2_loadStep == 8'h82);
  assign when_StochasticConvCore_l353_155 = (conv2_loadStep == 8'h83);
  assign when_StochasticConvCore_l353_156 = (conv2_loadStep == 8'h84);
  assign when_StochasticConvCore_l353_157 = (conv2_loadStep == 8'h85);
  assign when_StochasticConvCore_l353_158 = (conv2_loadStep == 8'h86);
  assign when_StochasticConvCore_l353_159 = (conv2_loadStep == 8'h87);
  assign when_StochasticConvCore_l353_160 = (conv2_loadStep == 8'h88);
  assign when_StochasticConvCore_l353_161 = (conv2_loadStep == 8'h89);
  assign when_StochasticConvCore_l353_162 = (conv2_loadStep == 8'h8a);
  assign when_StochasticConvCore_l353_163 = (conv2_loadStep == 8'h8b);
  assign when_StochasticConvCore_l353_164 = (conv2_loadStep == 8'h8c);
  assign when_StochasticConvCore_l353_165 = (conv2_loadStep == 8'h8d);
  assign when_StochasticConvCore_l353_166 = (conv2_loadStep == 8'h8e);
  assign when_StochasticConvCore_l353_167 = (conv2_loadStep == 8'h8f);
  assign when_StochasticConvCore_l353_168 = (conv2_loadStep == 8'h90);
  assign when_StochasticConvCore_l353_169 = (conv2_loadStep == 8'h91);
  assign when_StochasticConvCore_l353_170 = (conv2_loadStep == 8'h92);
  assign when_StochasticConvCore_l353_171 = (conv2_loadStep == 8'h93);
  assign when_StochasticConvCore_l353_172 = (conv2_loadStep == 8'h94);
  assign when_StochasticConvCore_l353_173 = (conv2_loadStep == 8'h95);
  assign when_StochasticConvCore_l353_174 = (conv2_loadStep == 8'h96);
  assign when_StochasticConvCore_l353_175 = (conv2_loadStep == 8'h97);
  assign when_StochasticConvCore_l353_176 = (conv2_loadStep == 8'h98);
  assign when_StochasticConvCore_l353_177 = (conv2_loadStep == 8'h99);
  assign when_StochasticConvCore_l353_178 = (conv2_loadStep == 8'h9a);
  assign when_StochasticConvCore_l353_179 = (conv2_loadStep == 8'h9b);
  assign when_StochasticConvCore_l353_180 = (conv2_loadStep == 8'h9c);
  assign when_StochasticConvCore_l353_181 = (conv2_loadStep == 8'h9d);
  assign when_StochasticConvCore_l353_182 = (conv2_loadStep == 8'h9e);
  assign when_StochasticConvCore_l353_183 = (conv2_loadStep == 8'h9f);
  assign when_StochasticConvCore_l353_184 = (conv2_loadStep == 8'ha0);
  assign when_StochasticConvCore_l353_185 = (conv2_loadStep == 8'ha1);
  assign when_StochasticConvCore_l353_186 = (conv2_loadStep == 8'ha2);
  assign when_StochasticConvCore_l353_187 = (conv2_loadStep == 8'ha3);
  assign when_StochasticConvCore_l353_188 = (conv2_loadStep == 8'ha4);
  assign when_StochasticConvCore_l353_189 = (conv2_loadStep == 8'ha5);
  assign when_StochasticConvCore_l353_190 = (conv2_loadStep == 8'ha6);
  assign when_StochasticConvCore_l353_191 = (conv2_loadStep == 8'ha7);
  assign when_StochasticConvCore_l353_192 = (conv2_loadStep == 8'ha8);
  assign when_StochasticConvCore_l353_193 = (conv2_loadStep == 8'ha9);
  assign when_StochasticConvCore_l353_194 = (conv2_loadStep == 8'haa);
  assign when_StochasticConvCore_l353_195 = (conv2_loadStep == 8'hab);
  assign when_StochasticConvCore_l353_196 = (conv2_loadStep == 8'hac);
  assign when_StochasticConvCore_l353_197 = (conv2_loadStep == 8'had);
  assign when_StochasticConvCore_l353_198 = (conv2_loadStep == 8'hae);
  assign when_StochasticConvCore_l353_199 = (conv2_loadStep == 8'haf);
  assign when_StochasticConvCore_l353_200 = (conv2_loadStep == 8'hb0);
  assign when_StochasticConvCore_l353_201 = (conv2_loadStep == 8'hb1);
  assign when_StochasticConvCore_l353_202 = (conv2_loadStep == 8'hb2);
  assign when_StochasticConvCore_l353_203 = (conv2_loadStep == 8'hb3);
  assign when_StochasticConvCore_l353_204 = (conv2_loadStep == 8'hb4);
  assign when_StochasticConvCore_l353_205 = (conv2_loadStep == 8'hb5);
  assign when_StochasticConvCore_l353_206 = (conv2_loadStep == 8'hb6);
  assign when_StochasticConvCore_l353_207 = (conv2_loadStep == 8'hb7);
  assign when_StochasticConvCore_l353_208 = (conv2_loadStep == 8'hb8);
  assign when_StochasticConvCore_l353_209 = (conv2_loadStep == 8'hb9);
  assign when_StochasticConvCore_l353_210 = (conv2_loadStep == 8'hba);
  assign when_StochasticConvCore_l353_211 = (conv2_loadStep == 8'hbb);
  assign when_StochasticConvCore_l353_212 = (conv2_loadStep == 8'hbc);
  assign when_StochasticConvCore_l353_213 = (conv2_loadStep == 8'hbd);
  assign when_StochasticConvCore_l353_214 = (conv2_loadStep == 8'hbe);
  assign when_StochasticConvCore_l353_215 = (conv2_loadStep == 8'hbf);
  assign when_StochasticConvCore_l353_216 = (conv2_loadStep == 8'hc0);
  assign when_StochasticConvCore_l353_217 = (conv2_loadStep == 8'hc1);
  assign when_StochasticConvCore_l353_218 = (conv2_loadStep == 8'hc2);
  assign when_StochasticConvCore_l353_219 = (conv2_loadStep == 8'hc3);
  assign when_StochasticConvCore_l353_220 = (conv2_loadStep == 8'hc4);
  assign when_StochasticConvCore_l353_221 = (conv2_loadStep == 8'hc5);
  assign when_StochasticConvCore_l353_222 = (conv2_loadStep == 8'hc6);
  assign when_StochasticConvCore_l353_223 = (conv2_loadStep == 8'hc7);
  assign when_StochasticConvCore_l353_224 = (conv2_loadStep == 8'hc8);
  assign when_StochasticConvCore_l361_1 = (conv2_loadStep == 8'hc8);
  assign when_StochasticConvCore_l373_1 = (conv2_state == conv2_sSC);
  assign when_StochasticConvCore_l376_1 = (conv2_scStep == 8'hfe);
  assign when_StochasticConvCore_l387_1 = (conv2_state == conv2_sDecode);
  assign _zz_conv2_activationOut_payload_value = ($signed(_zz__zz_conv2_activationOut_payload_value) + $signed(30'h0));
  assign conv2_activationOut_fire = (conv2_activationOut_valid && conv2_activationOut_ready);
  assign when_StochasticConvCore_l408_1 = (conv2_ocReg == 5'h0f);
  assign when_StochasticConvCore_l410_1 = (conv2_outWReg == 4'b1101);
  assign _zz_conv2_state = (conv2_outHReg == 4'b1101);
  assign StochasticConvPlugin_logic_outStream_valid_1 = conv2_activationOut_valid;
  assign conv2_activationOut_ready = StochasticConvPlugin_logic_outStream_ready_1;
  assign StochasticConvPlugin_logic_outStream_payload_value_1 = conv2_activationOut_payload_value;
  assign relu2_activationOut_valid = StochasticConvPlugin_logic_outStream_valid_1;
  assign StochasticConvPlugin_logic_outStream_ready_1 = relu2_activationOut_ready;
  assign relu2_activationOut_payload_value = (($signed(StochasticConvPlugin_logic_outStream_payload_value_1) < $signed(8'h0)) ? 8'h0 : _zz_relu2_activationOut_payload_value);
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
      conv1_state <= 3'b001;
      conv1_wRootLfsr <= 8'h01;
      conv1_aRootLfsr <= 8'h81;
      conv1_wLfsrChain_0 <= 8'h0;
      conv1_wLfsrChain_1 <= 8'h0;
      conv1_wLfsrChain_2 <= 8'h0;
      conv1_wLfsrChain_3 <= 8'h0;
      conv1_wLfsrChain_4 <= 8'h0;
      conv1_wLfsrChain_5 <= 8'h0;
      conv1_wLfsrChain_6 <= 8'h0;
      conv1_wLfsrChain_7 <= 8'h0;
      conv1_wLfsrChain_8 <= 8'h0;
      conv1_wLfsrChain_9 <= 8'h0;
      conv1_wLfsrChain_10 <= 8'h0;
      conv1_wLfsrChain_11 <= 8'h0;
      conv1_wLfsrChain_12 <= 8'h0;
      conv1_wLfsrChain_13 <= 8'h0;
      conv1_wLfsrChain_14 <= 8'h0;
      conv1_wLfsrChain_15 <= 8'h0;
      conv1_wLfsrChain_16 <= 8'h0;
      conv1_wLfsrChain_17 <= 8'h0;
      conv1_wLfsrChain_18 <= 8'h0;
      conv1_wLfsrChain_19 <= 8'h0;
      conv1_wLfsrChain_20 <= 8'h0;
      conv1_wLfsrChain_21 <= 8'h0;
      conv1_wLfsrChain_22 <= 8'h0;
      conv1_wLfsrChain_23 <= 8'h0;
      conv1_wLfsrChain_24 <= 8'h0;
      conv1_aLfsrChain_0 <= 8'h0;
      conv1_aLfsrChain_1 <= 8'h0;
      conv1_aLfsrChain_2 <= 8'h0;
      conv1_aLfsrChain_3 <= 8'h0;
      conv1_aLfsrChain_4 <= 8'h0;
      conv1_aLfsrChain_5 <= 8'h0;
      conv1_aLfsrChain_6 <= 8'h0;
      conv1_aLfsrChain_7 <= 8'h0;
      conv1_aLfsrChain_8 <= 8'h0;
      conv1_aLfsrChain_9 <= 8'h0;
      conv1_aLfsrChain_10 <= 8'h0;
      conv1_aLfsrChain_11 <= 8'h0;
      conv1_aLfsrChain_12 <= 8'h0;
      conv1_aLfsrChain_13 <= 8'h0;
      conv1_aLfsrChain_14 <= 8'h0;
      conv1_aLfsrChain_15 <= 8'h0;
      conv1_aLfsrChain_16 <= 8'h0;
      conv1_aLfsrChain_17 <= 8'h0;
      conv1_aLfsrChain_18 <= 8'h0;
      conv1_aLfsrChain_19 <= 8'h0;
      conv1_aLfsrChain_20 <= 8'h0;
      conv1_aLfsrChain_21 <= 8'h0;
      conv1_aLfsrChain_22 <= 8'h0;
      conv1_aLfsrChain_23 <= 8'h0;
      conv1_aLfsrChain_24 <= 8'h0;
      conv1_activThresh_0 <= 8'h80;
      conv1_activThresh_1 <= 8'h80;
      conv1_activThresh_2 <= 8'h80;
      conv1_activThresh_3 <= 8'h80;
      conv1_activThresh_4 <= 8'h80;
      conv1_activThresh_5 <= 8'h80;
      conv1_activThresh_6 <= 8'h80;
      conv1_activThresh_7 <= 8'h80;
      conv1_activThresh_8 <= 8'h80;
      conv1_activThresh_9 <= 8'h80;
      conv1_activThresh_10 <= 8'h80;
      conv1_activThresh_11 <= 8'h80;
      conv1_activThresh_12 <= 8'h80;
      conv1_activThresh_13 <= 8'h80;
      conv1_activThresh_14 <= 8'h80;
      conv1_activThresh_15 <= 8'h80;
      conv1_activThresh_16 <= 8'h80;
      conv1_activThresh_17 <= 8'h80;
      conv1_activThresh_18 <= 8'h80;
      conv1_activThresh_19 <= 8'h80;
      conv1_activThresh_20 <= 8'h80;
      conv1_activThresh_21 <= 8'h80;
      conv1_activThresh_22 <= 8'h80;
      conv1_activThresh_23 <= 8'h80;
      conv1_activThresh_24 <= 8'h80;
      conv1_wThrRegs_0 <= 8'h0;
      conv1_wThrRegs_1 <= 8'h0;
      conv1_wThrRegs_2 <= 8'h0;
      conv1_wThrRegs_3 <= 8'h0;
      conv1_wThrRegs_4 <= 8'h0;
      conv1_wThrRegs_5 <= 8'h0;
      conv1_wThrRegs_6 <= 8'h0;
      conv1_wThrRegs_7 <= 8'h0;
      conv1_wThrRegs_8 <= 8'h0;
      conv1_wThrRegs_9 <= 8'h0;
      conv1_wThrRegs_10 <= 8'h0;
      conv1_wThrRegs_11 <= 8'h0;
      conv1_wThrRegs_12 <= 8'h0;
      conv1_wThrRegs_13 <= 8'h0;
      conv1_wThrRegs_14 <= 8'h0;
      conv1_wThrRegs_15 <= 8'h0;
      conv1_wThrRegs_16 <= 8'h0;
      conv1_wThrRegs_17 <= 8'h0;
      conv1_wThrRegs_18 <= 8'h0;
      conv1_wThrRegs_19 <= 8'h0;
      conv1_wThrRegs_20 <= 8'h0;
      conv1_wThrRegs_21 <= 8'h0;
      conv1_wThrRegs_22 <= 8'h0;
      conv1_wThrRegs_23 <= 8'h0;
      conv1_wThrRegs_24 <= 8'h0;
      conv1_wSignRegs_0 <= 1'b1;
      conv1_wSignRegs_1 <= 1'b1;
      conv1_wSignRegs_2 <= 1'b1;
      conv1_wSignRegs_3 <= 1'b1;
      conv1_wSignRegs_4 <= 1'b1;
      conv1_wSignRegs_5 <= 1'b1;
      conv1_wSignRegs_6 <= 1'b1;
      conv1_wSignRegs_7 <= 1'b1;
      conv1_wSignRegs_8 <= 1'b1;
      conv1_wSignRegs_9 <= 1'b1;
      conv1_wSignRegs_10 <= 1'b1;
      conv1_wSignRegs_11 <= 1'b1;
      conv1_wSignRegs_12 <= 1'b1;
      conv1_wSignRegs_13 <= 1'b1;
      conv1_wSignRegs_14 <= 1'b1;
      conv1_wSignRegs_15 <= 1'b1;
      conv1_wSignRegs_16 <= 1'b1;
      conv1_wSignRegs_17 <= 1'b1;
      conv1_wSignRegs_18 <= 1'b1;
      conv1_wSignRegs_19 <= 1'b1;
      conv1_wSignRegs_20 <= 1'b1;
      conv1_wSignRegs_21 <= 1'b1;
      conv1_wSignRegs_22 <= 1'b1;
      conv1_wSignRegs_23 <= 1'b1;
      conv1_wSignRegs_24 <= 1'b1;
      conv1_scAcc <= 15'h0;
      conv1_combAdjReg <= 32'h0;
      conv1_posBitRegs_0 <= 1'b0;
      conv1_posBitRegs_1 <= 1'b0;
      conv1_posBitRegs_2 <= 1'b0;
      conv1_posBitRegs_3 <= 1'b0;
      conv1_posBitRegs_4 <= 1'b0;
      conv1_posBitRegs_5 <= 1'b0;
      conv1_posBitRegs_6 <= 1'b0;
      conv1_posBitRegs_7 <= 1'b0;
      conv1_posBitRegs_8 <= 1'b0;
      conv1_posBitRegs_9 <= 1'b0;
      conv1_posBitRegs_10 <= 1'b0;
      conv1_posBitRegs_11 <= 1'b0;
      conv1_posBitRegs_12 <= 1'b0;
      conv1_posBitRegs_13 <= 1'b0;
      conv1_posBitRegs_14 <= 1'b0;
      conv1_posBitRegs_15 <= 1'b0;
      conv1_posBitRegs_16 <= 1'b0;
      conv1_posBitRegs_17 <= 1'b0;
      conv1_posBitRegs_18 <= 1'b0;
      conv1_posBitRegs_19 <= 1'b0;
      conv1_posBitRegs_20 <= 1'b0;
      conv1_posBitRegs_21 <= 1'b0;
      conv1_posBitRegs_22 <= 1'b0;
      conv1_posBitRegs_23 <= 1'b0;
      conv1_posBitRegs_24 <= 1'b0;
      conv1_negBitRegs_0 <= 1'b0;
      conv1_negBitRegs_1 <= 1'b0;
      conv1_negBitRegs_2 <= 1'b0;
      conv1_negBitRegs_3 <= 1'b0;
      conv1_negBitRegs_4 <= 1'b0;
      conv1_negBitRegs_5 <= 1'b0;
      conv1_negBitRegs_6 <= 1'b0;
      conv1_negBitRegs_7 <= 1'b0;
      conv1_negBitRegs_8 <= 1'b0;
      conv1_negBitRegs_9 <= 1'b0;
      conv1_negBitRegs_10 <= 1'b0;
      conv1_negBitRegs_11 <= 1'b0;
      conv1_negBitRegs_12 <= 1'b0;
      conv1_negBitRegs_13 <= 1'b0;
      conv1_negBitRegs_14 <= 1'b0;
      conv1_negBitRegs_15 <= 1'b0;
      conv1_negBitRegs_16 <= 1'b0;
      conv1_negBitRegs_17 <= 1'b0;
      conv1_negBitRegs_18 <= 1'b0;
      conv1_negBitRegs_19 <= 1'b0;
      conv1_negBitRegs_20 <= 1'b0;
      conv1_negBitRegs_21 <= 1'b0;
      conv1_negBitRegs_22 <= 1'b0;
      conv1_negBitRegs_23 <= 1'b0;
      conv1_negBitRegs_24 <= 1'b0;
      conv1_rxCnt <= 10'h0;
      conv1_rxAddr <= 11'h042;
      conv1_rxRow <= 5'h0;
      conv1_ocReg <= 4'b0000;
      conv1_outHReg <= 5'h0;
      conv1_outWReg <= 5'h0;
      conv1_loadStep <= 5'h0;
      conv1_scStep <= 8'h0;
      conv1_wAddrBase <= 8'h0;
      conv1_initAddr <= 11'h0;
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
      conv2_state <= 3'b001;
      conv2_wRootLfsr <= 8'h01;
      conv2_aRootLfsr <= 8'h81;
      conv2_wLfsrChain_0 <= 8'h0;
      conv2_wLfsrChain_1 <= 8'h0;
      conv2_wLfsrChain_2 <= 8'h0;
      conv2_wLfsrChain_3 <= 8'h0;
      conv2_wLfsrChain_4 <= 8'h0;
      conv2_wLfsrChain_5 <= 8'h0;
      conv2_wLfsrChain_6 <= 8'h0;
      conv2_wLfsrChain_7 <= 8'h0;
      conv2_wLfsrChain_8 <= 8'h0;
      conv2_wLfsrChain_9 <= 8'h0;
      conv2_wLfsrChain_10 <= 8'h0;
      conv2_wLfsrChain_11 <= 8'h0;
      conv2_wLfsrChain_12 <= 8'h0;
      conv2_wLfsrChain_13 <= 8'h0;
      conv2_wLfsrChain_14 <= 8'h0;
      conv2_wLfsrChain_15 <= 8'h0;
      conv2_wLfsrChain_16 <= 8'h0;
      conv2_wLfsrChain_17 <= 8'h0;
      conv2_wLfsrChain_18 <= 8'h0;
      conv2_wLfsrChain_19 <= 8'h0;
      conv2_wLfsrChain_20 <= 8'h0;
      conv2_wLfsrChain_21 <= 8'h0;
      conv2_wLfsrChain_22 <= 8'h0;
      conv2_wLfsrChain_23 <= 8'h0;
      conv2_wLfsrChain_24 <= 8'h0;
      conv2_wLfsrChain_25 <= 8'h0;
      conv2_wLfsrChain_26 <= 8'h0;
      conv2_wLfsrChain_27 <= 8'h0;
      conv2_wLfsrChain_28 <= 8'h0;
      conv2_wLfsrChain_29 <= 8'h0;
      conv2_wLfsrChain_30 <= 8'h0;
      conv2_wLfsrChain_31 <= 8'h0;
      conv2_wLfsrChain_32 <= 8'h0;
      conv2_wLfsrChain_33 <= 8'h0;
      conv2_wLfsrChain_34 <= 8'h0;
      conv2_wLfsrChain_35 <= 8'h0;
      conv2_wLfsrChain_36 <= 8'h0;
      conv2_wLfsrChain_37 <= 8'h0;
      conv2_wLfsrChain_38 <= 8'h0;
      conv2_wLfsrChain_39 <= 8'h0;
      conv2_wLfsrChain_40 <= 8'h0;
      conv2_wLfsrChain_41 <= 8'h0;
      conv2_wLfsrChain_42 <= 8'h0;
      conv2_wLfsrChain_43 <= 8'h0;
      conv2_wLfsrChain_44 <= 8'h0;
      conv2_wLfsrChain_45 <= 8'h0;
      conv2_wLfsrChain_46 <= 8'h0;
      conv2_wLfsrChain_47 <= 8'h0;
      conv2_wLfsrChain_48 <= 8'h0;
      conv2_wLfsrChain_49 <= 8'h0;
      conv2_wLfsrChain_50 <= 8'h0;
      conv2_wLfsrChain_51 <= 8'h0;
      conv2_wLfsrChain_52 <= 8'h0;
      conv2_wLfsrChain_53 <= 8'h0;
      conv2_wLfsrChain_54 <= 8'h0;
      conv2_wLfsrChain_55 <= 8'h0;
      conv2_wLfsrChain_56 <= 8'h0;
      conv2_wLfsrChain_57 <= 8'h0;
      conv2_wLfsrChain_58 <= 8'h0;
      conv2_wLfsrChain_59 <= 8'h0;
      conv2_wLfsrChain_60 <= 8'h0;
      conv2_wLfsrChain_61 <= 8'h0;
      conv2_wLfsrChain_62 <= 8'h0;
      conv2_wLfsrChain_63 <= 8'h0;
      conv2_wLfsrChain_64 <= 8'h0;
      conv2_wLfsrChain_65 <= 8'h0;
      conv2_wLfsrChain_66 <= 8'h0;
      conv2_wLfsrChain_67 <= 8'h0;
      conv2_wLfsrChain_68 <= 8'h0;
      conv2_wLfsrChain_69 <= 8'h0;
      conv2_wLfsrChain_70 <= 8'h0;
      conv2_wLfsrChain_71 <= 8'h0;
      conv2_wLfsrChain_72 <= 8'h0;
      conv2_wLfsrChain_73 <= 8'h0;
      conv2_wLfsrChain_74 <= 8'h0;
      conv2_wLfsrChain_75 <= 8'h0;
      conv2_wLfsrChain_76 <= 8'h0;
      conv2_wLfsrChain_77 <= 8'h0;
      conv2_wLfsrChain_78 <= 8'h0;
      conv2_wLfsrChain_79 <= 8'h0;
      conv2_wLfsrChain_80 <= 8'h0;
      conv2_wLfsrChain_81 <= 8'h0;
      conv2_wLfsrChain_82 <= 8'h0;
      conv2_wLfsrChain_83 <= 8'h0;
      conv2_wLfsrChain_84 <= 8'h0;
      conv2_wLfsrChain_85 <= 8'h0;
      conv2_wLfsrChain_86 <= 8'h0;
      conv2_wLfsrChain_87 <= 8'h0;
      conv2_wLfsrChain_88 <= 8'h0;
      conv2_wLfsrChain_89 <= 8'h0;
      conv2_wLfsrChain_90 <= 8'h0;
      conv2_wLfsrChain_91 <= 8'h0;
      conv2_wLfsrChain_92 <= 8'h0;
      conv2_wLfsrChain_93 <= 8'h0;
      conv2_wLfsrChain_94 <= 8'h0;
      conv2_wLfsrChain_95 <= 8'h0;
      conv2_wLfsrChain_96 <= 8'h0;
      conv2_wLfsrChain_97 <= 8'h0;
      conv2_wLfsrChain_98 <= 8'h0;
      conv2_wLfsrChain_99 <= 8'h0;
      conv2_wLfsrChain_100 <= 8'h0;
      conv2_wLfsrChain_101 <= 8'h0;
      conv2_wLfsrChain_102 <= 8'h0;
      conv2_wLfsrChain_103 <= 8'h0;
      conv2_wLfsrChain_104 <= 8'h0;
      conv2_wLfsrChain_105 <= 8'h0;
      conv2_wLfsrChain_106 <= 8'h0;
      conv2_wLfsrChain_107 <= 8'h0;
      conv2_wLfsrChain_108 <= 8'h0;
      conv2_wLfsrChain_109 <= 8'h0;
      conv2_wLfsrChain_110 <= 8'h0;
      conv2_wLfsrChain_111 <= 8'h0;
      conv2_wLfsrChain_112 <= 8'h0;
      conv2_wLfsrChain_113 <= 8'h0;
      conv2_wLfsrChain_114 <= 8'h0;
      conv2_wLfsrChain_115 <= 8'h0;
      conv2_wLfsrChain_116 <= 8'h0;
      conv2_wLfsrChain_117 <= 8'h0;
      conv2_wLfsrChain_118 <= 8'h0;
      conv2_wLfsrChain_119 <= 8'h0;
      conv2_wLfsrChain_120 <= 8'h0;
      conv2_wLfsrChain_121 <= 8'h0;
      conv2_wLfsrChain_122 <= 8'h0;
      conv2_wLfsrChain_123 <= 8'h0;
      conv2_wLfsrChain_124 <= 8'h0;
      conv2_wLfsrChain_125 <= 8'h0;
      conv2_wLfsrChain_126 <= 8'h0;
      conv2_wLfsrChain_127 <= 8'h0;
      conv2_wLfsrChain_128 <= 8'h0;
      conv2_wLfsrChain_129 <= 8'h0;
      conv2_wLfsrChain_130 <= 8'h0;
      conv2_wLfsrChain_131 <= 8'h0;
      conv2_wLfsrChain_132 <= 8'h0;
      conv2_wLfsrChain_133 <= 8'h0;
      conv2_wLfsrChain_134 <= 8'h0;
      conv2_wLfsrChain_135 <= 8'h0;
      conv2_wLfsrChain_136 <= 8'h0;
      conv2_wLfsrChain_137 <= 8'h0;
      conv2_wLfsrChain_138 <= 8'h0;
      conv2_wLfsrChain_139 <= 8'h0;
      conv2_wLfsrChain_140 <= 8'h0;
      conv2_wLfsrChain_141 <= 8'h0;
      conv2_wLfsrChain_142 <= 8'h0;
      conv2_wLfsrChain_143 <= 8'h0;
      conv2_wLfsrChain_144 <= 8'h0;
      conv2_wLfsrChain_145 <= 8'h0;
      conv2_wLfsrChain_146 <= 8'h0;
      conv2_wLfsrChain_147 <= 8'h0;
      conv2_wLfsrChain_148 <= 8'h0;
      conv2_wLfsrChain_149 <= 8'h0;
      conv2_wLfsrChain_150 <= 8'h0;
      conv2_wLfsrChain_151 <= 8'h0;
      conv2_wLfsrChain_152 <= 8'h0;
      conv2_wLfsrChain_153 <= 8'h0;
      conv2_wLfsrChain_154 <= 8'h0;
      conv2_wLfsrChain_155 <= 8'h0;
      conv2_wLfsrChain_156 <= 8'h0;
      conv2_wLfsrChain_157 <= 8'h0;
      conv2_wLfsrChain_158 <= 8'h0;
      conv2_wLfsrChain_159 <= 8'h0;
      conv2_wLfsrChain_160 <= 8'h0;
      conv2_wLfsrChain_161 <= 8'h0;
      conv2_wLfsrChain_162 <= 8'h0;
      conv2_wLfsrChain_163 <= 8'h0;
      conv2_wLfsrChain_164 <= 8'h0;
      conv2_wLfsrChain_165 <= 8'h0;
      conv2_wLfsrChain_166 <= 8'h0;
      conv2_wLfsrChain_167 <= 8'h0;
      conv2_wLfsrChain_168 <= 8'h0;
      conv2_wLfsrChain_169 <= 8'h0;
      conv2_wLfsrChain_170 <= 8'h0;
      conv2_wLfsrChain_171 <= 8'h0;
      conv2_wLfsrChain_172 <= 8'h0;
      conv2_wLfsrChain_173 <= 8'h0;
      conv2_wLfsrChain_174 <= 8'h0;
      conv2_wLfsrChain_175 <= 8'h0;
      conv2_wLfsrChain_176 <= 8'h0;
      conv2_wLfsrChain_177 <= 8'h0;
      conv2_wLfsrChain_178 <= 8'h0;
      conv2_wLfsrChain_179 <= 8'h0;
      conv2_wLfsrChain_180 <= 8'h0;
      conv2_wLfsrChain_181 <= 8'h0;
      conv2_wLfsrChain_182 <= 8'h0;
      conv2_wLfsrChain_183 <= 8'h0;
      conv2_wLfsrChain_184 <= 8'h0;
      conv2_wLfsrChain_185 <= 8'h0;
      conv2_wLfsrChain_186 <= 8'h0;
      conv2_wLfsrChain_187 <= 8'h0;
      conv2_wLfsrChain_188 <= 8'h0;
      conv2_wLfsrChain_189 <= 8'h0;
      conv2_wLfsrChain_190 <= 8'h0;
      conv2_wLfsrChain_191 <= 8'h0;
      conv2_wLfsrChain_192 <= 8'h0;
      conv2_wLfsrChain_193 <= 8'h0;
      conv2_wLfsrChain_194 <= 8'h0;
      conv2_wLfsrChain_195 <= 8'h0;
      conv2_wLfsrChain_196 <= 8'h0;
      conv2_wLfsrChain_197 <= 8'h0;
      conv2_wLfsrChain_198 <= 8'h0;
      conv2_wLfsrChain_199 <= 8'h0;
      conv2_aLfsrChain_0 <= 8'h0;
      conv2_aLfsrChain_1 <= 8'h0;
      conv2_aLfsrChain_2 <= 8'h0;
      conv2_aLfsrChain_3 <= 8'h0;
      conv2_aLfsrChain_4 <= 8'h0;
      conv2_aLfsrChain_5 <= 8'h0;
      conv2_aLfsrChain_6 <= 8'h0;
      conv2_aLfsrChain_7 <= 8'h0;
      conv2_aLfsrChain_8 <= 8'h0;
      conv2_aLfsrChain_9 <= 8'h0;
      conv2_aLfsrChain_10 <= 8'h0;
      conv2_aLfsrChain_11 <= 8'h0;
      conv2_aLfsrChain_12 <= 8'h0;
      conv2_aLfsrChain_13 <= 8'h0;
      conv2_aLfsrChain_14 <= 8'h0;
      conv2_aLfsrChain_15 <= 8'h0;
      conv2_aLfsrChain_16 <= 8'h0;
      conv2_aLfsrChain_17 <= 8'h0;
      conv2_aLfsrChain_18 <= 8'h0;
      conv2_aLfsrChain_19 <= 8'h0;
      conv2_aLfsrChain_20 <= 8'h0;
      conv2_aLfsrChain_21 <= 8'h0;
      conv2_aLfsrChain_22 <= 8'h0;
      conv2_aLfsrChain_23 <= 8'h0;
      conv2_aLfsrChain_24 <= 8'h0;
      conv2_aLfsrChain_25 <= 8'h0;
      conv2_aLfsrChain_26 <= 8'h0;
      conv2_aLfsrChain_27 <= 8'h0;
      conv2_aLfsrChain_28 <= 8'h0;
      conv2_aLfsrChain_29 <= 8'h0;
      conv2_aLfsrChain_30 <= 8'h0;
      conv2_aLfsrChain_31 <= 8'h0;
      conv2_aLfsrChain_32 <= 8'h0;
      conv2_aLfsrChain_33 <= 8'h0;
      conv2_aLfsrChain_34 <= 8'h0;
      conv2_aLfsrChain_35 <= 8'h0;
      conv2_aLfsrChain_36 <= 8'h0;
      conv2_aLfsrChain_37 <= 8'h0;
      conv2_aLfsrChain_38 <= 8'h0;
      conv2_aLfsrChain_39 <= 8'h0;
      conv2_aLfsrChain_40 <= 8'h0;
      conv2_aLfsrChain_41 <= 8'h0;
      conv2_aLfsrChain_42 <= 8'h0;
      conv2_aLfsrChain_43 <= 8'h0;
      conv2_aLfsrChain_44 <= 8'h0;
      conv2_aLfsrChain_45 <= 8'h0;
      conv2_aLfsrChain_46 <= 8'h0;
      conv2_aLfsrChain_47 <= 8'h0;
      conv2_aLfsrChain_48 <= 8'h0;
      conv2_aLfsrChain_49 <= 8'h0;
      conv2_aLfsrChain_50 <= 8'h0;
      conv2_aLfsrChain_51 <= 8'h0;
      conv2_aLfsrChain_52 <= 8'h0;
      conv2_aLfsrChain_53 <= 8'h0;
      conv2_aLfsrChain_54 <= 8'h0;
      conv2_aLfsrChain_55 <= 8'h0;
      conv2_aLfsrChain_56 <= 8'h0;
      conv2_aLfsrChain_57 <= 8'h0;
      conv2_aLfsrChain_58 <= 8'h0;
      conv2_aLfsrChain_59 <= 8'h0;
      conv2_aLfsrChain_60 <= 8'h0;
      conv2_aLfsrChain_61 <= 8'h0;
      conv2_aLfsrChain_62 <= 8'h0;
      conv2_aLfsrChain_63 <= 8'h0;
      conv2_aLfsrChain_64 <= 8'h0;
      conv2_aLfsrChain_65 <= 8'h0;
      conv2_aLfsrChain_66 <= 8'h0;
      conv2_aLfsrChain_67 <= 8'h0;
      conv2_aLfsrChain_68 <= 8'h0;
      conv2_aLfsrChain_69 <= 8'h0;
      conv2_aLfsrChain_70 <= 8'h0;
      conv2_aLfsrChain_71 <= 8'h0;
      conv2_aLfsrChain_72 <= 8'h0;
      conv2_aLfsrChain_73 <= 8'h0;
      conv2_aLfsrChain_74 <= 8'h0;
      conv2_aLfsrChain_75 <= 8'h0;
      conv2_aLfsrChain_76 <= 8'h0;
      conv2_aLfsrChain_77 <= 8'h0;
      conv2_aLfsrChain_78 <= 8'h0;
      conv2_aLfsrChain_79 <= 8'h0;
      conv2_aLfsrChain_80 <= 8'h0;
      conv2_aLfsrChain_81 <= 8'h0;
      conv2_aLfsrChain_82 <= 8'h0;
      conv2_aLfsrChain_83 <= 8'h0;
      conv2_aLfsrChain_84 <= 8'h0;
      conv2_aLfsrChain_85 <= 8'h0;
      conv2_aLfsrChain_86 <= 8'h0;
      conv2_aLfsrChain_87 <= 8'h0;
      conv2_aLfsrChain_88 <= 8'h0;
      conv2_aLfsrChain_89 <= 8'h0;
      conv2_aLfsrChain_90 <= 8'h0;
      conv2_aLfsrChain_91 <= 8'h0;
      conv2_aLfsrChain_92 <= 8'h0;
      conv2_aLfsrChain_93 <= 8'h0;
      conv2_aLfsrChain_94 <= 8'h0;
      conv2_aLfsrChain_95 <= 8'h0;
      conv2_aLfsrChain_96 <= 8'h0;
      conv2_aLfsrChain_97 <= 8'h0;
      conv2_aLfsrChain_98 <= 8'h0;
      conv2_aLfsrChain_99 <= 8'h0;
      conv2_aLfsrChain_100 <= 8'h0;
      conv2_aLfsrChain_101 <= 8'h0;
      conv2_aLfsrChain_102 <= 8'h0;
      conv2_aLfsrChain_103 <= 8'h0;
      conv2_aLfsrChain_104 <= 8'h0;
      conv2_aLfsrChain_105 <= 8'h0;
      conv2_aLfsrChain_106 <= 8'h0;
      conv2_aLfsrChain_107 <= 8'h0;
      conv2_aLfsrChain_108 <= 8'h0;
      conv2_aLfsrChain_109 <= 8'h0;
      conv2_aLfsrChain_110 <= 8'h0;
      conv2_aLfsrChain_111 <= 8'h0;
      conv2_aLfsrChain_112 <= 8'h0;
      conv2_aLfsrChain_113 <= 8'h0;
      conv2_aLfsrChain_114 <= 8'h0;
      conv2_aLfsrChain_115 <= 8'h0;
      conv2_aLfsrChain_116 <= 8'h0;
      conv2_aLfsrChain_117 <= 8'h0;
      conv2_aLfsrChain_118 <= 8'h0;
      conv2_aLfsrChain_119 <= 8'h0;
      conv2_aLfsrChain_120 <= 8'h0;
      conv2_aLfsrChain_121 <= 8'h0;
      conv2_aLfsrChain_122 <= 8'h0;
      conv2_aLfsrChain_123 <= 8'h0;
      conv2_aLfsrChain_124 <= 8'h0;
      conv2_aLfsrChain_125 <= 8'h0;
      conv2_aLfsrChain_126 <= 8'h0;
      conv2_aLfsrChain_127 <= 8'h0;
      conv2_aLfsrChain_128 <= 8'h0;
      conv2_aLfsrChain_129 <= 8'h0;
      conv2_aLfsrChain_130 <= 8'h0;
      conv2_aLfsrChain_131 <= 8'h0;
      conv2_aLfsrChain_132 <= 8'h0;
      conv2_aLfsrChain_133 <= 8'h0;
      conv2_aLfsrChain_134 <= 8'h0;
      conv2_aLfsrChain_135 <= 8'h0;
      conv2_aLfsrChain_136 <= 8'h0;
      conv2_aLfsrChain_137 <= 8'h0;
      conv2_aLfsrChain_138 <= 8'h0;
      conv2_aLfsrChain_139 <= 8'h0;
      conv2_aLfsrChain_140 <= 8'h0;
      conv2_aLfsrChain_141 <= 8'h0;
      conv2_aLfsrChain_142 <= 8'h0;
      conv2_aLfsrChain_143 <= 8'h0;
      conv2_aLfsrChain_144 <= 8'h0;
      conv2_aLfsrChain_145 <= 8'h0;
      conv2_aLfsrChain_146 <= 8'h0;
      conv2_aLfsrChain_147 <= 8'h0;
      conv2_aLfsrChain_148 <= 8'h0;
      conv2_aLfsrChain_149 <= 8'h0;
      conv2_aLfsrChain_150 <= 8'h0;
      conv2_aLfsrChain_151 <= 8'h0;
      conv2_aLfsrChain_152 <= 8'h0;
      conv2_aLfsrChain_153 <= 8'h0;
      conv2_aLfsrChain_154 <= 8'h0;
      conv2_aLfsrChain_155 <= 8'h0;
      conv2_aLfsrChain_156 <= 8'h0;
      conv2_aLfsrChain_157 <= 8'h0;
      conv2_aLfsrChain_158 <= 8'h0;
      conv2_aLfsrChain_159 <= 8'h0;
      conv2_aLfsrChain_160 <= 8'h0;
      conv2_aLfsrChain_161 <= 8'h0;
      conv2_aLfsrChain_162 <= 8'h0;
      conv2_aLfsrChain_163 <= 8'h0;
      conv2_aLfsrChain_164 <= 8'h0;
      conv2_aLfsrChain_165 <= 8'h0;
      conv2_aLfsrChain_166 <= 8'h0;
      conv2_aLfsrChain_167 <= 8'h0;
      conv2_aLfsrChain_168 <= 8'h0;
      conv2_aLfsrChain_169 <= 8'h0;
      conv2_aLfsrChain_170 <= 8'h0;
      conv2_aLfsrChain_171 <= 8'h0;
      conv2_aLfsrChain_172 <= 8'h0;
      conv2_aLfsrChain_173 <= 8'h0;
      conv2_aLfsrChain_174 <= 8'h0;
      conv2_aLfsrChain_175 <= 8'h0;
      conv2_aLfsrChain_176 <= 8'h0;
      conv2_aLfsrChain_177 <= 8'h0;
      conv2_aLfsrChain_178 <= 8'h0;
      conv2_aLfsrChain_179 <= 8'h0;
      conv2_aLfsrChain_180 <= 8'h0;
      conv2_aLfsrChain_181 <= 8'h0;
      conv2_aLfsrChain_182 <= 8'h0;
      conv2_aLfsrChain_183 <= 8'h0;
      conv2_aLfsrChain_184 <= 8'h0;
      conv2_aLfsrChain_185 <= 8'h0;
      conv2_aLfsrChain_186 <= 8'h0;
      conv2_aLfsrChain_187 <= 8'h0;
      conv2_aLfsrChain_188 <= 8'h0;
      conv2_aLfsrChain_189 <= 8'h0;
      conv2_aLfsrChain_190 <= 8'h0;
      conv2_aLfsrChain_191 <= 8'h0;
      conv2_aLfsrChain_192 <= 8'h0;
      conv2_aLfsrChain_193 <= 8'h0;
      conv2_aLfsrChain_194 <= 8'h0;
      conv2_aLfsrChain_195 <= 8'h0;
      conv2_aLfsrChain_196 <= 8'h0;
      conv2_aLfsrChain_197 <= 8'h0;
      conv2_aLfsrChain_198 <= 8'h0;
      conv2_aLfsrChain_199 <= 8'h0;
      conv2_activThresh_0 <= 8'h80;
      conv2_activThresh_1 <= 8'h80;
      conv2_activThresh_2 <= 8'h80;
      conv2_activThresh_3 <= 8'h80;
      conv2_activThresh_4 <= 8'h80;
      conv2_activThresh_5 <= 8'h80;
      conv2_activThresh_6 <= 8'h80;
      conv2_activThresh_7 <= 8'h80;
      conv2_activThresh_8 <= 8'h80;
      conv2_activThresh_9 <= 8'h80;
      conv2_activThresh_10 <= 8'h80;
      conv2_activThresh_11 <= 8'h80;
      conv2_activThresh_12 <= 8'h80;
      conv2_activThresh_13 <= 8'h80;
      conv2_activThresh_14 <= 8'h80;
      conv2_activThresh_15 <= 8'h80;
      conv2_activThresh_16 <= 8'h80;
      conv2_activThresh_17 <= 8'h80;
      conv2_activThresh_18 <= 8'h80;
      conv2_activThresh_19 <= 8'h80;
      conv2_activThresh_20 <= 8'h80;
      conv2_activThresh_21 <= 8'h80;
      conv2_activThresh_22 <= 8'h80;
      conv2_activThresh_23 <= 8'h80;
      conv2_activThresh_24 <= 8'h80;
      conv2_activThresh_25 <= 8'h80;
      conv2_activThresh_26 <= 8'h80;
      conv2_activThresh_27 <= 8'h80;
      conv2_activThresh_28 <= 8'h80;
      conv2_activThresh_29 <= 8'h80;
      conv2_activThresh_30 <= 8'h80;
      conv2_activThresh_31 <= 8'h80;
      conv2_activThresh_32 <= 8'h80;
      conv2_activThresh_33 <= 8'h80;
      conv2_activThresh_34 <= 8'h80;
      conv2_activThresh_35 <= 8'h80;
      conv2_activThresh_36 <= 8'h80;
      conv2_activThresh_37 <= 8'h80;
      conv2_activThresh_38 <= 8'h80;
      conv2_activThresh_39 <= 8'h80;
      conv2_activThresh_40 <= 8'h80;
      conv2_activThresh_41 <= 8'h80;
      conv2_activThresh_42 <= 8'h80;
      conv2_activThresh_43 <= 8'h80;
      conv2_activThresh_44 <= 8'h80;
      conv2_activThresh_45 <= 8'h80;
      conv2_activThresh_46 <= 8'h80;
      conv2_activThresh_47 <= 8'h80;
      conv2_activThresh_48 <= 8'h80;
      conv2_activThresh_49 <= 8'h80;
      conv2_activThresh_50 <= 8'h80;
      conv2_activThresh_51 <= 8'h80;
      conv2_activThresh_52 <= 8'h80;
      conv2_activThresh_53 <= 8'h80;
      conv2_activThresh_54 <= 8'h80;
      conv2_activThresh_55 <= 8'h80;
      conv2_activThresh_56 <= 8'h80;
      conv2_activThresh_57 <= 8'h80;
      conv2_activThresh_58 <= 8'h80;
      conv2_activThresh_59 <= 8'h80;
      conv2_activThresh_60 <= 8'h80;
      conv2_activThresh_61 <= 8'h80;
      conv2_activThresh_62 <= 8'h80;
      conv2_activThresh_63 <= 8'h80;
      conv2_activThresh_64 <= 8'h80;
      conv2_activThresh_65 <= 8'h80;
      conv2_activThresh_66 <= 8'h80;
      conv2_activThresh_67 <= 8'h80;
      conv2_activThresh_68 <= 8'h80;
      conv2_activThresh_69 <= 8'h80;
      conv2_activThresh_70 <= 8'h80;
      conv2_activThresh_71 <= 8'h80;
      conv2_activThresh_72 <= 8'h80;
      conv2_activThresh_73 <= 8'h80;
      conv2_activThresh_74 <= 8'h80;
      conv2_activThresh_75 <= 8'h80;
      conv2_activThresh_76 <= 8'h80;
      conv2_activThresh_77 <= 8'h80;
      conv2_activThresh_78 <= 8'h80;
      conv2_activThresh_79 <= 8'h80;
      conv2_activThresh_80 <= 8'h80;
      conv2_activThresh_81 <= 8'h80;
      conv2_activThresh_82 <= 8'h80;
      conv2_activThresh_83 <= 8'h80;
      conv2_activThresh_84 <= 8'h80;
      conv2_activThresh_85 <= 8'h80;
      conv2_activThresh_86 <= 8'h80;
      conv2_activThresh_87 <= 8'h80;
      conv2_activThresh_88 <= 8'h80;
      conv2_activThresh_89 <= 8'h80;
      conv2_activThresh_90 <= 8'h80;
      conv2_activThresh_91 <= 8'h80;
      conv2_activThresh_92 <= 8'h80;
      conv2_activThresh_93 <= 8'h80;
      conv2_activThresh_94 <= 8'h80;
      conv2_activThresh_95 <= 8'h80;
      conv2_activThresh_96 <= 8'h80;
      conv2_activThresh_97 <= 8'h80;
      conv2_activThresh_98 <= 8'h80;
      conv2_activThresh_99 <= 8'h80;
      conv2_activThresh_100 <= 8'h80;
      conv2_activThresh_101 <= 8'h80;
      conv2_activThresh_102 <= 8'h80;
      conv2_activThresh_103 <= 8'h80;
      conv2_activThresh_104 <= 8'h80;
      conv2_activThresh_105 <= 8'h80;
      conv2_activThresh_106 <= 8'h80;
      conv2_activThresh_107 <= 8'h80;
      conv2_activThresh_108 <= 8'h80;
      conv2_activThresh_109 <= 8'h80;
      conv2_activThresh_110 <= 8'h80;
      conv2_activThresh_111 <= 8'h80;
      conv2_activThresh_112 <= 8'h80;
      conv2_activThresh_113 <= 8'h80;
      conv2_activThresh_114 <= 8'h80;
      conv2_activThresh_115 <= 8'h80;
      conv2_activThresh_116 <= 8'h80;
      conv2_activThresh_117 <= 8'h80;
      conv2_activThresh_118 <= 8'h80;
      conv2_activThresh_119 <= 8'h80;
      conv2_activThresh_120 <= 8'h80;
      conv2_activThresh_121 <= 8'h80;
      conv2_activThresh_122 <= 8'h80;
      conv2_activThresh_123 <= 8'h80;
      conv2_activThresh_124 <= 8'h80;
      conv2_activThresh_125 <= 8'h80;
      conv2_activThresh_126 <= 8'h80;
      conv2_activThresh_127 <= 8'h80;
      conv2_activThresh_128 <= 8'h80;
      conv2_activThresh_129 <= 8'h80;
      conv2_activThresh_130 <= 8'h80;
      conv2_activThresh_131 <= 8'h80;
      conv2_activThresh_132 <= 8'h80;
      conv2_activThresh_133 <= 8'h80;
      conv2_activThresh_134 <= 8'h80;
      conv2_activThresh_135 <= 8'h80;
      conv2_activThresh_136 <= 8'h80;
      conv2_activThresh_137 <= 8'h80;
      conv2_activThresh_138 <= 8'h80;
      conv2_activThresh_139 <= 8'h80;
      conv2_activThresh_140 <= 8'h80;
      conv2_activThresh_141 <= 8'h80;
      conv2_activThresh_142 <= 8'h80;
      conv2_activThresh_143 <= 8'h80;
      conv2_activThresh_144 <= 8'h80;
      conv2_activThresh_145 <= 8'h80;
      conv2_activThresh_146 <= 8'h80;
      conv2_activThresh_147 <= 8'h80;
      conv2_activThresh_148 <= 8'h80;
      conv2_activThresh_149 <= 8'h80;
      conv2_activThresh_150 <= 8'h80;
      conv2_activThresh_151 <= 8'h80;
      conv2_activThresh_152 <= 8'h80;
      conv2_activThresh_153 <= 8'h80;
      conv2_activThresh_154 <= 8'h80;
      conv2_activThresh_155 <= 8'h80;
      conv2_activThresh_156 <= 8'h80;
      conv2_activThresh_157 <= 8'h80;
      conv2_activThresh_158 <= 8'h80;
      conv2_activThresh_159 <= 8'h80;
      conv2_activThresh_160 <= 8'h80;
      conv2_activThresh_161 <= 8'h80;
      conv2_activThresh_162 <= 8'h80;
      conv2_activThresh_163 <= 8'h80;
      conv2_activThresh_164 <= 8'h80;
      conv2_activThresh_165 <= 8'h80;
      conv2_activThresh_166 <= 8'h80;
      conv2_activThresh_167 <= 8'h80;
      conv2_activThresh_168 <= 8'h80;
      conv2_activThresh_169 <= 8'h80;
      conv2_activThresh_170 <= 8'h80;
      conv2_activThresh_171 <= 8'h80;
      conv2_activThresh_172 <= 8'h80;
      conv2_activThresh_173 <= 8'h80;
      conv2_activThresh_174 <= 8'h80;
      conv2_activThresh_175 <= 8'h80;
      conv2_activThresh_176 <= 8'h80;
      conv2_activThresh_177 <= 8'h80;
      conv2_activThresh_178 <= 8'h80;
      conv2_activThresh_179 <= 8'h80;
      conv2_activThresh_180 <= 8'h80;
      conv2_activThresh_181 <= 8'h80;
      conv2_activThresh_182 <= 8'h80;
      conv2_activThresh_183 <= 8'h80;
      conv2_activThresh_184 <= 8'h80;
      conv2_activThresh_185 <= 8'h80;
      conv2_activThresh_186 <= 8'h80;
      conv2_activThresh_187 <= 8'h80;
      conv2_activThresh_188 <= 8'h80;
      conv2_activThresh_189 <= 8'h80;
      conv2_activThresh_190 <= 8'h80;
      conv2_activThresh_191 <= 8'h80;
      conv2_activThresh_192 <= 8'h80;
      conv2_activThresh_193 <= 8'h80;
      conv2_activThresh_194 <= 8'h80;
      conv2_activThresh_195 <= 8'h80;
      conv2_activThresh_196 <= 8'h80;
      conv2_activThresh_197 <= 8'h80;
      conv2_activThresh_198 <= 8'h80;
      conv2_activThresh_199 <= 8'h80;
      conv2_wThrRegs_0 <= 8'h0;
      conv2_wThrRegs_1 <= 8'h0;
      conv2_wThrRegs_2 <= 8'h0;
      conv2_wThrRegs_3 <= 8'h0;
      conv2_wThrRegs_4 <= 8'h0;
      conv2_wThrRegs_5 <= 8'h0;
      conv2_wThrRegs_6 <= 8'h0;
      conv2_wThrRegs_7 <= 8'h0;
      conv2_wThrRegs_8 <= 8'h0;
      conv2_wThrRegs_9 <= 8'h0;
      conv2_wThrRegs_10 <= 8'h0;
      conv2_wThrRegs_11 <= 8'h0;
      conv2_wThrRegs_12 <= 8'h0;
      conv2_wThrRegs_13 <= 8'h0;
      conv2_wThrRegs_14 <= 8'h0;
      conv2_wThrRegs_15 <= 8'h0;
      conv2_wThrRegs_16 <= 8'h0;
      conv2_wThrRegs_17 <= 8'h0;
      conv2_wThrRegs_18 <= 8'h0;
      conv2_wThrRegs_19 <= 8'h0;
      conv2_wThrRegs_20 <= 8'h0;
      conv2_wThrRegs_21 <= 8'h0;
      conv2_wThrRegs_22 <= 8'h0;
      conv2_wThrRegs_23 <= 8'h0;
      conv2_wThrRegs_24 <= 8'h0;
      conv2_wThrRegs_25 <= 8'h0;
      conv2_wThrRegs_26 <= 8'h0;
      conv2_wThrRegs_27 <= 8'h0;
      conv2_wThrRegs_28 <= 8'h0;
      conv2_wThrRegs_29 <= 8'h0;
      conv2_wThrRegs_30 <= 8'h0;
      conv2_wThrRegs_31 <= 8'h0;
      conv2_wThrRegs_32 <= 8'h0;
      conv2_wThrRegs_33 <= 8'h0;
      conv2_wThrRegs_34 <= 8'h0;
      conv2_wThrRegs_35 <= 8'h0;
      conv2_wThrRegs_36 <= 8'h0;
      conv2_wThrRegs_37 <= 8'h0;
      conv2_wThrRegs_38 <= 8'h0;
      conv2_wThrRegs_39 <= 8'h0;
      conv2_wThrRegs_40 <= 8'h0;
      conv2_wThrRegs_41 <= 8'h0;
      conv2_wThrRegs_42 <= 8'h0;
      conv2_wThrRegs_43 <= 8'h0;
      conv2_wThrRegs_44 <= 8'h0;
      conv2_wThrRegs_45 <= 8'h0;
      conv2_wThrRegs_46 <= 8'h0;
      conv2_wThrRegs_47 <= 8'h0;
      conv2_wThrRegs_48 <= 8'h0;
      conv2_wThrRegs_49 <= 8'h0;
      conv2_wThrRegs_50 <= 8'h0;
      conv2_wThrRegs_51 <= 8'h0;
      conv2_wThrRegs_52 <= 8'h0;
      conv2_wThrRegs_53 <= 8'h0;
      conv2_wThrRegs_54 <= 8'h0;
      conv2_wThrRegs_55 <= 8'h0;
      conv2_wThrRegs_56 <= 8'h0;
      conv2_wThrRegs_57 <= 8'h0;
      conv2_wThrRegs_58 <= 8'h0;
      conv2_wThrRegs_59 <= 8'h0;
      conv2_wThrRegs_60 <= 8'h0;
      conv2_wThrRegs_61 <= 8'h0;
      conv2_wThrRegs_62 <= 8'h0;
      conv2_wThrRegs_63 <= 8'h0;
      conv2_wThrRegs_64 <= 8'h0;
      conv2_wThrRegs_65 <= 8'h0;
      conv2_wThrRegs_66 <= 8'h0;
      conv2_wThrRegs_67 <= 8'h0;
      conv2_wThrRegs_68 <= 8'h0;
      conv2_wThrRegs_69 <= 8'h0;
      conv2_wThrRegs_70 <= 8'h0;
      conv2_wThrRegs_71 <= 8'h0;
      conv2_wThrRegs_72 <= 8'h0;
      conv2_wThrRegs_73 <= 8'h0;
      conv2_wThrRegs_74 <= 8'h0;
      conv2_wThrRegs_75 <= 8'h0;
      conv2_wThrRegs_76 <= 8'h0;
      conv2_wThrRegs_77 <= 8'h0;
      conv2_wThrRegs_78 <= 8'h0;
      conv2_wThrRegs_79 <= 8'h0;
      conv2_wThrRegs_80 <= 8'h0;
      conv2_wThrRegs_81 <= 8'h0;
      conv2_wThrRegs_82 <= 8'h0;
      conv2_wThrRegs_83 <= 8'h0;
      conv2_wThrRegs_84 <= 8'h0;
      conv2_wThrRegs_85 <= 8'h0;
      conv2_wThrRegs_86 <= 8'h0;
      conv2_wThrRegs_87 <= 8'h0;
      conv2_wThrRegs_88 <= 8'h0;
      conv2_wThrRegs_89 <= 8'h0;
      conv2_wThrRegs_90 <= 8'h0;
      conv2_wThrRegs_91 <= 8'h0;
      conv2_wThrRegs_92 <= 8'h0;
      conv2_wThrRegs_93 <= 8'h0;
      conv2_wThrRegs_94 <= 8'h0;
      conv2_wThrRegs_95 <= 8'h0;
      conv2_wThrRegs_96 <= 8'h0;
      conv2_wThrRegs_97 <= 8'h0;
      conv2_wThrRegs_98 <= 8'h0;
      conv2_wThrRegs_99 <= 8'h0;
      conv2_wThrRegs_100 <= 8'h0;
      conv2_wThrRegs_101 <= 8'h0;
      conv2_wThrRegs_102 <= 8'h0;
      conv2_wThrRegs_103 <= 8'h0;
      conv2_wThrRegs_104 <= 8'h0;
      conv2_wThrRegs_105 <= 8'h0;
      conv2_wThrRegs_106 <= 8'h0;
      conv2_wThrRegs_107 <= 8'h0;
      conv2_wThrRegs_108 <= 8'h0;
      conv2_wThrRegs_109 <= 8'h0;
      conv2_wThrRegs_110 <= 8'h0;
      conv2_wThrRegs_111 <= 8'h0;
      conv2_wThrRegs_112 <= 8'h0;
      conv2_wThrRegs_113 <= 8'h0;
      conv2_wThrRegs_114 <= 8'h0;
      conv2_wThrRegs_115 <= 8'h0;
      conv2_wThrRegs_116 <= 8'h0;
      conv2_wThrRegs_117 <= 8'h0;
      conv2_wThrRegs_118 <= 8'h0;
      conv2_wThrRegs_119 <= 8'h0;
      conv2_wThrRegs_120 <= 8'h0;
      conv2_wThrRegs_121 <= 8'h0;
      conv2_wThrRegs_122 <= 8'h0;
      conv2_wThrRegs_123 <= 8'h0;
      conv2_wThrRegs_124 <= 8'h0;
      conv2_wThrRegs_125 <= 8'h0;
      conv2_wThrRegs_126 <= 8'h0;
      conv2_wThrRegs_127 <= 8'h0;
      conv2_wThrRegs_128 <= 8'h0;
      conv2_wThrRegs_129 <= 8'h0;
      conv2_wThrRegs_130 <= 8'h0;
      conv2_wThrRegs_131 <= 8'h0;
      conv2_wThrRegs_132 <= 8'h0;
      conv2_wThrRegs_133 <= 8'h0;
      conv2_wThrRegs_134 <= 8'h0;
      conv2_wThrRegs_135 <= 8'h0;
      conv2_wThrRegs_136 <= 8'h0;
      conv2_wThrRegs_137 <= 8'h0;
      conv2_wThrRegs_138 <= 8'h0;
      conv2_wThrRegs_139 <= 8'h0;
      conv2_wThrRegs_140 <= 8'h0;
      conv2_wThrRegs_141 <= 8'h0;
      conv2_wThrRegs_142 <= 8'h0;
      conv2_wThrRegs_143 <= 8'h0;
      conv2_wThrRegs_144 <= 8'h0;
      conv2_wThrRegs_145 <= 8'h0;
      conv2_wThrRegs_146 <= 8'h0;
      conv2_wThrRegs_147 <= 8'h0;
      conv2_wThrRegs_148 <= 8'h0;
      conv2_wThrRegs_149 <= 8'h0;
      conv2_wThrRegs_150 <= 8'h0;
      conv2_wThrRegs_151 <= 8'h0;
      conv2_wThrRegs_152 <= 8'h0;
      conv2_wThrRegs_153 <= 8'h0;
      conv2_wThrRegs_154 <= 8'h0;
      conv2_wThrRegs_155 <= 8'h0;
      conv2_wThrRegs_156 <= 8'h0;
      conv2_wThrRegs_157 <= 8'h0;
      conv2_wThrRegs_158 <= 8'h0;
      conv2_wThrRegs_159 <= 8'h0;
      conv2_wThrRegs_160 <= 8'h0;
      conv2_wThrRegs_161 <= 8'h0;
      conv2_wThrRegs_162 <= 8'h0;
      conv2_wThrRegs_163 <= 8'h0;
      conv2_wThrRegs_164 <= 8'h0;
      conv2_wThrRegs_165 <= 8'h0;
      conv2_wThrRegs_166 <= 8'h0;
      conv2_wThrRegs_167 <= 8'h0;
      conv2_wThrRegs_168 <= 8'h0;
      conv2_wThrRegs_169 <= 8'h0;
      conv2_wThrRegs_170 <= 8'h0;
      conv2_wThrRegs_171 <= 8'h0;
      conv2_wThrRegs_172 <= 8'h0;
      conv2_wThrRegs_173 <= 8'h0;
      conv2_wThrRegs_174 <= 8'h0;
      conv2_wThrRegs_175 <= 8'h0;
      conv2_wThrRegs_176 <= 8'h0;
      conv2_wThrRegs_177 <= 8'h0;
      conv2_wThrRegs_178 <= 8'h0;
      conv2_wThrRegs_179 <= 8'h0;
      conv2_wThrRegs_180 <= 8'h0;
      conv2_wThrRegs_181 <= 8'h0;
      conv2_wThrRegs_182 <= 8'h0;
      conv2_wThrRegs_183 <= 8'h0;
      conv2_wThrRegs_184 <= 8'h0;
      conv2_wThrRegs_185 <= 8'h0;
      conv2_wThrRegs_186 <= 8'h0;
      conv2_wThrRegs_187 <= 8'h0;
      conv2_wThrRegs_188 <= 8'h0;
      conv2_wThrRegs_189 <= 8'h0;
      conv2_wThrRegs_190 <= 8'h0;
      conv2_wThrRegs_191 <= 8'h0;
      conv2_wThrRegs_192 <= 8'h0;
      conv2_wThrRegs_193 <= 8'h0;
      conv2_wThrRegs_194 <= 8'h0;
      conv2_wThrRegs_195 <= 8'h0;
      conv2_wThrRegs_196 <= 8'h0;
      conv2_wThrRegs_197 <= 8'h0;
      conv2_wThrRegs_198 <= 8'h0;
      conv2_wThrRegs_199 <= 8'h0;
      conv2_wSignRegs_0 <= 1'b1;
      conv2_wSignRegs_1 <= 1'b1;
      conv2_wSignRegs_2 <= 1'b1;
      conv2_wSignRegs_3 <= 1'b1;
      conv2_wSignRegs_4 <= 1'b1;
      conv2_wSignRegs_5 <= 1'b1;
      conv2_wSignRegs_6 <= 1'b1;
      conv2_wSignRegs_7 <= 1'b1;
      conv2_wSignRegs_8 <= 1'b1;
      conv2_wSignRegs_9 <= 1'b1;
      conv2_wSignRegs_10 <= 1'b1;
      conv2_wSignRegs_11 <= 1'b1;
      conv2_wSignRegs_12 <= 1'b1;
      conv2_wSignRegs_13 <= 1'b1;
      conv2_wSignRegs_14 <= 1'b1;
      conv2_wSignRegs_15 <= 1'b1;
      conv2_wSignRegs_16 <= 1'b1;
      conv2_wSignRegs_17 <= 1'b1;
      conv2_wSignRegs_18 <= 1'b1;
      conv2_wSignRegs_19 <= 1'b1;
      conv2_wSignRegs_20 <= 1'b1;
      conv2_wSignRegs_21 <= 1'b1;
      conv2_wSignRegs_22 <= 1'b1;
      conv2_wSignRegs_23 <= 1'b1;
      conv2_wSignRegs_24 <= 1'b1;
      conv2_wSignRegs_25 <= 1'b1;
      conv2_wSignRegs_26 <= 1'b1;
      conv2_wSignRegs_27 <= 1'b1;
      conv2_wSignRegs_28 <= 1'b1;
      conv2_wSignRegs_29 <= 1'b1;
      conv2_wSignRegs_30 <= 1'b1;
      conv2_wSignRegs_31 <= 1'b1;
      conv2_wSignRegs_32 <= 1'b1;
      conv2_wSignRegs_33 <= 1'b1;
      conv2_wSignRegs_34 <= 1'b1;
      conv2_wSignRegs_35 <= 1'b1;
      conv2_wSignRegs_36 <= 1'b1;
      conv2_wSignRegs_37 <= 1'b1;
      conv2_wSignRegs_38 <= 1'b1;
      conv2_wSignRegs_39 <= 1'b1;
      conv2_wSignRegs_40 <= 1'b1;
      conv2_wSignRegs_41 <= 1'b1;
      conv2_wSignRegs_42 <= 1'b1;
      conv2_wSignRegs_43 <= 1'b1;
      conv2_wSignRegs_44 <= 1'b1;
      conv2_wSignRegs_45 <= 1'b1;
      conv2_wSignRegs_46 <= 1'b1;
      conv2_wSignRegs_47 <= 1'b1;
      conv2_wSignRegs_48 <= 1'b1;
      conv2_wSignRegs_49 <= 1'b1;
      conv2_wSignRegs_50 <= 1'b1;
      conv2_wSignRegs_51 <= 1'b1;
      conv2_wSignRegs_52 <= 1'b1;
      conv2_wSignRegs_53 <= 1'b1;
      conv2_wSignRegs_54 <= 1'b1;
      conv2_wSignRegs_55 <= 1'b1;
      conv2_wSignRegs_56 <= 1'b1;
      conv2_wSignRegs_57 <= 1'b1;
      conv2_wSignRegs_58 <= 1'b1;
      conv2_wSignRegs_59 <= 1'b1;
      conv2_wSignRegs_60 <= 1'b1;
      conv2_wSignRegs_61 <= 1'b1;
      conv2_wSignRegs_62 <= 1'b1;
      conv2_wSignRegs_63 <= 1'b1;
      conv2_wSignRegs_64 <= 1'b1;
      conv2_wSignRegs_65 <= 1'b1;
      conv2_wSignRegs_66 <= 1'b1;
      conv2_wSignRegs_67 <= 1'b1;
      conv2_wSignRegs_68 <= 1'b1;
      conv2_wSignRegs_69 <= 1'b1;
      conv2_wSignRegs_70 <= 1'b1;
      conv2_wSignRegs_71 <= 1'b1;
      conv2_wSignRegs_72 <= 1'b1;
      conv2_wSignRegs_73 <= 1'b1;
      conv2_wSignRegs_74 <= 1'b1;
      conv2_wSignRegs_75 <= 1'b1;
      conv2_wSignRegs_76 <= 1'b1;
      conv2_wSignRegs_77 <= 1'b1;
      conv2_wSignRegs_78 <= 1'b1;
      conv2_wSignRegs_79 <= 1'b1;
      conv2_wSignRegs_80 <= 1'b1;
      conv2_wSignRegs_81 <= 1'b1;
      conv2_wSignRegs_82 <= 1'b1;
      conv2_wSignRegs_83 <= 1'b1;
      conv2_wSignRegs_84 <= 1'b1;
      conv2_wSignRegs_85 <= 1'b1;
      conv2_wSignRegs_86 <= 1'b1;
      conv2_wSignRegs_87 <= 1'b1;
      conv2_wSignRegs_88 <= 1'b1;
      conv2_wSignRegs_89 <= 1'b1;
      conv2_wSignRegs_90 <= 1'b1;
      conv2_wSignRegs_91 <= 1'b1;
      conv2_wSignRegs_92 <= 1'b1;
      conv2_wSignRegs_93 <= 1'b1;
      conv2_wSignRegs_94 <= 1'b1;
      conv2_wSignRegs_95 <= 1'b1;
      conv2_wSignRegs_96 <= 1'b1;
      conv2_wSignRegs_97 <= 1'b1;
      conv2_wSignRegs_98 <= 1'b1;
      conv2_wSignRegs_99 <= 1'b1;
      conv2_wSignRegs_100 <= 1'b1;
      conv2_wSignRegs_101 <= 1'b1;
      conv2_wSignRegs_102 <= 1'b1;
      conv2_wSignRegs_103 <= 1'b1;
      conv2_wSignRegs_104 <= 1'b1;
      conv2_wSignRegs_105 <= 1'b1;
      conv2_wSignRegs_106 <= 1'b1;
      conv2_wSignRegs_107 <= 1'b1;
      conv2_wSignRegs_108 <= 1'b1;
      conv2_wSignRegs_109 <= 1'b1;
      conv2_wSignRegs_110 <= 1'b1;
      conv2_wSignRegs_111 <= 1'b1;
      conv2_wSignRegs_112 <= 1'b1;
      conv2_wSignRegs_113 <= 1'b1;
      conv2_wSignRegs_114 <= 1'b1;
      conv2_wSignRegs_115 <= 1'b1;
      conv2_wSignRegs_116 <= 1'b1;
      conv2_wSignRegs_117 <= 1'b1;
      conv2_wSignRegs_118 <= 1'b1;
      conv2_wSignRegs_119 <= 1'b1;
      conv2_wSignRegs_120 <= 1'b1;
      conv2_wSignRegs_121 <= 1'b1;
      conv2_wSignRegs_122 <= 1'b1;
      conv2_wSignRegs_123 <= 1'b1;
      conv2_wSignRegs_124 <= 1'b1;
      conv2_wSignRegs_125 <= 1'b1;
      conv2_wSignRegs_126 <= 1'b1;
      conv2_wSignRegs_127 <= 1'b1;
      conv2_wSignRegs_128 <= 1'b1;
      conv2_wSignRegs_129 <= 1'b1;
      conv2_wSignRegs_130 <= 1'b1;
      conv2_wSignRegs_131 <= 1'b1;
      conv2_wSignRegs_132 <= 1'b1;
      conv2_wSignRegs_133 <= 1'b1;
      conv2_wSignRegs_134 <= 1'b1;
      conv2_wSignRegs_135 <= 1'b1;
      conv2_wSignRegs_136 <= 1'b1;
      conv2_wSignRegs_137 <= 1'b1;
      conv2_wSignRegs_138 <= 1'b1;
      conv2_wSignRegs_139 <= 1'b1;
      conv2_wSignRegs_140 <= 1'b1;
      conv2_wSignRegs_141 <= 1'b1;
      conv2_wSignRegs_142 <= 1'b1;
      conv2_wSignRegs_143 <= 1'b1;
      conv2_wSignRegs_144 <= 1'b1;
      conv2_wSignRegs_145 <= 1'b1;
      conv2_wSignRegs_146 <= 1'b1;
      conv2_wSignRegs_147 <= 1'b1;
      conv2_wSignRegs_148 <= 1'b1;
      conv2_wSignRegs_149 <= 1'b1;
      conv2_wSignRegs_150 <= 1'b1;
      conv2_wSignRegs_151 <= 1'b1;
      conv2_wSignRegs_152 <= 1'b1;
      conv2_wSignRegs_153 <= 1'b1;
      conv2_wSignRegs_154 <= 1'b1;
      conv2_wSignRegs_155 <= 1'b1;
      conv2_wSignRegs_156 <= 1'b1;
      conv2_wSignRegs_157 <= 1'b1;
      conv2_wSignRegs_158 <= 1'b1;
      conv2_wSignRegs_159 <= 1'b1;
      conv2_wSignRegs_160 <= 1'b1;
      conv2_wSignRegs_161 <= 1'b1;
      conv2_wSignRegs_162 <= 1'b1;
      conv2_wSignRegs_163 <= 1'b1;
      conv2_wSignRegs_164 <= 1'b1;
      conv2_wSignRegs_165 <= 1'b1;
      conv2_wSignRegs_166 <= 1'b1;
      conv2_wSignRegs_167 <= 1'b1;
      conv2_wSignRegs_168 <= 1'b1;
      conv2_wSignRegs_169 <= 1'b1;
      conv2_wSignRegs_170 <= 1'b1;
      conv2_wSignRegs_171 <= 1'b1;
      conv2_wSignRegs_172 <= 1'b1;
      conv2_wSignRegs_173 <= 1'b1;
      conv2_wSignRegs_174 <= 1'b1;
      conv2_wSignRegs_175 <= 1'b1;
      conv2_wSignRegs_176 <= 1'b1;
      conv2_wSignRegs_177 <= 1'b1;
      conv2_wSignRegs_178 <= 1'b1;
      conv2_wSignRegs_179 <= 1'b1;
      conv2_wSignRegs_180 <= 1'b1;
      conv2_wSignRegs_181 <= 1'b1;
      conv2_wSignRegs_182 <= 1'b1;
      conv2_wSignRegs_183 <= 1'b1;
      conv2_wSignRegs_184 <= 1'b1;
      conv2_wSignRegs_185 <= 1'b1;
      conv2_wSignRegs_186 <= 1'b1;
      conv2_wSignRegs_187 <= 1'b1;
      conv2_wSignRegs_188 <= 1'b1;
      conv2_wSignRegs_189 <= 1'b1;
      conv2_wSignRegs_190 <= 1'b1;
      conv2_wSignRegs_191 <= 1'b1;
      conv2_wSignRegs_192 <= 1'b1;
      conv2_wSignRegs_193 <= 1'b1;
      conv2_wSignRegs_194 <= 1'b1;
      conv2_wSignRegs_195 <= 1'b1;
      conv2_wSignRegs_196 <= 1'b1;
      conv2_wSignRegs_197 <= 1'b1;
      conv2_wSignRegs_198 <= 1'b1;
      conv2_wSignRegs_199 <= 1'b1;
      conv2_scAcc <= 18'h0;
      conv2_combAdjReg <= 32'h0;
      conv2_posBitRegs_0 <= 1'b0;
      conv2_posBitRegs_1 <= 1'b0;
      conv2_posBitRegs_2 <= 1'b0;
      conv2_posBitRegs_3 <= 1'b0;
      conv2_posBitRegs_4 <= 1'b0;
      conv2_posBitRegs_5 <= 1'b0;
      conv2_posBitRegs_6 <= 1'b0;
      conv2_posBitRegs_7 <= 1'b0;
      conv2_posBitRegs_8 <= 1'b0;
      conv2_posBitRegs_9 <= 1'b0;
      conv2_posBitRegs_10 <= 1'b0;
      conv2_posBitRegs_11 <= 1'b0;
      conv2_posBitRegs_12 <= 1'b0;
      conv2_posBitRegs_13 <= 1'b0;
      conv2_posBitRegs_14 <= 1'b0;
      conv2_posBitRegs_15 <= 1'b0;
      conv2_posBitRegs_16 <= 1'b0;
      conv2_posBitRegs_17 <= 1'b0;
      conv2_posBitRegs_18 <= 1'b0;
      conv2_posBitRegs_19 <= 1'b0;
      conv2_posBitRegs_20 <= 1'b0;
      conv2_posBitRegs_21 <= 1'b0;
      conv2_posBitRegs_22 <= 1'b0;
      conv2_posBitRegs_23 <= 1'b0;
      conv2_posBitRegs_24 <= 1'b0;
      conv2_posBitRegs_25 <= 1'b0;
      conv2_posBitRegs_26 <= 1'b0;
      conv2_posBitRegs_27 <= 1'b0;
      conv2_posBitRegs_28 <= 1'b0;
      conv2_posBitRegs_29 <= 1'b0;
      conv2_posBitRegs_30 <= 1'b0;
      conv2_posBitRegs_31 <= 1'b0;
      conv2_posBitRegs_32 <= 1'b0;
      conv2_posBitRegs_33 <= 1'b0;
      conv2_posBitRegs_34 <= 1'b0;
      conv2_posBitRegs_35 <= 1'b0;
      conv2_posBitRegs_36 <= 1'b0;
      conv2_posBitRegs_37 <= 1'b0;
      conv2_posBitRegs_38 <= 1'b0;
      conv2_posBitRegs_39 <= 1'b0;
      conv2_posBitRegs_40 <= 1'b0;
      conv2_posBitRegs_41 <= 1'b0;
      conv2_posBitRegs_42 <= 1'b0;
      conv2_posBitRegs_43 <= 1'b0;
      conv2_posBitRegs_44 <= 1'b0;
      conv2_posBitRegs_45 <= 1'b0;
      conv2_posBitRegs_46 <= 1'b0;
      conv2_posBitRegs_47 <= 1'b0;
      conv2_posBitRegs_48 <= 1'b0;
      conv2_posBitRegs_49 <= 1'b0;
      conv2_posBitRegs_50 <= 1'b0;
      conv2_posBitRegs_51 <= 1'b0;
      conv2_posBitRegs_52 <= 1'b0;
      conv2_posBitRegs_53 <= 1'b0;
      conv2_posBitRegs_54 <= 1'b0;
      conv2_posBitRegs_55 <= 1'b0;
      conv2_posBitRegs_56 <= 1'b0;
      conv2_posBitRegs_57 <= 1'b0;
      conv2_posBitRegs_58 <= 1'b0;
      conv2_posBitRegs_59 <= 1'b0;
      conv2_posBitRegs_60 <= 1'b0;
      conv2_posBitRegs_61 <= 1'b0;
      conv2_posBitRegs_62 <= 1'b0;
      conv2_posBitRegs_63 <= 1'b0;
      conv2_posBitRegs_64 <= 1'b0;
      conv2_posBitRegs_65 <= 1'b0;
      conv2_posBitRegs_66 <= 1'b0;
      conv2_posBitRegs_67 <= 1'b0;
      conv2_posBitRegs_68 <= 1'b0;
      conv2_posBitRegs_69 <= 1'b0;
      conv2_posBitRegs_70 <= 1'b0;
      conv2_posBitRegs_71 <= 1'b0;
      conv2_posBitRegs_72 <= 1'b0;
      conv2_posBitRegs_73 <= 1'b0;
      conv2_posBitRegs_74 <= 1'b0;
      conv2_posBitRegs_75 <= 1'b0;
      conv2_posBitRegs_76 <= 1'b0;
      conv2_posBitRegs_77 <= 1'b0;
      conv2_posBitRegs_78 <= 1'b0;
      conv2_posBitRegs_79 <= 1'b0;
      conv2_posBitRegs_80 <= 1'b0;
      conv2_posBitRegs_81 <= 1'b0;
      conv2_posBitRegs_82 <= 1'b0;
      conv2_posBitRegs_83 <= 1'b0;
      conv2_posBitRegs_84 <= 1'b0;
      conv2_posBitRegs_85 <= 1'b0;
      conv2_posBitRegs_86 <= 1'b0;
      conv2_posBitRegs_87 <= 1'b0;
      conv2_posBitRegs_88 <= 1'b0;
      conv2_posBitRegs_89 <= 1'b0;
      conv2_posBitRegs_90 <= 1'b0;
      conv2_posBitRegs_91 <= 1'b0;
      conv2_posBitRegs_92 <= 1'b0;
      conv2_posBitRegs_93 <= 1'b0;
      conv2_posBitRegs_94 <= 1'b0;
      conv2_posBitRegs_95 <= 1'b0;
      conv2_posBitRegs_96 <= 1'b0;
      conv2_posBitRegs_97 <= 1'b0;
      conv2_posBitRegs_98 <= 1'b0;
      conv2_posBitRegs_99 <= 1'b0;
      conv2_posBitRegs_100 <= 1'b0;
      conv2_posBitRegs_101 <= 1'b0;
      conv2_posBitRegs_102 <= 1'b0;
      conv2_posBitRegs_103 <= 1'b0;
      conv2_posBitRegs_104 <= 1'b0;
      conv2_posBitRegs_105 <= 1'b0;
      conv2_posBitRegs_106 <= 1'b0;
      conv2_posBitRegs_107 <= 1'b0;
      conv2_posBitRegs_108 <= 1'b0;
      conv2_posBitRegs_109 <= 1'b0;
      conv2_posBitRegs_110 <= 1'b0;
      conv2_posBitRegs_111 <= 1'b0;
      conv2_posBitRegs_112 <= 1'b0;
      conv2_posBitRegs_113 <= 1'b0;
      conv2_posBitRegs_114 <= 1'b0;
      conv2_posBitRegs_115 <= 1'b0;
      conv2_posBitRegs_116 <= 1'b0;
      conv2_posBitRegs_117 <= 1'b0;
      conv2_posBitRegs_118 <= 1'b0;
      conv2_posBitRegs_119 <= 1'b0;
      conv2_posBitRegs_120 <= 1'b0;
      conv2_posBitRegs_121 <= 1'b0;
      conv2_posBitRegs_122 <= 1'b0;
      conv2_posBitRegs_123 <= 1'b0;
      conv2_posBitRegs_124 <= 1'b0;
      conv2_posBitRegs_125 <= 1'b0;
      conv2_posBitRegs_126 <= 1'b0;
      conv2_posBitRegs_127 <= 1'b0;
      conv2_posBitRegs_128 <= 1'b0;
      conv2_posBitRegs_129 <= 1'b0;
      conv2_posBitRegs_130 <= 1'b0;
      conv2_posBitRegs_131 <= 1'b0;
      conv2_posBitRegs_132 <= 1'b0;
      conv2_posBitRegs_133 <= 1'b0;
      conv2_posBitRegs_134 <= 1'b0;
      conv2_posBitRegs_135 <= 1'b0;
      conv2_posBitRegs_136 <= 1'b0;
      conv2_posBitRegs_137 <= 1'b0;
      conv2_posBitRegs_138 <= 1'b0;
      conv2_posBitRegs_139 <= 1'b0;
      conv2_posBitRegs_140 <= 1'b0;
      conv2_posBitRegs_141 <= 1'b0;
      conv2_posBitRegs_142 <= 1'b0;
      conv2_posBitRegs_143 <= 1'b0;
      conv2_posBitRegs_144 <= 1'b0;
      conv2_posBitRegs_145 <= 1'b0;
      conv2_posBitRegs_146 <= 1'b0;
      conv2_posBitRegs_147 <= 1'b0;
      conv2_posBitRegs_148 <= 1'b0;
      conv2_posBitRegs_149 <= 1'b0;
      conv2_posBitRegs_150 <= 1'b0;
      conv2_posBitRegs_151 <= 1'b0;
      conv2_posBitRegs_152 <= 1'b0;
      conv2_posBitRegs_153 <= 1'b0;
      conv2_posBitRegs_154 <= 1'b0;
      conv2_posBitRegs_155 <= 1'b0;
      conv2_posBitRegs_156 <= 1'b0;
      conv2_posBitRegs_157 <= 1'b0;
      conv2_posBitRegs_158 <= 1'b0;
      conv2_posBitRegs_159 <= 1'b0;
      conv2_posBitRegs_160 <= 1'b0;
      conv2_posBitRegs_161 <= 1'b0;
      conv2_posBitRegs_162 <= 1'b0;
      conv2_posBitRegs_163 <= 1'b0;
      conv2_posBitRegs_164 <= 1'b0;
      conv2_posBitRegs_165 <= 1'b0;
      conv2_posBitRegs_166 <= 1'b0;
      conv2_posBitRegs_167 <= 1'b0;
      conv2_posBitRegs_168 <= 1'b0;
      conv2_posBitRegs_169 <= 1'b0;
      conv2_posBitRegs_170 <= 1'b0;
      conv2_posBitRegs_171 <= 1'b0;
      conv2_posBitRegs_172 <= 1'b0;
      conv2_posBitRegs_173 <= 1'b0;
      conv2_posBitRegs_174 <= 1'b0;
      conv2_posBitRegs_175 <= 1'b0;
      conv2_posBitRegs_176 <= 1'b0;
      conv2_posBitRegs_177 <= 1'b0;
      conv2_posBitRegs_178 <= 1'b0;
      conv2_posBitRegs_179 <= 1'b0;
      conv2_posBitRegs_180 <= 1'b0;
      conv2_posBitRegs_181 <= 1'b0;
      conv2_posBitRegs_182 <= 1'b0;
      conv2_posBitRegs_183 <= 1'b0;
      conv2_posBitRegs_184 <= 1'b0;
      conv2_posBitRegs_185 <= 1'b0;
      conv2_posBitRegs_186 <= 1'b0;
      conv2_posBitRegs_187 <= 1'b0;
      conv2_posBitRegs_188 <= 1'b0;
      conv2_posBitRegs_189 <= 1'b0;
      conv2_posBitRegs_190 <= 1'b0;
      conv2_posBitRegs_191 <= 1'b0;
      conv2_posBitRegs_192 <= 1'b0;
      conv2_posBitRegs_193 <= 1'b0;
      conv2_posBitRegs_194 <= 1'b0;
      conv2_posBitRegs_195 <= 1'b0;
      conv2_posBitRegs_196 <= 1'b0;
      conv2_posBitRegs_197 <= 1'b0;
      conv2_posBitRegs_198 <= 1'b0;
      conv2_posBitRegs_199 <= 1'b0;
      conv2_negBitRegs_0 <= 1'b0;
      conv2_negBitRegs_1 <= 1'b0;
      conv2_negBitRegs_2 <= 1'b0;
      conv2_negBitRegs_3 <= 1'b0;
      conv2_negBitRegs_4 <= 1'b0;
      conv2_negBitRegs_5 <= 1'b0;
      conv2_negBitRegs_6 <= 1'b0;
      conv2_negBitRegs_7 <= 1'b0;
      conv2_negBitRegs_8 <= 1'b0;
      conv2_negBitRegs_9 <= 1'b0;
      conv2_negBitRegs_10 <= 1'b0;
      conv2_negBitRegs_11 <= 1'b0;
      conv2_negBitRegs_12 <= 1'b0;
      conv2_negBitRegs_13 <= 1'b0;
      conv2_negBitRegs_14 <= 1'b0;
      conv2_negBitRegs_15 <= 1'b0;
      conv2_negBitRegs_16 <= 1'b0;
      conv2_negBitRegs_17 <= 1'b0;
      conv2_negBitRegs_18 <= 1'b0;
      conv2_negBitRegs_19 <= 1'b0;
      conv2_negBitRegs_20 <= 1'b0;
      conv2_negBitRegs_21 <= 1'b0;
      conv2_negBitRegs_22 <= 1'b0;
      conv2_negBitRegs_23 <= 1'b0;
      conv2_negBitRegs_24 <= 1'b0;
      conv2_negBitRegs_25 <= 1'b0;
      conv2_negBitRegs_26 <= 1'b0;
      conv2_negBitRegs_27 <= 1'b0;
      conv2_negBitRegs_28 <= 1'b0;
      conv2_negBitRegs_29 <= 1'b0;
      conv2_negBitRegs_30 <= 1'b0;
      conv2_negBitRegs_31 <= 1'b0;
      conv2_negBitRegs_32 <= 1'b0;
      conv2_negBitRegs_33 <= 1'b0;
      conv2_negBitRegs_34 <= 1'b0;
      conv2_negBitRegs_35 <= 1'b0;
      conv2_negBitRegs_36 <= 1'b0;
      conv2_negBitRegs_37 <= 1'b0;
      conv2_negBitRegs_38 <= 1'b0;
      conv2_negBitRegs_39 <= 1'b0;
      conv2_negBitRegs_40 <= 1'b0;
      conv2_negBitRegs_41 <= 1'b0;
      conv2_negBitRegs_42 <= 1'b0;
      conv2_negBitRegs_43 <= 1'b0;
      conv2_negBitRegs_44 <= 1'b0;
      conv2_negBitRegs_45 <= 1'b0;
      conv2_negBitRegs_46 <= 1'b0;
      conv2_negBitRegs_47 <= 1'b0;
      conv2_negBitRegs_48 <= 1'b0;
      conv2_negBitRegs_49 <= 1'b0;
      conv2_negBitRegs_50 <= 1'b0;
      conv2_negBitRegs_51 <= 1'b0;
      conv2_negBitRegs_52 <= 1'b0;
      conv2_negBitRegs_53 <= 1'b0;
      conv2_negBitRegs_54 <= 1'b0;
      conv2_negBitRegs_55 <= 1'b0;
      conv2_negBitRegs_56 <= 1'b0;
      conv2_negBitRegs_57 <= 1'b0;
      conv2_negBitRegs_58 <= 1'b0;
      conv2_negBitRegs_59 <= 1'b0;
      conv2_negBitRegs_60 <= 1'b0;
      conv2_negBitRegs_61 <= 1'b0;
      conv2_negBitRegs_62 <= 1'b0;
      conv2_negBitRegs_63 <= 1'b0;
      conv2_negBitRegs_64 <= 1'b0;
      conv2_negBitRegs_65 <= 1'b0;
      conv2_negBitRegs_66 <= 1'b0;
      conv2_negBitRegs_67 <= 1'b0;
      conv2_negBitRegs_68 <= 1'b0;
      conv2_negBitRegs_69 <= 1'b0;
      conv2_negBitRegs_70 <= 1'b0;
      conv2_negBitRegs_71 <= 1'b0;
      conv2_negBitRegs_72 <= 1'b0;
      conv2_negBitRegs_73 <= 1'b0;
      conv2_negBitRegs_74 <= 1'b0;
      conv2_negBitRegs_75 <= 1'b0;
      conv2_negBitRegs_76 <= 1'b0;
      conv2_negBitRegs_77 <= 1'b0;
      conv2_negBitRegs_78 <= 1'b0;
      conv2_negBitRegs_79 <= 1'b0;
      conv2_negBitRegs_80 <= 1'b0;
      conv2_negBitRegs_81 <= 1'b0;
      conv2_negBitRegs_82 <= 1'b0;
      conv2_negBitRegs_83 <= 1'b0;
      conv2_negBitRegs_84 <= 1'b0;
      conv2_negBitRegs_85 <= 1'b0;
      conv2_negBitRegs_86 <= 1'b0;
      conv2_negBitRegs_87 <= 1'b0;
      conv2_negBitRegs_88 <= 1'b0;
      conv2_negBitRegs_89 <= 1'b0;
      conv2_negBitRegs_90 <= 1'b0;
      conv2_negBitRegs_91 <= 1'b0;
      conv2_negBitRegs_92 <= 1'b0;
      conv2_negBitRegs_93 <= 1'b0;
      conv2_negBitRegs_94 <= 1'b0;
      conv2_negBitRegs_95 <= 1'b0;
      conv2_negBitRegs_96 <= 1'b0;
      conv2_negBitRegs_97 <= 1'b0;
      conv2_negBitRegs_98 <= 1'b0;
      conv2_negBitRegs_99 <= 1'b0;
      conv2_negBitRegs_100 <= 1'b0;
      conv2_negBitRegs_101 <= 1'b0;
      conv2_negBitRegs_102 <= 1'b0;
      conv2_negBitRegs_103 <= 1'b0;
      conv2_negBitRegs_104 <= 1'b0;
      conv2_negBitRegs_105 <= 1'b0;
      conv2_negBitRegs_106 <= 1'b0;
      conv2_negBitRegs_107 <= 1'b0;
      conv2_negBitRegs_108 <= 1'b0;
      conv2_negBitRegs_109 <= 1'b0;
      conv2_negBitRegs_110 <= 1'b0;
      conv2_negBitRegs_111 <= 1'b0;
      conv2_negBitRegs_112 <= 1'b0;
      conv2_negBitRegs_113 <= 1'b0;
      conv2_negBitRegs_114 <= 1'b0;
      conv2_negBitRegs_115 <= 1'b0;
      conv2_negBitRegs_116 <= 1'b0;
      conv2_negBitRegs_117 <= 1'b0;
      conv2_negBitRegs_118 <= 1'b0;
      conv2_negBitRegs_119 <= 1'b0;
      conv2_negBitRegs_120 <= 1'b0;
      conv2_negBitRegs_121 <= 1'b0;
      conv2_negBitRegs_122 <= 1'b0;
      conv2_negBitRegs_123 <= 1'b0;
      conv2_negBitRegs_124 <= 1'b0;
      conv2_negBitRegs_125 <= 1'b0;
      conv2_negBitRegs_126 <= 1'b0;
      conv2_negBitRegs_127 <= 1'b0;
      conv2_negBitRegs_128 <= 1'b0;
      conv2_negBitRegs_129 <= 1'b0;
      conv2_negBitRegs_130 <= 1'b0;
      conv2_negBitRegs_131 <= 1'b0;
      conv2_negBitRegs_132 <= 1'b0;
      conv2_negBitRegs_133 <= 1'b0;
      conv2_negBitRegs_134 <= 1'b0;
      conv2_negBitRegs_135 <= 1'b0;
      conv2_negBitRegs_136 <= 1'b0;
      conv2_negBitRegs_137 <= 1'b0;
      conv2_negBitRegs_138 <= 1'b0;
      conv2_negBitRegs_139 <= 1'b0;
      conv2_negBitRegs_140 <= 1'b0;
      conv2_negBitRegs_141 <= 1'b0;
      conv2_negBitRegs_142 <= 1'b0;
      conv2_negBitRegs_143 <= 1'b0;
      conv2_negBitRegs_144 <= 1'b0;
      conv2_negBitRegs_145 <= 1'b0;
      conv2_negBitRegs_146 <= 1'b0;
      conv2_negBitRegs_147 <= 1'b0;
      conv2_negBitRegs_148 <= 1'b0;
      conv2_negBitRegs_149 <= 1'b0;
      conv2_negBitRegs_150 <= 1'b0;
      conv2_negBitRegs_151 <= 1'b0;
      conv2_negBitRegs_152 <= 1'b0;
      conv2_negBitRegs_153 <= 1'b0;
      conv2_negBitRegs_154 <= 1'b0;
      conv2_negBitRegs_155 <= 1'b0;
      conv2_negBitRegs_156 <= 1'b0;
      conv2_negBitRegs_157 <= 1'b0;
      conv2_negBitRegs_158 <= 1'b0;
      conv2_negBitRegs_159 <= 1'b0;
      conv2_negBitRegs_160 <= 1'b0;
      conv2_negBitRegs_161 <= 1'b0;
      conv2_negBitRegs_162 <= 1'b0;
      conv2_negBitRegs_163 <= 1'b0;
      conv2_negBitRegs_164 <= 1'b0;
      conv2_negBitRegs_165 <= 1'b0;
      conv2_negBitRegs_166 <= 1'b0;
      conv2_negBitRegs_167 <= 1'b0;
      conv2_negBitRegs_168 <= 1'b0;
      conv2_negBitRegs_169 <= 1'b0;
      conv2_negBitRegs_170 <= 1'b0;
      conv2_negBitRegs_171 <= 1'b0;
      conv2_negBitRegs_172 <= 1'b0;
      conv2_negBitRegs_173 <= 1'b0;
      conv2_negBitRegs_174 <= 1'b0;
      conv2_negBitRegs_175 <= 1'b0;
      conv2_negBitRegs_176 <= 1'b0;
      conv2_negBitRegs_177 <= 1'b0;
      conv2_negBitRegs_178 <= 1'b0;
      conv2_negBitRegs_179 <= 1'b0;
      conv2_negBitRegs_180 <= 1'b0;
      conv2_negBitRegs_181 <= 1'b0;
      conv2_negBitRegs_182 <= 1'b0;
      conv2_negBitRegs_183 <= 1'b0;
      conv2_negBitRegs_184 <= 1'b0;
      conv2_negBitRegs_185 <= 1'b0;
      conv2_negBitRegs_186 <= 1'b0;
      conv2_negBitRegs_187 <= 1'b0;
      conv2_negBitRegs_188 <= 1'b0;
      conv2_negBitRegs_189 <= 1'b0;
      conv2_negBitRegs_190 <= 1'b0;
      conv2_negBitRegs_191 <= 1'b0;
      conv2_negBitRegs_192 <= 1'b0;
      conv2_negBitRegs_193 <= 1'b0;
      conv2_negBitRegs_194 <= 1'b0;
      conv2_negBitRegs_195 <= 1'b0;
      conv2_negBitRegs_196 <= 1'b0;
      conv2_negBitRegs_197 <= 1'b0;
      conv2_negBitRegs_198 <= 1'b0;
      conv2_negBitRegs_199 <= 1'b0;
      conv2_rxCnt <= 11'h0;
      conv2_rxAddr <= 12'h130;
      conv2_rxRow <= 7'h0;
      conv2_ocReg <= 5'h0;
      conv2_outHReg <= 4'b0000;
      conv2_outWReg <= 4'b0000;
      conv2_loadStep <= 8'h0;
      conv2_scStep <= 8'h0;
      conv2_wAddrBase <= 12'h0;
      conv2_initAddr <= 12'h0;
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
      conv1_wRootLfsr <= {(((conv1_wRootLfsr[0] ^ conv1_wRootLfsr[2]) ^ conv1_wRootLfsr[3]) ^ conv1_wRootLfsr[4]),conv1_wRootLfsr[7 : 1]};
      conv1_aRootLfsr <= {(((conv1_aRootLfsr[0] ^ conv1_aRootLfsr[2]) ^ conv1_aRootLfsr[3]) ^ conv1_aRootLfsr[4]),conv1_aRootLfsr[7 : 1]};
      conv1_wLfsrChain_0 <= conv1_wRootLfsr;
      conv1_aLfsrChain_0 <= conv1_aRootLfsr;
      conv1_wLfsrChain_1 <= conv1_wLfsrChain_0;
      conv1_aLfsrChain_1 <= conv1_aLfsrChain_0;
      conv1_wLfsrChain_2 <= conv1_wLfsrChain_1;
      conv1_aLfsrChain_2 <= conv1_aLfsrChain_1;
      conv1_wLfsrChain_3 <= conv1_wLfsrChain_2;
      conv1_aLfsrChain_3 <= conv1_aLfsrChain_2;
      conv1_wLfsrChain_4 <= conv1_wLfsrChain_3;
      conv1_aLfsrChain_4 <= conv1_aLfsrChain_3;
      conv1_wLfsrChain_5 <= conv1_wLfsrChain_4;
      conv1_aLfsrChain_5 <= conv1_aLfsrChain_4;
      conv1_wLfsrChain_6 <= conv1_wLfsrChain_5;
      conv1_aLfsrChain_6 <= conv1_aLfsrChain_5;
      conv1_wLfsrChain_7 <= conv1_wLfsrChain_6;
      conv1_aLfsrChain_7 <= conv1_aLfsrChain_6;
      conv1_wLfsrChain_8 <= conv1_wLfsrChain_7;
      conv1_aLfsrChain_8 <= conv1_aLfsrChain_7;
      conv1_wLfsrChain_9 <= conv1_wLfsrChain_8;
      conv1_aLfsrChain_9 <= conv1_aLfsrChain_8;
      conv1_wLfsrChain_10 <= conv1_wLfsrChain_9;
      conv1_aLfsrChain_10 <= conv1_aLfsrChain_9;
      conv1_wLfsrChain_11 <= conv1_wLfsrChain_10;
      conv1_aLfsrChain_11 <= conv1_aLfsrChain_10;
      conv1_wLfsrChain_12 <= conv1_wLfsrChain_11;
      conv1_aLfsrChain_12 <= conv1_aLfsrChain_11;
      conv1_wLfsrChain_13 <= conv1_wLfsrChain_12;
      conv1_aLfsrChain_13 <= conv1_aLfsrChain_12;
      conv1_wLfsrChain_14 <= conv1_wLfsrChain_13;
      conv1_aLfsrChain_14 <= conv1_aLfsrChain_13;
      conv1_wLfsrChain_15 <= conv1_wLfsrChain_14;
      conv1_aLfsrChain_15 <= conv1_aLfsrChain_14;
      conv1_wLfsrChain_16 <= conv1_wLfsrChain_15;
      conv1_aLfsrChain_16 <= conv1_aLfsrChain_15;
      conv1_wLfsrChain_17 <= conv1_wLfsrChain_16;
      conv1_aLfsrChain_17 <= conv1_aLfsrChain_16;
      conv1_wLfsrChain_18 <= conv1_wLfsrChain_17;
      conv1_aLfsrChain_18 <= conv1_aLfsrChain_17;
      conv1_wLfsrChain_19 <= conv1_wLfsrChain_18;
      conv1_aLfsrChain_19 <= conv1_aLfsrChain_18;
      conv1_wLfsrChain_20 <= conv1_wLfsrChain_19;
      conv1_aLfsrChain_20 <= conv1_aLfsrChain_19;
      conv1_wLfsrChain_21 <= conv1_wLfsrChain_20;
      conv1_aLfsrChain_21 <= conv1_aLfsrChain_20;
      conv1_wLfsrChain_22 <= conv1_wLfsrChain_21;
      conv1_aLfsrChain_22 <= conv1_aLfsrChain_21;
      conv1_wLfsrChain_23 <= conv1_wLfsrChain_22;
      conv1_aLfsrChain_23 <= conv1_aLfsrChain_22;
      conv1_wLfsrChain_24 <= conv1_wLfsrChain_23;
      conv1_aLfsrChain_24 <= conv1_aLfsrChain_23;
      conv1_posBitRegs_0 <= (_zz_conv1_posBitRegs_0 && conv1_wSignRegs_0);
      conv1_negBitRegs_0 <= (_zz_conv1_posBitRegs_0 && (! conv1_wSignRegs_0));
      conv1_posBitRegs_1 <= (_zz_conv1_posBitRegs_1 && conv1_wSignRegs_1);
      conv1_negBitRegs_1 <= (_zz_conv1_posBitRegs_1 && (! conv1_wSignRegs_1));
      conv1_posBitRegs_2 <= (_zz_conv1_posBitRegs_2 && conv1_wSignRegs_2);
      conv1_negBitRegs_2 <= (_zz_conv1_posBitRegs_2 && (! conv1_wSignRegs_2));
      conv1_posBitRegs_3 <= (_zz_conv1_posBitRegs_3 && conv1_wSignRegs_3);
      conv1_negBitRegs_3 <= (_zz_conv1_posBitRegs_3 && (! conv1_wSignRegs_3));
      conv1_posBitRegs_4 <= (_zz_conv1_posBitRegs_4 && conv1_wSignRegs_4);
      conv1_negBitRegs_4 <= (_zz_conv1_posBitRegs_4 && (! conv1_wSignRegs_4));
      conv1_posBitRegs_5 <= (_zz_conv1_posBitRegs_5 && conv1_wSignRegs_5);
      conv1_negBitRegs_5 <= (_zz_conv1_posBitRegs_5 && (! conv1_wSignRegs_5));
      conv1_posBitRegs_6 <= (_zz_conv1_posBitRegs_6 && conv1_wSignRegs_6);
      conv1_negBitRegs_6 <= (_zz_conv1_posBitRegs_6 && (! conv1_wSignRegs_6));
      conv1_posBitRegs_7 <= (_zz_conv1_posBitRegs_7 && conv1_wSignRegs_7);
      conv1_negBitRegs_7 <= (_zz_conv1_posBitRegs_7 && (! conv1_wSignRegs_7));
      conv1_posBitRegs_8 <= (_zz_conv1_posBitRegs_8 && conv1_wSignRegs_8);
      conv1_negBitRegs_8 <= (_zz_conv1_posBitRegs_8 && (! conv1_wSignRegs_8));
      conv1_posBitRegs_9 <= (_zz_conv1_posBitRegs_9 && conv1_wSignRegs_9);
      conv1_negBitRegs_9 <= (_zz_conv1_posBitRegs_9 && (! conv1_wSignRegs_9));
      conv1_posBitRegs_10 <= (_zz_conv1_posBitRegs_10 && conv1_wSignRegs_10);
      conv1_negBitRegs_10 <= (_zz_conv1_posBitRegs_10 && (! conv1_wSignRegs_10));
      conv1_posBitRegs_11 <= (_zz_conv1_posBitRegs_11 && conv1_wSignRegs_11);
      conv1_negBitRegs_11 <= (_zz_conv1_posBitRegs_11 && (! conv1_wSignRegs_11));
      conv1_posBitRegs_12 <= (_zz_conv1_posBitRegs_12 && conv1_wSignRegs_12);
      conv1_negBitRegs_12 <= (_zz_conv1_posBitRegs_12 && (! conv1_wSignRegs_12));
      conv1_posBitRegs_13 <= (_zz_conv1_posBitRegs_13 && conv1_wSignRegs_13);
      conv1_negBitRegs_13 <= (_zz_conv1_posBitRegs_13 && (! conv1_wSignRegs_13));
      conv1_posBitRegs_14 <= (_zz_conv1_posBitRegs_14 && conv1_wSignRegs_14);
      conv1_negBitRegs_14 <= (_zz_conv1_posBitRegs_14 && (! conv1_wSignRegs_14));
      conv1_posBitRegs_15 <= (_zz_conv1_posBitRegs_15 && conv1_wSignRegs_15);
      conv1_negBitRegs_15 <= (_zz_conv1_posBitRegs_15 && (! conv1_wSignRegs_15));
      conv1_posBitRegs_16 <= (_zz_conv1_posBitRegs_16 && conv1_wSignRegs_16);
      conv1_negBitRegs_16 <= (_zz_conv1_posBitRegs_16 && (! conv1_wSignRegs_16));
      conv1_posBitRegs_17 <= (_zz_conv1_posBitRegs_17 && conv1_wSignRegs_17);
      conv1_negBitRegs_17 <= (_zz_conv1_posBitRegs_17 && (! conv1_wSignRegs_17));
      conv1_posBitRegs_18 <= (_zz_conv1_posBitRegs_18 && conv1_wSignRegs_18);
      conv1_negBitRegs_18 <= (_zz_conv1_posBitRegs_18 && (! conv1_wSignRegs_18));
      conv1_posBitRegs_19 <= (_zz_conv1_posBitRegs_19 && conv1_wSignRegs_19);
      conv1_negBitRegs_19 <= (_zz_conv1_posBitRegs_19 && (! conv1_wSignRegs_19));
      conv1_posBitRegs_20 <= (_zz_conv1_posBitRegs_20 && conv1_wSignRegs_20);
      conv1_negBitRegs_20 <= (_zz_conv1_posBitRegs_20 && (! conv1_wSignRegs_20));
      conv1_posBitRegs_21 <= (_zz_conv1_posBitRegs_21 && conv1_wSignRegs_21);
      conv1_negBitRegs_21 <= (_zz_conv1_posBitRegs_21 && (! conv1_wSignRegs_21));
      conv1_posBitRegs_22 <= (_zz_conv1_posBitRegs_22 && conv1_wSignRegs_22);
      conv1_negBitRegs_22 <= (_zz_conv1_posBitRegs_22 && (! conv1_wSignRegs_22));
      conv1_posBitRegs_23 <= (_zz_conv1_posBitRegs_23 && conv1_wSignRegs_23);
      conv1_negBitRegs_23 <= (_zz_conv1_posBitRegs_23 && (! conv1_wSignRegs_23));
      conv1_posBitRegs_24 <= (_zz_conv1_posBitRegs_24 && conv1_wSignRegs_24);
      conv1_negBitRegs_24 <= (_zz_conv1_posBitRegs_24 && (! conv1_wSignRegs_24));
      if(when_StochasticConvCore_l279) begin
        if(when_StochasticConvCore_l280) begin
          conv1_initAddr <= 11'h0;
          conv1_state <= conv1_sRx;
        end else begin
          conv1_initAddr <= (conv1_initAddr + 11'h001);
        end
      end
      if(when_StochasticConvCore_l288) begin
        if(io_activationIn_fire) begin
          conv1_rxRow <= (_zz_conv1_rxAddr ? 5'h0 : _zz_conv1_rxRow);
          conv1_rxAddr <= (conv1_rxAddr + (_zz_conv1_rxAddr ? 11'h005 : 11'h001));
          conv1_rxCnt <= (conv1_rxCnt + 10'h001);
          if(when_StochasticConvCore_l295) begin
            conv1_rxCnt <= 10'h0;
            conv1_rxRow <= 5'h0;
            conv1_rxAddr <= 11'h042;
            conv1_ocReg <= 4'b0000;
            conv1_outHReg <= 5'h0;
            conv1_outWReg <= 5'h0;
            conv1_wAddrBase <= 8'h0;
            conv1_loadStep <= 5'h0;
            conv1_state <= conv1_sLoad;
          end
        end
      end
      if(when_StochasticConvCore_l345) begin
        conv1_loadStep <= (conv1_loadStep + 5'h01);
        if(when_StochasticConvCore_l349) begin
          conv1_combAdjReg <= conv1_combAdjRead;
        end
        if(when_StochasticConvCore_l353) begin
          conv1_activThresh_0 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_0 <= conv1_wThrRead;
          conv1_wSignRegs_0 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_1) begin
          conv1_activThresh_1 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_1 <= conv1_wThrRead;
          conv1_wSignRegs_1 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_2) begin
          conv1_activThresh_2 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_2 <= conv1_wThrRead;
          conv1_wSignRegs_2 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_3) begin
          conv1_activThresh_3 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_3 <= conv1_wThrRead;
          conv1_wSignRegs_3 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_4) begin
          conv1_activThresh_4 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_4 <= conv1_wThrRead;
          conv1_wSignRegs_4 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_5) begin
          conv1_activThresh_5 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_5 <= conv1_wThrRead;
          conv1_wSignRegs_5 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_6) begin
          conv1_activThresh_6 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_6 <= conv1_wThrRead;
          conv1_wSignRegs_6 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_7) begin
          conv1_activThresh_7 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_7 <= conv1_wThrRead;
          conv1_wSignRegs_7 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_8) begin
          conv1_activThresh_8 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_8 <= conv1_wThrRead;
          conv1_wSignRegs_8 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_9) begin
          conv1_activThresh_9 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_9 <= conv1_wThrRead;
          conv1_wSignRegs_9 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_10) begin
          conv1_activThresh_10 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_10 <= conv1_wThrRead;
          conv1_wSignRegs_10 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_11) begin
          conv1_activThresh_11 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_11 <= conv1_wThrRead;
          conv1_wSignRegs_11 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_12) begin
          conv1_activThresh_12 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_12 <= conv1_wThrRead;
          conv1_wSignRegs_12 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_13) begin
          conv1_activThresh_13 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_13 <= conv1_wThrRead;
          conv1_wSignRegs_13 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_14) begin
          conv1_activThresh_14 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_14 <= conv1_wThrRead;
          conv1_wSignRegs_14 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_15) begin
          conv1_activThresh_15 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_15 <= conv1_wThrRead;
          conv1_wSignRegs_15 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_16) begin
          conv1_activThresh_16 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_16 <= conv1_wThrRead;
          conv1_wSignRegs_16 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_17) begin
          conv1_activThresh_17 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_17 <= conv1_wThrRead;
          conv1_wSignRegs_17 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_18) begin
          conv1_activThresh_18 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_18 <= conv1_wThrRead;
          conv1_wSignRegs_18 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_19) begin
          conv1_activThresh_19 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_19 <= conv1_wThrRead;
          conv1_wSignRegs_19 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_20) begin
          conv1_activThresh_20 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_20 <= conv1_wThrRead;
          conv1_wSignRegs_20 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_21) begin
          conv1_activThresh_21 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_21 <= conv1_wThrRead;
          conv1_wSignRegs_21 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_22) begin
          conv1_activThresh_22 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_22 <= conv1_wThrRead;
          conv1_wSignRegs_22 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_23) begin
          conv1_activThresh_23 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_23 <= conv1_wThrRead;
          conv1_wSignRegs_23 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l353_24) begin
          conv1_activThresh_24 <= (conv1_actBufRead + 8'h80);
          conv1_wThrRegs_24 <= conv1_wThrRead;
          conv1_wSignRegs_24 <= conv1_wSignRead;
        end
        if(when_StochasticConvCore_l361) begin
          conv1_loadStep <= 5'h0;
          conv1_scAcc <= 15'h0;
          conv1_scStep <= 8'h0;
          conv1_state <= conv1_sSC;
        end
      end
      if(when_StochasticConvCore_l373) begin
        conv1_scStep <= (conv1_scStep + 8'h01);
        conv1_scAcc <= ($signed(conv1_scAcc) + $signed(_zz_conv1_scAcc));
        if(when_StochasticConvCore_l376) begin
          conv1_scStep <= 8'h0;
          conv1_state <= conv1_sDecode;
        end
      end
      if(when_StochasticConvCore_l387) begin
        if(conv1_activationOut_fire) begin
          conv1_ocReg <= (when_StochasticConvCore_l408 ? 4'b0000 : _zz_conv1_ocReg);
          conv1_wAddrBase <= (when_StochasticConvCore_l408 ? 8'h0 : _zz_conv1_wAddrBase);
          if(when_StochasticConvCore_l408) begin
            conv1_outWReg <= (when_StochasticConvCore_l410 ? 5'h0 : _zz_conv1_outWReg);
            if(when_StochasticConvCore_l410) begin
              conv1_outHReg <= (_zz_conv1_state ? 5'h0 : _zz_conv1_outHReg);
            end
          end
          conv1_loadStep <= 5'h0;
          conv1_state <= (((when_StochasticConvCore_l408 && when_StochasticConvCore_l410) && _zz_conv1_state) ? conv1_sRx : conv1_sLoad);
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
      conv2_wRootLfsr <= {(((conv2_wRootLfsr[0] ^ conv2_wRootLfsr[2]) ^ conv2_wRootLfsr[3]) ^ conv2_wRootLfsr[4]),conv2_wRootLfsr[7 : 1]};
      conv2_aRootLfsr <= {(((conv2_aRootLfsr[0] ^ conv2_aRootLfsr[2]) ^ conv2_aRootLfsr[3]) ^ conv2_aRootLfsr[4]),conv2_aRootLfsr[7 : 1]};
      conv2_wLfsrChain_0 <= conv2_wRootLfsr;
      conv2_aLfsrChain_0 <= conv2_aRootLfsr;
      conv2_wLfsrChain_1 <= conv2_wLfsrChain_0;
      conv2_aLfsrChain_1 <= conv2_aLfsrChain_0;
      conv2_wLfsrChain_2 <= conv2_wLfsrChain_1;
      conv2_aLfsrChain_2 <= conv2_aLfsrChain_1;
      conv2_wLfsrChain_3 <= conv2_wLfsrChain_2;
      conv2_aLfsrChain_3 <= conv2_aLfsrChain_2;
      conv2_wLfsrChain_4 <= conv2_wLfsrChain_3;
      conv2_aLfsrChain_4 <= conv2_aLfsrChain_3;
      conv2_wLfsrChain_5 <= conv2_wLfsrChain_4;
      conv2_aLfsrChain_5 <= conv2_aLfsrChain_4;
      conv2_wLfsrChain_6 <= conv2_wLfsrChain_5;
      conv2_aLfsrChain_6 <= conv2_aLfsrChain_5;
      conv2_wLfsrChain_7 <= conv2_wLfsrChain_6;
      conv2_aLfsrChain_7 <= conv2_aLfsrChain_6;
      conv2_wLfsrChain_8 <= conv2_wLfsrChain_7;
      conv2_aLfsrChain_8 <= conv2_aLfsrChain_7;
      conv2_wLfsrChain_9 <= conv2_wLfsrChain_8;
      conv2_aLfsrChain_9 <= conv2_aLfsrChain_8;
      conv2_wLfsrChain_10 <= conv2_wLfsrChain_9;
      conv2_aLfsrChain_10 <= conv2_aLfsrChain_9;
      conv2_wLfsrChain_11 <= conv2_wLfsrChain_10;
      conv2_aLfsrChain_11 <= conv2_aLfsrChain_10;
      conv2_wLfsrChain_12 <= conv2_wLfsrChain_11;
      conv2_aLfsrChain_12 <= conv2_aLfsrChain_11;
      conv2_wLfsrChain_13 <= conv2_wLfsrChain_12;
      conv2_aLfsrChain_13 <= conv2_aLfsrChain_12;
      conv2_wLfsrChain_14 <= conv2_wLfsrChain_13;
      conv2_aLfsrChain_14 <= conv2_aLfsrChain_13;
      conv2_wLfsrChain_15 <= conv2_wLfsrChain_14;
      conv2_aLfsrChain_15 <= conv2_aLfsrChain_14;
      conv2_wLfsrChain_16 <= conv2_wLfsrChain_15;
      conv2_aLfsrChain_16 <= conv2_aLfsrChain_15;
      conv2_wLfsrChain_17 <= conv2_wLfsrChain_16;
      conv2_aLfsrChain_17 <= conv2_aLfsrChain_16;
      conv2_wLfsrChain_18 <= conv2_wLfsrChain_17;
      conv2_aLfsrChain_18 <= conv2_aLfsrChain_17;
      conv2_wLfsrChain_19 <= conv2_wLfsrChain_18;
      conv2_aLfsrChain_19 <= conv2_aLfsrChain_18;
      conv2_wLfsrChain_20 <= conv2_wLfsrChain_19;
      conv2_aLfsrChain_20 <= conv2_aLfsrChain_19;
      conv2_wLfsrChain_21 <= conv2_wLfsrChain_20;
      conv2_aLfsrChain_21 <= conv2_aLfsrChain_20;
      conv2_wLfsrChain_22 <= conv2_wLfsrChain_21;
      conv2_aLfsrChain_22 <= conv2_aLfsrChain_21;
      conv2_wLfsrChain_23 <= conv2_wLfsrChain_22;
      conv2_aLfsrChain_23 <= conv2_aLfsrChain_22;
      conv2_wLfsrChain_24 <= conv2_wLfsrChain_23;
      conv2_aLfsrChain_24 <= conv2_aLfsrChain_23;
      conv2_wLfsrChain_25 <= conv2_wLfsrChain_24;
      conv2_aLfsrChain_25 <= conv2_aLfsrChain_24;
      conv2_wLfsrChain_26 <= conv2_wLfsrChain_25;
      conv2_aLfsrChain_26 <= conv2_aLfsrChain_25;
      conv2_wLfsrChain_27 <= conv2_wLfsrChain_26;
      conv2_aLfsrChain_27 <= conv2_aLfsrChain_26;
      conv2_wLfsrChain_28 <= conv2_wLfsrChain_27;
      conv2_aLfsrChain_28 <= conv2_aLfsrChain_27;
      conv2_wLfsrChain_29 <= conv2_wLfsrChain_28;
      conv2_aLfsrChain_29 <= conv2_aLfsrChain_28;
      conv2_wLfsrChain_30 <= conv2_wLfsrChain_29;
      conv2_aLfsrChain_30 <= conv2_aLfsrChain_29;
      conv2_wLfsrChain_31 <= conv2_wLfsrChain_30;
      conv2_aLfsrChain_31 <= conv2_aLfsrChain_30;
      conv2_wLfsrChain_32 <= conv2_wLfsrChain_31;
      conv2_aLfsrChain_32 <= conv2_aLfsrChain_31;
      conv2_wLfsrChain_33 <= conv2_wLfsrChain_32;
      conv2_aLfsrChain_33 <= conv2_aLfsrChain_32;
      conv2_wLfsrChain_34 <= conv2_wLfsrChain_33;
      conv2_aLfsrChain_34 <= conv2_aLfsrChain_33;
      conv2_wLfsrChain_35 <= conv2_wLfsrChain_34;
      conv2_aLfsrChain_35 <= conv2_aLfsrChain_34;
      conv2_wLfsrChain_36 <= conv2_wLfsrChain_35;
      conv2_aLfsrChain_36 <= conv2_aLfsrChain_35;
      conv2_wLfsrChain_37 <= conv2_wLfsrChain_36;
      conv2_aLfsrChain_37 <= conv2_aLfsrChain_36;
      conv2_wLfsrChain_38 <= conv2_wLfsrChain_37;
      conv2_aLfsrChain_38 <= conv2_aLfsrChain_37;
      conv2_wLfsrChain_39 <= conv2_wLfsrChain_38;
      conv2_aLfsrChain_39 <= conv2_aLfsrChain_38;
      conv2_wLfsrChain_40 <= conv2_wLfsrChain_39;
      conv2_aLfsrChain_40 <= conv2_aLfsrChain_39;
      conv2_wLfsrChain_41 <= conv2_wLfsrChain_40;
      conv2_aLfsrChain_41 <= conv2_aLfsrChain_40;
      conv2_wLfsrChain_42 <= conv2_wLfsrChain_41;
      conv2_aLfsrChain_42 <= conv2_aLfsrChain_41;
      conv2_wLfsrChain_43 <= conv2_wLfsrChain_42;
      conv2_aLfsrChain_43 <= conv2_aLfsrChain_42;
      conv2_wLfsrChain_44 <= conv2_wLfsrChain_43;
      conv2_aLfsrChain_44 <= conv2_aLfsrChain_43;
      conv2_wLfsrChain_45 <= conv2_wLfsrChain_44;
      conv2_aLfsrChain_45 <= conv2_aLfsrChain_44;
      conv2_wLfsrChain_46 <= conv2_wLfsrChain_45;
      conv2_aLfsrChain_46 <= conv2_aLfsrChain_45;
      conv2_wLfsrChain_47 <= conv2_wLfsrChain_46;
      conv2_aLfsrChain_47 <= conv2_aLfsrChain_46;
      conv2_wLfsrChain_48 <= conv2_wLfsrChain_47;
      conv2_aLfsrChain_48 <= conv2_aLfsrChain_47;
      conv2_wLfsrChain_49 <= conv2_wLfsrChain_48;
      conv2_aLfsrChain_49 <= conv2_aLfsrChain_48;
      conv2_wLfsrChain_50 <= conv2_wLfsrChain_49;
      conv2_aLfsrChain_50 <= conv2_aLfsrChain_49;
      conv2_wLfsrChain_51 <= conv2_wLfsrChain_50;
      conv2_aLfsrChain_51 <= conv2_aLfsrChain_50;
      conv2_wLfsrChain_52 <= conv2_wLfsrChain_51;
      conv2_aLfsrChain_52 <= conv2_aLfsrChain_51;
      conv2_wLfsrChain_53 <= conv2_wLfsrChain_52;
      conv2_aLfsrChain_53 <= conv2_aLfsrChain_52;
      conv2_wLfsrChain_54 <= conv2_wLfsrChain_53;
      conv2_aLfsrChain_54 <= conv2_aLfsrChain_53;
      conv2_wLfsrChain_55 <= conv2_wLfsrChain_54;
      conv2_aLfsrChain_55 <= conv2_aLfsrChain_54;
      conv2_wLfsrChain_56 <= conv2_wLfsrChain_55;
      conv2_aLfsrChain_56 <= conv2_aLfsrChain_55;
      conv2_wLfsrChain_57 <= conv2_wLfsrChain_56;
      conv2_aLfsrChain_57 <= conv2_aLfsrChain_56;
      conv2_wLfsrChain_58 <= conv2_wLfsrChain_57;
      conv2_aLfsrChain_58 <= conv2_aLfsrChain_57;
      conv2_wLfsrChain_59 <= conv2_wLfsrChain_58;
      conv2_aLfsrChain_59 <= conv2_aLfsrChain_58;
      conv2_wLfsrChain_60 <= conv2_wLfsrChain_59;
      conv2_aLfsrChain_60 <= conv2_aLfsrChain_59;
      conv2_wLfsrChain_61 <= conv2_wLfsrChain_60;
      conv2_aLfsrChain_61 <= conv2_aLfsrChain_60;
      conv2_wLfsrChain_62 <= conv2_wLfsrChain_61;
      conv2_aLfsrChain_62 <= conv2_aLfsrChain_61;
      conv2_wLfsrChain_63 <= conv2_wLfsrChain_62;
      conv2_aLfsrChain_63 <= conv2_aLfsrChain_62;
      conv2_wLfsrChain_64 <= conv2_wLfsrChain_63;
      conv2_aLfsrChain_64 <= conv2_aLfsrChain_63;
      conv2_wLfsrChain_65 <= conv2_wLfsrChain_64;
      conv2_aLfsrChain_65 <= conv2_aLfsrChain_64;
      conv2_wLfsrChain_66 <= conv2_wLfsrChain_65;
      conv2_aLfsrChain_66 <= conv2_aLfsrChain_65;
      conv2_wLfsrChain_67 <= conv2_wLfsrChain_66;
      conv2_aLfsrChain_67 <= conv2_aLfsrChain_66;
      conv2_wLfsrChain_68 <= conv2_wLfsrChain_67;
      conv2_aLfsrChain_68 <= conv2_aLfsrChain_67;
      conv2_wLfsrChain_69 <= conv2_wLfsrChain_68;
      conv2_aLfsrChain_69 <= conv2_aLfsrChain_68;
      conv2_wLfsrChain_70 <= conv2_wLfsrChain_69;
      conv2_aLfsrChain_70 <= conv2_aLfsrChain_69;
      conv2_wLfsrChain_71 <= conv2_wLfsrChain_70;
      conv2_aLfsrChain_71 <= conv2_aLfsrChain_70;
      conv2_wLfsrChain_72 <= conv2_wLfsrChain_71;
      conv2_aLfsrChain_72 <= conv2_aLfsrChain_71;
      conv2_wLfsrChain_73 <= conv2_wLfsrChain_72;
      conv2_aLfsrChain_73 <= conv2_aLfsrChain_72;
      conv2_wLfsrChain_74 <= conv2_wLfsrChain_73;
      conv2_aLfsrChain_74 <= conv2_aLfsrChain_73;
      conv2_wLfsrChain_75 <= conv2_wLfsrChain_74;
      conv2_aLfsrChain_75 <= conv2_aLfsrChain_74;
      conv2_wLfsrChain_76 <= conv2_wLfsrChain_75;
      conv2_aLfsrChain_76 <= conv2_aLfsrChain_75;
      conv2_wLfsrChain_77 <= conv2_wLfsrChain_76;
      conv2_aLfsrChain_77 <= conv2_aLfsrChain_76;
      conv2_wLfsrChain_78 <= conv2_wLfsrChain_77;
      conv2_aLfsrChain_78 <= conv2_aLfsrChain_77;
      conv2_wLfsrChain_79 <= conv2_wLfsrChain_78;
      conv2_aLfsrChain_79 <= conv2_aLfsrChain_78;
      conv2_wLfsrChain_80 <= conv2_wLfsrChain_79;
      conv2_aLfsrChain_80 <= conv2_aLfsrChain_79;
      conv2_wLfsrChain_81 <= conv2_wLfsrChain_80;
      conv2_aLfsrChain_81 <= conv2_aLfsrChain_80;
      conv2_wLfsrChain_82 <= conv2_wLfsrChain_81;
      conv2_aLfsrChain_82 <= conv2_aLfsrChain_81;
      conv2_wLfsrChain_83 <= conv2_wLfsrChain_82;
      conv2_aLfsrChain_83 <= conv2_aLfsrChain_82;
      conv2_wLfsrChain_84 <= conv2_wLfsrChain_83;
      conv2_aLfsrChain_84 <= conv2_aLfsrChain_83;
      conv2_wLfsrChain_85 <= conv2_wLfsrChain_84;
      conv2_aLfsrChain_85 <= conv2_aLfsrChain_84;
      conv2_wLfsrChain_86 <= conv2_wLfsrChain_85;
      conv2_aLfsrChain_86 <= conv2_aLfsrChain_85;
      conv2_wLfsrChain_87 <= conv2_wLfsrChain_86;
      conv2_aLfsrChain_87 <= conv2_aLfsrChain_86;
      conv2_wLfsrChain_88 <= conv2_wLfsrChain_87;
      conv2_aLfsrChain_88 <= conv2_aLfsrChain_87;
      conv2_wLfsrChain_89 <= conv2_wLfsrChain_88;
      conv2_aLfsrChain_89 <= conv2_aLfsrChain_88;
      conv2_wLfsrChain_90 <= conv2_wLfsrChain_89;
      conv2_aLfsrChain_90 <= conv2_aLfsrChain_89;
      conv2_wLfsrChain_91 <= conv2_wLfsrChain_90;
      conv2_aLfsrChain_91 <= conv2_aLfsrChain_90;
      conv2_wLfsrChain_92 <= conv2_wLfsrChain_91;
      conv2_aLfsrChain_92 <= conv2_aLfsrChain_91;
      conv2_wLfsrChain_93 <= conv2_wLfsrChain_92;
      conv2_aLfsrChain_93 <= conv2_aLfsrChain_92;
      conv2_wLfsrChain_94 <= conv2_wLfsrChain_93;
      conv2_aLfsrChain_94 <= conv2_aLfsrChain_93;
      conv2_wLfsrChain_95 <= conv2_wLfsrChain_94;
      conv2_aLfsrChain_95 <= conv2_aLfsrChain_94;
      conv2_wLfsrChain_96 <= conv2_wLfsrChain_95;
      conv2_aLfsrChain_96 <= conv2_aLfsrChain_95;
      conv2_wLfsrChain_97 <= conv2_wLfsrChain_96;
      conv2_aLfsrChain_97 <= conv2_aLfsrChain_96;
      conv2_wLfsrChain_98 <= conv2_wLfsrChain_97;
      conv2_aLfsrChain_98 <= conv2_aLfsrChain_97;
      conv2_wLfsrChain_99 <= conv2_wLfsrChain_98;
      conv2_aLfsrChain_99 <= conv2_aLfsrChain_98;
      conv2_wLfsrChain_100 <= conv2_wLfsrChain_99;
      conv2_aLfsrChain_100 <= conv2_aLfsrChain_99;
      conv2_wLfsrChain_101 <= conv2_wLfsrChain_100;
      conv2_aLfsrChain_101 <= conv2_aLfsrChain_100;
      conv2_wLfsrChain_102 <= conv2_wLfsrChain_101;
      conv2_aLfsrChain_102 <= conv2_aLfsrChain_101;
      conv2_wLfsrChain_103 <= conv2_wLfsrChain_102;
      conv2_aLfsrChain_103 <= conv2_aLfsrChain_102;
      conv2_wLfsrChain_104 <= conv2_wLfsrChain_103;
      conv2_aLfsrChain_104 <= conv2_aLfsrChain_103;
      conv2_wLfsrChain_105 <= conv2_wLfsrChain_104;
      conv2_aLfsrChain_105 <= conv2_aLfsrChain_104;
      conv2_wLfsrChain_106 <= conv2_wLfsrChain_105;
      conv2_aLfsrChain_106 <= conv2_aLfsrChain_105;
      conv2_wLfsrChain_107 <= conv2_wLfsrChain_106;
      conv2_aLfsrChain_107 <= conv2_aLfsrChain_106;
      conv2_wLfsrChain_108 <= conv2_wLfsrChain_107;
      conv2_aLfsrChain_108 <= conv2_aLfsrChain_107;
      conv2_wLfsrChain_109 <= conv2_wLfsrChain_108;
      conv2_aLfsrChain_109 <= conv2_aLfsrChain_108;
      conv2_wLfsrChain_110 <= conv2_wLfsrChain_109;
      conv2_aLfsrChain_110 <= conv2_aLfsrChain_109;
      conv2_wLfsrChain_111 <= conv2_wLfsrChain_110;
      conv2_aLfsrChain_111 <= conv2_aLfsrChain_110;
      conv2_wLfsrChain_112 <= conv2_wLfsrChain_111;
      conv2_aLfsrChain_112 <= conv2_aLfsrChain_111;
      conv2_wLfsrChain_113 <= conv2_wLfsrChain_112;
      conv2_aLfsrChain_113 <= conv2_aLfsrChain_112;
      conv2_wLfsrChain_114 <= conv2_wLfsrChain_113;
      conv2_aLfsrChain_114 <= conv2_aLfsrChain_113;
      conv2_wLfsrChain_115 <= conv2_wLfsrChain_114;
      conv2_aLfsrChain_115 <= conv2_aLfsrChain_114;
      conv2_wLfsrChain_116 <= conv2_wLfsrChain_115;
      conv2_aLfsrChain_116 <= conv2_aLfsrChain_115;
      conv2_wLfsrChain_117 <= conv2_wLfsrChain_116;
      conv2_aLfsrChain_117 <= conv2_aLfsrChain_116;
      conv2_wLfsrChain_118 <= conv2_wLfsrChain_117;
      conv2_aLfsrChain_118 <= conv2_aLfsrChain_117;
      conv2_wLfsrChain_119 <= conv2_wLfsrChain_118;
      conv2_aLfsrChain_119 <= conv2_aLfsrChain_118;
      conv2_wLfsrChain_120 <= conv2_wLfsrChain_119;
      conv2_aLfsrChain_120 <= conv2_aLfsrChain_119;
      conv2_wLfsrChain_121 <= conv2_wLfsrChain_120;
      conv2_aLfsrChain_121 <= conv2_aLfsrChain_120;
      conv2_wLfsrChain_122 <= conv2_wLfsrChain_121;
      conv2_aLfsrChain_122 <= conv2_aLfsrChain_121;
      conv2_wLfsrChain_123 <= conv2_wLfsrChain_122;
      conv2_aLfsrChain_123 <= conv2_aLfsrChain_122;
      conv2_wLfsrChain_124 <= conv2_wLfsrChain_123;
      conv2_aLfsrChain_124 <= conv2_aLfsrChain_123;
      conv2_wLfsrChain_125 <= conv2_wLfsrChain_124;
      conv2_aLfsrChain_125 <= conv2_aLfsrChain_124;
      conv2_wLfsrChain_126 <= conv2_wLfsrChain_125;
      conv2_aLfsrChain_126 <= conv2_aLfsrChain_125;
      conv2_wLfsrChain_127 <= conv2_wLfsrChain_126;
      conv2_aLfsrChain_127 <= conv2_aLfsrChain_126;
      conv2_wLfsrChain_128 <= conv2_wLfsrChain_127;
      conv2_aLfsrChain_128 <= conv2_aLfsrChain_127;
      conv2_wLfsrChain_129 <= conv2_wLfsrChain_128;
      conv2_aLfsrChain_129 <= conv2_aLfsrChain_128;
      conv2_wLfsrChain_130 <= conv2_wLfsrChain_129;
      conv2_aLfsrChain_130 <= conv2_aLfsrChain_129;
      conv2_wLfsrChain_131 <= conv2_wLfsrChain_130;
      conv2_aLfsrChain_131 <= conv2_aLfsrChain_130;
      conv2_wLfsrChain_132 <= conv2_wLfsrChain_131;
      conv2_aLfsrChain_132 <= conv2_aLfsrChain_131;
      conv2_wLfsrChain_133 <= conv2_wLfsrChain_132;
      conv2_aLfsrChain_133 <= conv2_aLfsrChain_132;
      conv2_wLfsrChain_134 <= conv2_wLfsrChain_133;
      conv2_aLfsrChain_134 <= conv2_aLfsrChain_133;
      conv2_wLfsrChain_135 <= conv2_wLfsrChain_134;
      conv2_aLfsrChain_135 <= conv2_aLfsrChain_134;
      conv2_wLfsrChain_136 <= conv2_wLfsrChain_135;
      conv2_aLfsrChain_136 <= conv2_aLfsrChain_135;
      conv2_wLfsrChain_137 <= conv2_wLfsrChain_136;
      conv2_aLfsrChain_137 <= conv2_aLfsrChain_136;
      conv2_wLfsrChain_138 <= conv2_wLfsrChain_137;
      conv2_aLfsrChain_138 <= conv2_aLfsrChain_137;
      conv2_wLfsrChain_139 <= conv2_wLfsrChain_138;
      conv2_aLfsrChain_139 <= conv2_aLfsrChain_138;
      conv2_wLfsrChain_140 <= conv2_wLfsrChain_139;
      conv2_aLfsrChain_140 <= conv2_aLfsrChain_139;
      conv2_wLfsrChain_141 <= conv2_wLfsrChain_140;
      conv2_aLfsrChain_141 <= conv2_aLfsrChain_140;
      conv2_wLfsrChain_142 <= conv2_wLfsrChain_141;
      conv2_aLfsrChain_142 <= conv2_aLfsrChain_141;
      conv2_wLfsrChain_143 <= conv2_wLfsrChain_142;
      conv2_aLfsrChain_143 <= conv2_aLfsrChain_142;
      conv2_wLfsrChain_144 <= conv2_wLfsrChain_143;
      conv2_aLfsrChain_144 <= conv2_aLfsrChain_143;
      conv2_wLfsrChain_145 <= conv2_wLfsrChain_144;
      conv2_aLfsrChain_145 <= conv2_aLfsrChain_144;
      conv2_wLfsrChain_146 <= conv2_wLfsrChain_145;
      conv2_aLfsrChain_146 <= conv2_aLfsrChain_145;
      conv2_wLfsrChain_147 <= conv2_wLfsrChain_146;
      conv2_aLfsrChain_147 <= conv2_aLfsrChain_146;
      conv2_wLfsrChain_148 <= conv2_wLfsrChain_147;
      conv2_aLfsrChain_148 <= conv2_aLfsrChain_147;
      conv2_wLfsrChain_149 <= conv2_wLfsrChain_148;
      conv2_aLfsrChain_149 <= conv2_aLfsrChain_148;
      conv2_wLfsrChain_150 <= conv2_wLfsrChain_149;
      conv2_aLfsrChain_150 <= conv2_aLfsrChain_149;
      conv2_wLfsrChain_151 <= conv2_wLfsrChain_150;
      conv2_aLfsrChain_151 <= conv2_aLfsrChain_150;
      conv2_wLfsrChain_152 <= conv2_wLfsrChain_151;
      conv2_aLfsrChain_152 <= conv2_aLfsrChain_151;
      conv2_wLfsrChain_153 <= conv2_wLfsrChain_152;
      conv2_aLfsrChain_153 <= conv2_aLfsrChain_152;
      conv2_wLfsrChain_154 <= conv2_wLfsrChain_153;
      conv2_aLfsrChain_154 <= conv2_aLfsrChain_153;
      conv2_wLfsrChain_155 <= conv2_wLfsrChain_154;
      conv2_aLfsrChain_155 <= conv2_aLfsrChain_154;
      conv2_wLfsrChain_156 <= conv2_wLfsrChain_155;
      conv2_aLfsrChain_156 <= conv2_aLfsrChain_155;
      conv2_wLfsrChain_157 <= conv2_wLfsrChain_156;
      conv2_aLfsrChain_157 <= conv2_aLfsrChain_156;
      conv2_wLfsrChain_158 <= conv2_wLfsrChain_157;
      conv2_aLfsrChain_158 <= conv2_aLfsrChain_157;
      conv2_wLfsrChain_159 <= conv2_wLfsrChain_158;
      conv2_aLfsrChain_159 <= conv2_aLfsrChain_158;
      conv2_wLfsrChain_160 <= conv2_wLfsrChain_159;
      conv2_aLfsrChain_160 <= conv2_aLfsrChain_159;
      conv2_wLfsrChain_161 <= conv2_wLfsrChain_160;
      conv2_aLfsrChain_161 <= conv2_aLfsrChain_160;
      conv2_wLfsrChain_162 <= conv2_wLfsrChain_161;
      conv2_aLfsrChain_162 <= conv2_aLfsrChain_161;
      conv2_wLfsrChain_163 <= conv2_wLfsrChain_162;
      conv2_aLfsrChain_163 <= conv2_aLfsrChain_162;
      conv2_wLfsrChain_164 <= conv2_wLfsrChain_163;
      conv2_aLfsrChain_164 <= conv2_aLfsrChain_163;
      conv2_wLfsrChain_165 <= conv2_wLfsrChain_164;
      conv2_aLfsrChain_165 <= conv2_aLfsrChain_164;
      conv2_wLfsrChain_166 <= conv2_wLfsrChain_165;
      conv2_aLfsrChain_166 <= conv2_aLfsrChain_165;
      conv2_wLfsrChain_167 <= conv2_wLfsrChain_166;
      conv2_aLfsrChain_167 <= conv2_aLfsrChain_166;
      conv2_wLfsrChain_168 <= conv2_wLfsrChain_167;
      conv2_aLfsrChain_168 <= conv2_aLfsrChain_167;
      conv2_wLfsrChain_169 <= conv2_wLfsrChain_168;
      conv2_aLfsrChain_169 <= conv2_aLfsrChain_168;
      conv2_wLfsrChain_170 <= conv2_wLfsrChain_169;
      conv2_aLfsrChain_170 <= conv2_aLfsrChain_169;
      conv2_wLfsrChain_171 <= conv2_wLfsrChain_170;
      conv2_aLfsrChain_171 <= conv2_aLfsrChain_170;
      conv2_wLfsrChain_172 <= conv2_wLfsrChain_171;
      conv2_aLfsrChain_172 <= conv2_aLfsrChain_171;
      conv2_wLfsrChain_173 <= conv2_wLfsrChain_172;
      conv2_aLfsrChain_173 <= conv2_aLfsrChain_172;
      conv2_wLfsrChain_174 <= conv2_wLfsrChain_173;
      conv2_aLfsrChain_174 <= conv2_aLfsrChain_173;
      conv2_wLfsrChain_175 <= conv2_wLfsrChain_174;
      conv2_aLfsrChain_175 <= conv2_aLfsrChain_174;
      conv2_wLfsrChain_176 <= conv2_wLfsrChain_175;
      conv2_aLfsrChain_176 <= conv2_aLfsrChain_175;
      conv2_wLfsrChain_177 <= conv2_wLfsrChain_176;
      conv2_aLfsrChain_177 <= conv2_aLfsrChain_176;
      conv2_wLfsrChain_178 <= conv2_wLfsrChain_177;
      conv2_aLfsrChain_178 <= conv2_aLfsrChain_177;
      conv2_wLfsrChain_179 <= conv2_wLfsrChain_178;
      conv2_aLfsrChain_179 <= conv2_aLfsrChain_178;
      conv2_wLfsrChain_180 <= conv2_wLfsrChain_179;
      conv2_aLfsrChain_180 <= conv2_aLfsrChain_179;
      conv2_wLfsrChain_181 <= conv2_wLfsrChain_180;
      conv2_aLfsrChain_181 <= conv2_aLfsrChain_180;
      conv2_wLfsrChain_182 <= conv2_wLfsrChain_181;
      conv2_aLfsrChain_182 <= conv2_aLfsrChain_181;
      conv2_wLfsrChain_183 <= conv2_wLfsrChain_182;
      conv2_aLfsrChain_183 <= conv2_aLfsrChain_182;
      conv2_wLfsrChain_184 <= conv2_wLfsrChain_183;
      conv2_aLfsrChain_184 <= conv2_aLfsrChain_183;
      conv2_wLfsrChain_185 <= conv2_wLfsrChain_184;
      conv2_aLfsrChain_185 <= conv2_aLfsrChain_184;
      conv2_wLfsrChain_186 <= conv2_wLfsrChain_185;
      conv2_aLfsrChain_186 <= conv2_aLfsrChain_185;
      conv2_wLfsrChain_187 <= conv2_wLfsrChain_186;
      conv2_aLfsrChain_187 <= conv2_aLfsrChain_186;
      conv2_wLfsrChain_188 <= conv2_wLfsrChain_187;
      conv2_aLfsrChain_188 <= conv2_aLfsrChain_187;
      conv2_wLfsrChain_189 <= conv2_wLfsrChain_188;
      conv2_aLfsrChain_189 <= conv2_aLfsrChain_188;
      conv2_wLfsrChain_190 <= conv2_wLfsrChain_189;
      conv2_aLfsrChain_190 <= conv2_aLfsrChain_189;
      conv2_wLfsrChain_191 <= conv2_wLfsrChain_190;
      conv2_aLfsrChain_191 <= conv2_aLfsrChain_190;
      conv2_wLfsrChain_192 <= conv2_wLfsrChain_191;
      conv2_aLfsrChain_192 <= conv2_aLfsrChain_191;
      conv2_wLfsrChain_193 <= conv2_wLfsrChain_192;
      conv2_aLfsrChain_193 <= conv2_aLfsrChain_192;
      conv2_wLfsrChain_194 <= conv2_wLfsrChain_193;
      conv2_aLfsrChain_194 <= conv2_aLfsrChain_193;
      conv2_wLfsrChain_195 <= conv2_wLfsrChain_194;
      conv2_aLfsrChain_195 <= conv2_aLfsrChain_194;
      conv2_wLfsrChain_196 <= conv2_wLfsrChain_195;
      conv2_aLfsrChain_196 <= conv2_aLfsrChain_195;
      conv2_wLfsrChain_197 <= conv2_wLfsrChain_196;
      conv2_aLfsrChain_197 <= conv2_aLfsrChain_196;
      conv2_wLfsrChain_198 <= conv2_wLfsrChain_197;
      conv2_aLfsrChain_198 <= conv2_aLfsrChain_197;
      conv2_wLfsrChain_199 <= conv2_wLfsrChain_198;
      conv2_aLfsrChain_199 <= conv2_aLfsrChain_198;
      conv2_posBitRegs_0 <= (_zz_conv2_posBitRegs_0 && conv2_wSignRegs_0);
      conv2_negBitRegs_0 <= (_zz_conv2_posBitRegs_0 && (! conv2_wSignRegs_0));
      conv2_posBitRegs_1 <= (_zz_conv2_posBitRegs_1 && conv2_wSignRegs_1);
      conv2_negBitRegs_1 <= (_zz_conv2_posBitRegs_1 && (! conv2_wSignRegs_1));
      conv2_posBitRegs_2 <= (_zz_conv2_posBitRegs_2 && conv2_wSignRegs_2);
      conv2_negBitRegs_2 <= (_zz_conv2_posBitRegs_2 && (! conv2_wSignRegs_2));
      conv2_posBitRegs_3 <= (_zz_conv2_posBitRegs_3 && conv2_wSignRegs_3);
      conv2_negBitRegs_3 <= (_zz_conv2_posBitRegs_3 && (! conv2_wSignRegs_3));
      conv2_posBitRegs_4 <= (_zz_conv2_posBitRegs_4 && conv2_wSignRegs_4);
      conv2_negBitRegs_4 <= (_zz_conv2_posBitRegs_4 && (! conv2_wSignRegs_4));
      conv2_posBitRegs_5 <= (_zz_conv2_posBitRegs_5 && conv2_wSignRegs_5);
      conv2_negBitRegs_5 <= (_zz_conv2_posBitRegs_5 && (! conv2_wSignRegs_5));
      conv2_posBitRegs_6 <= (_zz_conv2_posBitRegs_6 && conv2_wSignRegs_6);
      conv2_negBitRegs_6 <= (_zz_conv2_posBitRegs_6 && (! conv2_wSignRegs_6));
      conv2_posBitRegs_7 <= (_zz_conv2_posBitRegs_7 && conv2_wSignRegs_7);
      conv2_negBitRegs_7 <= (_zz_conv2_posBitRegs_7 && (! conv2_wSignRegs_7));
      conv2_posBitRegs_8 <= (_zz_conv2_posBitRegs_8 && conv2_wSignRegs_8);
      conv2_negBitRegs_8 <= (_zz_conv2_posBitRegs_8 && (! conv2_wSignRegs_8));
      conv2_posBitRegs_9 <= (_zz_conv2_posBitRegs_9 && conv2_wSignRegs_9);
      conv2_negBitRegs_9 <= (_zz_conv2_posBitRegs_9 && (! conv2_wSignRegs_9));
      conv2_posBitRegs_10 <= (_zz_conv2_posBitRegs_10 && conv2_wSignRegs_10);
      conv2_negBitRegs_10 <= (_zz_conv2_posBitRegs_10 && (! conv2_wSignRegs_10));
      conv2_posBitRegs_11 <= (_zz_conv2_posBitRegs_11 && conv2_wSignRegs_11);
      conv2_negBitRegs_11 <= (_zz_conv2_posBitRegs_11 && (! conv2_wSignRegs_11));
      conv2_posBitRegs_12 <= (_zz_conv2_posBitRegs_12 && conv2_wSignRegs_12);
      conv2_negBitRegs_12 <= (_zz_conv2_posBitRegs_12 && (! conv2_wSignRegs_12));
      conv2_posBitRegs_13 <= (_zz_conv2_posBitRegs_13 && conv2_wSignRegs_13);
      conv2_negBitRegs_13 <= (_zz_conv2_posBitRegs_13 && (! conv2_wSignRegs_13));
      conv2_posBitRegs_14 <= (_zz_conv2_posBitRegs_14 && conv2_wSignRegs_14);
      conv2_negBitRegs_14 <= (_zz_conv2_posBitRegs_14 && (! conv2_wSignRegs_14));
      conv2_posBitRegs_15 <= (_zz_conv2_posBitRegs_15 && conv2_wSignRegs_15);
      conv2_negBitRegs_15 <= (_zz_conv2_posBitRegs_15 && (! conv2_wSignRegs_15));
      conv2_posBitRegs_16 <= (_zz_conv2_posBitRegs_16 && conv2_wSignRegs_16);
      conv2_negBitRegs_16 <= (_zz_conv2_posBitRegs_16 && (! conv2_wSignRegs_16));
      conv2_posBitRegs_17 <= (_zz_conv2_posBitRegs_17 && conv2_wSignRegs_17);
      conv2_negBitRegs_17 <= (_zz_conv2_posBitRegs_17 && (! conv2_wSignRegs_17));
      conv2_posBitRegs_18 <= (_zz_conv2_posBitRegs_18 && conv2_wSignRegs_18);
      conv2_negBitRegs_18 <= (_zz_conv2_posBitRegs_18 && (! conv2_wSignRegs_18));
      conv2_posBitRegs_19 <= (_zz_conv2_posBitRegs_19 && conv2_wSignRegs_19);
      conv2_negBitRegs_19 <= (_zz_conv2_posBitRegs_19 && (! conv2_wSignRegs_19));
      conv2_posBitRegs_20 <= (_zz_conv2_posBitRegs_20 && conv2_wSignRegs_20);
      conv2_negBitRegs_20 <= (_zz_conv2_posBitRegs_20 && (! conv2_wSignRegs_20));
      conv2_posBitRegs_21 <= (_zz_conv2_posBitRegs_21 && conv2_wSignRegs_21);
      conv2_negBitRegs_21 <= (_zz_conv2_posBitRegs_21 && (! conv2_wSignRegs_21));
      conv2_posBitRegs_22 <= (_zz_conv2_posBitRegs_22 && conv2_wSignRegs_22);
      conv2_negBitRegs_22 <= (_zz_conv2_posBitRegs_22 && (! conv2_wSignRegs_22));
      conv2_posBitRegs_23 <= (_zz_conv2_posBitRegs_23 && conv2_wSignRegs_23);
      conv2_negBitRegs_23 <= (_zz_conv2_posBitRegs_23 && (! conv2_wSignRegs_23));
      conv2_posBitRegs_24 <= (_zz_conv2_posBitRegs_24 && conv2_wSignRegs_24);
      conv2_negBitRegs_24 <= (_zz_conv2_posBitRegs_24 && (! conv2_wSignRegs_24));
      conv2_posBitRegs_25 <= (_zz_conv2_posBitRegs_25 && conv2_wSignRegs_25);
      conv2_negBitRegs_25 <= (_zz_conv2_posBitRegs_25 && (! conv2_wSignRegs_25));
      conv2_posBitRegs_26 <= (_zz_conv2_posBitRegs_26 && conv2_wSignRegs_26);
      conv2_negBitRegs_26 <= (_zz_conv2_posBitRegs_26 && (! conv2_wSignRegs_26));
      conv2_posBitRegs_27 <= (_zz_conv2_posBitRegs_27 && conv2_wSignRegs_27);
      conv2_negBitRegs_27 <= (_zz_conv2_posBitRegs_27 && (! conv2_wSignRegs_27));
      conv2_posBitRegs_28 <= (_zz_conv2_posBitRegs_28 && conv2_wSignRegs_28);
      conv2_negBitRegs_28 <= (_zz_conv2_posBitRegs_28 && (! conv2_wSignRegs_28));
      conv2_posBitRegs_29 <= (_zz_conv2_posBitRegs_29 && conv2_wSignRegs_29);
      conv2_negBitRegs_29 <= (_zz_conv2_posBitRegs_29 && (! conv2_wSignRegs_29));
      conv2_posBitRegs_30 <= (_zz_conv2_posBitRegs_30 && conv2_wSignRegs_30);
      conv2_negBitRegs_30 <= (_zz_conv2_posBitRegs_30 && (! conv2_wSignRegs_30));
      conv2_posBitRegs_31 <= (_zz_conv2_posBitRegs_31 && conv2_wSignRegs_31);
      conv2_negBitRegs_31 <= (_zz_conv2_posBitRegs_31 && (! conv2_wSignRegs_31));
      conv2_posBitRegs_32 <= (_zz_conv2_posBitRegs_32 && conv2_wSignRegs_32);
      conv2_negBitRegs_32 <= (_zz_conv2_posBitRegs_32 && (! conv2_wSignRegs_32));
      conv2_posBitRegs_33 <= (_zz_conv2_posBitRegs_33 && conv2_wSignRegs_33);
      conv2_negBitRegs_33 <= (_zz_conv2_posBitRegs_33 && (! conv2_wSignRegs_33));
      conv2_posBitRegs_34 <= (_zz_conv2_posBitRegs_34 && conv2_wSignRegs_34);
      conv2_negBitRegs_34 <= (_zz_conv2_posBitRegs_34 && (! conv2_wSignRegs_34));
      conv2_posBitRegs_35 <= (_zz_conv2_posBitRegs_35 && conv2_wSignRegs_35);
      conv2_negBitRegs_35 <= (_zz_conv2_posBitRegs_35 && (! conv2_wSignRegs_35));
      conv2_posBitRegs_36 <= (_zz_conv2_posBitRegs_36 && conv2_wSignRegs_36);
      conv2_negBitRegs_36 <= (_zz_conv2_posBitRegs_36 && (! conv2_wSignRegs_36));
      conv2_posBitRegs_37 <= (_zz_conv2_posBitRegs_37 && conv2_wSignRegs_37);
      conv2_negBitRegs_37 <= (_zz_conv2_posBitRegs_37 && (! conv2_wSignRegs_37));
      conv2_posBitRegs_38 <= (_zz_conv2_posBitRegs_38 && conv2_wSignRegs_38);
      conv2_negBitRegs_38 <= (_zz_conv2_posBitRegs_38 && (! conv2_wSignRegs_38));
      conv2_posBitRegs_39 <= (_zz_conv2_posBitRegs_39 && conv2_wSignRegs_39);
      conv2_negBitRegs_39 <= (_zz_conv2_posBitRegs_39 && (! conv2_wSignRegs_39));
      conv2_posBitRegs_40 <= (_zz_conv2_posBitRegs_40 && conv2_wSignRegs_40);
      conv2_negBitRegs_40 <= (_zz_conv2_posBitRegs_40 && (! conv2_wSignRegs_40));
      conv2_posBitRegs_41 <= (_zz_conv2_posBitRegs_41 && conv2_wSignRegs_41);
      conv2_negBitRegs_41 <= (_zz_conv2_posBitRegs_41 && (! conv2_wSignRegs_41));
      conv2_posBitRegs_42 <= (_zz_conv2_posBitRegs_42 && conv2_wSignRegs_42);
      conv2_negBitRegs_42 <= (_zz_conv2_posBitRegs_42 && (! conv2_wSignRegs_42));
      conv2_posBitRegs_43 <= (_zz_conv2_posBitRegs_43 && conv2_wSignRegs_43);
      conv2_negBitRegs_43 <= (_zz_conv2_posBitRegs_43 && (! conv2_wSignRegs_43));
      conv2_posBitRegs_44 <= (_zz_conv2_posBitRegs_44 && conv2_wSignRegs_44);
      conv2_negBitRegs_44 <= (_zz_conv2_posBitRegs_44 && (! conv2_wSignRegs_44));
      conv2_posBitRegs_45 <= (_zz_conv2_posBitRegs_45 && conv2_wSignRegs_45);
      conv2_negBitRegs_45 <= (_zz_conv2_posBitRegs_45 && (! conv2_wSignRegs_45));
      conv2_posBitRegs_46 <= (_zz_conv2_posBitRegs_46 && conv2_wSignRegs_46);
      conv2_negBitRegs_46 <= (_zz_conv2_posBitRegs_46 && (! conv2_wSignRegs_46));
      conv2_posBitRegs_47 <= (_zz_conv2_posBitRegs_47 && conv2_wSignRegs_47);
      conv2_negBitRegs_47 <= (_zz_conv2_posBitRegs_47 && (! conv2_wSignRegs_47));
      conv2_posBitRegs_48 <= (_zz_conv2_posBitRegs_48 && conv2_wSignRegs_48);
      conv2_negBitRegs_48 <= (_zz_conv2_posBitRegs_48 && (! conv2_wSignRegs_48));
      conv2_posBitRegs_49 <= (_zz_conv2_posBitRegs_49 && conv2_wSignRegs_49);
      conv2_negBitRegs_49 <= (_zz_conv2_posBitRegs_49 && (! conv2_wSignRegs_49));
      conv2_posBitRegs_50 <= (_zz_conv2_posBitRegs_50 && conv2_wSignRegs_50);
      conv2_negBitRegs_50 <= (_zz_conv2_posBitRegs_50 && (! conv2_wSignRegs_50));
      conv2_posBitRegs_51 <= (_zz_conv2_posBitRegs_51 && conv2_wSignRegs_51);
      conv2_negBitRegs_51 <= (_zz_conv2_posBitRegs_51 && (! conv2_wSignRegs_51));
      conv2_posBitRegs_52 <= (_zz_conv2_posBitRegs_52 && conv2_wSignRegs_52);
      conv2_negBitRegs_52 <= (_zz_conv2_posBitRegs_52 && (! conv2_wSignRegs_52));
      conv2_posBitRegs_53 <= (_zz_conv2_posBitRegs_53 && conv2_wSignRegs_53);
      conv2_negBitRegs_53 <= (_zz_conv2_posBitRegs_53 && (! conv2_wSignRegs_53));
      conv2_posBitRegs_54 <= (_zz_conv2_posBitRegs_54 && conv2_wSignRegs_54);
      conv2_negBitRegs_54 <= (_zz_conv2_posBitRegs_54 && (! conv2_wSignRegs_54));
      conv2_posBitRegs_55 <= (_zz_conv2_posBitRegs_55 && conv2_wSignRegs_55);
      conv2_negBitRegs_55 <= (_zz_conv2_posBitRegs_55 && (! conv2_wSignRegs_55));
      conv2_posBitRegs_56 <= (_zz_conv2_posBitRegs_56 && conv2_wSignRegs_56);
      conv2_negBitRegs_56 <= (_zz_conv2_posBitRegs_56 && (! conv2_wSignRegs_56));
      conv2_posBitRegs_57 <= (_zz_conv2_posBitRegs_57 && conv2_wSignRegs_57);
      conv2_negBitRegs_57 <= (_zz_conv2_posBitRegs_57 && (! conv2_wSignRegs_57));
      conv2_posBitRegs_58 <= (_zz_conv2_posBitRegs_58 && conv2_wSignRegs_58);
      conv2_negBitRegs_58 <= (_zz_conv2_posBitRegs_58 && (! conv2_wSignRegs_58));
      conv2_posBitRegs_59 <= (_zz_conv2_posBitRegs_59 && conv2_wSignRegs_59);
      conv2_negBitRegs_59 <= (_zz_conv2_posBitRegs_59 && (! conv2_wSignRegs_59));
      conv2_posBitRegs_60 <= (_zz_conv2_posBitRegs_60 && conv2_wSignRegs_60);
      conv2_negBitRegs_60 <= (_zz_conv2_posBitRegs_60 && (! conv2_wSignRegs_60));
      conv2_posBitRegs_61 <= (_zz_conv2_posBitRegs_61 && conv2_wSignRegs_61);
      conv2_negBitRegs_61 <= (_zz_conv2_posBitRegs_61 && (! conv2_wSignRegs_61));
      conv2_posBitRegs_62 <= (_zz_conv2_posBitRegs_62 && conv2_wSignRegs_62);
      conv2_negBitRegs_62 <= (_zz_conv2_posBitRegs_62 && (! conv2_wSignRegs_62));
      conv2_posBitRegs_63 <= (_zz_conv2_posBitRegs_63 && conv2_wSignRegs_63);
      conv2_negBitRegs_63 <= (_zz_conv2_posBitRegs_63 && (! conv2_wSignRegs_63));
      conv2_posBitRegs_64 <= (_zz_conv2_posBitRegs_64 && conv2_wSignRegs_64);
      conv2_negBitRegs_64 <= (_zz_conv2_posBitRegs_64 && (! conv2_wSignRegs_64));
      conv2_posBitRegs_65 <= (_zz_conv2_posBitRegs_65 && conv2_wSignRegs_65);
      conv2_negBitRegs_65 <= (_zz_conv2_posBitRegs_65 && (! conv2_wSignRegs_65));
      conv2_posBitRegs_66 <= (_zz_conv2_posBitRegs_66 && conv2_wSignRegs_66);
      conv2_negBitRegs_66 <= (_zz_conv2_posBitRegs_66 && (! conv2_wSignRegs_66));
      conv2_posBitRegs_67 <= (_zz_conv2_posBitRegs_67 && conv2_wSignRegs_67);
      conv2_negBitRegs_67 <= (_zz_conv2_posBitRegs_67 && (! conv2_wSignRegs_67));
      conv2_posBitRegs_68 <= (_zz_conv2_posBitRegs_68 && conv2_wSignRegs_68);
      conv2_negBitRegs_68 <= (_zz_conv2_posBitRegs_68 && (! conv2_wSignRegs_68));
      conv2_posBitRegs_69 <= (_zz_conv2_posBitRegs_69 && conv2_wSignRegs_69);
      conv2_negBitRegs_69 <= (_zz_conv2_posBitRegs_69 && (! conv2_wSignRegs_69));
      conv2_posBitRegs_70 <= (_zz_conv2_posBitRegs_70 && conv2_wSignRegs_70);
      conv2_negBitRegs_70 <= (_zz_conv2_posBitRegs_70 && (! conv2_wSignRegs_70));
      conv2_posBitRegs_71 <= (_zz_conv2_posBitRegs_71 && conv2_wSignRegs_71);
      conv2_negBitRegs_71 <= (_zz_conv2_posBitRegs_71 && (! conv2_wSignRegs_71));
      conv2_posBitRegs_72 <= (_zz_conv2_posBitRegs_72 && conv2_wSignRegs_72);
      conv2_negBitRegs_72 <= (_zz_conv2_posBitRegs_72 && (! conv2_wSignRegs_72));
      conv2_posBitRegs_73 <= (_zz_conv2_posBitRegs_73 && conv2_wSignRegs_73);
      conv2_negBitRegs_73 <= (_zz_conv2_posBitRegs_73 && (! conv2_wSignRegs_73));
      conv2_posBitRegs_74 <= (_zz_conv2_posBitRegs_74 && conv2_wSignRegs_74);
      conv2_negBitRegs_74 <= (_zz_conv2_posBitRegs_74 && (! conv2_wSignRegs_74));
      conv2_posBitRegs_75 <= (_zz_conv2_posBitRegs_75 && conv2_wSignRegs_75);
      conv2_negBitRegs_75 <= (_zz_conv2_posBitRegs_75 && (! conv2_wSignRegs_75));
      conv2_posBitRegs_76 <= (_zz_conv2_posBitRegs_76 && conv2_wSignRegs_76);
      conv2_negBitRegs_76 <= (_zz_conv2_posBitRegs_76 && (! conv2_wSignRegs_76));
      conv2_posBitRegs_77 <= (_zz_conv2_posBitRegs_77 && conv2_wSignRegs_77);
      conv2_negBitRegs_77 <= (_zz_conv2_posBitRegs_77 && (! conv2_wSignRegs_77));
      conv2_posBitRegs_78 <= (_zz_conv2_posBitRegs_78 && conv2_wSignRegs_78);
      conv2_negBitRegs_78 <= (_zz_conv2_posBitRegs_78 && (! conv2_wSignRegs_78));
      conv2_posBitRegs_79 <= (_zz_conv2_posBitRegs_79 && conv2_wSignRegs_79);
      conv2_negBitRegs_79 <= (_zz_conv2_posBitRegs_79 && (! conv2_wSignRegs_79));
      conv2_posBitRegs_80 <= (_zz_conv2_posBitRegs_80 && conv2_wSignRegs_80);
      conv2_negBitRegs_80 <= (_zz_conv2_posBitRegs_80 && (! conv2_wSignRegs_80));
      conv2_posBitRegs_81 <= (_zz_conv2_posBitRegs_81 && conv2_wSignRegs_81);
      conv2_negBitRegs_81 <= (_zz_conv2_posBitRegs_81 && (! conv2_wSignRegs_81));
      conv2_posBitRegs_82 <= (_zz_conv2_posBitRegs_82 && conv2_wSignRegs_82);
      conv2_negBitRegs_82 <= (_zz_conv2_posBitRegs_82 && (! conv2_wSignRegs_82));
      conv2_posBitRegs_83 <= (_zz_conv2_posBitRegs_83 && conv2_wSignRegs_83);
      conv2_negBitRegs_83 <= (_zz_conv2_posBitRegs_83 && (! conv2_wSignRegs_83));
      conv2_posBitRegs_84 <= (_zz_conv2_posBitRegs_84 && conv2_wSignRegs_84);
      conv2_negBitRegs_84 <= (_zz_conv2_posBitRegs_84 && (! conv2_wSignRegs_84));
      conv2_posBitRegs_85 <= (_zz_conv2_posBitRegs_85 && conv2_wSignRegs_85);
      conv2_negBitRegs_85 <= (_zz_conv2_posBitRegs_85 && (! conv2_wSignRegs_85));
      conv2_posBitRegs_86 <= (_zz_conv2_posBitRegs_86 && conv2_wSignRegs_86);
      conv2_negBitRegs_86 <= (_zz_conv2_posBitRegs_86 && (! conv2_wSignRegs_86));
      conv2_posBitRegs_87 <= (_zz_conv2_posBitRegs_87 && conv2_wSignRegs_87);
      conv2_negBitRegs_87 <= (_zz_conv2_posBitRegs_87 && (! conv2_wSignRegs_87));
      conv2_posBitRegs_88 <= (_zz_conv2_posBitRegs_88 && conv2_wSignRegs_88);
      conv2_negBitRegs_88 <= (_zz_conv2_posBitRegs_88 && (! conv2_wSignRegs_88));
      conv2_posBitRegs_89 <= (_zz_conv2_posBitRegs_89 && conv2_wSignRegs_89);
      conv2_negBitRegs_89 <= (_zz_conv2_posBitRegs_89 && (! conv2_wSignRegs_89));
      conv2_posBitRegs_90 <= (_zz_conv2_posBitRegs_90 && conv2_wSignRegs_90);
      conv2_negBitRegs_90 <= (_zz_conv2_posBitRegs_90 && (! conv2_wSignRegs_90));
      conv2_posBitRegs_91 <= (_zz_conv2_posBitRegs_91 && conv2_wSignRegs_91);
      conv2_negBitRegs_91 <= (_zz_conv2_posBitRegs_91 && (! conv2_wSignRegs_91));
      conv2_posBitRegs_92 <= (_zz_conv2_posBitRegs_92 && conv2_wSignRegs_92);
      conv2_negBitRegs_92 <= (_zz_conv2_posBitRegs_92 && (! conv2_wSignRegs_92));
      conv2_posBitRegs_93 <= (_zz_conv2_posBitRegs_93 && conv2_wSignRegs_93);
      conv2_negBitRegs_93 <= (_zz_conv2_posBitRegs_93 && (! conv2_wSignRegs_93));
      conv2_posBitRegs_94 <= (_zz_conv2_posBitRegs_94 && conv2_wSignRegs_94);
      conv2_negBitRegs_94 <= (_zz_conv2_posBitRegs_94 && (! conv2_wSignRegs_94));
      conv2_posBitRegs_95 <= (_zz_conv2_posBitRegs_95 && conv2_wSignRegs_95);
      conv2_negBitRegs_95 <= (_zz_conv2_posBitRegs_95 && (! conv2_wSignRegs_95));
      conv2_posBitRegs_96 <= (_zz_conv2_posBitRegs_96 && conv2_wSignRegs_96);
      conv2_negBitRegs_96 <= (_zz_conv2_posBitRegs_96 && (! conv2_wSignRegs_96));
      conv2_posBitRegs_97 <= (_zz_conv2_posBitRegs_97 && conv2_wSignRegs_97);
      conv2_negBitRegs_97 <= (_zz_conv2_posBitRegs_97 && (! conv2_wSignRegs_97));
      conv2_posBitRegs_98 <= (_zz_conv2_posBitRegs_98 && conv2_wSignRegs_98);
      conv2_negBitRegs_98 <= (_zz_conv2_posBitRegs_98 && (! conv2_wSignRegs_98));
      conv2_posBitRegs_99 <= (_zz_conv2_posBitRegs_99 && conv2_wSignRegs_99);
      conv2_negBitRegs_99 <= (_zz_conv2_posBitRegs_99 && (! conv2_wSignRegs_99));
      conv2_posBitRegs_100 <= (_zz_conv2_posBitRegs_100 && conv2_wSignRegs_100);
      conv2_negBitRegs_100 <= (_zz_conv2_posBitRegs_100 && (! conv2_wSignRegs_100));
      conv2_posBitRegs_101 <= (_zz_conv2_posBitRegs_101 && conv2_wSignRegs_101);
      conv2_negBitRegs_101 <= (_zz_conv2_posBitRegs_101 && (! conv2_wSignRegs_101));
      conv2_posBitRegs_102 <= (_zz_conv2_posBitRegs_102 && conv2_wSignRegs_102);
      conv2_negBitRegs_102 <= (_zz_conv2_posBitRegs_102 && (! conv2_wSignRegs_102));
      conv2_posBitRegs_103 <= (_zz_conv2_posBitRegs_103 && conv2_wSignRegs_103);
      conv2_negBitRegs_103 <= (_zz_conv2_posBitRegs_103 && (! conv2_wSignRegs_103));
      conv2_posBitRegs_104 <= (_zz_conv2_posBitRegs_104 && conv2_wSignRegs_104);
      conv2_negBitRegs_104 <= (_zz_conv2_posBitRegs_104 && (! conv2_wSignRegs_104));
      conv2_posBitRegs_105 <= (_zz_conv2_posBitRegs_105 && conv2_wSignRegs_105);
      conv2_negBitRegs_105 <= (_zz_conv2_posBitRegs_105 && (! conv2_wSignRegs_105));
      conv2_posBitRegs_106 <= (_zz_conv2_posBitRegs_106 && conv2_wSignRegs_106);
      conv2_negBitRegs_106 <= (_zz_conv2_posBitRegs_106 && (! conv2_wSignRegs_106));
      conv2_posBitRegs_107 <= (_zz_conv2_posBitRegs_107 && conv2_wSignRegs_107);
      conv2_negBitRegs_107 <= (_zz_conv2_posBitRegs_107 && (! conv2_wSignRegs_107));
      conv2_posBitRegs_108 <= (_zz_conv2_posBitRegs_108 && conv2_wSignRegs_108);
      conv2_negBitRegs_108 <= (_zz_conv2_posBitRegs_108 && (! conv2_wSignRegs_108));
      conv2_posBitRegs_109 <= (_zz_conv2_posBitRegs_109 && conv2_wSignRegs_109);
      conv2_negBitRegs_109 <= (_zz_conv2_posBitRegs_109 && (! conv2_wSignRegs_109));
      conv2_posBitRegs_110 <= (_zz_conv2_posBitRegs_110 && conv2_wSignRegs_110);
      conv2_negBitRegs_110 <= (_zz_conv2_posBitRegs_110 && (! conv2_wSignRegs_110));
      conv2_posBitRegs_111 <= (_zz_conv2_posBitRegs_111 && conv2_wSignRegs_111);
      conv2_negBitRegs_111 <= (_zz_conv2_posBitRegs_111 && (! conv2_wSignRegs_111));
      conv2_posBitRegs_112 <= (_zz_conv2_posBitRegs_112 && conv2_wSignRegs_112);
      conv2_negBitRegs_112 <= (_zz_conv2_posBitRegs_112 && (! conv2_wSignRegs_112));
      conv2_posBitRegs_113 <= (_zz_conv2_posBitRegs_113 && conv2_wSignRegs_113);
      conv2_negBitRegs_113 <= (_zz_conv2_posBitRegs_113 && (! conv2_wSignRegs_113));
      conv2_posBitRegs_114 <= (_zz_conv2_posBitRegs_114 && conv2_wSignRegs_114);
      conv2_negBitRegs_114 <= (_zz_conv2_posBitRegs_114 && (! conv2_wSignRegs_114));
      conv2_posBitRegs_115 <= (_zz_conv2_posBitRegs_115 && conv2_wSignRegs_115);
      conv2_negBitRegs_115 <= (_zz_conv2_posBitRegs_115 && (! conv2_wSignRegs_115));
      conv2_posBitRegs_116 <= (_zz_conv2_posBitRegs_116 && conv2_wSignRegs_116);
      conv2_negBitRegs_116 <= (_zz_conv2_posBitRegs_116 && (! conv2_wSignRegs_116));
      conv2_posBitRegs_117 <= (_zz_conv2_posBitRegs_117 && conv2_wSignRegs_117);
      conv2_negBitRegs_117 <= (_zz_conv2_posBitRegs_117 && (! conv2_wSignRegs_117));
      conv2_posBitRegs_118 <= (_zz_conv2_posBitRegs_118 && conv2_wSignRegs_118);
      conv2_negBitRegs_118 <= (_zz_conv2_posBitRegs_118 && (! conv2_wSignRegs_118));
      conv2_posBitRegs_119 <= (_zz_conv2_posBitRegs_119 && conv2_wSignRegs_119);
      conv2_negBitRegs_119 <= (_zz_conv2_posBitRegs_119 && (! conv2_wSignRegs_119));
      conv2_posBitRegs_120 <= (_zz_conv2_posBitRegs_120 && conv2_wSignRegs_120);
      conv2_negBitRegs_120 <= (_zz_conv2_posBitRegs_120 && (! conv2_wSignRegs_120));
      conv2_posBitRegs_121 <= (_zz_conv2_posBitRegs_121 && conv2_wSignRegs_121);
      conv2_negBitRegs_121 <= (_zz_conv2_posBitRegs_121 && (! conv2_wSignRegs_121));
      conv2_posBitRegs_122 <= (_zz_conv2_posBitRegs_122 && conv2_wSignRegs_122);
      conv2_negBitRegs_122 <= (_zz_conv2_posBitRegs_122 && (! conv2_wSignRegs_122));
      conv2_posBitRegs_123 <= (_zz_conv2_posBitRegs_123 && conv2_wSignRegs_123);
      conv2_negBitRegs_123 <= (_zz_conv2_posBitRegs_123 && (! conv2_wSignRegs_123));
      conv2_posBitRegs_124 <= (_zz_conv2_posBitRegs_124 && conv2_wSignRegs_124);
      conv2_negBitRegs_124 <= (_zz_conv2_posBitRegs_124 && (! conv2_wSignRegs_124));
      conv2_posBitRegs_125 <= (_zz_conv2_posBitRegs_125 && conv2_wSignRegs_125);
      conv2_negBitRegs_125 <= (_zz_conv2_posBitRegs_125 && (! conv2_wSignRegs_125));
      conv2_posBitRegs_126 <= (_zz_conv2_posBitRegs_126 && conv2_wSignRegs_126);
      conv2_negBitRegs_126 <= (_zz_conv2_posBitRegs_126 && (! conv2_wSignRegs_126));
      conv2_posBitRegs_127 <= (_zz_conv2_posBitRegs_127 && conv2_wSignRegs_127);
      conv2_negBitRegs_127 <= (_zz_conv2_posBitRegs_127 && (! conv2_wSignRegs_127));
      conv2_posBitRegs_128 <= (_zz_conv2_posBitRegs_128 && conv2_wSignRegs_128);
      conv2_negBitRegs_128 <= (_zz_conv2_posBitRegs_128 && (! conv2_wSignRegs_128));
      conv2_posBitRegs_129 <= (_zz_conv2_posBitRegs_129 && conv2_wSignRegs_129);
      conv2_negBitRegs_129 <= (_zz_conv2_posBitRegs_129 && (! conv2_wSignRegs_129));
      conv2_posBitRegs_130 <= (_zz_conv2_posBitRegs_130 && conv2_wSignRegs_130);
      conv2_negBitRegs_130 <= (_zz_conv2_posBitRegs_130 && (! conv2_wSignRegs_130));
      conv2_posBitRegs_131 <= (_zz_conv2_posBitRegs_131 && conv2_wSignRegs_131);
      conv2_negBitRegs_131 <= (_zz_conv2_posBitRegs_131 && (! conv2_wSignRegs_131));
      conv2_posBitRegs_132 <= (_zz_conv2_posBitRegs_132 && conv2_wSignRegs_132);
      conv2_negBitRegs_132 <= (_zz_conv2_posBitRegs_132 && (! conv2_wSignRegs_132));
      conv2_posBitRegs_133 <= (_zz_conv2_posBitRegs_133 && conv2_wSignRegs_133);
      conv2_negBitRegs_133 <= (_zz_conv2_posBitRegs_133 && (! conv2_wSignRegs_133));
      conv2_posBitRegs_134 <= (_zz_conv2_posBitRegs_134 && conv2_wSignRegs_134);
      conv2_negBitRegs_134 <= (_zz_conv2_posBitRegs_134 && (! conv2_wSignRegs_134));
      conv2_posBitRegs_135 <= (_zz_conv2_posBitRegs_135 && conv2_wSignRegs_135);
      conv2_negBitRegs_135 <= (_zz_conv2_posBitRegs_135 && (! conv2_wSignRegs_135));
      conv2_posBitRegs_136 <= (_zz_conv2_posBitRegs_136 && conv2_wSignRegs_136);
      conv2_negBitRegs_136 <= (_zz_conv2_posBitRegs_136 && (! conv2_wSignRegs_136));
      conv2_posBitRegs_137 <= (_zz_conv2_posBitRegs_137 && conv2_wSignRegs_137);
      conv2_negBitRegs_137 <= (_zz_conv2_posBitRegs_137 && (! conv2_wSignRegs_137));
      conv2_posBitRegs_138 <= (_zz_conv2_posBitRegs_138 && conv2_wSignRegs_138);
      conv2_negBitRegs_138 <= (_zz_conv2_posBitRegs_138 && (! conv2_wSignRegs_138));
      conv2_posBitRegs_139 <= (_zz_conv2_posBitRegs_139 && conv2_wSignRegs_139);
      conv2_negBitRegs_139 <= (_zz_conv2_posBitRegs_139 && (! conv2_wSignRegs_139));
      conv2_posBitRegs_140 <= (_zz_conv2_posBitRegs_140 && conv2_wSignRegs_140);
      conv2_negBitRegs_140 <= (_zz_conv2_posBitRegs_140 && (! conv2_wSignRegs_140));
      conv2_posBitRegs_141 <= (_zz_conv2_posBitRegs_141 && conv2_wSignRegs_141);
      conv2_negBitRegs_141 <= (_zz_conv2_posBitRegs_141 && (! conv2_wSignRegs_141));
      conv2_posBitRegs_142 <= (_zz_conv2_posBitRegs_142 && conv2_wSignRegs_142);
      conv2_negBitRegs_142 <= (_zz_conv2_posBitRegs_142 && (! conv2_wSignRegs_142));
      conv2_posBitRegs_143 <= (_zz_conv2_posBitRegs_143 && conv2_wSignRegs_143);
      conv2_negBitRegs_143 <= (_zz_conv2_posBitRegs_143 && (! conv2_wSignRegs_143));
      conv2_posBitRegs_144 <= (_zz_conv2_posBitRegs_144 && conv2_wSignRegs_144);
      conv2_negBitRegs_144 <= (_zz_conv2_posBitRegs_144 && (! conv2_wSignRegs_144));
      conv2_posBitRegs_145 <= (_zz_conv2_posBitRegs_145 && conv2_wSignRegs_145);
      conv2_negBitRegs_145 <= (_zz_conv2_posBitRegs_145 && (! conv2_wSignRegs_145));
      conv2_posBitRegs_146 <= (_zz_conv2_posBitRegs_146 && conv2_wSignRegs_146);
      conv2_negBitRegs_146 <= (_zz_conv2_posBitRegs_146 && (! conv2_wSignRegs_146));
      conv2_posBitRegs_147 <= (_zz_conv2_posBitRegs_147 && conv2_wSignRegs_147);
      conv2_negBitRegs_147 <= (_zz_conv2_posBitRegs_147 && (! conv2_wSignRegs_147));
      conv2_posBitRegs_148 <= (_zz_conv2_posBitRegs_148 && conv2_wSignRegs_148);
      conv2_negBitRegs_148 <= (_zz_conv2_posBitRegs_148 && (! conv2_wSignRegs_148));
      conv2_posBitRegs_149 <= (_zz_conv2_posBitRegs_149 && conv2_wSignRegs_149);
      conv2_negBitRegs_149 <= (_zz_conv2_posBitRegs_149 && (! conv2_wSignRegs_149));
      conv2_posBitRegs_150 <= (_zz_conv2_posBitRegs_150 && conv2_wSignRegs_150);
      conv2_negBitRegs_150 <= (_zz_conv2_posBitRegs_150 && (! conv2_wSignRegs_150));
      conv2_posBitRegs_151 <= (_zz_conv2_posBitRegs_151 && conv2_wSignRegs_151);
      conv2_negBitRegs_151 <= (_zz_conv2_posBitRegs_151 && (! conv2_wSignRegs_151));
      conv2_posBitRegs_152 <= (_zz_conv2_posBitRegs_152 && conv2_wSignRegs_152);
      conv2_negBitRegs_152 <= (_zz_conv2_posBitRegs_152 && (! conv2_wSignRegs_152));
      conv2_posBitRegs_153 <= (_zz_conv2_posBitRegs_153 && conv2_wSignRegs_153);
      conv2_negBitRegs_153 <= (_zz_conv2_posBitRegs_153 && (! conv2_wSignRegs_153));
      conv2_posBitRegs_154 <= (_zz_conv2_posBitRegs_154 && conv2_wSignRegs_154);
      conv2_negBitRegs_154 <= (_zz_conv2_posBitRegs_154 && (! conv2_wSignRegs_154));
      conv2_posBitRegs_155 <= (_zz_conv2_posBitRegs_155 && conv2_wSignRegs_155);
      conv2_negBitRegs_155 <= (_zz_conv2_posBitRegs_155 && (! conv2_wSignRegs_155));
      conv2_posBitRegs_156 <= (_zz_conv2_posBitRegs_156 && conv2_wSignRegs_156);
      conv2_negBitRegs_156 <= (_zz_conv2_posBitRegs_156 && (! conv2_wSignRegs_156));
      conv2_posBitRegs_157 <= (_zz_conv2_posBitRegs_157 && conv2_wSignRegs_157);
      conv2_negBitRegs_157 <= (_zz_conv2_posBitRegs_157 && (! conv2_wSignRegs_157));
      conv2_posBitRegs_158 <= (_zz_conv2_posBitRegs_158 && conv2_wSignRegs_158);
      conv2_negBitRegs_158 <= (_zz_conv2_posBitRegs_158 && (! conv2_wSignRegs_158));
      conv2_posBitRegs_159 <= (_zz_conv2_posBitRegs_159 && conv2_wSignRegs_159);
      conv2_negBitRegs_159 <= (_zz_conv2_posBitRegs_159 && (! conv2_wSignRegs_159));
      conv2_posBitRegs_160 <= (_zz_conv2_posBitRegs_160 && conv2_wSignRegs_160);
      conv2_negBitRegs_160 <= (_zz_conv2_posBitRegs_160 && (! conv2_wSignRegs_160));
      conv2_posBitRegs_161 <= (_zz_conv2_posBitRegs_161 && conv2_wSignRegs_161);
      conv2_negBitRegs_161 <= (_zz_conv2_posBitRegs_161 && (! conv2_wSignRegs_161));
      conv2_posBitRegs_162 <= (_zz_conv2_posBitRegs_162 && conv2_wSignRegs_162);
      conv2_negBitRegs_162 <= (_zz_conv2_posBitRegs_162 && (! conv2_wSignRegs_162));
      conv2_posBitRegs_163 <= (_zz_conv2_posBitRegs_163 && conv2_wSignRegs_163);
      conv2_negBitRegs_163 <= (_zz_conv2_posBitRegs_163 && (! conv2_wSignRegs_163));
      conv2_posBitRegs_164 <= (_zz_conv2_posBitRegs_164 && conv2_wSignRegs_164);
      conv2_negBitRegs_164 <= (_zz_conv2_posBitRegs_164 && (! conv2_wSignRegs_164));
      conv2_posBitRegs_165 <= (_zz_conv2_posBitRegs_165 && conv2_wSignRegs_165);
      conv2_negBitRegs_165 <= (_zz_conv2_posBitRegs_165 && (! conv2_wSignRegs_165));
      conv2_posBitRegs_166 <= (_zz_conv2_posBitRegs_166 && conv2_wSignRegs_166);
      conv2_negBitRegs_166 <= (_zz_conv2_posBitRegs_166 && (! conv2_wSignRegs_166));
      conv2_posBitRegs_167 <= (_zz_conv2_posBitRegs_167 && conv2_wSignRegs_167);
      conv2_negBitRegs_167 <= (_zz_conv2_posBitRegs_167 && (! conv2_wSignRegs_167));
      conv2_posBitRegs_168 <= (_zz_conv2_posBitRegs_168 && conv2_wSignRegs_168);
      conv2_negBitRegs_168 <= (_zz_conv2_posBitRegs_168 && (! conv2_wSignRegs_168));
      conv2_posBitRegs_169 <= (_zz_conv2_posBitRegs_169 && conv2_wSignRegs_169);
      conv2_negBitRegs_169 <= (_zz_conv2_posBitRegs_169 && (! conv2_wSignRegs_169));
      conv2_posBitRegs_170 <= (_zz_conv2_posBitRegs_170 && conv2_wSignRegs_170);
      conv2_negBitRegs_170 <= (_zz_conv2_posBitRegs_170 && (! conv2_wSignRegs_170));
      conv2_posBitRegs_171 <= (_zz_conv2_posBitRegs_171 && conv2_wSignRegs_171);
      conv2_negBitRegs_171 <= (_zz_conv2_posBitRegs_171 && (! conv2_wSignRegs_171));
      conv2_posBitRegs_172 <= (_zz_conv2_posBitRegs_172 && conv2_wSignRegs_172);
      conv2_negBitRegs_172 <= (_zz_conv2_posBitRegs_172 && (! conv2_wSignRegs_172));
      conv2_posBitRegs_173 <= (_zz_conv2_posBitRegs_173 && conv2_wSignRegs_173);
      conv2_negBitRegs_173 <= (_zz_conv2_posBitRegs_173 && (! conv2_wSignRegs_173));
      conv2_posBitRegs_174 <= (_zz_conv2_posBitRegs_174 && conv2_wSignRegs_174);
      conv2_negBitRegs_174 <= (_zz_conv2_posBitRegs_174 && (! conv2_wSignRegs_174));
      conv2_posBitRegs_175 <= (_zz_conv2_posBitRegs_175 && conv2_wSignRegs_175);
      conv2_negBitRegs_175 <= (_zz_conv2_posBitRegs_175 && (! conv2_wSignRegs_175));
      conv2_posBitRegs_176 <= (_zz_conv2_posBitRegs_176 && conv2_wSignRegs_176);
      conv2_negBitRegs_176 <= (_zz_conv2_posBitRegs_176 && (! conv2_wSignRegs_176));
      conv2_posBitRegs_177 <= (_zz_conv2_posBitRegs_177 && conv2_wSignRegs_177);
      conv2_negBitRegs_177 <= (_zz_conv2_posBitRegs_177 && (! conv2_wSignRegs_177));
      conv2_posBitRegs_178 <= (_zz_conv2_posBitRegs_178 && conv2_wSignRegs_178);
      conv2_negBitRegs_178 <= (_zz_conv2_posBitRegs_178 && (! conv2_wSignRegs_178));
      conv2_posBitRegs_179 <= (_zz_conv2_posBitRegs_179 && conv2_wSignRegs_179);
      conv2_negBitRegs_179 <= (_zz_conv2_posBitRegs_179 && (! conv2_wSignRegs_179));
      conv2_posBitRegs_180 <= (_zz_conv2_posBitRegs_180 && conv2_wSignRegs_180);
      conv2_negBitRegs_180 <= (_zz_conv2_posBitRegs_180 && (! conv2_wSignRegs_180));
      conv2_posBitRegs_181 <= (_zz_conv2_posBitRegs_181 && conv2_wSignRegs_181);
      conv2_negBitRegs_181 <= (_zz_conv2_posBitRegs_181 && (! conv2_wSignRegs_181));
      conv2_posBitRegs_182 <= (_zz_conv2_posBitRegs_182 && conv2_wSignRegs_182);
      conv2_negBitRegs_182 <= (_zz_conv2_posBitRegs_182 && (! conv2_wSignRegs_182));
      conv2_posBitRegs_183 <= (_zz_conv2_posBitRegs_183 && conv2_wSignRegs_183);
      conv2_negBitRegs_183 <= (_zz_conv2_posBitRegs_183 && (! conv2_wSignRegs_183));
      conv2_posBitRegs_184 <= (_zz_conv2_posBitRegs_184 && conv2_wSignRegs_184);
      conv2_negBitRegs_184 <= (_zz_conv2_posBitRegs_184 && (! conv2_wSignRegs_184));
      conv2_posBitRegs_185 <= (_zz_conv2_posBitRegs_185 && conv2_wSignRegs_185);
      conv2_negBitRegs_185 <= (_zz_conv2_posBitRegs_185 && (! conv2_wSignRegs_185));
      conv2_posBitRegs_186 <= (_zz_conv2_posBitRegs_186 && conv2_wSignRegs_186);
      conv2_negBitRegs_186 <= (_zz_conv2_posBitRegs_186 && (! conv2_wSignRegs_186));
      conv2_posBitRegs_187 <= (_zz_conv2_posBitRegs_187 && conv2_wSignRegs_187);
      conv2_negBitRegs_187 <= (_zz_conv2_posBitRegs_187 && (! conv2_wSignRegs_187));
      conv2_posBitRegs_188 <= (_zz_conv2_posBitRegs_188 && conv2_wSignRegs_188);
      conv2_negBitRegs_188 <= (_zz_conv2_posBitRegs_188 && (! conv2_wSignRegs_188));
      conv2_posBitRegs_189 <= (_zz_conv2_posBitRegs_189 && conv2_wSignRegs_189);
      conv2_negBitRegs_189 <= (_zz_conv2_posBitRegs_189 && (! conv2_wSignRegs_189));
      conv2_posBitRegs_190 <= (_zz_conv2_posBitRegs_190 && conv2_wSignRegs_190);
      conv2_negBitRegs_190 <= (_zz_conv2_posBitRegs_190 && (! conv2_wSignRegs_190));
      conv2_posBitRegs_191 <= (_zz_conv2_posBitRegs_191 && conv2_wSignRegs_191);
      conv2_negBitRegs_191 <= (_zz_conv2_posBitRegs_191 && (! conv2_wSignRegs_191));
      conv2_posBitRegs_192 <= (_zz_conv2_posBitRegs_192 && conv2_wSignRegs_192);
      conv2_negBitRegs_192 <= (_zz_conv2_posBitRegs_192 && (! conv2_wSignRegs_192));
      conv2_posBitRegs_193 <= (_zz_conv2_posBitRegs_193 && conv2_wSignRegs_193);
      conv2_negBitRegs_193 <= (_zz_conv2_posBitRegs_193 && (! conv2_wSignRegs_193));
      conv2_posBitRegs_194 <= (_zz_conv2_posBitRegs_194 && conv2_wSignRegs_194);
      conv2_negBitRegs_194 <= (_zz_conv2_posBitRegs_194 && (! conv2_wSignRegs_194));
      conv2_posBitRegs_195 <= (_zz_conv2_posBitRegs_195 && conv2_wSignRegs_195);
      conv2_negBitRegs_195 <= (_zz_conv2_posBitRegs_195 && (! conv2_wSignRegs_195));
      conv2_posBitRegs_196 <= (_zz_conv2_posBitRegs_196 && conv2_wSignRegs_196);
      conv2_negBitRegs_196 <= (_zz_conv2_posBitRegs_196 && (! conv2_wSignRegs_196));
      conv2_posBitRegs_197 <= (_zz_conv2_posBitRegs_197 && conv2_wSignRegs_197);
      conv2_negBitRegs_197 <= (_zz_conv2_posBitRegs_197 && (! conv2_wSignRegs_197));
      conv2_posBitRegs_198 <= (_zz_conv2_posBitRegs_198 && conv2_wSignRegs_198);
      conv2_negBitRegs_198 <= (_zz_conv2_posBitRegs_198 && (! conv2_wSignRegs_198));
      conv2_posBitRegs_199 <= (_zz_conv2_posBitRegs_199 && conv2_wSignRegs_199);
      conv2_negBitRegs_199 <= (_zz_conv2_posBitRegs_199 && (! conv2_wSignRegs_199));
      if(when_StochasticConvCore_l279_1) begin
        if(when_StochasticConvCore_l280_1) begin
          conv2_initAddr <= 12'h0;
          conv2_state <= conv2_sRx;
        end else begin
          conv2_initAddr <= (conv2_initAddr + 12'h001);
        end
      end
      if(when_StochasticConvCore_l288_1) begin
        if(MaxPoolLinePlugin_logic_outStream_fire) begin
          conv2_rxRow <= (_zz_conv2_rxAddr ? 7'h0 : _zz_conv2_rxRow);
          conv2_rxAddr <= (conv2_rxAddr + (_zz_conv2_rxAddr ? 12'h021 : 12'h001));
          conv2_rxCnt <= (conv2_rxCnt + 11'h001);
          if(when_StochasticConvCore_l295_1) begin
            conv2_rxCnt <= 11'h0;
            conv2_rxRow <= 7'h0;
            conv2_rxAddr <= 12'h130;
            conv2_ocReg <= 5'h0;
            conv2_outHReg <= 4'b0000;
            conv2_outWReg <= 4'b0000;
            conv2_wAddrBase <= 12'h0;
            conv2_loadStep <= 8'h0;
            conv2_state <= conv2_sLoad;
          end
        end
      end
      if(when_StochasticConvCore_l345_1) begin
        conv2_loadStep <= (conv2_loadStep + 8'h01);
        if(when_StochasticConvCore_l349_1) begin
          conv2_combAdjReg <= conv2_combAdjRead;
        end
        if(when_StochasticConvCore_l353_25) begin
          conv2_activThresh_0 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_0 <= conv2_wThrRead;
          conv2_wSignRegs_0 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_26) begin
          conv2_activThresh_1 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_1 <= conv2_wThrRead;
          conv2_wSignRegs_1 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_27) begin
          conv2_activThresh_2 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_2 <= conv2_wThrRead;
          conv2_wSignRegs_2 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_28) begin
          conv2_activThresh_3 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_3 <= conv2_wThrRead;
          conv2_wSignRegs_3 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_29) begin
          conv2_activThresh_4 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_4 <= conv2_wThrRead;
          conv2_wSignRegs_4 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_30) begin
          conv2_activThresh_5 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_5 <= conv2_wThrRead;
          conv2_wSignRegs_5 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_31) begin
          conv2_activThresh_6 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_6 <= conv2_wThrRead;
          conv2_wSignRegs_6 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_32) begin
          conv2_activThresh_7 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_7 <= conv2_wThrRead;
          conv2_wSignRegs_7 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_33) begin
          conv2_activThresh_8 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_8 <= conv2_wThrRead;
          conv2_wSignRegs_8 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_34) begin
          conv2_activThresh_9 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_9 <= conv2_wThrRead;
          conv2_wSignRegs_9 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_35) begin
          conv2_activThresh_10 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_10 <= conv2_wThrRead;
          conv2_wSignRegs_10 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_36) begin
          conv2_activThresh_11 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_11 <= conv2_wThrRead;
          conv2_wSignRegs_11 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_37) begin
          conv2_activThresh_12 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_12 <= conv2_wThrRead;
          conv2_wSignRegs_12 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_38) begin
          conv2_activThresh_13 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_13 <= conv2_wThrRead;
          conv2_wSignRegs_13 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_39) begin
          conv2_activThresh_14 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_14 <= conv2_wThrRead;
          conv2_wSignRegs_14 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_40) begin
          conv2_activThresh_15 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_15 <= conv2_wThrRead;
          conv2_wSignRegs_15 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_41) begin
          conv2_activThresh_16 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_16 <= conv2_wThrRead;
          conv2_wSignRegs_16 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_42) begin
          conv2_activThresh_17 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_17 <= conv2_wThrRead;
          conv2_wSignRegs_17 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_43) begin
          conv2_activThresh_18 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_18 <= conv2_wThrRead;
          conv2_wSignRegs_18 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_44) begin
          conv2_activThresh_19 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_19 <= conv2_wThrRead;
          conv2_wSignRegs_19 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_45) begin
          conv2_activThresh_20 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_20 <= conv2_wThrRead;
          conv2_wSignRegs_20 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_46) begin
          conv2_activThresh_21 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_21 <= conv2_wThrRead;
          conv2_wSignRegs_21 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_47) begin
          conv2_activThresh_22 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_22 <= conv2_wThrRead;
          conv2_wSignRegs_22 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_48) begin
          conv2_activThresh_23 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_23 <= conv2_wThrRead;
          conv2_wSignRegs_23 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_49) begin
          conv2_activThresh_24 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_24 <= conv2_wThrRead;
          conv2_wSignRegs_24 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_50) begin
          conv2_activThresh_25 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_25 <= conv2_wThrRead;
          conv2_wSignRegs_25 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_51) begin
          conv2_activThresh_26 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_26 <= conv2_wThrRead;
          conv2_wSignRegs_26 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_52) begin
          conv2_activThresh_27 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_27 <= conv2_wThrRead;
          conv2_wSignRegs_27 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_53) begin
          conv2_activThresh_28 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_28 <= conv2_wThrRead;
          conv2_wSignRegs_28 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_54) begin
          conv2_activThresh_29 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_29 <= conv2_wThrRead;
          conv2_wSignRegs_29 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_55) begin
          conv2_activThresh_30 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_30 <= conv2_wThrRead;
          conv2_wSignRegs_30 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_56) begin
          conv2_activThresh_31 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_31 <= conv2_wThrRead;
          conv2_wSignRegs_31 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_57) begin
          conv2_activThresh_32 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_32 <= conv2_wThrRead;
          conv2_wSignRegs_32 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_58) begin
          conv2_activThresh_33 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_33 <= conv2_wThrRead;
          conv2_wSignRegs_33 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_59) begin
          conv2_activThresh_34 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_34 <= conv2_wThrRead;
          conv2_wSignRegs_34 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_60) begin
          conv2_activThresh_35 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_35 <= conv2_wThrRead;
          conv2_wSignRegs_35 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_61) begin
          conv2_activThresh_36 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_36 <= conv2_wThrRead;
          conv2_wSignRegs_36 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_62) begin
          conv2_activThresh_37 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_37 <= conv2_wThrRead;
          conv2_wSignRegs_37 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_63) begin
          conv2_activThresh_38 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_38 <= conv2_wThrRead;
          conv2_wSignRegs_38 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_64) begin
          conv2_activThresh_39 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_39 <= conv2_wThrRead;
          conv2_wSignRegs_39 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_65) begin
          conv2_activThresh_40 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_40 <= conv2_wThrRead;
          conv2_wSignRegs_40 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_66) begin
          conv2_activThresh_41 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_41 <= conv2_wThrRead;
          conv2_wSignRegs_41 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_67) begin
          conv2_activThresh_42 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_42 <= conv2_wThrRead;
          conv2_wSignRegs_42 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_68) begin
          conv2_activThresh_43 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_43 <= conv2_wThrRead;
          conv2_wSignRegs_43 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_69) begin
          conv2_activThresh_44 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_44 <= conv2_wThrRead;
          conv2_wSignRegs_44 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_70) begin
          conv2_activThresh_45 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_45 <= conv2_wThrRead;
          conv2_wSignRegs_45 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_71) begin
          conv2_activThresh_46 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_46 <= conv2_wThrRead;
          conv2_wSignRegs_46 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_72) begin
          conv2_activThresh_47 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_47 <= conv2_wThrRead;
          conv2_wSignRegs_47 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_73) begin
          conv2_activThresh_48 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_48 <= conv2_wThrRead;
          conv2_wSignRegs_48 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_74) begin
          conv2_activThresh_49 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_49 <= conv2_wThrRead;
          conv2_wSignRegs_49 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_75) begin
          conv2_activThresh_50 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_50 <= conv2_wThrRead;
          conv2_wSignRegs_50 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_76) begin
          conv2_activThresh_51 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_51 <= conv2_wThrRead;
          conv2_wSignRegs_51 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_77) begin
          conv2_activThresh_52 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_52 <= conv2_wThrRead;
          conv2_wSignRegs_52 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_78) begin
          conv2_activThresh_53 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_53 <= conv2_wThrRead;
          conv2_wSignRegs_53 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_79) begin
          conv2_activThresh_54 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_54 <= conv2_wThrRead;
          conv2_wSignRegs_54 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_80) begin
          conv2_activThresh_55 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_55 <= conv2_wThrRead;
          conv2_wSignRegs_55 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_81) begin
          conv2_activThresh_56 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_56 <= conv2_wThrRead;
          conv2_wSignRegs_56 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_82) begin
          conv2_activThresh_57 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_57 <= conv2_wThrRead;
          conv2_wSignRegs_57 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_83) begin
          conv2_activThresh_58 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_58 <= conv2_wThrRead;
          conv2_wSignRegs_58 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_84) begin
          conv2_activThresh_59 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_59 <= conv2_wThrRead;
          conv2_wSignRegs_59 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_85) begin
          conv2_activThresh_60 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_60 <= conv2_wThrRead;
          conv2_wSignRegs_60 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_86) begin
          conv2_activThresh_61 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_61 <= conv2_wThrRead;
          conv2_wSignRegs_61 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_87) begin
          conv2_activThresh_62 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_62 <= conv2_wThrRead;
          conv2_wSignRegs_62 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_88) begin
          conv2_activThresh_63 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_63 <= conv2_wThrRead;
          conv2_wSignRegs_63 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_89) begin
          conv2_activThresh_64 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_64 <= conv2_wThrRead;
          conv2_wSignRegs_64 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_90) begin
          conv2_activThresh_65 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_65 <= conv2_wThrRead;
          conv2_wSignRegs_65 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_91) begin
          conv2_activThresh_66 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_66 <= conv2_wThrRead;
          conv2_wSignRegs_66 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_92) begin
          conv2_activThresh_67 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_67 <= conv2_wThrRead;
          conv2_wSignRegs_67 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_93) begin
          conv2_activThresh_68 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_68 <= conv2_wThrRead;
          conv2_wSignRegs_68 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_94) begin
          conv2_activThresh_69 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_69 <= conv2_wThrRead;
          conv2_wSignRegs_69 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_95) begin
          conv2_activThresh_70 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_70 <= conv2_wThrRead;
          conv2_wSignRegs_70 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_96) begin
          conv2_activThresh_71 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_71 <= conv2_wThrRead;
          conv2_wSignRegs_71 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_97) begin
          conv2_activThresh_72 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_72 <= conv2_wThrRead;
          conv2_wSignRegs_72 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_98) begin
          conv2_activThresh_73 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_73 <= conv2_wThrRead;
          conv2_wSignRegs_73 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_99) begin
          conv2_activThresh_74 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_74 <= conv2_wThrRead;
          conv2_wSignRegs_74 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_100) begin
          conv2_activThresh_75 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_75 <= conv2_wThrRead;
          conv2_wSignRegs_75 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_101) begin
          conv2_activThresh_76 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_76 <= conv2_wThrRead;
          conv2_wSignRegs_76 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_102) begin
          conv2_activThresh_77 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_77 <= conv2_wThrRead;
          conv2_wSignRegs_77 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_103) begin
          conv2_activThresh_78 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_78 <= conv2_wThrRead;
          conv2_wSignRegs_78 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_104) begin
          conv2_activThresh_79 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_79 <= conv2_wThrRead;
          conv2_wSignRegs_79 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_105) begin
          conv2_activThresh_80 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_80 <= conv2_wThrRead;
          conv2_wSignRegs_80 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_106) begin
          conv2_activThresh_81 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_81 <= conv2_wThrRead;
          conv2_wSignRegs_81 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_107) begin
          conv2_activThresh_82 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_82 <= conv2_wThrRead;
          conv2_wSignRegs_82 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_108) begin
          conv2_activThresh_83 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_83 <= conv2_wThrRead;
          conv2_wSignRegs_83 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_109) begin
          conv2_activThresh_84 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_84 <= conv2_wThrRead;
          conv2_wSignRegs_84 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_110) begin
          conv2_activThresh_85 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_85 <= conv2_wThrRead;
          conv2_wSignRegs_85 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_111) begin
          conv2_activThresh_86 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_86 <= conv2_wThrRead;
          conv2_wSignRegs_86 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_112) begin
          conv2_activThresh_87 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_87 <= conv2_wThrRead;
          conv2_wSignRegs_87 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_113) begin
          conv2_activThresh_88 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_88 <= conv2_wThrRead;
          conv2_wSignRegs_88 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_114) begin
          conv2_activThresh_89 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_89 <= conv2_wThrRead;
          conv2_wSignRegs_89 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_115) begin
          conv2_activThresh_90 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_90 <= conv2_wThrRead;
          conv2_wSignRegs_90 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_116) begin
          conv2_activThresh_91 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_91 <= conv2_wThrRead;
          conv2_wSignRegs_91 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_117) begin
          conv2_activThresh_92 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_92 <= conv2_wThrRead;
          conv2_wSignRegs_92 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_118) begin
          conv2_activThresh_93 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_93 <= conv2_wThrRead;
          conv2_wSignRegs_93 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_119) begin
          conv2_activThresh_94 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_94 <= conv2_wThrRead;
          conv2_wSignRegs_94 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_120) begin
          conv2_activThresh_95 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_95 <= conv2_wThrRead;
          conv2_wSignRegs_95 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_121) begin
          conv2_activThresh_96 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_96 <= conv2_wThrRead;
          conv2_wSignRegs_96 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_122) begin
          conv2_activThresh_97 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_97 <= conv2_wThrRead;
          conv2_wSignRegs_97 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_123) begin
          conv2_activThresh_98 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_98 <= conv2_wThrRead;
          conv2_wSignRegs_98 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_124) begin
          conv2_activThresh_99 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_99 <= conv2_wThrRead;
          conv2_wSignRegs_99 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_125) begin
          conv2_activThresh_100 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_100 <= conv2_wThrRead;
          conv2_wSignRegs_100 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_126) begin
          conv2_activThresh_101 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_101 <= conv2_wThrRead;
          conv2_wSignRegs_101 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_127) begin
          conv2_activThresh_102 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_102 <= conv2_wThrRead;
          conv2_wSignRegs_102 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_128) begin
          conv2_activThresh_103 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_103 <= conv2_wThrRead;
          conv2_wSignRegs_103 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_129) begin
          conv2_activThresh_104 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_104 <= conv2_wThrRead;
          conv2_wSignRegs_104 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_130) begin
          conv2_activThresh_105 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_105 <= conv2_wThrRead;
          conv2_wSignRegs_105 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_131) begin
          conv2_activThresh_106 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_106 <= conv2_wThrRead;
          conv2_wSignRegs_106 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_132) begin
          conv2_activThresh_107 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_107 <= conv2_wThrRead;
          conv2_wSignRegs_107 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_133) begin
          conv2_activThresh_108 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_108 <= conv2_wThrRead;
          conv2_wSignRegs_108 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_134) begin
          conv2_activThresh_109 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_109 <= conv2_wThrRead;
          conv2_wSignRegs_109 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_135) begin
          conv2_activThresh_110 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_110 <= conv2_wThrRead;
          conv2_wSignRegs_110 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_136) begin
          conv2_activThresh_111 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_111 <= conv2_wThrRead;
          conv2_wSignRegs_111 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_137) begin
          conv2_activThresh_112 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_112 <= conv2_wThrRead;
          conv2_wSignRegs_112 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_138) begin
          conv2_activThresh_113 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_113 <= conv2_wThrRead;
          conv2_wSignRegs_113 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_139) begin
          conv2_activThresh_114 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_114 <= conv2_wThrRead;
          conv2_wSignRegs_114 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_140) begin
          conv2_activThresh_115 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_115 <= conv2_wThrRead;
          conv2_wSignRegs_115 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_141) begin
          conv2_activThresh_116 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_116 <= conv2_wThrRead;
          conv2_wSignRegs_116 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_142) begin
          conv2_activThresh_117 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_117 <= conv2_wThrRead;
          conv2_wSignRegs_117 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_143) begin
          conv2_activThresh_118 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_118 <= conv2_wThrRead;
          conv2_wSignRegs_118 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_144) begin
          conv2_activThresh_119 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_119 <= conv2_wThrRead;
          conv2_wSignRegs_119 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_145) begin
          conv2_activThresh_120 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_120 <= conv2_wThrRead;
          conv2_wSignRegs_120 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_146) begin
          conv2_activThresh_121 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_121 <= conv2_wThrRead;
          conv2_wSignRegs_121 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_147) begin
          conv2_activThresh_122 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_122 <= conv2_wThrRead;
          conv2_wSignRegs_122 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_148) begin
          conv2_activThresh_123 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_123 <= conv2_wThrRead;
          conv2_wSignRegs_123 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_149) begin
          conv2_activThresh_124 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_124 <= conv2_wThrRead;
          conv2_wSignRegs_124 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_150) begin
          conv2_activThresh_125 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_125 <= conv2_wThrRead;
          conv2_wSignRegs_125 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_151) begin
          conv2_activThresh_126 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_126 <= conv2_wThrRead;
          conv2_wSignRegs_126 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_152) begin
          conv2_activThresh_127 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_127 <= conv2_wThrRead;
          conv2_wSignRegs_127 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_153) begin
          conv2_activThresh_128 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_128 <= conv2_wThrRead;
          conv2_wSignRegs_128 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_154) begin
          conv2_activThresh_129 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_129 <= conv2_wThrRead;
          conv2_wSignRegs_129 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_155) begin
          conv2_activThresh_130 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_130 <= conv2_wThrRead;
          conv2_wSignRegs_130 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_156) begin
          conv2_activThresh_131 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_131 <= conv2_wThrRead;
          conv2_wSignRegs_131 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_157) begin
          conv2_activThresh_132 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_132 <= conv2_wThrRead;
          conv2_wSignRegs_132 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_158) begin
          conv2_activThresh_133 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_133 <= conv2_wThrRead;
          conv2_wSignRegs_133 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_159) begin
          conv2_activThresh_134 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_134 <= conv2_wThrRead;
          conv2_wSignRegs_134 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_160) begin
          conv2_activThresh_135 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_135 <= conv2_wThrRead;
          conv2_wSignRegs_135 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_161) begin
          conv2_activThresh_136 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_136 <= conv2_wThrRead;
          conv2_wSignRegs_136 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_162) begin
          conv2_activThresh_137 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_137 <= conv2_wThrRead;
          conv2_wSignRegs_137 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_163) begin
          conv2_activThresh_138 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_138 <= conv2_wThrRead;
          conv2_wSignRegs_138 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_164) begin
          conv2_activThresh_139 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_139 <= conv2_wThrRead;
          conv2_wSignRegs_139 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_165) begin
          conv2_activThresh_140 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_140 <= conv2_wThrRead;
          conv2_wSignRegs_140 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_166) begin
          conv2_activThresh_141 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_141 <= conv2_wThrRead;
          conv2_wSignRegs_141 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_167) begin
          conv2_activThresh_142 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_142 <= conv2_wThrRead;
          conv2_wSignRegs_142 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_168) begin
          conv2_activThresh_143 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_143 <= conv2_wThrRead;
          conv2_wSignRegs_143 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_169) begin
          conv2_activThresh_144 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_144 <= conv2_wThrRead;
          conv2_wSignRegs_144 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_170) begin
          conv2_activThresh_145 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_145 <= conv2_wThrRead;
          conv2_wSignRegs_145 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_171) begin
          conv2_activThresh_146 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_146 <= conv2_wThrRead;
          conv2_wSignRegs_146 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_172) begin
          conv2_activThresh_147 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_147 <= conv2_wThrRead;
          conv2_wSignRegs_147 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_173) begin
          conv2_activThresh_148 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_148 <= conv2_wThrRead;
          conv2_wSignRegs_148 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_174) begin
          conv2_activThresh_149 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_149 <= conv2_wThrRead;
          conv2_wSignRegs_149 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_175) begin
          conv2_activThresh_150 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_150 <= conv2_wThrRead;
          conv2_wSignRegs_150 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_176) begin
          conv2_activThresh_151 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_151 <= conv2_wThrRead;
          conv2_wSignRegs_151 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_177) begin
          conv2_activThresh_152 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_152 <= conv2_wThrRead;
          conv2_wSignRegs_152 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_178) begin
          conv2_activThresh_153 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_153 <= conv2_wThrRead;
          conv2_wSignRegs_153 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_179) begin
          conv2_activThresh_154 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_154 <= conv2_wThrRead;
          conv2_wSignRegs_154 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_180) begin
          conv2_activThresh_155 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_155 <= conv2_wThrRead;
          conv2_wSignRegs_155 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_181) begin
          conv2_activThresh_156 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_156 <= conv2_wThrRead;
          conv2_wSignRegs_156 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_182) begin
          conv2_activThresh_157 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_157 <= conv2_wThrRead;
          conv2_wSignRegs_157 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_183) begin
          conv2_activThresh_158 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_158 <= conv2_wThrRead;
          conv2_wSignRegs_158 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_184) begin
          conv2_activThresh_159 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_159 <= conv2_wThrRead;
          conv2_wSignRegs_159 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_185) begin
          conv2_activThresh_160 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_160 <= conv2_wThrRead;
          conv2_wSignRegs_160 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_186) begin
          conv2_activThresh_161 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_161 <= conv2_wThrRead;
          conv2_wSignRegs_161 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_187) begin
          conv2_activThresh_162 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_162 <= conv2_wThrRead;
          conv2_wSignRegs_162 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_188) begin
          conv2_activThresh_163 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_163 <= conv2_wThrRead;
          conv2_wSignRegs_163 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_189) begin
          conv2_activThresh_164 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_164 <= conv2_wThrRead;
          conv2_wSignRegs_164 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_190) begin
          conv2_activThresh_165 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_165 <= conv2_wThrRead;
          conv2_wSignRegs_165 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_191) begin
          conv2_activThresh_166 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_166 <= conv2_wThrRead;
          conv2_wSignRegs_166 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_192) begin
          conv2_activThresh_167 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_167 <= conv2_wThrRead;
          conv2_wSignRegs_167 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_193) begin
          conv2_activThresh_168 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_168 <= conv2_wThrRead;
          conv2_wSignRegs_168 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_194) begin
          conv2_activThresh_169 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_169 <= conv2_wThrRead;
          conv2_wSignRegs_169 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_195) begin
          conv2_activThresh_170 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_170 <= conv2_wThrRead;
          conv2_wSignRegs_170 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_196) begin
          conv2_activThresh_171 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_171 <= conv2_wThrRead;
          conv2_wSignRegs_171 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_197) begin
          conv2_activThresh_172 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_172 <= conv2_wThrRead;
          conv2_wSignRegs_172 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_198) begin
          conv2_activThresh_173 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_173 <= conv2_wThrRead;
          conv2_wSignRegs_173 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_199) begin
          conv2_activThresh_174 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_174 <= conv2_wThrRead;
          conv2_wSignRegs_174 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_200) begin
          conv2_activThresh_175 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_175 <= conv2_wThrRead;
          conv2_wSignRegs_175 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_201) begin
          conv2_activThresh_176 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_176 <= conv2_wThrRead;
          conv2_wSignRegs_176 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_202) begin
          conv2_activThresh_177 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_177 <= conv2_wThrRead;
          conv2_wSignRegs_177 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_203) begin
          conv2_activThresh_178 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_178 <= conv2_wThrRead;
          conv2_wSignRegs_178 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_204) begin
          conv2_activThresh_179 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_179 <= conv2_wThrRead;
          conv2_wSignRegs_179 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_205) begin
          conv2_activThresh_180 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_180 <= conv2_wThrRead;
          conv2_wSignRegs_180 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_206) begin
          conv2_activThresh_181 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_181 <= conv2_wThrRead;
          conv2_wSignRegs_181 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_207) begin
          conv2_activThresh_182 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_182 <= conv2_wThrRead;
          conv2_wSignRegs_182 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_208) begin
          conv2_activThresh_183 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_183 <= conv2_wThrRead;
          conv2_wSignRegs_183 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_209) begin
          conv2_activThresh_184 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_184 <= conv2_wThrRead;
          conv2_wSignRegs_184 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_210) begin
          conv2_activThresh_185 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_185 <= conv2_wThrRead;
          conv2_wSignRegs_185 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_211) begin
          conv2_activThresh_186 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_186 <= conv2_wThrRead;
          conv2_wSignRegs_186 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_212) begin
          conv2_activThresh_187 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_187 <= conv2_wThrRead;
          conv2_wSignRegs_187 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_213) begin
          conv2_activThresh_188 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_188 <= conv2_wThrRead;
          conv2_wSignRegs_188 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_214) begin
          conv2_activThresh_189 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_189 <= conv2_wThrRead;
          conv2_wSignRegs_189 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_215) begin
          conv2_activThresh_190 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_190 <= conv2_wThrRead;
          conv2_wSignRegs_190 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_216) begin
          conv2_activThresh_191 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_191 <= conv2_wThrRead;
          conv2_wSignRegs_191 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_217) begin
          conv2_activThresh_192 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_192 <= conv2_wThrRead;
          conv2_wSignRegs_192 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_218) begin
          conv2_activThresh_193 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_193 <= conv2_wThrRead;
          conv2_wSignRegs_193 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_219) begin
          conv2_activThresh_194 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_194 <= conv2_wThrRead;
          conv2_wSignRegs_194 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_220) begin
          conv2_activThresh_195 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_195 <= conv2_wThrRead;
          conv2_wSignRegs_195 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_221) begin
          conv2_activThresh_196 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_196 <= conv2_wThrRead;
          conv2_wSignRegs_196 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_222) begin
          conv2_activThresh_197 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_197 <= conv2_wThrRead;
          conv2_wSignRegs_197 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_223) begin
          conv2_activThresh_198 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_198 <= conv2_wThrRead;
          conv2_wSignRegs_198 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l353_224) begin
          conv2_activThresh_199 <= (conv2_actBufRead + 8'h80);
          conv2_wThrRegs_199 <= conv2_wThrRead;
          conv2_wSignRegs_199 <= conv2_wSignRead;
        end
        if(when_StochasticConvCore_l361_1) begin
          conv2_loadStep <= 8'h0;
          conv2_scAcc <= 18'h0;
          conv2_scStep <= 8'h0;
          conv2_state <= conv2_sSC;
        end
      end
      if(when_StochasticConvCore_l373_1) begin
        conv2_scStep <= (conv2_scStep + 8'h01);
        conv2_scAcc <= ($signed(conv2_scAcc) + $signed(_zz_conv2_scAcc));
        if(when_StochasticConvCore_l376_1) begin
          conv2_scStep <= 8'h0;
          conv2_state <= conv2_sDecode;
        end
      end
      if(when_StochasticConvCore_l387_1) begin
        if(conv2_activationOut_fire) begin
          conv2_ocReg <= (when_StochasticConvCore_l408_1 ? 5'h0 : _zz_conv2_ocReg);
          conv2_wAddrBase <= (when_StochasticConvCore_l408_1 ? 12'h0 : _zz_conv2_wAddrBase);
          if(when_StochasticConvCore_l408_1) begin
            conv2_outWReg <= (when_StochasticConvCore_l410_1 ? 4'b0000 : _zz_conv2_outWReg);
            if(when_StochasticConvCore_l410_1) begin
              conv2_outHReg <= (_zz_conv2_state ? 4'b0000 : _zz_conv2_outHReg);
            end
          end
          conv2_loadStep <= 8'h0;
          conv2_state <= (((when_StochasticConvCore_l408_1 && when_StochasticConvCore_l410_1) && _zz_conv2_state) ? conv2_sRx : conv2_sLoad);
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
