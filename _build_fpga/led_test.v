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
    wire [18:0] _64;
    wire [4:0] _62;
    wire [31:0] _45;
    wire [15:0] _55;
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
    wire [27:0] _42;
    wire [1:0] _28;
    wire [1:0] _26;
    wire [1:0] _27;
    wire [1:0] _29;
    wire [11:0] _25;
    wire [13:0] _30;
    wire _31;
    wire [1:0] _32;
    wire [3:0] _33;
    wire [7:0] _34;
    wire [15:0] _35;
    wire [17:0] _36;
    wire [31:0] _37;
    wire [31:0] _38;
    wire _39;
    wire [1:0] _40;
    wire [3:0] _41;
    wire [31:0] _43;
    wire [31:0] _44;
    wire [31:0] _5;
    reg [31:0] _24;
    wire [63:0] _47;
    wire [31:0] _48;
    wire [31:0] _49;
    wire _50;
    wire [1:0] _51;
    wire [3:0] _52;
    wire [7:0] _53;
    wire [15:0] _54;
    wire [31:0] _56;
    wire [31:0] _57;
    wire [31:0] _6;
    reg [31:0] _46;
    wire _58;
    wire [1:0] _59;
    wire [3:0] _60;
    wire [7:0] _61;
    wire [12:0] _63;
    wire [31:0] _65;
    wire [5:0] _66;
    wire [5:0] _67;
    assign _11 = 4'b0100;
    assign _12 = _10 < _11;
    assign _64 = _46[31:13];
    assign _62 = { _60,
                   _58 };
    assign _45 = 32'b00000000000000000000000000000000;
    assign _55 = _49[31:16];
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
    assign _42 = _38[31:4];
    assign _28 = 2'b01;
    assign _26 = { pdm_dat,
                   pdm_dat };
    assign _27 = _26 + _26;
    assign _29 = _27 - _28;
    assign _25 = 12'b010000000000;
    assign _30 = $signed(_25) * $signed(_29);
    assign _31 = _30[13:13];
    assign _32 = { _31,
                   _31 };
    assign _33 = { _32,
                   _32 };
    assign _34 = { _33,
                   _33 };
    assign _35 = { _34,
                   _34 };
    assign _36 = { _35,
                   _32 };
    assign _37 = { _36,
                   _30 };
    assign _38 = _37 - _24;
    assign _39 = _38[31:31];
    assign _40 = { _39,
                   _39 };
    assign _41 = { _40,
                   _40 };
    assign _43 = { _41,
                   _42 };
    assign _44 = _24 + _43;
    assign _5 = _44;
    always @(posedge clock) begin
        if (gnd)
            _24 <= _45;
        else
            if (_23)
                _24 <= _5;
    end
    assign _47 = $signed(_24) * $signed(_24);
    assign _48 = _47[31:0];
    assign _49 = _48 - _46;
    assign _50 = _49[31:31];
    assign _51 = { _50,
                   _50 };
    assign _52 = { _51,
                   _51 };
    assign _53 = { _52,
                   _52 };
    assign _54 = { _53,
                   _53 };
    assign _56 = { _54,
                   _55 };
    assign _57 = _46 + _56;
    assign _6 = _57;
    always @(posedge clock) begin
        if (gnd)
            _46 <= _45;
        else
            if (_23)
                _46 <= _6;
    end
    assign _58 = _46[31:31];
    assign _59 = { _58,
                   _58 };
    assign _60 = { _59,
                   _59 };
    assign _61 = { _60,
                   _60 };
    assign _63 = { _61,
                   _62 };
    assign _65 = { _63,
                   _64 };
    assign _66 = _65[5:0];
    assign _67 = ~ _66;
    assign leds = _67;
    assign pdm_clk = _12;

endmodule
