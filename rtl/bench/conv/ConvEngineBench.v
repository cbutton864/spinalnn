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

  reg        [7:0]    bench_inputBuf_0_spinal_port0;
  reg        [7:0]    bench_weightRom_0_spinal_port0;
  wire       [31:0]   bench_biasRom_spinal_port0;
  wire       [31:0]   bench_reqMultRom_spinal_port0;
  wire       [7:0]    bench_reqShiftRom_spinal_port0;
  wire                _zz_bench_inputBuf_0_port;
  wire                _zz_bench_inValsR_0_1;
  wire                _zz_bench_weightRom_0_port;
  wire                _zz_bench_wValsR_0_1;
  wire       [7:0]    _zz_bench_rowElemReg;
  wire       [7:0]    _zz_bench_inputBuf_0_port_1;
  wire       [4:0]    _zz_bench_accumReg_2;
  wire       [12:0]   _zz_bench_inAddrReg_1;
  wire       [12:0]   _zz_bench_inAddrReg_2;
  wire       [12:0]   _zz_bench_inAddrReg_3;
  wire       [4:0]    _zz_bench_inAddrReg_4;
  wire       [12:0]   _zz_bench_inAddrReg_5;
  wire       [9:0]    _zz_bench_inAddrReg_6;
  wire       [4:0]    _zz_bench_inAddrReg_7;
  wire       [12:0]   _zz_bench_inAddrReg_8;
  wire       [4:0]    _zz_bench_inAddrReg_9;
  wire       [13:0]   _zz_bench_wAddrReg;
  wire       [13:0]   _zz_bench_wAddrReg_1;
  wire       [13:0]   _zz_bench_wAddrReg_2;
  wire       [13:0]   _zz_bench_wAddrReg_3;
  wire       [13:0]   _zz_bench_wAddrReg_4;
  wire       [5:0]    _zz_bench_wAddrReg_5;
  wire       [13:0]   _zz_bench_wAddrReg_6;
  wire       [4:0]    _zz_bench_wAddrReg_7;
  wire       [13:0]   _zz_bench_wAddrReg_8;
  wire       [4:0]    _zz_bench_wAddrReg_9;
  wire       [4:0]    _zz_bench_biasRom_port;
  wire       [5:0]    _zz_bench_rowStepReg;
  wire       [17:0]   _zz_bench_prodReg;
  wire       [8:0]    _zz_bench_prodReg_1;
  wire       [8:0]    _zz_bench_prodReg_2;
  wire       [8:0]    _zz_bench_prodReg_3;
  wire       [8:0]    _zz_bench_prodReg_4;
  wire       [31:0]   _zz_bench_absAReg;
  wire       [31:0]   _zz_bench_absAReg_1;
  wire       [4:0]    _zz__zz_bench_pLL_Reg_1;
  wire       [4:0]    _zz_bench_reqMultRom_port;
  wire       [32:0]   _zz_bench_pSumReg;
  wire       [32:0]   _zz_bench_pSumReg_1;
  wire       [63:0]   _zz_bench_part1Reg;
  wire       [63:0]   _zz_bench_part1Reg_1;
  wire       [79:0]   _zz_bench_part1Reg_2;
  wire       [63:0]   _zz_bench_part1Reg_3;
  wire       [95:0]   _zz_bench_part2Reg;
  wire       [63:0]   _zz_bench_part2Reg_1;
  wire       [63:0]   _zz_bench_reqProdReg2_1;
  wire       [63:0]   _zz_bench_reqProdReg2_2;
  wire       [63:0]   _zz_bench_reqProdReg2_3;
  wire       [31:0]   _zz__zz_bench_resultReg_1;
  wire       [63:0]   _zz__zz_bench_resultReg_1_1;
  wire       [4:0]    _zz__zz_bench_resultReg_1_2;
  wire       [7:0]    _zz_bench_resultReg_2;
  wire       [7:0]    _zz_bench_resultReg_3;
  wire       [4:0]    _zz_bench_reqShiftRom_port;
  wire       [5:0]    _zz_bench_outChReg;
  wire       [3:0]    _zz_bench_outColReg;
  wire       [3:0]    _zz_bench_outRowReg;
  reg                 _zz_1;
  reg                 inValidR;
  reg        [7:0]    inValueR;
  reg                 outReadyR;
  wire                inStream_valid;
  reg                 inStream_ready;
  wire       [7:0]    inStream_payload_value;
  reg                 bench_activationOut_valid;
  wire                bench_activationOut_ready;
  reg        [7:0]    bench_activationOut_payload_value;
  wire       [3:0]    bench_sReceive;
  wire       [3:0]    bench_sLoadBias;
  wire       [3:0]    bench_sCompute;
  wire       [3:0]    bench_sRequant;
  wire       [3:0]    bench_sRequantMul;
  wire       [3:0]    bench_sRequantWait;
  wire       [3:0]    bench_sRequantWait2;
  wire       [3:0]    bench_sRequantWait3;
  wire       [3:0]    bench_sRequantShift;
  wire       [3:0]    bench_sEmit;
  reg        [3:0]    bench_stateReg;
  reg        [10:0]   bench_recvCntReg;
  reg        [10:0]   bench_padWriteAddrReg;
  reg        [7:0]    bench_rowElemReg;
  reg        [3:0]    bench_outRowReg;
  reg        [3:0]    bench_outColReg;
  reg        [5:0]    bench_outChReg;
  reg        [31:0]   bench_accumReg;
  reg        [31:0]   bench_prodReg;
  reg        [7:0]    bench_resultReg;
  wire       [63:0]   bench_reqProdReg1;
  reg        [63:0]   bench_reqProdReg2;
  reg        [31:0]   bench_accumRequantReg;
  reg                 bench_signAReg;
  reg        [31:0]   bench_absAReg;
  reg        [31:0]   bench_pLL_Reg;
  reg        [31:0]   bench_pLH_Reg;
  reg        [31:0]   bench_pHL_Reg;
  reg        [31:0]   bench_pHH_Reg;
  reg        [32:0]   bench_pSumReg;
  reg        [31:0]   bench_pLL_Reg2;
  reg        [31:0]   bench_pHH_Reg2;
  reg        [63:0]   bench_part1Reg;
  reg        [63:0]   bench_part2Reg;
  reg        [10:0]   bench_inAddrReg;
  reg        [12:0]   bench_wAddrReg;
  reg        [7:0]    bench_compCycleReg;
  reg        [5:0]    bench_rowStepReg;
  reg        [10:0]   bench_inAddrComb;
  reg        [12:0]   bench_wAddrComb;
  wire       [10:0]   _zz_bench_inValsR_0;
  wire       [7:0]    bench_inValsR_0;
  wire       [12:0]   _zz_bench_wValsR_0;
  wire       [7:0]    bench_wValsR_0;
  reg        [7:0]    bench_inValsReg_0;
  reg        [7:0]    bench_wValsReg_0;
  wire                when_QLinearConvCore_l262;
  wire                inStream_fire;
  wire                _zz_bench_padWriteAddrReg;
  wire                when_QLinearConvCore_l280;
  wire                when_QLinearConvCore_l291;
  wire       [5:0]    _zz_bench_accumReg;
  wire                when_QLinearConvCore_l306;
  wire                when_QLinearConvCore_l310;
  wire                _zz_bench_inAddrReg;
  wire                when_QLinearConvCore_l323;
  wire                when_QLinearConvCore_l331;
  wire                when_QLinearConvCore_l342;
  wire       [31:0]   _zz_bench_accumReg_1;
  wire                when_QLinearConvCore_l346;
  wire                when_QLinearConvCore_l355;
  wire                when_QLinearConvCore_l362;
  wire       [5:0]    _zz_bench_pLL_Reg;
  wire       [31:0]   _zz_bench_pLL_Reg_1;
  wire       [15:0]   _zz_bench_pHL_Reg;
  wire       [15:0]   _zz_bench_pLL_Reg_2;
  wire       [15:0]   _zz_bench_pLH_Reg;
  wire       [15:0]   _zz_bench_pLL_Reg_3;
  wire                when_QLinearConvCore_l381;
  wire                when_QLinearConvCore_l389;
  wire                when_QLinearConvCore_l396;
  wire       [63:0]   _zz_bench_reqProdReg2;
  wire                when_QLinearConvCore_l404;
  wire       [5:0]    _zz_bench_resultReg;
  wire       [31:0]   _zz_bench_resultReg_1;
  wire                when_QLinearConvCore_l416;
  wire                bench_activationOut_fire;
  wire                when_QLinearConvCore_l426;
  wire                when_QLinearConvCore_l428;
  wire                _zz_bench_stateReg;
  reg                 inStream_ready_regNext;
  reg                 bench_activationOut_valid_regNext;
  reg        [7:0]    bench_activationOut_payload_value_regNext;
  reg [7:0] bench_inputBuf_0 [0:1599];
  reg [7:0] bench_weightRom_0 [0:4607];
  reg [31:0] bench_biasRom [0:31];
  reg [31:0] bench_reqMultRom [0:31];
  reg [7:0] bench_reqShiftRom [0:31];

  assign _zz_bench_rowElemReg = (bench_rowElemReg + 8'h01);
  assign _zz_bench_biasRom_port = _zz_bench_accumReg[4:0];
  assign _zz_bench_inAddrReg_1 = (_zz_bench_inAddrReg_2 + _zz_bench_inAddrReg_8);
  assign _zz_bench_inAddrReg_2 = (_zz_bench_inAddrReg_3 + _zz_bench_inAddrReg_5);
  assign _zz_bench_inAddrReg_3 = (_zz_bench_inAddrReg_4 * 8'ha0);
  assign _zz_bench_inAddrReg_4 = (bench_outRowReg * 1'b1);
  assign _zz_bench_inAddrReg_6 = (_zz_bench_inAddrReg_7 * 5'h10);
  assign _zz_bench_inAddrReg_5 = {3'd0, _zz_bench_inAddrReg_6};
  assign _zz_bench_inAddrReg_7 = (bench_outColReg * 1'b1);
  assign _zz_bench_inAddrReg_9 = 5'h0;
  assign _zz_bench_inAddrReg_8 = {8'd0, _zz_bench_inAddrReg_9};
  assign _zz_bench_wAddrReg = (_zz_bench_wAddrReg_1 + _zz_bench_wAddrReg_8);
  assign _zz_bench_wAddrReg_1 = (_zz_bench_wAddrReg_2 + _zz_bench_wAddrReg_6);
  assign _zz_bench_wAddrReg_2 = (_zz_bench_wAddrReg_3 + _zz_bench_wAddrReg_4);
  assign _zz_bench_wAddrReg_3 = (bench_outChReg * 8'h90);
  assign _zz_bench_wAddrReg_5 = 6'h0;
  assign _zz_bench_wAddrReg_4 = {8'd0, _zz_bench_wAddrReg_5};
  assign _zz_bench_wAddrReg_7 = 5'h0;
  assign _zz_bench_wAddrReg_6 = {9'd0, _zz_bench_wAddrReg_7};
  assign _zz_bench_wAddrReg_9 = 5'h0;
  assign _zz_bench_wAddrReg_8 = {9'd0, _zz_bench_wAddrReg_9};
  assign _zz_bench_rowStepReg = (bench_rowStepReg + 6'h01);
  assign _zz_bench_prodReg = ($signed(_zz_bench_prodReg_1) * $signed(_zz_bench_prodReg_3));
  assign _zz_bench_prodReg_1 = ($signed(_zz_bench_prodReg_2) - $signed(9'h180));
  assign _zz_bench_prodReg_2 = {{1{bench_inValsReg_0[7]}}, bench_inValsReg_0};
  assign _zz_bench_prodReg_3 = ($signed(_zz_bench_prodReg_4) - $signed(9'h0));
  assign _zz_bench_prodReg_4 = {{1{bench_wValsReg_0[7]}}, bench_wValsReg_0};
  assign _zz_bench_absAReg = (($signed(bench_accumRequantReg) < $signed(32'h0)) ? _zz_bench_absAReg_1 : bench_accumRequantReg);
  assign _zz_bench_absAReg_1 = (- bench_accumRequantReg);
  assign _zz_bench_reqMultRom_port = _zz_bench_pLL_Reg[4:0];
  assign _zz_bench_pSumReg = {1'd0, bench_pLH_Reg};
  assign _zz_bench_pSumReg_1 = {1'd0, bench_pHL_Reg};
  assign _zz_bench_part1Reg = {32'd0, bench_pLL_Reg2};
  assign _zz_bench_part1Reg_2 = ({16'd0,_zz_bench_part1Reg_3} <<< 5'd16);
  assign _zz_bench_part1Reg_1 = _zz_bench_part1Reg_2[63:0];
  assign _zz_bench_part1Reg_3 = {31'd0, bench_pSumReg};
  assign _zz_bench_part2Reg = ({32'd0,_zz_bench_part2Reg_1} <<< 6'd32);
  assign _zz_bench_part2Reg_1 = {32'd0, bench_pHH_Reg2};
  assign _zz_bench_reqProdReg2_1 = (- _zz_bench_reqProdReg2_2);
  assign _zz_bench_reqProdReg2_2 = _zz_bench_reqProdReg2;
  assign _zz_bench_reqProdReg2_3 = _zz_bench_reqProdReg2;
  assign _zz__zz_bench_resultReg_1_1 = ($signed(bench_reqProdReg2) >>> bench_reqShiftRom_spinal_port0);
  assign _zz__zz_bench_resultReg_1 = _zz__zz_bench_resultReg_1_1[31:0];
  assign _zz_bench_reqShiftRom_port = _zz_bench_resultReg[4:0];
  assign _zz_bench_resultReg_2 = (($signed(_zz_bench_resultReg_1) < $signed(32'hffffff80)) ? 8'h80 : _zz_bench_resultReg_3);
  assign _zz_bench_resultReg_3 = _zz_bench_resultReg_1[7:0];
  assign _zz_bench_outChReg = (bench_outChReg + 6'h01);
  assign _zz_bench_outColReg = (bench_outColReg + 4'b0001);
  assign _zz_bench_outRowReg = (bench_outRowReg + 4'b0001);
  assign _zz_bench_inValsR_0_1 = 1'b1;
  assign _zz_bench_inputBuf_0_port_1 = inStream_payload_value;
  assign _zz_bench_wValsR_0_1 = 1'b1;
  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_inputBuf_0.bin",bench_inputBuf_0);
  end
  always @(posedge clk) begin
    if(_zz_bench_inValsR_0_1) begin
      bench_inputBuf_0_spinal_port0 <= bench_inputBuf_0[_zz_bench_inValsR_0];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      bench_inputBuf_0[bench_padWriteAddrReg] <= _zz_bench_inputBuf_0_port_1;
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_weightRom_0.bin",bench_weightRom_0);
  end
  always @(posedge clk) begin
    if(_zz_bench_wValsR_0_1) begin
      bench_weightRom_0_spinal_port0 <= bench_weightRom_0[_zz_bench_wValsR_0];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_biasRom.bin",bench_biasRom);
  end
  assign bench_biasRom_spinal_port0 = bench_biasRom[_zz_bench_biasRom_port];
  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_reqMultRom.bin",bench_reqMultRom);
  end
  assign bench_reqMultRom_spinal_port0 = bench_reqMultRom[_zz_bench_reqMultRom_port];
  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_reqShiftRom.bin",bench_reqShiftRom);
  end
  assign bench_reqShiftRom_spinal_port0 = bench_reqShiftRom[_zz_bench_reqShiftRom_port];
  always @(*) begin
    _zz_1 = 1'b0;
    if(when_QLinearConvCore_l262) begin
      if(inStream_fire) begin
        _zz_1 = 1'b1;
      end
    end
  end

  assign inStream_valid = inValidR;
  assign inStream_payload_value = inValueR;
  assign bench_sReceive = 4'b0000;
  assign bench_sLoadBias = 4'b0001;
  assign bench_sCompute = 4'b0010;
  assign bench_sRequant = 4'b0011;
  assign bench_sRequantMul = 4'b0100;
  assign bench_sRequantWait = 4'b0101;
  assign bench_sRequantWait2 = 4'b0110;
  assign bench_sRequantWait3 = 4'b0111;
  assign bench_sRequantShift = 4'b1000;
  assign bench_sEmit = 4'b1001;
  assign bench_reqProdReg1 = 64'h0;
  always @(*) begin
    bench_inAddrComb = bench_inAddrReg;
    if(when_QLinearConvCore_l306) begin
      if(when_QLinearConvCore_l310) begin
        bench_inAddrComb = bench_inAddrReg;
      end
    end
  end

  always @(*) begin
    bench_wAddrComb = bench_wAddrReg;
    if(when_QLinearConvCore_l306) begin
      if(when_QLinearConvCore_l310) begin
        bench_wAddrComb = bench_wAddrReg;
      end
    end
  end

  assign _zz_bench_inValsR_0 = bench_inAddrComb;
  assign bench_inValsR_0 = bench_inputBuf_0_spinal_port0;
  assign _zz_bench_wValsR_0 = bench_wAddrComb;
  assign bench_wValsR_0 = bench_weightRom_0_spinal_port0;
  always @(*) begin
    inStream_ready = 1'b0;
    if(when_QLinearConvCore_l262) begin
      inStream_ready = 1'b1;
    end
  end

  always @(*) begin
    bench_activationOut_valid = 1'b0;
    if(when_QLinearConvCore_l416) begin
      bench_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    bench_activationOut_payload_value = bench_resultReg;
    if(when_QLinearConvCore_l416) begin
      bench_activationOut_payload_value = bench_resultReg;
    end
  end

  assign when_QLinearConvCore_l262 = (bench_stateReg == bench_sReceive);
  assign inStream_fire = (inStream_valid && inStream_ready);
  assign _zz_bench_padWriteAddrReg = (bench_rowElemReg == 8'h7f);
  assign when_QLinearConvCore_l280 = (bench_recvCntReg == 11'h3ff);
  assign when_QLinearConvCore_l291 = (bench_stateReg == bench_sLoadBias);
  assign _zz_bench_accumReg = bench_outChReg;
  assign when_QLinearConvCore_l306 = (bench_stateReg == bench_sCompute);
  assign when_QLinearConvCore_l310 = (bench_compCycleReg < 8'h90);
  assign _zz_bench_inAddrReg = (bench_rowStepReg == 6'h2f);
  assign when_QLinearConvCore_l323 = ((8'h01 <= bench_compCycleReg) && (bench_compCycleReg <= 8'h90));
  assign when_QLinearConvCore_l331 = ((8'h02 <= bench_compCycleReg) && (bench_compCycleReg <= 8'h91));
  assign when_QLinearConvCore_l342 = ((8'h03 <= bench_compCycleReg) && (bench_compCycleReg <= 8'h92));
  assign _zz_bench_accumReg_1 = ($signed(bench_accumReg) + $signed(bench_prodReg));
  assign when_QLinearConvCore_l346 = (bench_compCycleReg == 8'h92);
  assign when_QLinearConvCore_l355 = (bench_stateReg == bench_sRequant);
  assign when_QLinearConvCore_l362 = (bench_stateReg == bench_sRequantMul);
  assign _zz_bench_pLL_Reg = bench_outChReg;
  assign _zz_bench_pLL_Reg_1 = bench_reqMultRom_spinal_port0;
  assign _zz_bench_pHL_Reg = bench_absAReg[31 : 16];
  assign _zz_bench_pLL_Reg_2 = bench_absAReg[15 : 0];
  assign _zz_bench_pLH_Reg = _zz_bench_pLL_Reg_1[31 : 16];
  assign _zz_bench_pLL_Reg_3 = _zz_bench_pLL_Reg_1[15 : 0];
  assign when_QLinearConvCore_l381 = (bench_stateReg == bench_sRequantWait);
  assign when_QLinearConvCore_l389 = (bench_stateReg == bench_sRequantWait2);
  assign when_QLinearConvCore_l396 = (bench_stateReg == bench_sRequantWait3);
  assign _zz_bench_reqProdReg2 = (bench_part1Reg + bench_part2Reg);
  assign when_QLinearConvCore_l404 = (bench_stateReg == bench_sRequantShift);
  assign _zz_bench_resultReg = bench_outChReg;
  assign _zz_bench_resultReg_1 = ($signed(_zz__zz_bench_resultReg_1) + $signed(32'hffffff80));
  assign when_QLinearConvCore_l416 = (bench_stateReg == bench_sEmit);
  assign bench_activationOut_fire = (bench_activationOut_valid && bench_activationOut_ready);
  assign when_QLinearConvCore_l426 = (bench_outChReg == 6'h1f);
  assign when_QLinearConvCore_l428 = (bench_outColReg == 4'b0111);
  assign _zz_bench_stateReg = (bench_outRowReg == 4'b0111);
  assign bench_activationOut_ready = outReadyR;
  assign io_inReady = inStream_ready_regNext;
  assign io_outValid = bench_activationOut_valid_regNext;
  assign io_outValue = bench_activationOut_payload_value_regNext;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      inValidR <= 1'b0;
      inValueR <= 8'h0;
      outReadyR <= 1'b0;
      bench_stateReg <= 4'b0000;
      bench_recvCntReg <= 11'h0;
      bench_padWriteAddrReg <= 11'h0b0;
      bench_rowElemReg <= 8'h0;
      bench_outRowReg <= 4'b0000;
      bench_outColReg <= 4'b0000;
      bench_outChReg <= 6'h0;
      bench_accumReg <= 32'h0;
      bench_prodReg <= 32'h0;
      bench_resultReg <= 8'h0;
      bench_reqProdReg2 <= 64'h0;
      bench_accumRequantReg <= 32'h0;
      bench_signAReg <= 1'b0;
      bench_absAReg <= 32'h0;
      bench_pLL_Reg <= 32'h0;
      bench_pLH_Reg <= 32'h0;
      bench_pHL_Reg <= 32'h0;
      bench_pHH_Reg <= 32'h0;
      bench_pSumReg <= 33'h0;
      bench_pLL_Reg2 <= 32'h0;
      bench_pHH_Reg2 <= 32'h0;
      bench_part1Reg <= 64'h0;
      bench_part2Reg <= 64'h0;
      bench_inAddrReg <= 11'h0;
      bench_wAddrReg <= 13'h0;
      bench_compCycleReg <= 8'h0;
      bench_rowStepReg <= 6'h0;
      bench_inValsReg_0 <= 8'h0;
      bench_wValsReg_0 <= 8'h0;
      inStream_ready_regNext <= 1'b0;
      bench_activationOut_valid_regNext <= 1'b0;
      bench_activationOut_payload_value_regNext <= 8'h0;
    end else begin
      inValidR <= io_inValid;
      inValueR <= io_inValue;
      outReadyR <= io_outReady;
      if(when_QLinearConvCore_l262) begin
        if(inStream_fire) begin
          bench_rowElemReg <= (_zz_bench_padWriteAddrReg ? 8'h0 : _zz_bench_rowElemReg);
          bench_padWriteAddrReg <= (bench_padWriteAddrReg + (_zz_bench_padWriteAddrReg ? 11'h021 : 11'h001));
          bench_recvCntReg <= (bench_recvCntReg + 11'h001);
          if(when_QLinearConvCore_l280) begin
            bench_recvCntReg <= 11'h0;
            bench_rowElemReg <= 8'h0;
            bench_padWriteAddrReg <= 11'h0b0;
            bench_outRowReg <= 4'b0000;
            bench_outColReg <= 4'b0000;
            bench_outChReg <= 6'h0;
            bench_stateReg <= bench_sLoadBias;
          end
        end
      end
      if(when_QLinearConvCore_l291) begin
        bench_accumReg <= bench_biasRom_spinal_port0;
        bench_inAddrReg <= _zz_bench_inAddrReg_1[10:0];
        bench_wAddrReg <= _zz_bench_wAddrReg[12:0];
        bench_compCycleReg <= 8'h0;
        bench_rowStepReg <= 6'h0;
        bench_stateReg <= bench_sCompute;
      end
      if(when_QLinearConvCore_l306) begin
        bench_compCycleReg <= (bench_compCycleReg + 8'h01);
        if(when_QLinearConvCore_l310) begin
          bench_wAddrReg <= (bench_wAddrReg + 13'h0001);
          bench_inAddrReg <= (bench_inAddrReg + (_zz_bench_inAddrReg ? 11'h071 : 11'h001));
          bench_rowStepReg <= (_zz_bench_inAddrReg ? 6'h0 : _zz_bench_rowStepReg);
        end
        if(when_QLinearConvCore_l323) begin
          bench_inValsReg_0 <= bench_inValsR_0;
          bench_wValsReg_0 <= bench_wValsR_0;
        end
        if(when_QLinearConvCore_l331) begin
          bench_prodReg <= {{14{_zz_bench_prodReg[17]}}, _zz_bench_prodReg};
        end
        if(when_QLinearConvCore_l342) begin
          bench_accumReg <= _zz_bench_accumReg_1;
          if(when_QLinearConvCore_l346) begin
            bench_accumRequantReg <= _zz_bench_accumReg_1;
            bench_stateReg <= bench_sRequant;
            bench_compCycleReg <= 8'h0;
          end
        end
      end
      if(when_QLinearConvCore_l355) begin
        bench_absAReg <= _zz_bench_absAReg;
        bench_signAReg <= ($signed(bench_accumRequantReg) < $signed(32'h0));
        bench_stateReg <= bench_sRequantMul;
      end
      if(when_QLinearConvCore_l362) begin
        bench_pLL_Reg <= (_zz_bench_pLL_Reg_2 * _zz_bench_pLL_Reg_3);
        bench_pLH_Reg <= (_zz_bench_pLL_Reg_2 * _zz_bench_pLH_Reg);
        bench_pHL_Reg <= (_zz_bench_pHL_Reg * _zz_bench_pLL_Reg_3);
        bench_pHH_Reg <= (_zz_bench_pHL_Reg * _zz_bench_pLH_Reg);
        bench_stateReg <= bench_sRequantWait;
      end
      if(when_QLinearConvCore_l381) begin
        bench_pSumReg <= (_zz_bench_pSumReg + _zz_bench_pSumReg_1);
        bench_pLL_Reg2 <= bench_pLL_Reg;
        bench_pHH_Reg2 <= bench_pHH_Reg;
        bench_stateReg <= bench_sRequantWait2;
      end
      if(when_QLinearConvCore_l389) begin
        bench_part1Reg <= (_zz_bench_part1Reg + _zz_bench_part1Reg_1);
        bench_part2Reg <= _zz_bench_part2Reg[63:0];
        bench_stateReg <= bench_sRequantWait3;
      end
      if(when_QLinearConvCore_l396) begin
        bench_reqProdReg2 <= (bench_signAReg ? _zz_bench_reqProdReg2_1 : _zz_bench_reqProdReg2_3);
        bench_stateReg <= bench_sRequantShift;
      end
      if(when_QLinearConvCore_l404) begin
        bench_resultReg <= (($signed(32'h0000007f) < $signed(_zz_bench_resultReg_1)) ? 8'h7f : _zz_bench_resultReg_2);
        bench_stateReg <= bench_sEmit;
      end
      if(when_QLinearConvCore_l416) begin
        if(bench_activationOut_fire) begin
          bench_outChReg <= (when_QLinearConvCore_l426 ? 6'h0 : _zz_bench_outChReg);
          if(when_QLinearConvCore_l426) begin
            bench_outColReg <= (when_QLinearConvCore_l428 ? 4'b0000 : _zz_bench_outColReg);
            if(when_QLinearConvCore_l428) begin
              bench_outRowReg <= (_zz_bench_stateReg ? 4'b0000 : _zz_bench_outRowReg);
            end
          end
          bench_stateReg <= (((when_QLinearConvCore_l426 && when_QLinearConvCore_l428) && _zz_bench_stateReg) ? bench_sReceive : bench_sLoadBias);
        end
      end
      inStream_ready_regNext <= inStream_ready;
      bench_activationOut_valid_regNext <= bench_activationOut_valid;
      bench_activationOut_payload_value_regNext <= bench_activationOut_payload_value;
    end
  end


endmodule
