module half_adder (
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

  xor u1(sum,a,b);
  and u2(cout,a,b);

endmodule
