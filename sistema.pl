% =========================
% Sistema de recomendação de trilhas em tecnologia
% =========================

:- module(sistema, [
  iniciar/0,
  testar/1,
  limpar_respostas/0,
  listar_trilhas/0
]).

:- dynamic resposta/2.

% ----------------------------------
% Trilhas e descrições
% Aqui definimos as trilhas disponíveis e suas descrições.
% ----------------------------------

trilha(inteligencia_artificial,
  'Modelagem e treinamento de modelos inteligentes (ML/IA), PNL e raciocínio automatizado.').

trilha(ciencia_de_dados,
  'Analise, interpretacao e comunicacao de dados; estatistica e machine learning aplicada.').

trilha(desenvolvimento_web,
  'Construcao de aplicacoes web (front-end e back-end), usabilidade e bancos de dados.').

trilha(seguranca_da_informacao,
  'Protecao de sistemas e dados: criptografia, auditoria, testes de intrusao e compliance.').

trilha(redes_e_infraestrutura,
  'Redes, sistemas operacionais, nuvem, DevOps e infraestrutura escalavel e confiavel.').

% ------------------------------------------------------------------------------------------
% Caracteristicas com pesos por trilha
% Aqui definimos as caracteristicas que serao avaliadas e seus pesos para cada trilha
% perfil(Trilha,caracteristica,Peso).
% ------------------------------------------------------------------------------------------

% Inteligencia Artificial
perfil(inteligencia_artificial, matematica_estatistica, 5).
perfil(inteligencia_artificial, programacao, 4).
perfil(inteligencia_artificial, logica, 4).
perfil(inteligencia_artificial, machine_learning, 5).
perfil(inteligencia_artificial, pln, 3).

% Ciencia de Dados
perfil(ciencia_de_dados, matematica_estatistica, 5).
perfil(ciencia_de_dados, banco_de_dados, 4).
perfil(ciencia_de_dados, programacao, 4).
perfil(ciencia_de_dados, machine_learning, 5).
perfil(ciencia_de_dados, analise_de_negocios, 3).
perfil(ciencia_de_dados, logica, 4).

% Desenvolvimento Web
perfil(desenvolvimento_web, programacao, 5).
perfil(desenvolvimento_web, front_end, 4).
perfil(desenvolvimento_web, back_end, 4).
perfil(desenvolvimento_web, banco_de_dados, 3).
perfil(desenvolvimento_web, usabilidade, 3).
perfil(desenvolvimento_web, design, 2).

% Seguranca da Informacao
perfil(seguranca_da_informacao, redes, 4).
perfil(seguranca_da_informacao, criptografia, 5).
perfil(seguranca_da_informacao, auditoria, 3).
perfil(seguranca_da_informacao, seguranca, 5).
perfil(seguranca_da_informacao, sistema_operacional, 3).
perfil(seguranca_da_informacao, devops, 2).

% Redes e Infraestrutura
perfil(redes_e_infraestrutura, redes, 5).
perfil(redes_e_infraestrutura, sistema_operacional, 4).
perfil(redes_e_infraestrutura, nuvem, 4).
perfil(redes_e_infraestrutura, devops, 4).
perfil(redes_e_infraestrutura, hardware, 3).

% -----------------------------------------
% Rotulo legível para cada caracteristica
% -----------------------------------------

caracteristica(matematica_estatistica, 'Matematica & Estatistica').
caracteristica(programacao,            'Programacao').
caracteristica(logica,                 'Logica').
caracteristica(machine_learning,       'Machine Learning').
caracteristica(pln,                    'Processamento de Linguagem Natural (PLN)').
caracteristica(analise_de_negocios,       'Analise de Negocios/Comunicacao de Dados').
caracteristica(banco_de_dados,            'Bancos de Dados').
caracteristica(front_end,              'Front-end').
caracteristica(back_end,                'Back-end').
caracteristica(usabilidade,            'Usabilidade/UX').
caracteristica(design,                 'Design Visual').
caracteristica(seguranca,              'Seguranca').
caracteristica(criptografia,           'Criptografia').
caracteristica(auditoria,              'Auditoria/Compliance').
caracteristica(redes,                  'Redes').
caracteristica(sistema_operacional,    'Sistemas Operacionais').
caracteristica(nuvem,                  'Computacao em Nuvem').
caracteristica(devops,                 'DevOps/CI-CD').
caracteristica(hardware,               'Hardware/Infraestrutura Fisica').

