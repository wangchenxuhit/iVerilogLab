//
// 2-paragraph method to describe FSM 
//
//(1) Describe sequential state transition in 1 sequential always block 
//(2) State transition conditions & state output in the other combinational 
//    always block 
module sm_para_2_task ( 
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
  // sequential state transition 
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
  // Use output task to package state output
  //
  task IDLE_out; 
    {o1,o2,err} = 3'b000; 
  endtask 
  
  task S1_out; 
    {o1,o2,err} = 3'b100; 
  endtask 
  
  task S2_out; 
    {o1,o2,err} = 3'b010; 
  endtask 
  
  task ERROR_out; 
    {o1,o2,err} = 3'b111; 
  endtask 
  
  //
  // combinational state transition condition judgment & state output
  //
  always @( cs or i1 or i2 ) begin
    ns = IDLE; 
    IDLE_out; 
    case ( cs ) 
      IDLE : begin 
        IDLE_out; 
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
        S1_out; 
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
        S2_out; 
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
        ERROR_out; 
        if ( i1 ) begin
          ns  = ERROR; 
        end 
        if ( ~i1 ) begin
          ns  = IDLE; 
        end 
      end 
    endcase 
  end
  
endmodule

