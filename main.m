
clear all 
close all
clc

N=100; 
dim =30;
Function_name=6; % Name of the test function, range from 1-30
iter=500; 


[lb,ub,dim,fobj]=Get_Functions_cec2017(Function_name,dim);


DBO
[DE_fvalbest,DE_xposbest,DE_Curve] = DE(N,iter,lb,ub,dim,fobj);
display(['The best optimal value of the objective funciton found by DE  for ' [num2str(Function_name)],'  is : ', num2str(DE_fvalbest)]);

[APO_fvalbest,APO_xposbest,APO_Curve] = APO(N,iter,lb,ub,dim,fobj);
display(['The best optimal value of the objective funciton found by APO  for ' [num2str(Function_name)],'  is : ', num2str(APO_fvalbest)]);

[DBO_fvalbest,DBO_xposbest,DBO_Curve] = DBO(N,iter,lb,ub,dim,fobj);
display(['The best optimal value of the objective funciton found by DBO  for ' [num2str(Function_name)],'  is : ', num2str(DBO_fvalbest)]);

[BSLO_fvalbest,BSLO_xposbest,BSLO_Curve] =BSLO(N,iter,lb,ub,dim,fobj);
display(['The best optimal value of the objective funciton found by BSLO  for ' [num2str(Function_name)],'  is : ', num2str(BSLO_fvalbest)]);

[ISSA_fvalbest,ISSA_xposbest,ISSA_Curve] = ISSA(N,iter,lb,ub,dim,fobj);
display(['The best optimal value of the objective funciton found by ISSA  for ' [num2str(Function_name)],'  is : ', num2str(ISSA_fvalbest)]);

[QHDBO_fvalbest,QHDBO_xposbest,QHDBO_Curve] =QHDBO(N,iter,lb,ub,dim,fobj);
display(['The best optimal value of the objective funciton found by QHDBO  for ' [num2str(Function_name)],'  is : ', num2str(QHDBO_fvalbest)]);

[SSASC_fvalbest,SSASC_xposbest,SSASC_Curve] =SSASC(N,iter,lb,ub,dim,fobj);
display(['The best optimal value of the objective funciton found by SSASC  for ' [num2str(Function_name)],'  is : ', num2str(SSASC_fvalbest)]);


[SSA_fvalbest,SSA_xposbest,SSA_Curve] = SSA(N,iter,lb,ub,dim,fobj);
display(['The best optimal value of the objective funciton found by SSA  for ' [num2str(Function_name)],'  is : ', num2str(SSA_fvalbest)]);

[HyperSSA_fvalbest,HyperSSA_xposbest,HyperSSA_Curve] = HyperSSA(N,iter,lb,ub,dim,fobj);
display(['The best optimal value of the objective funciton found by HyperSSA  for ' [num2str(Function_name)],'  is : ', num2str(HyperSSA_fvalbest)]);


% Figure
figure(1)

CNT=35;
k=round(linspace(1,iter,CNT)); 

iter=1:1:iter;

semilogy(iter(k),DE_Curve(k),'color',[0.65,0.65,0.65],'marker','+','linewidth',1);
hold on

semilogy(iter(k),APO_Curve(k),'color',[0.4,0.4,0.6],'marker','d','linewidth',1);
hold on

semilogy(iter(k),BSLO_Curve(k),'color',[0.10,0.81,0.17],'marker','d','linewidth',1);
hold on

semilogy(iter(k),DBO_Curve(k),'color',[0.2,0.7,0.3],'marker','s','linewidth',1);
hold on

semilogy(iter(k),QHDBO_Curve(k),'color',[0.1,0.5,0.4],'marker','s','linewidth',1);
hold on

semilogy(iter(k),SSA_Curve(k),'color',[0.5,0.2,0.8],'marker','o','linewidth',1);
hold on

semilogy(iter(k),ISSA_Curve(k),'color',[0.3,0.3,0.8],'marker','o','linewidth',1);
hold on

semilogy(iter(k),SSASC_Curve(k),'color',[0.3,0.6,0.8],'marker','o','linewidth',1);
hold on

semilogy(iter(k),HyperSSA_Curve(k),'color',[0.90,0.21,0.27],'marker','p','linewidth',1);
grid on;


title('Convergence curve')
xlabel('Iterations');
ylabel('Fitness value');
box on
legend('DE','DBO','QHDBO','APO','BSLO','SSA','ISSA','SSASC','HyperSSA')
set (gcf,'position', [300,300,800,320])
