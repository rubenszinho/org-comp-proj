jmp InitGame

; -----------------------------------------------------------------------------
; Variáveis
; -----------------------------------------------------------------------------
Tabuleiro : string "_________"
Mensagem : string "Use os numeros para movimentar o cursor e o Enter para executar as jogadas."
Cursor : var #1
Slot : var #1
Vez : var #1 ; 1 é vez do pc, 0 é do usuario
rnd : var #1
MapPos : var #9 ; Tabela de posições na tela para os 9 slots

; Inicializa a tabela de posições para centralizar o jogo (3x3 com espaçamento)
; Tela 40 colunas.
; Linha 1: Pos 494, 498, 502 (Linha 12 da tela)
; Linha 2: Pos 574, 578, 582 (Linha 14 da tela)
; Linha 3: Pos 654, 658, 662 (Linha 16 da tela)
static MapPos + #0, #494
static MapPos + #1, #498
static MapPos + #2, #502
static MapPos + #3, #574
static MapPos + #4, #578
static MapPos + #5, #582
static MapPos + #6, #654
static MapPos + #7, #658
static MapPos + #8, #662

; -----------------------------------------------------------------------------
; Inicialização e Menus
; -----------------------------------------------------------------------------
InitGame:
    ; Tela de menu
    MenuScreen:
        call ClearScreen
        loadn r1, #TelaInit0
        loadn r2, #1280        ; Cor roxa
        call PrintScreen

    MenuLoop:
        loadn r3, #255
        inchar r4
        cmp r4, r3
        jeq MenuLoop
        jmp StartGame

    ; Tela de Vitoria (Jogador ganhou)
    VitoriaScreen:
        call ClearScreen
        loadn r1, #TelaVitoria0
        loadn r2, #512         ; Cor verde
        call PrintScreen
        
    VitoriaLoop:
        loadn r3, #255
        inchar r4
        cmp r4, r3
        jeq VitoriaLoop
        jmp InitGame           ; Reinicia o jogo

    ; Tela de Derrota (PC ganhou)
    DerrotaScreen:
        call ClearScreen
        loadn r1, #TelaDerrota0
        loadn r2, #2304        ; Cor vermelha
        call PrintScreen
        
    DerrotaLoop:
        loadn r3, #255
        inchar r4
        cmp r4, r3
        jeq DerrotaLoop
        jmp InitGame           ; Reinicia o jogo

    ; Tela de Empate (Velha)
    EmpateScreen:
        call ClearScreen
        loadn r1, #TelaEmpate0
        loadn r2, #1280        ; Cor roxa
        call PrintScreen
        
    EmpateLoop:
        loadn r3, #255
        inchar r4
        cmp r4, r3
        jeq EmpateLoop
        jmp InitGame           ; Reinicia o jogo

    ; Inicialização do jogo
    StartGame:
        call ClearScreen
        loadn r1, #TelaJogo0
        loadn r2, #256         ; Cor branca/padrão para o tabuleiro
        call PrintScreen
        
        call reinicia          ; Limpa o tabuleiro lógico
        loadn r0, #0
        store Cursor, r0
        store Vez, r0
        store Slot, r0
        
        call print             ; Desenha o estado inicial (X/O)
        call MostraTurno       ; Mostra de quem é a vez

    ; Loop principal do jogo
    GameLoop:
        call RND               ; Atualiza semente aleatória
        call LeTeclado         ; Lê input e processa jogada
        call print             ; Atualiza a tela
        jmp GameLoop

; -----------------------------------------------------------------------------
; Lógica do Jogo
; -----------------------------------------------------------------------------

