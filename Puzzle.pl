% MAIN

% executa o modelo e imprime o resultado em formato de tabela
main :-
    modelo(L),
    imprime_lista(L).


% MODELO (FORÇANDO POSIÇÕES)

modelo(L) :-

    % estrutura: cada posição representa um menino
    % (Mochila, Nome, Mês, Jogo, Matéria, Suco)
    L = [
        (M1,N1,Mes1,J1,Mat1,S1),
        (M2,N2,Mes2,J2,Mat2,S2),
        (M3,N3,Mes3,J3,Mat3,S3),
        (M4,N4,Mes4,J4,Mat4,S4),
        (M5,N5,Mes5,J5,Mat5,S5)
    ],

    % FIXOS FORTES (reduzem busca)

    % posição 3: joga Forca e gosta de Morango
    (M3,N3,Mes3,J3,Mat3,S3) = (_,_,_,forca,_,morango),

    % Lenin está na posição 5
    N5 = lenin,

    % na posição 1 bebe suco de limão
    S1 = limao,

    % REGRAS DIRETAS (vínculos absolutos)

    % Mochila azul → nasceu em janeiro
    member((azul,_,janeiro,_,_,_), L),

    % Suco de uva → gosta de problemas de lógica
    member((_,_,_,prob_logica,_,uva), L),

    % Matemática → nasceu em dezembro e bebe maracujá
    member((_,_,dezembro,_,matematica,maracuja), L),

    % João → gosta de História
    member((_,joao,_,_,historia,_), L),

    % Biologia → bebe suco de morango
    member((_,_,_,_,biologia,morango), L),

    % DOMÍNIO (valores únicos)

    % cada lista garante que não há repetição de valores
    permutation([amarela,azul,branca,verde,vermelha], [M1,M2,M3,M4,M5]),
    permutation([denis,joao,lenin,otavio,will], [N1,N2,N3,N4,N5]),
    permutation([agosto,dezembro,janeiro,maio,setembro], [Mes1,Mes2,Mes3,Mes4,Mes5]),
    permutation(['3_ou_mais',caca_palavras,cubo_vermelho,forca,prob_logica], [J1,J2,J3,J4,J5]),
    permutation([biologia,geografia,historia,matematica,portugues], [Mat1,Mat2,Mat3,Mat4,Mat5]),
    permutation([laranja,limao,maracuja,morango,uva], [S1,S2,S3,S4,S5]),

    % RELAÇÕES DE VIZINHANÇA

    % Quem nasceu em setembro está ao lado de quem gosta de laranja
    nextto((_,_,setembro,_,_,_), (_,_,_,_,_,laranja), L),

    % Quem nasceu em janeiro está ao lado de quem nasceu em setembro
    nextto((_,_,janeiro,_,_,_), (_,_,setembro,_,_,_), L),

    % Mochila branca está à esquerda de Will
    esquerda((branca,_,_,_,_,_), (_,will,_,_,_,_), L).



% IMPRESSÃO EM TABELA (ALINHADA)

imprime_lista(L) :-
    nl,
    write('            | Menino 1 | Menino 2 | Menino 3 | Menino 4 | Menino 5'), nl,
    write('------------+----------+----------+----------+----------+----------'), nl,

    linha_mochila(L),
    linha_nome(L),
    linha_mes(L),
    linha_jogo(L),
    linha_materia(L),
    linha_suco(L).

linha_mochila([(M1,_,_,_,_,_),
               (M2,_,_,_,_,_),
               (M3,_,_,_,_,_),
               (M4,_,_,_,_,_),
               (M5,_,_,_,_,_)]) :-
    format('Mochila     | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+~n',
           [M1,M2,M3,M4,M5]).

linha_nome([(_,N1,_,_,_,_),
            (_,N2,_,_,_,_),
            (_,N3,_,_,_,_),
            (_,N4,_,_,_,_),
            (_,N5,_,_,_,_)]) :-
    format('Nome        | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+~n',
           [N1,N2,N3,N4,N5]).

linha_mes([(_,_,Mes1,_,_,_),
           (_,_,Mes2,_,_,_),
           (_,_,Mes3,_,_,_),
           (_,_,Mes4,_,_,_),
           (_,_,Mes5,_,_,_)]) :-
    format('Mes         | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+~n',
           [Mes1,Mes2,Mes3,Mes4,Mes5]).

linha_jogo([(_,_,_,J1,_,_),
            (_,_,_,J2,_,_),
            (_,_,_,J3,_,_),
            (_,_,_,J4,_,_),
            (_,_,_,J5,_,_)]) :-
    format('Jogo        | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+~n',
           [J1,J2,J3,J4,J5]).

linha_materia([(_,_,_,_,Mat1,_),
               (_,_,_,_,Mat2,_),
               (_,_,_,_,Mat3,_),
               (_,_,_,_,Mat4,_),
               (_,_,_,_,Mat5,_)]) :-
    format('Materia     | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+~n',
           [Mat1,Mat2,Mat3,Mat4,Mat5]).

linha_suco([(_,_,_,_,_,S1),
            (_,_,_,_,_,S2),
            (_,_,_,_,_,S3),
            (_,_,_,_,_,S4),
            (_,_,_,_,_,S5)]) :-
    format('Suco        | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+ | ~|~w~t~10+~n',
           [S1,S2,S3,S4,S5]).



% AUXILIAR

% verifica se A está à esquerda de B
esquerda(A, B, L) :-
    nth1(PosA, L, A),
    nth1(PosB, L, B),
    PosA < PosB.