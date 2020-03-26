//
// 1-paragraph method to describe FSM 
//
// Describe state transition, state output, state transition condition 
// in 1 always block 
//
module sm_para_1 ( 
  nrst,
  clk, 
  i1,
  i2, 
  o1,
  o2, 
  err 
); 
              
  input          nrst;
  input          clk; 
  input          i1; 
  input          i2; 
  output         o1; 
  output         o2; 
  output         err; 
  
  reg            o1;
  reg            o2;
  reg            err; 
  
  reg    [2:0]   cs;   // current state 
  parameter [2:0]      // one hot with zero idle 
        IDLE   = 3'b000, 
        S1     = 3'b001, 
        S2     = 3'b010, 
        ERROR  = 3'b100; 
   
  //
  // 1 always block to describe state transition, state output and 
  // state transiton condition      
  //
  always @( posedge clk or negedge nrst ) begin
    if ( !nrst ) begin 
      cs           <= IDLE; 
      {o1,o2,err}  <= 3'b000; 
    end 
    else begin 
      case ( cs ) 
        IDLE : begin 
          if ( ~i1 ) begin 
            {o1,o2,err} <= 3'b000; 
            cs  <= IDLE; 
          end 
          if ( i1 && i2 ) begin
            {o1,o2,err} <= 3'b100; 
            cs  <= S1; 
          end 
          if ( i1 && ~i2 ) begin
            {o1,o2,err} <= 3'b111; 
            cs  <= ERROR; 
          end 
        end 
        S1 : begin 
          if ( ~i2 ) begin
            {o1,o2,err} <= 3'b100; 
            cs  <= S1; 
          end 
          if ( i2 && i1 ) begin
            {o1,o2,err} <= 3'b010; 
            cs  <= S2; 
          end 
          if ( i2 && ( ~i1 ) ) begin
            {o1,o2,err} <= 3'b111; 
            cs  <= ERROR; 
          end 
        end 
        S2 : begin 
          if ( i2 ) begin
            {o1,o2,err} <= 3'b010; 
            cs  <= S2; 
          end 
          if ( ~i2 && i1 ) begin
            {o1,o2,err} <= 3'b000; 
            cs  <= IDLE; 
          end 
          if ( ~i2 && ( ~i1 ) ) begin
            {o1,o2,err} <= 3'b111; 
            cs  <= ERROR; 
          end 
        end 
        ERROR : begin 
          if ( i1 ) begin
            {o1,o2,err} <= 3'b111; 
            cs  <= ERROR; 
          end 
          if ( ~i1 ) begin
            {o1,o2,err} <= 3'b000; 
            cs  <= IDLE; 
          end 
        end 
      endcase 
    end    
  end

endmodule

