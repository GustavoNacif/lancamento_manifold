
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
importXcosDiagram("simulacao_1_grau.zcos")

// Define o ambiente: quatro variáveis:
//  y1   : amplitude da excitação
//  f1   : frequência da excitação
//  zeta : fator de amortecimento
//  Tf   : tempo total de simulação
typeof(scs_m) // estrutura de dados
scs_m.props.context; // definições

// Defina o intervalo de T (período do movimento da base em s)
T = [5,7,9];

// Defina o valor de Y (amplitude do movimento da base em m)
Y = 1;

// Define o comprimento do cabo em m
lc = 100:100:3000;


// Loop de T
for m = 1:size(T,2);
    
    // Loop de lc
    for n = 1:size(lc,2);
        
        // Atribui as variáveis ao contexto
        Context.fw = 1./T(m);
        Context.lc = lc(n);
        
        // Executa a simulação com o contexto
        scicos_simulate(scs_m,Context);

        // Recebe as variáveis de resposta enviadas ao "workspace"
        t(:,n) = x_t.time; 
        x(:,n) = x_t.values;
        
        // Calcula a amplitude da resposta a aprtir do RMS do sinal 
        // multiplicado por raiz de 2 (amplitude harmônica).
        Ax(m,n) = sqrt(2)*sqrt(sum(x_t.values.*conj(x_t.values))/size(x_t.values,1));
        Ay(m,n) = sqrt(2)*sqrt(sum(y_t.values.*conj(y_t.values))/size(y_t.values,1));

    end
end

// Calcula o fator de amplificação
AMP = Ax./Ay;

// fecha as janelas abertas
close();

// Plota as curvas de AMP em função de lc para cada T.
figure
plot(lc,AMP,'o-')
xlabel '$l_c \rm{(m)}$' fontsize 4
ylabel ('$X/Y$','fontsize',4)
leg=legend(['$T=5\rm{s}$';'$T=7\rm{s}$';'$T=9\rm{s}$'],'fontsize',5,'pos','in_lower_left');
leg.background = 8;

fig = gcf();
fig.background = 8;
