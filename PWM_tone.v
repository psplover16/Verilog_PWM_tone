module PWM_tone (
    input clk,
    input [2:0] mode, // 標準do/re/mi
    input [1:0] HL, // 高低音(升高或降低頻率)
    input restartBtn,
    output reg redC
);

reg [14:0] freq; // 要發出哪個聲音

// 標準
parameter do= 15267; // 262
parameter re= 13605; // 294
parameter mi= 12121; // 330
parameter fa= 11461; // 349
parameter so= 10230; // 391
parameter la= 9090; // 440
parameter si= 8097; // 494

parameter noVoice = 401; // 沒聲音,直接強制指定頻率



always @(posedge clk)begin
    if (freq==0) begin
        if(mode == 3'b000)begin
            freq = noVoice; // 0
        end else begin
            case(mode)
                3'b001: freq = do; // 1
                3'b010: freq = re; // 2
                3'b011: freq = mi; // 3
                3'b100: freq = fa; // 4
                3'b101: freq = so; // 5
                3'b110: freq = la; // 6
                3'b111: freq = si; // 7
            endcase
            case (HL)
                // 3'b000: freq = freq; // 
                // 3'b001: freq = freq * 8; // 1
                // 3'b010: freq = freq * 4; // 2
                2'b00: freq = freq * 2; // 3
                2'b01: freq = freq; // 4
                2'b11: freq = freq / 2; // 5
                // 3'b110: freq = freq / 4; // 6
                // 3'b111: freq = freq / 8; // 7
            endcase
        end
    end
    freq = freq - 1;

    if(freq > (freq - 500))begin
        if(mode == 3'b000)begin
            redC = 0;
        end else begin
            redC = 1;
        end
    end
    else begin
        redC = 0;
    end
end


endmodule