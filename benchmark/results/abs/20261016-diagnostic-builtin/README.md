# Diagnostic run: compiler built-in bypass

This run used GCC default built-ins. Calls to abs with an unused return were eliminated, so its Fulminate results are unsuitable for evaluation. teSpec results are diagnostic only here. The active 20261016-evaluation reruns all tools with a compiler wrapper disabling built-ins. Original embedded artifact paths were preserved; this diagnostic directory was renamed after measurement.