% -------------------------------------------------------------
% Perguntas (ID, Texto, Caracteristica)
% RESPONDER COM SIM/NAO
% Aqui definimos as perguntas que serao feitas ao usuario
% -------------------------------------------------------------

pergunta(1, 'Voce gosta de resolver problemas matematicos e estatisticos?', matematica_estatistica).
pergunta(2, 'Voce gosta de programar com frequencia?', programacao).
pergunta(3, 'Voce gosta de pensar e resolver problemas logicamente?', logica).
pergunta(4, 'Voce tem interesse em aprender sobre Machine Learning?', machine_learning).
pergunta(5, 'Voce tem interesse em Processamento de Linguagem Natural (PLN)?', pln).
pergunta(6, 'Voce gosta de analisar dados do negocio e comunicar insights?', analise_de_negocios).
pergunta(7, 'Voce gosta de modelar e consultar bancos de dados?', banco_de_dados).
pergunta(8, 'Voce gosta de desenvolver interfaces e experiencias para usuarios (front-end)?', front_end).
pergunta(9, 'Voce gosta de logica de negocio/servicos (back-end)?', back_end).
pergunta(10, 'Voce se preocupa com usabilidade/UX?', usabilidade).
pergunta(11, 'Voce tem interesse em design visual?', design).
pergunta(12, 'Voce tem interesse em seguranca de sistemas e dados?', seguranca).
pergunta(13, 'Voce tem interesse em criptografia?', criptografia).
pergunta(14, 'Voce tem interesse em auditoria e compliance?', auditoria).
pergunta(15, 'Voce gosta de trabalhar com redes de computadores?', redes).
pergunta(16, 'Voce gosta de trabalhar com sistemas operacionais (Linux/Windows Server)?', sistema_operacional).
pergunta(17, 'Voce tem interesse em computacao em nuvem? (AWS/Azure/GCP)', nuvem).
pergunta(18, 'Voce tem interesse em DevOps/CI-CD?', devops).
pergunta(19, 'Voce tem interesse em hardware e infraestrutura fisica?', hardware).

% -----------------------------------------
% Fluxo principal e questionario
% Aqui definimos o fluxo principal do sistema
% -----------------------------------------
iniciar :-
    limpar_respostas,
    banner,
    writeln('Responda s (sim) ou n (nao).'),
    fazer_perguntas,
    calcular_pontuacoes(Pares),              % [trilha(Pontuacao, Justificativa)...]
    ordenar_por_pontuacao(Pares, Ordenada),
    exibir_resultados(Ordenada).

listar_trilhas :-
    writeln('Trilhas disponiveis:'),
    forall(trilha(Nome, Descricao),
           (format('- ~w: ~w~n', [Nome, Descricao]))).

banner :-
    writeln('=============================================='),
    writeln('  Sistema de Recomendacao de Trilhas em Tech  '),
    writeln('==============================================').

fazer_perguntas :-
    forall(pergunta(Id, Texto, _Caracteristica),
           perguntar(Id, Texto, Resposta)),
    (var(Resposta) -> true ; true). % evita warning; fluxo eh do forall

perguntar(Id, Texto, RespostaFinal) :-
    format('(~d) ~w (s/n): ', [Id, Texto]),
    ler_resposta(Resposta),
    assertz(resposta(Id, Resposta)),
    RespostaFinal = Resposta.

ler_resposta(Resposta) :-
    read_line_to_string(user_input, (In)),
    string_lower(In, Lower),
    normaliza(Lower, RespostaNorm),
    ( RespostaNorm = s ; RespostaNorm = n ),
    !,
    Resposta = RespostaNorm.
ler_resposta(Resposta) :-
    writeln('Entrada invalida. Digite "s" ou "n".'),
    ler_resposta(Resposta).

normaliza(Str, s) :- member(Str, ["s","sim","y","yes"]).
normaliza(Str, n) :- member(Str, ["n","nao","não","no"]).
normaliza(Str, Str).

