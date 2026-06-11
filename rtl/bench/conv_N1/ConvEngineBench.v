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

  reg        [7:0]    bench_N1_inputBuf_0_spinal_port0;
  reg        [7:0]    bench_N1_weightRom_0_spinal_port0;
  reg        [31:0]   bench_N1_biasRom_spinal_port0;
  reg        [31:0]   bench_N1_reqMultRom_spinal_port0;
  reg        [7:0]    bench_N1_reqShiftRom_spinal_port0;
  wire                _zz_bench_N1_inputBuf_0_port;
  wire                _zz_bench_N1_inValsR_0_1;
  wire                _zz_bench_N1_weightRom_0_port;
  wire                _zz_bench_N1_wValsR_0_1;
  wire       [4:0]    _zz_bench_N1_biasRom_port;
  wire                _zz_bench_N1_biasRom_port_1;
  wire       [4:0]    _zz_bench_N1_biasVal_1;
  wire                _zz_bench_N1_biasVal_2;
  wire       [4:0]    _zz_bench_N1_reqMultRom_port;
  wire                _zz_bench_N1_reqMultRom_port_1;
  wire       [4:0]    _zz_bench_N1_reqMultVal_1;
  wire                _zz_bench_N1_reqMultVal_2;
  wire       [4:0]    _zz_bench_N1_reqShiftRom_port;
  wire                _zz_bench_N1_reqShiftRom_port_1;
  wire       [4:0]    _zz_bench_N1_reqShiftVal_1;
  wire                _zz_bench_N1_reqShiftVal_2;
  wire       [10:0]   _zz_bench_N1_inputBuf_0_port_1;
  wire       [7:0]    _zz_bench_N1_inputBuf_0_port_2;
  wire       [7:0]    _zz_bench_N1_inputBuf_0_port_3;
  wire                _zz_bench_N1_inputBuf_0_port_4;
  wire       [7:0]    _zz_bench_N1_rowElemReg;
  wire       [12:0]   _zz_bench_N1_inAddrReg_1;
  wire       [12:0]   _zz_bench_N1_inAddrReg_2;
  wire       [12:0]   _zz_bench_N1_inAddrReg_3;
  wire       [4:0]    _zz_bench_N1_inAddrReg_4;
  wire       [12:0]   _zz_bench_N1_inAddrReg_5;
  wire       [9:0]    _zz_bench_N1_inAddrReg_6;
  wire       [4:0]    _zz_bench_N1_inAddrReg_7;
  wire       [12:0]   _zz_bench_N1_inAddrReg_8;
  wire       [4:0]    _zz_bench_N1_inAddrReg_9;
  wire       [13:0]   _zz_bench_N1_wAddrReg;
  wire       [13:0]   _zz_bench_N1_wAddrReg_1;
  wire       [13:0]   _zz_bench_N1_wAddrReg_2;
  wire       [13:0]   _zz_bench_N1_wAddrReg_3;
  wire       [13:0]   _zz_bench_N1_wAddrReg_4;
  wire       [5:0]    _zz_bench_N1_wAddrReg_5;
  wire       [13:0]   _zz_bench_N1_wAddrReg_6;
  wire       [4:0]    _zz_bench_N1_wAddrReg_7;
  wire       [13:0]   _zz_bench_N1_wAddrReg_8;
  wire       [4:0]    _zz_bench_N1_wAddrReg_9;
  wire       [5:0]    _zz_bench_N1_rowStepReg;
  wire       [17:0]   _zz_bench_N1_prodReg;
  wire       [8:0]    _zz_bench_N1_prodReg_1;
  wire       [8:0]    _zz_bench_N1_prodReg_2;
  wire       [8:0]    _zz_bench_N1_prodReg_3;
  wire       [8:0]    _zz_bench_N1_prodReg_4;
  wire       [31:0]   _zz_bench_N1_absAReg;
  wire       [31:0]   _zz_bench_N1_absAReg_1;
  wire       [32:0]   _zz_bench_N1_pSumReg;
  wire       [32:0]   _zz_bench_N1_pSumReg_1;
  wire       [63:0]   _zz_bench_N1_part1Reg;
  wire       [63:0]   _zz_bench_N1_part1Reg_1;
  wire       [79:0]   _zz_bench_N1_part1Reg_2;
  wire       [63:0]   _zz_bench_N1_part1Reg_3;
  wire       [95:0]   _zz_bench_N1_part2Reg;
  wire       [63:0]   _zz_bench_N1_part2Reg_1;
  wire       [63:0]   _zz_bench_N1_reqProdReg2_1;
  wire       [63:0]   _zz_bench_N1_reqProdReg2_2;
  wire       [63:0]   _zz_bench_N1_reqProdReg2_3;
  wire       [31:0]   _zz__zz_bench_N1_resultReg;
  wire       [63:0]   _zz__zz_bench_N1_resultReg_1;
  wire       [7:0]    _zz_bench_N1_resultReg_1;
  wire       [7:0]    _zz_bench_N1_resultReg_2;
  wire       [5:0]    _zz_bench_N1_outChReg;
  wire       [3:0]    _zz_bench_N1_outColReg;
  wire       [3:0]    _zz_bench_N1_outRowReg;
  reg                 inValidR;
  reg        [7:0]    inValueR;
  reg                 outReadyR;
  wire                inStream_valid;
  reg                 inStream_ready;
  wire       [7:0]    inStream_payload_value;
  reg                 bench_N1_activationOut_valid;
  wire                bench_N1_activationOut_ready;
  reg        [7:0]    bench_N1_activationOut_payload_value;
  wire       [3:0]    bench_N1_sReceive;
  wire       [3:0]    bench_N1_sLoadBias;
  wire       [3:0]    bench_N1_sCompute;
  wire       [3:0]    bench_N1_sRequant;
  wire       [3:0]    bench_N1_sRequantMul;
  wire       [3:0]    bench_N1_sRequantWait;
  wire       [3:0]    bench_N1_sRequantWait2;
  wire       [3:0]    bench_N1_sRequantWait3;
  wire       [3:0]    bench_N1_sRequantShift;
  wire       [3:0]    bench_N1_sEmit;
  wire       [3:0]    bench_N1_sInit;
  wire       [3:0]    bench_N1_sWaitBias;
  wire       [3:0]    bench_N1_sLoadWeights;
  reg        [3:0]    bench_N1_stateReg;
  reg        [10:0]   bench_N1_recvCntReg;
  reg        [10:0]   bench_N1_padWriteAddrReg;
  reg        [7:0]    bench_N1_rowElemReg;
  reg        [3:0]    bench_N1_outRowReg;
  reg        [3:0]    bench_N1_outColReg;
  reg        [5:0]    bench_N1_outChReg;
  reg        [31:0]   bench_N1_accumReg;
  reg        [31:0]   bench_N1_prodReg;
  reg        [7:0]    bench_N1_resultReg;
  wire       [63:0]   bench_N1_reqProdReg1;
  reg        [63:0]   bench_N1_reqProdReg2;
  reg        [31:0]   bench_N1_accumRequantReg;
  reg                 bench_N1_signAReg;
  reg        [31:0]   bench_N1_absAReg;
  reg        [31:0]   bench_N1_pLL_Reg;
  reg        [31:0]   bench_N1_pLH_Reg;
  reg        [31:0]   bench_N1_pHL_Reg;
  reg        [31:0]   bench_N1_pHH_Reg;
  reg        [32:0]   bench_N1_pSumReg;
  reg        [31:0]   bench_N1_pLL_Reg2;
  reg        [31:0]   bench_N1_pHH_Reg2;
  reg        [63:0]   bench_N1_part1Reg;
  reg        [63:0]   bench_N1_part2Reg;
  reg        [10:0]   bench_N1_initAddrReg;
  reg        [10:0]   bench_N1_inAddrReg;
  reg        [12:0]   bench_N1_wAddrReg;
  reg        [7:0]    bench_N1_compCycleReg;
  reg        [5:0]    bench_N1_rowStepReg;
  reg        [10:0]   bench_N1_inAddrComb;
  reg        [12:0]   bench_N1_wAddrComb;
  wire       [10:0]   _zz_bench_N1_inValsR_0;
  wire       [7:0]    bench_N1_inValsR_0;
  wire       [12:0]   _zz_bench_N1_wValsR_0;
  wire       [7:0]    bench_N1_wValsR_0;
  wire       [5:0]    _zz_bench_N1_biasVal;
  wire       [31:0]   bench_N1_biasVal;
  wire       [5:0]    _zz_bench_N1_reqMultVal;
  wire       [31:0]   bench_N1_reqMultVal;
  wire       [5:0]    _zz_bench_N1_reqShiftVal;
  wire       [7:0]    bench_N1_reqShiftVal;
  reg        [7:0]    bench_N1_inValsReg_0;
  reg        [7:0]    bench_N1_wValsReg_0;
  wire                _zz_6;
  wire                inStream_fire;
  wire                when_QLinearConvCore_l331;
  wire                when_QLinearConvCore_l333;
  wire                when_QLinearConvCore_l347;
  wire                _zz_bench_N1_padWriteAddrReg;
  wire                when_QLinearConvCore_l357;
  wire                when_QLinearConvCore_l390;
  wire                when_QLinearConvCore_l404;
  wire                when_QLinearConvCore_l412;
  wire                when_QLinearConvCore_l416;
  wire                _zz_bench_N1_inAddrReg;
  wire                when_QLinearConvCore_l429;
  wire                when_QLinearConvCore_l437;
  wire                when_QLinearConvCore_l448;
  wire       [31:0]   _zz_bench_N1_accumReg;
  wire                when_QLinearConvCore_l452;
  wire                when_QLinearConvCore_l461;
  wire                when_QLinearConvCore_l468;
  wire       [15:0]   _zz_bench_N1_pHL_Reg;
  wire       [15:0]   _zz_bench_N1_pLL_Reg;
  wire       [15:0]   _zz_bench_N1_pLH_Reg;
  wire       [15:0]   _zz_bench_N1_pLL_Reg_1;
  wire                when_QLinearConvCore_l485;
  wire                when_QLinearConvCore_l493;
  wire                when_QLinearConvCore_l500;
  wire       [63:0]   _zz_bench_N1_reqProdReg2;
  wire                when_QLinearConvCore_l508;
  wire       [31:0]   _zz_bench_N1_resultReg;
  wire                when_QLinearConvCore_l519;
  wire                bench_N1_activationOut_fire;
  wire                when_QLinearConvCore_l529;
  wire                when_QLinearConvCore_l531;
  wire                _zz_bench_N1_stateReg;
  reg                 inStream_ready_regNext;
  reg                 bench_N1_activationOut_valid_regNext;
  reg        [7:0]    bench_N1_activationOut_payload_value_regNext;
  reg [7:0] bench_N1_inputBuf_0 [0:1599];
  reg [7:0] bench_N1_weightRom_0 [0:4607];
  reg [31:0] bench_N1_biasRom [0:31];
  reg [31:0] bench_N1_reqMultRom [0:31];
  reg [7:0] bench_N1_reqShiftRom [0:31];

  assign _zz_bench_N1_biasVal_1 = _zz_bench_N1_biasVal[4:0];
  assign _zz_bench_N1_reqMultVal_1 = _zz_bench_N1_reqMultVal[4:0];
  assign _zz_bench_N1_reqShiftVal_1 = _zz_bench_N1_reqShiftVal[4:0];
  assign _zz_bench_N1_inputBuf_0_port_3 = (_zz_6 ? 8'h80 : inStream_payload_value);
  assign _zz_bench_N1_rowElemReg = (bench_N1_rowElemReg + 8'h01);
  assign _zz_bench_N1_inAddrReg_1 = (_zz_bench_N1_inAddrReg_2 + _zz_bench_N1_inAddrReg_8);
  assign _zz_bench_N1_inAddrReg_2 = (_zz_bench_N1_inAddrReg_3 + _zz_bench_N1_inAddrReg_5);
  assign _zz_bench_N1_inAddrReg_3 = (_zz_bench_N1_inAddrReg_4 * 8'ha0);
  assign _zz_bench_N1_inAddrReg_4 = (bench_N1_outRowReg * 1'b1);
  assign _zz_bench_N1_inAddrReg_6 = (_zz_bench_N1_inAddrReg_7 * 5'h10);
  assign _zz_bench_N1_inAddrReg_5 = {3'd0, _zz_bench_N1_inAddrReg_6};
  assign _zz_bench_N1_inAddrReg_7 = (bench_N1_outColReg * 1'b1);
  assign _zz_bench_N1_inAddrReg_9 = 5'h0;
  assign _zz_bench_N1_inAddrReg_8 = {8'd0, _zz_bench_N1_inAddrReg_9};
  assign _zz_bench_N1_wAddrReg = (_zz_bench_N1_wAddrReg_1 + _zz_bench_N1_wAddrReg_8);
  assign _zz_bench_N1_wAddrReg_1 = (_zz_bench_N1_wAddrReg_2 + _zz_bench_N1_wAddrReg_6);
  assign _zz_bench_N1_wAddrReg_2 = (_zz_bench_N1_wAddrReg_3 + _zz_bench_N1_wAddrReg_4);
  assign _zz_bench_N1_wAddrReg_3 = (bench_N1_outChReg * 8'h90);
  assign _zz_bench_N1_wAddrReg_5 = 6'h0;
  assign _zz_bench_N1_wAddrReg_4 = {8'd0, _zz_bench_N1_wAddrReg_5};
  assign _zz_bench_N1_wAddrReg_7 = 5'h0;
  assign _zz_bench_N1_wAddrReg_6 = {9'd0, _zz_bench_N1_wAddrReg_7};
  assign _zz_bench_N1_wAddrReg_9 = 5'h0;
  assign _zz_bench_N1_wAddrReg_8 = {9'd0, _zz_bench_N1_wAddrReg_9};
  assign _zz_bench_N1_rowStepReg = (bench_N1_rowStepReg + 6'h01);
  assign _zz_bench_N1_prodReg = ($signed(_zz_bench_N1_prodReg_1) * $signed(_zz_bench_N1_prodReg_3));
  assign _zz_bench_N1_prodReg_1 = ($signed(_zz_bench_N1_prodReg_2) - $signed(9'h180));
  assign _zz_bench_N1_prodReg_2 = {{1{bench_N1_inValsReg_0[7]}}, bench_N1_inValsReg_0};
  assign _zz_bench_N1_prodReg_3 = ($signed(_zz_bench_N1_prodReg_4) - $signed(9'h0));
  assign _zz_bench_N1_prodReg_4 = {{1{bench_N1_wValsReg_0[7]}}, bench_N1_wValsReg_0};
  assign _zz_bench_N1_absAReg = (($signed(bench_N1_accumRequantReg) < $signed(32'h0)) ? _zz_bench_N1_absAReg_1 : bench_N1_accumRequantReg);
  assign _zz_bench_N1_absAReg_1 = (- bench_N1_accumRequantReg);
  assign _zz_bench_N1_pSumReg = {1'd0, bench_N1_pLH_Reg};
  assign _zz_bench_N1_pSumReg_1 = {1'd0, bench_N1_pHL_Reg};
  assign _zz_bench_N1_part1Reg = {32'd0, bench_N1_pLL_Reg2};
  assign _zz_bench_N1_part1Reg_2 = ({16'd0,_zz_bench_N1_part1Reg_3} <<< 5'd16);
  assign _zz_bench_N1_part1Reg_1 = _zz_bench_N1_part1Reg_2[63:0];
  assign _zz_bench_N1_part1Reg_3 = {31'd0, bench_N1_pSumReg};
  assign _zz_bench_N1_part2Reg = ({32'd0,_zz_bench_N1_part2Reg_1} <<< 6'd32);
  assign _zz_bench_N1_part2Reg_1 = {32'd0, bench_N1_pHH_Reg2};
  assign _zz_bench_N1_reqProdReg2_1 = (- _zz_bench_N1_reqProdReg2_2);
  assign _zz_bench_N1_reqProdReg2_2 = _zz_bench_N1_reqProdReg2;
  assign _zz_bench_N1_reqProdReg2_3 = _zz_bench_N1_reqProdReg2;
  assign _zz__zz_bench_N1_resultReg_1 = ($signed(bench_N1_reqProdReg2) >>> bench_N1_reqShiftVal);
  assign _zz__zz_bench_N1_resultReg = _zz__zz_bench_N1_resultReg_1[31:0];
  assign _zz_bench_N1_resultReg_1 = (($signed(_zz_bench_N1_resultReg) < $signed(32'hffffff80)) ? 8'h80 : _zz_bench_N1_resultReg_2);
  assign _zz_bench_N1_resultReg_2 = _zz_bench_N1_resultReg[7:0];
  assign _zz_bench_N1_outChReg = (bench_N1_outChReg + 6'h01);
  assign _zz_bench_N1_outColReg = (bench_N1_outColReg + 4'b0001);
  assign _zz_bench_N1_outRowReg = (bench_N1_outRowReg + 4'b0001);
  assign _zz_bench_N1_inValsR_0_1 = 1'b1;
  assign _zz_bench_N1_inputBuf_0_port_1 = (_zz_6 ? bench_N1_initAddrReg : bench_N1_padWriteAddrReg);
  assign _zz_bench_N1_inputBuf_0_port_2 = _zz_bench_N1_inputBuf_0_port_3;
  assign _zz_bench_N1_inputBuf_0_port_4 = (_zz_6 || ((bench_N1_stateReg == bench_N1_sReceive) && inStream_fire));
  assign _zz_bench_N1_wValsR_0_1 = 1'b1;
  assign _zz_bench_N1_biasVal_2 = 1'b1;
  assign _zz_bench_N1_reqMultVal_2 = 1'b1;
  assign _zz_bench_N1_reqShiftVal_2 = 1'b1;
  always @(posedge clk) begin
    if(_zz_bench_N1_inValsR_0_1) begin
      bench_N1_inputBuf_0_spinal_port0 <= bench_N1_inputBuf_0[_zz_bench_N1_inValsR_0];
    end
  end

  always @(posedge clk) begin
    if(_zz_bench_N1_inputBuf_0_port_4) begin
      bench_N1_inputBuf_0[_zz_bench_N1_inputBuf_0_port_1] <= _zz_bench_N1_inputBuf_0_port_2;
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N1_weightRom_0.bin",bench_N1_weightRom_0);
  end
  always @(posedge clk) begin
    if(_zz_bench_N1_wValsR_0_1) begin
      bench_N1_weightRom_0_spinal_port0 <= bench_N1_weightRom_0[_zz_bench_N1_wValsR_0];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N1_biasRom.bin",bench_N1_biasRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N1_biasVal_2) begin
      bench_N1_biasRom_spinal_port0 <= bench_N1_biasRom[_zz_bench_N1_biasVal_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N1_reqMultRom.bin",bench_N1_reqMultRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N1_reqMultVal_2) begin
      bench_N1_reqMultRom_spinal_port0 <= bench_N1_reqMultRom[_zz_bench_N1_reqMultVal_1];
    end
  end

  initial begin
    $readmemb("ConvEngineBench.v_toplevel_bench_N1_reqShiftRom.bin",bench_N1_reqShiftRom);
  end
  always @(posedge clk) begin
    if(_zz_bench_N1_reqShiftVal_2) begin
      bench_N1_reqShiftRom_spinal_port0 <= bench_N1_reqShiftRom[_zz_bench_N1_reqShiftVal_1];
    end
  end

  assign inStream_valid = inValidR;
  assign inStream_payload_value = inValueR;
  assign bench_N1_sReceive = 4'b0000;
  assign bench_N1_sLoadBias = 4'b0001;
  assign bench_N1_sCompute = 4'b0010;
  assign bench_N1_sRequant = 4'b0011;
  assign bench_N1_sRequantMul = 4'b0100;
  assign bench_N1_sRequantWait = 4'b0101;
  assign bench_N1_sRequantWait2 = 4'b0110;
  assign bench_N1_sRequantWait3 = 4'b0111;
  assign bench_N1_sRequantShift = 4'b1000;
  assign bench_N1_sEmit = 4'b1001;
  assign bench_N1_sInit = 4'b1010;
  assign bench_N1_sWaitBias = 4'b1011;
  assign bench_N1_sLoadWeights = 4'b1100;
  assign bench_N1_reqProdReg1 = 64'h0;
  always @(*) begin
    bench_N1_inAddrComb = bench_N1_inAddrReg;
    if(when_QLinearConvCore_l412) begin
      if(when_QLinearConvCore_l416) begin
        bench_N1_inAddrComb = bench_N1_inAddrReg;
      end
    end
  end

  always @(*) begin
    bench_N1_wAddrComb = bench_N1_wAddrReg;
    if(when_QLinearConvCore_l412) begin
      if(when_QLinearConvCore_l416) begin
        bench_N1_wAddrComb = bench_N1_wAddrReg;
      end
    end
  end

  assign _zz_bench_N1_inValsR_0 = bench_N1_inAddrComb;
  assign bench_N1_inValsR_0 = bench_N1_inputBuf_0_spinal_port0;
  assign _zz_bench_N1_wValsR_0 = bench_N1_wAddrComb;
  assign bench_N1_wValsR_0 = bench_N1_weightRom_0_spinal_port0;
  assign _zz_bench_N1_biasVal = bench_N1_outChReg;
  assign bench_N1_biasVal = bench_N1_biasRom_spinal_port0;
  assign _zz_bench_N1_reqMultVal = bench_N1_outChReg;
  assign bench_N1_reqMultVal = bench_N1_reqMultRom_spinal_port0;
  assign _zz_bench_N1_reqShiftVal = bench_N1_outChReg;
  assign bench_N1_reqShiftVal = bench_N1_reqShiftRom_spinal_port0;
  assign _zz_6 = (bench_N1_stateReg == bench_N1_sInit);
  assign inStream_fire = (inStream_valid && inStream_ready);
  always @(*) begin
    inStream_ready = 1'b0;
    if(when_QLinearConvCore_l347) begin
      inStream_ready = 1'b1;
    end
  end

  always @(*) begin
    bench_N1_activationOut_valid = 1'b0;
    if(when_QLinearConvCore_l519) begin
      bench_N1_activationOut_valid = 1'b1;
    end
  end

  always @(*) begin
    bench_N1_activationOut_payload_value = bench_N1_resultReg;
    if(when_QLinearConvCore_l519) begin
      bench_N1_activationOut_payload_value = bench_N1_resultReg;
    end
  end

  assign when_QLinearConvCore_l331 = (bench_N1_stateReg == bench_N1_sInit);
  assign when_QLinearConvCore_l333 = (bench_N1_initAddrReg == 11'h63f);
  assign when_QLinearConvCore_l347 = (bench_N1_stateReg == bench_N1_sReceive);
  assign _zz_bench_N1_padWriteAddrReg = (bench_N1_rowElemReg == 8'h7f);
  assign when_QLinearConvCore_l357 = (bench_N1_recvCntReg == 11'h3ff);
  assign when_QLinearConvCore_l390 = (bench_N1_stateReg == bench_N1_sLoadBias);
  assign when_QLinearConvCore_l404 = (bench_N1_stateReg == bench_N1_sWaitBias);
  assign when_QLinearConvCore_l412 = (bench_N1_stateReg == bench_N1_sCompute);
  assign when_QLinearConvCore_l416 = (bench_N1_compCycleReg < 8'h90);
  assign _zz_bench_N1_inAddrReg = (bench_N1_rowStepReg == 6'h2f);
  assign when_QLinearConvCore_l429 = ((8'h01 <= bench_N1_compCycleReg) && (bench_N1_compCycleReg <= 8'h90));
  assign when_QLinearConvCore_l437 = ((8'h02 <= bench_N1_compCycleReg) && (bench_N1_compCycleReg <= 8'h91));
  assign when_QLinearConvCore_l448 = ((8'h03 <= bench_N1_compCycleReg) && (bench_N1_compCycleReg <= 8'h92));
  assign _zz_bench_N1_accumReg = ($signed(bench_N1_accumReg) + $signed(bench_N1_prodReg));
  assign when_QLinearConvCore_l452 = (bench_N1_compCycleReg == 8'h92);
  assign when_QLinearConvCore_l461 = (bench_N1_stateReg == bench_N1_sRequant);
  assign when_QLinearConvCore_l468 = (bench_N1_stateReg == bench_N1_sRequantMul);
  assign _zz_bench_N1_pHL_Reg = bench_N1_absAReg[31 : 16];
  assign _zz_bench_N1_pLL_Reg = bench_N1_absAReg[15 : 0];
  assign _zz_bench_N1_pLH_Reg = bench_N1_reqMultVal[31 : 16];
  assign _zz_bench_N1_pLL_Reg_1 = bench_N1_reqMultVal[15 : 0];
  assign when_QLinearConvCore_l485 = (bench_N1_stateReg == bench_N1_sRequantWait);
  assign when_QLinearConvCore_l493 = (bench_N1_stateReg == bench_N1_sRequantWait2);
  assign when_QLinearConvCore_l500 = (bench_N1_stateReg == bench_N1_sRequantWait3);
  assign _zz_bench_N1_reqProdReg2 = (bench_N1_part1Reg + bench_N1_part2Reg);
  assign when_QLinearConvCore_l508 = (bench_N1_stateReg == bench_N1_sRequantShift);
  assign _zz_bench_N1_resultReg = ($signed(_zz__zz_bench_N1_resultReg) + $signed(32'hffffff80));
  assign when_QLinearConvCore_l519 = (bench_N1_stateReg == bench_N1_sEmit);
  assign bench_N1_activationOut_fire = (bench_N1_activationOut_valid && bench_N1_activationOut_ready);
  assign when_QLinearConvCore_l529 = (bench_N1_outChReg == 6'h1f);
  assign when_QLinearConvCore_l531 = (bench_N1_outColReg == 4'b0111);
  assign _zz_bench_N1_stateReg = (bench_N1_outRowReg == 4'b0111);
  assign bench_N1_activationOut_ready = outReadyR;
  assign io_inReady = inStream_ready_regNext;
  assign io_outValid = bench_N1_activationOut_valid_regNext;
  assign io_outValue = bench_N1_activationOut_payload_value_regNext;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      inValidR <= 1'b0;
      inValueR <= 8'h0;
      outReadyR <= 1'b0;
      bench_N1_stateReg <= 4'b1010;
      bench_N1_recvCntReg <= 11'h0;
      bench_N1_padWriteAddrReg <= 11'h0b0;
      bench_N1_rowElemReg <= 8'h0;
      bench_N1_outRowReg <= 4'b0000;
      bench_N1_outColReg <= 4'b0000;
      bench_N1_outChReg <= 6'h0;
      bench_N1_accumReg <= 32'h0;
      bench_N1_prodReg <= 32'h0;
      bench_N1_resultReg <= 8'h0;
      bench_N1_reqProdReg2 <= 64'h0;
      bench_N1_accumRequantReg <= 32'h0;
      bench_N1_signAReg <= 1'b0;
      bench_N1_absAReg <= 32'h0;
      bench_N1_pLL_Reg <= 32'h0;
      bench_N1_pLH_Reg <= 32'h0;
      bench_N1_pHL_Reg <= 32'h0;
      bench_N1_pHH_Reg <= 32'h0;
      bench_N1_pSumReg <= 33'h0;
      bench_N1_pLL_Reg2 <= 32'h0;
      bench_N1_pHH_Reg2 <= 32'h0;
      bench_N1_part1Reg <= 64'h0;
      bench_N1_part2Reg <= 64'h0;
      bench_N1_initAddrReg <= 11'h0;
      bench_N1_inAddrReg <= 11'h0;
      bench_N1_wAddrReg <= 13'h0;
      bench_N1_compCycleReg <= 8'h0;
      bench_N1_rowStepReg <= 6'h0;
      bench_N1_inValsReg_0 <= 8'h0;
      bench_N1_wValsReg_0 <= 8'h0;
      inStream_ready_regNext <= 1'b0;
      bench_N1_activationOut_valid_regNext <= 1'b0;
      bench_N1_activationOut_payload_value_regNext <= 8'h0;
    end else begin
      inValidR <= io_inValid;
      inValueR <= io_inValue;
      outReadyR <= io_outReady;
      if(when_QLinearConvCore_l331) begin
        if(when_QLinearConvCore_l333) begin
          bench_N1_initAddrReg <= 11'h0;
          bench_N1_stateReg <= bench_N1_sReceive;
        end else begin
          bench_N1_initAddrReg <= (bench_N1_initAddrReg + 11'h001);
        end
      end
      if(when_QLinearConvCore_l347) begin
        if(inStream_fire) begin
          bench_N1_rowElemReg <= (_zz_bench_N1_padWriteAddrReg ? 8'h0 : _zz_bench_N1_rowElemReg);
          bench_N1_padWriteAddrReg <= (bench_N1_padWriteAddrReg + (_zz_bench_N1_padWriteAddrReg ? 11'h021 : 11'h001));
          bench_N1_recvCntReg <= (bench_N1_recvCntReg + 11'h001);
          if(when_QLinearConvCore_l357) begin
            bench_N1_recvCntReg <= 11'h0;
            bench_N1_rowElemReg <= 8'h0;
            bench_N1_padWriteAddrReg <= 11'h0b0;
            bench_N1_outRowReg <= 4'b0000;
            bench_N1_outColReg <= 4'b0000;
            bench_N1_outChReg <= 6'h0;
            bench_N1_stateReg <= bench_N1_sLoadBias;
          end
        end
      end
      if(when_QLinearConvCore_l390) begin
        bench_N1_inAddrReg <= _zz_bench_N1_inAddrReg_1[10:0];
        bench_N1_wAddrReg <= _zz_bench_N1_wAddrReg[12:0];
        bench_N1_compCycleReg <= 8'h0;
        bench_N1_rowStepReg <= 6'h0;
        bench_N1_stateReg <= bench_N1_sWaitBias;
      end
      if(when_QLinearConvCore_l404) begin
        bench_N1_accumReg <= bench_N1_biasVal;
        bench_N1_stateReg <= bench_N1_sCompute;
      end
      if(when_QLinearConvCore_l412) begin
        bench_N1_compCycleReg <= (bench_N1_compCycleReg + 8'h01);
        if(when_QLinearConvCore_l416) begin
          bench_N1_wAddrReg <= (bench_N1_wAddrReg + 13'h0001);
          bench_N1_inAddrReg <= (bench_N1_inAddrReg + (_zz_bench_N1_inAddrReg ? 11'h071 : 11'h001));
          bench_N1_rowStepReg <= (_zz_bench_N1_inAddrReg ? 6'h0 : _zz_bench_N1_rowStepReg);
        end
        if(when_QLinearConvCore_l429) begin
          bench_N1_inValsReg_0 <= bench_N1_inValsR_0;
          bench_N1_wValsReg_0 <= bench_N1_wValsR_0;
        end
        if(when_QLinearConvCore_l437) begin
          bench_N1_prodReg <= {{14{_zz_bench_N1_prodReg[17]}}, _zz_bench_N1_prodReg};
        end
        if(when_QLinearConvCore_l448) begin
          bench_N1_accumReg <= _zz_bench_N1_accumReg;
          if(when_QLinearConvCore_l452) begin
            bench_N1_accumRequantReg <= _zz_bench_N1_accumReg;
            bench_N1_stateReg <= bench_N1_sRequant;
            bench_N1_compCycleReg <= 8'h0;
          end
        end
      end
      if(when_QLinearConvCore_l461) begin
        bench_N1_absAReg <= _zz_bench_N1_absAReg;
        bench_N1_signAReg <= ($signed(bench_N1_accumRequantReg) < $signed(32'h0));
        bench_N1_stateReg <= bench_N1_sRequantMul;
      end
      if(when_QLinearConvCore_l468) begin
        bench_N1_pLL_Reg <= (_zz_bench_N1_pLL_Reg * _zz_bench_N1_pLL_Reg_1);
        bench_N1_pLH_Reg <= (_zz_bench_N1_pLL_Reg * _zz_bench_N1_pLH_Reg);
        bench_N1_pHL_Reg <= (_zz_bench_N1_pHL_Reg * _zz_bench_N1_pLL_Reg_1);
        bench_N1_pHH_Reg <= (_zz_bench_N1_pHL_Reg * _zz_bench_N1_pLH_Reg);
        bench_N1_stateReg <= bench_N1_sRequantWait;
      end
      if(when_QLinearConvCore_l485) begin
        bench_N1_pSumReg <= (_zz_bench_N1_pSumReg + _zz_bench_N1_pSumReg_1);
        bench_N1_pLL_Reg2 <= bench_N1_pLL_Reg;
        bench_N1_pHH_Reg2 <= bench_N1_pHH_Reg;
        bench_N1_stateReg <= bench_N1_sRequantWait2;
      end
      if(when_QLinearConvCore_l493) begin
        bench_N1_part1Reg <= (_zz_bench_N1_part1Reg + _zz_bench_N1_part1Reg_1);
        bench_N1_part2Reg <= _zz_bench_N1_part2Reg[63:0];
        bench_N1_stateReg <= bench_N1_sRequantWait3;
      end
      if(when_QLinearConvCore_l500) begin
        bench_N1_reqProdReg2 <= (bench_N1_signAReg ? _zz_bench_N1_reqProdReg2_1 : _zz_bench_N1_reqProdReg2_3);
        bench_N1_stateReg <= bench_N1_sRequantShift;
      end
      if(when_QLinearConvCore_l508) begin
        bench_N1_resultReg <= (($signed(32'h0000007f) < $signed(_zz_bench_N1_resultReg)) ? 8'h7f : _zz_bench_N1_resultReg_1);
        bench_N1_stateReg <= bench_N1_sEmit;
      end
      if(when_QLinearConvCore_l519) begin
        if(bench_N1_activationOut_fire) begin
          bench_N1_outChReg <= (when_QLinearConvCore_l529 ? 6'h0 : _zz_bench_N1_outChReg);
          if(when_QLinearConvCore_l529) begin
            bench_N1_outColReg <= (when_QLinearConvCore_l531 ? 4'b0000 : _zz_bench_N1_outColReg);
            if(when_QLinearConvCore_l531) begin
              bench_N1_outRowReg <= (_zz_bench_N1_stateReg ? 4'b0000 : _zz_bench_N1_outRowReg);
            end
          end
          bench_N1_stateReg <= (((when_QLinearConvCore_l529 && when_QLinearConvCore_l531) && _zz_bench_N1_stateReg) ? bench_N1_sReceive : bench_N1_sLoadBias);
        end
      end
      inStream_ready_regNext <= inStream_ready;
      bench_N1_activationOut_valid_regNext <= bench_N1_activationOut_valid;
      bench_N1_activationOut_payload_value_regNext <= bench_N1_activationOut_payload_value;
    end
  end


endmodule
