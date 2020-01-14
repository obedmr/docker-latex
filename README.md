docker-latex
============
A Docker container for compiling LaTeX Projects

How to use it?
--------------

1. Pull it from DockerHub
```
	docker pull obedmr/latex
```

2. Compile it ... !
```
	cd /path/to/your/latex/project
	# Create the output directory
	mkdir aux/
	docker run --rm -v `pwd`:/mnt obedmr/latex tex <tex_command> <main.tex>
```

3. That's all, you will have your compiled content inside the output dir ``aux/``


**Important Notes**
- If you want to see all available TeX commands, run:
```
	 docker run -v `pwd`:/mnt obedmr/latex tex list-utils
```
- Example command for compiling my main.tex file
```
	 docker run -v `pwd`:/mnt obedmr/latex tex pdflatex main.tex
```
