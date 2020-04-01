module half_adder_behav (
  a,
  b,
  sum,
  cout
);
  input   a;
  input   b;
  output  sum;
  output  cout;

  wire    sum;
  wire    cout;
  assign { cout, sum } = a + b;

  /*
  //
  // the second description method
  //
  wire    sum;
  wire    cout;
  assign  sum  = a ^ b;
  assign  cout = a & b;
  */

endmodule
