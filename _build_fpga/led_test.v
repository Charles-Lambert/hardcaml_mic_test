module led_counter (
    clock,
    pdm_dat,
    leds,
    pdm_clk
);

    input clock;
    input pdm_dat;
    output [5:0] leds;
    output pdm_clk;

    wire [3:0] _11;
    wire _12;
    wire [31:0] _46;
    wire [15:0] _56;
    wire vdd;
    wire [3:0] _20;
    wire [3:0] _9;
    wire [3:0] _15;
    wire [3:0] _16;
    wire [3:0] _13;
    wire _14;
    wire [3:0] _18;
    wire [3:0] _2;
    reg [3:0] _10;
    wire _21;
    wire _23;
    wire gnd;
    wire [27:0] _43;
    wire [5:0] _36;
    wire [1:0] _28;
    wire [1:0] _26;
    wire [1:0] _27;
    wire [1:0] _29;
    wire [7:0] _25;
    wire [9:0] _30;
    wire _31;
    wire [1:0] _32;
    wire [3:0] _33;
    wire [7:0] _34;
    wire [15:0] _35;
    wire [21:0] _37;
    wire [31:0] _38;
    wire [31:0] _39;
    wire _40;
    wire [1:0] _41;
    wire [3:0] _42;
    wire [31:0] _44;
    wire [31:0] _45;
    wire [31:0] _5;
    reg [31:0] _24;
    wire [63:0] _48;
    wire [31:0] _49;
    wire [31:0] _50;
    wire _51;
    wire [1:0] _52;
    wire [3:0] _53;
    wire [7:0] _54;
    wire [15:0] _55;
    wire [31:0] _57;
    wire [31:0] _58;
    wire [31:0] _6;
    reg [31:0] _47;
    wire [5:0] _59;
    wire [5:0] _60;
    assign _11 = 4'b0100;
    assign _12 = _10 < _11;
    assign _46 = 32'b00000000000000000000000000000000;
    assign _56 = _50[31:16];
    assign vdd = 1'b1;
    assign _20 = 4'b0010;
    assign _9 = 4'b0000;
    assign _15 = 4'b0001;
    assign _16 = _10 + _15;
    assign _13 = 4'b1000;
    assign _14 = _10 == _13;
    assign _18 = _14 ? _9 : _16;
    assign _2 = _18;
    always @(posedge clock) begin
        if (gnd)
            _10 <= _9;
        else
            _10 <= _2;
    end
    assign _21 = _10 == _20;
    assign _23 = _21 ? gnd : vdd;
    assign gnd = 1'b0;
    assign _43 = _39[31:4];
    assign _36 = { _33,
                   _32 };
    assign _28 = 2'b01;
    assign _26 = { pdm_dat,
                   pdm_dat };
    assign _27 = _26 + _26;
    assign _29 = _27 - _28;
    assign _25 = 8'b01000000;
    assign _30 = $signed(_25) * $signed(_29);
    assign _31 = _30[9:9];
    assign _32 = { _31,
                   _31 };
    assign _33 = { _32,
                   _32 };
    assign _34 = { _33,
                   _33 };
    assign _35 = { _34,
                   _34 };
    assign _37 = { _35,
                   _36 };
    assign _38 = { _37,
                   _30 };
    assign _39 = _38 - _24;
    assign _40 = _39[31:31];
    assign _41 = { _40,
                   _40 };
    assign _42 = { _41,
                   _41 };
    assign _44 = { _42,
                   _43 };
    assign _45 = _24 + _44;
    assign _5 = _45;
    always @(posedge clock) begin
        if (gnd)
            _24 <= _46;
        else
            if (_23)
                _24 <= _5;
    end
    assign _48 = $signed(_24) * $signed(_24);
    assign _49 = _48[31:0];
    assign _50 = _49 - _47;
    assign _51 = _50[31:31];
    assign _52 = { _51,
                   _51 };
    assign _53 = { _52,
                   _52 };
    assign _54 = { _53,
                   _53 };
    assign _55 = { _54,
                   _54 };
    assign _57 = { _55,
                   _56 };
    assign _58 = _47 + _57;
    assign _6 = _58;
    always @(posedge clock) begin
        if (gnd)
            _47 <= _46;
        else
            if (_23)
                _47 <= _6;
    end
    assign _59 = _47[5:0];
    assign _60 = ~ _59;
    assign leds = _60;
    assign pdm_clk = _12;

endmodule
