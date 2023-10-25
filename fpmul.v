module fpmul(
input clk,in_ready,
input [10:0] a,b,
output reg [10:0]product,
output reg done
);

reg sign_a,sign_b,sign_p;
reg [5:0] exp_a,exp_b,exp_p;
reg [3:0] man_a,man_b,man_p;
reg [5:0] temp_expa,temp_expb,temp_expp;
reg [4:0] temp_mana,temp_manb;
reg [9:0]temp_manp;

always@(posedge clk) begin
if(a==0||b==0)begin
product=0;
done=1'b1;
end
else begin
if(in_ready)begin
{sign_a,exp_a,man_a}<=a;
{sign_b,exp_b,man_b}<=b;
temp_mana={1'b1,man_a};
temp_manb={1'b1,man_b};
temp_expa=exp_a-6'd31;
temp_expb=exp_b-6'd31;

sign_p=sign_a^sign_b;
temp_expp = temp_expa+temp_expb;
temp_manp = temp_mana*temp_manb;
if(temp_manp[9]) begin
man_p=temp_manp[8:5];
exp_p=temp_expp+6'd32;
product={sign_p,exp_p,man_p};
done=1'b1;
end
else if(temp_manp[9]==0)begin
man_p=temp_manp[7:4];
exp_p=temp_expp+6'd31;
product={sign_p,exp_p,man_p};
done=1'b1;
end
end
end
end
endmodule
