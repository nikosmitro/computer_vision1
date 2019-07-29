function y = com(S,x1,y1,x2,y2)
y = S(x2,y2)+S(x1-1,y1-1)-S(x1-1,y2)-S(x2,y1-1);
end