Calchylus 3 - Lambda calculus with Hy
=====================================

Intro
-----

``calchylus3`` is a computer installable `Hy`_ module that is used to evaluate,
and furthermore, through this documentation, shine light to the basics of Lambda
calculus (also written as λ-calculus).

	`Lambda calculus`_ is a formal system in mathematical logic for expressing
	computation that is based on a function abstraction and the application using
	variable binding and substitution.

The target audience is those who:

a) are interested in the theory and the history of the programming languages
b) may have some experience or are interested to gain more experience in Python
   and/or Lisp
c) who wants to narrow the gap between mathematical notation and
   programming languages, especially by the means of logic

CS Concepts
-----------

`Andrew Bayer`_, a professor of computational mathematics at the Faculty of
Mathematics and Physics, University of Ljubljana, writes in his blog post about
formal proofs and deduction:

	*Traditional logic, and to some extent also type theory, hides computation
	behind equality.*

Lambda calculus, on the other hand, reveals how the computation in logic is
done by manipulation of the Lambda terms. Manipulation rules are simple and
were originally made with a paper and a pen, but now we rather use computers for
the task. Lambda calculus also addresses the problem, what can be proved and
solved and what cannot be computed in a finite amount of time. Formally these
are called the `decidability`_ and the `halting`_ problems in Computer
Science (CS).

Beside evaluating Lambda expressions, ``calchylus3`` module can serve as a
starting point for a mini programming language. Via `custom macros`_
representing well known Lambda forms, ``calchylus3`` provides all necessary
elements for boolean, integers, and list data types as well as
conditionals, loops, variable setters, imperative do structure, logical
connectives, and arithmetic operators. You can build upon that, for example
`real numbers`_ , even negative complex numbers, if it makes any sense to do it
with Lambda calculus. Your imagination is really the only limit.

Finally, when investigating the open source ``calchylus3`` implementation that is
hosted on `GitHub`_ , one can expect to get a good understanding of the higher
order functions and the `combinatory logic`_, not the least of the fixed-point
combinator or shortly, ϒ-combinator.

Older version
-------------

.. note::
  ``calchylus3`` is a revised edition of `Calchylus`_ pypi package. While the
  earlier version focuses on the beta-reduction steps and "pure" implementation
  of the Lambda calculus, ``calchylus3`` concentrates on solving the performance
  issues. Performance is a critical factor when implementing and designing more
  complex lambda forms that utilize Y-combinator. This is achieved by using some
  of the native data structures of Hy / Python, which affects to the final
  syntax of the ``calchylus3`` implementation.


Quick start
-----------

For people willing to get hands quickly on coding, this is the fast way of
jumping in:

**Install**

.. code-block:: bash

	$ pip install calchylus3

**Open Hy**

.. code-block:: bash

	$ hy

**Import lambda library**

.. code-block:: hylang

	> (require [calchylus3.lambdas [\*]])

**Initialize lambda macros**

Use ``with-macros`` macro to initialize the system. Pass a lambda function
abstraction binder name as the first parameter, for example ``λ`` or ``L``:

.. code-block:: hylang

	> (with-macros L)

Run and output the result of the ``calchylus3`` application:

.. code-block:: hylang

	> (print ((L x x) 1))

that outputs ``1``.

**Application form**

Syntactically application is formed by ``(F v)`` where ``F`` is a function abstraction and
``v`` is a parameter passed on the function. Mathematically this is phrased so
that the function ``F`` is applied to the parameter ``v``. Parentheses are
required around the function and the parameter in ``calchylus3``.

Function ``F`` is an abstraction formed by the selected binder in the
``with-macros`` call. After the binder comes either a single variable name or
multiary variables separated by spaces. The last block in the function is the
body of the function which is also separated by space from the variable. Also
the function must be wrapped with parentheses. So the function abstraction looks
like:

.. code-block:: hylang

	> (L x x)

In this so-called identity function the first ``x`` is the variable name and the
last ``x`` is the body of the function simply containing the variable.

The last and the final step is to form an application with a function
and a parameter. If function ``F`` is ``(L x x)`` and the parameter ``v`` is ``1``,
then the application is denoted as:

.. code-block:: hylang

	> ((L x x) 1)

