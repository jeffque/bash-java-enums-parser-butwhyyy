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

estado=INICIAL
enum_lida=''
barra=false
while read -N1 CARACTER; do
    case "$estado" in
        INICIAL)
            if [ "$CARACTER" = '{' ]; then
                estado=POSSIVEIS_ENUM
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
                if [ "$CARACTER" = '}' ] || [ "$CARACTER" = ';' ]; then
                    estado=EOE
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