LeTeclado:
    push r0
    push r1
    
    inchar r0
    loadn r1, #255
    cmp r0, r1
    jeq LeTecladoFim       ; Se nada pressionado, retorna

    loadn r1, #13          ; Enter
    cmp r0, r1
    jeq TrataEnter
    
    ; Verifica números 1-9 para mover cursor direto
    ; Tecla '1' (ASCII 49) -> posição 0
    ; Tecla '9' (ASCII 57) -> posição 8
    loadn r1, #49          ; '1'
    cmp r0, r1
    jle LeTecladoFim       ; Menor que '1', ignora
    loadn r1, #57          ; '9'
    cmp r0, r1
    jgr LeTecladoFim       ; Maior que '9', ignora
    
    ; Converte ASCII para índice (0-8)
    loadn r1, #49          ; '1'
    sub r0, r0, r1         ; r0 = tecla - '1' (resulta em 0-8)
    store Cursor, r0       ; Atualiza cursor
    jmp LeTecladoFim

    TrataEnter:
        call Joga
    
    LeTecladoFim:
    pop r1
    pop r0
    rts

Joga:
    push r0
    push r1
    push r2
    
    ; Se for vez do PC
    load r0, Vez
    loadn r1, #0
    cmp r0, r1
    jeq VezDoUsuario
    
    call PCJoga
    call AlguemGanhou
    jmp JogaFim

    VezDoUsuario:
        loadn r1, #Tabuleiro
        load r0, Cursor
        add r1, r1, r0
        
        loadi r0, r1
        loadn r2, #'_'
        cmp r2, r0
        jne JogaFim        ; Casa ocupada
        
        loadn r0, #'X'
        storei r1, r0
        call MudaVez
        call AlguemGanhou

    JogaFim:
    pop r2
    pop r1
    pop r0
    rts

PCJoga:
    push r0
    push r1
    push r2
    push r3
    push r4
    loadn r2, #'_'
    loadn r0, #Tabuleiro
    
    PCJogaLoop:
        call RND
        mov r4, r7             ; Salva o índice gerado
        add r1, r0, r4         ; r1 = Tabuleiro + índice
        loadi r3, r1
        cmp r2, r3
        jne PCJogaLoop
    
    ; Encontrou posição vazia, usa r1 que já tem o endereço correto
    loadn r3, #'O'
    storei r1, r3
    call MudaVez
    
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

MudaVez:
    push r0
    push r1
    load r0, Vez
    loadn r1, #0
    cmp r0, r1
    jne MudaVezFim
    loadn r1, #1
    MudaVezFim:
    store Vez, r1
    call MostraTurno          ; Atualiza mensagem de turno
    pop r1
    pop r0
    rts

AlguemGanhou:
    push r0
    push r1
    push r2
    push r3
    push r4
    loadn r4, #1
    
    ; Verifica linhas
    loadn r0, #0
    loadn r1, #1
    loadn r2, #2
    call Iguais
    cmp r4, r3
    jeq SimAlguemGanhou
    
    loadn r0, #3
    loadn r1, #4
    loadn r2, #5
    call Iguais
    cmp r4, r3
    jeq SimAlguemGanhou
    
    loadn r0, #6
    loadn r1, #7
    loadn r2, #8
    call Iguais
    cmp r4, r3
    jeq SimAlguemGanhou
    
    ; Verifica colunas
    loadn r0, #0
    loadn r1, #3
    loadn r2, #6
    call Iguais
    cmp r4, r3
    jeq SimAlguemGanhou
    
    loadn r0, #1
    loadn r1, #4
    loadn r2, #7
    call Iguais
    cmp r4, r3
    jeq SimAlguemGanhou
    
    loadn r0, #2
    loadn r1, #5
    loadn r2, #8
    call Iguais
    cmp r4, r3
    jeq SimAlguemGanhou
    
    ; Verifica diagonais
    loadn r0, #0
    loadn r1, #4
    loadn r2, #8
    call Iguais
    cmp r4, r3
    jeq SimAlguemGanhou

    loadn r0, #2
    loadn r1, #4
    loadn r2, #6
    call Iguais
    cmp r4, r3
    jeq SimAlguemGanhou
    
    jmp VerificaVelha

    SimAlguemGanhou:
        ; Verifica quem ganhou baseado na vez atual
        ; Se Vez == 1, significa que o jogador (X) acabou de jogar e ganhou
        ; Se Vez == 0, significa que o PC (O) acabou de jogar e ganhou
        call Delay
        load r0, Vez
        loadn r1, #1
        cmp r0, r1
        jeq JogadorGanhou
        jmp PCGanhou
        
    JogadorGanhou:
        jmp VitoriaScreen
        
    PCGanhou:
        jmp DerrotaScreen

    VerificaVelha:
        call DeuVelha
        
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

