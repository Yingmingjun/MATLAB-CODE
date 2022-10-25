Score = xlsread('test1.xlsx');
M = mean(Score')';
S = std(Score')';


xlswrite('test1.xlsx',{'Mean'},1,'E1');
xlswrite('test1.xlsx',{'Stan D'},1,'F1');
xlswrite('test1.xlsx',M,1,'E2:E4');
xlswrite('test1.xlsx',S,1,'F2:F4');


















