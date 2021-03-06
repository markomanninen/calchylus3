
Quick start
===========

For people willing to get hands quickly on coding:

**Install**

.. code-block:: bash

	$ pip install calchylus3

**Open Hy**

.. code-block:: bash

	$ hy

**Import lambda library**

.. code-block:: hylang

	(require [calchylus3.lambdas [*]])

**Initialize lambda macros**

.. code-block:: hylang

	(with-macros L)

**Lambda dance**

.. code-block:: hylang

	((L x y [x [x y]]) 'a 'b) ; output: (a (a b))

.. code-block:: hylang

	(FIBONACCI SEVEN 'x 'y) ; output: (x (x (x (x (x (x (x (x (x (x (x (x (x y)))))))))))))


Explanation
-----------

``calchylus3`` module works in Windows, Linux, and MacOS operating systems.
3.7 or greater is required. The whole great Python ecosystem
can be installed from `Anaconda`_.

Install Hy language interpreter and ``calchylus3`` module by using ``pip``
Python package management tool:

.. code-block:: bash

	$ pip install calchylus3

Open Hy, since ``calchylus3`` is mostly written as Hy macros:

.. code-block:: bash

	$ hy

Import Lambda calculus macros:

.. code-block:: hylang

	(require [calchylus.lambdas [*]])

Define Lambda function indicator letter ``L`` and Lambda argument-body
separator character ``,`` with one of the `initializer macros`_:

.. code-block:: hylang

	(with-macros L)

By ``with-macros`` we want to say that arguments should
be internally renamed to prevent argument name collision and that we want to
load custom macros representing Lambda forms.

Now, we are ready to evaluate Lambda expressions. Here we apply
`Church numeral`_  five to the two values, ``a`` and ``b``:

.. code-block:: hylang

	((L x y [x [x [x [x [x y]]]]]) 'a 'b)

|Output:|

.. code-block:: text

	[a [a [a [a [a b]]]]]

Without going deeper into this yet, we can see that all ``x`` got replaced by
``a`` and all ``y`` got replaced by ``b``.

Predefined macros are available as `shorthands`_ for the most common Lambda forms.
For example, calculating the seventh Fibonacci number can be done by using the
Church numeral ``SEVEN`` and the ``FIBONACCI`` shorthands:

.. code-block:: hylang

	(FIBONACCI SEVEN 'x 'y)

|Output:|

.. code-block:: text

	[x [x [x [x [x [x [x [x [x [x [x [x [x y]]]]]]]]]]]]]

That is the Church numeral 13, the seventh `Fibonacci number`_.

In ``calchylus3`` these custom macro `shorthands`_ representing Lambda forms serves
as a mathematical and logical foundation for a prototype programming language
that is based on purely untyped Lambda calculus.

.. |Output:| replace:: [output]

.. _Anaconda: https://www.anaconda.com/download/
.. _shorthands: http://calchylus3.readthedocs.io/en/latest/macros.html
.. _Church numeral: https://en.wikipedia.org/wiki/Church_encoding
.. _Fibonacci number: https://en.wikipedia.org/wiki/Fibonacci_number
.. _initializer macros: http://calchylus3.readthedocs.io/en/latest/inits.html
