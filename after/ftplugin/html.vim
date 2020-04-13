setlocal foldmethod=syntax foldlevel=4
setlocal tabstop=2

let b:match_words = '<:>,{{:}},{%:%},{:},[:],(:),<!--:-->,<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>' .
    \ ',{% block:{% endblock,{% if:{% endif,{% for:{% endfor,{% macro:{% endmacro,{% call:{% endcall,{% filter:{% endfilter,{% set:{% endset'