% -------------------------------------------------------------------------
% Calculo de pontuacoes e justificativas
% Aqui calculamos as pontuacoes para cada trilha com base nas respostas
% -------------------------------------------------------------------------

% retorna lista de pares: [trilha(Nome, Pontuacao, JustificativaOrdenada) ...]
calcular_pontuacoes(Resultado) :-
    findall(Nome, trilha(Nome, _), Trilhas),
    findall(trilha(Nome, Total, JustificativaOrdenada),
        ( member(Nome, Trilhas),
          pontuacao_trilha(Nome, trilha(Nome, Total, JustificativaOrdenada))
        ),
        Resultado).

pontuacao_trilha(Nome, trilha(Nome, Total, JustificativaOrdenada)) :-
    % Contribuicoes = [ (Caracteristica, Peso, IdPergunta) ... ] somente para 's'
    findall((Caracteristica, Peso, Id),
        ( perfil(Nome, Caracteristica, Peso),
          pergunta(Id, _Texto, Caracteristica),
          resposta(Id, s)
        ),
        Contribuicoes),
    soma_pesos(Contribuicoes, Total),
    ordena_contribuicoes(Contribuicoes, JustificativaOrdenada).

soma_pesos(Contribuicoes, Total) :-
    findall(Peso, member((_Caracteristica, Peso, _Id), Contribuicoes), Pesos),
    sum_list(Pesos, Total).

ordena_contribuicoes(Contribuicoes, Ordenadas) :-
    sort(2, @>=, Contribuicoes, Ordenadas). % por Peso desc.
% ------------------------------------------
% Ordenacao e exibicao dos resultados
% ------------------------------------------

ordenar_por_pontuacao(Pares, Ordenada) :-
    sort(2, @>=, Pares, Ordenada).  % usa o 2o argumento de trilha/3 (Pontuacao)

exibir_resultados([]) :-
    writeln('Nenhuma trilha recomendada com base nas suas respostas.').
  exibir_resultados(Pares) :-
  writeln('\n=== Ranking de Compatibilidade ==='),
  % pega maior pontuacao para calcular porcentagem
  Pares = [trilha(_TotalMax, Max, _)|_],
    forall(member(trilha(Total, Ponto, Justificativa), Pares),
        ( ( Max =:= 0 -> Percent = 0
          ; Percent is round(Ponto * 100 / Max)
          ),
          trilha(Total, Desc),
          format('\n> ~w (~d pts; ~d%% do topo)\n', [Total, Ponto, Percent]),
          format('  - Descricao: ~w~n', [Desc]),
          ( Justificativa = [] ->
                writeln('  - Nenhuma resposta contribuiu (todas n ou nao relacionadas).')
            ;
                writeln('  - Principais contribuicoes:'),
                mostrar_justificativas(Justificativa)
          )
        )),
    exibir_ranking(Pares).


mostrar_justificativas([]).
mostrar_justificativas([(Caracteristica, Peso, Id)|Resposta]) :-
    caracteristica(Caracteristica, Label),
    format('    • [Q~d] ~w  (+~d)~n', [Id, Label, Peso]),
    mostrar_justificativas(Resposta).


exibir_ranking(Pares) :-
    Pares = [trilha(_TotalMax, Max, _)|_],
    findall(Total, member(trilha(Total, Max, _), Pares), Tops),
    ( Tops = [Unico] ->
        format('\nRecomendacao principal: ~w~n', [Unico])
      ; format('\nEmpate no topo entre: ~w~n', [Tops])
    ).


% -----------------------------------------
% Modo teste
% Carrega resposta de um arquivo
% -----------------------------------------

% Arquivo de teste deve definir fatos: resposta(Id, s|n).
% Ex: testar('tests/teste_perfil_ia.pl').

testar(Arquivo) :-
    limpar_respostas,
    consult(Arquivo),
    banner,
    writeln('Executando em modo de teste (sem entrada manual)...'),
    calcular_pontuacoes(Pares),
    ordenar_por_pontuacao(Pares, Ordenada),
    exibir_resultados(Ordenada).


limpar_respostas :-
    retractall(resposta(_,_)).
