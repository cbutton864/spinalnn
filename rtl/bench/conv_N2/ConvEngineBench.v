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

  reg        [7:0]    bench_N2_inputBuf_0_spinal_port0;
  reg        [7:0]    bench_N2_inputBuf_1_spinal_port0;
  reg        [7:0]    bench_N2_weightRom_0_spinal_port0;
  reg        [7:0]    bench_N2_weightRom_1_spinal_port0;
  reg        [31:0]   bench_N2_biasRom_spinal_port0;
  reg        [31:0]   bench_N2_reqMultRom_spinal_port0;
  reg        [7:0]    bench_N2_reqShiftRom_spinal_port0;
  wire                _zz_bench_N2_inputBuf_0_port;
  wire                _zz_bench_N2_inValsR_0_1;
  wire                _zz_bench_N2_inputBuf_1_port;
  wire                _zz_bench_N2_inValsR_1_1;
  wire                _zz_bench_N2_weightRom_0_port;
  wire                _zz_bench_N2_wValsR_0_1;
  wire                _zz_bench_N2_weightRom_1_port;
  wire                _zz_bench_N2_wValsR_1_1;
  wire       [4:0]    _zz_bench_N2_biasRom_port;
  wire                _zz_bench_N2_biasRom_port_1;
  wire       [4:0]    _zz_bench_N2_biasVal_1;
  wire                _zz_bench_N2_biasVal_2;
  wire       [4:0]    _zz_bench_N2_reqMultRom_port;
  wire                _zz_bench_N2_reqMultRom_port_1;
  wire       [4:0]    _zz_bench_N2_reqMultVal_1;
  wire                _zz_bench_N2_reqMultVal_2;
  wire       [4:0]    _zz_bench_N2_reqShiftRom_port;
  wire                _zz_bench_N2_reqShiftRom_port_1;
  wire       [4:0]    _zz_bench_N2_reqShiftVal_1;
  wire                _zz_bench_N2_reqShiftVal_2;
  wire       [9:0]    _zz_bench_N2_inputBuf_0_port_1;
  wire       [9:0]    _zz_bench_N2_inputBuf_0_port_2;
  wire       [7:0]    _zz_bench_N2_inputBuf_0_port_3;
  wire       [7:0]    _zz_bench_N2_inputBuf_0_port_4;
  wire                _zz_bench_N2_inputBuf_0_port_5;
  wire       [9:0]    _zz_bench_N2_inputBuf_1_port_1;
  wire       [9:0]    _zz_bench_N2_inputBuf_1_port_2;
  wire       [7:0]    _zz_bench_N2_inputBuf_1_port_3;
  wire       [7:0]    _zz_bench_N2_inputBuf_1_port_4;
  wire                _zz_bench_N2_inputBuf_1_port_5;
  wire       [7:0]    _zz_bench_N2_rowElemReg;
  wire       [11:0]   _zz_bench_N2_inAddrReg_1;
  wire       [11:0]   _zz_bench_N2_inAddrReg_2;
  wire       [11:0]   _zz_bench_N2_inAddrReg_3;
  wire       [4:0]    _zz_bench_N2_inAddrReg_4;
  wire       [11:0]   _zz_bench_N2_inAddrReg_5;
  wire       [8:0]    _zz_bench_N2_inAddrReg_6;
  wire       [4:0]    _zz_bench_N2_inAddrReg_7;
  wire       [11:0]   _zz_bench_N2_inAddrReg_8;
  wire       [3:0]    _zz_bench_N2_inAddrReg_9;
  wire       [12:0]   _zz_bench_N2_wAddrReg;
  wire       [12:0]   _zz_bench_N2_wAddrReg_1;
  wire       [12:0]   _zz_bench_N2_wAddrReg_2;
  wire       [12:0]   _zz_bench_N2_wAddrReg_3;
  wire       [12:0]   _zz_bench_N2_wAddrReg_4;
  wire       [4:0]    _zz_bench_N2_wAddrReg_5;
  wire       [12:0]   _zz_bench_N2_wAddrReg_6;
  wire       [3:0]    _zz_bench_N2_wAddrReg_7;
  wire       [12:0]   _zz_bench_N2_wAddrReg_8;
  wire       [3:0]    _zz_bench_N2_wAddrReg_9;
  wire       [4:0]    _zz_bench_N2_rowStepReg;
  wire       [31:0]   _zz_bench_N2_prodReg;
  wire       [17:0]   _zz_bench_N2_prodReg_1;
  wire       [8:0]    _zz_bench_N2_prodReg_2;
  wire       [8:0]    _zz_bench_N2_prodReg_3;
  wire       [8:0]    _zz_bench_N2_prodReg_4;
  wire       [8:0]    _zz_bench_N2_prodReg_5;
  wire       [31:0]   _zz_bench_N2_prodReg_6;
  wire       [17:0]   _zz_bench_N2_prodReg_7;
  wire       [8:0]    _zz_bench_N2_prodReg_8;
  wire       [8:0]    _zz_bench_N2_prodReg_9;
  wire       [8:0]    _zz_bench_N2_prodReg_10;
  wire       [8:0]    _zz_bench_N2_prodReg_11;
  wire       [31:0]   _zz_bench_N2_absAReg;
  wire       [31:0]   _zz_bench_N2_absAReg_1;
  wire       [32:0]   _zz_bench_N2_pSumReg;
  wire       [32:0]   _zz_bench_N2_pSumReg_1;
  wire       [63:0]   _zz_bench_N2_part1Reg;
  wire       [63:0]   _zz_bench_N2_part1Reg_1;
  wire       [79:0]   _zz_bench_N2_part1Reg_2;
  wire       [63:0]   _zz_bench_N2_part1Reg_3;
  wire       [95:0]   _zz_bench_N2_part2Reg;
  wire       [63:0]   _zz_bench_N2_part2Reg_1;
  wire       [63:0]   _zz_bench_N2_reqProdReg2_1;
  wire       [63:0]   _zz_bench_N2_reqProdReg2_2;
  wire       [63:0]   _zz_bench_N2_reqProdReg2_3;
  wire       [31:0]   _zz__zz_bench_N2_resultReg;
  wire       [63:0]   _zz__zz_bench_N2_resultReg_1;
  wire       [7:0]    _zz_bench_N2_resultReg_1;
  wire       [7:0]    _zz_bench_N2_resultReg_2;
  wire       [5:0]    _zz_bench_N2_outChReg;
  wire       [3:0]    _zz_bench_N2_outColReg;
  wire       [3:0]    _zz_bench_N2_outRowReg;
  reg                 inValidR;
  reg        [7:0]    inValueR;
  reg                 outReadyR;
  wire                inStream_valid;
  reg                 inStream_ready;
  wire       [7:0]    inStream_payload_value;
  reg                 bench_N2_activationOut_valid;
  wire                bench_N2_activationOut_ready;
  reg        [7:0]    bench_N2_activationOut_payload_value;
  wire       [3:0]    bench_N2_sReceive;
  wire       [3:0]    bench_N2_sLoadBias;
  wire       [3:0]    bench_N2_sCompute;
  wire       [3:0]    bench_N2_sRequant;
  wire       [3:0]    bench_N2_sRequantMul;
  wire       [3:0]    bench_N2_sRequantWait;
  wire       [3:0]    bench_N2_sRequantWait2;
  wire       [3:0]    bench_N2_sRequantWait3;
  wire       [3:0]    bench_N2_sRequantShift;
  wire       [3:0]    bench_N2_sEmit;
  wire       [3:0]    bench_N2_sInit;
  wire       [3:0]    bench_N2_sWaitBias;
  wire       [3:0]    bench_N2_sLoadWeights;
  reg        [3:0]    bench_N2_stateReg;
  reg        [10:0]   bench_N2_recvCntReg;
  reg        [10:0]   bench_N2_padWriteAddrReg;
  reg        [7:0]    bench_N2_rowElemReg;
  reg        [3:0]    bench_N2_outRowReg;
  reg        [3:0]    bench_N2_outColReg;
  reg        [5:0]    bench_N2_outChReg;
  reg        [31:0]   bench_N2_accumReg;
  reg        [31:0]   bench_N2_prodReg;
  reg        [7:0]    bench_N2_resultReg;
  wire       [63:0]   bench_N2_reqProdReg1;
  reg        [63:0]   bench_N2_reqProdReg2;
  reg        [31:0]   bench_N2_accumRequantReg;
  reg                 bench_N2_signAReg;
  reg        [31:0]   bench_N2_absAReg;
  reg        [31:0]   bench_N2_pLL_Reg;
  reg        [31:0]   bench_N2_pLH_Reg;
  reg        [31:0]   bench_N2_pHL_Reg;
  reg        [31:0]   bench_N2_pHH_Reg;
  reg        [32:0]   bench_N2_pSumReg;
  reg        [31:0]   bench_N2_pLL_Reg2;
  reg        [31:0]   bench_N2_pHH_Reg2;
  reg        [63:0]   bench_N2_part1Reg;
  reg        [63:0]   bench_N2_part2Reg;
  reg        [9:0]    bench_N2_initAddrReg;
  reg        [9:0]    bench_N2_inAddrReg;
  reg        [11:0]   bench_N2_wAddrReg;
  reg        [6:0]    bench_N2_compCycleReg;
  reg        [4:0]    bench_N2_rowStepReg;
  reg        [9:0]    bench_N2_inAddrComb;
  reg        [11:0]   bench_N2_wAddrComb;
  wire       [9:0]    _zz_bench_N2_inValsR_0;
  wire       [7:0]    bench_N2_inValsR_0;
  wire       [9:0]    _zz_bench_N2_inValsR_1;
  wire       [7:0]    bench_N2_inValsR_1;
  wire       [11:0]   _zz_bench_N2_wValsR_0;
  wire       [7:0]    bench_N2_wValsR_0;
  wire       [11:0]   _zz_bench_N2_wValsR_1;
  wire       [7:0]    bench_N2_wValsR_1;
  wire       [5:0]    _zz_bench_N2_biasVal;
  wire       [31:0]   bench_N2_biasVal;
  wire       [5:0]    _zz_bench_N2_reqMultVal;
  wire       [31:0]   bench_N2_reqMultVal;
  wire       [5:0]    _zz_bench_N2_reqShiftVal;
  wire       [7:0]    bench_N2_reqShiftVal;
  reg        [7:0]    bench_N2_inValsReg_0;
  reg        [7:0]    bench_N2_inValsReg_1;
  reg        [7:0]    bench_N2_wValsReg_0;
  reg        [7:0]    bench_N2_wValsReg_1;
  wire                _zz_8;
  wire                inStream_fire;
  wire                _zz_10;
  wire                when_QLinearConvCore_l331;
  wire                when_QLinearConvCore_l333;
  wire                when_QLinearConvCore_l347;
  wire                _zz_bench_N2_padWriteAddrReg;
  wire                when_QLinearConvCore_l357;
  wire                when_QLinearConvCore_l390;
  wire                when_QLinearConvCore_l404;
  wire                when_QLinearConvCore_l412;
  wire                when_QLinearConvCore_l416;
  wire                _zz_bench_N2_inAddrReg;
  wire                when_QLinearConvCore_l429;
  wire                when_QLinearConvCore_l437;
  wire                when_QLinearConvCore_l448;
  wire       [31:0]   _zz_bench_N2_accumReg;
  wire                when_QLinearConvCore_l452;
  wire                when_QLinearConvCore_l461;
  wire                when_QLinearConvCore_l468;
  wire       [15:0]   _zz_bench_N2_pHL_Reg;
  wire       [15:0]   _zz_bench_N2_pLL_Reg;
  wire       [15:0]   _zz_bench_N2_pLH_Reg;
  wire       [15:0]   _zz_bench_N2_pLL_Reg_1;
  wire                when_QLinearConvCore_l485;
  wire                when_QLinearConvCore_l493;
  wire                when_QLinearConvCore_l500;
  wire       [63:0]   _zz_bench_N2_reqProdReg2;
  wire                when_QLinearConvCore_l508;
  wire       [31:0]   _zz_bench_N2_resultReg;
  wire                when_QLinearConvCore_l519;
  wire                bench_N2_activationOut_fire;
  wire                when_QLinearConvCore_l529;
  wire                when_QLinearConvCore_l531;
  wire                _zz_bench_N2_stateReg;
  reg                 inStream_ready_regNext;
  reg                 bench_N2_activationOut_valid_regNext;
  reg        [7:0]    bench_N2_activationOut_payload_value_regNext;
  reg [7:0] bench_N2_inputBuf_0 [0:799];
  reg [7:0] bench_N2_inputBuf_1 [0:799];
  reg [7:0] bench_N2_weightRom_0 [0:2303];
  reg [7:0] bench_N2_weightRom_1 [0:2303];
  reg [31:0] bench_N2_biasRom [0:31];
  reg [31:0] bench_N2_reqMultRom [0:31];
  reg [7:0] bench_N2_reqShiftRom [0:31];

  assign _zz_bench_N2_biasVal_1 = _zz_bench_N2_biasVal[4:0];
  assign _zz_bench_N2_reqMultVal_1 = _zz_bench_N2_reqMultVal[4:0];
  assign _zz_bench_N2_reqShiftVal_1 = _zz_bench_N2_reqShiftVal[4:0];
  assign _zz_bench_N2_inputBuf_0_port_2 = (bench_N2_padWriteAddrReg >>> 1'd1);
  assign _zz_bench_N2_inputBuf_0_port_4 = (_zz_8 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N2_inputBuf_1_port_2 = (bench_N2_padWriteAddrReg >>> 1'd1);
  assign _zz_bench_N2_inputBuf_1_port_4 = (_zz_10 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N2_rowElemReg = (bench_N2_rowElemReg + 8'h01);
  assign _zz_bench_N2_inAddrReg_1 = (_zz_bench_N2_inAddrReg_2 + _zz_bench_N2_inAddrReg_8);
  assign _zz_bench_N2_inAddrReg_2 = (_zz_bench_N2_inAddrReg_3 + _zz_bench_N2_inAddrReg_5);
  assign _zz_bench_N2_inAddrReg_3 = (_zz_bench_N2_inAddrReg_4 * 7'h50);
  assign _zz_bench_N2_inAddrReg_4 = (bench_N2_outRowReg * 1'b1);
  assign _zz_bench_N2_inAddrReg_6 = (_zz_bench_N2_inAddrReg_7 * 4'b1000);
  assign _zz_bench_N2_inAddrReg_5 = {3'd0, _zz_bench_N2_inAddrReg_6};
  assign _zz_bench_N2_inAddrReg_7 = (bench_N2_outColReg * 1'b1);
  assign _zz_bench_N2_inAddrReg_9 = 4'b0000;
  assign _zz_bench_N2_inAddrReg_8 = {8'd0, _zz_bench_N2_inAddrReg_9};
  assign _zz_bench_N2_wAddrReg = (_zz_bench_N2_wAddrReg_1 + _zz_bench_N2_wAddrReg_8);
  assign _zz_bench_N2_wAddrReg_1 = (_zz_bench_N2_wAddrReg_2 + _zz_bench_N2_wAddrReg_6);
  assign _zz_bench_N2_wAddrReg_2 = (_zz_bench_N2_wAddrReg_3 + _zz_bench_N2_wAddrReg_4);
  assign _zz_bench_N2_wAddrReg_3 = (bench_N2_outChReg * 7'h48);
  assign _zz_bench_N2_wAddrReg_5 = 5'h0;
  assign _zz_bench_N2_wAddrReg_4 = {8'd0, _zz_bench_N2_wAddrReg_5};
  assign _zz_bench_N2_wAddrReg_7 = 4'b0000;
  assign _zz_bench_N2_wAddrReg_6 = {9'd0, _zz_bench_N2_wAddrReg_7};
  assign _zz_bench_N2_wAddrReg_9 = 4'b0000;
  assign _zz_bench_N2_wAddrReg_8 = {9'd0, _zz_bench_N2_wAddrReg_9};
  assign _zz_bench_N2_rowStepReg = (bench_N2_rowStepReg + 5'h01);
  assign _zz_bench_N2_prodReg_1 = ($signed(_zz_bench_N2_prodReg_2) * $signed(_zz_bench_N2_prodReg_4));
  assign _zz_bench_N2_prodReg = {{14{_zz_bench_N2_prodReg_1[17]}}, _zz_bench_N2_prodReg_1};
  assign _zz_bench_N2_prodReg_2 = ($signed(_zz_bench_N2_prodReg_3) - $signed(9'h180));
  assign _zz_bench_N2_prodReg_3 = {{1{bench_N2_inValsReg_0[7]}}, bench_N2_inValsReg_0};
  assign _zz_bench_N2_prodReg_4 = ($signed(_zz_bench_N2_prodReg_5) - $signed(9'h0));
  assign _zz_bench_N2_prodReg_5 = {{1{bench_N2_wValsReg_0[7]}}, bench_N2_wValsReg_0};
  assign _zz_bench_N2_prodReg_7 = ($signed(_zz_bench_N2_prodReg_8) * $signed(_zz_bench_N2_prodReg_10));
  assign _zz_bench_N2_prodReg_6 = {{14{_zz_bench_N2_prodReg_7[17]}}, _zz_bench_N2_prodReg_7};
  assign _zz_bench_N2_prodReg_8 = ($signed(_zz_bench_N2_prodReg_9) - $signed(9'h180));
  assign _zz_bench_N2_prodReg_9 = {{1{bench_N2_inValsReg_1[7]}}, bench_N2_inValsReg_1};
  assign _zz_bench_N2_prodReg_10 = ($signed(_zz_bench_N2_prodReg_11) - $signed(9'h0));
  assign _zz_bench_N2_prodReg_11 = {{1{bench_N2_wValsReg_1[7]}}, bench_N2_wValsReg_1};
  assign _zz_bench_N2_absAReg = (($signed(bench_N2_accumRequantReg) < $signed(32'h0)) ? _zz_bench_N2_absAReg_1 : bench_N2_accumRequantReg);
  assign _zz_bench_N2_absAReg_1 = (- bench_N2_accumRequantReg);
  assign _zz_bench_N2_pSumReg = {1'd0, bench_N2_pLH_Reg};
  assign _zz_bench_N2_pSumReg_1 = {1'd0, bench_N2_pHL_Reg};
  assign _zz_bench_N2_part1Reg = {32'd0, bench_N2_pLL_Reg2};
  assign _zz_bench_N2_part1Reg_2 = ({16'd0,_zz_bench_N2_part1Reg_3} <<< 5'd16);
  assign _zz_bench_N2_part1Reg_1 = _zz_bench_N2_part1Reg_2[63:0];
  assign _zz_bench_N2_part1Reg_3 = {31'd0, bench_N2_pSumReg};
  assign _zz_bench_N2_part2Reg = ({32'd0,_zz_bench_N2_part2Reg_1} <<< 6'd32);
  assign _zz_bench_N2_part2Reg_1 = {32'd0, bench_N2_pHH_Reg2};
  assign _zz_bench_N2_reqProdReg2_1 = (- _zz_bench_N2_reqProdReg2_2);
  assign _zz_bench_N2_reqProdReg2_2 = _zz_bench_N2_reqProdReg2;
  assign _zz_bench_N2_reqProdReg2_3 = _zz_bench_N2_reqProdReg2;
  assign _zz__zz_bench_N2_resultReg_1 = ($signed(bench_N2_reqProdReg2) >>> bench_N2_reqShiftVal);
  assign _zz__zz_bench_N2_resultReg = _zz__zz_bench_N2_resultReg_1[31:0];
  assign _zz_bench_N2_resultReg_1 = (($signed(_zz_bench_N2_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz_bench_N2_resultReg_2);
  assign _zz_bench_N2_resultReg_2 = _zz_bench_N2_resultReg[7:0];
  assign _zz_bench_N2_outChReg = (bench_N2_outChReg + 6'h01);
  assign _zz_bench_N2_outColReg = (bench_N2_outColReg + 4'b0001);
  assign _zz_bench_N2_outRowReg = (bench_N2_outRowReg + 4'b0001);
  assign _zz_bench_N2_inValsR_0_1 = 1'b1;
  assign _zz_bench_N2_inputBuf_0_port_1 = (_zz_8 ? bench_N2_initAddrReg : _zz_bench_N2_inputBuf_0_port_2);
  assign _zz_bench_N2_inputBuf_0_port_3 = _zz_bench_N2_inputBuf_0_port_4;
  assign _zz_bench_N2_inputBuf_0_port_5 = (_zz_8 || (((bench_N2_stateReg == bench_N2_sReceive) && inStream_fire) && (bench_N2_padWriteAddrReg[0 : 0] == 1'b0)));
  assign _zz_bench_N2_inValsR_1_1 = 1'b1;
  assign _zz_bench_N2_inputBuf_1_port_1 = (_zz_10 ? bench_N2_initAddrReg : _zz_bench_N2_inputBuf_1_port_2);
  assign _zz_bench_N2_inputBuf_1_port_3 = _zz_bench_N2_inputBuf_1_port_4;
  assign _zz_bench_N2_inputBuf_1_port_5 = (_zz_10 || (((bench_N2_stateReg == bench_N2_sReceive) && inStream_fire) && (bench_N2_padWriteAddrReg[0 : 0] == 1'b1)));
  assign _zz_bench_N2_wValsR_0_1 = 1'b1;
  assign _zz_bench_N2_wValsR_1_1 = 1'b1;
  assign _zz_bench_N2_biasVal_2 = 1'b1;
  assign _zz_bench_N2_reqMultVal_2 = 1'b1;
  assign _zz_bench_N2_reqShiftVal_2 = 1'b1;
  always @(posedge clk) begin
    if(_zz_bench_N2_inValsR_0_1) begin
      bench_N2_inputBuf_0_spinal_port0 <= bench_N2_inputBuf_0[_zz_bench_N2_inValsR_0];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N2_inputBuf_0_port_5) begin
      bench_N2_inputBuf_0[_zz_bench_N2_inputBuf_0_port_1] <= _zz_bench_N2_inputBuf_0_port_3;
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N2_inValsR_1_1) begin
      bench_N2_inputBuf_1_spinal_port0 <= bench_N2_inputBuf_1[_zz_bench_N2_inValsR_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N2_inputBuf_1_port_5) begin
      bench_N2_inputBuf_1[_zz_bench_N2_inputBuf_1_port_1] <= _zz_bench_N2_inputBuf_1_port_3;
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N2_weightRom_0.bin",bench_N2_weightRom_0);
  end
  always @(posedge clk) begin
    if(_zz_bench_N2_wValsR_0_1) begin
      bench_N2_weightRom_0_spinal_port0 <= bench_N2_weightRom_0[_zz_bench_N2_wValsR_0];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N2_weightRom_1.bin",bench_N2_weightRom_1);
  end
  always @(posedge clk) begin
    if(_zz_bench_N2_wValsR_1_1) begin
      bench_N2_weightRom_1_spinal_port0 <= bench_N2_weightRom_1[_zz_bench_N2_wValsR_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N2_biasRom.bin",bench_N2_biasRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N2_biasVal_2) begin
      bench_N2_biasRom_spinal_port0 <= bench_N2_biasRom[_zz_bench_N2_biasVal_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N2_reqMultRom.bin",bench_N2_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N2_reqMultVal_2) begin
      bench_N2_reqMultRom_spinal_port0 <= bench_N2_reqMultRom[_zz_bench_N2_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N2_reqShiftRom.bin",bench_N2_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N2_reqShiftVal_2) begin
      bench_N2_reqShiftRom_spinal_port0 <= bench_N2_reqShiftRom[_zz_bench_N2_reqShiftVal_1];
    end
  end

  assign inStream_valid = inValidR;
  assign inStream_payload_value = inValueR;
  assign bench_N2_sReceive = 4'b0000;
  assign bench_N2_sLoadBias = 4'b0001;
  assign bench_N2_sCompute = 4'b0010;
  assign bench_N2_sRequant = 4'b0011;
  assign bench_N2_sRequantMul = 4'b0100;
  assign bench_N2_sRequantWait = 4'b0101;
  assign bench_N2_sRequantWait2 = 4'b0110;
  assign bench_N2_sRequantWait3 = 4'b0111;
  assign bench_N2_sRequantShift = 4'b1000;
  assign bench_N2_sEmit = 4'b1001;
  assign bench_N2_sInit = 4'b1010;
  assign bench_N2_sWaitBias = 4'b1011;
  assign bench_N2_sLoadWeights = 4'b1100;
  assign bench_N2_reqProdReg1 = 64'h0;
  always @(*) begin
    bench_N2_inAddrComb = bench_N2_inAddrReg;
    if(when_QLinearConvCore_l412) begin
      if(when_QLinearConvCore_l416) begin
        bench_N2_inAddrComb = bench_N2_inAddrReg;
      end
    end
  end

  always @(*) begin
    bench_N2_wAddrComb = bench_N2_wAddrReg;
    if(when_QLinearConvCore_l412) begin
      if(when_QLinearConvCore_l416) begin
        bench_N2_wAddrComb = bench_N2_wAddrReg;
      end
    end
  end

  assign _zz_bench_N2_inValsR_0 = bench_N2_inAddrComb;
  assign bench_N2_inValsR_0 = bench_N2_inputBuf_0_spinal_port0;
  assign _zz_bench_N2_inValsR_1 = bench_N2_inAddrComb;
  assign bench_N2_inValsR_1 = bench_N2_inputBuf_1_spinal_port0;
  assign _zz_bench_N2_wValsR_0 = bench_N2_wAddrComb;
  assign bench_N2_wValsR_0 = bench_N2_weightRom_0_spinal_port0;
  assign _zz_bench_N2_wValsR_1 = bench_N2_wAddrComb;
  assign bench_N2_wValsR_1 = bench_N2_weightRom_1_spinal_port0;
  assign _zz_bench_N2_biasVal = bench_N2_outChReg;
  assign bench_N2_biasVal = bench_N2_biasRom_spinal_port0;
  assign _zz_bench_N2_reqMultVal = bench_N2_outChReg;
  assign bench_N2_reqMultVal = bench_N2_reqMultRom_spinal_port0;
  assign _zz_bench_N2_reqShiftVal = bench_N2_outChReg;
  assign bench_N2_reqShiftVal = bench_N2_reqShiftRom_spinal_port0;
  assign _zz_8 = (bench_N2_stateReg == bench_N2_sInit);
  assign inStream_fire = (inStream_valid && inStream_ready);
  assign _zz_10 = (bench_N2_stateReg == bench_N2_sInit);
  always @(*) begin
    inStream_ready = 1'b0;
    if(when_QLinearConvCore_l347) begin
      inStream_ready = 1'b1;
    end
  end

  always @(*) begin
    bench_N2_activationOut_valid = 1'b0;
    if(when_QLinearConvCore_l519) begin
      bench_N2_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    bench_N2_activationOut_payload_value = bench_N2_resultReg;
    if(when_QLinearConvCore_l519) begin
      bench_N2_activationOut_payload_value = bench_N2_resultReg;
    end
  end

  assign when_QLinearConvCore_l331 = (bench_N2_stateReg == bench_N2_sInit);
  assign when_QLinearConvCore_l333 = (bench_N2_initAddrReg == 10'h31f);
  assign when_QLinearConvCore_l347 = (bench_N2_stateReg == bench_N2_sReceive);
  assign _zz_bench_N2_padWriteAddrReg = (bench_N2_rowElemReg == 8'h7f);
  assign when_QLinearConvCore_l357 = (bench_N2_recvCntReg == 11'h3ff);
  assign when_QLinearConvCore_l390 = (bench_N2_stateReg == bench_N2_sLoadBias);
  assign when_QLinearConvCore_l404 = (bench_N2_stateReg == bench_N2_sWaitBias);
  assign when_QLinearConvCore_l412 = (bench_N2_stateReg == bench_N2_sCompute);
  assign when_QLinearConvCore_l416 = (bench_N2_compCycleReg < 7'h48);
  assign _zz_bench_N2_inAddrReg = (bench_N2_rowStepReg == 5'h17);
  assign when_QLinearConvCore_l429 = ((7'h01 <= bench_N2_compCycleReg) && (bench_N2_compCycleReg <= 7'h48));
  assign when_QLinearConvCore_l437 = ((7'h02 <= bench_N2_compCycleReg) && (bench_N2_compCycleReg <= 7'h49));
  assign when_QLinearConvCore_l448 = ((7'h03 <= bench_N2_compCycleReg) && (bench_N2_compCycleReg <= 7'h4a));
  assign _zz_bench_N2_accumReg = ($signed(bench_N2_accumReg) + $signed(bench_N2_prodReg));
  assign when_QLinearConvCore_l452 = (bench_N2_compCycleReg == 7'h4a);
  assign when_QLinearConvCore_l461 = (bench_N2_stateReg == bench_N2_sRequant);
  assign when_QLinearConvCore_l468 = (bench_N2_stateReg == bench_N2_sRequantMul);
  assign _zz_bench_N2_pHL_Reg = bench_N2_absAReg[31 : 16];
  assign _zz_bench_N2_pLL_Reg = bench_N2_absAReg[15 : 0];
  assign _zz_bench_N2_pLH_Reg = bench_N2_reqMultVal[31 : 16];
  assign _zz_bench_N2_pLL_Reg_1 = bench_N2_reqMultVal[15 : 0];
  assign when_QLinearConvCore_l485 = (bench_N2_stateReg == bench_N2_sRequantWait);
  assign when_QLinearConvCore_l493 = (bench_N2_stateReg == bench_N2_sRequantWait2);
  assign when_QLinearConvCore_l500 = (bench_N2_stateReg == bench_N2_sRequantWait3);
  assign _zz_bench_N2_reqProdReg2 = (bench_N2_part1Reg + bench_N2_part2Reg);
  assign when_QLinearConvCore_l508 = (bench_N2_stateReg == bench_N2_sRequantShift);
  assign _zz_bench_N2_resultReg = ($signed(_zz__zz_bench_N2_resultReg) + $signed(32'hffffff80));
  assign when_QLinearConvCore_l519 = (bench_N2_stateReg == bench_N2_sEmit);
  assign bench_N2_activationOut_fire = (bench_N2_activationOut_valid && bench_N2_activationOut_ready);
  assign when_QLinearConvCore_l529 = (bench_N2_outChReg == 6'h1f);
  assign when_QLinearConvCore_l531 = (bench_N2_outColReg == 4'b0111);
  assign _zz_bench_N2_stateReg = (bench_N2_outRowReg == 4'b0111);
  assign bench_N2_activationOut_ready = outReadyR;
  assign io_inReady = inStream_ready_regNext;
  assign io_outValid = bench_N2_activationOut_valid_regNext;
  assign io_outValue = bench_N2_activationOut_payload_value_regNext;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      inValidR <= 1'b0;
      inValueR <= 8'h0;
      outReadyR <= 1'b0;
      bench_N2_stateReg <= 4'b1010;
      bench_N2_recvCntReg <= 11'h0;
      bench_N2_padWriteAddrReg <= 11'h0b0;
      bench_N2_rowElemReg <= 8'h0;
      bench_N2_outRowReg <= 4'b0000;
      bench_N2_outColReg <= 4'b0000;
      bench_N2_outChReg <= 6'h0;
      bench_N2_accumReg <= 32'h0;
      bench_N2_prodReg <= 32'h0;
      bench_N2_resultReg <= 8'h0;
      bench_N2_reqProdReg2 <= 64'h0;
      bench_N2_accumRequantReg <= 32'h0;
      bench_N2_signAReg <= 1'b0;
      bench_N2_absAReg <= 32'h0;
      bench_N2_pLL_Reg <= 32'h0;
      bench_N2_pLH_Reg <= 32'h0;
      bench_N2_pHL_Reg <= 32'h0;
      bench_N2_pHH_Reg <= 32'h0;
      bench_N2_pSumReg <= 33'h0;
      bench_N2_pLL_Reg2 <= 32'h0;
      bench_N2_pHH_Reg2 <= 32'h0;
      bench_N2_part1Reg <= 64'h0;
      bench_N2_part2Reg <= 64'h0;
      bench_N2_initAddrReg <= 10'h0;
      bench_N2_inAddrReg <= 10'h0;
      bench_N2_wAddrReg <= 12'h0;
      bench_N2_compCycleReg <= 7'h0;
      bench_N2_rowStepReg <= 5'h0;
      bench_N2_inValsReg_0 <= 8'h0;
      bench_N2_inValsReg_1 <= 8'h0;
      bench_N2_wValsReg_0 <= 8'h0;
      bench_N2_wValsReg_1 <= 8'h0;
      inStream_ready_regNext <= 1'b0;
      bench_N2_activationOut_valid_regNext <= 1'b0;
      bench_N2_activationOut_payload_value_regNext <= 8'h0;
    end else begin
      inValidR <= io_inValid;
      inValueR <= io_inValue;
      outReadyR <= io_outReady;
      if(when_QLinearConvCore_l331) begin
        if(when_QLinearConvCore_l333) begin
          bench_N2_initAddrReg <= 10'h0;
          bench_N2_stateReg <= bench_N2_sReceive;
        end else begin
          bench_N2_initAddrReg <= (bench_N2_initAddrReg + 10'h001);
        end
      end
      if(when_QLinearConvCore_l347) begin
        if(inStream_fire) begin
          bench_N2_rowElemReg <= (_zz_bench_N2_padWriteAddrReg ? 8'h0 : _zz_bench_N2_rowElemReg);
          bench_N2_padWriteAddrReg <= (bench_N2_padWriteAddrReg + (_zz_bench_N2_padWriteAddrReg ? 11'h021 : 11'h001));
          bench_N2_recvCntReg <= (bench_N2_recvCntReg + 11'h001);
          if(when_QLinearConvCore_l357) begin
            bench_N2_recvCntReg <= 11'h0;
            bench_N2_rowElemReg <= 8'h0;
            bench_N2_padWriteAddrReg <= 11'h0b0;
            bench_N2_outRowReg <= 4'b0000;
            bench_N2_outColReg <= 4'b0000;
            bench_N2_outChReg <= 6'h0;
            bench_N2_stateReg <= bench_N2_sLoadBias;
          end
        end
      end
      if(when_QLinearConvCore_l390) begin
        bench_N2_inAddrReg <= _zz_bench_N2_inAddrReg_1[9:0];
        bench_N2_wAddrReg <= _zz_bench_N2_wAddrReg[11:0];
        bench_N2_compCycleReg <= 7'h0;
        bench_N2_rowStepReg <= 5'h0;
        bench_N2_stateReg <= bench_N2_sWaitBias;
      end
      if(when_QLinearConvCore_l404) begin
        bench_N2_accumReg <= bench_N2_biasVal;
        bench_N2_stateReg <= bench_N2_sCompute;
      end
      if(when_QLinearConvCore_l412) begin
        bench_N2_compCycleReg <= (bench_N2_compCycleReg + 7'h01);
        if(when_QLinearConvCore_l416) begin
          bench_N2_wAddrReg <= (bench_N2_wAddrReg + 12'h001);
          bench_N2_inAddrReg <= (bench_N2_inAddrReg + (_zz_bench_N2_inAddrReg ? 10'h039 : 10'h001));
          bench_N2_rowStepReg <= (_zz_bench_N2_inAddrReg ? 5'h0 : _zz_bench_N2_rowStepReg);
        end
        if(when_QLinearConvCore_l429) begin
          bench_N2_inValsReg_0 <= bench_N2_inValsR_0;
          bench_N2_wValsReg_0 <= bench_N2_wValsR_0;
          bench_N2_inValsReg_1 <= bench_N2_inValsR_1;
          bench_N2_wValsReg_1 <= bench_N2_wValsR_1;
        end
        if(when_QLinearConvCore_l437) begin
          bench_N2_prodReg <= ($signed(_zz_bench_N2_prodReg) + $signed(_zz_bench_N2_prodReg_6));
        end
        if(when_QLinearConvCore_l448) begin
          bench_N2_accumReg <= _zz_bench_N2_accumReg;
          if(when_QLinearConvCore_l452) begin
            bench_N2_accumRequantReg <= _zz_bench_N2_accumReg;
            bench_N2_stateReg <= bench_N2_sRequant;
            bench_N2_compCycleReg <= 7'h0;
          end
        end
      end
      if(when_QLinearConvCore_l461) begin
        bench_N2_absAReg <= _zz_bench_N2_absAReg;
        bench_N2_signAReg <= ($signed(bench_N2_accumRequantReg) < $signed(32'h0));
        bench_N2_stateReg <= bench_N2_sRequantMul;
      end
      if(when_QLinearConvCore_l468) begin
        bench_N2_pLL_Reg <= (_zz_bench_N2_pLL_Reg * _zz_bench_N2_pLL_Reg_1);
        bench_N2_pLH_Reg <= (_zz_bench_N2_pLL_Reg * _zz_bench_N2_pLH_Reg);
        bench_N2_pHL_Reg <= (_zz_bench_N2_pHL_Reg * _zz_bench_N2_pLL_Reg_1);
        bench_N2_pHH_Reg <= (_zz_bench_N2_pHL_Reg * _zz_bench_N2_pLH_Reg);
        bench_N2_stateReg <= bench_N2_sRequantWait;
      end
      if(when_QLinearConvCore_l485) begin
        bench_N2_pSumReg <= (_zz_bench_N2_pSumReg + _zz_bench_N2_pSumReg_1);
        bench_N2_pLL_Reg2 <= bench_N2_pLL_Reg;
        bench_N2_pHH_Reg2 <= bench_N2_pHH_Reg;
        bench_N2_stateReg <= bench_N2_sRequantWait2;
      end
      if(when_QLinearConvCore_l493) begin
        bench_N2_part1Reg <= (_zz_bench_N2_part1Reg + _zz_bench_N2_part1Reg_1);
        bench_N2_part2Reg <= _zz_bench_N2_part2Reg[63:0];
        bench_N2_stateReg <= bench_N2_sRequantWait3;
      end
      if(when_QLinearConvCore_l500) begin
        bench_N2_reqProdReg2 <= (bench_N2_signAReg ? _zz_bench_N2_reqProdReg2_1 : _zz_bench_N2_reqProdReg2_3);
        bench_N2_stateReg <= bench_N2_sRequantShift;
      end
      if(when_QLinearConvCore_l508) begin
        bench_N2_resultReg <= (($signed(32'h0000007f) < $signed(_zz_bench_N2_resultReg)) ? 8'h7f : _zz_bench_N2_resultReg_1);
        bench_N2_stateReg <= bench_N2_sEmit;
      end
      if(when_QLinearConvCore_l519) begin
        if(bench_N2_activationOut_fire) begin
          bench_N2_outChReg <= (when_QLinearConvCore_l529 ? 6'h0 : _zz_bench_N2_outChReg);
          if(when_QLinearConvCore_l529) begin
            bench_N2_outColReg <= (when_QLinearConvCore_l531 ? 4'b0000 : _zz_bench_N2_outColReg);
            if(when_QLinearConvCore_l531) begin
              bench_N2_outRowReg <= (_zz_bench_N2_stateReg ? 4'b0000 : _zz_bench_N2_outRowReg);
            end
          end
          bench_N2_stateReg <= (((when_QLinearConvCore_l529 && when_QLinearConvCore_l531) && _zz_bench_N2_stateReg) ? bench_N2_sReceive : bench_N2_sLoadBias);
        end
      end
      inStream_ready_regNext <= inStream_ready;
      bench_N2_activationOut_valid_regNext <= bench_N2_activationOut_valid;
      bench_N2_activationOut_payload_value_regNext <= bench_N2_activationOut_payload_value;
    end
  end


endmodule
