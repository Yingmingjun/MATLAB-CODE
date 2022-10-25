function test_persistent(~)

persistent a

for i=1:10
    a=a+1;
end
a