Iguais:
    push r0
    push r1
    push r2
    loadn r3, #Tabuleiro
    add r0, r0, r3
    add r1, r1, r3
    add r2, r2, r3
    loadi r0, r0
    loadi r1, r1
    loadi r2, r2
    
    cmp r0, r1
    jne NaoIguais
    cmp r0, r2
    jne NaoIguais    
    
    loadn r3, #'_'
    cmp r3, r0
    jeq NaoIguais
    loadn r3, #1
    jmp IguaisFim
    
    NaoIguais:
    loadn r3, #0
    
    IguaisFim:
    pop r2
    pop r1
    pop r0
    rts

DeuVelha:
    push r0
    push r1
    push r2
    
    ; Verifica se tem algum espaço vazio
    loadn r0, #0 ; contador
    loadn r1, #Tabuleiro
    loadn r2, #9 ; limite
    
    LoopVelha:
        loadi r3, r1
        loadn r4, #'_'
        cmp r3, r4
        jeq NaoDeuVelha ; Achou vazio, jogo continua
        inc r1
        inc r0
        cmp r0, r2
        jne LoopVelha
        
    ; Se chegou aqui, tabuleiro cheio e ninguém ganhou
    call Delay
    jmp EmpateScreen
    
    NaoDeuVelha:
    pop r2
    pop r1
    pop r0
    rts

; Função de impressão do tabuleiro (X e O) nas posições corretas
print:
    push r0 ; índice 0..8
    push r1 ; ponteiro Tabuleiro
    push r2 ; ponteiro MapPos
    push r3 ; valor do char
    push r4 ; posição na tela
    push r5 ; cor
    push r6 ; cursor

    loadn r0, #0
    loadn r1, #Tabuleiro
    loadn r2, #MapPos
    load r6, Cursor

    PrintLoop:
        loadi r3, r1        ; Carrega char do tabuleiro (X, O, _)
        loadi r4, r2        ; Carrega posição na tela do MapPos
        
        ; Define cor base
        loadn r5, #256      ; Branco (exemplo)
        
        ; Verifica se é o cursor
        cmp r0, r6
        jne PrintChar
        loadn r5, #2304     ; Vermelho se for cursor (ou outra cor de destaque)
        
        PrintChar:
        add r3, r3, r5      ; Adiciona cor ao char
        outchar r3, r4      ; Imprime na tela na posição mapeada
        
        inc r0
        inc r1
        inc r2
        loadn r3, #9
        cmp r0, r3
        jne PrintLoop

    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

reinicia:
    push r0
    push r1
    push r2
    push r3
    loadn r0, #Tabuleiro
    loadn r1, #0
    
    reinicialoop:
    add r2, r0, r1
    loadn r3, #'_'
    storei r2, r3
    inc r1
    loadn r3, #9
    cmp r1, r3
    jne reinicialoop
    
    pop r3
    pop r2
    pop r1
    pop r0
    rts

RND:
    push r0
    inc r7
    loadn r0, #9
    mod r7, r7, r0
    pop r0
    rts

Delay:
    push r0
    push r1
    loadn r1, #50
    DelayLoop2:
        loadn r0, #1000
    DelayLoop:
        dec r0
        jnz DelayLoop
        dec r1
        jnz DelayLoop2
    pop r1
    pop r0
    rts

