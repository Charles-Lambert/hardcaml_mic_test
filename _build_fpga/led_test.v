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

    wire [3:0] _12;
    wire _13;
    wire [23:0] _79;
    wire [23:0] _14;
    wire [23:0] _19;
    wire [23:0] _16;
    wire _17;
    wire [23:0] _21;
    wire [23:0] _2;
    reg [23:0] _15;
    wire _80;
    wire _81;
    wire [5:0] _78;
    wire [14:0] _74;
    wire [31:0] _54;
    wire [14:0] _65;
    wire vdd;
    wire [3:0] _29;
    wire [3:0] _10;
    wire [3:0] _24;
    wire [3:0] _25;
    wire [3:0] _22;
    wire _23;
    wire [3:0] _27;
    wire [3:0] _3;
    reg [3:0] _11;
    wire _30;
    wire _32;
    wire gnd;
    wire [27:0] _51;
    wire [1:0] _37;
    wire [1:0] _35;
    wire [1:0] _36;
    wire [1:0] _38;
    wire [11:0] _34;
    wire [13:0] _39;
    wire _40;
    wire [1:0] _41;
    wire [3:0] _42;
    wire [7:0] _43;
    wire [15:0] _44;
    wire [17:0] _45;
    wire [31:0] _46;
    wire [31:0] _47;
    wire _48;
    wire [1:0] _49;
    wire [3:0] _50;
    wire [31:0] _52;
    wire [31:0] _53;
    wire [31:0] _6;
    reg [31:0] _33;
    wire [63:0] _56;
    wire [31:0] _57;
    wire [31:0] _58;
    wire _59;
    wire [1:0] _60;
    wire [3:0] _61;
    wire [7:0] _62;
    wire [15:0] _63;
    wire [16:0] _64;
    wire [31:0] _66;
    wire [31:0] _67;
    wire [31:0] _7;
    reg [31:0] _55;
    wire _68;
    wire [1:0] _69;
    wire [3:0] _70;
    wire [7:0] _71;
    wire [15:0] _72;
    wire [16:0] _73;
    wire [31:0] _75;
    wire [5:0] _76;
    wire [5:0] _77;
    reg [5:0] _82;
    assign _12 = 4'b0100;
    assign _13 = _11 < _12;
    assign _79 = 24'b000000000000000000000001;
    assign _14 = 24'b000000000000000000000000;
    assign _19 = _15 + _79;
    assign _16 = 24'b000101001001100101101111;
    assign _17 = _15 == _16;
    assign _21 = _17 ? _14 : _19;
    assign _2 = _21;
    always @(posedge clock) begin
        if (gnd)
            _15 <= _14;
        else
            _15 <= _2;
    end
    assign _80 = _15 == _79;
    assign _81 = _80 ? vdd : gnd;
    assign _78 = 6'b000000;
    assign _74 = _55[31:17];
    assign _54 = 32'b00000000000000000000000000000000;
    assign _65 = _58[31:17];
    assign vdd = 1'b1;
    assign _29 = 4'b0010;
    assign _10 = 4'b0000;
    assign _24 = 4'b0001;
    assign _25 = _11 + _24;
    assign _22 = 4'b1000;
    assign _23 = _11 == _22;
    assign _27 = _23 ? _10 : _25;
    assign _3 = _27;
    always @(posedge clock) begin
        if (gnd)
            _11 <= _10;
        else
            _11 <= _3;
    end
    assign _30 = _11 == _29;
    assign _32 = _30 ? gnd : vdd;
    assign gnd = 1'b0;
    assign _51 = _47[31:4];
    assign _37 = 2'b01;
    assign _35 = { pdm_dat,
                   pdm_dat };
    assign _36 = _35 + _35;
    assign _38 = _36 - _37;
    assign _34 = 12'b010000000000;
    assign _39 = $signed(_34) * $signed(_38);
    assign _40 = _39[13:13];
    assign _41 = { _40,
                   _40 };
    assign _42 = { _41,
                   _41 };
    assign _43 = { _42,
                   _42 };
    assign _44 = { _43,
                   _43 };
    assign _45 = { _44,
                   _41 };
    assign _46 = { _45,
                   _39 };
    assign _47 = _46 - _33;
    assign _48 = _47[31:31];
    assign _49 = { _48,
                   _48 };
    assign _50 = { _49,
                   _49 };
    assign _52 = { _50,
                   _51 };
    assign _53 = _33 + _52;
    assign _6 = _53;
    always @(posedge clock) begin
        if (gnd)
            _33 <= _54;
        else
            if (_32)
                _33 <= _6;
    end
    assign _56 = $signed(_33) * $signed(_33);
    assign _57 = _56[31:0];
    assign _58 = _57 - _55;
    assign _59 = _58[31:31];
    assign _60 = { _59,
                   _59 };
    assign _61 = { _60,
                   _60 };
    assign _62 = { _61,
                   _61 };
    assign _63 = { _62,
                   _62 };
    assign _64 = { _63,
                   _59 };
    assign _66 = { _64,
                   _65 };
    assign _67 = _55 + _66;
    assign _7 = _67;
    always @(posedge clock) begin
        if (gnd)
            _55 <= _54;
        else
            if (_32)
                _55 <= _7;
    end
    assign _68 = _55[31:31];
    assign _69 = { _68,
                   _68 };
    assign _70 = { _69,
                   _69 };
    assign _71 = { _70,
                   _70 };
    assign _72 = { _71,
                   _71 };
    assign _73 = { _72,
                   _68 };
    assign _75 = { _73,
                   _74 };
    assign _76 = _75[5:0];
    assign _77 = ~ _76;
    always @(posedge clock) begin
        if (gnd)
            _82 <= _78;
        else
            if (_81)
                _82 <= _77;
    end
    assign leds = _82;
    assign pdm_clk = _13;

endmodule
