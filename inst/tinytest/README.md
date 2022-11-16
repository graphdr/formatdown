
Unit tests    

Richard A. Layton    
2022-11-16    


In writing defensive programming unit tests for formatdown, I use the packages:

- checkmate, to write the runtime assertions to check function arguments. These assertions are in the function files in the `formatdown/R/` directory.   

- tinytest, to write the unit tests that check function arguments before the function executes. The test files are in the directory `formatdown/inst/tinytest/`. 




