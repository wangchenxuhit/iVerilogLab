//
// 3-paragraph method to describe FSM 
// Describe sequential state transition in the 1st sequential always block 
// Describe state transition conditions in the 2nd combinational always block 
// Describe the state out in the 3rd SEQUENTIAL always block 
//
module sm_para_3 ( 
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
  
  reg    [2:0]   cs; // current_state
  reg    [2:0]   ns; // next state
  parameter [2:0]    // one hot with zero idle 
        IDLE   = 3'b000, 
        S1     = 3'b001, 
        S2     = 3'b010, 
        ERROR  = 3'b100; 
  
  //
  // 1st always block, sequential state transition 
  //
  always @( posedge clk or negedge nrst ) begin
    if ( !nrst ) begin             
      cs <= IDLE;         
    end                   
    else begin                  
      cs <= ns;            
    end                   
  end
  
  //
  // 2nd always block, combinational state output
  //
  always @( cs or i1 or i2 ) begin
    ns = IDLE; 
    case ( cs ) 
      IDLE : begin 
        if ( ~i1 ) begin 
          ns  = IDLE; 
        end 
        if ( i1 && i2 ) begin
          ns  = S1; 
        end 
        if ( i1 && ~i2 ) begin
          ns  = ERROR; 
        end 
      end 
      S1 : begin 
        if ( ~i2 ) begin
          ns  = S1; 
        end 
        if ( i2 && i1 ) begin
          ns  = S2; 
        end 
        if ( i2 && ( ~i1 ) ) begin
          ns  = ERROR; 
        end 
      end 
      S2 : begin 
        if ( i2 ) begin
          ns  = S2; 
        end 
        if ( ~i2 && i1 ) begin
          ns  = IDLE; 
        end 
        if ( ~i2 && ( ~i1 ) ) begin
          ns  = ERROR; 
        end 
      end 
      ERROR : begin 
        if ( i1 ) begin
          ns  = ERROR; 
        end 
        if ( ~i1 ) begin
          ns  = IDLE; 
        end 
      end 
    endcase 
  end
  
  //
  // 3rd always block, the sequential state/FSM output 
  //
  always @( posedge clk or negedge nrst ) begin 
    if ( !nrst ) begin 
      {o1,o2,err} <= 3'b000; 
    end
    else begin 
      case ( ns ) 
        IDLE : {o1,o2,err} <= 3'b000; 
        S1   : {o1,o2,err} <= 3'b100; 
        S2   : {o1,o2,err} <= 3'b010; 
        ERROR: {o1,o2,err} <= 3'b111; 
      endcase 
    end 
  end
  
endmodule

