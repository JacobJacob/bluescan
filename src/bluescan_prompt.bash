#!/usr/bin/env bash

_bluescan() {
    local pword cword opts modes le_scan_types result
    pword=${COMP_WORDS[COMP_CWORD-1]}
    cword=${COMP_WORDS[COMP_CWORD]}

    opts='-h --help -v --version -m -i --timeout= --le-scan-type='
    modes='le br'
    le_scan_types='active passive'

    # echo -e '\n'
    # echo cmd: $cmd
    # echo pword: $pword
    # echo cword: $cword
    # echo COMP_CWORD: $COMP_CWORD

    case $cword in
    -*)
        result=($(compgen -W "$opts" -- $cword))
        ;;
    esac


    case $pword in
    -m)
        result=($(compgen -W "$modes" -- $cword))
        ;;
    =)
        if [ $COMP_CWORD -gt 1 ] && [ ${COMP_WORDS[COMP_CWORD-2]} = --le-scan-type ]; then
            result=($(compgen -W "$le_scan_types" -- $cword))
        fi
        ;;
    esac

    if [ ${#result[*]} -ne 1 ]; then
        # 当匹配结果不唯一时，不把匹配结果传递给 bash
        result=('')
    fi

    COMPREPLY=$result
}

complete -F _bluescan bluescan
