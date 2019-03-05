
Initialization macros
=====================

After importing ``calchylus3`` module with ``(require [calchylus3.lambdas [*]])``,
the system itself is initialized by one of the four start up macros:

- ``with-macros`` that loads macro shorthands
- ``without-macros`` that loads only basic library

There are two parameters you must use on initialization macros to specify the
syntax of the Lambda expressions:

1. lambda function identifier (more formally called the binding operator)
2. optional argument and body separator (delimitter) that is used only on
   printing lambda form

Identifier is usually the Greek lambda letter ``λ``, but it can be any character
or string you desire. One can find letters like ``\``, ``^``, ``|lambda|``, and
``L`` used on different Lambda calculus implementations.

In Hy, even unicode letters are supported, which is sometimes typographically
satisfying for printing purposes. Writing unicode letters from the keyboard
however, can be tricky. Most probably, one needs to rely on extensive copy and
paste, if an unicode identifier and separator is used.

For a demonstration, let us load the basic set from the ``calchylus3``
module:

.. code-block:: hylang

	(without-macros λ)

There will be an output after the successful initialization, which indicates the
last created lambda function, something like:

.. code-block:: text

	<function <lambda> at 0x000001790B7208C8>

Now we can start evaluating Lambda expressions with the given identifiers:

.. code-block:: hylang

	((λ x (λ y (y x))) 'first 'second)

|Output:|

.. code-block:: hylang

	(second first)

Example from notebook...

.. |Output:| replace:: [output]

.. _macro shorthands: http://calchylus3.readthedocs.io/en/latest/macros.html
.. _alpha conversion: http://calchylus3.readthedocs.io/en/latest/evaluation.html

.. |lambda| unicode:: U+1D706 .. mathematical lambda sign
