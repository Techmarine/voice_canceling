function output = BandstopFilter(s,fs,Fst1,Fst2)
    %Filter design---------------------------------------------------------
    p = 0.1;
    df = Fst2 - Fst1;
    Fp1 = Fst1 - df/2*p;
    Fp2 = Fst2 + df/2*p;
    Ap1 = 60;
    Ast = 100;
    Ap2 = 60;
    d = fdesign.bandstop(Fp1,Fst1,Fst2,Fp2,Ap1,Ast,Ap2,fs);
    h = design(d,'butter');      
    %----------------------------------------------------------------------
    data_is_too_short = 3*h.order > length(s);
    delay = 3*h.order - length(s) + 1;
    if data_is_too_short
        s = [zeros(1,delay),s];
    end
    q = filtfilt(h.sosMatrix,h.ScaleValues,s);
    if data_is_too_short
        q = q((delay + 1):end);
    end
    output = q;
end