#!/bin/bash

leitura_comentario_linha() {
    local CARACTER
    while read -N1 CARACTER; do
        if [ -z "$CARACTER" ] || [ "$CARACTER" = $'\r' ] ||
                [ "$CARACTER" = $'\n' ]; then
            return
        fi
    done
}

leitura_comentario_bloco() {
    local CARACTER
    local star=false
    while read -N1 CARACTER; do
        if [ "$CARACTER" = '*' ]; then
            star=true
        elif $star; then
            if [ "$CARACTER" = '/' ]; then
                return
            fi
            star=false
        fi
    done
}

leitura_string() {
    local CARACTER
    local ASPAS="$1"

    while read -rN1 CARACTER; do
        if [ "$CARACTER" = '\' ]; then
            read -N1 CARACTER
        elif [ "$CARACTER" = "$ASPAS" ]; then
            return
        fi
    done
}

simple_pushdown_automata() {
    local -r OPEN="$1" CLOSE="$2"
    local -i cnt=0
    local CARACTER
    local barra=false

    while read -N1 CARACTER; do
        case "$CARACTER" in
            "$OPEN")
                cnt+=1       #empilha PUSH
                barra=false
                ;;
            "$CLOSE")
                if [ $cnt = 0 ]; then
                    return   #removeu PUSH-E
                fi
                cnt+=-1      #desempilha PUSH
                barra=false
                ;;
            /)
                if $barra; then
                    leitura_comentario_linha
                    barra=false
                else
                    barra=true;
                fi
                ;;
            '"'|"'")
                leitura_string "$CARACTER"
                ;;
            '*')
                if $barra; then
                    leitura_comentario_bloco
                    barra=false
                fi
                ;;
            *)
                barra=false
                ;;
        esac
    done
}



estado=INICIAL
enum_lida=''
barra=false
while read -N1 CARACTER; do
    case "$estado" in
        INICIAL)
            if [ "$CARACTER" = '{' ]; then
                estado=POSSIVEIS_ENUM
            elif [ "$CARACTER" = '(' ]; then # só acontece com anotação
                simple_pushdown_automata '(' ')'
            fi
            ;;
        POSSIVEIS_ENUM)
            if [[ "$CARACTER" = [A-Za-z0-9_] ]]; then
                enum_lida+="$CARACTER" #evento #ID
            else
                if [ -n "$enum_lida" ]; then
                    echo "$enum_lida" #evento #FIM
                    enum_lida=''
                fi
                if [ "$CARACTER" = { ]; then
                    simple_pushdown_automata { }
                elif [ "$CARACTER" = '(' ]; then
                    simple_pushdown_automata '(' ')'
                elif [ "$CARACTER" = '}' ] || [ "$CARACTER" = ';' ]; then
                    estado=EOE
                elif [ "$CARACTER" = '@' ]; then
                    estado=ANNOTATION
                fi
            fi
            ;;
        ANNOTATION)
            if [[ "$CARACTER" = [A-Za-z0-9_] ]]; then
                # não faz nada, identificador da annotation
            else
                # saiu da annotation ou falta só parametrizar ela
                estado=POSSIVEIS_ENUM
                if [ "$CARACTER" = '(' ]; then
                    simple_pushdown_automata '(' ')'
                elif [ "$CARACTER" = '@' ]; then
                    # caiu em nova annotation
                    estado=ANNOTATION
                fi
            fi
            ;;
        EOE)
            break
            ;;
    esac
    if [ "$CARACTER" = / ]; then
        if $barra; then
            leitura_comentario_linha
            barra=false
        else
            barra=true
        fi
    elif $barra; then
        if [ "$CARACTER" = '*' ]; then
            leitura_comentario_bloco
        fi
        barra=false
    fi
done