data = xlsread('delay.xlsx'); 
 
 for n = 1:size(data,1)
     
     disp(sprintf('Subject %d', n))
     
     A = 20;
     D = [0 2 30 180 365];
     V = data(n,2:6);
     [ktmp, results, gof] = fitcurve(D, V, 'hyper', A, 1);
     kh1(n,1) = ktmp;
     rh1(n,1) = gof.rsquare;
     [ktmp, results, gof] = fitcurve(D, V, 'exp', A, 1);
     ke1(n,1) = ktmp;
     re1(n,1) = gof.rsquare;
     
     A = 100;
     D = [25 50 75 90 100];
     V = data(n,[11:-1:7]);
     [ktmp, results, gof] = fitcurve(D, V, 'hyper', A, 1);
     kh2(n,1) = ktmp;
     rh2(n,1) = gof.rsquare;
     [ktmp, results, gof] = fitcurve(D, V, 'exp', A, 1);
     ke2(n,1) = ktmp;
     re2(n,1) = gof.rsquare;
    
 end
 
data = [data kh1 rh1 ke1 re1 kh2 rh2 ke2 re2];
 
csvwrite('data_fit.csv',data);