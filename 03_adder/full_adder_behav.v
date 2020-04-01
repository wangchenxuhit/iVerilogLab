module full_adder_behav (
  a,
  b,
  cin,
  sum,
  cout
);

  input   a;
  input   b;
  input   cin;
  output  sum;
  output  cout;

  wire    sum;
  wire    cout;

  assign { cout, sum } = a + b + cin;

endmodule