; Função para mostrar de quem é a vez
MostraTurno:
    push r0
    push r1
    push r2
    push r3
    push r4
    
    ; Limpa a linha 22 (posição 880 a 919)
    loadn r0, #880
    loadn r1, #920
    loadn r2, #' '
    LimpaLinha22:
        outchar r2, r0
        inc r0
        cmp r0, r1
        jne LimpaLinha22
    
    ; Verifica de quem é a vez
    load r0, Vez
    loadn r1, #0
    cmp r0, r1
    jeq MostraVezJogador
    jmp MostraVezPC
    
    MostraVezJogador:
        ; "SUA VEZ" - centralizado na linha 22 (posição ~896)
        loadn r0, #893
        loadn r1, #MsgSuaVez
        loadn r2, #512         ; Verde
        call PrintMsgTurno
        jmp MostraTurnoFim
    
    MostraVezPC:
        ; "Pressione ENTER para jogada do PC" - centralizado
        loadn r0, #883
        loadn r1, #MsgVezPC
        loadn r2, #2304        ; Vermelho
        call PrintMsgTurno
        jmp MostraTurnoFim
    
    MostraTurnoFim:
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

; Imprime mensagem de turno
PrintMsgTurno:
    push r0
    push r1
    push r2
    push r3
    push r4
    
    loadn r3, #'\0'
    
    PrintMsgTurnoLoop:
        loadi r4, r1
        cmp r4, r3
        jeq PrintMsgTurnoFim
        add r4, r2, r4
        outchar r4, r0
        inc r0
        inc r1
        jmp PrintMsgTurnoLoop
    
    PrintMsgTurnoFim:
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

; -----------------------------------------------------------------------------
; Funções Gráficas (Importadas de snake-game.asm)
; -----------------------------------------------------------------------------

; Função para limpar a tela
ClearScreen:
    push r0
    push r1

    loadn r0, #1200           ; Define 1200 como o número de posições para limpar na tela
    loadn r1, #' '            ; Caractere de espaço para limpar

    ClearScreenLoop:
        dec r0                ; Decrementa o contador
        outchar r1, r0        ; Imprime espaço na posição atual
        jnz ClearScreenLoop   ; Repete até que o contador chegue a zero

    pop r1
    pop r0
    rts

; Função para imprimir a tela
PrintScreen:
    push r0
    push r3
    push r4
    push r5

    loadn r0, #0              ; Posição inicial deve ser o começo da tela
    loadn r3, #40             ; Passa para a próxima linha
    loadn r4, #41             ; Incremento do ponteiro
    loadn r5, #1200           ; Limite da tela

    PrintScreenLoop:
        call PrintStr         ; Chama a função para imprimir cada pixel
        add r0, r0, r3        ; Incrementa a posição para a próxima linha na tela
        add r1, r1, r4        ; Incrementa o ponteiro para a próxima linha na memória
        cmp r0, r5            ; Verifica se o fim da tela foi alcançado
        jne PrintScreenLoop

    pop r5
    pop r4
    pop r3
    pop r0
    rts

; Função para imprimir uma string
PrintStr:
    push r0
    push r1
    push r2
    push r3
    push r4

    loadn r3, #'\0'           ; Critério de parada

    PrintStrLoop:
        loadi r4, r1          ; Obtém o primeiro caractere
        cmp r4, r3            ; Verifica o critério de parada
        jeq PrintStrExit
        add r4, r2, r4        ; Adiciona a cor
        outchar r4, r0        ; Imprime o caractere na tela
        inc r0                ; Incrementa a posição na tela
        inc r1                ; Incrementa o ponteiro da string
        jmp PrintStrLoop

    PrintStrExit:
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        rts

; -----------------------------------------------------------------------------
; Telas (Strings)
; -----------------------------------------------------------------------------

