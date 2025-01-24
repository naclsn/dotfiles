" Make python usable, dangit

let s:loaded = v:false

fu s:ypy()
  if s:loaded |retu |en
  let s:loaded = v:true
  py <<
from pprint import pp
import tokenize
_BREAKS = {tokenize.COMMA, tokenize.COLON}
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

                elif et in _BREAKS:
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

com -nargs=+ Ypy cal s:ypy() |py pp(_ := ypy(r"""<args>"""))
