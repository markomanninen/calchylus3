#! /usr/bin/env hy
; 566 chars
(eval-and-compile(defn G[e](instance? F e))(defn H[a b](while(and(callable a)b)(setv a(a(.pop b 0))))(if b(doto a(.extend b))a))(defn N[e](if(coll? e)(if(G(first e))(H(first e)(list(rest e)))(if(G e)e(do(setv x(list(map N e)))(if(G(first x))(N x)x))))e))(defn R[e](if(and(coll? e)(not(G e)))(map R e)e))(defclass F[list](defn --repr--[self](%"(L%s.%s)"(,(first self)(R(second self)))))(defn --call--[self v &rest a](setv e(N((last self)v)))(if a(H e(list a))e))))(defmacro L[&rest e](reduce(fn[b a]`((fn[](setv ~a '~a)(F['~a ~b(fn[~a]~b)]))))(doto(list e).reverse)))