; Tela de Inicio
TelaInit0  : string "|======================================|"
TelaInit1  : string "|                                      |"
TelaInit2  : string "|                                      |"
TelaInit3  : string "|                                      |"
TelaInit4  : string "|                                      |"
TelaInit5  : string "|    |   | +---- |     |   | +---+     |"
TelaInit6  : string "|    |   | |     |     |   | |   |     |"
TelaInit7  : string "|    |   | +---  |     +---+ +---+     |"
TelaInit8  : string "|     | |  |     |     |   | |   |     |"
TelaInit9  : string "|      |   +---- +---- |   | |   |     |"
TelaInit10 : string "|                                      |"
TelaInit11 : string "|            JOGO DA VELHA             |"
TelaInit12 : string "|                                      |"
TelaInit13 : string "|                                      |"
TelaInit14 : string "|                                      |"
TelaInit15 : string "|                                      |"
TelaInit16 : string "|                                      |"
TelaInit17 : string "|                                      |"
TelaInit18 : string "|                                      |"
TelaInit19 : string "|                                      |"
TelaInit20 : string "|                                      |"
TelaInit21 : string "|                                      |"
TelaInit22 : string "|                                      |"
TelaInit23 : string "|                                      |"
TelaInit24 : string "|        Pressione qualquer tecla      |"
TelaInit25 : string "|              para jogar              |"
TelaInit26 : string "|                                      |"
TelaInit27 : string "|                                      |"
TelaInit28 : string "|                                      |"
TelaInit29 : string "|======================================|"

; Tela de Vitoria
TelaVitoria0   : string "|======================================|"
TelaVitoria1   : string "|                                      |"
TelaVitoria2   : string "|                                      |"
TelaVitoria3   : string "|                                      |"
TelaVitoria4   : string "|                                      |"
TelaVitoria5   : string "|  |   | -+- -+- +--+ +--  -+-  +--+   |"
TelaVitoria6   : string "|  |   |  |   |  |  | |  |  |   |  |   |"
TelaVitoria7   : string "|  |   |  |   |  |  | +--   |   +--+   |"
TelaVitoria8   : string "|   | |   |   |  |  | |  |  |   |  |   |"
TelaVitoria9   : string "|    |   -+-  |  +--+ |  | -+-  |  |   |"
TelaVitoria10  : string "|                                      |"
TelaVitoria11  : string "|            VOCE GANHOU!              |"
TelaVitoria12  : string "|                                      |"
TelaVitoria13  : string "|                                      |"
TelaVitoria14  : string "|                                      |"
TelaVitoria15  : string "|                                      |"
TelaVitoria16  : string "|                                      |"
TelaVitoria17  : string "|                                      |"
TelaVitoria18  : string "|                                      |"
TelaVitoria19  : string "|                                      |"
TelaVitoria20  : string "|                                      |"
TelaVitoria21  : string "|                                      |"
TelaVitoria22  : string "|                                      |"
TelaVitoria23  : string "|                                      |"
TelaVitoria24  : string "|        Pressione qualquer tecla      |"
TelaVitoria25  : string "|             para reiniciar           |"
TelaVitoria26  : string "|                                      |"
TelaVitoria27  : string "|                                      |"
TelaVitoria28  : string "|                                      |"
TelaVitoria29  : string "|======================================|"

; Tela de Derrota
TelaDerrota0   : string "|======================================|"
TelaDerrota1   : string "|                                      |"
TelaDerrota2   : string "|                                      |"
TelaDerrota3   : string "|                                      |"
TelaDerrota4   : string "|                                      |"
TelaDerrota5   : string "|   +--  +--- +--  +--  +--+ -+- +--+  |"
TelaDerrota6   : string "|   |  | |    |  | |  | |  |  |  |  |  |"
TelaDerrota7   : string "|   |  | +--  +--  +--  |  |  |  +--+  |"
TelaDerrota8   : string "|   |  | |    |  | |  | |  |  |  |  |  |"
TelaDerrota9   : string "|   +--  +--- |  | |  | +--+  |  |  |  |"
TelaDerrota10  : string "|                                      |"
TelaDerrota11  : string "|            VOCE PERDEU!              |"
TelaDerrota12  : string "|                                      |"
TelaDerrota13  : string "|                                      |"
TelaDerrota14  : string "|                                      |"
TelaDerrota15  : string "|                                      |"
TelaDerrota16  : string "|                                      |"
TelaDerrota17  : string "|                                      |"
TelaDerrota18  : string "|                                      |"
TelaDerrota19  : string "|                                      |"
TelaDerrota20  : string "|                                      |"
TelaDerrota21  : string "|                                      |"
TelaDerrota22  : string "|                                      |"
TelaDerrota23  : string "|                                      |"
TelaDerrota24  : string "|        Pressione qualquer tecla      |"
TelaDerrota25  : string "|             para reiniciar           |"
TelaDerrota26  : string "|                                      |"
TelaDerrota27  : string "|                                      |"
TelaDerrota28  : string "|                                      |"
TelaDerrota29  : string "|======================================|"

