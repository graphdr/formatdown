Unit tests with tinytest 

https://github.com/markvanderloo/tinytest

We use the tinytest R package for unit tests. In tinytest, tests 
are scripts interspersed with statements that perform checks. 

Package testing is set up as follows: 

1. Test scripts are located in formatdown/inst/tinytest/.   
   Filenames start with `test_`, for example, `test_format_power.R`.  
   Usually one file per function.  
  
2. The formatdown/tests/ directory contains an R file named tinytest.R that 
   contains the following script:  

     if (requireNamespace("tinytest", quietly = TRUE)){
       tinytest::test_package("formatdown" )
     }

3. In the DESCRIPTION file, tinytest is added to Suggests:. 
  
formatdown users can run the tinytest tests themselves by 
installing tinytest and running: 
 
    tinytest::test_package("formatdown")

For detailed information including test functions, see 

    vignette("using_tinytest", package = "tinytest")
