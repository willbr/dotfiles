" Define syntax groups
syntax keyword myformatKeyword fn return from import params returns if cond
syntax keyword myformatRepeat for in fn while

syntax match myformatOperator "[=]"

syntax match myformatString1 /"\([^"\\]\|\\.\)*"/
syntax match myformatString2 /'\([^'\\]\|\\.\)*'/
syntax match myformatComment "#.*$"


syntax match Number1 "\v<\d+\.?\d*|\.\d+>"
syntax match Number2 "\v<\d+\.?\d*f|\.\d+f>"
highlight default link Number1 Number
highlight default link Number2 Number

" Set highlighting rules
highlight default link myformatKeyword Keyword
highlight default link myformatString1 String
highlight default link myformatString2 String
highlight default link myformatComment Comment

highlight default link myformatRepeat Repeat
highlight default link myformatOperator Operator