Now ``calchylus3`` will evaluate this expression by replacing all occurences of
``x`` in the function body with the parameter ``1``. Output is simply ``1``.

In this simple example same is achieved by many programming languages with an
anonymous function. For example in Python we could do:

.. code-block:: python

	> (lambda x: x)(1)

which is just a matter of syntax being a little bit different from Lambda
calculus. When going into the complex applications, there is actually more
inside the surface but it will be discussed later.

**Monad or multiary**

Traditionally single variable functions were called `monads`_, two variable
functions dyads and so on. Later the concept of monad evolved much more esoteric
in the programming languages.

``calchylus3`` supports any number of variable names in the function, but
internally the multiary function is regarded as a nested set of monadic
functions. For example nested lambda function may contain three different
abstractions each containing one variable.

Example a:

.. code-block:: hylang

	> (L x (L y (L z [x y z])))

can be expressed simply in the example b:

.. code-block:: hylang

	> (L x y z [x y z])

Latter, however, is regarded as a nested set of functions as denoted in the
example a. In same way passing parameters to the function can be done in a
nested structure

Example c:

.. code-block:: hylang

	> ((((L x (L y (L z [x [y z]]))) 1) 2) 3)

when output is: ``[1 [2 3]]``

But semantically it is easier to read code, when applying function to parameters
in linear fashion.

Example d:

.. code-block:: hylang

	> ((L x y z [x [y z]]) 1 2 3)

Parameter currying process is applied internally so that both expressions
(c and d) yield the same result: ``[1 [2 3]]``

.. note::
  The function body is defined as a Hy list ``[1 [2 3]]`` rather than parenthesis
  ``(1 (2 3))``. This is one specialty of the ``calchylus3`` module compared to
  the most implementations of the Lambda calculus. As earlier stated, this is
  because of the performance advantage achieved by using native Hy / Python list
  data structures. You can use ``print*`` to output result in parentheses however.

Any symbol recognizable by Hy-language is accepted as a parameter ``v``. If
variable is not used anywhere in the function body, then it must be quoted so
that Hy-interpreter doesn't take it as an undefined variable and cause a
run-time error.

Right:

.. code-block:: hylang

	> (L x 'y)

Wrong (expect error):

.. code-block:: hylang

	> (L x y)

**Lambda dance**

Church number three:

.. code-block:: hylang

	> (print* ((L x y [x [x [x y]]]) 'a 'b))

By using ``print*`` helper function we get the output: ``(a (a (a b)))``.

Seventh fibonacci number:

.. code-block:: hylang

	> (print* (FIBONACCI SEVEN 'x 'y))

Output: ``(x (x (x (x (x (x (x (x (x (x (x (x (x y)))))))))))))``.

Decode chuch number to an integer with ``MUN`` macro:

.. code-block:: hylang

	> (print (MUN (FIBONACCI SEVEN)))

Output: ``13``.

Documentation
-------------

For full documentation, see: `calchylus3.readthedocs.io`_


.. |Output:| replace:: [output]

.. _halting problem: http://www.huffingtonpost.com/entry/how-to-describing-alan-turings-halting-problem-to_us_58d1ae08e4b062043ad4add7
.. _combinatory logic: https://en.wikipedia.org/wiki/Combinatory_logic
.. _GitHub: https://github.com/markomanninen/calchylus3
.. _real numbers: https://cs.stackexchange.com/questions/2272/representing-negative-and-complex-numbers-using-lambda-calculus?noredirect=1&lq=1
.. _my favorite programming language: http://www.python.org
.. _custom macros: http://calchylus.readthedocs.io/en/latest/macros.html
.. _decidability: https://plato.stanford.edu/entries/computability/#UnsHalPro
.. _halting: https://en.wikipedia.org/wiki/Halting_problem
.. _Andrew Bayer: http://math.andrej.com/2016/08/30/formal-proofs-are-not-just-deduction-steps/
.. _Lambda calculus: https://en.wikipedia.org/wiki/Lambda_calculus
.. _Hy: http://docs.hylang.org
.. _calchylus: https://github.com/markomanninen/calchylus
.. _monads: https://en.wikipedia.org/wiki/Monad_(functional_programming)#History
.. _calchylus3.readthedocs.io: http://calchylus3.readthedocs.io/