; Tela de Empate
TelaEmpate0   : string "|======================================|"
TelaEmpate1   : string "|                                      |"
TelaEmpate2   : string "|                                      |"
TelaEmpate3   : string "|                                      |"
TelaEmpate4   : string "|                                      |"
TelaEmpate5   : string "|  +--- +- -+  +--+  +--+ --+-- +---   |"
TelaEmpate6   : string "|  |    | | |  |  |  |  |   |   |      |"
TelaEmpate7   : string "|  |--  | | |  |--+  +--+   |   +--    |"
TelaEmpate8   : string "|  |    |   |  |     |  |   |   |      |"
TelaEmpate9   : string "|  +--- |   |  |     |  |   |   +---   |"
TelaEmpate10  : string "|                                      |"
TelaEmpate11  : string "|             DEU VELHA!               |"
TelaEmpate12  : string "|                                      |"
TelaEmpate13  : string "|                                      |"
TelaEmpate14  : string "|                                      |"
TelaEmpate15  : string "|                                      |"
TelaEmpate16  : string "|                                      |"
TelaEmpate17  : string "|                                      |"
TelaEmpate18  : string "|                                      |"
TelaEmpate19  : string "|                                      |"
TelaEmpate20  : string "|                                      |"
TelaEmpate21  : string "|                                      |"
TelaEmpate22  : string "|                                      |"
TelaEmpate23  : string "|                                      |"
TelaEmpate24  : string "|        Pressione qualquer tecla      |"
TelaEmpate25  : string "|             para reiniciar           |"
TelaEmpate26  : string "|                                      |"
TelaEmpate27  : string "|                                      |"
TelaEmpate28  : string "|                                      |"
TelaEmpate29  : string "|======================================|"

; Tela do Jogo (Background com as linhas do tabuleiro)
; O tabuleiro é desenhado nas linhas 12, 13, 14, 15, 16
; Colunas centrais: 14, 18, 22
TelaJogo0  : string "|======================================|"
TelaJogo1  : string "|                                      |"
TelaJogo2  : string "|                                      |"
TelaJogo3  : string "|                                      |"
TelaJogo4  : string "|                                      |"
TelaJogo5  : string "|                                      |"
TelaJogo6  : string "|                                      |"
TelaJogo7  : string "|                                      |"
TelaJogo8  : string "|                                      |"
TelaJogo9  : string "|                                      |"
TelaJogo10 : string "|               |   |                  |"
TelaJogo11 : string "|               |   |                  |"
TelaJogo12 : string "|               |   |                  |"
TelaJogo13 : string "|           ----+---+----              |"
TelaJogo14 : string "|               |   |                  |"
TelaJogo15 : string "|           ----+---+----              |"
TelaJogo16 : string "|               |   |                  |"
TelaJogo17 : string "|               |   |                  |"
TelaJogo18 : string "|               |   |                  |"
TelaJogo19 : string "|                                      |"
TelaJogo20 : string "|                                      |"
TelaJogo21 : string "|                                      |"
TelaJogo22 : string "|                                      |"
TelaJogo23 : string "|                                      |"
TelaJogo24 : string "|      Use 1-9 ou Enter para jogar     |"
TelaJogo25 : string "|                                      |"
TelaJogo26 : string "|                                      |"
TelaJogo27 : string "|                                      |"
TelaJogo28 : string "|                                      |"
TelaJogo29 : string "|======================================|"

; Mensagens de turno
MsgSuaVez : string "SUA VEZ"
MsgVezPC : string "Pressione ENTER para jogada do PC"