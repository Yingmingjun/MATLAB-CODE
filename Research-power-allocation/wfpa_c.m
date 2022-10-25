function popt=wfpa_c(c,P)

Nf=length(c);
w=fzero(@(w) findw_c(w,c,P),P/2);

for f=1:Nf
    popt(f)=max(0,w-c(f));
end

end