
//Código para executar simulação do XCOS em modo batch, alterando os 
//parâmetros de entrada para cada simulação.

//Limpa a tela e variáveis
clc
clear()
close()

// Abre os blocos de biblioteca.
loadXcosLibs(); loadScicos();

//Abre o arquivo do XCOS a ser simulado.
//Altere o nome do arquivo.
importXcosDiagram('simulacao_2_graus.zcos')

// Define o ambiente: quatro variáveis:
//  y1   : amplitude da excitação
//  f1   : frequência da excitação
//  zeta : fator de amortecimento
//  Tf   : tempo total de simulação
typeof(scs_m) // estrutura de dados
scs_m.props.context; // definições
T = [5,7,9]
lc = 100:75:3000;
// Atribua as constantes ao contexto
//Context.Tf=500;

// Loop de T
for m = 1:size(T,2);
    
    // Loop de lc
    for n = 1:size(lc,2);
        
        // Atribui as variáveis ao contexto
        Context.fw = 1/T(m);
        Context.lc = lc(n);
                
        // Executa a simulação com o contexto
        scicos_simulate(scs_m,Context);

        // Recebe as variáveis de resposta enviadas ao "workspace"
        //t(:,n) = x_t.time; 
        //x(:,n) = x_t.values;
        //y(:,n) = y_t.values;
        //fc_t = Fc_t.values;
        //d_t = D_t.values
        
        // Calcula a amplitude da resposta a aprtir do RMS do sinal 
        // multiplicado por raiz de 2 (amplitude harmônica).
        X(m,n) = sqrt(2)*sqrt(sum(x_t.values.*conj(x_t.values))/size(x_t.values,1));
        Y(m,n) = sqrt(2)*sqrt(sum(y_t.values.*conj(y_t.values))/size(y_t.values,1));
        Fc(m,n) = sqrt(2)*sqrt(sum(Fc_t.values.*conj(Fc_t.values))/size(Fc_t.values,1));
        D(m,n) = sqrt(2)*sqrt(sum(D_t.values.*conj(D_t.values))/size(D_t.values,1));
        Sc = Fc./(3.141590*0.04^2/4)
        AMP = X./Y
Se = 66934*lc + 4E+08
St = Sc+Se(:,1)

    end
end

// Calcula o fator de amplificação

// fecha as janelas abertas

// Plota as curvas de AMP em função de lc para cada T.
figure
figure
plot(lc,X,'o-')
xlabel '$l_c \rm{(m)}$' fontsize 4
ylabel ('$X$','fontsize',4)
leg=legend(['$T=5\rm{s}$';'$T=7\rm{s}$';'$T=9\rm{s}$'],'fontsize',5,'pos','in_upper_right');
leg.background = 8;

fig = gcf();
fig.background = 8;

figure
plot(lc,Y,'o-')
xlabel '$l_c \rm{(m)}$' fontsize 4
ylabel ('$Y$','fontsize',4)
leg=legend(['$T=5\rm{s}$';'$T=7\rm{s}$';'$T=9\rm{s}$'],'fontsize',5,'pos','in_upper_left');
leg.background = 8;

fig = gcf();
fig.background = 8;

figure
plot(lc,AMP,'o-')
xlabel '$l_c \rm{(m)}$' fontsize 4
ylabel ('$X/Y$','fontsize',4)
leg=legend(['$T=5\rm{s}$';'$T=7\rm{s}$';'$T=9\rm{s}$'],'fontsize',5,'pos','in_lower_left');
leg.background = 8;

fig = gcf();
fig.background = 8;
figure
plot(lc,Fc,'o-')
xlabel '$l_c \rm{(m)}$' fontsize 4
ylabel ('$Fc$','fontsize',4)
leg=legend(['$T=5\rm{s}$';'$T=7\rm{s}$';'$T=9\rm{s}$'],'fontsize',5,'pos','in_lower_left');
leg.background = 8;

fig = gcf();
fig.background = 8;
figure
plot(lc,Sc,'o-')
xlabel '$l_c \rm{(m)}$' fontsize 4
ylabel ('$Sc$','fontsize',4)
leg=legend(['$T=5\rm{s}$';'$T=7\rm{s}$';'$T=9\rm{s}$'],'fontsize',5,'pos','in_upper_right');
leg.background = 8;

fig = gcf();
fig.background = 8;

figure
plot(lc,D,'o-')
xlabel '$l_c \rm{(m)}$' fontsize 4
ylabel ('$D$','fontsize',4)
leg=legend(['$T=5\rm{s}$';'$T=7\rm{s}$';'$T=9\rm{s}$'],'fontsize',5,'pos','in_upper_right');
leg.background = 8;

fig = gcf();
fig.background = 8;

figure
plot(lc,St,'o-')
xlabel '$l_c \rm{(m)}$' fontsize 4
ylabel ('$St$','fontsize',4)
leg=legend(['$T=5\rm{s}$';'$T=7\rm{s}$';'$T=9\rm{s}$'],'fontsize',5,'pos','in_upper_right');
leg.background = 8;

fig = gcf();
fig.background = 8;
