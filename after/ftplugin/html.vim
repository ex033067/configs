setlocal nofoldenable
setlocal foldmethod=indent

setlocal tabstop=2
setlocal expandtab

let b:match_words = '<:>,{{:}},{%:%},{:},[:],(:),<!--:-->,<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>' .
	\ ',{% block:{% endblock,{% if:{% endif,{% for:{% endfor,{% macro:{% endmacro,{% call:{% endcall,{% filter:{% endfilter,{% set:{% endset'
