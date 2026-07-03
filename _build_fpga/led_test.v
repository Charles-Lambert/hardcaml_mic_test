module led_counter (
    clock,
    leds
);

    input clock;
    output [5:0] leds;

    wire vdd;
    wire [23:0] _15;
    wire [23:0] _10;
    wire [23:0] _11;
    wire [23:0] _8;
    wire _9;
    wire [23:0] _13;
    wire [23:0] _1;
    reg [23:0] _7;
    wire _16;
    wire _17;
    wire _19;
    wire [5:0] _14;
    wire gnd;
    wire [5:0] _21;
    wire [5:0] _22;
    wire [5:0] _3;
    reg [5:0] _20;
    wire [5:0] _23;
    assign vdd = 1'b1;
    assign _15 = 24'b000000000000000000000000;
    assign _10 = 24'b000000000000000000000001;
    assign _11 = _7 + _10;
    assign _8 = 24'b110011011111111001011111;
    assign _9 = _7 == _8;
    assign _13 = _9 ? _15 : _11;
    assign _1 = _13;
    always @(posedge clock) begin
        if (gnd)
            _7 <= _15;
        else
            _7 <= _1;
    end
    assign _16 = _7 == _15;
    assign _17 = ~ _16;
    assign _19 = _17 ? gnd : vdd;
    assign _14 = 6'b000000;
    assign gnd = 1'b0;
    assign _21 = 6'b000001;
    assign _22 = _20 + _21;
    assign _3 = _22;
    always @(posedge clock) begin
        if (gnd)
            _20 <= _14;
        else
            if (_19)
                _20 <= _3;
    end
    assign _23 = ~ _20;
    assign leds = _23;

endmodule
