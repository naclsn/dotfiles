" Vim's `expr8->` in :py -- somewhat
"
" Adds :Ypy and Ypy() that acts (somewhat) like :py and pyeval(), but is added
" to the syntax the concepts of 'subject' so that the following does what
" you'd expect:
"
"   range(3)->map(str, _)->list(_)->print(_)
"   # 'subject' at 1st `->` is `range(3)`
"   #           at 2nd `->` is `map(str, range(3))`
"   #           ... and so on
"
" `->` essentially makes a `_N` variable of the preceding expression, and in
" the following expression `_` is the latest `_N` at current depth:
"
"   1 -> (_+_) -> print(_) # prints 2
"   1 -> (_+_) -> print(_0) # prints 1 except it doesn't because fixme
"
"   set()->(_.update(coucou) or _.update(blabla) or _)->print(_)
"
" Be prepared for jank 'cause idc. Use :NotYpy to 'help' debugging.
" Why 'Ypy'? 'cause :Y is easy to type, :y <crap> will complain, and y not.

let s:loaded = 0
fu s:ypy()
  if s:loaded |retu |en
  let s:loaded = 1
  py <<
from pprint import pp
import tokenize
_LOWPREC = {tokenize.NOTEQUAL, tokenize.PERCENT, tokenize.PERCENTEQUAL, tokenize.AMPER, tokenize.AMPEREQUAL, tokenize.STAR, tokenize.DOUBLESTAR, tokenize.DOUBLESTAREQUAL, tokenize.STAREQUAL, tokenize.PLUS, tokenize.PLUSEQUAL, tokenize.COMMA, tokenize.MINUS, tokenize.MINEQUAL, tokenize.SLASH, tokenize.DOUBLESLASH, tokenize.DOUBLESLASHEQUAL, tokenize.SLASHEQUAL, tokenize.COLON, tokenize.COLONEQUAL, tokenize.SEMI, tokenize.LESS, tokenize.LEFTSHIFT, tokenize.LEFTSHIFTEQUAL, tokenize.LESSEQUAL, tokenize.EQEQUAL, tokenize.GREATER, tokenize.GREATEREQUAL, tokenize.RIGHTSHIFT, tokenize.RIGHTSHIFTEQUAL, tokenize.AT, tokenize.ATEQUAL, tokenize.CIRCUMFLEX, tokenize.CIRCUMFLEXEQUAL, tokenize.VBAR, tokenize.VBAREQUAL}
_CLOSERS = {tokenize.LPAR: tokenize.RPAR, tokenize.LSQB: tokenize.RSQB, tokenize.LBRACE: tokenize.RBRACE}
_DISCARD = {tokenize.NEWLINE, tokenize.COMMENT, tokenize.NL, tokenize.ENCODING}

def ypytr(script: str):
    tokens = tokenize.generate_tokens(iter([script]).__next__)
    n = 0

    def tt(close: int, subj: "list[str]") -> "list[str]":
        r: "list[str]" = []
        subst = 0

        for tok in tokens:
            et = tok.exact_type
            if et is close:
                r.append(tok.string)
                break

            if et not in _DISCARD:
                if et in _CLOSERS.keys():
                    subtt = [tok.string]
                    subtt.extend(tt(_CLOSERS[et], subj))
                    r.extend(subtt)

                elif tokenize.NAME == et and "_" == tok.string:
                    if 1 == len(subj) and "_" == subj[0][0] and subj[0][1:].isdigit():
                        r.append(subj[0])
                    else:
                        nonlocal n
                        r.extend([f"(_{n}:=(", *subj, "))"])
                        subj = [f"_{n}"]
                        n+= 1

                elif et in _LOWPREC:
                    r.append(tok.string)
                    subst = len(r)

                elif tokenize.RARROW == et:
                    r = r[:subst] + tt(close, r[subst:])
                    break

                else: r.append(tok.string)
        return r

    return " ".join(tt(tokenize.ENDMARKER, ["_"]))

def ypy(script: str): return eval(ypytr(script))
.
endf

fu Ypy(script)
  cal s:ypy()
  retu pyeval('(_:=ypy(r"""'..a:script..'"""))')
endf
com -nargs=+ Ypy cal s:ypy() |py pp(_:=ypy(r"""<args>"""))
com -nargs=+ NotYpy cal s:ypy() |py print(ypytr(r"""<args>"""))
