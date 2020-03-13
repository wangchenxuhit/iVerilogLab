module led4_pipe (
  reset_n,
  clock,
  diode
);

  input             reset_n;
  input             clock;
  output [3:0]      diode;

  reg    [3:0]      diode;

  always @( posedge clock or negedge reset_n ) begin
    if ( ~reset_n ) begin
      diode[3:0] <= 4'b0001;
    end
    else begin
      diode[0] <= diode[3];
      diode[1] <= diode[0];
      diode[2] <= diode[1];
      diode[3] <= diode[2];
    end
  end

endmodule

