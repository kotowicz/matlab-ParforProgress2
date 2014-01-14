## A) ABOUT

This is version 0.2.2 of ParforProgress2, a simple parfor progress monitor for matlab. See also http://www.mathworks.com/matlabcentral/fileexchange/35609-matlab-parforprogress2.

This progress monitor comes with a nice wrapper `ParforProgressStarter2.m` which will take care of adding the classes to the java class path, depending on whether matlabpool / parpool is enabled or not.

## B) SETUP

* clone this directory 
* add directory to matlab path

## C) HOW TO USE (no globals)

see `ParforProgressStressTest2.m` or `ParforProgressStarter2.m`


## D) HOW TO USE (with globals)

### Matlab 2012b and later:
- create `javaclasspath.txt` file in your preference directory.
- add path to `ParforProgressStarter2` to this file.

On Linux this translates to:
```
$ cd .matlab/R2013a
$ echo "/path/to/matlab-ParforProgress2" > javaclasspath.txt
```

Next, startup Matlab and call `ParforProgressStarter2`, but do not run `javaddpath`:

```
 >> run_javaaddpath = 0;
 >> ParforProgressStressTest2(10000, run_javaaddpath)
```


### Matlab 2012a and earlier:

Unfortunately Matlab 2012a and earlier versions of Matlab do not support customized
`javaclasspath.txt` files, instead, you need to edit the `classpath.txt` file that is
part of the Matlab installation. You might need administrator / superuser privileges to 
edit this file. Here's how you can locate it:

```
>> which classpath.txt -all
/share/pkgs/MATLAB/R2012a/toolbox/local/classpath.txt
>> edit classpath.txt 
```


See http://www.mathworks.com/help/matlab/matlab_external/bringing-java-classes-and-methods-into-matlab-workspace.html for further information regarding `javaclasspath`.


